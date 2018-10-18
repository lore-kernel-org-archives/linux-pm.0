From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PCI / PM: Allow runtime PM without callback functions
Date: Thu, 18 Oct 2018 17:08:46 +0200
Message-ID: <CAJZ5v0jyS+E_tzpoRs1uvet_ydZphqfLQ0012Q0RroYk+C67Wg@mail.gmail.com>
References: <20181018123038.21386-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181018123038.21386-1-jarkko.nikula@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Stable <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 18, 2018 at 2:30 PM Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> Allow PCI core to do runtime PM to devices without needing to use dummy
> runtime PM callback functions if there is no need to do anything device
> specific beyond PCI device power state management.
>
> Implement this by letting core to change device power state during
> runtime PM transitions even if no callback functions are defined.
>
> Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> This is related to my i2c-i801.c fix thread back in June which I completely
> forgot till now: https://lkml.org/lkml/2018/6/27/642
> Discussion back then was that it should be handled in the PCI PM instead
> of having dummy functions in the drivers. I wanted to respin with a
> patch.

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci-driver.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index bef17c3fca67..6185b878ede1 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1239,7 +1239,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
>         struct pci_dev *pci_dev = to_pci_dev(dev);
>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>         pci_power_t prev = pci_dev->current_state;
> -       int error;
> +       int error = 0;
>
>         /*
>          * If pci_dev->driver is not set (unbound), we leave the device in D0,
> @@ -1251,11 +1251,9 @@ static int pci_pm_runtime_suspend(struct device *dev)
>                 return 0;
>         }
>
> -       if (!pm || !pm->runtime_suspend)
> -               return -ENOSYS;
> -
>         pci_dev->state_saved = false;
> -       error = pm->runtime_suspend(dev);
> +       if (pm && pm->runtime_suspend)
> +               error = pm->runtime_suspend(dev);
>         if (error) {
>                 /*
>                  * -EBUSY and -EAGAIN is used to request the runtime PM core
> @@ -1292,7 +1290,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
>
>  static int pci_pm_runtime_resume(struct device *dev)
>  {
> -       int rc;
> +       int rc = 0;
>         struct pci_dev *pci_dev = to_pci_dev(dev);
>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>
> @@ -1306,14 +1304,12 @@ static int pci_pm_runtime_resume(struct device *dev)
>         if (!pci_dev->driver)
>                 return 0;
>
> -       if (!pm || !pm->runtime_resume)
> -               return -ENOSYS;
> -
>         pci_fixup_device(pci_fixup_resume_early, pci_dev);
>         pci_enable_wake(pci_dev, PCI_D0, false);
>         pci_fixup_device(pci_fixup_resume, pci_dev);
>
> -       rc = pm->runtime_resume(dev);
> +       if (pm && pm->runtime_resume)
> +               rc = pm->runtime_resume(dev);
>
>         pci_dev->runtime_d3cold = false;
>
> --
> 2.19.1
>
