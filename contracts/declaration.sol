// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CargoDeclaration {
    
    struct Declaration {
        string id;                      // (R) Converted to string
        string declaration_date;         // (R)
        string request_no;               // (R)
        string declaration_no;           // (R)
        uint256 net_weight;              // (R)
        uint256 gross_weight;            // (R)
        string measurements;             // (R)
        uint256 nmbr_of_packages;        // (R)
        string cargo_type;               // (R)
        string declaration_type;         // (R)
        string cargo_channel;            // (R)
        string transaction_type;         // (R)
        string trade_type;               // (R)
        string regime_type;              // (R)
        string iam_user_id;              // (R) Converted to string
        string is_verified;              // (R) Default state is "underprocess"
        string comments;                 // (O)
        string updated_by_user;          // (O) Converted to string
    }

    struct Items {
        string id;                      // (R) Converted to string
        string goods_description;        // (R)
        string static_quantity_unit;     // (R)
        string supp_quantity_unit;       // (R)
        uint256 unit_weight;             // (R)
        uint256 goods_value;             // (R)
        uint256 cif_value;               // (R)
        uint256 duty_fee;                // (R)
        string hs_code;                  // (R)
        string declaration_id;           // (O) Reference to Declaration, Converted to string
        string documents;                // (O)
    }
    
    Declaration[] public declarations;
    Items[] public items;

    function addDeclaration(
        string memory _id,
        string memory _declaration_date,
        string memory _request_no,
        string memory _declaration_no,
        uint256 _net_weight,
        uint256 _gross_weight,
        string memory _measurements,
        uint256 _nmbr_of_packages,
        string memory _cargo_type,
        string memory _declaration_type,
        string memory _cargo_channel,
        string memory _transaction_type,
        string memory _trade_type,
        string memory _regime_type,
        string memory _iam_user_id,      // Now a string
        string memory _comments,
        string memory _updated_by_user    // Now a string
    ) public {
        Declaration memory newDeclaration = Declaration({
            id: _id,
            declaration_date: _declaration_date,
            request_no: _request_no,
            declaration_no: _declaration_no,
            net_weight: _net_weight,
            gross_weight: _gross_weight,
            measurements: _measurements,
            nmbr_of_packages: _nmbr_of_packages,
            cargo_type: _cargo_type,
            declaration_type: _declaration_type,
            cargo_channel: _cargo_channel,
            transaction_type: _transaction_type,
            trade_type: _trade_type,
            regime_type: _regime_type,
            iam_user_id: _iam_user_id,   // Assigned as a string
            is_verified: "underprocess",  // Default state
            comments: _comments,
            updated_by_user: _updated_by_user   // Assigned as a string
        });

        declarations.push(newDeclaration);
    }

    function addItem(
        string memory _id,
        string memory _goods_description,
        string memory _static_quantity_unit,
        string memory _supp_quantity_unit,
        uint256 _unit_weight,
        uint256 _goods_value,
        uint256 _cif_value,
        uint256 _duty_fee,
        string memory _hs_code,
        string memory _declaration_id,   // Now a string
        string memory _documents
    ) public {
        Items memory newItem = Items({
            id: _id,
            goods_description: _goods_description,
            static_quantity_unit: _static_quantity_unit,
            supp_quantity_unit: _supp_quantity_unit,
            unit_weight: _unit_weight,
            goods_value: _goods_value,
            cif_value: _cif_value,
            duty_fee: _duty_fee,
            hs_code: _hs_code,
            declaration_id: _declaration_id, // Assigned as a string
            documents: _documents
        });

        items.push(newItem);
    }

    function updateIsVerified(string memory _declarationId, string memory _newStatus) public {
        require(
            keccak256(abi.encodePacked(_newStatus)) == keccak256(abi.encodePacked("underprocess")) ||
            keccak256(abi.encodePacked(_newStatus)) == keccak256(abi.encodePacked("approved")) ||
            keccak256(abi.encodePacked(_newStatus)) == keccak256(abi.encodePacked("rejected")) ||
            keccak256(abi.encodePacked(_newStatus)) == keccak256(abi.encodePacked("on-hold")),
            "Invalid state for is_verified"
        );

        bool found = false;
        for (uint i = 0; i < declarations.length; i++) {
            if (keccak256(abi.encodePacked(declarations[i].id)) == keccak256(abi.encodePacked(_declarationId))) {
                declarations[i].is_verified = _newStatus;
                found = true;
                break;
            }
        }

        require(found, "Declaration not found");
    }
}
