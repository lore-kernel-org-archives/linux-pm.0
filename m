From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/5] power: supply: bq27xxx: Correct supply status with
 current draw
Date: Wed, 31 May 2017 19:32:07 +0200
Message-ID: <20170531173207.GA10763@amd>
References: <20170430182727.24412-1-contact@paulk.fr>
 <20170430182727.24412-5-contact@paulk.fr>
 <20170528191619.GA20159@xo-6d-61-c0.localdomain>
 <1496249719.1774.1.camel@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496249719.1774.1.camel@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>
List-Id: linux-pm@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > The status reported directly by the battery controller is not always
> > > reliable and should be corrected based on the current draw informatio=
n.
> > >=20
> > > This implements such a correction with a dedicated function, called
> > > when retrieving the supply status.

> > > @@ -1182,6 +1196,8 @@ static int bq27xxx_battery_status(struct
> > > bq27xxx_device_info *di,
> > >  		else
> > >  			status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > >  	} else {
> > > +		curr =3D (int)((s16)curr) * 1000;
> >=20
> > Umm.

As in "two casts in one expression -- too ugly to live".

> > > @@ -1190,6 +1206,18 @@ static int bq27xxx_battery_status(struct
> > > bq27xxx_device_info *di,
> > >  			status =3D POWER_SUPPLY_STATUS_CHARGING;
> > >  	}
> > > =20
> > > +
> > > +	if (curr =3D=3D 0 && status !=3D POWER_SUPPLY_STATUS_NOT_CHARGING)
> > > +		status =3D POWER_SUPPLY_STATUS_FULL;
> > > +
> > > +	if (status =3D=3D POWER_SUPPLY_STATUS_FULL) {
> > > +		/* Drawing or providing current when full */
> > > +		if (curr > 0)
> > > +			status =3D POWER_SUPPLY_STATUS_CHARGING;
> > > +		else if (curr < 0)
> > > +			status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > > +	}
> >=20
> > Are you sure this works? On N900, we normally see small currents to/from
> > "full" battery.
>=20
> In my case, this works perfectly and I am quite surprised of what you're
> describing. Is it the case when the battery has a PSU connected?

"PSU"? This is cellphone. It has USB connection and charges from that.

It has been charging for long while now, and current_now fluctuates
between 20706 and -2856. USB has limitted current, so I guess "draw
current from battery if we need more than USB can provide" is quite common.

pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
5355
pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
5355
pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
-4105
pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
-4105
pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
-7675
pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
-5712
pavel@n900:~$ #screen on
pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
4641
pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
4641
pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
37842
pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
16600
pavel@n900:~$

> I guess I would consider this a hardware issue (leak currents) and we cou=
ld
> definitely set some range (in device-tree) to distinguish between full + =
leak
> currents and bad reporting from the fuel gauge. That would work well in m=
y case
> too.

I'd pass to userspace what the controller reports. Yes, I seldom see
"STATUS_FULL" but that may be a problem we need to track down.



       	  	 	     		 	      	    	    	 Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlku/hcACgkQMOfwapXb+vJ8TwCeJGVEBGgGmdiKQeUOPFY7Y4P9
3nIAoI8djId9u8ojVSUZlIj1ieDGRzzd
=R/7h
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
