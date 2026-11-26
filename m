Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795695994;
	b=UbbwIPaK/OPTPyCYKt2woKED+VR6tNzO7LH/4e0H1nWYXoAt88t8oBbwoSzu+lxQAO27
	 e3uO4jCEuNd0H5+7pzOonggn19lMTM+qOnjrjyxd7FRiS1egG+a7fHzIoZpe6H1j2Wefi
	 8hw6BqzlnLNHBxv1ZW3hwAOYB0hTIWWD/KvnDeb2ixTjhS2Mu3Z6aNqidnMEZ7XSOIZX1
	 8igZvEUg14WtWfRmT77I4xfnylFzB7X8EEQQoirvKqaLrQHk/Lr4KWy3aKjtiCgIgbKxS
	 aYKeiqQTZg+fKPMc82hSd82yhtpkWFoertwcPPtZMGlc/IXJkN4YqiCiNJ+sXaY6x3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695994;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FDf27xnjIY0MGgU9QPmFgOgG3Aq3X7unXOSGnQEZ3Zw=;
	b=5ERXChzpAI81ez6WpGJigWfP/mslB9jbiot993PEPN8mJR4+z1EH2mZ2+ZSwPQwQgl6C
	 eVM1CmXEGdcNLtcrP0knP0Ud9SBhgqTF+4hq/yE3PC4Tc1bKYb3jmTk83HccrYDKJBd5c
	 RidIOPNVyymYSuVIatq+qalxdcSatfMUQrLZXmwOEm2GzZQUUg8olAC1SfXd8+ivoSVV0
	 Tv3HXF9UIPqYui4g439917Rp7m0pxJWPTJpCUHnDc78+ObyPYOP0gO0WjkCJRcWEm5gUT
	 Sz5uarlB1+rHnDIoghsy2cFyF1QZFBP01ZxvcNRXh8NCjWqk7xhHFYVYL+Q9BZeFIbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V5kd7NJz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g+ocJyGF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C220606A31C
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 12:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C220606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V5kd7NJz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g+ocJyGF
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBVQso4128637
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 12:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FDf27xnjIY0MGgU9QPmFgOgG3Aq3X7unXOSGnQEZ3Zw=; b=V5kd7NJzOdG1BKDx
	I5/IfSAIdzSsX2fnwQfRC8Ib6pN0PhViZABr3i8j+TcXy2/+4RuObh7mTfOUhyBG
	lpUcGwqLuHO6d1ShDhOgyP3m1JOqUkcsIyKwckbHs5JsWkzmwIaoAuS5fukPfORQ
	w1QHpcgzG2F9OJzhtLyY0Fo6IYUyGolDMPM9ratJxnB/4aiLTx+vieyBzrm+iZl+
	Um8lBMbrSAUrJcXlqBT8dFm7EvfP13qLnlz5lJsmEFHC5xK25A53GmprtuxoziDA
	Ayopt8q9+tqRTSMPhN08ghhqxJ4nbGuYPxHLR1WxPoIA+gzzdxAq4iBhkiTgGX9r
	qJ1DPQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j62vauwbx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 12:26:32 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd5fd34fee0so3754350a12.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 04:26:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795695992; cv=none;
        d=google.com; s=arc-20260327;
        b=Vkp2SazbnqRnp+lmdOOYHHuLUmc+U2GlwGylPH0TmDTnqs15619Fttu592yuv7mbYx
         M5+6YX+Nhpnik5GCi55JuKN5lKSnRyw+LofOM01oODflZ7/xLFITZdiIoeBBQFUiSSQl
         1FBjHPolrfhhw3y+ReqXOO2yai9i/E5nbJ/vJyqK3plhFCiBRC/vSK27zYk9YqKWy6hY
         8nLUwHhgLLwsLGSF2EsFVy8/3YOkB/OVFrF7StCuOxD+LE+Jw72CGHqJ2MmNSM19MC0D
         KModv/a2SgvpF46SoqJ1EpzhBUylRHtTpOp8zRIOlZJ98HC5IEJ8R8U3CpDl2LUgrkl0
         ZO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FDf27xnjIY0MGgU9QPmFgOgG3Aq3X7unXOSGnQEZ3Zw=;
        fh=6H5JXBLOlGMTbbD+nuqghKke5gNfMUAHJkCJALVhw5c=;
        b=L/4HbogEUXSgRAK1cFNB900GISdHdYgqTUK9l9lae2wgsCzEq0Wx/+8uZV5Xz34+AY
         v5k4qzKBPGdjVdwI0+G9QaBw7VTibHxPnlbjccI4zftFclNtmXSQw/jm2Z7NoyX7igCp
         WMISjcAityYQrDEWJArhjr2BgWIHEXCEAnMD026HH6+xWkgs/5kZo+kOqHjQOS2W9dxx
         p0N2WCq1YC3vvSgd+EvkrDiVMVDZ2xojVDWS/RRpY6lgWLvO8uolRhyUAr97MJ6sENal
         p07Iy/GldStBPX9YKFjZXMBChMsOLyYC3VwYBEVy0JjzHCJC/E/upRo80afKm0VXtLc1
         NF4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795695992; x=1796300792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FDf27xnjIY0MGgU9QPmFgOgG3Aq3X7unXOSGnQEZ3Zw=;
        b=g+ocJyGFVTu8eBHgZFId5jdSnE75WTLkbYTjZxMpSC8b9yn7yMJVvlmNY5aWbMYjPH
         gCSai4xZPAh8jjECllikGL0834enf1UlPow78Ji8xnJyCY+O3F0tG33B9Kka3VQth7YF
         379WfQ6CnJMnMOczL9+9zP5RkGNqscyJt7pEiGnfASQEV7GT2AFRrI20O4+gc5TLPkCj
         pBOghpY33JLnJDRfmkXSJcUeldvJoqIRBeP1gh/SydIwTQ7lyLOgh2+WBDkXFGBpTdHx
         exoS34UlhBgnCbb9fwnhjek/GYQRxPPbxz88lmmOCjKrlk9wxJk41ucVcKqFqLKnWoDd
         24EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795695992; x=1796300792;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FDf27xnjIY0MGgU9QPmFgOgG3Aq3X7unXOSGnQEZ3Zw=;
        b=oKJyhfn9PTYMQcTaDqabhZq74N6OV5Ckkux+s7W+0ChqN6oVWH52p0eM9d6wQYWrgH
         vbPo3a208vcMQXzSELVl4nDrN5vEy+4dz+r8EAl25jKbsvhiGDikFjEZ5FCT+ygMiw7z
         2YfHLWvgL6l8puclqBPJXN1j8YxORLNhSyT5+7pLhh/6Ov9zopLSwteA0cNQyBfiu0r8
         irtOSabZaJR2cNzUiyh6mEPwCfaMoMgMzCPapglgiO5bjTgkFEY9w5ZGIBeHBtBm82m8
         HM/c2YyC0UKyUQxE4VMyiCtiW2aGR/3FCWpLtFonY6+TLsP/e1ux+6NRf+Lu+wbMhzoT
         ebiw==
