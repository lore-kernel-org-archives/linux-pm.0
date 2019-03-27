From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [RESEND PATCH] thermal: rcar_gen3_thermal: Fix init value of
 IRQCTL register
Date: Wed, 27 Mar 2019 09:34:42 +0000
Message-ID: <TY2PR01MB48128E8FFB7D26714A61BF62D8580@TY2PR01MB4812.jpnprd01.prod.outlook.com>
References: <1553677398-7896-1-git-send-email-na-hoan@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553677398-7896-1-git-send-email-na-hoan@jinso.co.jp>
Content-Language: ja-JP
Sender: linux-kernel-owner@vger.kernel.org
To: Nguyen An Hoan <na-hoan@jinso.co.jp>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "jslaby@suse.com" <jslaby@suse.com>, "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, hideo inayoshi <h-inayoshi@jinso.co.jp>, "nv-dung@jinso.co.jp" <nv-dung@jinso.co.jp>, "cv-dong@jinso.co.jp" <cv-dong@jinso.co.jp>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Hi Hoan-san,

> From: Nguyen An Hoan, Sent: Wednesday, March 27, 2019 6:03 PM
>=20
> Fix setting value for IRQCTL register. We are setting the last 6 bits
> of (IRQCTL) to be 1 (0x3f), this is only suitable for H3ES1.*, according
> to Hardware manual values 1 are "setting prohibited" for Gen3.
>=20
> Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda
