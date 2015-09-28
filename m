From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH][RFC] ACPI / PM: Fix incorrect wakeup irq setting before suspend-to-idle
Date: Mon, 28 Sep 2015 22:05:53 +0200
Message-ID: <CAJZ5v0h=fjAzLKOio1sAH3J_3FL6pY041jiLvLs8MPTkbvm9Ag@mail.gmail.com>
References: <1439172686-16360-1-git-send-email-yu.c.chen@intel.com>
	<14896395.L30bH9BMzP@vostro.rjw.lan>
	<36DF59CE26D8EE47B0655C516E9CE64026587A89@SHSMSX101.ccr.corp.intel.com>
	<2077382.8itqOgEaxv@vostro.rjw.lan>
	<36DF59CE26D8EE47B0655C516E9CE64026F22661@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE64026F22661@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "Brown, Len" <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Mon, Sep 28, 2015 at 7:56 PM, Chen, Yu C <yu.c.chen@intel.com> wrote:
> Hi,
>
>> -----Original Message-----
>> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
>> Sent: Monday, September 28, 2015 8:56 PM
>> To: Chen, Yu C
>> Cc: Wysocki, Rafael J; jiang.liu@linux.intel.com; Zhang, Rui; Brown, Len; linux-
>> kernel@vger.kernel.org; linux-pm@vger.kernel.org
>> Subject: Re: [PATCH][RFC] ACPI / PM: Fix incorrect wakeup irq setting before
>> suspend-to-idle
>>
>> On Monday, September 28, 2015 01:51:09 AM Chen, Yu C wrote:
>> > Hi, Rafael,
>> >
>> > > -----Original Message-----
>> > > From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
>> > > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
>> > > Sent: Sunday, September 27, 2015 9:30 PM
>> > > To: Chen, Yu C
>> > > Cc: Wysocki, Rafael J; jiang.liu@linux.intel.com; Zhang, Rui; Brown,
>> > > Len; linux- kernel@vger.kernel.org; linux-pm@vger.kernel.org
>> > > Subject: Re: [PATCH][RFC] ACPI / PM: Fix incorrect wakeup irq
>> > > setting before suspend-to-idle
>> > >
>> > > On Saturday, September 26, 2015 02:37:19 PM Chen, Yu C wrote:
>> > > > Hi, Rafael,
>> > > >
>> > > > > -----Original Message-----
>> > > > > From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
>> > > > > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
>> > > > > Sent: Friday, September 25, 2015 9:57 PM
>> > > > > To: Chen, Yu C
>> > > > > Cc: Wysocki, Rafael J; jiang.liu@linux.intel.com; Zhang, Rui;
>> > > > > Brown, Len; linux- kernel@vger.kernel.org;
>> > > > > linux-pm@vger.kernel.org
>> > > > > Subject: Re: [PATCH][RFC] ACPI / PM: Fix incorrect wakeup irq
>> > > > > setting before suspend-to-idle
>> > > > >
>> > > > > On Friday, September 25, 2015 06:42:41 AM Chen, Yu C wrote:
>> > > > > > Hi,Rafael, thanks a lot for your review, will resend v2 version.
>> > > > > >
>> > > > > > > -----Original Message-----
>> > > > > > > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
>> > > > > > > Sent: Friday, September 25, 2015 9:24 AM
>> > > > > > > To: Chen, Yu C
>> > > > > > > Cc: Wysocki, Rafael J; jiang.liu@linux.intel.com; Zhang,
>> > > > > > > Rui; Brown, Len; linux- kernel@vger.kernel.org;
>> > > > > > > linux-pm@vger.kernel.org
>> > > > > > > Subject: Re: [PATCH][RFC] ACPI / PM: Fix incorrect wakeup
>> > > > > > > irq setting before suspend-to-idle
>> > > > > > >
>> > > > > > > On Monday, August 10, 2015 10:11:26 AM Chen Yu wrote:
>> > > > >
>> > Because the name of acpi_irq is already used by acpi irq handler at
>> > drivers/acpi/osl.c:
>> > request_irq(irq, acpi_irq, IRQF_SHARED, "acpi", acpi_irq)
>>
>> Ah, this is the name of the handler.  I forgot about that, sorry.
>>
>> Well, it might be worth renaming the handler to something like
>> acpi_interrupt(), then.
> OK, will rewrite the patch, Thanks!

Alternatively, you can call the new variable acpi_sci_irq.

Thanks,
Rafael
