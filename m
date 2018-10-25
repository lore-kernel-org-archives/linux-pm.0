From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] PCI / PM: Allow runtime PM without callback functions
Date: Thu, 25 Oct 2018 15:57:57 +0200
Message-ID: <CAJZ5v0gna-KvmezNGmCJZTwMrSBHyxbXqPZi12aKjEkxkr=YPQ@mail.gmail.com>
References: <20181023114552.22958-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181023114552.22958-1-jarkko.nikula@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Stable <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 23, 2018 at 1:46 PM Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> Commit a9c8088c7988 ("i2c: i801: Don't restore config registers on
> runtime PM") nullified the runtime PM suspend/resume callback pointers
> while keeping the runtime PM enabled.
>
> This causes that SMBus PCI device stays in D0 power state and sysfs
> /sys/bus/pci/devices/[SMBus PCI ID]/power/runtime_status shows "error"
> when the runtime PM framework attempts to autosuspend the device. This
> is due PCI bus runtime PM which checks for driver runtime PM callbacks
> and returns with -ENOSYS if they are not set.
>
> Since i2c-i801.c don't need to do anything device specific beyond PCI
> device power state management Jean Delvare proposed if this can be fixed
> in the PCI subsystem core level rather than adding dummy runtime PM
> callback functions in the PCI drivers.
>
> Change the pci_pm_runtime_suspend()/pci_pm_runtime_resume() semantics so
> that they allow change the PCI device power state during runtime PM
> transitions even if no runtime PM callback functions are defined.
>
> This change fixes the runtime PM regression on i2c-i801.c.
>
> It is not obvious why the code had hard requirements for the runtime PM
> callbacks. Test has been here since the code was introduced by the
> commit 6cbf82148ff2 ("PCI PM: Run-time callbacks for PCI bus type").
>
> On the other hand similar change than this was done to generic runtime
> PM callbacks way back in the commit 05aa55dddb9e ("PM / Runtime: Lenient
> generic runtime pm callbacks").
>
> Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: <stable@vger.kernel.org> # 4.18+
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> I Cc'ed stable since this fixes the regression on i2c-i801.c. But we
> probably want to get some test coverage first before applying into
> stable. Queueing for v4.20 sounds reasonable to me.
> v2:
> Previous version had a potential NULL dereference in WARN_ONCE() statement
> noted by Jean Delvare. Now covered by pm && pm->runtime_suspend test.
> Also handling of error code from pm->runtime_suspend() moved under the
> same code block where callback is called.
> v1:
> This is related to my i2c-i801.c fix thread back in June which I completely
> forgot till now: https://lkml.org/lkml/2018/6/27/642
> Discussion back then was that it should be handled in the PCI PM instead
> of having dummy functions in the drivers. I wanted to respin with a patch.
> ---
>  drivers/pci/pci-driver.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index bef17c3fca67..33f3f475e5c6 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1251,30 +1251,29 @@ static int pci_pm_runtime_suspend(struct device *dev)
>                 return 0;
>         }
>
> -       if (!pm || !pm->runtime_suspend)
> -               return -ENOSYS;
> -
>         pci_dev->state_saved = false;
> -       error = pm->runtime_suspend(dev);
> -       if (error) {
> +       if (pm && pm->runtime_suspend) {
> +               error = pm->runtime_suspend(dev);
>                 /*
>                  * -EBUSY and -EAGAIN is used to request the runtime PM core
>                  * to schedule a new suspend, so log the event only with debug
>                  * log level.
>                  */
> -               if (error == -EBUSY || error == -EAGAIN)
> +               if (error == -EBUSY || error == -EAGAIN) {
>                         dev_dbg(dev, "can't suspend now (%pf returned %d)\n",
>                                 pm->runtime_suspend, error);
> -               else
> +                       return error;
> +               } else if (error) {
>                         dev_err(dev, "can't suspend (%pf returned %d)\n",
>                                 pm->runtime_suspend, error);
> -
> -               return error;
> +                       return error;
> +               }
>         }
>
>         pci_fixup_device(pci_fixup_suspend, pci_dev);
>
> -       if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
> +       if (pm && pm->runtime_suspend
> +           && !pci_dev->state_saved && pci_dev->current_state != PCI_D0
>             && pci_dev->current_state != PCI_UNKNOWN) {
>                 WARN_ONCE(pci_dev->current_state != prev,
>                         "PCI PM: State of device not saved by %pF\n",
> @@ -1292,7 +1291,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
>
>  static int pci_pm_runtime_resume(struct device *dev)
>  {
> -       int rc;
> +       int rc = 0;
>         struct pci_dev *pci_dev = to_pci_dev(dev);
>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>
> @@ -1306,14 +1305,12 @@ static int pci_pm_runtime_resume(struct device *dev)
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
