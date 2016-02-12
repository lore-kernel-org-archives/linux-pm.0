From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Prevent runtime suspend during adapter
 registration
Date: Fri, 12 Feb 2016 20:04:10 +0100
Message-ID: <20160212190410.GK1520@katana>
References: <1455201363-3278-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yr6OvWOSyJed8q4v"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455201363-3278-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--yr6OvWOSyJed8q4v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 11, 2016 at 04:36:03PM +0200, Jarkko Nikula wrote:
> There can be unnecessary runtime suspend-resume cycle during
> i2c-designware-platdrv probe when it registers the I2C adapter device. Th=
is
> happens because i2c-designware-platdrv is set to initially active platform
> device in its probe function and is a parent of I2C adapter.
>=20
> In that case power.usage_count of i2c-designware device is zero and
> pm_runtime_get()/pm_runtime_put() cycle during probe could put it into
> runtime suspend. This happens when the i2c_register_adapter() calls the
> device_register():
>=20
> i2c_register_adapter
>   device_register
>     device_add
>       bus_probe_device
>         device_initial_probe
>           __device_attach
>             if (dev->parent) pm_runtime_get_sync(dev->parent)
>             ...
>             if (dev->parent) pm_runtime_put(dev->parent)
>=20
> After that the i2c_register_adapter() continues registering I2C slave
> devices. In case slave device probe does I2C transfers the parent will
> resume again and thus get a needless runtime suspend/resume cycle during
> adapter registration.
>=20
> Prevent this while retaining the runtime PM status of i2c-designware by
> only incrementing/decrementing device power usage count during I2C
> adapter registration. That makes sure there won't be spurious runtime PM
> status changes and lets the driver core to idle the device after probe
> finishes.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-next, thanks!


--yr6OvWOSyJed8q4v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWviyqAAoJEBQN5MwUoCm23KsP/AvtJLHZ52nbF4FlCEdO6Bre
YA2plkN2t/UQ7EbetcLbeWRQyIF1xdW5tnzefUJaABIzwoOK2noiTYm5cpD5ULp/
ysyJAvjO68+YyRkweiQ1vwiYmILcbCPyKid7Kz8imbnlKHLIKN1qynMZn+I5j6kt
ef24YmVz8nEdLNsO1TR8TYWrft0ebDSfnfS1m21Td67gSYvCFkNhC2Hnw79ZV8Um
vACoYKd5LNiSmC0nd+bozkaTKesXaEf2SGUDxbGWhNxs8X1o8qDcRuqPPRv93iVM
g6ZHKBLp1/R0i0clB8nKvdIxTgayKOPzSfDcpx6RgmVXEKqKE2tc/SILVsXhBev2
MQPy4etQDvNhpy4WFIwGltcPsqflBuMOyt9A3RivLTiX0JF/G3RMdBsHp2DYHJHs
EL/6iWTnT/4oCB482rGGHf/ruFE1gi23zY3ZaBDVfGtg8rxEed4OmUYJPBelNy3t
6yqdATR8jfNVR+nkTdrDwSGmDhmSLbO6jVQJv0ge9gbF/mzYBSCxrwsCy99b3Scz
8Pxu38+5/lexfZqGi2TwTKDTCPRvbjc8/lhRX3VuHGvXwtY2VvNOamMnGghIV1CW
GOkYUZmSDOLpJ5MV4ThHjmQcPrijRmWPojpM2itKfKdmVByB8RfVBy0k90Uj1nWr
hYmCKymJT6TErUC1zSpY
=rYki
-----END PGP SIGNATURE-----

--yr6OvWOSyJed8q4v--