X-Forwarded-Encrypted: i=1; AL+hErFA0TGNzBQUi1VRaqMI1jjBEt9sizsjKwe/pt/brXomlXXDpTknI6Wifn39LX16ZVn6glz/wc9MSw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Wpe/xZhsTM2QVavWcqqZzHkASDt5wRcMG2bQDGp2Jp3HTeuZI
	hJGufIabTu9U+OuprZxAcVyKr+5eKTx+QlbbSc2aCTUSvPTEm4dUVLG7NvSBL2HqZwMJEZX/D/F
	CuVnJVA94zUjXnosDU9+vTqP/hmz+q/gM8tZqd2//4fQORhoLHXHB7H0sXX0i/owpcMk9MxBUaD
	YghNpQ7P0pWuCRrBVGj+iUOmQCyY8L/CuC8JA+
X-Gm-Gg: AZFdTZc8In2qpkCCsvyejITTIJX+HM6kKUbCREXhWw0FZ/SC7tVAV7VJhpKZG6up3kp
	lbIIYSOOBTugif89uXLmeFH5f5078pZNr5xqy7mLdAD8MRK23WZxNpIwYVBDhGLWDBf0/Wlairb
	tNKAsSawZavG+ry6bVv3rAawbvzomT/m6sjcbwgts0sMsutnDkuOqJoz3s9Q==
X-Received: by 2002:a17:90b:2d8a:b0:3a4:6f38:f2a2 with SMTP id 98e67ed59e1d1-3b41c92ce58mr20258233a91.25.1795695991812;
        Thu, 26 Nov 2026 04:26:31 -0800 (PST)
