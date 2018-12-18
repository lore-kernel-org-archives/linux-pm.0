From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC/RFT 00/10] i2c: move handling of suspended adapters to the
 core
Date: Wed, 19 Dec 2018 00:32:59 +0100
Message-ID: <20181218233259.2ufszlpw5hjlg2hm@ninjato>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <2094a0d4-733f-7f74-abd2-bdb28edd0f80@redhat.com>
 <20181211234102.GA6701@kunai>
 <e8c68ef5-5085-e304-4959-82c4959f4511@redhat.com>
 <20181218201725.2uqfmsethlkasdvc@ninjato>
 <0e6b0ea6-e472-19f2-bb2f-61a1d66e6091@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2zqdnv7q2yfssawi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0e6b0ea6-e472-19f2-bb2f-61a1d66e6091@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--2zqdnv7q2yfssawi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I've been thinking along the same lines: your series for the drivers
> with separate runtime and system suspend handlers, "custom" driver
> specific code for troublesome cases like i2c-designware.

Cool, thanks!

> Do you want me to send out a new version of my patch for the i2c-designware
> code?

Yes, please do.


--2zqdnv7q2yfssawi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwZg6sACgkQFA3kzBSg
Kbb76A//brac55lwWTzuGQxjrhsSLEQwELKmBFUMND3qoxvsksj7MPwfUes29I22
/40oqppJtH5pvm9a9oLl1EHmvIPKCmECe1kgp9SqrxRtspuMIIvwVL2YVA23bEsk
g29Fo9oIQ23Le7vsh3CT+9hcfrsyuBUnqbQWdpWQVIEgdzwySeDuRzgF5CbV4951
WiPwMH9+dxt4JnQART5cjHIkjf88TMNLNZah2mv+Qc306U/qvxBNPjKRAfMuyMHt
4axCZ6WwuRGB8uXeFu/fkctno7l7Qta/m1iFHIt3t3nGVAlWdOB/fOqS9H3IX0+L
y4MbbS6WVr+mCjddy1T9UBC9U2GXP29aU6Zn4x9XlcBq7AY/LHAGyvWbXHhuB8IO
j4ZFy0P/2DH4VYDEtJdFFR4abyBzpPQZIR4dNQIIDQ4qPN5aWgs6gcRTJ38j3fdd
neCGpf37wKEBzryrRdC4vbMx4CwoeMIcStDz62ARsOV5fOomyg4w8cL6Xlu1Vt+3
4fIimBvfSzeb+wmSvep+9PPaBzXT99Uft6z0WlpPo2oRIS/x2ryD2livFPQYcxkE
a0zyiy+8pYgfhrRc4YYp1K2LEJi2dJWBl0dDMyQMT3Wp0qPL02MAVsUEcodWqP6e
lNasaYCIBijQlWPK6UmIt7ajsXAyXO8TrUZPXFjBK50hFwWYgSk=
=m5jJ
-----END PGP SIGNATURE-----

--2zqdnv7q2yfssawi--
