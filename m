From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: libata-acpi.c ata_acpi_register_power_resource copy and paste
 mistake ?
Date: Fri, 01 Mar 2013 09:59:41 +0800
Message-ID: <51300B8D.8030600@intel.com>
References: <928867757.20130228174510@eikelenboom.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <928867757.20130228174510@eikelenboom.it>
Sender: linux-ide-owner@vger.kernel.org
To: Sander Eikelenboom <linux@eikelenboom.it>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Linux-pm mailing list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

+Rafael

commit bc9b6407bd6df3ab7189e5622816bbc11ae9d2d8
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Thu Jan 17 14:11:05 2013 +0100

    ACPI / PM: Rework the handling of devices depending on power resources

-Aaron

On 03/01/2013 12:45 AM, Sander Eikelenboom wrote:
> Hi Jeff,
> 
> During the last merge of ahci code (d9978ec5680059d727b39d6c706777c6973587f2), i saw this coming by:
> 
> 
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -1024,30 +1024,20 @@ static void ata_acpi_register_power_resource(struct ata_device *dev)
>  {
>         struct scsi_device *sdev = dev->sdev;
>         acpi_handle handle;
> -       struct device *device;
>  
>         handle = ata_dev_acpi_handle(dev);
> -       if (!handle)
> -               return;
> -
> -       device = &sdev->sdev_gendev;
> -
> -       acpi_power_resource_register_device(device, handle);
> +       if (handle)
> +               acpi_dev_pm_remove_dependent(handle, &sdev->sdev_gendev);
>  }
> 
> shouldn't:
> 
> acpi_dev_pm_remove_dependent(handle, &sdev->sdev_gendev);
> 
> be
> 
> acpi_dev_pm_add_dependent(handle, &sdev->sdev_gendev);
> 
> in the ata_acpi_register_power_resource function ?
> 
> (seems like a copy and paste mistake from the unregister function)
> 
> --
> Sander
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

