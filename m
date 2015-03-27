From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 04/13] thermal: Fix not emulating critical temperatures
Date: Fri, 27 Mar 2015 06:23:18 +0100
Message-ID: <20150327052318.GO9742@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-5-git-send-email-s.hauer@pengutronix.de>
 <CADGdYn5vaPu4+yhjs5c3QuCnz-LtL2Z2qRENjsizpO6D1gVOSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57893 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbbC0FX1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Mar 2015 01:23:27 -0400
Content-Disposition: inline
In-Reply-To: <CADGdYn5vaPu4+yhjs5c3QuCnz-LtL2Z2qRENjsizpO6D1gVOSg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: amit daniel kachhap <amit.daniel@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, LAK <linux-arm-kernel@lists.infradead.org>

Hi Amit,

On Fri, Mar 27, 2015 at 08:35:50AM +0530, amit daniel kachhap wrote:
> Hi Sascha,
> 
> > -#ifdef CONFIG_THERMAL_EMULATION
> > -       if (!tz->emul_temperature)
> > -               goto skip_emul;
> > -
> > -       for (count = 0; count < tz->trips; count++) {
> > -               ret = tz->ops->get_trip_type(tz, count, &type);
> > -               if (!ret && type == THERMAL_TRIP_CRITICAL) {
> > -                       ret = tz->ops->get_trip_temp(tz, count, &crit_temp);
> > -                       break;
> > -               }
> > -       }
> > -
> > -       if (ret)
> > -               goto skip_emul;
> >
> > -       if (*temp < crit_temp)
> I guess this check is confusing. Actually instead of returning
> emulating temperature it is returning actual temperature. But the
> important thing to look here is that actual temperature is higher than
> critical temperature. So this check prevents the user from suppressing
> the critical temperature and hence prevents from burning up the chip.

Indeed the check is confusing, but now it makes perfectly sense. I'll
look at the patch again and maybe turn into a patch just adding a
comment to clarify this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
