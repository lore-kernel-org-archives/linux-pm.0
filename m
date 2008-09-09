From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: [RFC 1/5] devcore introduce wakeup_event callback
Date: Tue, 9 Sep 2008 11:49:03 +0800
Message-ID: <76780B19A496DC4B80439008DAD7076C01AC7F328B__25461.66039906$1220932369$gmane$org@PDSMSX501.ccr.corp.intel.com>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
	<20080908092305.221009807@sli10-desk.sh.intel.com>
	<200809081956.23522.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200809081956.23522.david-b@pacbell.net>
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
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of David Brownell
>Sent: Tuesday, September 09, 2008 10:56 AM
>To: Li, Shaohua
>Cc: linux-pm@lists.linux-foundation.org; linux-acpi@vger.kernel.org;
>stern@rowland.harvard.edu
>Subject: Re: [RFC 1/5] devcore introduce wakeup_event callback
>
>On Monday 08 September 2008, shaohua.li@intel.com wrote:
>> --- linux.orig/include/linux/pm.h       2008-09-08 13:55:57.000000000
>+0800
>> +++ linux/include/linux/pm.h    2008-09-08 13:56:51.000000000 +0800
>> @@ -125,6 +125,8 @@ typedef struct pm_message {
>>   *     make ANY assumptions about the hardware state right prior to
>@restore().
>>   *     On most platforms, there are no restrictions on availability of
>>   *     resources like clocks during @restore().
>> + * @wakeup_event: Checks if a wakeup event occurs. If yes, wakeup event
>should
>> + *      be disabled.
>
>And ... what else??  What does the return value indicate?
>Should anything be done with it other than printing it out
>if it's nonzero and we're debugging?
Return 0 if the device invokes a wakeup event. In this case, driver should clear/disable wakeup event.
Return < 0 if device didn't invoke wakeup.

If device follows standard wakeup mechanism which bus level can handle, driver isn't required to provide this callback.

>>   *
>>   * All of the above callbacks, except for @complete(), return error
>codes.
>>   * However, the error codes returned by the resume operations, @resume(),
>> @@ -151,6 +153,7 @@ struct pm_ops {
>>         int (*thaw)(struct device *dev);
>>         int (*poweroff)(struct device *dev);
>>         int (*restore)(struct device *dev);
>> +       int (*wakeup_event)(struct device *dev);
>
>My reaction to adding this method is:  why do it here rather
>than at the bus level?
>
>In my particular experience there are two basic types of wakeup
>event:
>
>  - Regular IRQs.  Common on SOC systems; the IRQ comes in,
>    the driver knows it must wake up.  Does not need any
>    driver model hook; enable_irq_wake()/disable_irq_wake()
>    suffice.
>
>    I've seen USB remote wakeup working just fine on several
>    different embedded Linuxes using only regular IRQ hooks.
Ok, in such case, driver can just ignore the callback.

>  - Side-band signaling.  Think of this as an IRQ mechanism
>    that's not used for "normal" driver operation, and you
>    won't be far off.  Examples:
>
>     * PCI PME# (and its PCIE analogue).  Bus-specific; it's
>       pretty much a kind of shared IRQ line coupled with a
>       special config-space register protocol.
Right, in this case, device doesn't require .wakeup_event too.
>
>     * ACPI GPEs.  Bus-specific ... and similar to GPIO IRQs.
>       Also sharable; bytecode is used to map the GPE and
>       some register state to the ACPI device(s) which
>       issued that GPE.
This isn't bus specific. ACPI devices can map to any physical devices, like PCI, IDE drive, PNP device. In this case, a bus specific mechanism can't handle all.
For example the UHCI case. A GPE is fired, we need to clear/disable the wakeup event. PCI bus can't handle it, as UHCI has special registers for this, so we need call into device specific handling.

>     * Pin-change events.  Not quite isomorphic with (GPIO)
>       IRQs; sometimes used with pins that aren't used for
>       events (or even GPIOs!) during normal operation.
>       Device-specific.
>
>That is, I don't see why these events should expect to be
>filtered through the driver core.  If there's a reason to
>do that, please enlighten me!
The UHCI case.

Thanks,
Shaohua
