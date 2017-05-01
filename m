From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v6] power: supply: bq24190_charger: Add disable-reset
 device-property
Date: Mon, 1 May 2017 13:14:39 +0200
Message-ID: <20170501111438.tpzitox7zxiaf47t@earth>
References: <20170414165233.4532-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2qky6inckuttbeb5"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57599 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2999001AbdEALOo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 07:14:44 -0400
Content-Disposition: inline
In-Reply-To: <20170414165233.4532-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>


--2qky6inckuttbeb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Apr 14, 2017 at 06:52:33PM +0200, Hans de Goede wrote:
> Allow platform-code to disable the reset on probe and suspend/resume
> by setting a "disable-reset" boolean device property on the device.

Thanks, queued.

-- Sebastian

--2qky6inckuttbeb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHGJsACgkQ2O7X88g7
+ppMcg/6AoYi8qAhRfDA0Gm7GlKCxvNlWrO31a6zaGy9DTRio+byC5WnsgA/t/nR
l1SaRYjQUm2nRAdWFADnU0MD7oqYfKNPZ2QnUGAARIcMbgp0VvAusjyLr6nE9cv4
pHIV9ZU/7B4/pyLfChPrWAsnxcdxFw1ARccYarx3xhSIx70Z0wS52tGzhKT5tQW5
hOuRYXKINiII63ApAtMUbWzivbva+VPO2jsj1lGUzNAxxpq8ta20b7a9/zWFmp2J
DcVoEEd/wXv6oZVpmmf7u4NCwzQYnHFg97TFJP0OAnY0s+/LyuLYxB6yAAfAfGVh
4VREYrMw6D4roT+Oa7w+trhckSv8xb7USAmzRaG/eai+rGCTIxP+CF8TMGdTVUqd
ErEkn89d+DwwDUxsN4caO5nqFH87GQyfL0ccwpK2mcoMJx9Pnc1yUGcjHeBj5i5R
UQd2UBmpYbcemfB8mYZOaK0aHnxhVXl+JjNbOGQpn59PGmjgG+qu9sYEboqOBByC
l2Pf6Fq/9JGmvKW+uaw66gD5XJcxdyix3VW8hsD/emMn4elaorUIHx2xKers636e
Gzvc2wPgplqpFmcwIogevWhdzOC9liQkBdi6dXOJlcF36W8fM2VXIaZn+72ncrG7
m6q2ioRvWqtSN4dZIBf3WEdsC0RVbBmEIH7B+jiirovzYlrKLrA=
=qFHp
-----END PGP SIGNATURE-----

--2qky6inckuttbeb5--