X-Received: by 2002:a17:90b:2d8a:b0:3a4:6f38:f2a2 with SMTP id
 98e67ed59e1d1-3b41c92ce58mr20258182a91.25.1795695991298; Thu, 26 Nov 2026
 04:26:31 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-zx29usb-v1-0-b0433258e51b@gmail.com> <20261120-zx29usb-v1-3-b0433258e51b@gmail.com>
In-Reply-To: <20261120-zx29usb-v1-3-b0433258e51b@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 13:26:20 +0100
X-Gm-Features: Aa3M54oSOwHoQYSn0V3AtuTR48SOSoC8DE5fzBMGlfQpwJvg-qreLFgHRZWsWfc
Message-ID: <CAPx+jO_zuvcNnBWqUKJHJ246xEDb=FbN6FYKcrN+p6ERmjg2tQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] pmdomain: zte: Add a zx297520v3 power domain driver
To: =?UTF-8?Q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, Lee Jones <lee@kernel.org>,
        Ulf Hansson <ulfh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Agustin Santiago Isasmendi <isasmendi.agus@gmail.com>,
        Navid Ghahremani <ghahramani.navid@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0OCBTYWx0ZWRfX+AfkdyH5C3uM
 KC8gW35tC3ZQdPUhpSLi3+cnzCj4wQ8aYBcYOjNtfP2Y923Yo6zGnA/Hg9i/Tm87C8i3dNw8QtQ
 gv7F5FHnzGY9knsrrBrmpQraP3ZXzkM=
X-Proofpoint-ORIG-GUID: eHi-4UrDVJ8xt6tp65gMFAQS3pOvXKaf
X-Proofpoint-GUID: eHi-4UrDVJ8xt6tp65gMFAQS3pOvXKaf
X-Authority-Analysis: v=2.4 cv=QZPzLcbv c=1 sm=1 tr=0 ts=6b082578 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=kvRnqJp7QHj-O9gkUQ0A:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0OCBTYWx0ZWRfX4Vkq1V6Ux8Vv
 cWjSRRxSOsH4LN5IDEHBzFpDSieGizGfTx1qB/ZPVwYNWzHi/CI/xiGqtucwdj9HQ9wQ15xecM6
 sKrGxcRBtLgyR/qN3Ky9kOkRn6Zifd45H/sN361MpkfhjUm9znGOPodkdtBagB8T4+AELOjYz9e
 TMTLIrmH3XHr9eDmNVQJLRuWlP/780jJY0sp5BxZSCt8c+mwobRwMQP2OZKDcEgC+NF2SeQRnXi
 4WYnWoiEQTLiMCbzz4jge/OQTsVP1LvqMUx68PoQBWwRe3hUrmrI3kEfhYN9UVSv3132smzQJF8
 DwxucDCS2wEJ2u0V9KMCGrnYzLbEjY1khkjF9R44m16UwWeXKW6b6+rP3DcIuU5f2Xm3scncjI+
 kvPXdwMFAO1895bqNDLPgy3oBb28ZuKgaYYfHuquGRcTFaTmVFhdCS2rSD9BNYAt1MXgCHgV4pE
 JGyO40SeOSfRd8NxcCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260048

