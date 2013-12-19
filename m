From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/3] thermal: imx: add necessary clk operation
Date: Thu, 19 Dec 2013 15:29:24 +0800
Message-ID: <20131219072922.GD6691@S2101-09.ap.freescale.net>
References: <1387477045-19037-1-git-send-email-b20788@freescale.com>
 <1387477045-19037-2-git-send-email-b20788@freescale.com>
 <20131219065915.GB6691@S2101-09.ap.freescale.net>
 <d067cdecda2046f5998302deed320c2a@DM2PR03MB317.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d067cdecda2046f5998302deed320c2a@DM2PR03MB317.namprd03.prod.outlook.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Anson.Huang@freescale.com" <Anson.Huang@freescale.com>
Cc: "kernel@pengutronix.de" <kernel@pengutronix.de>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 19, 2013 at 07:08:16AM +0000, Anson.Huang@freescale.com wrote:
> >On Thu, Dec 19, 2013 at 01:17:24PM -0500, Anson Huang wrote:
> >> @@ -427,6 +429,13 @@ static int imx_thermal_probe(struct platform_device
> >*pdev)
> >>  		return ret;
> >>  	}
> >>
> >> +	data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
> >> +	if (IS_ERR(data->thermal_clk)) {
> >> +		ret = IS_ERR(data->thermal_clk);
> >> +		dev_err(&pdev->dev, "failed to get thermal clk!\n");
> >> +		return ret;
> >> +	}
> >> +
> >
> >So when the new kernel runs on a board with an old DTB installed, thermal
> >driver will be broken.
> >
> Yes, I thought about this case, but the previous implement is incorrect, if
> the PLL3 is not enabled by other drivers, thermal driver will not work, so
> this patch is a bug fix, not enhancement. So we still need to consider old
> dts case? 

The thing is mainline kernel runs on many board with thermal driver
being functional today.  That said, PLL3 is already enabled on these
platforms when thermal driver is running.  You cannot fix a bug but
meanwhile break these users who use old DTB.

Shawn

