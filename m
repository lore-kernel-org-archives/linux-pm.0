From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 3/3] ARM64: dts: mt8173: Add thermal/auxadc device nodes
Date: Fri, 19 Feb 2016 08:20:00 +0100
Message-ID: <20160219071959.GL3939@pengutronix.de>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
 <1448883753-19068-4-git-send-email-s.hauer@pengutronix.de>
 <56C5EEE9.4020407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44159 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1424240AbcBSHUF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2016 02:20:05 -0500
Content-Disposition: inline
In-Reply-To: <56C5EEE9.4020407@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Matthias,

On Thu, Feb 18, 2016 at 05:18:49PM +0100, Matthias Brugger wrote:
> Hi Sascha,
> 
> On 30/11/15 12:42, Sascha Hauer wrote:
> >This adds the thermal controller and auxadc nodes to the Mediatek MT8173
> >dtsi file.
> >
> >Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> >Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> >---
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> >diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> >index 06a1564..e2ddd03 100644
> >--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> >+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> >@@ -277,6 +277,11 @@
> >  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> >  		};
> >
> >+		auxadc: auxadc@11001000 {
> >+			compatible = "mediatek,mt8173-auxadc";
> 
> Can you please write a small Documentation about the binding.
> I suppose it will be mediatek,auxadc and mediatek,mt8173-auxadc.

Just did that.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
