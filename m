From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 0/2] Add support for Smart Battery System Manager
Date: Wed, 31 Aug 2016 17:10:44 +0200
Message-ID: <20160831151044.xftg6k5f66n53jem@earth>
References: <1bIiDr-0004G1-0P>
 <1472156461-25180-1-git-send-email-karl-heinz@schneider-inet.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jv7h5xtxyz5e2qhv"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472156461-25180-1-git-send-email-karl-heinz@schneider-inet.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Peter Rosin <peda@axentia.se>, Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org


--jv7h5xtxyz5e2qhv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 25, 2016 at 10:20:59PM +0200, Karl-Heinz Schneider wrote:
> This patch series adds support for Smart Battery System Manager.
> A SBSM is a device listening at I2C/SMBus address 0x0a and is capable of
> communicating up to four I2C smart battery devices. All smart battery
> devices are listening at address 0x0b, so the SBSM muliplexes between
> them. The driver makes use of the I2C-Mux framework to allow smart
> batteries to be bound via device tree, i.e. the sbs-battery driver.
>=20
> Via sysfs interface the online state and charge type are presented. If
> the driver is bound as ltc1760 (a Dual Smart Battery System Manager)
> the charge type can also be changed from trickle to fast.

Driver looks fine to me. Waiting for Rob's ACK on the DT bindings.

-- Sebastian

--jv7h5xtxyz5e2qhv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXxvNxAAoJENju1/PIO/qa49wP/3McyNdIOMNdL9ZRQkC85q1A
EPs24jdq5hbqrM8AR1fVTQBE+5FgfB4+lW/W7JRLhRm2+wzDSXg8ZyiWHJO9toiz
aRNlsOpXwGMxXqmZfkX9LhicKnF8qJ5sQLpP1PIMoBWNoUKwkpGNj7HMH8ZrByOx
XsYBGeTqMZy8nlD190E2DFktcFQzqfYDeg8QEGOPZyCnP4NrfFlFq5dQ4HAjorM1
sgXIB4uTlxj5uSnfzFQWbqd2S5PC/mW6XNH4MBpOrqdLjCquvfMqDQR8rX02tDyf
QoziunCB2/rSDOcOFdnMyfqlveZ1v1teUtPmhOfRDzgGfoLGEBV2jUsu1zlbCBvx
Zz53zlkwDWBqMQVZz2ICHcefOPfqi92Nhssf/o3WsHDXJ2L/a1XGr1geerI8FD7B
95XN8nZ4Dvx38mBNugJa20Mp2BmeR+24fAZxMQgHrBCkwAUh8FVXbZfsJiVaH+n7
JfdAusuVJ6HHpxiSNWeeXRkvG2mmPiqeMlgN+8zK9V+ndAf9L/1296083n74ochB
40F3IoXIMdxZlgiK3oHwyESkI6ou6hBamFI70aSiKfoVPilKPjKMGu+86TSkqmuO
vPe7c8RZ4xijBG0GjGYTATnKlnj2WoTAlx/f0f6mQSoYtkW51P18u4KQNylghBqX
oTbVk894oMY8vLWlj/Hr
=WrQJ
-----END PGP SIGNATURE-----

--jv7h5xtxyz5e2qhv--
