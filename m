From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] i2c: designware: Do nothing in system suspend/resume when
 RT suspended
Date: Tue, 25 Apr 2017 14:04:43 +0200
Message-ID: <CAPDyKFoLFCfeX-Cwa4ACZ_yYeXh=0ryw4-iPXaO_Vxi9cq-8aQ@mail.gmail.com>
References: <20170330120444.12499-1-jarkko.nikula@linux.intel.com>
 <CAPDyKFqfDYg1ZzcJ2Z7md5CD6tYWRMwi4N8M82DesG_ybVKHMw@mail.gmail.com>
 <da36d4c0-7bcb-be18-6c8c-9fd714e2f1e0@linux.intel.com> <CAPDyKFqg3TDMwBO7a-1zuKYeLjE-BQ4RPmtXFKzA0s2a50jQqg@mail.gmail.com>
 <1493120164.24567.194.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36789 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428953AbdDYMEp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 08:04:45 -0400
Received: by mail-qk0-f171.google.com with SMTP id u75so44772910qka.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Apr 2017 05:04:45 -0700 (PDT)
In-Reply-To: <1493120164.24567.194.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On 25 April 2017 at 13:36, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, 2017-04-25 at 13:12 +0200, Ulf Hansson wrote:
>> On 25 April 2017 at 13:08, Jarkko Nikula <jarkko.nikula@linux.intel.co
>> m> wrote:
>> > On 04/25/2017 12:24 PM, Ulf Hansson wrote:
>
>> > > To me, the proper solution is to use the
>> > > pm_runtime_force_suspend|resume() helpers to deal with system
>> > > suspend/resume. However I understand that the behavior of the ACPI
>> > > PM
>> > > domain currently prevents us from doing this. That said, perhaps
>> > > we
>> > > should instead try to make the ACPI PM domain to better
>> > > collaborate
>> > > with drivers using pm_runtime_force_suspend|resume()? I have been
>> > > investigating that and started to cook some patches, although I
>> > > have
>> > > not yet been able to post something. If you think it could make
>> > > sense,
>> > > I can pick it up.
>> > >
>> >
>> > That's a good idea. I didn't think about it at all.
>>
>> Okay, thanks! I will continue to look into this and try to submit
>> something within a reasonable time frame, keep you posted.
>
> But please keep in mind that ACPI PM domain for BayTrail / CherryTrail
> is used by several IPs including most nasty GPDMA case. If something
> breaks that it would be show stopper.

Thanks for pointing this out. I think I have an overall understanding
of the complexity.

This driver is a cross SoC driver and not only should we expect the
ACPI PM domain to be used but also the generic PM domain for ARM SoCs.
To me, this makes it even more interesting and a very good candidate
to explore the usage of pm_runtime_force_suspend|resume(). :-)

Nevertheless, I will rely and appreciate help in testing and of course
also reviewing.

Kind regards
Uffe
