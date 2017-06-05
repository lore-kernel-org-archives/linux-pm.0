From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: suspend-to-mem broken by eed4d47efe95 (ACPI / sleep: Ignore
 spurious SCI wakeups from suspend-to-idle)
Date: Mon, 5 Jun 2017 17:09:15 +0200
Message-ID: <20170605150915.GA1627@light.dominikbrodowski.net>
References: <20170605090521.GA1912@light.dominikbrodowski.net>
 <21111815.riZgbS9lI9@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <21111815.riZgbS9lI9@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2017 at 03:08:57PM +0200, Rafael J. Wysocki wrote:
> On Monday, June 05, 2017 11:05:21 AM Dominik Brodowski wrote:
> > unfortunately, commit eed4d47efe95 (ACPI / sleep: Ignore spurious SCI
> > wakeups from suspend-to-idle) breaks suspend-to-mem on my Dell XPS 13
> > (9343) up to v4.12-rc4: Issuing
> >=20
> > 	$ echo "mem" > /sys/power/state
> >=20
> > in the initramfs returns, after a while, with "write error: Resource
> > busy", and the system *not* having entered the sleep state in between.
>=20
> Why initramfs?

Easiest and quickest to test, with no userspace in between to interfere.
During normal operations, I see suspend-to-mem fail, then a fall-back to
s2idle...

> > In contrast thereto, 8a537ece3d94 (PM / wakeup: Integrate mechanism to =
abort
> > transitions in progress) still works fine, and allows to enter
> > suspend-to-mem. No real difference is to be seen in dmesg, with the not=
able
> > exception of
> >=20
> > 	ACPI: Low-level resume complete
> > 	ACPI : EC: EC started
> > 	PM: Restoring platform NVS memory
> > 	Suspended for N.NNNN seconds
> >=20
> > only showing up on working kernels. Reverting eed4d47efe95 on top of
> > v4.12-rc4 restores suspend-to-mem to work as expected.
>=20
> I'm sure it is not necessary to revert all of it.

Thought so, just wanted to confirm that eed4d47efe95 is indeed the culprit.

> I guess what happens is that you get a wakeup event during suspend which =
is
> aborted as a result.
>=20
> Please apply the partial revert below and see if it makes the issue go aw=
ay.

Yes it does -- with this patch applied on top of v4.12-rc4, everything works
as expected. Both in initramfs and during normal runtime operations. Only an
(probably unrelated) issue still appears during resume, namely "cache"
complaining that the non-boot CPUs should not be sleeping:

[  140.773931] Suspended for 2.244 seconds
[  140.776090] Enabling non-boot CPUs ...
[  140.780214] x86: Booting SMP configuration:
[  140.780216] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  140.781116]  cache: parent cpu1 should not be sleeping
[  140.781325] microcode: sig=3D0x306d4, pf=3D0x40, revision=3D0x1f
[  140.782400] CPU1 is up
[  140.788172] smpboot: Booting Node 0 Processor 2 APIC 0x1
[  140.788865]  cache: parent cpu2 should not be sleeping
[  140.788987] microcode: sig=3D0x306d4, pf=3D0x40, revision=3D0x24
[  140.789095] CPU2 is up
[  140.797493] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  140.798208]  cache: parent cpu3 should not be sleeping
[  140.798551] CPU3 is up
[  140.802735] ACPI: Waking up from system sleep state S3


Thanks!

	Dominik


>  drivers/acpi/battery.c   |    2 +-
>  drivers/acpi/button.c    |    4 ++--
>  drivers/acpi/device_pm.c |    2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> Index: linux-pm/drivers/acpi/battery.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/battery.c
> +++ linux-pm/drivers/acpi/battery.c
> @@ -782,7 +782,7 @@ static int acpi_battery_update(struct ac
>  	if ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
>  	    (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
>              (battery->capacity_now <=3D battery->alarm)))
> -		pm_wakeup_hard_event(&battery->device->dev);
> +		pm_wakeup_event(&battery->device->dev, 0);
> =20
>  	return result;
>  }
> Index: linux-pm/drivers/acpi/device_pm.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -400,7 +400,7 @@ static void acpi_pm_notify_handler(acpi_
>  	mutex_lock(&acpi_pm_notifier_lock);
> =20
>  	if (adev->wakeup.flags.notifier_present) {
> -		pm_wakeup_ws_event(adev->wakeup.ws, 0, true);
> +		__pm_wakeup_event(adev->wakeup.ws, 0);
>  		if (adev->wakeup.context.work.func)
>  			queue_pm_work(&adev->wakeup.context.work);
>  	}
> Index: linux-pm/drivers/acpi/button.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/button.c
> +++ linux-pm/drivers/acpi/button.c
> @@ -217,7 +217,7 @@ static int acpi_lid_notify_state(struct
>  	}
> =20
>  	if (state)
> -		pm_wakeup_hard_event(&device->dev);
> +		pm_wakeup_event(&device->dev, 0);
> =20
>  	ret =3D blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
>  	if (ret =3D=3D NOTIFY_DONE)
> @@ -402,7 +402,7 @@ static void acpi_button_notify(struct ac
>  		} else {
>  			int keycode;
> =20
> -			pm_wakeup_hard_event(&device->dev);
> +			pm_wakeup_event(&device->dev, 0);
>  			if (button->suspended)
>  				break;
> =20

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmgXaWKgmjrvkPhLCmpdgiUyNow0FAlk1dBgACgkQmpdgiUyN
ow2fog//QFkcuUUc/w3VWNFgxkWPTn2KDkRltmCaoiIPbWmKHSMKMKtpWyFrTQo8
FEgGeq5yKuTANetA0Ka6Fg2k3xVk3mVv8RPzfY96ewHIL8iQAoamol7UgDRUxLcO
owN5QMfhtfonczrSIx2nhhK4ExzhjPOM+8ca5jjK+czzth5LndvZhldwuUeFfwI/
eLUXnjiIO+pMWoDxIVhVj6fa983AHrI+5dkxWxDS+/9zrD37p6V3h0p78r2DQ/RZ
e8d8uTS6m11B16dhF9ex7WcS25RHuuXOOjxvqAKOWEWlerc43EVK5aZGkv1Bg5Jw
4HSYLM1yXT9wOzeQQeEFKXEQzYCSLuwuCisMBpM64tnG1eEA+PmQZPS2/r10Ocg4
TrSSJrAALTavSRlCfm7XvB1+q25bv6r8eGogUZcKbzOK5XUIpkq0EZ9G0XJ3xCDH
R0tYsNZMAxBZKJ8/PQyeE4vpAhUekfmTsBFz2/X2G9XT6GUpNPIGM4fhhpKEkSVH
zsbyXmueGKzGpim5dqa8584NwQmdSMC78iRQ17L70CH0S7HA3FrOdXuvOq+rgwyQ
VdPQZpsh643TyXdj3FPqjSuqt3fUekWv01HYwOElnU4c54vWBuSVQ/og2uRcYV7I
jk7KPSBCe08Ew7oJ2AjhnpEdFHaY/D9LN14bcvjuUzHCX6u24bI=
=L+Vk
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
