Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352AA3368B1
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035541; cv=pass; b=pVpxWJAVBVZsnrGV9Soh8qlZJFE1+1c9oFbb1fTP/LSKxOO5NvvJ2x391kzGfaEBL0h2rwklQLstlYaDETYBY3H52+jHySupah2+oHqNEtSvh0QkxNjf9GBvwzVA+FjwhIf7G20U7fIVAqzwIXL4vKTX44Gr2bBWNqNZi2UkWI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035541; c=relaxed/simple;
	bh=U+IHAhlau1+FQ/9SnNbSqU3dkHQE3mjTxVianlAUiZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfcUo7g+m5PG7aQ/qEINUoHHfFFE5WrLJzefQBNe430nZgBCrAovgHxYrNRlH28QkCTPv31+hyYxbH+VscntN84q1qupmX8Gc7ZV4mHLaNTi/OZpPgwVSTBpRd3811cx4mntePMHhgUz3genWIdr9EmBOZC+r30/8thzvS81duM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aRyaAp7a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XBAla5s4; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aRyaAp7a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XBAla5s4"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ED3dOr674000
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	717QVw0yJNdagVep2nzauZkl9EHE4Pz9tV4rojKV45c=; b=aRyaAp7aH5SEoQOK
	km6Jmp/T234j31falyyM4QXkeHCbrZbFztEpbZvnNNmXArVNt3FbJjN1WhbJwh5T
	2v8xcpJlodbeCawsXGGH/mEmKVsmcYyYcQ4ejfl9DQaiGcizak3TkjUdBJ0Mj3Te
	Tli4AjYc8O2MtQtAhDgf8bAfjdn9oWY/GLlXMDEI4+njXIhhnqeI7Ll4jPJ3cCH8
	oBxhFdUJhQi9o98L0UMDFRYUOnCBbT9Njm3AsTENO/q95S46WyLt7a5H7yv7Q2Ic
	9idLhuTPPQ+miS7GRBhHle4zuMkm2bpsfojeVsmu++KmOWCLriII27sExOkUQnoC
	omPPZA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnqr498-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:25:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51a8db414c7so60436361cf.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 06:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035536; cv=none;
        d=google.com; s=arc-20260327;
        b=YDmCY8hlLh8b7/UExakE8Gfq/ykEU5/ZCyTtywcw77dl6ZfYaBCcDtNGz1odmqymUl
         OZpJmDnOp6MMG7GNqWOkgQDP914sGouxeXpxQJOVQZpr0mQVAxeGAtUqY64ft2BH10rE
         8QR6MyCAyUYGH0WrNie0UQ37sdJaRWPAAdCoGrWlrsPldwlZ7OU21h/W3KkKzKEIZeaf
         VgZYAdHD3E5y0X/9HjLh7nA8aplt1sWE8EJCHzlk1fZVJ+gRkCADOIwv7MMops5rmjuF
         jGumO+e5k60Kbrq86hx7Mwm85i52r4m9H45dJ2nvKwx2KFDMNekAwyQbaI5O/kArOYq9
         PrVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=717QVw0yJNdagVep2nzauZkl9EHE4Pz9tV4rojKV45c=;
        fh=8kjPlslNQg6+85/u3O5Zk0HfTr1uP6mWtrXn8WPV938=;
        b=pTYuM1tKqyyBazuezn9jZ4nlkRHv3mBkIEy2Qrrg3YFPu4+X9UXLbzXJCZSk98oXCA
         1bh8V2Qfpirjg0SGi+YOKcx0LPtwoONoGuCzenB3I7Xpf1KktAR8Cw7e7iug0UV3VoUw
         1dAYmdPvCFy0+ak80HuGaxdrcJaDjnhdsyh0+YxBjSSfPAmRQK5i3T7wLXa+lQe/j/E0
         cCYWKoTicICcV7g/tMM2exLdEUGJigCa/uS96V9H692pcM193zZHSXOfhvjdX8CVEI7m
         ucyk7o4Pqtdi89K9tZ1pKW+jP4vf1GlUT2TOgrQh4CIM9785gTSwCkCZUIk1IBYp32At
         dLgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784035536; x=1784640336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=717QVw0yJNdagVep2nzauZkl9EHE4Pz9tV4rojKV45c=;
        b=XBAla5s4EseFgTWcBVSDel+aosRzU1sJyhb6NhUXwl2+ezshP0IE1w6KybB/7qw2tr
         FkaYSdxriHOwVua2TNfdYWod46WWJa3ARNKC2dpqN/gnwG1SUhv9t4xCFGzt/3TPGScG
         FMz512SMF6AvenxxxJXEVvpRYoQsQqunPREINhze6mEhlDWCRLq2PgOdupKnmm+8P3CU
         AJz8dDywbz9sNl1fCO2WWsODv22kucC5abwwxk0Zc8fD1mQU0w/CB9IeE8W1SNNqceae
         4K03XtM/lLNOU6haK4H2/F8daA5DZNipyVrCnvnyfnlC9MElm9pv1scXaN3W6uwj6Wao
         l76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035536; x=1784640336;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=717QVw0yJNdagVep2nzauZkl9EHE4Pz9tV4rojKV45c=;
        b=CCDxUowjV4scRjk8KgXpjLqpprrBimBXfQzq29qpSjeh6hPSoqo0UIHCAIqloQUQZI
         b2/CQfsIWOmdsMCdRAE3viCrpi6Ry5yEiwasOoksRx4+uOIR4vwgQTfnlR3Q8PjeqiIk
         C3Sgf6TVwbWGY23hgiLkoUF23VTRFfctODzFIrOujvJpITI2+TGHGA+dcmBsrMErNrjP
         eKayDgFPJhhtSouaYaI5dIUmIKpMQRg/QT/kKSzQ2uQSIR/rTC84XzKIj7Ds+lf1VhXI
         sQ2oDgw2fQIDa57ndN0BpI6iZjN73/p8pYhOg+zwcyKnYX9/WjdZe8xpQAWTjs6v2wZK
         WhkQ==
