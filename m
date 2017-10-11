From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] PM / OPP: add missing of_node_put() for
 of_get_cpu_node()
Date: Wed, 11 Oct 2017 11:35:20 +0100
Message-ID: <62886e65-5bed-9a17-e1e0-0012ebc742ec@arm.com>
References: <1507632519-19648-1-git-send-email-sudeep.holla@arm.com>
 <1507716661-27146-1-git-send-email-sudeep.holla@arm.com>
 <20171011102146.GB32532@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58050 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752099AbdJKKfZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Oct 2017 06:35:25 -0400
In-Reply-To: <20171011102146.GB32532@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>



On 11/10/17 11:21, Viresh Kumar wrote:
> On 11-10-17, 11:11, Sudeep Holla wrote:
>> Commit 762792913f8c ("PM / OPP: Fix get sharing CPUs when hotplug is used")
>> moved away from using cpu_dev->of_node because of some limitations.
>> However commit 7467c9d95989 ("of: return of_get_cpu_node from
>> of_cpu_device_node_get if CPUs are not registered") added support to
>> falls back to of_get_cpu_node if called if CPUs are not registered yet.
>>
>> It adds the missing of_node_put for the CPU device nodes. This patch also
>> moves back to use of_cpu_device_node_get in dev_pm_opp_of_get_sharing_cpus
>> to avoid scanning the device tree again.
>>
>> Cc: Viresh Kumar <vireshk@kernel.org>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Fixes: 762792913f8c ("PM / OPP: Fix get sharing CPUs when hotplug is used")
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Cc: 4.14+ <stable@vger.kernel.org> # 4.14+
> 

Generally Greg pulls them based on fixes tags, so I didn't bother
to specify that explicitly :)

>> ---
>>  drivers/opp/of.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> v1->v2:
>> 	- Moved of_node_put after using cpu_np
>> 	- Renamed the $subject as fixing refcount is key part of the part
>> 	  and correctly relates to "Fixes" tag
>> 	- Also added include change which was accidentally missed
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 


Thanks.

-- 
Regards,
Sudeep
