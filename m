From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH] power_supply: Fix documentation for TEMP_*ALERT*
 properties
Date: Mon, 28 Oct 2013 10:20:08 -0700
Message-ID: <20131028172008.GA29544@animalcreek.com>
References: <1382676798-27835-1-git-send-email-jonghwa3.lee@samsung.com>
 <20131025231720.GB9015@teo>
 <526DC554.30506@samsung.com>
 <20131028052743.GA31070@teo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from p3plsmtpa09-02.prod.phx3.secureserver.net ([173.201.193.231]:56587
	"EHLO p3plsmtpa09-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756841Ab3J1R0a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2013 13:26:30 -0400
Content-Disposition: inline
In-Reply-To: <20131028052743.GA31070@teo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anton Vorontsov <anton@enomsg.org>
Cc: jonghwa3.lee@samsung.com, linux-pm@vger.kernel.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, Ramakrishna Pallala <ramakrishna.pallala@intel.com>

On Sun, Oct 27, 2013 at 10:27:43PM -0700, Anton Vorontsov wrote:
> All temperatures should be in tenth degrees Celsius.

> bq24190_charger.c probably should be fixed.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

>=20
> Reported-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Signed-off-by: Anton Vorontsov <anton@enomsg.org>
> ---
>=20
> On Mon, Oct 28, 2013 at 11:00:52AM +0900, jonghwa3.lee@samsung.com wr=
ote:
> > >  * All voltages, currents, charges, energies, time and temperatur=
es in uV,     =20
> > >  * =B5A, =B5Ah, =B5Wh, seconds and tenths of degree Celsius unles=
s otherwise         =20
> > >  * stated
> > >=20
> > > So, the current code seems to be correct.
> >=20
> > Honestly, I missed the above paragraph you showed rather I read fol=
lowing one.
> >=20
> > TEMP - temperature of the power supply.
> > TEMP_ALERT_MIN - minimum battery temperature alert value in milli c=
entigrade.
> > TEMP_ALERT_MAX - maximum battery temperature alert value in milli c=
entigrade.
> > TEMP_AMBIENT - ambient temperature.
> > TEMP_AMBIENT_ALERT_MIN - minimum ambient temperature alert value in=
 milli
> > centigrade.
> > TEMP_AMBIENT_ALERT_MAX - maximum ambient temperature alert value in=
 milli
> > centigrade.
> >=20
> > So, we use different unit for properties related temperature, right=
?
> > current temperature is in tenth of centigrade and threshold tempera=
tures and
> > ambient temperature are in milli centigrade. Wouldn't it have to be=
 in same unit?
>=20
> :( They should. Thanks for spotting.
>=20
> The patch down below should fix the issue...
>=20
> Documentation/power/power_supply_class.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/power/power_supply_class.txt b/Documentati=
on/power/power_supply_class.txt
> index 3f10b39..89a8816 100644
> --- a/Documentation/power/power_supply_class.txt
> +++ b/Documentation/power/power_supply_class.txt
> @@ -135,11 +135,11 @@ CAPACITY_LEVEL - capacity level. This correspon=
ds to
>  POWER_SUPPLY_CAPACITY_LEVEL_*.
> =20
>  TEMP - temperature of the power supply.
> -TEMP_ALERT_MIN - minimum battery temperature alert value in milli ce=
ntigrade.
> -TEMP_ALERT_MAX - maximum battery temperature alert value in milli ce=
ntigrade.
> +TEMP_ALERT_MIN - minimum battery temperature alert.
> +TEMP_ALERT_MAX - maximum battery temperature alert.
>  TEMP_AMBIENT - ambient temperature.
> -TEMP_AMBIENT_ALERT_MIN - minimum ambient temperature alert value in =
milli centigrade.
> -TEMP_AMBIENT_ALERT_MAX - maximum ambient temperature alert value in =
milli centigrade.
> +TEMP_AMBIENT_ALERT_MIN - minimum ambient temperature alert.
> +TEMP_AMBIENT_ALERT_MAX - maximum ambient temperature alert.
> =20
>  TIME_TO_EMPTY - seconds left for battery to be considered empty (i.e=
=2E
>  while battery powers a load)
> --=20
> 1.8.3.1

I missed the beginning of this thread so I may be missing something but
the bq24190_charger driver already uses tenth of degrees Celcius for
POWER_SUPPLY_PROP_TEMP_ALERT_MAX.  IIUC, that's correct so there's is
nothing to fix in the bq24190_charger.c driver, correct?

Mark
--
