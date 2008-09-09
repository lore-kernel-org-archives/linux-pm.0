From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: [RFC 5/5] ACPI GPE based wakeup event detection
Date: Tue, 9 Sep 2008 09:08:09 +0800
Message-ID: <76780B19A496DC4B80439008DAD7076C01AC7F3061__12759.6690938391$1220922678$gmane$org@PDSMSX501.ccr.corp.intel.com>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
	<20080908092305.658492314@sli10-desk.sh.intel.com>
	<200809082257.35009.rjw@sisk.pl>
	<1220922812.3989.8.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1220922812.3989.8.camel@yakui_zhao.sh.intel.com>
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
To: "Zhao, Yakui" <yakui.zhao@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

>> > +
>> >  /**
>> >   * acpi_bus_notify
>> >   * ---------------
>> > @@ -506,6 +519,8 @@ static void acpi_bus_notify(acpi_handle
>> >     int result = 0;
>> >     struct acpi_device *device = NULL;
>> >
>> > +   blocking_notifier_call_chain(&acpi_bus_notify_list,
>> > +                   type, (void *)handle);
>>
>> Hm, perhaps I'm too tired and I'm missing something obvious, but can you
>> tell me please why that has to be a notifier chain?  It looks like you
>add only
>> one notifier to it, so seemingly it could be replaced by a direct call to
>a
>> function like acpi_gpe_pme_handler() (with modified list of arguments).
>When the notifier chain is used, it can work regardless of whether the
>CONFIG_ACPI_GPE_WAKEUP is set.
>If the CONFIG_ACPI_GPE_WAKEUP is set, what you said is also OK.
I actually had another usage for this (I sent a patchset for docking station, which uses it)

>> >     if (acpi_bus_get_device(handle, &device))
>> >             return;
>> > Index: linux/drivers/acpi/sleep/wakeup.c
>> > ===================================================================
>> > --- linux.orig/drivers/acpi/sleep/wakeup.c  2008-09-08
>14:28:55.000000000 +0800
>> > +++ linux/drivers/acpi/sleep/wakeup.c       2008-09-08
>15:04:23.000000000 +0800
>> > @@ -142,6 +142,70 @@ void acpi_disable_wakeup_device(u8 sleep
>> >     spin_unlock(&acpi_device_lock);
>> >  }
>> >
>> > +#ifdef CONFIG_ACPI_GPE_WAKEUP
>> > +static int acpi_gpe_pme_check(struct acpi_device *dev)
>> > +{
>> > +   struct device *ldev;
>> > +
>> > +   ldev = acpi_get_physical_device(dev->handle);
>> > +   if (!ldev)
>> > +           return -ENODEV;
>> > +   /*
>> > +    * AML code might already clear the event, so ignore the return
>value.
>> > +    * Actually we can't correctly detect which device invokes GPE if
>the
>> > +    * event is cleared.
>> > +    */
>> > +   if (ldev->bus->pm && ldev->bus->pm->base.wakeup_event)
>> > +           ldev->bus->pm->base.wakeup_event(ldev);
>> > +
>> > +   /*
>> > +    * We always send the event. AML code usually identifies the exact
>> > +    * device of the GPE, let's trust it
>> > +    */
>> > +   device_receive_wakeup_event(ldev);
>> > +
>> > +   put_device(ldev);
>> > +   return 0;
>> > +}
>> > +
>> > +static int acpi_gpe_pme_handler(struct notifier_block *nb,
>> > +   unsigned long type, void *data)
>> > +{
>> > +   int ret;
>> > +   acpi_handle handle = data;
>> > +   struct acpi_device *dev;
>> > +
>> > +   if (type != ACPI_NOTIFY_DEVICE_WAKE)
>> > +           return NOTIFY_DONE;
>> > +
>> > +   if (acpi_bus_get_device(handle, &dev))
>> > +           return NOTIFY_DONE;
>> > +
>> > +   ret = acpi_gpe_pme_check(dev);
>> > +
>> > +   acpi_disable_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
>> > +           ACPI_NOT_ISR);
>> > +
>>
>> At which point are dev->wakeup.gpe_device and dev->wakeup.gpe_number
>> determined, for example, for PCI devices, and how?
>In the boot phase a PCI device will be bound with an ACPI device. In the
>system based on ACPI(GPE) when a PCI device generates a wakeup event, an
>ACPI interrupt will be triggered and the ACPI AML code will send the
>device wakeup event to the corresponding ACPI device. In such case we
>can get the gpe number for the PCI device.
This is correct. For example:

            Method (_L07, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.SMBS, 0x02)
            }

            Method (_L05, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.MODM, 0x02)
            }

GPE 5,7 are wakeup GPEs

Thanks,
Shaohua
