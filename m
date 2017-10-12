From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] PM / OPP: add missing of_node_put() for
 of_get_cpu_node()
Date: Thu, 12 Oct 2017 09:50:37 +0100
Message-ID: <f60a6d2d-a216-45e3-75c4-4ed285b74ec4@arm.com>
References: <1507632519-19648-1-git-send-email-sudeep.holla@arm.com>
 <1507716661-27146-1-git-send-email-sudeep.holla@arm.com>
 <20171011202011.GB25302@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbdJLIul (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Oct 2017 04:50:41 -0400
In-Reply-To: <20171011202011.GB25302@codeaurora.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>



On 11/10/17 21:20, Stephen Boyd wrote:
> On 10/11, Sudeep Holla wrote:
>> @@ -603,7 +603,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>> @@ -614,10 +614,12 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>>  		/* Get OPP descriptor node */
>>  		tmp_np = _opp_of_get_opp_desc_node(cpu_np);
>>  		if (!tmp_np) {
>> +			of_node_put(cpu_np);
>>  			pr_err("%pOF: Couldn't find opp node\n", cpu_np);
>>  			ret = -ENOENT;
>>  			goto put_cpu_node;
>>  		}
>> +		of_node_put(cpu_np);
>>
> 
> Why not?
> 
> 
> 		tmp_np = _opp_of_get_opp_desc_node(cpu_np);
> 		of_node_put(cpu_np);
> 		if (!tmp_np) {
> 			pr_err("%pOF: Couldn't find opp node\n", cpu_np);
> 			ret = -ENOENT;
> 			goto put_cpu_node;
> 		}
> 

Yes that's exactly what I asked in v1 and the did it other way as I
didn't get any response. I can do this way, not a problem.

-- 
Regards,
Sudeep
