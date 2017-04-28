From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/2] thermal: broadcom: Allow for NSP to use ns-thermal
 driver
Date: Fri, 28 Apr 2017 06:07:02 -0700
Message-ID: <20170428130659.GA28546@localhost.localdomain>
References: <1493153351-12698-1-git-send-email-jon.mason@broadcom.com>
 <1493153351-12698-2-git-send-email-jon.mason@broadcom.com>
 <20170427163658.GC18276@localhost.localdomain>
 <CAC3K-4pr4LY-9unHNxMDN9YmCYHKekUo66813OUdiKkQH4QzVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36764 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164260AbdD1NHH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Apr 2017 09:07:07 -0400
Content-Disposition: inline
In-Reply-To: <CAC3K-4pr4LY-9unHNxMDN9YmCYHKekUo66813OUdiKkQH4QzVw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Mason <jon.mason@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 01:42:25PM -0400, Jon Mason wrote:
> On Thu, Apr 27, 2017 at 12:37 PM, Eduardo Valentin <edubezval@gmail.com> =
wrote:
> > Hey Jason,
>=20
> It's Jon :)

Apologies. I think I either read too fast, or my fingers were faster
than my brain. Sorry.

>=20
> >
> > On Tue, Apr 25, 2017 at 04:49:10PM -0400, Jon Mason wrote:
> >> Change the iProc Kconfig to select THERMAL and THERMAL_OF, which allows
> >> the ns-thermal driver to be selected via menuconfig.  Also, change the
> >> ns-thermal driver to work on any iProc based SoC.  Finally, tweak the
> >> Kconfig description to mention support for NSP and make the default on
> >> for iProc based platforms.
> >
> >
> > Thanks for the patch, but..
> >>
> >> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> >> ---
> >>  arch/arm/mach-bcm/Kconfig        | 2 ++
> >>  drivers/thermal/broadcom/Kconfig | 9 +++++----
> >>  2 files changed, 7 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> >> index a0e66d8..da2bfeb 100644
> >> --- a/arch/arm/mach-bcm/Kconfig
> >> +++ b/arch/arm/mach-bcm/Kconfig
> >> @@ -19,6 +19,8 @@ config ARCH_BCM_IPROC
> >>       select GPIOLIB
> >>       select ARM_AMBA
> >>       select PINCTRL
> >> +     select THERMAL
> >> +     select THERMAL_OF
> >>       help
> >>         This enables support for systems based on Broadcom IPROC archi=
tected SoCs.
> >>         The IPROC complex contains one or more ARM CPUs along with com=
mon
> >
> > It would be better if this is split and sent through your arch tree, to
> > avoid conflicts. I could also pick it if you get an ack from one of your
> > maintainers. Still, first option is preferable.
>=20
> Sure, I'll be happy to split this off.  I should've thought to split
> it up before sending.  Thanks for the suggestion.

Cool!

>=20
> >
> >> diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadc=
om/Kconfig
> >> index f0dea8a..26d706c 100644
> >> --- a/drivers/thermal/broadcom/Kconfig
> >> +++ b/drivers/thermal/broadcom/Kconfig
> >> @@ -1,8 +1,9 @@
> >>  config BCM_NS_THERMAL
> >>       tristate "Northstar thermal driver"
> >>       depends on ARCH_BCM_IPROC || COMPILE_TEST
> >> +     default ARCH_BCM_IPROC
> >
> > Not sure if this is really what you wanted. Based on your commit log
> > message, you meant the following, perhaps?
> >
> >  +      default y if ARCH_BCM_IPROC
>=20
> IIUC, my original default works, as we have used it frequently in
> other places in the kernel.
> grep -rI "default ARCH_BCM_IPROC" * | wc -l
> 15

Yeah... Are you sure they are all correct?

>=20
> However, if the above is preferred (or the other 15 massively broken),
> I'll be happy to do it that way.

Your construction is syntactically correct. Maybe might still work (did
not check myself) for the purpose you describe, but the construction
mentioned in Documentation/kbuild/kconfig-language.txt is:
 +      default y if BAR

So, please fix it.


>=20
>=20
> >>       help
> >> -       Northstar is a family of SoCs that includes e.g. BCM4708, BCM4=
7081,
> >> -       BCM4709 and BCM47094. It contains DMU (Device Management Unit)=
 block
> >> -       with a thermal sensor that allows checking CPU temperature. Th=
is
> >> -       driver provides support for it.
> >> +       Support for the Northstar and Northstar Plus family of SoCs (e=
=2Eg.
> >> +       BCM4708, BCM4709, BCM5301x, BCM95852X, etc). It contains DMU (=
Device
> >
> > Did we look BCM47094 somehow on this patch?
>=20
> Naa, just trying to be more concise, while adding the NSP products to
> the list..  BCM47094 is a type of BCM4709.  So, it is still there :)
>=20
> >
> >> +       Management Unit) block with a thermal sensor that allows check=
ing CPU
> >> +       temperature.
> >> --
> >> 2.7.4
> >>

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZAz5tAAoJEA6VkvSQfF5TygYQAJYs4SLgvcrNM71a01rSAEky
V3wxTfn6pmHFDzvy46Ur4+Z3NBXYZmdt563W6EpH9BSe2D0F49K/MS4L8Jwyko1D
nNhloOHSHo8b81TvUSag358WToS7VJPak5Ccn6PzmXTxgWEtV6MJ/rI8/L8MVZ17
87q/Qrkb2xy4r8zsIc0EFg7+TNMg61ZBAkqkCA81ivhp87JebTlbhNefR1a6nvZg
27kyCkQHC+0EcuVo6khZ3CczANCBgRBAsUc+0XHeCp5SKKz59Q4HQ1gJIrLJMls8
dzDHsf7I4XjOru1QNxVp7r0vl0nJDAQMqW53ei/AG4t5qhZZozCOLmtOSJi4q6B4
zrZ986Wm5FXIt+ccS/E6QkPV2424Wuoi3tgrT7RddGi0Ad9eR4i9dGzpD7V3Cx4P
YskIWANleFqOeCrCOPI0PDHwky2eOMgnhKm3oBwczeKhCbDyIlLodGCwj1daK3Fp
arSl1M+cJP4SWQGKFnVAU11dgdXGvsqhYFBJW6j3lhOFqnVlKDqNXuO4lV+VZOzK
Z4MDchFFgs2sQBli4pcUzsFqQJbbUGf7fgelZfLRBQQIEEAdxUuns8u4idmuTVVh
dnO4zNKAo9wRyaA06cRHYCYXih5Bj9QyQkTi6FmObnmHKZWey87r3TLmm/6Y0lK6
jXF0dBNRadu7AwL7uhSx
=Poky
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
