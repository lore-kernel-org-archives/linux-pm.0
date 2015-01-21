From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC PATCHv2 00/19] power_supply: Allow safe usage of power supply
Date: Wed, 21 Jan 2015 16:42:43 +0100
Message-ID: <1421854963.12894.1.camel@AMDC1943>
References: <1420472882-10463-1-git-send-email-k.kozlowski@samsung.com>
 <20150121152216.GD13715@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40561 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbbAUPmr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jan 2015 10:42:47 -0500
In-reply-to: <20150121152216.GD13715@earth.universe>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On =C5=9Bro, 2015-01-21 at 16:22 +0100, Sebastian Reichel wrote:
> Hi Krzysztof,
>=20
> On Mon, Jan 05, 2015 at 04:47:43PM +0100, Krzysztof Kozlowski wrote:
> > This is RFC, please don't apply yet but let me know if this approac=
h
> > is OK.
>=20
> I just reviewed the patchset. It looks fine to me.

Great! Thanks for looking at patchset. I'll start working on next
version adjusting all drivers.

>=20
> > TLDR
> > =3D=3D=3D=3D
> > Patchset tries to fix following race scenario:
> >=20
> > Thread 1: charger manager, CONSUMER
> > Thread 2: power supply driver, PROVIDER
> >=20
> > THREAD 1 (charger manager)         THREAD 2 (power supply driver)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > psy =3D power_supply_get_by_name()
> >                                    Driver unbind, .remove
> >                                      power_supply_unregister()
> >                                      Device fully removed
> > psy->get_property()
> >=20
> > To properly fix the race the patchset:
> > 1. Adds power_supply_get_property()-like API for safe access by con=
sumer.
> > 2. Moves ownership of power_supply structure from driver (provider)=
 to
> >    power supply core.
> > 3. Adds power_supply_put() which will reclaim memory.
>=20
> Looks fine to me, thanks for doing this :)
>=20
> > Description
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
> > This is a little different than my previous approaches [1][2] for f=
ixing
> > usage of power supply by some consumer, if driver implementing it i=
s
> > unbound.
> >=20
> > The patchset is quite big and touches power supply API so a lot of
> > changes in drivers are needed. These changes *are not finished yet*=
=2E
> > I've done them only for:
> >  - bq24190_charger.c
> >  - charger-manager.c
> >  - max14577_charger.c
> >  - max17040_battery.c
> >  - max17042_battery.c
> >  - sbs-battery.c
> >  - tps65090-charger.c
> > So allyesconfig won't build.
> >
> > If this approach is OK, I'll prepare full patchset changing all the
> > drivers.
>=20
> Please do :)
>=20
> > My previous approach [1][2] limited the race but did not close it.
> > Still the consumer of power supply by calling power_supply_get_prop=
ert(psy...)
> > may reference invalid memory because the producer freed it.
> >=20
> > Actually, because struct power_supply is exposed to consumers, the
> > core should be the owner of it. This is accomplished in patch 11/19
> > ("power_supply: Change ownership from driver to core").
> >=20
> > What the patchset does in steps
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. Some preparation steps are necessary - patch 1 and 2. The driver
> >    implementing power supply won't be able to fill structure before
> >    calling power_supply_register(). So 'power_supply_config'
> >    is introduced in patch 2 ("power_supply: Move run-time configura=
tion
> >    to separate structure"). Unfortunately this touches all drivers.
>=20
> $ grep -l power_supply_register **/*.c | grep -v mod.c | grep -v driv=
ers/power
> drivers/acpi/ac.c
> drivers/acpi/battery.c
> drivers/acpi/sbs.c
> drivers/hid/hid-input.c
> drivers/hid/hid-sony.c
> drivers/hid/hid-wiimote-modules.c
> drivers/hid/wacom_sys.c
> drivers/platform/x86/compal-laptop.c
> drivers/staging/nvec/nvec_power.c
>=20
> Please make sure to CC the respective maintainers for the patchset
> (e.g. current patch 14 and 15 should have CC'd x86 maintainers), so
> that they can Acknowledge the patchset.

Right. Probably maintainers should receive full patchset anyway. The
address list will be quite big.

>=20
> > 2. Safe API wrappers (and usage counter) are added (power_supply_*(=
)).
> > 3. Patch 11: ownership of 'struct power_supply' is moved from drive=
r
> >    to the core.
> > 4. power_supply_put() is added which reclaims resources.
>=20
> Looks fine to me.
>=20
> > The patchset is rebased on next-20141226. It should be pulled at on=
ce.
> > Bisectability is preserved.
>=20
> Fine with me, but I need acks from all involved maintainers. So for t=
he
> patchset:
>=20
> Reviewed-By: Sebastian Reichel <sre@kernel.org>

Thanks!

Best regards,
Krzysztof



