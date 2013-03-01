From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] libata-acpi.c: fix copy and paste mistake in ata_acpi_register_power_resource
Date: Fri, 01 Mar 2013 17:34:32 +0100
Message-ID: <2944715.8ytIW0aehH@vostro.rjw.lan>
References: <2508494.4AbRYXD1du@vostro.rjw.lan> <1362136602-30327-1-git-send-email-linux@eikelenboom.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <1362136602-30327-1-git-send-email-linux@eikelenboom.it>
Sender: linux-ide-owner@vger.kernel.org
To: Sander Eikelenboom <linux@eikelenboom.it>
Cc: aaron.lu@intel.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, March 01, 2013 12:16:42 PM Sander Eikelenboom wrote:
> Fix a copy and paste mistake introduced in:
> 
> commit bc9b6407bd6df3ab7189e5622816bbc11ae9d2d8
> "ACPI / PM: Rework the handling of devices depending on power resources"
> 
> Signed-off-by: Sander Eikelenboom <linux@eikelenboom.it>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/ata/libata-acpi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index 0ea1018..cb3eab6d 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -1027,7 +1027,7 @@ static void ata_acpi_register_power_resource(struct ata_device *dev)
>  
>  	handle = ata_dev_acpi_handle(dev);
>  	if (handle)
> -		acpi_dev_pm_remove_dependent(handle, &sdev->sdev_gendev);
> +		acpi_dev_pm_add_dependent(handle, &sdev->sdev_gendev);
>  }
>  
>  static void ata_acpi_unregister_power_resource(struct ata_device *dev)
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
