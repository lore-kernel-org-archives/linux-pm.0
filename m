From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: Add driver for TI BQ2416X battery charger
Date: Thu, 23 Mar 2017 14:54:36 +0100
Message-ID: <20170323135436.v7epznjbtclqkfsd@earth>
References: <1486429749-12973-1-git-send-email-wojciech.ziemba@verifone.com>
 <20170320055845.3o7nyhcu66ridheb@earth>
 <BN6PR03MB2963F42E5F6AC2ECCDC5722B9F3C0@BN6PR03MB2963.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zx44lwxrosfxj6ja"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751324AbdCWNyl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 09:54:41 -0400
Content-Disposition: inline
In-Reply-To: <BN6PR03MB2963F42E5F6AC2ECCDC5722B9F3C0@BN6PR03MB2963.namprd03.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wojciech Ziemba <Wojciech.Ziemba@VERIFONE.com>
Cc: Wojciech Ziemba <wo.ziemba@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--zx44lwxrosfxj6ja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 22, 2017 at 01:53:19PM +0000, Wojciech Ziemba wrote:
> [...]
>
> >> and a number of knobs for controlling the charging process
> > missing sysfs ABI documentation. Most of them are probably either
> > not needed, or should become standard POWER_SUPPLY_PROP_ properties.
>=20
> Well, it is up to you. POWER_SUPPLY props are already there.
> If any new POWER_SUPPLY props should be introduced, it is an open questio=
n.
> I agree sysfs knobs could be not needed, but many PSY drivers
> still use them. Couldn't them still be useful even if don't fit the model=
 directly?
> Especially for more specialized embedded systems?

Yes they may, they also may not. Let's add them once they are
needed, because adding them means, that they become ABI.

> [...]
>
> >> +- ti,safety-timer:          Safety timer. enum:
> >> +                    - TMR_27MIN (0)
> >> +                    - TMR_6H (1)
> >> +                    - TMR_9H (2)
> >> +                    - TMR_OFF (3)
> > This does not belong into DT. Just always set it to 27 minutes and
> > properly reset the timer in the driver. You will also need a suspend
> > handler, that disables the timer (or wakeup every now and then to
> > reset it).
>=20
> Do you mean, more flexible safety timer based on minimal 27min reset?
> Will address wakeup in suspend, separately in this driver.

I mean just always use TMR_27MIN in the driver + watchdog to keep
the system charging. You can change the timer to something bigger
in the suspend routine.

-- Sebastian

--zx44lwxrosfxj6ja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljT05kACgkQ2O7X88g7
+pqlzBAAlNFEC7gxoZZ6MGyS83tk68x6XVTugsM0GoA4Izyfpt2Cq3NQLVnwbZLG
iEZKZo9QDSYUu2u2ZPwr8vqTCbv16phxCb8tgu5hzdDL8u1aE2VeSReOrPmWhzLR
5n8QRUOAW3uoVPQU647s/hsviL0SYbAVYAKxjaijJGELqF+yJIut6nGszgDhnnVa
MIkQz5h6QDWyB4V0VhY2kYZtKmySgx14CmTIBGuCndwjUrst2cGVrintB07+eeGh
PFQthWqamNBiBJR7bwEzE8MONZX9x2M3+NSE+zCOBPYTSOM3dl770R4UCKISYeg3
FcQ1cpZdKUwGCNreX2fthxjV41zaYXFQQWN8SsHDjz5c7LkMaj2v/uMlPty1YiLT
MccuC9NO+6gPLBew80X+mEmtMXL1v+O+Ob1OqrfV8OTuOhMeHbv5w2RXTV1UzS32
U509Vc57AXI/AGhriwtFzPTQR0M0XFrVUshtpf3Q3bHT83iedBN6v3k9OQyKx7q7
TdQCJ0tA3pMukODoUk/XxTL725p0Oiy2lCepJCqwFyYocNqE1WQqdDnuUo2yyNKX
lhXY1G6NltXBLdIhXoOd8to0lcApKW2M9sEzYS3jUAL2DSwwraqo4+dS9OARQyOp
kbHso3o1AcZVFFLYcrAUpStkNpVFnFWzXyyyDAo6fNBnipKndAw=
=ov61
-----END PGP SIGNATURE-----

--zx44lwxrosfxj6ja--
