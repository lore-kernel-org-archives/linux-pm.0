From: Bai Ping <b51503@freescale.com>
Subject: Re: [PATCH v2] cpufreq: imx: update the clock switch flow to support
 imx6ul
Date: Fri, 11 Sep 2015 16:38:05 +0800
Message-ID: <55F292ED.1080000@freescale.com>
References: <1441986065-8821-1-git-send-email-b51503@freescale.com>
 <20150911080741.GJ9650@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bl2on0143.outbound.protection.outlook.com ([65.55.169.143]:44236
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751273AbbIKIid (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 11 Sep 2015 04:38:33 -0400
In-Reply-To: <20150911080741.GJ9650@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org



On 2015/9/11 16:07, Viresh Kumar wrote:
> On 11-09-15, 23:41, Bai Ping wrote:
>> +	if (of_machine_is_compatible("fsl,imx6ul")) {
>> +		pll2_bus_clk = clk_get(cpu_dev, "pll2_bus");
>> +		secondary_sel_clk = clk_get(cpu_dev, "secondary_sel");
>> +		if (IS_ERR(pll2_bus_clk) || IS_ERR(secondary_sel_clk)) {
>> +			dev_err(cpu_dev, "failed to get clocks specific to imx6ul\n");
>> +			ret = -ENOENT;
>> +			goto put_clk;
>> +		}
>> +	}
>> +
>>   	arm_reg = regulator_get(cpu_dev, "arm");
>>   	pu_reg = regulator_get_optional(cpu_dev, "pu");
>>   	soc_reg = regulator_get(cpu_dev, "soc");
>> @@ -331,6 +365,10 @@ put_clk:
>>   		clk_put(step_clk);
>>   	if (!IS_ERR(pll2_pfd2_396m_clk))
>>   		clk_put(pll2_pfd2_396m_clk);
>> +	if (!IS_ERR(pll2_bus_clk))
>> +		clk_put(pll2_bus_clk);
>> +	if (!IS_ERR(secondary_sel_clk))
>> +		clk_put(secondary_sel_clk);
>>   	of_node_put(np);
>>   	return ret;
>>   }
> As part of good coding practices, you should free resources in the
> reverse order to which they were allocated. The clocks don't follow
> that, but its not a problem with just your patch. That's how it is
> present today. Maybe you can write another patch to fix that.

thanks for your suggestion, I will pay more attention to it in future 
coding.

> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>

