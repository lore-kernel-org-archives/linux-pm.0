From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 3/3] power: bq27xxx: add support for NVRAM R/W access
Date: Fri, 6 Jan 2017 18:28:59 +0100
Message-ID: <20170106172858.wro233hduyecou5p@earth>
References: <20170105021007.22088-1-matt@ranostay.consulting>
 <20170105021007.22088-4-matt@ranostay.consulting>
 <20170106015314.7qju6eodkwldty6h@earth>
 <CAJ_EiSTVv90QSB6TY7+5KXWPbLkkr5vEXpDQrQ0VCvtAkddt5A@mail.gmail.com>
 <CAJ_EiSQjRn=rot7Zu+oB80DruN0qexd+3_PxjXS6_JaF7CY1Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aburygu6pz44amhc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750809AbdAFR3E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Jan 2017 12:29:04 -0500
Content-Disposition: inline
In-Reply-To: <CAJ_EiSQjRn=rot7Zu+oB80DruN0qexd+3_PxjXS6_JaF7CY1Bw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matt Ranostay <matt@ranostay.consulting>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org


--aburygu6pz44amhc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 05, 2017 at 07:23:48PM -0800, Matt Ranostay wrote:
> On Thu, Jan 5, 2017 at 6:34 PM, Matt Ranostay <matt@ranostay.consulting> =
wrote:
> > On Thu, Jan 5, 2017 at 5:53 PM, Sebastian Reichel <sre@kernel.org> wrot=
e:
> >> On Wed, Jan 04, 2017 at 06:10:07PM -0800, Matt Ranostay wrote:
> >>> Initial support for access and modification of the non-volatile regio=
ns
> >>> of the bq27425 fuel gauge DesignEnergy, DesignCapacity, and
> >>> TerminateVoltage settings.
> >>>
> >>> This is intended for fine tuning the fuel gauge state machine for the
> >>> respective battery specifications.
> >>>
> >>> Cc: Sebastian Reichel <sre@kernel.org>
> >>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> >>> ---
> >>>  drivers/power/supply/bq27xxx_battery_i2c.c | 335 +++++++++++++++++++=
++++++++++
> >>>  include/linux/power/bq27xxx_battery.h      |   4 +
> >>>  2 files changed, 339 insertions(+)
> >>
> >> I only skipped over this one, as the changed DT binding requires
> >> quite some changes in this patch anyways. Here are a couple of
> >> comments how I would like to see this implemented:
> >>
> >> Add a patch for the power-supply core, which implements a
> >> structure for the battery info. Something like this:
> >>
> >> struct power_supply_battery_info {
> >>     uint32 energy; /* =B5Wh */
> >>     uint32 power;  /* =B5Ah */
> >>     uint32 nominal_voltage; /* =B5V */
> >>     /* ... */
> >> };
> >>
> >> And a function in the core framework, which gets the information
> >> from DT. The function itself should *not* be DT specific, so that
> >> ACPI/platformdata/whatever support can be added later without
> >> modifying every single driver.
> >>
> >> static struct power_supply_battery_info*
> >> power_supply_get_battery_info(struct power_supply *psy) {
> >>     if (psy->dt) {
> >>         /* get battery phandle or return -ENXIO */
> >>         /* fill and return struct */
> >>     }
> >>
> >>     return -ENOTSUP;
> >> }
> >>
> >> Then call power_supply_get_battery_info() during bq27xxx probe and
> >> use the struct to initialize the registers. Also I expect that
> >> functionality in bq27xxx_battery.c instead of bq27xxx_battery_i2c.c,
> >> since it's not I=B2C specific.
> >
> > They may not be i2c specific but they are only used by the i2c path of
> > the code currently. Do you think that platform data would ever have a
> > struct to pass with the respective data?

I think it is possible, that there will be some non-i2c bq27xxx
device in the future, that needs this feature.

> > Also it would have to be in bq27xxx_battery_setup() and not
> > bq27xxx_battery_platform_probe() since the former is only thing called
> > by both code paths.

bq27xxx_battery_setup is fine.

> Also there is no bq27xxx_battery_platform_write to even write the
> configuration data.

Just check if the callback exists.

The plan is to convert the 1wire bq27xxx to regmap at some point, so
that the bus-specific bq27xxx files can be dropped by just using
regmap in the core bq27xxx driver.

-- Sebastian

--aburygu6pz44amhc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhv09cACgkQ2O7X88g7
+pqXBA//YPalInQDKH7/ZplPgkKIJWqqwPvMyHd6n1YHi3zZtxkejKYDbp50WDKX
ttVdb2USpl8dDDprA/xW0aPaGa2AET4J46s8EXMniwq+igD3tHNiJc2ZDCduN/fR
bAwm+VKX4Zvt1bKzv1Ob+Qo2ulozjIJgTUrJii7KuDlfgzbYCQgApP7Ib10lUcrC
6iQLx7em4kZD3UttTKD1KLLiipRoQ/jR14KvgH91dSqdq1CiWBil1psFM4BOizXr
i67lE37byK+WcdnaZkbhXxhvrIzL2NLsJ3fg3BrUJj2qkQS2KYYOhDef0o2OiQTL
xcmSMgWtLcHu2YDXMMYdxKGXESHBd0swjHPdGiqxpnd6+RMFL6CvYZ3fnDKcE12h
VKOsnvytCprjZY6Bi1NdfsefCqorjS7k07ndTWaE1080zPqrtG0YXws0xMwjmut8
U5lyRY8L7auz+PFs9cRt1gDj0pMu/n1jT49DQsU/Mp59nX9sZDirxT6pnlSOOKJD
6EtQQlh2Tu9FqdN03DJwjZ/cz1vPKMd6SaGrrpgbv8Pj731LD5sJqTDMU5ze9epB
hDQXnmFESwYjSg8TQN77JvTlJFf98NzMeShiGoTplxFpjkOvboZuMOzXAmOl9PmA
MrYQQaKKi4EolhkVPgzKP7gT9/ta4E2m17D4ZIO5hwad1eV9DXQ=
=XmcM
-----END PGP SIGNATURE-----

--aburygu6pz44amhc--
