<h1>Azure ContainerApps</h1>

<h2>Description</h2>

This project is a template to deploy a ContainerApp in Azure (More info at https://learn.microsoft.com/en-us/azure/container-apps/overview). It uses AzureDevops for the CI/CD pipeline, and Terraform to create the resources in Azure. 

It creates a container App and then set a new revision (labeled 'production'). If you redeploy, it creates a new revision labeled 'staging'. depedning on the environment you are deploying to, it swaps the labels automatically (for DEV envs), or waits for manual validation and approval to do it (for PROD envs)


<h2>Pre-Requisites</h2>

The destination resource group must be already created, and also the service princpal to deploy using ADO. It requieres a /23 subnet for the Kubernetes (behind the ContainerApp layer) and another subnet for the PostgreSQL resource. 


<h2>Notes</h2>
    
You can run the Terraform script locally, or if you use ADO, you have to create a storage account somewhere in Azure and set the parameters in the Library section in Pipelines.

