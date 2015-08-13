From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH 5/9] clk: qcom: gcc-msm8960: add child devices support.
Date: Thu, 13 Aug 2015 09:58:46 +0530
Message-ID: <55CC1CFE.7000005@codeaurora.org>
References: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org> <1436348838-22671-6-git-send-email-rnayak@codeaurora.org> <20150811224902.GO2839@codeaurora.org> <55CB0B26.2020105@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <55CB0B26.2020105@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, lina.iyer@linaro.org, nrajan@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> On 11/08/15 23:49, Stephen Boyd wrote:
>> On 07/08, Rajendra Nayak wrote:
>>> diff --git a/drivers/clk/qcom/gcc-msm8960.c
>>> b/drivers/clk/qcom/gcc-msm8960.c
>>> index eb6a4f9..2c80d03 100644
>>> --- a/drivers/clk/qcom/gcc-msm8960.c
>>> +++ b/drivers/clk/qcom/gcc-msm8960.c
>>> @@ -15,6 +15,7 @@
>>>   #include <linux/bitops.h>
>>>   #include <linux/err.h>
>>>   #include <linux/platform_device.h>
>>> +#include <linux/of_platform.h>
>>>   #include <linux/module.h>
>>>   #include <linux/of.h>
>>>   #include <linux/of_device.h>
>>> @@ -3520,7 +3521,8 @@ static int gcc_msm8960_probe(struct
>>> platform_device *pdev)
>>>       if (IS_ERR(clk))
>>>           return PTR_ERR(clk);
>>>
>>> -    return qcom_cc_probe(pdev, match->data);
>>> +    qcom_cc_probe(pdev, match->data);
>>> +    return of_platform_populate(pdev->dev.of_node, NULL, NULL,
>>> &pdev->dev);
>>
>> We just lost the error code from qcom_cc_probe()...
>>
> I think Rajendra picked up the wrong patch for this series, I did submit
> a v2 (https://patches.linaro.org/44033/) with the above fixed.

ah, sorry about that.

>> Also, I don't like having a subnode in DT. Why can't we use the
>> same node as the GCC node and create a virtual child device here
>> for tsens? We can assign the same of_node that this platform
>> device has so that DT keeps working correctly.

So the current driver looks up data based on compatible strings.
So you suggesting to create a virtual child device for gcc and
associate the gcc DT node to it? (And have the tsens compatible
mentioned as part of the gcc DT node?)
How is this any different from creating a subnode in DT anyway?
