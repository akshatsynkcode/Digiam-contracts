pragma solidity ^0.8.0;

contract ServiceContract {
    // Struct to hold service details with all fields as strings
    struct Service {
        string id;                            // Unique ID for the service (as string)
        string service_uuid;                   // UUID for the service
        string service_name;                   // Name of the service
        string service_url;                    // URL related to the service
        string service_image;                  // Image URL for the service
        string service_details;                // Detailed description of the service
        string service_type;                   // Type of the service
        string service_urgency;                // Urgency level (as string, e.g., "1", "2", etc.)
        string service_category;               // Category of the service
        string allow_all_users;                // Whether all users are allowed ("true" or "false")
        string is_company_required;            // Whether a company is required ("true" or "false")
        string service_charge;                 // Charge for the service (as string)
        string service_limitation;             // Limitations related to the service
        string service_hierarchy;              // Hierarchy (e.g., main service, sub-service)
        string service_interconnection;        // Interconnection with other services
        string bundle;                         // Bundle (if applicable)
        string delivery_time;                  // Delivery time in hours (as string)
        string completion_time;                // Completion time in hours (as string)
        string service_fees;                   // Additional fees for the service (as string)
        string service_delivery_channel;       // Delivery method (e.g., email, in-person)
        string terms_and_conditions;           // Terms and conditions
        string service_description;            // Short description of the service
        string title;                          // Title of the service
        string customer_description;           // Customer's description of the service
        string service_image_cust;             // Image URL for customer use
    }

    // Mapping to store services by their unique ID
    mapping(string => Service) public services;
    
    // Event for adding a new service
    event ServiceAdded(string id, string service_name, string service_uuid);

    // Function to add a new service
    function addService(
        string memory _id,
        string memory _service_uuid,
        string memory _service_name,
        string memory _service_url,
        string memory _service_image,
        string memory _service_details,
        string memory _service_type,
        string memory _service_urgency,
        string memory _service_category,
        string memory _allow_all_users,
        string memory _is_company_required,
        string memory _service_charge,
        string memory _service_limitation,
        string memory _service_hierarchy,
        string memory _service_interconnection,
        string memory _bundle,
        string memory _delivery_time,
        string memory _completion_time,
        string memory _service_fees,
        string memory _service_delivery_channel,
        string memory _terms_and_conditions,
        string memory _service_description,
        string memory _title,
        string memory _customer_description,
        string memory _service_image_cust
    ) public {
        // Create a new service with all fields as strings
        services[_id] = Service({
            id: _id,
            service_uuid: _service_uuid,
            service_name: _service_name,
            service_url: _service_url,
            service_image: _service_image,
            service_details: _service_details,
            service_type: _service_type,
            service_urgency: _service_urgency,
            service_category: _service_category,
            allow_all_users: _allow_all_users,
            is_company_required: _is_company_required,
            service_charge: _service_charge,
            service_limitation: _service_limitation,
            service_hierarchy: _service_hierarchy,
            service_interconnection: _service_interconnection,
            bundle: _bundle,
            delivery_time: _delivery_time,
            completion_time: _completion_time,
            service_fees: _service_fees,
            service_delivery_channel: _service_delivery_channel,
            terms_and_conditions: _terms_and_conditions,
            service_description: _service_description,
            title: _title,
            customer_description: _customer_description,
            service_image_cust: _service_image_cust
        });
        
        // Emit the event
        emit ServiceAdded(_id, _service_name, _service_uuid);
    }

    // Function to get a service by ID
    function getService(string memory _id) public view returns (Service memory) {
        return services[_id];
    }
}
