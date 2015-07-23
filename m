From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v6 01/13] clk: qcom: Add support for GDSCs
Date: Thu, 23 Jul 2015 14:07:32 +0530
Message-ID: <55B0A7CC.3040607@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org> <1437549069-29655-2-git-send-email-rnayak@codeaurora.org> <55B03495.8050902@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <55B03495.8050902@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org
List-Id: linux-pm@vger.kernel.org


On 07/23/2015 05:55 AM, Stephen Boyd wrote:
> On 07/22/2015 12:10 AM, Rajendra Nayak wrote:
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 59d1666..a7c2eea 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -39,6 +39,11 @@ config IPQ_LCC_806X
>>         Say Y if you want to use audio devices such as i2s, pcm,
>>         S/PDIF, etc.
>> +config QCOM_GDSC
>> +    bool
>> +    select PM_GENERIC_DOMAINS if PM
>> +    depends on COMMON_CLK_QCOM
>>
>
> We can drop this depends because it should only be selected if
> COMMON_CLK_QCOM anyway.

Stephen, thanks for the review. I'll fix up this and others you pointed 
to in this patch and others in the series.
