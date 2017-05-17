From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v1] cpufreq: kirkwood-cpufreq:- Handle return value of
 clk_prepare_enable
Date: Wed, 17 May 2017 11:20:26 +0530
Message-ID: <8f21257b-f20a-f2cd-3d56-bebe51aad946@gmail.com>
References: <1494918717-16434-1-git-send-email-arvind.yadav.cs@gmail.com>
 <20170517043445.GZ17481@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35326 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdEQFvj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2017 01:51:39 -0400
In-Reply-To: <20170517043445.GZ17481@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Yes, I will add check for powersave clk.

Thanks
- Arvind

On Wednesday 17 May 2017 10:04 AM, Viresh Kumar wrote:
> On 16-05-17, 12:41, Arvind Yadav wrote:
>> Here, Clock enable can failed. So adding an error check for
>> clk_prepare_enable.
> Rewrite it as:
>
> clk_prepare_enable() can fail here and we must check its return value.
>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   drivers/cpufreq/kirkwood-cpufreq.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
>> index 1b9bcd7..4c30103 100644
>> --- a/drivers/cpufreq/kirkwood-cpufreq.c
>> +++ b/drivers/cpufreq/kirkwood-cpufreq.c
>> @@ -127,7 +127,12 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
>>   		return PTR_ERR(priv.cpu_clk);
>>   	}
>>   
>> -	clk_prepare_enable(priv.cpu_clk);
>> +	err = clk_prepare_enable(priv.cpu_clk);
>> +	if (err) {
>> +		dev_err(priv.dev, "Unable to prepare cpuclk\n");
>> +		return err;
>> +	}
>> +
>>   	kirkwood_freq_table[0].frequency = clk_get_rate(priv.cpu_clk) / 1000;
>>   
>>   	priv.ddr_clk = of_clk_get_by_name(np, "ddrclk");
>> @@ -137,7 +142,11 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
>>   		goto out_cpu;
>>   	}
>>   
>> -	clk_prepare_enable(priv.ddr_clk);
>> +	err = clk_prepare_enable(priv.ddr_clk);
>> +	if (err) {
>> +		dev_err(priv.dev, "Unable to prepare ddrclk\n");
>> +		goto out_cpu;
>> +	}
>>   	kirkwood_freq_table[1].frequency = clk_get_rate(priv.ddr_clk) / 1000;
>>   
>>   	priv.powersave_clk = of_clk_get_by_name(np, "powersave");
> There is one more prepare-enable after this. Why not fix that as well
> ?
>
