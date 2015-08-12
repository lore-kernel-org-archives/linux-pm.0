From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 5/9] clk: qcom: gcc-msm8960: add child devices support.
Date: Wed, 12 Aug 2015 14:57:31 -0700
Message-ID: <55CBC14B.8000509@codeaurora.org>
References: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org> <1436348838-22671-6-git-send-email-rnayak@codeaurora.org> <20150811224902.GO2839@codeaurora.org> <20150812201855.GF13472@usrtlx11787.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150812201855.GF13472@usrtlx11787.corpusers.net>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org, linux-arm-kernel@lists.infradead.org, nrajan@codeaurora.org, lina.iyer@linaro.org
List-Id: linux-pm@vger.kernel.org

On 08/12/2015 01:18 PM, Bjorn Andersson wrote:
> On Tue 11 Aug 15:49 PDT 2015, Stephen Boyd wrote:
>
>> On 07/08, Rajendra Nayak wrote:
>>> diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
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
>>> @@ -3520,7 +3521,8 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
>>>   	if (IS_ERR(clk))
>>>   		return PTR_ERR(clk);
>>>   
>>> -	return qcom_cc_probe(pdev, match->data);
>>> +	qcom_cc_probe(pdev, match->data);
>>> +	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
>> We just lost the error code from qcom_cc_probe()...
>>
>> Also, I don't like having a subnode in DT. Why can't we use the
>> same node as the GCC node and create a virtual child device here
>> for tsens? We can assign the same of_node that this platform
>> device has so that DT keeps working correctly.
>>
> Can't we make the gcc driver support being a child of a simple-mfd by
> having it attempting to acquire the regmap of the parent and falling
> back to creating its own mmio regmap?

So we would need to make a new device and driver for the simple-mfd 
parent? I'm confused about what you're suggesting and what benefit it 
has versus creating a child of the clock controller device.

Here's the patch I'm suggesting. The device name is probably wrong, but 
you get the idea.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
----8<----

diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
index aa294b1bad34..802e9794f76e 100644
--- a/drivers/clk/qcom/gcc-msm8960.c
+++ b/drivers/clk/qcom/gcc-msm8960.c
@@ -3505,7 +3505,9 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
  {
  	struct clk *clk;
  	struct device *dev = &pdev->dev;
+	struct platform_device *tsens;
  	const struct of_device_id *match;
+	int ret;
  
  	match = of_match_device(gcc_msm8960_match_table, &pdev->dev);
  	if (!match)
@@ -3520,7 +3522,30 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
  	if (IS_ERR(clk))
  		return PTR_ERR(clk);
  
-	return qcom_cc_probe(pdev, match->data);
+	ret = qcom_cc_probe(pdev, match->data);
+	if (ret)
+		return ret;
+
+	tsens = platform_device_alloc("tsens", -1);
+	if (!tsens) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	tsens->dev.parent = &pdev->dev;
+	tsens->dev.of_node = pdev->dev.of_node;
+	ret = platform_device_add(tsens);
+	if (ret)
+		goto err_add;
+
+	return 0;
+
+err_add:
+	platform_device_put(tsens);
+err_alloc:
+	qcom_cc_remove(pdev);
+
+	return ret;
  }
  
  static int gcc_msm8960_remove(struct platform_device *pdev)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
