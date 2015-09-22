From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] max8903_charger: Convert to using managed resources
Date: Tue, 22 Sep 2015 17:15:31 +0200
Message-ID: <20150922151531.GD2533@earth>
References: <20150917132500.GA12639@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43985 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754464AbbIVPPf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 11:15:35 -0400
Content-Disposition: inline
In-Reply-To: <20150917132500.GA12639@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 17, 2015 at 06:55:00PM +0530, Vaishali Thakkar wrote:
> Use managed resource functions devm_request_threaded_irq and
> devm_power_supply_register to simplify error handling.
>=20
> To be compatible with the change, various gotos are replaced
> with direct returns and unneeded labels are dropped. Also,
> remove max8903_remove as it is now redundant.

Thanks, queued for 4.4.

-- Sebastian

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAXCTAAoJENju1/PIO/qa0EIQAIDFfOeY9tZ4DVUKvucFGc9y
lb8v0Txl8LljowkP36ttgk/kXpuTRD9b1+GnkY8J6VQSHJwUUrd7EUNjkVVQ4I+A
QEVCkGrT3FhQzXMQ4ey4Q8Fk3qmFBkN52WWnwKm3bgOVmQxbDhzo3bek/bNEstls
MuswoxumqPu+zB0qWzysssawo5YMNa9gG9uDMjVTqcmCF9obXFdnVdnUC8KZjnpf
DiD7PkKEIYBMnN3FucA9CZDNNNdaFn/AoBU/0j3+gqwliznSfMPIW7TpQO/CcfYz
YtEt1gHMrsE4Q81t3eskyPH4GudPQxeIF+zdyfkCEPkUmvHZAUcdU/cMSMRZGVF+
5zPik3swfFC7JSqi9E7Dl+lkadgVVt2IIrjY56h4imJWOhQSX2Yi+aFfO6v5wGkX
iMmyT/In/43PnYg2/SG5ko1k18iEgQycYDiUXS3QDAiwE9S+1La3Tve3quRMFibL
pbvXHBPfooMEQ2v0t817tcPjMSKNtl9hmDFTWBBvPlAkpepbC+J+fke3ZYJjfWmr
4Zlfp7VBvsPgU9one2l97fioAirtVTj84KlCvQCGE9oOMpLc4TMmpcfhd+omsS+B
GRoWbOBfOqgnJXPnGzDDtxbb6VKp6Xp+quWxGR0BgMvY21HvQ6qTWOr03e3PiCGS
+fnmL11MqCe2rqJ62BFx
=A5dE
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--
