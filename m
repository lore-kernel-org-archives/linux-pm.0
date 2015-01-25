From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
Date: Sun, 25 Jan 2015 16:04:31 +0100
Message-ID: <20150125150431.GE2719@earth.universe>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
 <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
 <20150121230148.GJ13715@earth.universe>
 <54C0AFE4.3020701@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54C0AFE4.3020701-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

[add maintainers from regulator framework]

On Thu, Jan 22, 2015 at 09:08:04AM +0100, Stefan Wahren wrote:
> Am 22.01.2015 um 00:01 schrieb Sebastian Reichel:
> > On Thu, Nov 20, 2014 at 08:14:36PM +0000, Stefan Wahren wrote:
> >> This patch adds a minimal driver for the Freescale i.MX23, i.MX28
> >> power subsystem. It's required to trigger the probing of the underlying
> >> drivers like on-chip regulators. Additionally the drivers supports
> >> the configuration of the DC-DC clock frequency to avoid possible
> >> interferences.
> > I would expect PLL to be board specific and part of DT. Why is it
> > specified as parameter?
>=20
> I think the switching frequency of the DC-DC belongs to the
> configuration and don't describe how the hardware is connected. But i
> don't have a problem to change it into a DT property.
>=20
> Does a common property name exists for the switching frequency or would
> it be vendor specific?

As far as I know most regulators have fixed switching frequencies,
so there is no common property name so far. I added regulator
framework people, since this property should be regulator specific.

Apart from introducing a custom/common switching-frequency property
the dts could also expose the PLL like this and use the common
clock-frequency property:

power: power@80044000 {
    compatible =3D "fsl,imx28-power";
    #address-cells =3D <1>;
    #size-cells =3D <1>;
    reg =3D <0x80044000 0x2000>;
    interrupts =3D <6>;
    ranges;

    powerpll {
        compatible =3D "fsl,imx28-power-pll"
        #clock-cells =3D <0>;
        clock-frequency =3D <12345>;
    }
}

-- Sebastian

--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUxQX4AAoJENju1/PIO/qaVucP/3vSrSghX73NcAfK6PxifImL
Wbf3yrEHLhjRkvPzB+GPJ/ylTRl53YeH3TtI26tGsfnvjCMGTexaEJdQd14S2v4p
KE5af9xx4r7cZn6j7ql7TqE1tvvIJ1CuGKVvl8qh+3lbrArmlezId7qMNu717GXk
XIYlfaSNGupTBgdqCJ7kBNrkxd2vkrGnQTKPJ6RPWqg/6CK0oBgmrRACFWRDedsh
61oKkr2LPRKq2k/04/WL+JflwhNMv+dJaXWMH+KO2wOWP+Uerky6Md7fUsNL3Trn
wWA2uCB9k3CdoKPHFGvsI/ypbe0dHNR2pOtFG05tQkx2wFpl16GJrUoAUh2e7Xuu
C2ZopESsPvbpheO7ARn4iI6YsLDTN/t51vJREsJgerSStZ1wiMYhJlVxFFWiiLki
h8X0RFITq1XlpB5DnCuN+HUM6ag/qHlE3Am2A1GJyoTzeXq4cvaw1pOY3Vld40m8
pznXJdJ5pLtFuYKbWHjUaqRobVMRmka9l2D+0e3SqHd51+tCEypvEXJaK7eepb//
V7xG91dfvr8Mh7jhiAF74RJBNK4M2EObOwp8fuuaKMurwlXfqHVkSrXpwU6+N6fo
irvtySipFfTFCIhoiQNeO5nenE3cofbad1ZyxeEsk2u5EWEsHA8Ur+5YnpzJf29m
7ZP0ZpdOASZ+oWnAGhoo
=Rbpm
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
