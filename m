From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 11/11] power: bq24257: Add platform data based
 initialization
Date: Tue, 22 Sep 2015 21:29:35 +0200
Message-ID: <20150922192935.GB9949@earth>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
 <1442612399-341-12-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45212 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758351AbbIVT3q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 15:29:46 -0400
Content-Disposition: inline
In-Reply-To: <1442612399-341-12-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 18, 2015 at 04:39:59PM -0500, Andreas Dannenberg wrote:
> The patch adds a way to setup and initialize the device through the use
> of platform data with configuration options equivalent to when using
> device firmware (DT or ACPI) for systems where this is not available.
> ---
>  drivers/power/bq24257_charger.c       | 117 ++++++++++++++++++++++++++++=
++----
>  include/linux/power/bq24257_charger.h |  29 +++++++++
>  2 files changed, 135 insertions(+), 11 deletions(-)
>  create mode 100644 include/linux/power/bq24257_charger.h
>=20
> diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_char=
ger.c
> index a1068291..6cc288c 100644
> --- a/drivers/power/bq24257_charger.c
> +++ b/drivers/power/bq24257_charger.c
> @@ -27,10 +27,13 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> +#include <linux/gpio.h>

gpiod interface is also supported for platform devices. Just request
it the same way as for DT. Read section "Platform Data" in this
file: Documentation/gpio/board.txt

-- Sebastian

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAawcAAoJENju1/PIO/qaRG8P/je3zcox+hQu8GZK6fmcY0iU
Z5wV1xj4MtBMMT7HwuNNqaO4HT0BpSok8H5XGnBLepvlmAFjDD8zQ2vLwK6dwwku
Xsjk9BwlpKk1mQGnBytrBrGEFnTLCHsYkiFeaN1r6FVTsR8iMZkmoAxT2psLSVdV
RIICQnfKr0gsUeq0D3T5xiOy83XkPwL5VQnUNRAJiNtBE8f36kpSrS1l81zBBv+I
79+TSBZft5JTjNRO5U5LQkH/nXVj4bsuPHp9GO7FQdl4zfQ/kRrGtD0HBIZviIV8
aY+MfxhBzAQE7STlA21+VIEyQ9HZhOo58V5nIIWqUtjacNDV6s2qIeyUUsYEhDm5
CKc9adyRJZl0Jw4d5RDcwdEablXVwSqNff8DFfbprnXjMwu+TXK/VpJzO5WpCf2p
BOVnia1qAJpZka4YexQ4WE1wwf6nHdKrHrhdvSL1LT4AjQGFPztZeuviJkEKqS2H
fY6OfDP/DV9hiR6E4ymOxEjGxYiNKh5LV8E3hSAO/lIGKFMGaQDVILDH2bK5EUh0
qLYfPqn66LeYXSycXgsY/wen4NRML+q7baIq9d0USDM2zy3flLIVOhl5IBHQSM3t
b0DW4hhxTukFLH54iJEk5Embn8Jl242Pu9L0zSvYSqHc8Wm7bND/zqXODBwqeDB6
9HUwKGc/jDjB+zPj8P0K
=0ZGD
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
