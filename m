From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Fri, 21 Aug 2015 07:06:28 +0200
Message-ID: <20150821050628.GU18700@pengutronix.de>
References: <1440057962-13373-1-git-send-email-s.hauer@pengutronix.de>
 <1440057962-13373-3-git-send-email-s.hauer@pengutronix.de>
 <20150820222039.GA6708@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41515 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbbHUFGd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2015 01:06:33 -0400
Content-Disposition: inline
In-Reply-To: <20150820222039.GA6708@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>

On Thu, Aug 20, 2015 at 03:20:52PM -0700, Eduardo Valentin wrote:
> On Thu, Aug 20, 2015 at 10:06:01AM +0200, Sascha Hauer wrote:
> > +
> > +	/*
> > +	 * These calibration values should finally be provided by the
> > +	 * firmware or fuses. For now use default values.
> > +	 */
> > +	mt->calib_slope = -123;
> > +	mt->calib_offset = 465124;
> 
> Would it make sense to use the coefficients device tree property to
> describe the sensor slope and offset?
> 

The values shall ultimately be stored in fuses in the SoC. The current
bootloader cannot convert these values into device tree properties. Also
there is the new nvmem framework landing. This will allow us to put a
description into the device tree where in the fuses the calibration
values are found, rather than putting the calibration values themselves
into the device tree. This all needs some discussion and work, so I left
this topic for later.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
