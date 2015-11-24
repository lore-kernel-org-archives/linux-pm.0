From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Tue, 24 Nov 2015 08:53:07 +0100
Message-ID: <20151124075307.GZ11966@pengutronix.de>
References: <1447835066-10482-1-git-send-email-s.hauer@pengutronix.de>
 <1447835066-10482-3-git-send-email-s.hauer@pengutronix.de>
 <1448345169.2421.20.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36766 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbbKXHxO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2015 02:53:14 -0500
Content-Disposition: inline
In-Reply-To: <1448345169.2421.20.camel@mtksdaap41>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dawei chien <dawei.chien@mediatek.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org

On Tue, Nov 24, 2015 at 02:06:09PM +0800, dawei chien wrote:
> Hi Sascha,
> 
> > +static int mtk_thermal_get_calibration_data(struct device *dev, struct mtk_thermal *mt)
> > +{
> > +	struct nvmem_cell *cell;
> > +	u32 *buf;
> > +	size_t len;
> > +	int i, ret;
> > +	/* Start with default values */
> > +	mt->adc_ge = 512;
> > +	for (i = 0; i < MT8173_NUM_SENSORS; i++)
> > +		mt->vts[i] = 260;
> > +	mt->degc_cali = 40;
> > +	mt->o_slope = 0;
> > +
> > +	cell = nvmem_cell_get(dev, "calibration-data");
> > +	if (IS_ERR(cell)) {
> > +		if (PTR_ERR(cell) == -EPROBE_DEFER)
> > +			return PTR_ERR(cell);
> > +		return 0;
> > +	}
> > +
> > +	buf = (u32 *)nvmem_cell_read(cell, &len);
> > +
> > +	nvmem_cell_put(cell);
> > +
> > +	if (IS_ERR(buf))
> > +		return PTR_ERR(buf);
> > +
> > +	if (len < 3 * sizeof(u32)) {
> > +		dev_warn(dev, "invalid calibration data\n");
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> 
> ret would not be assigned if the length of calibration data is correct.
> Otherwise,

gcc does a increasingly bad job when it comes to warn about
uninitialized variables :(

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
