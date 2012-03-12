From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: mmc: sdhci-pci: why no .shutdown() implemented
Date: Mon, 12 Mar 2012 15:25:25 +0200
Message-ID: <4F5DF945.3010204@intel.com>
References: <810586B7581CC8469141DADEBC3719120AECF8@BGSMSX102.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <810586B7581CC8469141DADEBC3719120AECF8@BGSMSX102.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Mansoor, Illyas" <illyas.mansoor@intel.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12/03/12 10:15, Mansoor, Illyas wrote:
> Hi All,
> 
> I'm not sure if this is the right mailing list to discuss this question, but
> anyways I'll ask:
> 
> On our platform we implemented a BUG in pci_set_power_state callback when the
> shutdown
> Is in progress, and we caught sdci-pci doing pci_set_power_state(D0) when
> shutdown was
> Already in progress.
> 
> My question, why doesn't sdhci-pci.c implement a .shutdown() callback and close
> the device
> After doing sys_sync()?
> 
> Is there some reason behind it not doing a graceful shutdown.

In general, the kernel does not know how to do a graceful shutdown.  There
may be any number of housekeeping activities that userspace wishes to do
before shutting down.

If file systems are not getting sync'd that is a userspace problem, not a
kernel problem.

> 
> I think it could cause corruption, since there is no guarantee when the system
> will power-off/reboot/halt
> 
> I just implemented a patch to fix this, if it's a good fix I'll submit.
> 
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index f5fe05c..e0818c9 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -23,6 +23,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/async.h>
> +#include <linux/syscalls.h>
> 
>  #include <asm/scatterlist.h>
>  #include <asm/io.h>
> @@ -1342,6 +1343,34 @@ err:
>         return ret;
>  }
> 
> +static void sdhci_pci_shutdown(struct pci_dev *pdev)
> +{
> +       int i;
> +       struct sdhci_pci_chip *chip;
> +
> +       printk(KERN_INFO "%s: Syncing filesystems ... ", __func__);
> +       sys_sync();
> +       printk("done.\n");
> +
> +       pm_runtime_get_sync(&pdev->dev);
> +
> +       chip = pci_get_drvdata(pdev);
> +
> +       if (chip) {
> +               for (i = 0;i < chip->num_slots; i++)
> +                       sdhci_pci_remove_slot(chip->slots[i]);
> +
> +               pci_set_drvdata(pdev, NULL);
> +               kfree(chip);
> +       }
> +
> +       pci_disable_device(pdev);
> +
> +       pm_runtime_put_noidle(&pdev->dev);
> +       pm_runtime_forbid(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);
> +}
> +
>  static void __devexit sdhci_pci_remove(struct pci_dev *pdev)
>  {
>         int i;
> @@ -1473,6 +1502,7 @@ static struct pci_driver sdhci_driver = {
>         .id_table =     pci_ids,
>         .probe =        sdhci_pci_probe,
>         .remove =       __devexit_p(sdhci_pci_remove),
> +       .shutdown =     sdhci_pci_shutdown,
> 
> 
> -Illyas

