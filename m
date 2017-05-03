From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 2/3] drivers:power:twl4030-charger: add INPUT_CURRENT_LIMIT property and make it writeable
Date: Wed, 3 May 2017 14:18:11 +0200
Message-ID: <957290C0-85B4-4077-9D68-B08FE3232353@goldelico.com>
References: <cover.1492194356.git.hns@goldelico.com> <ed229ae8e6a4a9bd040e389d101b5257296d54ff.1492194356.git.hns@goldelico.com> <20170501111546.hmc7evtz2juyg5ur@earth>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_19E49008-3B25-44B9-AEC0-0E039AD60BFB"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:18531 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbdECMVc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 May 2017 08:21:32 -0400
In-Reply-To: <20170501111546.hmc7evtz2juyg5ur@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org


--Apple-Mail=_19E49008-3B25-44B9-AEC0-0E039AD60BFB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> Am 01.05.2017 um 13:15 schrieb Sebastian Reichel =
<sebastian.reichel@collabora.co.uk>:
>=20
> Hi,
>=20
> On Fri, Apr 14, 2017 at 08:25:56PM +0200, H. Nikolaus Schaller wrote:
>> Currently, the twl4030 charger defines its own max_current by =
directly
>> creating sysfs nodes. It should use the input_current_limit property
>> which is e.g. used by the bq24257 driver.
>>=20
>> This patch adds the input_current_property with the same semantics as
>> the max_current property. The code to manage the max_current property
>> is removed by a separate patch.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>=20
> Thanks, queued.

TNX,
Nikolaus


--Apple-Mail=_19E49008-3B25-44B9-AEC0-0E039AD60BFB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJZCcqEAAoJEIl79TGLgAm60B4QAJI+cQ/nebeuDvzJi2Spf6/+
O02KdGoay2RAqRJohGPxpZpoaCfZN92aGeh0j0yEG/5Xsn+bq6vgiUpNQP+wZLFV
v9dvs51+Ksgmu4QMxN2lZUkCblz6ttFg223qiGm9wC07f1K3oXMc/ZJRfTFv89YN
tK+DZZXskp1eZUDogU1eGw2NUsOHEggp9qiuHDaAFW+wrubDLntneV7h6kV6BU3b
Cg6VU2erowH6vaGaGLwgz/N8VBgxTs3Gz+PIrrwt2QWc5J6GfHOD+rpJk33TFUO4
tI6MQrciMH9z93Bk85PRxowLANt9NQN2wqepq1Fw1ZCre5JRQYMPka9EC5F94Wvt
KsQuF64YREa9qby9Zs51yYnJRSiMu4AR16oEwmEsShnHHlcGWQUBecKZk+jUdCc+
fELzhHcUtVC0s/BJu54TdeaE/iDjnshU+xRhiHgWDW7nEHHKH2gbWMG7MJfVvDGL
0h0CLyhDueZ1HrdqirurjUOhqGEt7lKuMN4OIgLOigkKJlz94Ff1EBF9pGr6MSwm
l6RRcpGDTkGeQiDnV5Bw/Ydk4WNJhsYH7E2ykUKYJsR6RSKf4PG0Fro3i9VTxFxh
hB/jsrlRjdQm5K9Und9euiONyZFu3IPPgH1+gXnDYkgdg+GqPqj27lMdo9fBZl8m
3gLdDH+jm/EPgp5kmyh9
=FlW1
-----END PGP SIGNATURE-----

--Apple-Mail=_19E49008-3B25-44B9-AEC0-0E039AD60BFB--
