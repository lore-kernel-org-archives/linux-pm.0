From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 04/15] clk: divider: Make generic for usage elsewhere
Date: Tue, 07 Oct 2014 18:27:35 +0100
Message-ID: <54342287.7020005@linaro.org>
References: <1409957256-23729-1-git-send-email-sboyd@codeaurora.org> <1409957256-23729-5-git-send-email-sboyd@codeaurora.org> <542EE5FE.9080806@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <542EE5FE.9080806@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Stephen,

Just noticed this regression while testing the patch on Arndale board.

https://bugs.linaro.org/show_bug.cgi?id=740


--srini

On 03/10/14 19:07, Stephen Boyd wrote:
> On 09/05/14 15:47, Stephen Boyd wrote:
>> +
>> +int divider_get_val(unsigned long rate, unsigned long parent_rate,
>> +		    const struct clk_div_table *table, u8 width,
>> +		    unsigned long flags)
>> +{
>>   	unsigned int div, value;
>> -	unsigned long flags = 0;
>> -	u32 val;
>>
>>   	div = DIV_ROUND_UP(parent_rate, rate);
>>
>> -	if (!_is_valid_div(divider, div))
>> +	if (!_is_valid_div(table, div, flags))
>>   		return -EINVAL;
>>
>> -	value = _get_val(divider, div);
>> +	value = _get_val(table, div, flags);
>> +
>> +	min_t(unsigned int, value, div_mask(width));
>> +
>> +	return 0;
>
> This should be return value, not return 0.
>
>> +}
>> +EXPORT_SYMBOL_GPL(divider_get_val);
>>
