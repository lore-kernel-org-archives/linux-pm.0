From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Subject: Re: [PATCH v3 1/1] PM / OPP: Fix get sharing cpus when hotplug is used
Date: Wed, 26 Jul 2017 11:26:17 +0200
Message-ID: <CAHKzcEPhyGOzmZJKQg4KGDApT7u4yzKcPzL3fBKUg+=zd__vPQ@mail.gmail.com>
References: <20170724160342.1879-1-waldemarx.rymarkiewicz@intel.com> <20170726061637.GZ352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33893 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750813AbdGZJ07 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2017 05:26:59 -0400
Received: by mail-wr0-f194.google.com with SMTP id o33so14174103wrb.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Jul 2017 02:26:59 -0700 (PDT)
In-Reply-To: <20170726061637.GZ352@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, WaldemarRymarkiewiczwaldemar.rymarkiewicz@gmail.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>

On 26 July 2017 at 08:16, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> +Rafael,
>
> On 24-07-17, 18:03, Waldemar Rymarkiewicz wrote:
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
>> ---
>>  drivers/base/power/opp/of.c | 28 +++++++++++++++++-----------
>>  1 file changed, 17 insertions(+), 11 deletions(-)
>
> @Waldemar: I don't see this series on patchwork [1]. Are you
> subscribed for that list ?

Well, I am indeed but with my gmail. I have all my mailboxes attached
to my patchwork account but didn't know that patchwork checks for the
subscription before it picks up a patch.  Will subscribe with my
@intel.com and send v4  including Stephen comment and Reviewed-by.

/Waldek
