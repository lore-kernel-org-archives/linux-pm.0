From: "Y.T. Tang" <yuantian.tang@nxp.com>
Subject: RE: [PATCH 0/3] QorIQ TMU bindings and device tree update
Date: Wed, 4 Jan 2017 09:19:32 +0000
Message-ID: <DB6PR0402MB2837D623CA7FA287642CA5BEF0610@DB6PR0402MB2837.eurprd04.prod.outlook.com>
References: <1483520271-3838-1-git-send-email-hongtao.jia@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-db5eur01on0066.outbound.protection.outlook.com ([104.47.2.66]:49024
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751552AbdADJTi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Jan 2017 04:19:38 -0500
In-Reply-To: <1483520271-3838-1-git-send-email-hongtao.jia@nxp.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "oss@buserror.net" <oss@buserror.net>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Scott Wood <scott.wood@nxp.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Troy Jia <hongtao.jia@nxp.com>

++Scott NXP email address.

Hi Scott,

Could you please give these patch set a little higher priority as Troy's la=
st day is Friday?
We want those get ACKed or address all the major issues before Friday.

Thanks,
Yuantian

> -----Original Message-----
> From: Jia Hongtao [mailto:hongtao.jia@nxp.com]
> Sent: Wednesday, January 04, 2017 4:58 PM
> To: oss@buserror.net; rui.zhang@intel.com; edubezval@gmail.com; Y.T.
> Tang <yuantian.tang@nxp.com>; robh+dt@kernel.org
> Cc: linux-pm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Troy Jia <hongtao.jia@nxp.com>
> Subject: [PATCH 0/3] QorIQ TMU bindings and device tree update
>=20
> As Rui Zhang suggested I combine TMU binding patch and two device tree
> patchset together. He will take all of them after the device tree patchse=
t got
> ACK.
>=20
> @Scott please help to review the device tree patchset.
> Thanks.
>=20
> Jia Hongtao (3):
>   dt-bindings: Update QorIQ TMU thermal bindings
>   powerpc/mpc85xx: Update TMU device tree node for T1040/T1042
>   powerpc/mpc85xx: Update TMU device tree node for T1023/T1024
>=20
>  Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 7
> +++++++
>  arch/powerpc/boot/dts/fsl/t1023si-post.dtsi                 | 4 ++--
>  arch/powerpc/boot/dts/fsl/t1040si-post.dtsi                 | 4 ++--
>  3 files changed, 11 insertions(+), 4 deletions(-)
>=20
> --
> 2.1.0.27.g96db324

