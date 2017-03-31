From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 3/4] i2c: core: Allow drivers to specify index for irq
 to get from of / ACPI
Date: Fri, 31 Mar 2017 18:23:33 +0200
Message-ID: <20170331162332.dar3f3mval2ch2uh@ninjato>
References: <20170325135550.22509-1-hdegoede@redhat.com>
 <20170325135550.22509-4-hdegoede@redhat.com>
 <1490530535.21738.31.camel@linux.intel.com>
 <1935239d-fdd8-3917-9865-de389e6728e8@redhat.com>
 <20170330203954.GA1452@katana>
 <149df3eb-8111-4c91-472e-f6c708302ede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="34gmuqwk37mjcy6l"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <149df3eb-8111-4c91-472e-f6c708302ede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--34gmuqwk37mjcy6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Note I said "flag in i2c_driver" the idea is that the driver can tell
> the i2c_core that it is not going to use i2c_client->irq by
> setting i2c_driver->no_irq and that the i2c_core then will not bother
> with trying to get an irq in i2c_device_probe(), this is esp. useful
> for ACPI i2c instantiated devices where we otherwise might end up
> returning -EPROBE_DEFER (waiting for an irq to show up) without
> needing the irq, which is esp. troublesome when there is no driver
> for the irqchip the ACPI irq resource points to as then we end up
> waiting indefinitely.

Okay, thanks. I understand the big picture. But does it really need to
be fixed in I2C core? Independent of I2C: if an irq is described in ACPI
and the driver for the needed irq controller is not available, that can
lead to various problems everywhere.

Or maybe you simply want to be early and don't want to get deferred? Are
we talking then about boot optimizations or necessities?


--34gmuqwk37mjcy6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljegoEACgkQFA3kzBSg
KbYyHhAAiZaNfmzUBc11Gh9JZMI1zs1otTiuNYsBc5CxZSpcQzTtrmR5qv6rt8rl
Dmur4KQHkgHyqpPy17I7iORu+1+HfqmQbstDvr8cMoaHDsdqHsRWRKvEmkmG+pMa
xWBA/YqBzJ2Kp6/CNKEltUPvBxdjNCepzVZy+cU0wuq6PUu+9k27Tpu0tildQbaa
CbaEV5hAq0f4Ko6ElZcgP6Z6l7cwUv2O/BbvVCoAYc1lro7BMOrPWBcoL0IuANox
Es50HnmCpLycJau/FkikhsFsVbEuR0lGD80sPcSLgi9qe649hSVhbUTaLs1EXHf3
Dej/lU0+pfa+DqbJ8E5zna3VufjG+zca9rtSrM9k/DfIIlgPP1ytt/sJ2c7164/u
K9H0Wd2m2FJmVvu6UCti60euCAMBHMSexnXXPL2mA1lul+sqRHMWGO7/tVn0IWxo
JIW4Xf/jrVEP6W+GimZfpt+PJgHf0zeduu5gU7zLwt5qil0E5nqgfmYSspe33goc
yrvSbqkTDVQdDrHJuvocZxdBk5Qhn/Bc13jD4ZSQ/kRI3dKnxuxX/m8ToXj39y6N
RSnW91i1qDPVFoMuMc5d0DRt6YrBalIWtPJjNXEBbMYvv81RigPP+cmpVPz4A8ov
e6Mn0hTCrzMSZP2Jm8Feu/5kTINyfGDeKIBx5IIuB3oofduBTMU=
=I8V2
-----END PGP SIGNATURE-----

--34gmuqwk37mjcy6l--
