From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] cpufreq: arm_big_little: remove unused cpu-cluster.<n>
 clock name
Date: Mon, 30 Mar 2015 14:39:10 +0100
Message-ID: <551951FE.3050105@arm.com>
References: <1427718438-31098-1-git-send-email-sudeep.holla@arm.com>	<1427718438-31098-2-git-send-email-sudeep.holla@arm.com> <CAKohpo=EkWcp_vvfQQg5yUR67rhDTB286Fi1j=22qTzOMg=dKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60987 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbbC3NiO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 30 Mar 2015 09:38:14 -0400
In-Reply-To: <CAKohpo=EkWcp_vvfQQg5yUR67rhDTB286Fi1j=22qTzOMg=dKw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>



On 30/03/15 14:31, Viresh Kumar wrote:
> On 30 March 2015 at 17:57, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> The "cpu-cluster.<n>" used to get the cluster clock is not used by any
>> platform. Moreover __of_clk_get_by_name used in clk_get return error if
>> the "clock-names" in the DT doesn't match this string. When using DT,
>> it's not compulsory to specify the clock name unless there are multiple
>> clock input entries in the consumer.
>>
>> This patch removes the unused clock string from the driver.
>>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   drivers/cpufreq/arm_big_little.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
>> index 3fc676c63f91..813315cd0247 100644

[...]

>> @@ -344,8 +343,7 @@ static int _get_cluster_clk_and_freq_table(struct device *cpu_dev)
>>                  goto free_opp_table;
>>          }
>>
>> -       name[12] = cluster + '0';
>> -       clk[cluster] = clk_get(cpu_dev, name);
>> +       clk[cluster] = clk_get(cpu_dev, NULL);
>>          if (!IS_ERR(clk[cluster])) {
>>                  dev_dbg(cpu_dev, "%s: clk: %p & freq table: %p, cluster: %d\n",
>>                                  __func__, clk[cluster], freq_table[cluster],
>
> What about non-DT platforms? Yeah, even I am not sure if any such
> platform will be there on not, using this driver..
>

Hope we don't have any in future :)

> But otherwise,
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>

Thanks.
