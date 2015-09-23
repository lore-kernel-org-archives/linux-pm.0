From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 0/6] Add support for additional bq27xxx devices
Date: Thu, 24 Sep 2015 00:43:04 +0200
Message-ID: <20150923224304.GB4024@earth>
References: <1442950511-16122-1-git-send-email-afd@ti.com>
 <20150923164217.GA27606@earth>
 <5602F23D.80700@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49410 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752320AbbIWWnP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 23 Sep 2015 18:43:15 -0400
Content-Disposition: inline
In-Reply-To: <5602F23D.80700@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Evgeniy Polyakov <zbr@ioremap.net>, "Andrew F. Davis" <afd@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[updated receiver list]

Hi,

On Wed, Sep 23, 2015 at 01:41:01PM -0500, Andrew F. Davis wrote:
> On 09/23/2015 11:42 AM, Sebastian Reichel wrote:
> >On Tue, Sep 22, 2015 at 02:35:05PM -0500, Andrew F. Davis wrote:
> >>This series adds support for several additional bq27xxx devices and
> >>makes a few related fixes.
> >
> >Thanks, I queued all remaining patches. I wonder if this driver
> >should be converted to regmap. It supports lots of chips now and
> >it might be useful to get register dumps from debugfs.
> >
>=20
> I was thinking the same thing, but this driver can also communicate
> over the w1 bus which doesn't look like it has the regmap hooks yet.
> So I never really found a clean way, outside of bringing up regmap
> on w1, to convert this driver over.

Right, I assumed there was regmap support for w1 :(

Evgeniy, are there plans to add 1-wire regmap support?

-- Sebastian

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAyr1AAoJENju1/PIO/qaqN4P/17bxVClACh2i2UzR6LTHvqe
HlU7pCwtTqNvDJ2TsCjXV+UAX/WcNA92U5WcWZPKEP5jApLVf88c2nevn5E4nJPY
YohDpdXFjajaozWd209khAS9sbTFArq/vWcUHD8+FmxJXsfguL9H5Jujco0PJvZ4
rfl9pK2wrdQuX7HLQZx1F0cwY29C1Ppxey/A6QoHtcfR9VWII6YV6GkLBkr10pM/
CbtufdW7ZfZQwjRN/9/0QU6y7ziskks9P1/C+H3eRoT2ogYDzZJCvOelsLcFexA4
41c9L+UeZYpyn9vMxAQM9Sbok3sD1Cs1IPM2ZYK/Gjsutks+adPnl17hvr4jHTN1
N4LWGnNCsqABu8mneQYY5RdnF5pfqlPy5tyjgfctJl3/6mdFHUK9Ct6/zsvFnOf9
oppgyGvZekIsm4zqnvl9M8ktFJ/E6/7pVU4XUS3kT93OG764lNC/5oAOuAbpnKV8
0NyLBVjNHj12b/US7rORFaRtExBsyKslk9n9D/bSZiSwOlExtKp1X32EcJ8aoBZM
6z1SvyItKpSmtlCgZKe6wnnDPCtxWfl/xclOY7eV2s05g3MF5KF5OM3Q1tUcysLM
VODfsebq/n5XDuvrsa3ZbVbySjGSmDRK8yc1lX/EJM8yHdfR1y50pMH2z/Ko7eCO
/aEZfz/ph2sG0dwOkh7n
=zQDF
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
