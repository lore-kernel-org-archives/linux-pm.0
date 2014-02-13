From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH] thermal: imx: update formula for thermal sensor
Date: Thu, 13 Feb 2014 20:09:22 +0100
Message-ID: <CA+gwMccQPxxi2N8wTb4ggK2LaaZk1vOS6RtnP_XfpgLgJyYrtw@mail.gmail.com>
References: <1392199595-1054-1-git-send-email-b20788@freescale.com>
	<20140213130252.GB20842@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:58309 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbaBMTJX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2014 14:09:23 -0500
Received: by mail-qa0-f43.google.com with SMTP id o15so16682196qap.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2014 11:09:22 -0800 (PST)
In-Reply-To: <20140213130252.GB20842@S2101-09.ap.freescale.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Anson Huang <b20788@freescale.com>, eduardo.valentin@ti.com, rui.zhang@intel.com, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

Hi,

On Thu, Feb 13, 2014 at 2:02 PM, Shawn Guo <shawn.guo@linaro.org> wrote=
:
>
> Copy LAKML and pengutronix folks in case they have comments.
>
> On Wed, Feb 12, 2014 at 06:06:35PM +0800, Anson Huang wrote:
> > Thermal sensor used to need two calibration points which are
> > in fuse map to get a slope for converting thermal sensor's raw
> > data to real temperature in degree C. Due to the chip calibration
> > limitation, hardware team provides an universal formula to get
> > real temperature from internal thermal sensor raw data:
> >
> > Slope =3D 0.4297157 - (0.0015976 * 25C fuse);

I have an i.MX6Q 1.2 with 1417 counts at 25=B0C and 1296 counts at 105=B0=
C fused.
Assuming that those values are fused correctly, with the old formula I =
get:

t1=3D25, n1=3D1417, t2=3D105, n2=3D1296
c1=3D1000*(t1-t2)/(n1-n2)=3D-662, c2=3D1000*t2-c1*n2=3D962952
T_meas=3Dc2+c1*N_meas=3D962952-662*N_meas

N_meas=3D1417 --> T_meas =3D 24898
N_meas=3D1296 --> T_meas =3D 105000

With the new formula, on the other hand, I would get:

t1=3D25, n1=3D1417
=460=3D10000000, F1=3D15976, 4297157
c1=3DF0*1000/(F1*n1-F2)=3D545, c2=3Dn1*c1+1000*25=3D797265
T_meas=3Dc2-N_meas*c1=3D797265-N_meas*545

N_meas=3D1417 --> T_meas =3D 25000
N_meas=3D1296 --> T_meas =3D 90945

That's off by over 14=B0C!

The default passive cooling trip point is at 85=B0C,
which translated to 1326 counts before:
alarm_value=3D(alarm_temp-c2)/c1=3D(85000-962952)/(-662)=3D1326

With the new formula the trip count is only
alarm_value=3D(c2-alarm_temp)/c1=3D(797265-85000)/545=3D1306
That translates to 98.4=B0C according to the old formula. I think
that is awfully close to the critical trip point at 100=B0C, which,
according to the old formula, corresponded to 1303 counts.

The new critical trip point for 100=B0C is at 1279 counts. According
to the old formula this corresponds to 116.2=B0C, well over the
rated maximum of 105=B0C.

Do I need to be afraid for my old silicon?

> > Update the formula, as there will be no hot point calibration
> > data in fuse map from now on.

I wonder if it would be better to keep using the high temperature
calibration point if it is fused at all.

regards
Philipp
