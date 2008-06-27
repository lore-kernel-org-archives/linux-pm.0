From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 6/8] PCI ACPI: Rework PCI handling of wake-up
Date: Fri, 27 Jun 2008 10:08:18 +0800
Message-ID: <1214532498.26388.2.camel__3608.42000595785$1214532239$gmane$org@sli10-desk.sh.intel.com>
References: <200806270022.24496.rjw@sisk.pl> <200806270028.29396.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806270028.29396.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, "Zhao,
	Yakui" <yakui.zhao@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2008-06-27 at 06:28 +0800, Rafael J. Wysocki wrote:
> +
> +/**
>   * pci_enable_wake - enable PCI device as wakeup event source
>   * @dev: PCI device affected
>   * @state: PCI state from which device will issue wakeup events
> @@ -1046,66 +1108,84 @@ int pci_set_pcie_reset_state(struct pci_
>   * called automatically by this routine.
>   *
>   * Devices with legacy power management (no standard PCI PM
> capabilities)
> - * always require such platform hooks.  Depending on the platform,
> devices
> - * supporting the standard PCI PME# signal may require such platform
> hooks;
> - * they always update bits in config space to allow PME# generation.
> - *
> - * -EIO is returned if the device can't ever be a wakeup event
> source.
> - * -EINVAL is returned if the device can't generate wakeup events
> from
> - * the specified PCI state.  Returns zero if the operation is
> successful.
> + * always require such platform hooks.
> + *
> + * RETURN VALUE:
> + * 0 is returned on success
> + * -EINVAL is returned if device is not supposed to wake up the
> system
> + * Error code depending on the platform is returned if both the
> platform and
> + * the native mechanism fail to enable the generation of wake-up
> events
>   */
>  int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int
> enable)
>  {
>         int pm;
> -       int status;
> -       u16 value;
> +       int error = 0;
> 
> -       /* Note that drivers should verify
> device_may_wakeup(&dev->dev)
> -        * before calling this function.  Platform code should report
> -        * errors when drivers try to enable wakeup on devices that
> -        * can't issue wakeups, or on which wakeups were disabled by
> -        * userspace updating the /sys/devices.../power/wakeup file.
> -        */
> +       if (!device_may_wakeup(&dev->dev))
> +               return -EINVAL;
> 
> -       status = call_platform_enable_wakeup(&dev->dev, enable);
> +       if (enable && platform_pci_can_wakeup(dev)) {
> +               error = platform_pci_sleep_wake(dev, true);
> +               if (!error)
> +                       /*
> +                        * The platform claims to have handled the
> device and
> +                        * we have to trust it to avoid double wake-up
> events.
> +                        */
> +                       return 0;
> +       }
> 
> -       /* find PCI PM capability in list */
>         pm = pci_find_capability(dev, PCI_CAP_ID_PM);
> -
> -       /* If device doesn't support PM Capabilities, but caller wants
> to
> -        * disable wake events, it's a NOP.  Otherwise fail unless the
> -        * platform hooks handled this legacy device already.
> -        */
> -       if (!pm)
> -               return enable ? status : 0;
> -
> -       /* Check device's ability to generate PME# */
> -       pci_read_config_word(dev,pm+PCI_PM_PMC,&value);
> -
> -       value &= PCI_PM_CAP_PME_MASK;
> -       value >>= ffs(PCI_PM_CAP_PME_MASK) - 1;   /* First bit of mask
> */
> -
> -       /* Check if it can generate PME# from requested state. */
> -       if (!value || !(value & (1 << state))) {
> -               /* if it can't, revert what the platform hook changed,
> -                * always reporting the base "EINVAL, can't PME#"
> error
> -                */
> +       if (!enable || pci_pme_capable(dev, pm, state)) {
> +               pci_pme_active(dev, pm, enable);
>                 if (enable)
> -                       call_platform_enable_wakeup(&dev->dev, 0);
> -               return enable ? -EINVAL : 0;
> +                       return 0;
>         }
> 
> -       pci_read_config_word(dev, pm + PCI_PM_CTRL, &value);
> +       if (!enable && platform_pci_can_wakeup(dev))
> +               error = platform_pci_sleep_wake(dev, false);
> 
> -       /* Clear PME_Status by writing 1 to it and enable PME# */
> -       value |= PCI_PM_CTRL_PME_STATUS | PCI_PM_CTRL_PME_ENABLE;
> +       return error;
> +}
> 
> -       if (!enable)
> -               value &= ~PCI_PM_CTRL_PME_ENABLE;
> +/**
> + * pci_pm_init - Initialize PM functions of given PCI device
> + * @dev: PCI device to handle.
> + */
> +void pci_pm_init(struct pci_dev *dev)
> +{
> +       int pm;
> +       u16 pmc;
> 
> -       pci_write_config_word(dev, pm + PCI_PM_CTRL, value);
> +       /* find PCI PM capability in list */
> +       pm = pci_find_capability(dev, PCI_CAP_ID_PM);
> +       if (!pm)
> +               return;
> +       /* Check device's ability to generate PME# */
> +       pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
> 
> -       return 0;
> +       if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
> +               dev_err(&dev->dev, "unsupported PM cap regs version (%
> u)\n",
> +                       pmc & PCI_PM_CAP_VER_MASK);
> +               return;
> +       }
> +
> +       if (pmc & PCI_PM_CAP_PME_MASK) {
> +               dev_printk(KERN_INFO, &dev->dev,
> +                       "PME# supported from%s%s%s%s%s\n",
> +                       (pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
> +                       (pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
> +                       (pmc & PCI_PM_CAP_PME_D2) ? " D2" : "",
> +                       (pmc & PCI_PM_CAP_PME_D3) ? " D3hot" : "",
> +                       (pmc & PCI_PM_CAP_PME_D3cold) ? " D3cold" :
> "");
> +               /*
> +                * Make device's PM flags reflect the wake-up
> capability, but
> +                * let the user space enable it to wake up the system
> as needed.
> +                */
> +               device_set_wakeup_capable(&dev->dev, true);
> +               device_set_wakeup_enable(&dev->dev, false);
> +               /* Disable the PME# generation functionality */
> +               pci_pme_active(dev, pm, false);
> +       }
>  }
It appears a lot of drivers will call device_init_wakeup(dev, 1)
regardless if userspace enable wakeup for the device. Will you fix the
drivers?

Thanks,
Shaohua
