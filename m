From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 5/5] power: supply: bq27xxx: Correct supply status with
 current draw
Date: Wed, 07 Jun 2017 10:15:33 +0300
Message-ID: <1496819733.927.16.camel@paulk.fr>
References: <20170430182727.24412-1-contact@paulk.fr>
         <20170430182727.24412-5-contact@paulk.fr>
         <20170528191619.GA20159@xo-6d-61-c0.localdomain>
         <1496249719.1774.1.camel@paulk.fr> <20170531173207.GA10763@amd>
         <1496258936.2038.8.camel@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-w/B3qr7lt4n0DCR8rMBF"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1496258936.2038.8.camel@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>
List-Id: linux-pm@vger.kernel.org


--=-w/B3qr7lt4n0DCR8rMBF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 31 mai 2017 =C3=A0 21:28 +0200, Paul Kocialkowski a =C3=A9crit =
:
> Hi,
>=20
> Le mercredi 31 mai 2017 =C3=A0 19:32 +0200, Pavel Machek a =C3=A9crit :
> > The status reported directly by the battery controller is not always
> > > > > reliable and should be corrected based on the current draw
> > > > > information.
> > > > >=20
> > > > > This implements such a correction with a dedicated function, call=
ed
> > > > > when retrieving the supply status.
> > > > > @@ -1182,6 +1196,8 @@ static int bq27xxx_battery_status(struct
> > > > > bq27xxx_device_info *di,
> > > > >  		else
> > > > >  			status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > > > >  	} else {
> > > > > +		curr =3D (int)((s16)curr) * 1000;
> > > >=20
> > > > Umm.
> >=20
> > As in "two casts in one expression -- too ugly to live".
>=20
> Oh, I had skipped that comment, sorry about that. Yeah I understand your
> concern. However, this line was mostly inspired by another part of the co=
de,
> below the following comment: /* Other gauges return signed value */
>=20
> I think we should fix the first occurence first and then used the fixed s=
yntax
> in v2 of this patch. What do you think?
>=20
> > > > > @@ -1190,6 +1206,18 @@ static int bq27xxx_battery_status(struct
> > > > > bq27xxx_device_info *di,
> > > > >  			status =3D POWER_SUPPLY_STATUS_CHARGING;
> > > > >  	}
> > > > > =20
> > > > > +
> > > > > +	if (curr =3D=3D 0 && status !=3D POWER_SUPPLY_STATUS_NOT_CHARGI=
NG)
> > > > > +		status =3D POWER_SUPPLY_STATUS_FULL;
> > > > > +
> > > > > +	if (status =3D=3D POWER_SUPPLY_STATUS_FULL) {
> > > > > +		/* Drawing or providing current when full */
> > > > > +		if (curr > 0)
> > > > > +			status =3D POWER_SUPPLY_STATUS_CHARGING;
> > > > > +		else if (curr < 0)
> > > > > +			status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > > > > +	}
> > > >=20
> > > > Are you sure this works? On N900, we normally see small currents to=
/from
> > > > "full" battery.
> > >=20
> > > In my case, this works perfectly and I am quite surprised of what you=
're
> > > describing. Is it the case when the battery has a PSU connected?
> >=20
> > "PSU"? This is cellphone. It has USB connection and charges from that.
> >=20
> > It has been charging for long while now, and current_now fluctuates
> > between 20706 and -2856. USB has limitted current, so I guess "draw
> > current from battery if we need more than USB can provide" is quite com=
mon.
>=20
> Ah right, I had forgotten about the USB current limitation thing. In this
> case,
> I guess the battery is never actually full and IMO, it should be reported=
 as
> such.
>=20
> > pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> > 5355
> > pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> > 5355
> > pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> > -4105
> > pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> > -4105
> > pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> > -7675
> > pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> > -5712
> > pavel@n900:~$ #screen on
> > pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> > 4641
> > pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> > 4641
> > pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> > 37842
> > pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> > 16600
> > pavel@n900:~$
> >=20
> > > I guess I would consider this a hardware issue (leak currents) and we
> > > could
> > > definitely set some range (in device-tree) to distinguish between ful=
l +
> > > leak
> > > currents and bad reporting from the fuel gauge. That would work well =
in my
> > > case
> > > too.
> >=20
> > I'd pass to userspace what the controller reports. Yes, I seldom see
> > "STATUS_FULL" but that may be a problem we need to track down.
>=20
> The controller is known, from my experience, to not be reliable in that
> regard,
> so I don't think it makes sense to pass a state that doesn't reflect the
> actual
> state of charging just because the chip tells us so.
>=20
> Worst case, we could also have a dt property to enable that kind of fixup
> workaround and let every device maintainer decide whether it is relevant =
for
> their device.

Actually, since a similar fix[0] was accepted in sbs-battery, I'd rather no=
t
make this optional but rather make it the default and perhaps have a dt pro=
p to
disable it.

> What do you think?

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?
h=3Dv4.12-rc4&id=3D7f93e1fa032bb5ee19b868b9649bc98c82553003
--=20
Paul Kocialkowski, developer of free digital technology and hardware suppor=
t

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-w/B3qr7lt4n0DCR8rMBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlk3qBUACgkQhP3B6o/u
lQxG5RAAgqf3whmbka58MkryOBLGdF2VV6XODx3Sy2fW+FXfcul+18vhU7oe6Bj9
QZu1Suvo/fOYSspgzLR1/rjb/7WEBkO0VHI2B8vgnsSmm/UKXqD7nh2Zx6XHVwEY
g+SocgVW11EJoJ801XMQ79xByu1pymaaZNpsEWlnWm/c7LZ6fSdRHABC3idpr/vc
9DurmSmf3ef+mG0pk5UgE99eR7EgjZwjFGJu9ysIkUm4fGorjR55oncWQLeoCxWq
xXqYrllOhQwHaUeIVeHF+7Eehsw7Eafk0iUskDR9durP02K47VjtytlQdON+4a10
Hmmjdfv9BKcEc5anY7S4V7JMRpv2OQ0Lyzz/9VyLByrd3IiGU6RR/0oOyKztD8k+
Cvc8ZcjVExS0giz/XC9N+91maxxT6cD6muR7KqulimodawT/NNoJcxOe8cSxRMB5
zIJZmAWMvX951wgdBoPUMY0b1Rb//+HuT1UM+a64lToIRq4w7xzzgxg34XGBv8V2
Y0CWTPahMCvL6WWJV0vTGFpzfaG4j6wgIfuqo7zUHmq/0yabvJxO/Za/kb19PkEe
ywwNdnUb0K3V76sPpxxzcenyLd4iapAwb+Rj/zDh5s1yv4Sro3q4QLQ+sS3L/75q
RKPvQTvo3vefhNr2ciBNVHiwHTtdbb5TJ43oxW9acEnMgn5F33Y=
=PL12
-----END PGP SIGNATURE-----

--=-w/B3qr7lt4n0DCR8rMBF--
