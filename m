From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC 17/27] drivers: cpu-pd: Record CPUs that are part of
 the domain
Date: Wed, 25 Nov 2015 13:20:33 -0700
Message-ID: <20151125202033.GI30342@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-18-git-send-email-lina.iyer@linaro.org>
 <20151124210043.GD25963@codeaurora.org>
 <20151125141338.GH30342@linaro.org>
 <56560801.8000908@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56560801.8000908@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 25 2015 at 12:12 -0700, Stephen Boyd wrote:
>On 11/25/15 06:13, Lina Iyer wrote:
>> On Tue, Nov 24 2015 at 14:00 -0700, Stephen Boyd wrote:
>>> On 11/17, Lina Iyer wrote:
>>>> diff --git a/drivers/base/power/cpu-pd.c b/drivers/base/power/cpu-pd.c
>>>> index 9758b8d..617ce54 100644
>>>> --- a/drivers/base/power/cpu-pd.c
>>>> +++ b/drivers/base/power/cpu-pd.c
>>>> @@ -18,6 +18,7 @@
>>>>  #include <linux/device.h>
>>>>  #include <linux/pm_runtime.h>
>>>>  #include <linux/platform_device.h>
>>>> +#include <linux/pm_qos.h>
>>>
>>> What's this added for?
>>>
>> pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
>> Getting the PM QoS for the CPUs.
>>
>
>Ok. That function call is not added in this patch though.
>
Ah, right. Will fix.

>-- 
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>a Linux Foundation Collaborative Project
>