X-Forwarded-Encrypted: i=1; AHgh+RrD2iuBD+450lZkTUN1GpBvPPwQueHS5ptfiVT2iYZETYePzDh/4fc6WNy7PKEBYJBe2nx7rb2fRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjcL7t970UxqdBAkmiQeC9WP9sLTQ34B8WZ0mz41Y8boD6Qi9p
	2hEe5CkWslfv5UAm4m+KWc5FFa6GVgqrWnS/5QJ6uhT0dpH6vkbADAfZBDkBTQFDzOz7uJkRj3v
	6FM/uYaNFojV9YjI4VkB1dKtTUeqrOz6X+VuOV3QdjCVQl4IXTBZlgpBF20iWRSfW4B/q1LZvUN
	NZJWDu+1uB6Oj+Cku8w+hmHQvU28U/2Q9Z3mqwjh2I1OTq
X-Gm-Gg: AfdE7cms3nrrjN48Ma9LaxzjcCZU9yeUJcnwbsRPcsnhKT9zEo8ryFoz0KiHR9wmFFZ
	mlqBK0qipJV45jGJKTiLge6tefTf0UjLUpOifWWWDtWkMxJ5bc40TuxLniVTvU3C94e6t8SZhbi
	zmhzquaPyi538CPu/a6QqS/LRs7tXLLkIGRc8zIoPtRg8D9csHPdp9EaIhsSKCBoO/oht3
X-Received: by 2002:a05:622a:4885:b0:51b:f0ab:2b1b with SMTP id d75a77b69052e-51cbf26daddmr133079591cf.49.1784035534511;
        Tue, 14 Jul 2026 06:25:34 -0700 (PDT)
X-Received: by 2002:a05:622a:4885:b0:51b:f0ab:2b1b with SMTP id
 d75a77b69052e-51cbf26daddmr133077151cf.49.1784035531296; Tue, 14 Jul 2026
 06:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420022254.302740-1-zhipeng.wang_1@nxp.com>
In-Reply-To: <20260420022254.302740-1-zhipeng.wang_1@nxp.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 15:25:20 +0200
X-Gm-Features: AUfX_myUc1dBICALtzRuHVKIlbb7qfNnmRBTvv_VDYs9K5Gif0zPw5ow6tXTGB4
Message-ID: <CAPx+jO8WidzjwnGspSTLa6urva3w3qrigJ46CDnqOTLAh06XBg@mail.gmail.com>
Subject: Re: [PATCH v4] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL tristate
To: Zhipeng Wang <zhipeng.wang_1@nxp.com>
Cc: ulfh@kernel.org, Frank.Li@nxp.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-pm@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, xuegang.liu@nxp.com, jindong.yue@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzOSBTYWx0ZWRfX47CHNQNY58M9
 TCEWuHWkjglvsiUb38sa3qfipSPUw6HRFmN0gJcyL/GNrEOZYP7sNILo8ctY/sczKwK/JJlIrzx
 jKKcGB4TVD4T0z7yPVBqh1ptaTViOv/ZPIfkrj8f3nxijTSFbgu5iW33xqs96XnOipQBffArfC/
 GFWjmCvINPQLApmXqy+zlFRSrCJtc9/Tl5EJmNcuyK5x2uJxGYShtiUCAq1CfJ63+7zXQwejUrM
 LmTe+02+LWuEfJCrfg5414XA5kDr4fqF+HMxBr0azRmh5GQpGn4VkdEyVIyUdwIdZf4cT8GYFrK
 HZ/1yXxO2ZzEoT/rKhBUUBswexrP6LdJ4NJTdIS00WcxQ/0H3BTDkiuFsUQGLJhGYtbA5iPKreP
 Tzb6N08o/UWlzgeKeR5fMGe6T7UwFkciP6mZi8krFMcHT/BACVvwAY6DnupP/rxb8pZGK3o57OA
 GMcuSdjLmhFUqjXN1RA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzOSBTYWx0ZWRfX6yV/6NeFkhWH
 Ghoi75Z01YGZH02nPzE3F2U3HrA3tm4cNTc6Sv7aDoVKxhPhaS8bemyBgX81PpKKvtaOFCpH/Ep
 UvARbkJ2q0VM5fDoZMoxH2oNLLFRsEU=
