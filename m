From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v3 5/9] thermal: qcom: tsens-8960: Add support for 8960
 family of SoCs
Date: Thu, 08 Oct 2015 12:45:58 +0530
Message-ID: <5616182E.5060707@codeaurora.org>
References: <1444280468-17159-1-git-send-email-rnayak@codeaurora.org> <1444280468-17159-6-git-send-email-rnayak@codeaurora.org> <20151008061243.GE26883@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20151008061243.GE26883@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com
List-Id: linux-pm@vger.kernel.org



On 10/08/2015 11:42 AM, Stephen Boyd wrote:
> On 10/08, Rajendra Nayak wrote:
>> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
>> index a471100..f3cefd1 100644
>> --- a/drivers/thermal/qcom/Makefile
>> +++ b/drivers/thermal/qcom/Makefile
>> @@ -1,2 +1,2 @@
>>  obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
>> -qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o
>> +qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o
> 
> Maybe a dumb question: What's the point of multiple files for
> each SoC if they're always built?

Just for code segregation and better readability.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
