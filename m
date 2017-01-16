From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] power_supply: Add support for MAX14656 USB charger
 detector
Date: Mon, 16 Jan 2017 23:09:42 +0100
Message-ID: <20170116220942.6ndez745bhmczyzu@earth>
References: <1476893089-7233-1-git-send-email-akurz@blala.de>
 <1476893089-7233-2-git-send-email-akurz@blala.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3zqtffriqv5yyy23"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1476893089-7233-2-git-send-email-akurz-3EoFODjbY6Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kurz <akurz-3EoFODjbY6Q@public.gmane.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--3zqtffriqv5yyy23
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On Wed, Oct 19, 2016 at 06:04:49PM +0200, Alexander Kurz wrote:
> The MAX14656 USB charger detector, also known as "AL32" is used to detect
> the presence and capabilities of attached USB chargers. The device is
> attached via I2C plus one interrupt line to signalize events.
>=20
> The device can be found in LG smartphones like LS665 and LS770, compatible
> devices are present in 4th/5th generation Amazon Kindle readers referenced
> in source code packages as "Maxim AL32".
>=20
> The initial version of this driver has been extracted from LG source code
> package LGLS665_Android_Lollipop_LS665ZV3, enriched with information from
> the Kindle_src_4.1.3 source code package and adapted to the current power
> class sysfs interface. Non-Standard Apple chargers which the device may
> detect are mapped to the USB Battery Charging Specification Revision 1.2
> class USB_DCP.
>=20
> Signed-off-by: Alexander Kurz <akurz-3EoFODjbY6Q@public.gmane.org>

Sorry for the delay, this fell between the cracks. The driver looks
fine and I have queued it for 4.11.

-- Sebastian

--3zqtffriqv5yyy23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh9RKYACgkQ2O7X88g7
+pqMtA//dIzM3mFvvwYUMGfCBBPpnu6y6U0wzUsYBbxR6vwSl6+kyYUefw/mgDCq
SCHv7nFCLw96bSajr7ktGoqpCHW4Ncm4vhgpvTc/y6whX9WVvdqaWzk94DgwHVlj
c8TUY7FJ/qLVyIpVjLXYfQBZH1Zgy3Db8LXuA2R5T79rz5A8nE5MKQ1tjS3a91x9
xCPkLYU1GcxRBo9xGDWHemzosThPaFy71rH5p70/RKUlZESs/643e+HLlyTqTqpU
MDm6eFgwQz6SCOq5Ek/T0Pt9rj9HER2yrxdPbTEnqFWAIc/W00ACOvYZhvvdKMnv
+7yaNB89BwE/ePwH6rgrA3e98Lt+UK3rLv4ezUd34P4IqUUguW2yCFBm1iSm08U3
iBiUMn+3NtJgH5tMb1HL0Fn9yxvmGUSBJ9dsrE/TQhVZ3d9n/ykXVMpxIEx27FgS
n1p4t+XR279jrZvIRPow0+k8GWNsHz2CoQUTGKWi0KUAcZyjkfaVpSWOw37ABKoy
/Oz9CWCSFjlaV4ubzs2lal8WNE38X7kEEuYv52P/yzJCuv5waEC0G2ej3plQcFV8
9cUG8iWanDQ9BCkOfGJpYguCKD4n+QP3isbuoLHvOReMsWEvMqfC8YStWFigYyLc
nig3RQdLuBqY9CV5LCs8CTJ2spoCx3Ska1WxknENirS2rZbwMvA=
=h/eZ
-----END PGP SIGNATURE-----

--3zqtffriqv5yyy23--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
