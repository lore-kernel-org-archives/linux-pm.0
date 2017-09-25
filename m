From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Hibernation or S2R doesn't cover entire
 power directory
Date: Tue, 26 Sep 2017 01:18:14 +0200
Message-ID: <CAJZ5v0h65Xo+jFffHE9j2bY=BAOfNvV5DWLtxsx4Bxc2y1dRsw@mail.gmail.com>
References: <18e729501c1ebe4798d17b8d8a60ba102ebc2837.1505922834.git.viresh.kumar@linaro.org>
 <CAJZ5v0hv3T7L0c5URrVHC=H5V3h+W7OLRXVMVXLQf-VuTT-E+Q@mail.gmail.com> <20170925231055.GA3053@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33988 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965663AbdIYXSP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2017 19:18:15 -0400
In-Reply-To: <20170925231055.GA3053@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Sep 26, 2017 at 1:10 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 25-09-17, 00:44, Rafael J. Wysocki wrote:
>> On Wed, Sep 20, 2017 at 5:58 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > The command:
>> >
>> >  $ scripts/get_maintainer.pl -f drivers/base/power/opp/core.c
>> >
>> > is incorrectly picking maintainers from Hibernation and Suspend to RAM
>> > as well, simply because the entries in MAINTAINERS file contains the
>> > entire power directory. Though the only concerning file is main.c
>> > really.
>>
>> No, it is not the only one.  The others are common.c, trace.c,
>> wakeup.c, wakeirq.c, sysfs.c, generic_ops.c and power.h (if I have not
>> overlooked any).
>>
>> I'm not actually sure how to fix this issue other than by listing all
>> of the files in question directly in there.
>
> Should I just use *.c for now? Yeah, that will still cover lot more files, but
> at least the directories, like OPP, are not going to show those maintainers.
>
> Or I was actually thinking of moving the entire OPP directory out of
> drivers/base/power, and move to drivers/opp, just like cpufreq and cpuidle. Will
> that be okay?

Yes, that should be fine.
