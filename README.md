# Deklarative Datenbankenentwicklung

# Voraussetzungen

Vor den Start des Trainings sind folgende Voraussetzungen zu erfüllen: Teilnehmer sollten bereits über Grundkenntnisse im Umgang mit Git und mit Terraform verfügen, vertiefte Kenntnisse in SQL werden ebenso voraus gesetzt.

Teilnehmer sollten Zugang zu einer Azure DevOps Organisation haben und auf Azure DevOps ein Personal Access Token erzeugt haben.

Softwareseitig sollte auf dem Rechner installiert sein:

- Azure Data Studio
- Git
- Terraform
- Azure CLI
- Wahlweise PowerShell, Bash, Zsh oder ein alternative Unix Terminal
- ssh

Vor Begin des Workshops sollten Teilnehmer mittels Terraform erfolgreich eine Datenbank auf Azure aufgesetzt haben. Ein passendes Terraform Projekt findet sich im Git Repository.

Zur Einrichtung der Datenbank müssen folgende Schritte durchgeführt werden:

1. Repository clonen

```powershell
git clone https://github.com/fingineering/declarativedatabasedevelopment.git
```

1. Terraform.tfvars Datei aus Beispel erzeugen und ausfüllen

```powershell
cp terraform.tfvars.example terraform.tfvars
```

1. Terraform initialisieren und Ausführen

```powershell
terraform init
terraform plan
terraform apply
```

Beispiel Code und Infrastruktur Script finden sich im folgenden Repository:

[Deklarative Datenbankenentwicklung Git Repository](https://github.com/fingineering/declarativedatabasedevelopment)

# Verwandte Ressourcen

**Terraform-101** - [Terraform 101 Repository](https://github.com/fingineering/terraform-101)


