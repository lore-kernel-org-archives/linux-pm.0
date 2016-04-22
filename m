From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 7/9] thermal: of: Add support for hardware-tracked trip
 points
Date: Fri, 22 Apr 2016 07:41:47 +0200
Message-ID: <20160422054147.GI21638@pengutronix.de>
References: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
 <1460950562-20652-8-git-send-email-wxt@rock-chips.com>
 <20160420234818.GB2558@localhost.localdomain>
 <20160421011230.GA118377@google.com>
 <5719844B.3040703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34022 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753882AbcDVFl4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 01:41:56 -0400
Content-Disposition: inline
In-Reply-To: <5719844B.3040703@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <caesar.upstream@gmail.com>
Cc: Brian Norris <briannorris@chromium.org>, Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, huangtao@rock-chips.com, Wei Ni <wni@nvidia.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dianders@chromium.org, linux-rockchip@lists.infradead.org, eddie.cai@rock-chips.com, smbarber@google.com, Paul Walmsley <pwalmsley@nvidia.com>, Zhang Rui <rui.zhang@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Caesar Wang <wxt@rock-chips.com>

On Fri, Apr 22, 2016 at 09:54:19AM +0800, Caesar Wang wrote:
> Hi Brian, Eduardo, Sascha
>=20
> =E5=9C=A8 2016=E5=B9=B404=E6=9C=8821=E6=97=A5 09:12, Brian Norris =E5=
=86=99=E9=81=93:
> >+ Sascha
> >
> >On Wed, Apr 20, 2016 at 04:48:18PM -0700, Eduardo Valentin wrote:
> >>On Mon, Apr 18, 2016 at 11:35:59AM +0800, Caesar Wang wrote:
> >>>From: Mikko Perttunen <mperttunen@nvidia.com>
> >>>
> >>>This adds support for hardware-tracked trip points to the device t=
ree
> >><cut>
> >>
> >>>diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> >>>index 97b86c5..6ef932a 100644
> >>>--- a/include/linux/thermal.h
> >>>+++ b/include/linux/thermal.h
> >>>@@ -335,12 +335,14 @@ struct thermal_genl_event {
> >>>   * @get_trend: a pointer to a function that reads the sensor tem=
perature trend.
> >>>   * @set_emul_temp: a pointer to a function that sets sensor emul=
ated
> >>>   *		   temperature.
> >>>+ * @set_trips: a pointer to a function that set low/high trip tem=
perature.
> >>>   */
> >>>  struct thermal_zone_of_device_ops {
> >>>  	int (*get_temp)(void *, int *);
> >>>  	int (*get_trend)(void *, long *);
> >>>  	int (*set_emul_temp)(void *, int);
> >>>  	int (*set_trip_temp)(void *, int, int);
> >>>+	int (*set_trips)(void *, int, int);
> >>This is unfortunately a diverges from API available on thermal core=
=2E Can
> >>you please add first on thermal core then, use it in of thermal?
> >>
> >>I don't want to have callbacks available only via of thermal. If we
> >>allow it, OF thermal becomes a separate API.
> >What ever happened to this effort?
> >
> >http://thread.gmane.org/gmane.linux.power-management.general/59451
> >
> >Patch 12 and 13 look to accomplish something similar, yet they do wh=
at
> >Eduardo suggested. I was testing that series at my previous job, but
> >unfortunately (for the fate of this series) I left that employer bef=
ore
> >I could finish reviewing and testing it. Perhaps Caesar can resurrec=
t
> >and test it?
>=20
> @Brian
> Yes, I can
>=20
> Sure, I can.
>=20
> I see the Sascha's newest thermal patches in patchwork.
> The following patches are still needed, right?
>=20
> 6446191 New          [06/16] thermal: inline only once used function
> 6446111 New          [07/16] thermal: streamline get_trend callbacks
> 6445871 New          [08/16] thermal: Allow sensor ops to fail with -=
ENOSYS
> 6445861 New          [09/16] thermal: of: always set sensor related
> callbacks
> 6446221 New          [10/16] thermal: Make struct thermal_zone_device=
_ops
> const
> 6446201 New          [11/16] thermal: bang-bang governor: act on lowe=
r trip
> boundary
> 6445891 New          [12/16] thermal: thermal: Add support for
> hardware-tracked trip points
> 6445911 New          [13/16] thermal: of: implement .set_trips for de=
vice
> tree thermal zones
>=20
> @Sascha, Eduardo
> Can you share your discussion content for the above patches as rememb=
ered?

These are still the newest patches. I won't have any resources in the
near future for continuing the work on them, so feel free to pick them
up. There hasn't been much discussion around these patches which was th=
e
reason I abandoned them.

Sascha


--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
