From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 1/3] system-power: Add system power and restart framework
Date: Wed, 1 Feb 2017 12:13:31 +0100
Message-ID: <20170201111331.GA27721@amd>
References: <20170130171506.3527-1-thierry.reding@gmail.com>
 <20170130171506.3527-2-thierry.reding@gmail.com>
 <20170130215301.GA18997@atrey.karlin.mff.cuni.cz>
 <20170131174658.GA16896@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60078 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbdBALNe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2017 06:13:34 -0500
Content-Disposition: inline
In-Reply-To: <20170131174658.GA16896@ulmo.ba.sec>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2017-01-31 18:46:58, Thierry Reding wrote:
> On Mon, Jan 30, 2017 at 10:53:01PM +0100, Pavel Machek wrote:
> > Hi!
> >=20
> >=20
> > > +struct system_power_chip;
> > > +
> > > +struct system_power_ops {
> > > +	int (*restart)(struct system_power_chip *chip, enum reboot_mode mod=
e,
> > > +		       char *cmd);
> > > +	int (*power_off_prepare)(struct system_power_chip *chip);
> > > +	int (*power_off)(struct system_power_chip *chip);
> > > +};
> > > +
> > > +struct system_power_chip {
> > > +	const struct system_power_ops *ops;
> > > +	struct list_head list;
> > > +	struct device *dev;
> > > +};
> >=20
> > Is it useful to have two structures? AFAICT one would do.
>=20
> Yeah, one structure works fine. I was drawing inspiration from other
> subsystems that have a separate structure for these. I've merged the
> operations into the struct system_power_chip now because that gives
> us some more flexiblity, for example in cases where a chip can be a
> power controller and a reset controller, but sometimes we may want
> it to be only one of them.
>=20
> > Do we always have struct device * to work with? IMO we have nothing
> > suitable for example in the ACPI case. Would void * be more suitable?
>=20
> The struct device * was meant to be purely optional, but working with
> the code some more today and doing some more conversions, I've resorted
> to adding a separate field (const char *name) that takes precedence. So
> if a chip specifies both a .dev and .name field, then .name will be the
> user visible string, otherwise dev_name(.dev) will be used in
> messages.

Thanks!

> > Could you convert someting (acpi?) to the new framework as
> > demonstration?
>=20
> I had originally only converted architecture code to call into system
> power instead of the notifier chain and added a driver for a chip that
> I want to get this to work on. I've now converted a couple of other
> drivers from drivers/power/reset as well as ACPI. I've also added a
> very rudimentary prioritization mechanism that I've validated on the
> specific setup that I'm working on.
>=20
> On the Jetson TX1 that I'm testing this on, the SoC has a way of
> resetting itself. This has the advantage that some of the registers are
> kept intact over the reset, and this in turn is used to control early
> boot, so that specific recovery modes can be used. However, the board
> has to be powered off using the PMIC (via I2C). The patches achieve this
> by splitting up restart and power off into two steps, prepare and
> restart/power-off, as well as levels to prioritize. On Jetson TX1 the
> PMIC will be higher priority than the SoC (determined by the level) and
> therefore be able to override the SoC restart mechanism if we want to.
> If we don't we simply instruct the MAX77620 driver not to register the
> restart callback, in which case the SoC implementation will be used.
>=20
> I've uploaded all of it to a branch on github:
>=20
> 	https://github.com/thierryreding/linux/tree/system-power
>=20
> It's rather lengthy, so I'm not sure if it makes sense to send to the
> lists right away.

It is easier to review on lists, but no reasons to do it now.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliRwtsACgkQMOfwapXb+vKzWQCfT+QFSRGc8PXCLIq7tNOVI/IG
Z94AoKH9WDD+dnCkgAeeQWpg9AFcBN6n
=Qrvh
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
