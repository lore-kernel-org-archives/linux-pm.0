From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 5/9] PM / ACPI: Provide option to disable
 direct_complete for ACPI devices
Date: Fri, 25 Aug 2017 11:04:53 +0200
Message-ID: <CAPDyKFpznYWU3NcuUfUD3=isR_w=it995+=GTaF8OU2Ho-GOQg@mail.gmail.com>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0gJn=SzNFGUT7Zb+CfhQBZ7KNDK2GTSSXGexD8GObjGOw@mail.gmail.com>
 <CAPDyKFrGvqhBdenSyQ8Qr76DbfEvc74_dKZAjraA5qL63Mm2rg@mail.gmail.com> <4050921.GfHh1Z5NrX@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:38429 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755000AbdHYJEy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Aug 2017 05:04:54 -0400
Received: by mail-qk0-f178.google.com with SMTP id o184so8650318qkc.5
        for <linux-pm@vger.kernel.org>; Fri, 25 Aug 2017 02:04:54 -0700 (PDT)
In-Reply-To: <4050921.GfHh1Z5NrX@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>

On 24 August 2017 at 16:57, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, August 24, 2017 10:19:43 AM CEST Ulf Hansson wrote:
>> On 24 August 2017 at 01:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> > On Wed, Aug 23, 2017 at 4:42 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> >> In some cases a driver for an ACPI device needs to be able to prevent the
>> >> ACPI PM domain from using the direct_complete path during system sleep.
>> >>
>> >> One typical case is when the driver for the device needs its device to stay
>> >> runtime enabled, during the __device_suspend phase. This isn't the case
>> >> when the direct_complete path is being executed by the PM core, as it then
>> >> disables runtime PM for the device in __device_suspend(). Any following
>> >> attempts to runtime resume the device after that point, just fails.
>> >
>> > OK, that is a problem.
>> >
>> >> A workaround to this problem is to let the driver runtime resume its device
>> >> from its ->prepare() callback, as that would prevent the direct_complete
>> >> path from being executed. However, that may often be a waste, especially if
>> >> it turned out that no one really needed the device.
>> >>
>> >> For this reason, invent acpi_dev_disable|enable_direct_complete(), to allow
>> >> drivers to inform the ACPI PM domain to change its default behaviour during
>> >> system sleep, and thus control whether it may use the direct_complete path
>> >> or not.
>> >
>> > But I'm not sure this is the right place to address it as it very well
>> > may affect a PCI device too.
>> >
>> > Also, this is about the device and not about its ACPI companion
>> > object, so putting the flag in there is somewhat unclean, so to speak.
>> >
>> > It looks like we need a flag in dev_pm_info saying something along the
>> > lines of "my system suspend callback can deal with runtime PM" that
>> > will cause the direct_complete update to occur in
>> > __device_suspend_late() instead of __device_suspend().
>>
>> I realize that in the end this turns out to be a comparison between
>> the runtime PM centric path and the direct_complete path while
>> implementing system sleep. In patch 9, there is some more explanation
>> around this, however if you like I can elaborate even more about
>> this!?
>>
>> Regarding making changes to the PM core and adding more flags to the
>> dev_pm_info etc, I am not sure we really want that. Isn't it already
>> complex enough?
>
> Maybe it is.
>
>> My point is, that I am trying to improve the behavior of the ACPI PM
>> domain by enabling the runtime PM centric path for it, and even if
>> there is something similar that could be done for PCI, I don't think
>> we should need involvement by the PM core.
>
> Well, this generally simply doesn't work.
>
> The whole "runtime PM centric approach" idea is generally fine by me,
> but the fact today is that there are drivers not ready for it.  Which
> is why there is the direct_complete thing (it may be regarded as a
> sort-of workaround for the unreadiness of drivers if you will).

This is how I see it:

The runtime PM centric path is being widely deployed, however it takes
time to convert drivers.

The direct_complete path offers a great intermediate step for the ACPI
PM domain as it affects all its devices - while we wait for further
optimizations being deployed using the runtime PM centric path.

>
> Now, buy adding the no_direct_complete flag just to the ACPI PM domain
> you basically overlook the fact that this potentially affects the parents
> of the devices in question by preventing direct_complete from being set
> for them.  And those parents may not be in the ACPI PM domain in principle,
> so the problem needs to be addressed in the core.

Okay, let's move the flag to the dev_pm* structures, to not limit this
to the ACPI PM domain.

However in the current approach taken in this series, as it's coded as
opt-in to use for drivers, I am questioning how big of a problem
parent devices not being able to use the direct_complete path could
be!?
Couldn't it be good enough to just adopt the behavior of the ACPI PM
domain and more or less leave the core out of it - at least for now!?

I am also thinking, that for those parent devices that potentially may
suffer from not be able to use the direct_complete path, those can be
fixed by deploying the runtime PM centric path in their
subsystems/drivers. That would even mean that the parent devices get
the additional benefits that the runtime PM centric path offers. So,
in the end we would end up having a better optimized solution than we
had before.

What do you think?

Kind regards
Uffe
