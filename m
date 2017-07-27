From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Subject: Re: [PATCH v4 1/1] PM / OPP: Fix get sharing cpus when hotplug is used
Date: Thu, 27 Jul 2017 12:01:03 +0200
Message-ID: <CAHKzcEMKWweUbuFV3j1tGVR54pFLDTzBSswjy6oHeaEExBxM5Q@mail.gmail.com>
References: <20170726121151.7576-1-waldemarx.rymarkiewicz@intel.com> <2684007.FU6l9NfBCM@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37676 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbdG0KBp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 06:01:45 -0400
Received: by mail-wr0-f196.google.com with SMTP id 12so15976079wrb.4
        for <linux-pm@vger.kernel.org>; Thu, 27 Jul 2017 03:01:45 -0700 (PDT)
In-Reply-To: <2684007.FU6l9NfBCM@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>

On 27 July 2017 at 02:03, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, July 26, 2017 02:11:38 PM Waldemar Rymarkiewicz wrote:
>> We fail dev_pm_opp_of_get_sharing_cpus() when possible cpu device does not
>> exist. This can happen on platforms where not all possible CPUs are
>> available at start up ie. hotplugged out. Cpu device is not registered in
>> the system so we are not able to check struct device to set the sharing
>> CPUs bitmask properly.
>>
>> Example (real use case):
>> 2 physical MIPS cores, 4 VPE, cpu0/2 run Linux and cpu1/3 are not available
>> for Linux at boot up. cpufreq-dt driver + opp v2 fail to register opp_table
>> due to the fact there is no struct device for cpu1 (remains offline at
>> bootup).
>>
>> To solve the bug, stop using device struct to check device_node. Instead
>> get cpu device_node directly from device tree with of_get_cpu_node().
>>
>> Signed-off-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

>> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
>
> Please fix the build issue reported by 0-day introduced by this patch.

err.. alldefconfig does not enable CONFIG_OF.  I have updated my
travis file, so it builds now all{yes|no|def}config.
sending v5 in a minute.

I would prefer to take this patch as it is if no one is against and
once Sudeep's patch [1] is in the tree, I will push another one
replacing  of_get_cpu_node with of_cpu_device_node_ge().

[1] https://patchwork.kernel.org/patch/9859453/

/Waldek
