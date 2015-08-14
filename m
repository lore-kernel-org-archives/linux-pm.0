From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 5/9] clk: qcom: gcc-msm8960: add child devices support.
Date: Thu, 13 Aug 2015 17:42:06 -0700
Message-ID: <20150814004206.GU26614@codeaurora.org>
References: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org>
 <1436348838-22671-6-git-send-email-rnayak@codeaurora.org>
 <20150811224902.GO2839@codeaurora.org>
 <55CB0B26.2020105@linaro.org>
 <55CC1CFE.7000005@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38337 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255AbbHNAmI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 20:42:08 -0400
Content-Disposition: inline
In-Reply-To: <55CC1CFE.7000005@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, lina.iyer@linaro.org, nrajan@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On 08/13, Rajendra Nayak wrote:
> >On 11/08/15 23:49, Stephen Boyd wrote:
> >>On 07/08, Rajendra Nayak wrote:
> >>>diff --git a/drivers/clk/qcom/gcc-msm8960.c
> >>>b/drivers/clk/qcom/gcc-msm8960.c
> >>>index eb6a4f9..2c80d03 100644
> >>>--- a/drivers/clk/qcom/gcc-msm8960.c
> >>>+++ b/drivers/clk/qcom/gcc-msm8960.c
> >>>@@ -15,6 +15,7 @@
> >>>  #include <linux/bitops.h>
> >>>  #include <linux/err.h>
> >>>  #include <linux/platform_device.h>
> >>>+#include <linux/of_platform.h>
> >>>  #include <linux/module.h>
> >>>  #include <linux/of.h>
> >>>  #include <linux/of_device.h>
> >>>@@ -3520,7 +3521,8 @@ static int gcc_msm8960_probe(struct
> >>>platform_device *pdev)
> >>>      if (IS_ERR(clk))
> >>>          return PTR_ERR(clk);
> >>>
> >>>-    return qcom_cc_probe(pdev, match->data);
> >>>+    qcom_cc_probe(pdev, match->data);
> >>>+    return of_platform_populate(pdev->dev.of_node, NULL, NULL,
> >>>&pdev->dev);
> >>
> >>We just lost the error code from qcom_cc_probe()...
> >>
> >I think Rajendra picked up the wrong patch for this series, I did submit
> >a v2 (https://patches.linaro.org/44033/) with the above fixed.
> 
> ah, sorry about that.
> 
> >>Also, I don't like having a subnode in DT. Why can't we use the
> >>same node as the GCC node and create a virtual child device here
> >>for tsens? We can assign the same of_node that this platform
> >>device has so that DT keeps working correctly.
> 
> So the current driver looks up data based on compatible strings.

The tsens device is always the same piece of hardware. The only
thing that's changing is the qfprom data and the number of
sensors. So we should be looking at the qfprom compatible string
to figure out how to interpret the qfprom data which would
include the number of sensors and how the data is encoded.

> So you suggesting to create a virtual child device for gcc and
> associate the gcc DT node to it? (And have the tsens compatible
> mentioned as part of the gcc DT node?)

No. The driver should work just fine without having to
interrogate the device's compatible string. If we still need the
compatible check for some reason, then we can always match based
on qcom,gcc-msm8960, qcom,gcc-apq8064, etc. But I don't see why
we need to do that when we should be looking at what type of
qfprom is connected so we can correctly parse the data.

> How is this any different from creating a subnode in DT anyway?

The difference is we don't make up nodes to satisfy linux device
driver design. I suspect the hardware engineers put tsens inside
gcc because both blocks were written by the same person/team and
they just needed some place to jam some registers and call it a
day. That doesn't constitute an MFD or bus, which is what we
would be expressing in DT if we made a child node, it constitutes
a horrible software interface design that we have to live with.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
