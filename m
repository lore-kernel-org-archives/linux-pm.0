From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 5/7] power: supply: bq24190_charger: Don't spam the
 logs on charger plug / unplug
Date: Fri, 24 Mar 2017 10:25:21 +0100
Message-ID: <20170324092521.pnb3pcvrtub5glit@earth>
References: <20170322145536.30570-1-hdegoede@redhat.com>
 <20170322145536.30570-6-hdegoede@redhat.com>
 <CAKvHMgQdccLPDz2HyxopdDgQxk+6DMtBrvFxKD--wxLPfe5DQQ@mail.gmail.com>
 <07ee304f-f86d-ae79-8bda-9f0538db11c7@redhat.com>
 <CAKvHMgQP_hZCt+-U85MCJfjoxf6muKrks2V+B52JQx8WCWcqyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rqcms65lhfy44xez"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965497AbdCXJZj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Mar 2017 05:25:39 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgQP_hZCt+-U85MCJfjoxf6muKrks2V+B52JQx8WCWcqyw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>


--rqcms65lhfy44xez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 23, 2017 at 03:24:15PM -0700, Liam Breck wrote:
> On Thu, Mar 23, 2017 at 3:02 PM, Hans de Goede <hdegoede@redhat.com> wrot=
e:
> > On 23-03-17 22:31, Liam Breck wrote:
> >> On Wed, Mar 22, 2017 at 7:55 AM, Hans de Goede <hdegoede@redhat.com>
> >> wrote:
> >>>
> >>> If the charger gets unplugged before the battery is fully charged we =
will
> >>> get a one time Input fault. Ignore this rather then logging a message=
 for
> >>> it. Likewise on the next interrupt after the one time Input fault all
> >>> fault flags will be 0, do not log a message when there are no faults.
> >>>
> >>> This fixes messages like these getting logged on charger unplug + rep=
lug:
> >>> bq24190-charger 15-006b: Fault: boost 0, charge 1, battery 0, ntc 0
> >>> bq24190-charger 15-006b: Fault: boost 0, charge 0, battery 0, ntc 0
> >>>
> >>> Cc: Liam Breck <kernel@networkimprov.net>
> >>> Cc: Tony Lindgren <tony@atomide.com>
> >>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>> ---
> >>> Changes in v2:
> >>> -This is a new patch in v2 of this patch-set
> >>> ---
> >>>  drivers/power/supply/bq24190_charger.c | 17 +++++++++++------
> >>>  1 file changed, 11 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/power/supply/bq24190_charger.c
> >>> b/drivers/power/supply/bq24190_charger.c
> >>> index b535f24..351e020 100644
> >>> --- a/drivers/power/supply/bq24190_charger.c
> >>> +++ b/drivers/power/supply/bq24190_charger.c
> >>> @@ -1189,12 +1189,17 @@ static void bq24190_check_status(struct
> >>> bq24190_dev_info *bdi)
> >>>         } while (f_reg && ++i < 2);
> >>>
> >>>         if (f_reg !=3D bdi->f_reg) {
> >>> -               dev_info(bdi->dev,
> >>> -                       "Fault: boost %d, charge %d, battery %d, ntc
> >>> %d\n",
> >>> -                       !!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
> >>> -                       !!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
> >>> -                       !!(f_reg & BQ24190_REG_F_BAT_FAULT_MASK),
> >>> -                       !!(f_reg & BQ24190_REG_F_NTC_FAULT_MASK));
> >>> +               /*
> >>> +                * Don't spam the logs if all faults are cleared, or =
when
> >>> the
> >>> +                * cable providing Vbus gets unplugged.
> >>> +                */
> >>> +               if  (f_reg && f_reg !=3D (1 <<
> >>> BQ24190_REG_F_CHRG_FAULT_SHIFT))
> >>
> >>
> >> if (f_reg && ((ss_reg & BQ24190_REG_SS_PG_STAT_MASK) ||
> >>     f_reg !=3D (1 << BQ24190_REG_F_CHRG_FAULT_SHIFT)) )
> >
> >
> > Sebastian has already merged the original patch into his for-next branc=
h,
> > please
> > provide a patch on top.
>=20
> I recall Sebastian merging and then dropping a commit from the other
> series I'm working on.

Yeah, I thought it was a fix, but it was useless without the
remaining series.

> I'll return to the charger once the dependency for my charger patchset
> is merged. I just got a big change request for that.

Ok.

>=20
> >>> +                       dev_info(bdi->dev,
>=20
> This should probably be dev_warn now.

makes sense to me.

FWIW I think a follow-up commit for this is enough, but I can also
swap the existing commit.

-- Sebastian

> >>> +                               "Fault: boost %d, charge %d, battery =
%d,
> >>> ntc %d\n",
> >>> +                               !!(f_reg &
> >>> BQ24190_REG_F_BOOST_FAULT_MASK),
> >>> +                               !!(f_reg &
> >>> BQ24190_REG_F_CHRG_FAULT_MASK),
> >>> +                               !!(f_reg & BQ24190_REG_F_BAT_FAULT_MA=
SK),
> >>> +                               !!(f_reg &
> >>> BQ24190_REG_F_NTC_FAULT_MASK));
> >>>
> >>>                 mutex_lock(&bdi->f_reg_lock);
> >>>                 if ((bdi->f_reg & battery_mask_f) !=3D (f_reg &
> >>> battery_mask_f))
> >>> --
> >>> 2.9.3
> >>>
> >

--rqcms65lhfy44xez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljU5gAACgkQ2O7X88g7
+pqGrA//ZU5TN5yE5kVbV6moNSltisZ86kBsAdWOO+KQQPrkuEB5adKdJ/s5lFml
LRxA2qWFd6dMZ63WNWxmNQNeCZ7yrSWRo6Vv7E9TDb5w7ZFjsq0gY2g1/6V8TAyU
RCawG1Xy2/mvOleKjzbEPPMjORMNZ64ArwpMwJrdNBALqQbvLtAqz0ArywW+u8Cn
OFlCrmobPselxMWYmOxYZKBe5yaBxAL0WWw2bARr/8+S/aMRqu/LWTZnFwqOA3Fl
ZzhIC6avhsFIIHvlcJ17tv31zjzsELoZZtHlBplK+KMiaugsXPWRG5t+DI14GAsi
9legr/OPs2a/qHoLWBtAiorZvvnQBJ3XXXRszYUeNTM/pqFQhBRw0c+3G0sFrNga
0NEpnBhzDuHxSlx0LE7tFRVwkzphD4GTwxnh4rVa5c8YkZ2IWTEKNNoQNMu2UKdB
OrcKKrZhgNl7gcrem9WfVzDAS9TRtq8Tf5t3xtGTLqMLmmn00YiqdfwR0xcZZxH4
IQxQxVyXuHfA06ayPmhRzWGjekQ0XgHQDggek7UphXPMhczWyQLwAg02E0gEeQGu
VOaFrlEwyrid4UsucjQeNNrKx+3K7f4/v1rLlokOat5dATHGB+zfS3gspNh1ViEv
i7RUsu6agY/ZuqN6htN7cW3Bj1OyELyD5793Czc/3W9hoNhe4/Q=
=rXsr
-----END PGP SIGNATURE-----

--rqcms65lhfy44xez--