X-Authority-Analysis: v=2.4 cv=U+Oiy+ru c=1 sm=1 tr=0 ts=6a5638d0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=8AirrxEcAAAA:8 a=TQfnek6nW7prAsdi_scA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: B0nsmsPLKm3uGEjJfFM_pbGimGHBR5_t
X-Proofpoint-ORIG-GUID: B0nsmsPLKm3uGEjJfFM_pbGimGHBR5_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140139

On Mon, Apr 20, 2026 at 4:22=E2=80=AFAM Zhipeng Wang <zhipeng.wang_1@nxp.co=
m> wrote:
>
> Convert IMX8M_BLK_CTRL and IMX9_BLK_CTRL from bool to tristate
> to allow building as loadable modules.
>
> This change is required to support Android devices using Generic Kernel
> Image (GKI) kernels, where SoC-specific drivers must be built as loadable
> modules rather than built into the core kernel image.
>
> For i.MX8M and i.MX9 devices running Android with GKI kernels, the
> BLK_CTRL drivers therefore need to be loadable. Without tristate
> support, power domains cannot be initialized correctly, making these
> systems non-functional under GKI.
>
> Add prompt strings to make these options visible and configurable
> in menuconfig, keeping them enabled by default on appropriate platforms.
>
> Also remove the IMX_GPCV2_PM_DOMAINS dependency from IMX9_BLK_CTRL.
> This dependency was incorrect from the beginning because i.MX93 uses a
> different power domain architecture compared to i.MX8M series:
>
> - i.MX8M uses GPCv2 (General Power Controller v2) for power domain
>   management, hence IMX8M_BLK_CTRL correctly depends on it.
>
> - i.MX93 uses BLK_CTRL directly without GPCv2. The hardware doesn't
>   have GPCv2 at all.
>
> Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Apologize for the delay, I have simply missed this one.

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v4:
> - No functional changes
> - Added detailed explanation about GKI (Generic Kernel Image) requirement
>   in the commit message to clarify why tristate support is needed for
>   Android devices
>
> Changes in v3:
> - No functional changes
> - Fixed typo reported by Frank
> - Added Reviewed-by tag from Frank Li
>
> Changes in v2:
> - No functional changes
> - Expanded commit message to explain the architectural differences betwee=
n
>   i.MX8M and i.MX93 power domain management
> - Clarified why IMX_GPCV2_PM_DOMAINS dependency removal is correct for
>   i.MX93
> ---
>  drivers/pmdomain/imx/Kconfig | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/Kconfig b/drivers/pmdomain/imx/Kconfig
> index 00203615c65e..9168d183b0c5 100644
> --- a/drivers/pmdomain/imx/Kconfig
> +++ b/drivers/pmdomain/imx/Kconfig
> @@ -10,15 +10,18 @@ config IMX_GPCV2_PM_DOMAINS
>         default y if SOC_IMX7D
>
>  config IMX8M_BLK_CTRL
> -       bool
> -       default SOC_IMX8M && IMX_GPCV2_PM_DOMAINS
> +       tristate "i.MX8M BLK CTRL driver"
> +       depends on SOC_IMX8M
> +       depends on IMX_GPCV2_PM_DOMAINS
>         depends on PM_GENERIC_DOMAINS
>         depends on COMMON_CLK
> +       default y
>
>  config IMX9_BLK_CTRL
> -       bool
> -       default SOC_IMX9 && IMX_GPCV2_PM_DOMAINS
> +       tristate "i.MX93 BLK CTRL driver"
> +       depends on SOC_IMX9
>         depends on PM_GENERIC_DOMAINS
> +       default y
>
>  config IMX_SCU_PD
>         bool "IMX SCU Power Domain driver"
> --
> 2.34.1
