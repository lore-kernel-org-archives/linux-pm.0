From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC 1/3] system-power: Add system power and restart framework
Date: Tue, 31 Jan 2017 18:46:58 +0100
Message-ID: <20170131174658.GA16896@ulmo.ba.sec>
References: <20170130171506.3527-1-thierry.reding@gmail.com>
 <20170130171506.3527-2-thierry.reding@gmail.com>
 <20170130215301.GA18997@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:33126 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbdAaRrC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2017 12:47:02 -0500
Content-Disposition: inline
In-Reply-To: <20170130215301.GA18997@atrey.karlin.mff.cuni.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2017 at 10:53:01PM +0100, Pavel Machek wrote:
> Hi!
>=20
>=20
> > +struct system_power_chip;
> > +
> > +struct system_power_ops {
> > +	int (*restart)(struct system_power_chip *chip, enum reboot_mode mode,
> > +		       char *cmd);
> > +	int (*power_off_prepare)(struct system_power_chip *chip);
> > +	int (*power_off)(struct system_power_chip *chip);
> > +};
> > +
> > +struct system_power_chip {
> > +	const struct system_power_ops *ops;
> > +	struct list_head list;
> > +	struct device *dev;
> > +};
>=20
> Is it useful to have two structures? AFAICT one would do.

Yeah, one structure works fine. I was drawing inspiration from other
subsystems that have a separate structure for these. I've merged the
operations into the struct system_power_chip now because that gives
us some more flexiblity, for example in cases where a chip can be a
power controller and a reset controller, but sometimes we may want
it to be only one of them.

> Do we always have struct device * to work with? IMO we have nothing
> suitable for example in the ACPI case. Would void * be more suitable?

The struct device * was meant to be purely optional, but working with
the code some more today and doing some more conversions, I've resorted
to adding a separate field (const char *name) that takes precedence. So
if a chip specifies both a .dev and .name field, then .name will be the
user visible string, otherwise dev_name(.dev) will be used in messages.

> Could you convert someting (acpi?) to the new framework as
> demonstration?

I had originally only converted architecture code to call into system
power instead of the notifier chain and added a driver for a chip that
I want to get this to work on. I've now converted a couple of other
drivers from drivers/power/reset as well as ACPI. I've also added a
very rudimentary prioritization mechanism that I've validated on the
specific setup that I'm working on.

On the Jetson TX1 that I'm testing this on, the SoC has a way of
resetting itself. This has the advantage that some of the registers are
kept intact over the reset, and this in turn is used to control early
boot, so that specific recovery modes can be used. However, the board
has to be powered off using the PMIC (via I2C). The patches achieve this
by splitting up restart and power off into two steps, prepare and
restart/power-off, as well as levels to prioritize. On Jetson TX1 the
PMIC will be higher priority than the SoC (determined by the level) and
therefore be able to override the SoC restart mechanism if we want to.
If we don't we simply instruct the MAX77620 driver not to register the
restart callback, in which case the SoC implementation will be used.

I've uploaded all of it to a branch on github:

	https://github.com/thierryreding/linux/tree/system-power

It's rather lengthy, so I'm not sure if it makes sense to send to the
lists right away.

Thierry

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliQzY8ACgkQ3SOs138+
s6Eegw//QvNlihEh42cBjnJOvSpAbVoq+vJllRgzhvzaQq/yt7q6UAFVGDu4HKdq
+QLMi1eaFyWCk4CPe5xwSgjnx1MFevsNJ/kf0P1K2t3r1tLB/2itUplBgul87azk
1FqVGQV43Dk/w5Pias0o3okmU/YSaeAlsVrqm+xveJDVjZsKECPZ+gpCmRC15FlA
BsvDr1/hcQjKQesJ1PlrQSpFA6t6yxvmQEYjcdbad3UXDw+mQsnm+/s+SzvTROeA
QpIc3zgiLD7i4Rzu/kkmsxosb9q2x24eNQgx4VBXoXwGT8tOQyJ62sNvlz3dLn4k
uXjJl+OLQmDveljd0wjBqum9OXfpRUbYXYD6UTHcI2U/mFo7fcUG5yQkYh6H3Ttm
fNhUd4LbgMhDsqMplBCGCF52XtcWbNJHrij29MYwopPfuxii0f4+9mM6QDw3+Zyc
1m3QHfPNBaETGz7cXvnYLPAsW+drCEIXumEZ48mnlzP/QNLwkzogEIa0wHD7l97H
XfnUNPXCrp6l+eVlvcQcn6b3SfWg6j1qhSHE5S1l+5jsOqkIdmI9yf0CH1rF6A0o
K/fAfTOuLTxBzwzIvn/6z6c0VKRbPd0iJnuIIbn/mMRvKBbzJz5/3oI5uvgSlER1
jxa6iwg31WMImIekoKv24hKsZV0l7gHbjn4WlV2G0UjuXrydR8s=
=FGLw
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
