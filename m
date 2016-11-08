From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Wed, 09 Nov 2016 07:38:36 +1100
Message-ID: <87vavxn1v7.fsf@notabene.neil.brown.name>
References: <cover.1476780088.git.baolin.wang@linaro.org> <CAMz4ku+5=LebdDB9waDD8GYQmYM=uxuOqN6hYZ+E1HSALa1GMQ@mail.gmail.com> <87k2cttptn.fsf@notabene.neil.brown.name> <CAMz4kuJPenbqf935EGW67UeqOiP48_Ti1Jf5YfJ_K=DEcrz++Q@mail.gmail.com> <87a8dls7yn.fsf@notabene.neil.brown.name> <CAMz4kuJdp+ijur_mDjcG3aghn8Q1gnJsTfFWBEiKWcdVQPMj7g@mail.gmail.com> <871sytqrqh.fsf@notabene.neil.brown.name> <20161108084133.GA12276@b29397-desktop>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59593 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932329AbcKHUi4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Nov 2016 15:38:56 -0500
In-Reply-To: <20161108084133.GA12276@b29397-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08 2016, Peter Chen wrote:

> On Thu, Nov 03, 2016 at 12:25:42PM +1100, NeilBrown wrote:
>>=20
>>=20
>>=20
>> 2/ Change all usb phys to register an extcon and to send appropriate
>>    notifications.  Many already do, but I don't think it is universal.
>>    It is probable that the extcon should be registered using common code
>>    instead of each phy driver having its own
>>    extcon_get_edev_by_phandle()
>>    or whatever.
>>    If the usb phy driver needs to look at battery charger registers to
>>    know what sort of cable was connected (which I believe is the case
>>    for the chips you are interested in), then it should do that.
>
> Not only USB PHY to register an extcon, but also for the drivers which
> can detect USB charger type, it may be USB controller driver, USB type-c
> driver, pmic driver, and these drivers may not have an extcon device
> since the internal part can finish the vbus detect.

Can you point to an example of the sort of hardware/driver you are
referring to, preferably in the mainline kernel.  Concrete examples make
this sort of thing much easier to understand.

I think I would argue that if some piece of hardware can detect the USB
charger type, then that piece of hardware is part of the "USB PHY", even
if the hardware manufacturer has chosen to partition the register set in
a way which doesn't make that obvious.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYIjfMAAoJEDnsnt1WYoG5HP8P/3IBkoGhYReqGAJBR9SCJDAA
i9pI57WGiObpJFi2LE/QXmT+fYCNsO3pdo63ZdaM2txEfyGMzkt5yIoHdxBs1arA
oZtCIIA+XgqAdjs7TThGgvcNpIl7dOOEklElCocH/k4UcoLldQ4SJFY389sIZbhR
vboJuEibRB0cD/ydKvZkjDSL5VZyHzOHUij+nz1gtznqlko2yfppVDVzVsE/cVRx
VUX+gAn/sLME+kKp/SNvJEUM6SDocYZXefIwVvZK+13VTmb3px8GrEgs8P0rrYy7
a36osZswY1Rl5EJATvJNfi5EQFb/iugzaHR4+KNLLALx8G/ZnCRk5lGFPthcvgRc
7SG+JvohxPUKiDL9M7DXbh+mw0zH9bq3mtRwCXpmWFA/CHtvwYNNuMWLhovsCgoA
zRzVetvMbTKhXTFk/bvJX3BWhfkqclHfSxP2GXRp9rradLqvmSl66RoixJ9uRvLl
AKT/a0LTV38U8zkFQ1A2dKrNFfmD1Aqpc3rpMeTjy+dPXj9qSyDMQkfdL5vOajvw
6RZLswTsVLkKpsCB02eywo5XqzeTJOgD/rHAVRRrCoNgfhP3+Ka4nMOVsB7AghjX
KdmWHKxsHORoblGpSD7v6ZA/Ft2TC923dlszKjYeTusU1Fja+YIpEUI8MEo6h6t5
8C+7zSCfww1Hkv82gOPV
=lT8y
-----END PGP SIGNATURE-----
--=-=-=--
