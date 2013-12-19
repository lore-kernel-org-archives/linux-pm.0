From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 2/3] thermal: imx: add necessary clk operation
Date: Thu, 19 Dec 2013 08:24:50 +0200
Message-ID: <20131219062450.GC4148@tarshish>
References: <1387477045-19037-1-git-send-email-b20788@freescale.com>
 <1387477045-19037-2-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:44454 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332Ab3LSGYy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 19 Dec 2013 01:24:54 -0500
Content-Disposition: inline
In-Reply-To: <1387477045-19037-2-git-send-email-b20788@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, rui.zhang@intel.com, eduardo.valentin@ti.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org

Hi Anson,

On Thu, Dec 19, 2013 at 01:17:24PM -0500, Anson Huang wrote:
> +	if (IS_ERR(data->thermal_clk)) {
> +		ret = IS_ERR(data->thermal_clk);

You probably what to return PTR_ERR here.

baruch

> +		dev_err(&pdev->dev, "failed to get thermal clk!\n");
> +		return ret;
> +	}

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
