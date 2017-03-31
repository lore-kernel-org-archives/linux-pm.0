From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 3/4] i2c: core: Allow drivers to specify index for irq
 to get from of / ACPI
Date: Fri, 31 Mar 2017 23:19:05 +0200
Message-ID: <20170331211905.frbdixlix24gt35c@ninjato>
References: <20170325135550.22509-1-hdegoede@redhat.com>
 <20170325135550.22509-4-hdegoede@redhat.com>
 <1490530535.21738.31.camel@linux.intel.com>
 <1935239d-fdd8-3917-9865-de389e6728e8@redhat.com>
 <20170330203954.GA1452@katana>
 <149df3eb-8111-4c91-472e-f6c708302ede@redhat.com>
 <20170331162332.dar3f3mval2ch2uh@ninjato>
 <2b4d002f-9e6b-b193-7dc3-2f4c20a93276@redhat.com>
 <20170331195407.GA1449@katana>
 <0ff7a58f-b6d3-edb2-2751-e30069098c61@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="co6ceiplha5zzcmj"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0ff7a58f-b6d3-edb2-2751-e30069098c61@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--co6ceiplha5zzcmj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hans,

> So I'm going to throw in a fifth option for a name for the flag:
>=20
> "disable_i2c_core_irq_mapping"

I am fine with that. It is only used once per driver, so "clarity over
brevity" from my POV.

Thanks,

   Wolfram


--co6ceiplha5zzcmj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljex8kACgkQFA3kzBSg
KbakDQ/9E68GHOjoNK+Gd6XEq9u+fPcmfhgLqZCOuTvzvLoXQmTwu1uy3V5Vhdrl
g/ULNoMTQuIaedHWk5Gw0+S1spkgpTIQeSGu+CadGSOFZcgQxsFVYOV4E+R1n0rO
hx/gKy8ax39cKbXeNDrfuUrNm5FSWHVi9vkVR54ODzfIr/tXItxndkzhMtycYgKV
uVvH36YoO+X0RUIDZqQnFvnF8kYiBwh2TYoCvCyUHYDvPT76QoDIXZrzKQZU3hG8
HbQ+eFD+F5YurPzX3UwGWg5GOPpVBpnWI/HVrgxDtA/0QMxXCyXanHisLQVjB3Mt
XwrHy4bCRkUPjeAB0B+HcdpejqxODdCVPzSLxj7WcnGlOQ9c7VNA1GuLTFodAfBH
HChaGvEm3VbusNOlBKgDqFSWwCKDn5TKWE6mAU+pjrioZxzSsHRcylNnY6zs7v0Q
IdqRKwK3y1+1/tkz5kClfh/mRrOAwCqlG+7RuoU+4fh8sdSGGN3wTUJWz24cEJOi
t1lfTEqGen544iitRfSn6OeUQk7u3Sxu9ci5bYAm3kkabxvHaZseHakcr830ztWl
jqzu+Y7R1bXzt+MgxEw/9H79w6CuVmcJo8qhkL5z7RDd1kQzAYsocrM/GYWpLilK
3b5XvLTm1cgh9C6LuSlylZPQ6YyAH7qnx0se5ev+WRD+C6jefLo=
=wIUu
-----END PGP SIGNATURE-----

--co6ceiplha5zzcmj--
