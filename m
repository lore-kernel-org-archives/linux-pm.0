From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] power: reset: syscon-reboot-mode: Use managed
 resource API
Date: Tue, 16 Aug 2016 00:34:04 +0200
Message-ID: <20160815223328.ecvoya42v3ru23rn@earth>
References: <1470287046-17437-1-git-send-email-bjorn.andersson@linaro.org>
 <1470287046-17437-2-git-send-email-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jlqqvpfojimsznkc"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470287046-17437-2-git-send-email-bjorn.andersson@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, John Stultz <john.stultz@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--jlqqvpfojimsznkc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 03, 2016 at 10:04:06PM -0700, Bjorn Andersson wrote:
> Use the managed resource version of reboot_mode_register().
>=20
> [...]
>
>  drivers/power/reset/syscon-reboot-mode.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

Thanks, queued.

-- Sebastian

--jlqqvpfojimsznkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXskM4AAoJENju1/PIO/qar8QQAKjUspjeoKoHR39vcaoJeRWn
ycN2W0aNXUntsOZdSNaw6wDkCvkn4dW+jOsj/kpZTMTw69BuDU0pU5oudcMmmyvk
lyM4nzrtpPPeVEBj3h9+b24e1/R6rh2O3V7jlGYVpbLfL1bZzgNxSc6Kcgy02xD9
rLGFS7po0hHJhi5P1HE3X+fCaHGZq0d8N1z4/4U5rXIeRDdhipS6wzulu4hNaN8z
w5VYwRoDwFcIJo1wpH6EUaiI78K2eW4ogx3vuL+Tvzkf2t7MTM/j7l6Vn8NVaLJb
bXpKB0uppGqSMdsd6fOHq8PtscElNVoACshUIJA0/w3RbX7fxSqWFpboEThzjNhj
5QzNMbrZiOGU3FFeYzGmq0cDVwv+58NFCYv+8lEhEwHZONCkvxXado8XbSuYTDZM
gRItjLrBXGS+qN917O7lAokVpQNut1+FNYV9Fq4MVU29mFpruSQBzI8TF0CRrNX0
p1NxJ9kt6rINoRwywCVK7V75VjhHgxf3QmDbCheKLLO25j0/sJukwA6StM02zh+O
Q05Hf6EEsj3OiDuWZkuhSg/wbakcgkvid+ZXL2I5dIyH4eFaYRNWIMooxRHYmCDg
qp+qhSo3M3xOZkXJyzqjrdQPT2yuGI7AKIdvMgg/2TU07XHL8rgIbm+9W9sm67OM
w6K1zAfYMVazi8rV9Fyn
=VGBT
-----END PGP SIGNATURE-----

--jlqqvpfojimsznkc--
