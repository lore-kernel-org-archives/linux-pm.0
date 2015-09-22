From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: bq24261_charger: Add support for TI BQ24261
 charger
Date: Tue, 22 Sep 2015 17:37:25 +0200
Message-ID: <20150922153725.GA4235@earth>
References: <1441560187-23611-1-git-send-email-ramakrishna.pallala@intel.com>
 <CAJKOXPfDu+LxoiQrV+CsqUbEVwYb1Zmk-m9y-L_1JxrB6ouS0g@mail.gmail.com>
 <D854C92F57B1B347B57E531E78D05EAD57904B8D@BGSMSX104.gar.corp.intel.com>
 <55F0C522.6070705@samsung.com>
 <55F1B2FD.4020608@ti.com>
 <55F22740.4080003@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55F22740.4080003@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "Andrew F. Davis" <afd@ti.com>, "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Tc, Jenny" <jenny.tc@intel.com>, Andreas Dannenberg <dannenberg@ti.com>
List-Id: linux-pm@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 11, 2015 at 09:58:40AM +0900, Krzysztof Kozlowski wrote:
> On 11.09.2015 01:42, Andrew F. Davis wrote:
> > On 09/09/2015 06:47 PM, Krzysztof Kozlowski wrote:
> >>>>> +- ti,enable-user-write: boolean, if present driver will allow the
> >>>>> user space
> >>>>> +    to control the charging current and voltage through sysfs;
> >>>>
> >>>> This is not DT property. It does not describe hardware.
> >>> We needed a mechanism to enable the sysfs writes on certain propertie=
s.
> >>> If DT is not the place where should it go?
> >>
> >> DT is not the place. As I discussed later with Andreas, if you really
> >> need this and if mainline is a place for that then probably this should
> >> be compile option (a Kconfig symbol).
> >>
> >=20
> > I think this would actually be a good use for module parameters, this w=
ay
> > it could still be set at boot without re-compiling.
> >=20
> > I think compile-time disabling sysfs properties because they are
> > "dangerous" is
> > a little bit too artificially restricting and controlling, you can set
> > permissions
> > so only root can change them already. The kernel should not be
> > restricting root,
> > I understand the fear of someone rooting a machine and remotely over
> > charging
> > a LiPo[1], but these physical limits are hardware descriptions and can
> > and should
> > be set by DT, beyond this root should have full control over their mach=
ine.
>=20
>=20
> Indeed module parameters could be used for enabling/disabling debug
> options... but as fair as I understand these are for purely development
> purposes. That is why they got into DT initially, right? To allow the
> developer to play with it on the development board?
>=20
> This is why I am really not convinced that this should go to mainline.
>=20
> Anyway if it goes, then maybe compiling it out is the safest choice?
> What's the purpose of having it in kernel all the time? If this was a
> debug option, than some experienced user could turn it on and report to
> LKML with extended debug data. But it's not a debug but development optio=
n?

Changing the current limit is useful for "expert" users with custom
usb power supplies, that are not correctly detected by extcon. I
also think a module parameter would be the best option here.

-- Sebastian

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAXWyAAoJENju1/PIO/qalAUP/iQ8j956h3v2LOgMF4BPIZKx
s0vtTW9Bf/PvtJFzhEKzdDxW12ZFyqgUS3gk9GJssP9rr65fBvzEripZqmP6lDzz
A7fm3vEGVsrmvIMDdk08ll2GLKs7TsFfcz+DKIvriuHba4v4yys8G9sM/p1Zm6WI
ZI4eNbKv/7kf64U+rB1rQHoHi6zzXkq2pdKWkrzPh3h5evkBqQPYlNJ2t13plh93
p+nGMfPPRG7HGP06o89ZScF+sRzGgGM5f1Pin3t3rESwbBDjNYMpLiZwpzqpclBX
GlRJhq5mj7Xe4FTprPHQTqGu8pYQYaXUxToZvDqxp7iNR5SImxofLptMFL+XIg/4
BrjvaO6yjczdJlO8WochXcLL3s0OOjPHyLYZOrrQ3DyIzid6uihiOFbbvu51qXHE
pQq9HbQZuwnnEFl6T+XI+49ZPFCGMsMmQM/BgN0RuKI/b89tOeCiKpKR7fCFGS8D
DM4RyEanAWUYmpD+ZcPlo9U31h6fAPlSkNpDl6GAzzfeQ3z25ILuM+HSUquzbl9N
PntM6HhfrdD0Ie7QDywVhRs78kGpJdfP3z+HKtObKKrs+11k3WD0EV2eceJVdUEV
S7cHbfFn3CDG32FFsndCCQ1D2YkslCJ1E0Fq8Z4jGTB7raaW9VcfWEFZbzLfq4aK
hbiQUBDf5hv3RM3+cKnN
=BCk3
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
