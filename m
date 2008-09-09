From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: [RFC 3/5] pci wakeup handler
Date: Tue, 9 Sep 2008 11:33:57 +0800
Message-ID: <76780B19A496DC4B80439008DAD7076C01AC7F326A__19794.2755221904$1220931490$gmane$org@PDSMSX501.ccr.corp.intel.com>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
	<20080908092305.438330804@sli10-desk.sh.intel.com>
	<200809081956.42663.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200809081956.42663.david-b@pacbell.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



>-----Original Message-----
>From: David Brownell [mailto:david-b@pacbell.net]
>Sent: Tuesday, September 09, 2008 10:57 AM
>To: Li, Shaohua
>Cc: linux-pm@lists.linux-foundation.org; linux-acpi@vger.kernel.org;
>stern@rowland.harvard.edu
>Subject: Re: [RFC 3/5] pci wakeup handler
>
>On Monday 08 September 2008, shaohua.li@intel.com wrote:
>> --- linux.orig/drivers/pci/pci-driver.c       2008-09-08
>13:55:56.000000000 +0800
>> +++ linux/drivers/pci/pci-driver.c    2008-09-08 14:24:42.000000000 +0800
>> @@ -472,12 +472,57 @@ static int pci_pm_resume_noirq(struct de
>>       return error;
>>  }
>>
>> +/*
>> + * Called when dev is suspected to invoke a wakeup event, return 0 if
>yes
>> + * */
>> +static int pci_pm_wakeup_event(struct device *dev)
>
>If wakeup notifications were bus-specific this would
>take "struct pci_dev *pdev" ... and we're missing a
>key part of this stuff, namely the code to sort out
>which devices get this call.
This device is suspected to invoke a wakeup event, might not be true. I suppose other bus requires the same mechanism, so should be a 'struct device'

>> +     struct pci_driver *drv = pdev->driver;
>> +     u16 reg16;
>> +     int spurious = 0;
>> +     int ret = -ENODEV;
>> +
>> +     if (pme_pos == 0) {
>> +             /*
>> +              * Some USB devices haven't PME, but have specific
>registers to
>> +              * control wakeup
>
>The PCI PM spec has words some like:  "Some PCI devices support legacy
>wakeup mechanisms instead of supporting PCI PM capabilities."  Today
>the best example of that is Intel's UHCI controllers, but it's not
>restricted to USB at all.
>
>I suspect that this particular path won't often need to handle anything
>other than those Intel controllers, however.  And so I hope that they
>never share GPEs.  ;)
This is one of the reason calling drv->wakeup_event().

>Another rather important case is bridges.  I observe that with ACPI
>the way PME# is handled for add-in cards _seems_ to be that the bridge
>for that PCI bus segment gets a GPE (presumably matching the PME#
>signal for that bus segment, and maybe for its subsidiaries).  That
>suggests the bridge will need to scan its children to find out which
>one(s) issued PME#.  You didn't include such code here, where that
>notification will be received...
In GPE case, it appears BIOS will detect the exact wakeup device.

In native PME case, if a device is a pcie device, npme will detect the exact device too. If the device is a legacy device, then npme driver will check devices under bridges, please see the npme_pme_target().

We can directly scan children in pci_pm_wakeup_event() too, but GPE case doesn't require it and actually is broken in GPE case as duplication will be added.

I thought this covers all cases in IA platform, right?
>
>> +     /* I see spurious GPE here, just ignore it for now */
>
>Comments about GPEs shouldn't be included here; they're ACPI-specific.
>This is PCI-generic code!
A typo, it should be PME. And actually I found this in npme case instead of ACPI.

>> +     if (!(reg16 & PCI_PM_CTRL_PME_ENABLE))
>> +             spurious = 1;
>> +     reg16 &= ~PCI_PM_CTRL_PME_ENABLE;
>> +     reg16 |= PCI_PM_CTRL_PME_STATUS;
>> +     pci_write_config_word(pdev, pme_pos + PCI_PM_CTRL, reg16);
>
>If this device didn't issue PME, then don't clear PME_ENABLE.
Ok, this is reasonable.


>> +     if (drv && drv->pm && drv->pm->base.wakeup_event) {
>> +             if (!ret) /* ignore return value in this case */
>> +                     drv->pm->base.wakeup_event(&pdev->dev);
>> +             else
>> +                     return drv->pm->base.wakeup_event(&pdev->dev);
>
>I'm also puzzled why you want the legacy PM case (UHCI etc)
>to work differently from the "normal" one.
>
>And style-wise I'd really prefer to see
>
>        return pdev->driver->wakeup(pdev);
>
>Or perhaps more generically -- since I still have yet to
>hear an argument why resume() shouldn't suffice to handle
>the wakeup event processing, at least for PCI -- just
>
>        if (pdev->driver->wakeup)
>                return pdev->driver->wakeup(pdev);
>        if (pdev->driver->resume)
>                return pdev->driver->resume(pdev);
>
>Although I don't know what the return value here should
>be interpreted to mean.  Would it be better to return
>void, and just log all "interesting"/error cases?
In my mind, .wakeup_event() just returns if the device invokes a wakeup event, ACPI or NPME will call corresponding .resume method. Suspected device might not invoke wakeup event as you said the bridge case.

Thanks,
Shaohua
