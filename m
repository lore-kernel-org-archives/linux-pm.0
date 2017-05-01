From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v12.7 0/10] bq27xxx_battery partial series
Date: Mon, 1 May 2017 17:22:51 +0200
Message-ID: <20170501152251.ca6mpnf7hot44jey@earth>
References: <20170421095959.14151-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xauv7gxiipe2wq3c"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58140 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbdEAPlf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 11:41:35 -0400
Content-Disposition: inline
In-Reply-To: <20170421095959.14151-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org


--xauv7gxiipe2wq3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Liam,

On Fri, Apr 21, 2017 at 02:59:52AM -0700, Liam Breck wrote:
> Latest changes (including 12.6):
>=20
> Only DM update RAM chips by default
>=20
> Add config_battery_bq27xxx_dt_updates_nvm. If defined, update NVM chips
>  and add module param dt_monitored_battery_updates_nvm
>=20
> Fixed checkpatch errors and most warnings
>=20
> Switched from -ENOSYS to -PERM, due to checkpatch warning
>=20
> Add Copyright notice
>=20
> unseal() returns error on key=3D=3D0
>=20
> Skip reset on non-cfgupdate chips if not updated
>=20
> Emit warning if no dm_regs table
>=20
> Map orig ID to chip ID via bq27xxx_chips[]
>=20
> Drop "prototypes" in enum comments
>=20
> Rename dupes detector bq27xxx_battery_dbg_regs_dupes()
>=20
> ^.^ ^.^ ^.^ - We has hungry for test!

I queued everything up to patch 7 (including). That way any rebasing
should be less problematic. With the unseal keys not yet applied all
new features are not yet be used, but its much easier to follow
development. Also your work on using the new interface in charger
driver is unblocked.

I plan to send this for 4.12 towards the end of next week and would
like to queue the remaining patches early during 4.13 period (i.e.
sometime mid-end of May), so that they get much time in linux-next.
This will also give Andrew some time to test this.

-- Sebastian

--xauv7gxiipe2wq3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHUsgACgkQ2O7X88g7
+poS2xAAp7jdGhLFZky/AvyOQ+CJpwyVJF86ZoJuuc00m4+hqJ4BSPZPfHCC/tsA
VakKtbs/FZON8Tx8kqPtfrIv5qGvU6INRntqReLs7c6zjOaYfUMrsyJOW/H+DR4q
rbm04zHpjSTp+L37WnPghufQZffkem/y4OqXDl/013k6FsVAiGrrdkD3GJg1Y/yN
uAqPcjm+ip2Ocuiuo3grRm56E8FfiJclwwgbUAIG1/SZJ909ty7vuYF5oihfJn1c
zEd33c7VHV/sOlxWY23uHnn/RvYJkWkH1xBg6AKHdG4JsafANy39YPcsKrCk6rhj
v8rhfDK6eYj7eeYWzXL+URf0gQHh+gFakfUGGdZuwjl6g2DedB53KHw/kwk6vxTQ
tfF7lXZ6kZo4p+Fyl8vdcK1+AHPFI361mOli7481hY/HDrTL90wtoDR54MnfAVTG
SpLv6Aqe9LjhGsiAfiL8JUpjTDcEEC1yVRYiqIfOktVNqViGV8iVf5zAuFrDwAYM
OFPc7cH/FRQv5kTwficz/vv7M8m8r18sFpgWuL7pVlWu3lKcYqu1n9ZOpILkNswm
a+EkQwQ8VVyqoPju7xnKPaxPsISNUZzLlZqDQIwEp1L4dVyWBfgbLlFWzVLb8kCB
erSYpqNiyiXjZZnRMevFqtKYx4Vz5QtAryYxZEnyDdTKfwXYBBw=
=1VMS
-----END PGP SIGNATURE-----

--xauv7gxiipe2wq3c--