On Fri, Nov 20, 2026 at 8:21=E2=80=AFPM Stefan D=C3=B6singer
<stefandoesinger@gmail.com> wrote:
>
> This controller has bits for USB, HSIC, EDCP (a cryptographic engine)
> and GSM. Not all of them work the way one might expect (see comments in
> the code), but they are there and can be set.
>
> Signed-off-by: Stefan D=C3=B6singer <stefandoesinger@gmail.com>
>
> ---
>
> For now this driver can only enable and disable the USB controller. I
> expect more LTE related power switches will be added later, but I don't
> want to commit to how I expose GSM and EDCP in the bindings just yet.
> ---
>  MAINTAINERS                                 |   1 +
>  drivers/pmdomain/Kconfig                    |   1 +
>  drivers/pmdomain/Makefile                   |   1 +
>  drivers/pmdomain/zte/Kconfig                |  15 ++
>  drivers/pmdomain/zte/Makefile               |   2 +
>  drivers/pmdomain/zte/zx297520v3-pm-domain.c | 286 ++++++++++++++++++++++=
++++++
>  6 files changed, 306 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ab8797b8d0a5..e394e0044f1f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4038,6 +4038,7 @@ F:        arch/arm/boot/dts/zte/
>  F:     arch/arm/mach-zte/
>  F:     drivers/clk/zte/
>  F:     drivers/mfd/zte-zx297520v3-crm.c
> +F:     drivers/pmdomain/zte/
>  F:     include/dt-bindings/clock/zte,zx297520v3-clk.h
>  F:     include/dt-bindings/phy/zte,zx297520v3-topcrm.h
>  F:     include/dt-bindings/reset/zte,zx297520v3-reset.h
> diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
> index 5341dff669be..d5050c22f064 100644
> --- a/drivers/pmdomain/Kconfig
> +++ b/drivers/pmdomain/Kconfig
> @@ -21,5 +21,6 @@ source "drivers/pmdomain/tegra/Kconfig"
>  source "drivers/pmdomain/thead/Kconfig"
>  source "drivers/pmdomain/ti/Kconfig"
>  source "drivers/pmdomain/xilinx/Kconfig"
> +source "drivers/pmdomain/zte/Kconfig"
>
>  endmenu
> diff --git a/drivers/pmdomain/Makefile b/drivers/pmdomain/Makefile
> index d7aee13ae571..cc3cc7b3d1c2 100644
> --- a/drivers/pmdomain/Makefile
> +++ b/drivers/pmdomain/Makefile
> @@ -19,4 +19,5 @@ obj-y                                 +=3D tegra/
>  obj-y                                  +=3D thead/
>  obj-y                                  +=3D ti/
>  obj-y                                  +=3D xilinx/
> +obj-y                                  +=3D zte/
>  obj-y                                  +=3D core.o governor.o
> diff --git a/drivers/pmdomain/zte/Kconfig b/drivers/pmdomain/zte/Kconfig
> new file mode 100644
> index 000000000000..cc329d085e5a
> --- /dev/null
> +++ b/drivers/pmdomain/zte/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config ZTE_ZX297520V3_PM_DOMAIN
> +       tristate "ZTE zx297520v3 pm domain"
> +       depends on HAS_IOMEM
> +       depends on PM
> +       depends on MFD_ZTE_ZX297520V3_CRM || COMPILE_TEST
> +       default SOC_ZX297520V3
> +       select PM_GENERIC_DOMAINS
> +       select MFD_SYSCON
> +       help
> +         Say y to enable the power domain driver for ZTE zx297520v3 boar=
ds.
> +         This driver is necessary to enable the USB hardware found on th=
is
> +         board. Say y or m if you are building a kernel for a zx297520v3=
 based
> +         device and plan to use its USB capabilities.
> diff --git a/drivers/pmdomain/zte/Makefile b/drivers/pmdomain/zte/Makefil=
e
> new file mode 100644
> index 000000000000..8a4185f48ff3
> --- /dev/null
> +++ b/drivers/pmdomain/zte/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_ZTE_ZX297520V3_PM_DOMAIN) +=3D zx297520v3-pm-domain.o
> diff --git a/drivers/pmdomain/zte/zx297520v3-pm-domain.c b/drivers/pmdoma=
in/zte/zx297520v3-pm-domain.c
> new file mode 100644
> index 000000000000..3df4cd5f1b22
> --- /dev/null
> +++ b/drivers/pmdomain/zte/zx297520v3-pm-domain.c
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 Stefan D=C3=B6singer
> + *
> + * This driver controls power domain registers found on the ZTE zx297520=
v3 board. The USB and GSM
> + * controllers are controlled from here.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/regmap.h>
> +

[...]

> +
> +static int zx29_pd_attach_dev(struct generic_pm_domain *domain, struct d=
evice *dev)
> +{
> +       /* The DT link to the consumer targets the (MFD) parent, which do=
esn't prevent unbinding the
> +        * this driver or removing the module. Either would leave the con=
sumer with a dangling
> +        * reference.
> +        */
> +       if (!device_link_add(dev, &domain->dev, DL_FLAG_AUTOREMOVE_CONSUM=
ER))
> +               return -ENOMEM;

This doesn't belong in this particular driver, but rather in the genpd
core. In fact, we have a proposed patch [1] that is being discussed;
but the bigger question is if we need genpd provider drivers to be
removable at all.

What is your use case for this?

[...]

Otherwise this looks good to me!

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20261112-01-pm-device-link-v1-1-8932e0862378@ke=
rnel.org/
