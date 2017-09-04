From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFT][PATCH v2 0/3] PM / ACPI / i2c: Runtime PM aware system
 sleep handling
Date: Mon, 4 Sep 2017 07:18:34 +0200
Message-ID: <20170904051834.m63sajya32mops4p@ninjato>
References: <1551534.5XKjjnxbAy@aspire.rjw.lan>
 <1529572.3Syt3kfoAo@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cf7zpzmllm7le5w7"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1529572.3Syt3kfoAo@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org


--cf7zpzmllm7le5w7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> To on-going discussion with Ulf made me think that it would be better to
> make the driver do the right thing when the ACPI PM domain is not present
> and then worry about what to do when it is there.
>=20
> So, please scratch this series and I will post an alternative one just for
> i2c-designware-platdrv shortly.

Thanks for the heads up, Rafael, and all the work on this!


--cf7zpzmllm7le5w7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlms4ikACgkQFA3kzBSg
Kbbgcg/9HKUGt01tJFEd4Mdt5j92A2YuABffKowjJoFdw1XXFnn9gzbA+FZ+Jsd+
WqSo5szhkfAiyq3hEK4ZxulZaDolEUBbUI66HRNyQC8M8XgssMDC0QDUmR3Zysru
VrB+IozD0v+4+pdqPSA1VDfjfDk/DnXcUwePu097Ca4y9LI5ZbWNaTEb5P2CfUpY
QKUIhsaG2UltKcD+QCjt2+Z1yfqQZHGzaX/B94FpYx3G+tha2AzXMK7JEi1TsvYX
CadOKsajag+T1xwv3kXri06o2q17fBTXQNwyzA7xqP0Nbxpi3FbOKBbl7J8nu71C
U5+ohi/IZNNJAmuOEDZjwcR98tgwwnbgyVthVB301n2oJtlP5kK1VivOQWHiafmt
P38x2myyL5d2yMB5w2uJBpm9UTDSSvr6yRZzTavZGKikao4TXroAI9ImZYkqFhur
LvtPR2PJjtUEdZbIGGGb/1BDvGpnH01hhHw1E3TLRrF57mBe3ROBNywq2gt1bqrl
bE4NcabD8w8EWWbxwSMa1k34Ij6/fGxbxCb5hC8A4xcauB8EZAm1g+N/Kz6wQ6eP
yZPSMbckz+cpFh6NfU+n5xYfdoy0iqzyskWzcXZdv+ICBO03id+DjAauV3Yf0Zgv
n/6LM0oUXysGIIkEzmGnmNFOQyfQg7JIydi3kzmekuyz+756Q3U=
=uCF+
-----END PGP SIGNATURE-----

--cf7zpzmllm7le5w7--
