From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [04/15] power: supply: bq24190_charger: Add no_register_reset
 pdata flag
Date: Mon, 20 Mar 2017 06:27:15 +0100
Message-ID: <20170320052715.hrgaxsxwdrv7ynbu@earth>
References: <20170318071019.4561-1-liam@networkimprov.net>
 <6ad6ecd2-ea0f-b613-8519-66ad424c623a@redhat.com>
 <CAKvHMgQ-hnS_XkL_7Mwkm94hNDc9Q++xHBAOUK1bKmvO=YnSXQ@mail.gmail.com>
 <6a0e54e3-581d-6162-b521-82b7567b6e74@redhat.com>
 <CAKvHMgTYqypPiv0KcoFZqpojq50yUDoU=HL8uiwPyKP7HLTy1A@mail.gmail.com>
 <f7b3fda0-eeff-b6ab-4908-86c4180bda8a@redhat.com>
 <12321f48-def6-33cb-1df5-853ecc8f1061@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2dkejef55l754j72"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750943AbdCTF1V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Mar 2017 01:27:21 -0400
Content-Disposition: inline
In-Reply-To: <12321f48-def6-33cb-1df5-853ecc8f1061@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Liam Breck <liam@networkimprov.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>


--2dkejef55l754j72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 19, 2017 at 10:42:00AM +0100, Hans de Goede wrote:
> On 19-03-17 09:22, Hans de Goede wrote:
> > > Then consider the pseudo-driver concept. That would be generally
> > > useful for any charger/gauge pairing. Both drivers would provide
> > > callbacks to it.
> >=20
> > So your rejecting a patch which adds 30 lines of code for some
> > vague generic pseudo-driver concept without offering any design
> > direction on what such a concept would look like and without taking
> > into account that so far this seems to be a one-of problem.
>=20
> I still think the pseudo-driver idea is a bad idea. Having 1 driver
> which somehow combines things from 2 drivers without clear semantics
> feels wrong.

Apart from being ugly, that does not work anyways, how should the
drivers know when its ok to expose their info to userspace and when
its not.

> As said before I think your suggested solution lacks any
> design direction, I've been thinking about this a bit more and
> I've come up with an alternative solution with clearly defined
> goals and semantics.
>=20
> We want one driver which is solidly in control of the charger
> since getting that wrong is quite bad and we want to extend
> the information it is exporting to userspace in the form of
> power_supply properties with some extra info.
>=20
> So taking that as a starting point and generalizing that,
> I think that if we want we can make something more generic then
> my original patch for this. My idea is to introduce something
> called a power_supply_properties_provider, with an API
> like this:

Thanks for thinking about this. From what I can see it should
be enough to just avoid exposing a battery device at all in
the charger driver, though. It does not really provide useful
information anyways.

> typedef int (*power_supply_properties_provider_get_property_t)(
> 	enum power_supply_property prop, union power_supply_propval *val,
> 	void *driver_data);
>=20
> struct power_supply_properties_provider;
>=20
> struct power_supply_properties_provider *
> power_supply_properties_provider_register(
> 	const char *name,
> 	power_supply_properties_provider_get_property_t get_property,
> 	const enum power_supply_property *properties,
> 	size_t num_properties,
> 	void *driver_data);
>=20
> void power_supply_properties_provider_unregister(
> 	struct power_supply_properties_provider *pspp);
>=20
> struct power_supply_properties_provider *
> 	power_supply_properties_provider_get(const char *name);
>=20
> void power_supply_properties_provider_put(
> 	struct power_supply_properties_provider *pspp);
>=20
> int power_supply_properties_provider_merge_properties(
> 	struct power_supply_properties_provider *pspp,
> 	const enum power_supply_property *properties,
> 	size_t num_properties,
> 	enum power_supply_property **merged_properties_ret,
> 	size_t *merged_num_properties_ret);
>=20
> int power_supply_properties_provider_get_property(
> 	struct power_supply_properties_provider *pspp,
> 	enum power_supply_property prop,
> 	union power_supply_propval *val);
>=20
> So in this case the faul-gauge driver would call
> power_supply_properties_provider_register() from probe and
> power_supply_properties_provider_unregister() from remove.
>=20
> The struct power_supply_properties_provider will be ref-counted
> so that it will stick around after unregister in case any
> consumers who have gotten a ref through
> power_supply_properties_provider_get can still call
> power_supply_properties_provider_get_property, which after
> unregister will simply always return -ENXIO.
>=20
> A driver wanting to use extra properties like bq24190_charger
> will call power_supply_properties_provider_get (with a name
> provided through platform_data), use a dynamically allocated
> struct power_supply_desc and fill the properties of that
> using power_supply_properties_provider_merge_properties
> to merge its own properties with the
> power_supply_properties_provider's properties and in its
> get_property method have a default label which calls
> power_supply_properties_provider_get_property.
>=20
> This would still add quite a bit more code then my original
> patch for what may very well end up being a one-of solution,
> but I guess we may encounter this problem more often and
> this will offer a nice generic and clean way for dealing
> with adding extra info from other sources to a power_supply
> driver, so I'm happy to turn this idea / design into working
> code if people like this better then my original patch.
>=20
> Liam, Sebastian what do you think of the above proposal?
>=20
> Regards,
>=20
> Hans
>=20

--2dkejef55l754j72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljPaDEACgkQ2O7X88g7
+poXTg//TtchQC48ZDaukFeTBbyQCphM6agAC1+CDj2vblqAhBtzQNfkgllvNiTN
AIYGd3UdTTmuQGzGxtJ0+wFxRNFdHmYesxIguvJT8QrarNavEztzsqXiTWT0RjYt
/KLAvdS8OsfijV+99R1NdJ2kkPJrkhomQGtIEhfQMWM9AvXY20toJlS8NpdPvy6y
TOwi+KzTI+y6FnfeI4Mu+14m8XPa9FaOlbsjxKU0KX0peuM1PJV6zB6UvUvSz0jh
LssM8oINLsMA7aEA3DataokjPqZJPhtDY+vZgB55+acFGG6seXP/mirDGkhCVqj2
EoLhVqD9nVUcMAsb/mnbTJpDVZjGDC3wWvhY1vYNbG2+mfbCcIO2cI4rwx8H1anS
YA/x2hK3ANTu1ggVwQvIG6/YF+IKMYQ8qTd0QzHE82hm8BY5A/Obu5TnKYGtaPGy
/bdM57w09S8NANIrfJ6/r3JBZrrwYlL/xIYnl5xBaCowd8eHylghgsvZNmN0x5Oj
tPoTeYapnomsnHQCGuwYTDJddccvQVa/6dkV5C4EkU5bKsMg5/NfGDri9pelmMNW
zZw4/koBpmOfAT+eA9OdlFTU7UbLAmlSKTqE8P+X+7Xrde0XXZvdXYs8iU5DIGgI
F/5lx8kuzGZDbUzzLXI6QD9W1tYd6MBSRt1NHEEWwFY4qdX+AY0=
=LWWA
-----END PGP SIGNATURE-----

--2dkejef55l754j72--
