From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 4/7] power: supply: bq24190_charger: Never reset the
 charger chip
Date: Thu, 23 Mar 2017 11:59:46 +0100
Message-ID: <20170323105946.53b5pwq252orqea7@earth>
References: <20170322145536.30570-1-hdegoede@redhat.com>
 <20170322145536.30570-5-hdegoede@redhat.com>
 <CAKvHMgQ0XCuYg6MG4x+gouNPSoNKvmpj5x79_J_3PxnGKZkfUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ppmhxn7mppmg6nv3"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932133AbdCWK7v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 06:59:51 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgQ0XCuYg6MG4x+gouNPSoNKvmpj5x79_J_3PxnGKZkfUw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>


--ppmhxn7mppmg6nv3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 22, 2017 at 11:41:14AM -0700, Liam Breck wrote:
> On Wed, Mar 22, 2017 at 7:55 AM, Hans de Goede <hdegoede@redhat.com> wrot=
e:
> > -static int bq24190_register_reset(struct bq24190_dev_info *bdi)
> > -{
> > -       int ret, limit =3D 100;
> > -       u8 v;
> > -
> > -       /* Reset the registers */
> > -       ret =3D bq24190_write_mask(bdi, BQ24190_REG_POC,
> > -                       BQ24190_REG_POC_RESET_MASK,
> > -                       BQ24190_REG_POC_RESET_SHIFT,
> > -                       0x1);
> > -       if (ret < 0)
> > -               return ret;
> > -
> > -       /* Reset bit will be cleared by hardware so poll until it is */
> > -       do {
> > -               ret =3D bq24190_read_mask(bdi, BQ24190_REG_POC,
> > -                               BQ24190_REG_POC_RESET_MASK,
> > -                               BQ24190_REG_POC_RESET_SHIFT,
> > -                               &v);
> > -               if (ret < 0)
> > -                       return ret;
> > -
> > -               if (!v)
> > -                       break;
> > -
> > -               udelay(10);
> > -       } while (--limit);
> > -
> > -       if (!limit)
> > -               return -EIO;
> > -
> > -       return 0;
> > -}
>=20
> Let's leave this in with __maybe_unused.

It's named __maybe_unused instead of __always_unused for a reason.

-- Sebastian

--ppmhxn7mppmg6nv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljTqqIACgkQ2O7X88g7
+pqQzRAAg3mk71QbxJ6mvd8ctEgME5xFBzFL3aVLs7EPK6bfeagXjb26Dn+RD2pY
hcxDBwEzU6qcFNxv8yVZd4WuWfEue0RGFXp7wrOTZ+dwACI2r2evr4DMFPgGeq+/
9saTkbTy0xqXTKVfMymdzQQ4KdR3BLhh5nonJm+q8wjgLUimLGy599RfAzF7ZNF3
ZfJJ/RCRDVYrW6a6i9UPoErY47xcnykhUAuR4UOZJa7YwOsxHAQphRYF0XYEyx9P
Qu7/OAQJKKIoYTqD8nuR+zzjG9tMmB1A7aBtByeI8lNs8W802CAz7baTjW0WAZwR
kgtorpIhivfWFJjEHCy+HcaSq67odLkekMTe8b7OBU6/a4rctQ8ShxSLGAp+AgIj
dLvtPjtm7nBPwMaOIklRKUTbYQGYb+bRKEPlqKuHv4ZBiezc9P0XW6IpGtWeIwTZ
qh3f78QAm5lcNBGPvU18Z5MrZVeA+Hoa1jnb+x9t67Wx80EcXjAxBaqRdkn8tN4e
PLX+DtLxL7S6NIVsZSfi0Xcdg1RKbQ1LW/wJtQquo49wxvLZ4otxT3hjCjiwyzR1
bFjulDCIpFlncgO7AjnYB5wY67b7+a5t5WOWxnnYlNF1tc458t0ImU1NAWu+OfH6
E6vC9rc+12yu4SAStT/AkK0E/vIxLGC6eUFWLX0y+8wiieGJJpU=
=0QPC
-----END PGP SIGNATURE-----

--ppmhxn7mppmg6nv3--
