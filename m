From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2] PM / OPP: Move the OPP directory out of power/
Date: Wed, 27 Sep 2017 19:49:58 +0200
Message-ID: <CAJZ5v0jM5nJ-WyA1M7Ce7a7XyGTSsxxXSYop3Ah7d+K1F3KPuQ@mail.gmail.com>
References: <3eaed52523d54bdc7b43b335d5aefda9b4d1b4a8.1506463860.git.viresh.kumar@linaro.org>
 <CAJZ5v0hcg5bYfhUR2cLZo5bB8gL8F3UeD9Wrbp8TLLQU_agx-A@mail.gmail.com> <20170927172705.GA12211@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33273 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751016AbdI0RuA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2017 13:50:00 -0400
In-Reply-To: <20170927172705.GA12211@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Sep 27, 2017 at 7:27 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 27-09-17, 19:22, Rafael J. Wysocki wrote:
>> On Wed, Sep 27, 2017 at 12:12 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > The drivers/base/power/ directory is special and contains code related
>> > to power management core like system suspend/resume, hibernation, etc.
>> > It was fine to keep the OPP code inside it when we had just one file for
>> > it, but it is growing now and already has a directory for itself.
>> >
>> > Lets move it directly under drivers/ directory, just like cpufreq and
>> > cpuidle.
>> >
>> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> > ---
>> > V1->V2:
>> > - Update maintainers and add a Kconfig file in drivers/opp/.
>>
>> OK, but I need an ACK from Stephen here.
>
> Sure.
>
>> And while we are at it, you, Stephen and Nishanth Menon are listed as
>> maintainers for it and I'm not, but I still apply OPP patches, so
>> maybe one of you can set up a git repo for this and send pull requests
>> to me instead?
>
> Yeah, I will setup one.

Actually, it is even listed in that MAINTAINERS entry already, unless
you prefer to use a different one that is. :-)

Thanks,
Rafael
