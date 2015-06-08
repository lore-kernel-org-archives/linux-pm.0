From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4] Thermal cleanups and hardware trip points
Date: Mon, 8 Jun 2015 08:56:57 +0200
Message-ID: <20150608065657.GL26575@pengutronix.de>
References: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37360 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbbFHG5E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 02:57:04 -0400
Content-Disposition: inline
In-Reply-To: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, linux-kernel@vger.kernel.org, Mikko Perttunen <mikko.perttunen@kapsi.fi>, linux-mediatek@lists.infradead.org, kernel@pengutronix.de, Brian Norris <computersforpeace@gmail.com>, linux-arm-kernel@lists.infradead.org

Eduardo, Rui,

Any feedback to this series?

Thanks
  Sascha

On Wed, May 20, 2015 at 03:20:30PM +0200, Sascha Hauer wrote:
> This series adds support for hardware trip points. It picks up earlier
> work from Mikko Perttunen. Mikko implemented hardware trip points as part
> of the device tree support. It was suggested back then to move the
> functionality to the thermal core instead of putting more code into the
> device tree support. This series does exactly that.
> 
> The majority of the patches are cleanups and fixes. Patch 11 introduces
> hardware tracked trip points and finally a driver for the Mediatek
> thermal controller is introduced as the first user.
> 
> All comments welcome
> 
> Changes since v3:
> - Fix some missing function type changes in int3400_thermal.c,
>   processor_thermal_device.c, kirkwood_thermal.c and exynos_tmu.c
> - Add better description for set_trips callback
> - update the interrupt triggers also when the trip points change
> - Add missing MODULE_* tags
> - Broaden temperature range in the Mediatek driver so that we can be sure
>   the measured temperatures are really out of the desired range
> 
> Changes since v2:
> - Add Mediatek thermal controller driver as first user for hardware trip
>   points
> 
> Changes since v1:
> - Use int instead of unsigned long consistently for temperatures
> - Instead of misfixing the emulation code add a comment how the
>   code is meant
> - Add doc entry for .set_trips callback
> - initialize prev_low_trip/prev_high_trip properly
> - get tz->lock before calling thermal_zone_set_trips()
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
