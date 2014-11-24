From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/2] of: Rename "poweroff-source" property to
 "system-power-controller"
Date: Mon, 24 Nov 2014 10:24:56 +0000
Message-ID: <20141124102456.GE4241@x1>
References: <1415885699-1465-1-git-send-email-user@radxa>
 <1415885699-1465-2-git-send-email-user@radxa>
 <20141121105951.GA20679@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:47814 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbaKXKZE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Nov 2014 05:25:04 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so3072493iga.8
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2014 02:25:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141121105951.GA20679@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Auto Configured <romain.perier@gmail.com>, Mark Brown <broonie@kernel.org>, heiko@sntech.de, grant.likely@linaro.org, robh@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, mark.rutland@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com

On Fri, 21 Nov 2014, Johan Hovold wrote:

> On Thu, Nov 13, 2014 at 01:34:58PM +0000, Auto Configured wrote:
> > From: Romain Perier <romain.perier@gmail.com>
> >=20
> > It reverts commit a4b4e0461ec5 ("of: Add standard property for powe=
roff capability").
> > As discussed on the mailing list, it makes more sense to rename bac=
k to the
> > old established property name, without the vendor prefix. Problem b=
eing that
> > the word "source" usually tends to be used for inputs and that is o=
ut of control
> > of the OS. The poweroff capability is an output which simply turns =
the
> > system-power off. Also, this property might be used by drivers whic=
h power-off
> > the system and power back on subsequent RTC alarms. This seems to s=
uggest to
> > remove "poweroff" from the property name and to choose "system-powe=
r-controller"
> > as the more generic name. This patchs adds the required renaming ch=
anges and
> > defines an helper function which is compatible with both properties=
, the old one
> > which was only used by tps65910 and the new one without vendor-pref=
ix.
>=20
> Now this is a bit of a mess.
>=20
> There's a commit in the mfd tree, 25f833c1171d ("mfd: tps65910: Conve=
rt
> ti,system-power-controller DT property to poweroff-source"), which
> breaks all dts using tps65910 since these are never updated to the no=
w
> retracted property name ("poweroff-source").

My word!

Romain, what conversation on the MLs are you talking about?

> This one should simply be reverted ASAP.

No need to revert, I can just remove the patch from the MFD tree.

> > Signed-off-by: Romain Perier <romain.perier@gmail.com>
> > ---
> >  .../bindings/power/{poweroff.txt =3D> power-controller.txt}       =
 | 0
> >  .../devicetree/bindings/regulator/act8865-regulator.txt          |=
 4 ++--
> >  drivers/mfd/tps65910.c                                           |=
 9 ++++++++-
> >  drivers/regulator/act8865-regulator.c                            |=
 2 +-
> >  include/linux/of.h                                               |=
 6 +++---
> >  5 files changed, 14 insertions(+), 7 deletions(-)
>=20
> Romain, what tree is this patch against? The changes to the tps65910
> driver appears not to even be in the regulator tree, yet you asked Ma=
rk
> to merge this. And the MFD maintainer is not even on CC.
>=20
> Let's fix the breakage by reverting the offending commit in mfd. Then=
 the
> new standard name can be introduced in regulator alone (e.g. this pat=
ch
> without the tps65910 bits) as nothing outside of regulator should be
> using the new power-off feature (or binding) for act8865. Then other
> drivers and dts can be converted to use the new property name (while
> retaining backwards compatibility) for 3.20.
>=20
> [ We should probably also consider adding an "of_device_is_" prefix t=
o
> the helper name for consistency. ]
>=20
> Johan

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
