From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Subject: Re: [PATCH v2 1/1] PM / OPP: Fix get sharing cpus when hotplug is used
Date: Tue, 25 Jul 2017 10:09:42 +0200
Message-ID: <CAHKzcEONE7CUyqdQC5X45S9oWLa9iEbyVd4gpgiYBuU4vQeKUA@mail.gmail.com>
References: <20170721121403.31202-1-waldemarx.rymarkiewicz@intel.com>
 <20170724084713.GR352@vireshk-i7> <10881593.7egIBYKlCz@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37263 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdGYIKX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jul 2017 04:10:23 -0400
Received: by mail-wr0-f195.google.com with SMTP id 12so11201209wrb.4
        for <linux-pm@vger.kernel.org>; Tue, 25 Jul 2017 01:10:23 -0700 (PDT)
In-Reply-To: <10881593.7egIBYKlCz@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, WaldemarRymarkiewiczwaldemar.rymarkiewicz@gmail.com, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>

On 24 July 2017 at 23:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, July 24, 2017 02:17:13 PM Viresh Kumar wrote:
>> On 21-07-17, 14:13, Waldemar Rymarkiewicz wrote:
>> > We fail dev_pm_opp_of_get_sharing_cpus() when possible cpu device does not
>> > exist. This can happen on platforms where not all possible CPUs are
>> > available at start up ie. hotplugged out. Cpu device is not registered in
>> > the system so we are not able to check struct device to set the sharing
>> > CPUs bitmask properly.
>> >
>> > Example (real use case):
>> > 2 physical MIPS cores, 4 VPE, cpu0/2 run Linux and cpu1/3 are not available
>> > for Linux at boot up. cpufreq-dt driver + opp v2 fail to register opp_table
>> > due to the fact there is no struct device for cpu1 (remains offline at
>> > bootup).
>> >
>> > To solve the bug, stop using device struct to check device_node. Instead
>> > get cpu device_node directly from device tree with of_get_cpu_node().
>> >
>> > Signed-off-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
>> > ---
>> >  drivers/base/power/opp/of.c | 28 +++++++++++++++++-----------
>> >  1 file changed, 17 insertions(+), 11 deletions(-)
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> I've lost track of this, care to resend?

I've resent v3.

/Waldek
