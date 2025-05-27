# README
## Scope
This is a Ruby on Rails 8 API-only application built for a WebOps task. It offers a full-featured backend for user authentication, post management with tagging, and nested commenting. The app is containerized with Docker, uses JWT for secure access.


# FEATURES 
  ## Authentication & Authorization
  
 - JWT-Based Authentication
  
 - Secure login/signup with email and password
  
 - All API routes require a valid JWT token
  
  User Model Fields
  
     name
    
     email
    
     password_digest
    
     image (optional)
  
  ## Post Management
  Post Model Fields
  
    title
    
    body
    
    user_id (author)
    
    tags (at least one required)
    
  
  ## Create, update, and delete (only your own posts).
  ## Add/update tags dynamically.
  ## Posts auto-deleted via background job (demo below).
  
  # Commenting
  ```bash
   -Users can comment on any post.
   -Only comment authors can update or delete their comments.
 ```


## Technology Stack
```bash
  -Backend: Ruby on Rails 8 (API mode)
  -Database: PostgreSQL
  -Authentication: JWT
  -Background Jobs: Sidekiq
  -Containerization: Docker & Docker Compose
```

## Setup Instructions
```bash
git clone https://github.com/abdelrahmanyasser778/Taskk.git

cd Taskk

run `docker-compose up`
```


