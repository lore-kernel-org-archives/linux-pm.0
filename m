From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 0/4] bcm2835: add thermal driver
Date: Thu, 12 May 2016 15:58:55 -0700
Message-ID: <87ziruano0.fsf@eliezer.anholt.net>
References: <1463063738-11506-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463063738-11506-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain

kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org writes:

> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> Add thermal driver for the bcm2835 SOC.
>
> Right now this driver does not set up the thermal device
> itself, but relies on the fact that the firmware is setting
> the device up correctly.
>
> Also it is currently only reading from the register-set.
>
> The driver also exposes the registers via debugfs.

I had looked through before and decided that the FW was turning the
tempsens clock on and off at runtime so we'd have to go through it for
checking temperature.  Looking at it now, though, it keeps the clock
running the entire time and just does a read periodically.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXNQqwAAoJELXWKTbR/J7opekQAIKHfHZ85R8Vm8SfRWvcMcnf
Y4GUVkfoXdszl8NJfTQKwMqCNBMBkuR/7JICmnABpx3c6C3KK03Sxu5qwhue9MuH
I/IFkcCAzUIS4ihiNxF9cWdeDVTNFaS0NqglM6lGI6dhV3abMlTV6jVtWyYe3kg1
MmUqrn9xhZUBAh9XWIJra46A6W6VNEX+MjyHjBvFqQ4Ar7Z4gI6YzzJhB7F03+qT
l+fuCGmWK5juvhjm2rGmnTuiHtidNN4SsgAXP3JCyrBeQOf6w2R/+EA8ZoALCsV/
W2oShopLsP/GvKN31UDk7c9tIT9pN0JTbKCtlhEPclxuGcY8HRRDy3m0QrwMfgiZ
Dkexaw1zKU1DPPYvQLVgZHvao42jp+/WBhDKJIRZU8nDuYGFfWUUacDz2W/f+wGB
auWo5L1P241SekPPMVLsYgeyNXrQ3okLskArNz7RQdMBcvuxGjTs5lajpnmPfolA
svJ1yZqwOW4pipitbX/jTPQIVoWCGP6JVyheajStKz0AEihB/JNcc0oF53bTiA2x
n4Gml9iXOkuMOOVmHEg7LRzC9E+0BwfdCYZWTXbF4p2HSD+lEDg+4iLH2OcuJcWt
AbUFZ8xw/oacg0JAg3YzHj3FMoGnJv872IxKYFqG746hWplL5C0QWAcJQe32I/32
NZwwXDSP9i9neUoSNit/
=Pm3C
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
