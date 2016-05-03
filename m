From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 1/2] PM / OPP: add non-OF versions of
 dev_pm_opp_{cpumask_,}remove_table
Date: Tue, 3 May 2016 11:46:00 +0100
Message-ID: <57288168.7060105@arm.com>
References: <1461926262-24732-1-git-send-email-sudeep.holla@arm.com>
 <5727DAFA.5040902@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37863 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755462AbcECKqE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 3 May 2016 06:46:04 -0400
In-Reply-To: <5727DAFA.5040902@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org



On 02/05/16 23:55, Stephen Boyd wrote:
> On 04/29/2016 03:37 AM, Sudeep Holla wrote:
>> Functions dev_pm_opp_of_{cpumask_,}remove_table removes/frees all the
>> static OPP entries associated with the device and/or all cpus(in case
>> of cpumask) that are created from DT.
>>
>> However the OPP entries are populated reading from the firmware or some
>> different method using dev_pm_opp_add are marked dynamic and can't be
>> removed using above functions.
>>
>> This patch adds non DT/OF versions of dev_pm_opp_{cpumask_,}remove_table
>> to support the above mentioned usecase.
>>
>> This is in preparation to make use of the same in scpi-cpufreq.c
>>
>> Cc: Viresh Kumar <vireshk@kernel.org>
>> Cc: Nishanth Menon <nm@ti.com>
>> CC: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: linux-pm@vger.kernel.org
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Could you rebase this on top of Arnd's patch[1] to fix the cpumask_var_t
> usage? Your patch introduces more incorrect use of that type.
>

Thanks for noticing that. I will rebase on top of that patch and repost it.

-- 
Regards,
Sudeep
