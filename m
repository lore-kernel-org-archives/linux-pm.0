From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [GIT PULL] power supply changes for 4.2
Date: Wed, 24 Jun 2015 06:48:28 +0200
Message-ID: <20150624044828.GA27303@earth>
References: <20150623005302.GB24028@earth>
 <CA+55aFx_X2pj=b6qzx5HcGByLmucKSRrbyCpVmZjo_fQ+yiYxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42563 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879AbbFXEsd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Jun 2015 00:48:33 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFx_X2pj=b6qzx5HcGByLmucKSRrbyCpVmZjo_fQ+yiYxg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 23, 2015 at 04:13:34PM -0700, Linus Torvalds wrote:
> On Mon, Jun 22, 2015 at 5:53 PM, Sebastian Reichel <sre@ring0.de> wrote:
> >
> >   git://git.infradead.org/battery-2.6.git tags/for-4.2
>=20
> So I started wondering. Why do you use infradead for one of your
> trees, but git.kernel.org for the other (the HSI one)?
>
> That just looks odd to me.

Since I simply took over the existing repository for the power
supply subsystem (commit ad8464a2f31a54560b17d5fc6b1cca5fa68de83d).
This was not possible for the HSI subsystem, so I used
git.kernel.org infrastructure.

> Also, something in your HSI pull request made gmail unhappy, and
> it marked it as spam. Do you send the emails differently too?

No, both mails were sent in the same way.

-- Sebastian

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVijaYAAoJENju1/PIO/qaEOAP/3BXXHYfaBkwGfFkIoJPsPmm
rudPTT/9eAzq73l8pOsBvyg8VWlpXfahaxMSaS2wUD+Gx0wEeMj8QzXbPY0Teom7
T+3Cm4Gxef9t5gwvo88FdV6N4T079PxVo61sVf1vevpG8aNDcd9h6muXzxTRZIBd
Nkc4+BHHJjlteuw/mS2lQGFvlJrXPDNeqRuifLWEhtDmavvwLWD9Arpj01SeZN+L
UkwvsGz0cY1CaasNNrktr73dR8JugI4C4R7m1HZGL2+maMKnKz8oLAaPzWmVcqtW
3gt/LyCxqo8syNwzdOv4u0+EqFdtnI1rXosAB6MFAztlr6uH5qnOMRs+jwmh8gni
WZAw7q//vhEjW9ejWt+2G/ixOSYwqNjiVVktGZeYUZmJEJ4YkhOyxFsAIr8/GSah
m6ORWJ7Yqz91WuNZSPiKhOvCyFWhiDbt0crho9B2jxBBp4dmIK4zX98Tz0cRr0Fn
fCKZYY7QLz7Oc8XdaQg1HWbpA/awHkRH/01MgpKddVp+A0Ebr7L6PwAf4lauW5B0
3YfzLE2pgqsbJNjRAUOC8Q9Tuw3vADuTsiFMUqtp0MAmUO1kPtlXaCxGPg+MI2lY
eV20h3p/zm6nU/qLLbmfXo7pu2QJ5Tbax1mNiJo+LdkU3QCmWxCY42q1pcbfH4Qs
z3kgkNX54fWpjX9pIZc9
=w/nH
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
