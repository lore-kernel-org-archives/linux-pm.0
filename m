From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: [RFC 3/5] pci wakeup handler
Date: Tue, 9 Sep 2008 11:38:19 +0800
Message-ID: <76780B19A496DC4B80439008DAD7076C01AC7F3275__43453.856992028$1220931795$gmane$org@PDSMSX501.ccr.corp.intel.com>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
	<200809081509.52070.rjw@sisk.pl>
	<76780B19A496DC4B80439008DAD7076C01AC7F30F3@PDSMSX501.ccr.corp.intel.com>
	<200809081956.48036.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200809081956.48036.david-b@pacbell.net>
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
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org



>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of David Brownell
>Sent: Tuesday, September 09, 2008 10:57 AM
>To: Li, Shaohua
>Cc: Rafael J. Wysocki; linux-pm@lists.linux-foundation.org; linux-
>acpi@vger.kernel.org; stern@rowland.harvard.edu; Jesse Barnes
>Subject: Re: [RFC 3/5] pci wakeup handler
>
>On Monday 08 September 2008, Li, Shaohua wrote:
>> >        if (drv && drv->pm && drv->pm->base.wakeup_event) {
>> >                int dev_ret = drv->pm->base.wakeup_event(&pdev->dev);
>> >                if (ret)
>> >                        ret = dev_ret;
>> >        }
>> >
>> > Also, why do you think we should ignore the returned value if ret is
>zero?
>>
>> Because we already identified the device which invokes PME.
>
>Well, we *may* have identified *one* of them.  If the device
>supports the PCI PM standards, we did.  If it uses legacy PM
>(like Intel's UHCI controllers), that's not guaranteed ...
Right, so the patch always 0 if device follows PM standards. Otherwise, return .wakeup_event().

>> Even the .wakeup_event() returns an error, we should populate
>> It's this device which has wakeup event.
>
>You haven't exactly defined the semantics of the return value,
>or what a caller would do with it.
I'll comment this on another mail

>> In my mind, driver isn't
>> required to provide .wakeup_event() unless device has non-standard
>> regs for wakeup event or some special to handle. Generic PME handling
>> should be fine for most devices (for PCI devices).
>
>I don't follow this then.  You're saying it will suffice to
>just clear the PCI PM status, and the driver is expected to
>work fine without even being notified about its wake event??
NPME or ACPI will call ' device_receive_wakeup_event()', which will do anything you want.

Thanks,
Shaohua
