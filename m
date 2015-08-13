From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH 5/9] clk: qcom: gcc-msm8960: add child devices support.
Date: Wed, 12 Aug 2015 21:14:02 -0700
Message-ID: <20150813041402.GI13472@usrtlx11787.corpusers.net>
References: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org>
 <1436348838-22671-6-git-send-email-rnayak@codeaurora.org>
 <20150811224902.GO2839@codeaurora.org>
 <20150812201855.GF13472@usrtlx11787.corpusers.net>
 <55CBC14B.8000509@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([37.139.156.2]:10267 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751345AbbHMEOI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 00:14:08 -0400
Content-Disposition: inline
In-Reply-To: <55CBC14B.8000509@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "nrajan@codeaurora.org" <nrajan@codeaurora.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>

On Wed 12 Aug 14:57 PDT 2015, Stephen Boyd wrote:

> On 08/12/2015 01:18 PM, Bjorn Andersson wrote:
> > On Tue 11 Aug 15:49 PDT 2015, Stephen Boyd wrote:
> >
> >> On 07/08, Rajendra Nayak wrote:
> >>> diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
> >>> index eb6a4f9..2c80d03 100644
> >>> --- a/drivers/clk/qcom/gcc-msm8960.c
> >>> +++ b/drivers/clk/qcom/gcc-msm8960.c
> >>> @@ -15,6 +15,7 @@
> >>>   #include <linux/bitops.h>
> >>>   #include <linux/err.h>
> >>>   #include <linux/platform_device.h>
> >>> +#include <linux/of_platform.h>
> >>>   #include <linux/module.h>
> >>>   #include <linux/of.h>
> >>>   #include <linux/of_device.h>
> >>> @@ -3520,7 +3521,8 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
> >>>   	if (IS_ERR(clk))
> >>>   		return PTR_ERR(clk);
> >>>   
> >>> -	return qcom_cc_probe(pdev, match->data);
> >>> +	qcom_cc_probe(pdev, match->data);
> >>> +	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> >> We just lost the error code from qcom_cc_probe()...
> >>
> >> Also, I don't like having a subnode in DT. Why can't we use the
> >> same node as the GCC node and create a virtual child device here
> >> for tsens? We can assign the same of_node that this platform
> >> device has so that DT keeps working correctly.
> >>
> > Can't we make the gcc driver support being a child of a simple-mfd by
> > having it attempting to acquire the regmap of the parent and falling
> > back to creating its own mmio regmap?
> 
> So we would need to make a new device and driver for the simple-mfd 
> parent?

No that part is already in mainline, so my idea was that we add an early
return in qcom_cc_map() like:

	 struct device *dev = &pdev->dev;
+        struct regmap *map;
+
+        map = syscon_node_to_regmap(dev->parent->of_node);
+        if (!IS_ERR(map))
+                return map;

And then just update the dts to:

	gcc {
		compatible = "syscon", "simple-mfd";
		reg = <0x00900000 0x4000>;

		gcc: clock-controller {
			compatible = "qcom,gcc-apq8064";
			#clock-cells = <1>;
			#reset-cells = <1>;
		};
	};

But as I implemented this I realized that the syscon_node_to_regmap()
does not register the regmap as a devres of the parent, and as such it's
not caught by the regmap lookup in devm_clk_register_regmap().

So either one would need to make the syscon throw the regmap into devres
or make it possible to pass a regmap to devm_clk_register_regmap() for
this to work.

> I'm confused about what you're suggesting and what benefit it 
> has versus creating a child of the clock controller device.

The benefit would simply be that we're using the already existing
mechanism for handling multiple platform_drivers sharing a hw block.

> 
> Here's the patch I'm suggesting. The device name is probably wrong, but 
> you get the idea.

Looks very much like my take on it as well, I do however have concerns
that suddenly the node called "clock-controller" will have to come with
tsens related properties.

Are all the tsens-in-gcc blocks the same? Or do you intend to of_match
on the gcc compatible in the tsens driver?

Regards,
Bjorn
