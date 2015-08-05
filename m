From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Wed, 5 Aug 2015 12:20:39 +0200
Message-ID: <20150805102039.GH18700@pengutronix.de>
References: <1437465566-16299-1-git-send-email-s.hauer@pengutronix.de>
 <1437465566-16299-3-git-send-email-s.hauer@pengutronix.de>
 <CAGS+omAsTBMhfLPs5V68Ou1E5WXnQzZ3_E5+9qCCbAja3dgY-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39307 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbbHEKUs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 06:20:48 -0400
Content-Disposition: inline
In-Reply-To: <CAGS+omAsTBMhfLPs5V68Ou1E5WXnQzZ3_E5+9qCCbAja3dgY-w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: "Hanyi.Wu" <hanyi.wu@mediatek.com>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sasha Hauer <kernel@pengutronix.de>, linux-mediatek@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>

On Tue, Jul 21, 2015 at 11:13:22PM +0800, Daniel Kurtz wrote:
> Hi Sascha,
> 
> Review comments inline...
> 
> > + *
> > + * This converts the raw ADC value to mcelsius using the SoC specific
> > + * calibration constants
> > + */
> > +static int raw_to_mcelsius(struct mtk_thermal *mt, u32 raw)
> > +{
> > +       s32 format_1, format_2, format_3, format_4;
> 
> The formula would be easier to follow with better variable names than
> "format_X".
> 
> > +       s32 xtoomt;
> 
> What does "xtoomt" mean?
> 
> > +       s32 gain;
> > +
> > +       raw &= 0xfff;
> > +
> > +       gain = (10000 + mt->adc_ge);
> 
> no outer ()
> 
> > +
> > +       xtoomt = ((((mt->vts + 3350 - mt->adc_oe) * 10000) / 4096) * 10000) /
> > +               gain;
> > +
> > +       format_1 = ((mt->degc_cali * 10) >> 1);
> 
> When doing computations, I think "A / 2" is preferred over "A >> 1".
> Also, no outer ().
> 
> > +       format_2 = (raw - mt->adc_oe);
> > +       format_3 = (((((format_2) * 10000) >> 12) * 10000) / gain) - xtoomt;
> 
> This is just:
>   format_3 = ((((raw - mt->vts - 3350) * 10000) / 4096) * 10000) / gain;
> 
> No wonder mt->adc_oe = 512-512 = 0... it just cancels itself out here, anyway.
> 
> > +       format_3 = format_3 * 15 / 18;
> 
> Of course we should multiply by 15/18!
> What is going on here?  Why this magic 5/6 ratio?
> 
> > +       format_4 = ((format_3 * 100) / (165 + mt->o_slope));
> 
> no outer ()
> 
> > +       format_4 = format_4 - (format_4 << 1);
> 
> Hmm...
>  A = X - 2*X;
> otherwise known as:
>  A = -X;
> 
> > +       return (format_1 + format_4) * 100;
> 
> Or just:
>   return (format_1 - format_4) * 100;

I must admit I took this calculation from the original driver and never
looked at it. Simplifying this further this goes down to:

static int raw_to_mcelsius(struct mtk_thermal *mt, u32 raw)
{
	return mt->calib_b + mt->calib_a * (raw & 0xfff);
}

with calib_a = -123 and calib_b = 465124.

I'll address this and the other comments in v2.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
