From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: let I2C masters ignore their children for PM
Date: Mon, 11 Apr 2016 15:02:17 +0200
Message-ID: <20160411130217.GB4719@katana>
References: <1460374700-23269-1-git-send-email-linus.walleij@linaro.org>
 <CAPDyKFqXjsrm13kRopVor_5_m_gTfunqfac4ozFL=w1w9k3QEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:57872 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754559AbcDKNCW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Apr 2016 09:02:22 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFqXjsrm13kRopVor_5_m_gTfunqfac4ozFL=w1w9k3QEw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index 0f2f8484e8ec..5e114342dcbc 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -1566,6 +1566,7 @@ static int i2c_register_adapter(struct i2c_adapte=
r *adap)
> >
> >         pm_runtime_no_callbacks(&adap->dev);
> >         pm_runtime_enable(&adap->dev);
> > +       pm_suspend_ignore_children(&adap->dev, true);
>=20
> I guess it doesn't matter much, but I would set this before calling
> pm_runtime_enable().

I was wondering about that, too.


--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXC6BZAAoJEBQN5MwUoCm23ssQAIHhGQsNZjTRv6ZQaRRz7+Cd
whdYgxCDOa4ohqxL6DidoKQsCR456ZT/eomqvPytaR2KV+QwWr1ImAnNF49DKHXs
04Zd8yQy4Qsnep3occQVa0IzHIdjINuyKMNtgT6LLzp5eAHvzae/7Irucx3z6sqf
l1p2bYy2j+lRf9AnXyy/ClTrg/hl/daqye42iPROrqIXd56J5mNwzddo/3ERGxW1
nHPSC5ywduiDDWf0N05Sb0akYo49h3B540ImNE77+MtBshq4jx/QgozSwxvz3SDU
gR+bkGULn+y6VZl5r4oqQlm9en48XZOiQy+JtY5k8JUs5QSiZ+CT1EOxEbz0rQVd
Bogh0b40muEewZSe+YW8nVKVYP5E26tUsuWn59fKGUiRuhPk92A/12SnZW6OE5Yh
qk236/vfy9FrvNPUGm5AO0cQmRtNno5w2YfTomA3CkKbA8IvCW6vgsiUboz9lhVO
J1z/yBn+R6jkwRJ8orI6WhS4UyJi4IKM++udMjacqtmA4eugJWVSAFFy6MulSw8i
HkySGlz15EfCmgkRNZLTOj+Q/mqc+scLT9+Mk+q13SDmophfzFGTh7+/vnLKYcle
5lRNc/jpKqUL0NNfMRej/9xiw2TTxpVwwIma5uOeM7qUG1rOo5qYqV5Aj1ecV206
C6bfTaInaQYrVdTHAtmy
=iVlU
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
