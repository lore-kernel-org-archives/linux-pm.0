From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v8 06/11] power: act8945a_charger: Fix the power supply
 type
Date: Wed, 31 Aug 2016 16:47:22 +0200
Message-ID: <20160831144721.hbletwaxwefkih4a@earth>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
 <1472109599-21915-7-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2zfjl5naqtwtsnnz"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934320AbcHaOr0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Aug 2016 10:47:26 -0400
Content-Disposition: inline
In-Reply-To: <1472109599-21915-7-git-send-email-wenyou.yang@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--2zfjl5naqtwtsnnz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 25, 2016 at 03:19:54PM +0800, Wenyou Yang wrote:
> The power supply type property is varying as the external power
> supply changes. It is not a constant.
>=20
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Thanks, queued.

-- Sebastian

--2zfjl5naqtwtsnnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXxu35AAoJENju1/PIO/qaF9AP/3Xo9wmpTPAI4LXFeZ7UNtOk
QHBjtTmmLC7yl21qawhENu2Sf/mRXB21A/aJ/gT7QEvCOC7fyjgCi1iOsoYRwexQ
Kkh24JuQpXLx/phE0tTkTi1DCU8vAk2XrONwbOvsJhlFFY7Ihk+OB40G656HQnBI
oAHVogc+fwkrTET4BvD0cQCrcUy+jeDFxtF1gOJizSKvGwtGYfbG/I99vd0OLwZr
h4ov5wmb6pf1fj6xfbr3dY+D9muFYJh9h74oI6O5+TKfkJCvs49NbVs5TW0Xo+Js
zEBjXBOkre6ICDuSC1qmdb2BGh+PaLOM0TF31AQxRBC27hrwKsCmxWwtH1VllwVg
LSGLWksB4BYi4zDh4pHi39/CgtnJvPrCW14vc66e7qlxhgBfMcjSTvQnOcsS+BXs
9tjYZBf0xyou0CnS+QLxiSNyKcaHwkxVGGz7+D+kxEJoZG5kRFvn88UV53k39oDq
NJCy1gfPF1UXhpg8ZK6m57miOrr+AzjWG3NE/5hcZoteddji8RjZL6EphjKzMiCS
dccjsLUmhhT6OuJs5jkmp1he4uP0TJQECAIcjdoQ6780gXqx9LxwjOuvRBwLdEKi
bqQf9Vccq13pRvK5yHvmR4wb6QsfHl6sboV2bMnxDuR8f2dAsGDVMNx7F2k/KuDe
YCWAWO1CYCan2G2WbMwv
=Kz12
-----END PGP SIGNATURE-----

--2zfjl5naqtwtsnnz--
