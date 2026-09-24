Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E960494805
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257519; cv=pass; b=kpCgeBltopj8h8I317gKn+blFzxZE3UeAUeypTY57iPhwr8yvcynOF/mDQw2H1IIWHtf/haOn6Zm3NdnXcPaGxdoZ8pVOTlocgZOG5p8Izb71SkxsOLWK4Q9LQ6ls++ZISrzLCKF+IoWh/isVHW8nrw519wlDqVgW3+jK++gxys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257519; c=relaxed/simple;
	bh=VxTD9bps2tmguob1h0DU6BbtFrs2Bck4jQrFUdaM7uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtWtNmQqRowJ1MLpDh+VuN93BL+CPRg3CtC026xLrkwHZlVwa2pjUJ0KNAZZpAAauscAIKXiZgct/vO3GhDecAV+qo6nUrMeHbg03zX2qv7UcRBv+z5p5aY8RMhzalFtN4g8ekxMV4kckG5kHsO3QmVjL/aB8hOjiEikQhR3TYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OXNqTZaW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JY9ULeqQ; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OXNqTZaW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JY9ULeqQ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC4VcQ3282830
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 13:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+92HIZiD8BjzLF20PEwnQGtt9JR2IY1fehiHqBhK2DE=; b=OXNqTZaW1hVXUEuA
	RpbpIDZ5ZyZIMz5G3cp/uC/FgcuVeu3hcEkHU+lrs0zGQ9LslzczkcYpfSViC2pQ
	HDAj2sS5zlACKFUS3vuWUqwcHy/Pirw2f88NsGnJYR7H0RLWPSY9G/qjBuA7oVxg
	r7JUkZP6oRWhIYTIB6Dlxk0JYowYsovizQ5kDwCHxSzWKeHWGpUMjP2vryZbILNt
	p4jOnHT3okmy53j8LtMoyl+sGDCmTjkISbe/J+tNphd93NjcoU2TBMXKYrYszQ5t
	96fw3+VpQemov/UV82Yj085pC3Ts6ZG23ZZMYfL+KsMe2dJihm7aww+cvUEExwLZ
	/JxeBw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvstujvqe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 13:45:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2df5a65671eso12220335ad.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 06:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790257510; cv=none;
        d=google.com; s=arc-20260327;
        b=fXp3lmkp7vX/9jCbkWRW11Kt8XyN0BhHRa1eVqIMl2s7KlxcpOg/F7KDj6N2ARbeb1
         +z7jBfjArFti6JF4h98lnMzpHUNYu7FgOxm0Xi8XwyY3kw4CserUv+1wuzgt8vWuZKDU
         oGKnS6vcle6YE9xvoL2DKOomQco0HQe3gdTL+q4bI1Tm9pGsuxlP4A93b9PwiT9YoEdv
         ANUHX5BSsHzPlG0LeOXHf/3LM8kYfvgPGKOBfapf1y28x6cAZmLkBNKtlxjg2gFk/4uL
         zUWc3EFrxRKBooEGe79vtYMjoAGFNm48QdVSN6meS5v/6mmnWyJlWFI+F5xuEy5i2vKo
         HjTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+92HIZiD8BjzLF20PEwnQGtt9JR2IY1fehiHqBhK2DE=;
        fh=uwDGQDIlkfwPbdqfJKz56xAhjvqTdxxyo67tGNCZpBk=;
        b=TKP/fwO6ypWRewvI9nefb0jgokgA5MVk3G1VX0WVOwR6HV2b7pvHoZ46D7FkRwnD/r
         vGwegPXh1wdFYb+XOtin98PYh39uk2s3hRcQiORCV/YM/mXlQ9YxOl1PIFUhTy1R1mSU
         7YRFyTDx6Jk6lAMcs5vG3zdFV1vBX5cuoEgJhqekHPjLQgJrjvL5zIb/FDbbZosmiBDC
         0AZ6q4ljJRXAVhLkg/nxW1Tyf08JcXwuZ/2XewOhKNSMW/SiC9rAhGsRaGkMkHoD5BkL
         cTNjGMoMdyt7r7mEEptY8ldpcARvtCB84AJixw22YJmCYqqEmpP1eRNtFlFr2+gdJuvh
         NMVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790257510; x=1790862310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+92HIZiD8BjzLF20PEwnQGtt9JR2IY1fehiHqBhK2DE=;
        b=JY9ULeqQf4WDJl7hRLUPNcJW/pFXdxZq05HjylkR0v4cB/oh+4TbWjXYzaq/UGPsn8
         6ZOGjC98a358NTSg/rg1PnsrnG18fIlOuiUK+yynLF0j6B+BIVyybcC0m+myaUt7aDyA
         naHumX6LXOv+Y6JTnkwdC5I0TGlLZTKLV7NzNdO3INHB7c9BImob1eSfWMNG+4R2yKMp
         AO3fManve1qDQod+2canUkb2NCuMhtXBTSuq+Epq843EOjMMSIfVLJiM7C0NLJWyffx+
         tyzkurISrVmqBSqwUX59j8PwfHcUl8Jl2eNPp4r56dv27xKyEz9RcvVFgm6Y6gKwRx1v
         pwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257510; x=1790862310;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+92HIZiD8BjzLF20PEwnQGtt9JR2IY1fehiHqBhK2DE=;
        b=ShX8THh1Xgltp3KcPJVqxvr9HjpydXQk/ZVYUoQSZ+5WQwGQ6pMvlPB9oVZK/GCBZ+
         ikDF67bGS6GaClC3k/pkO5LeWZOZeZ1ChS8sN+2wE0hRqWvdN6vDaRji+oeQHaYtHH1e
         d5Nrhh2pPr9Th/xhUzVVASPsURio3xSEJVae2QG/osSTP2JIrr/ZEc1Zo5rtenHMhrGx
         571Eu85PvApI4j/2gVtjW5F9Y2Yd+lQ49dGqWVrv1FBzywHtntO4zIdKD92sFi/lpnvA
         /R6AWxzg/zV/EU18qXktWIwohzAb5AJFT4k8arOl+qex53dbltczefDRnlHJJB/fivs2
         NZ8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwANFUWJCuizNBqUGzafHZXIks3C9t/zvkcqSGKMHIvqUdu9EqmohVsx6PPYFqoBSqvN1YSA0RWbw==@vger.kernel.org
X-Gm-Message-State: AFuF++lh8Nj6xWKHByS5hSaJUQ88dhCAWtnjyft+ajsHviX4n2M7XudI
	VTDqALqjVb/ZqhiOQyeVI+lOalspFhSpQRx8UqN32gQ4s0C37vNcu2Z//42cw6GWN1mDG1bpzkB
	KCFaV4EflZ6Rjw7lRNx5hEpUe2gSU62fyjbYDur7Mpq6Sisd23MrL5tUQoouzhUqsl2LwP1eSby
	qg6Bot8LKBZ7x8uwFydoHruTlHohpU2qARtZxR
X-Gm-Gg: AYBFou1+DGaP11LtwOWVrv348LAmfGJnYec0sQRZ+CnyYFCy/cgr0RHJ8tQZzFbnOee
	SSy2ZF9tLi2Z49q3z3dDCtKjl2Hza0GS3J/hhl35zVN9b0lRkSB2cl7bo9a0wyycsID4PM1/LKw
	BZ4PAYCwsncuwEf4QgNR/XrBhtRzTvOjJ/199GsWd3h2MKVVDCwDc4/Tdn3g==
X-Received: by 2002:a17:902:e747:b0:2df:89ac:a9f3 with SMTP id d9443c01a7336-2df89acb234mr4396885ad.30.1790257509531;
        Thu, 24 Sep 2026 06:45:09 -0700 (PDT)
X-Received: by 2002:a17:902:e747:b0:2df:89ac:a9f3 with SMTP id
 d9443c01a7336-2df89acb234mr4396605ad.30.1790257508990; Thu, 24 Sep 2026
 06:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org> <20260921-ux500-power-domains-v7-1-v3-12-9352be6b86b1@kernel.org>
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-12-9352be6b86b1@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 15:44:57 +0200
X-Gm-Features: AclHuK8823By2ir4rvAhJl6ftcMi5z7VMEo6jrXMBPTc2AtobSCQW7MLn1qCZ9I
Message-ID: <CAPx+jO-3aZXatF+zL=G_cG0QaSjjCPrdhpXOGZC+_zNYxjsP1w@mail.gmail.com>
Subject: Re: [PATCH v3 12/18] pmdomain: st: ux500: Control DB8500 EPODs
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NiBTYWx0ZWRfX7zxyUzwx3oXO
 nAclQZVyhBwqUwYHuY4fCmu0TqPfptUm0hfcPLlesQDDHt31VaV+YJ5vCcEA62r+cyTLYzC2FDr
 Ctom9hIaKIK8MXk0GHEIh3w3FUsZgOE=
X-Proofpoint-ORIG-GUID: dn8l2xtWrhll7QLxSJ7-S0UiPu0gUqW9
X-Proofpoint-GUID: dn8l2xtWrhll7QLxSJ7-S0UiPu0gUqW9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NiBTYWx0ZWRfXwpew4Ql83899
 MGxEF6Em5IuLUSjUZAhvYkIijI2b5I5ybiwLHGjkBTmsAAxMsJWkC1q5ST8wuCmYmTVSTD2J66f
 oOvRRSeQYxHkBlPpPsnXhFLAqZl80XcWw2MbK2Rn8vsjQR90vIX4vPhG9v95TcxGXl787KTJaqx
 HwNWui2pxTwKTpVy6HSsq2krV3CeVuk+UFrEbMggw0TZhpwJ4KSoruQNzBCvfCQhOpEz8JXDc+p
 KV27/cuFICQ99Lps5fk1lrLrd3aQYqZvB7/2PO9WlFVoncWtRMyqnSsyv/+/QlyM6zN67vh+lmD
 r84c5cTDC93uYfTh3/olE6dkr7JsZuJmyJD+l7OwA7s5k4cNLzGjNnniEyxuspTDwNycApxypeh
 NPqes+ddu/py0DgO53+HGxn0HK48dO2PxPya+3fuoKGmGe033aQEsa8HNC4+h/L9Pi5ei517D1p
 Q6hxJOLRWvdkuZmZrTg==
X-Authority-Analysis: v=2.4 cv=cKp1IVeN c=1 sm=1 tr=0 ts=6ab52966 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=-O4hDVTBhx9-GJANRbkA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240056

On Mon, Sep 21, 2026 at 12:49=E2=80=AFAM Linus Walleij <linusw@kernel.org> =
wrote:
>
> Move the DB8500 EPOD state handling into the Ux500 power-domain driver.
>
> Keep the old regulator driver mutually exclusive with the pmdomain driver=
.
>
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  arch/arm/mach-ux500/Kconfig               |   2 +-
>  drivers/pmdomain/st/ste-ux500-pm-domain.c | 355 +++++++++++++++++++++---=
------
>  drivers/regulator/Kconfig                 |   1 +
>  3 files changed, 254 insertions(+), 104 deletions(-)
>
> diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
> index c18def269137..56636c993f49 100644
> --- a/arch/arm/mach-ux500/Kconfig
> +++ b/arch/arm/mach-ux500/Kconfig
> @@ -26,7 +26,7 @@ menuconfig ARCH_U8500
>         select PL310_ERRATA_753970 if CACHE_L2X0
>         select PM_GENERIC_DOMAINS if PM
>         select REGULATOR
> -       select REGULATOR_DB8500_PRCMU
> +       select UX500_PM_DOMAIN
>         select REGULATOR_FIXED_VOLTAGE
>         select SOC_BUS
>         select RESET_CONTROLLER
> diff --git a/drivers/pmdomain/st/ste-ux500-pm-domain.c b/drivers/pmdomain=
/st/ste-ux500-pm-domain.c
> index d90a563cd6f3..b31a36a4acd1 100644
> --- a/drivers/pmdomain/st/ste-ux500-pm-domain.c
> +++ b/drivers/pmdomain/st/ste-ux500-pm-domain.c
> @@ -6,174 +6,292 @@
>   *
>   * Implements PM domains using the generic PM domain for ux500.
>   */
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/platform_device.h>
> -#include <linux/printk.h>
> -#include <linux/slab.h>
>  #include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/db8500-prcmu.h>
> +#include <linux/mutex.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> +#include <linux/slab.h>
>
>  #include <dt-bindings/arm/ux500_pm_domains.h>
>
>  #define NR_DOMAINS             (DOMAIN_ESRAM_34 + 1)
> +#define UX500_EPOD_NONE                NUM_EPOD_ID
>
> -static int pd_power_off(struct generic_pm_domain *domain)
> +/**
> + * struct dbx500_powerdomain_info - dbx500 power domain information
> + * @genpd: generic power domain
> + * @epod_id: id for EPOD (power domain)
> + * @is_ramret: RAM retention switch for EPOD (power domain)
> + */
> +struct dbx500_powerdomain_info {
> +       struct generic_pm_domain genpd;
> +       u16 epod_id;
> +       bool is_ramret;

This one is unused for the defined power domains. Is the plan to add
support for this on top, later on?

> +};
> +
> +static DEFINE_MUTEX(ux500_pd_lock);
> +static bool epod_on[NUM_EPOD_ID];
> +static bool epod_ramret[NUM_EPOD_ID];
> +
> +static int enable_epod(u16 epod_id, bool ramret)
>  {
> -       /*
> -        * Handle the gating of the PM domain regulator here.
> -        *
> -        * Drivers/subsystems handling devices in the PM domain needs to =
perform
> -        * register context save/restore from their respective runtime PM
> -        * callbacks, to be able to enable PM domain gating/ungating.
> -        */
> +       int ret;
> +
> +       if (ramret) {
> +               if (!epod_on[epod_id]) {
> +                       ret =3D db8500_prcmu_set_epod(epod_id, EPOD_STATE=
_RAMRET);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +               epod_ramret[epod_id] =3D true;
> +       } else {
> +               ret =3D db8500_prcmu_set_epod(epod_id, EPOD_STATE_ON);
> +               if (ret < 0)
> +                       return ret;
> +               epod_on[epod_id] =3D true;
> +       }
> +
>         return 0;
>  }
>
> -static int pd_power_on(struct generic_pm_domain *domain)
> +static int disable_epod(u16 epod_id, bool ramret)
>  {
> -       /*
> -        * Handle the ungating of the PM domain regulator here.
> -        *
> -        * Drivers/subsystems handling devices in the PM domain needs to =
perform
> -        * register context save/restore from their respective runtime PM
> -        * callbacks, to be able to enable PM domain gating/ungating.
> -        */
> +       int ret;
> +
> +       if (ramret) {
> +               if (!epod_on[epod_id]) {
> +                       ret =3D db8500_prcmu_set_epod(epod_id, EPOD_STATE=
_OFF);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +               epod_ramret[epod_id] =3D false;
> +       } else {
> +               if (epod_ramret[epod_id]) {
> +                       ret =3D db8500_prcmu_set_epod(epod_id, EPOD_STATE=
_RAMRET);
> +                       if (ret < 0)
> +                               return ret;
> +               } else {
> +                       ret =3D db8500_prcmu_set_epod(epod_id, EPOD_STATE=
_OFF);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +               epod_on[epod_id] =3D false;
> +       }
> +
>         return 0;
>  }
>
> +
> +static int pd_power_off(struct generic_pm_domain *domain)
> +{
> +       struct dbx500_powerdomain_info *info =3D
> +               container_of(domain, struct dbx500_powerdomain_info, genp=
d);
> +       int ret =3D 0;
> +
> +       guard(mutex)(&ux500_pd_lock);
> +       if (info->epod_id < NUM_EPOD_ID)
> +               ret =3D disable_epod(info->epod_id, info->is_ramret);
> +
> +       return ret;
> +}
> +
> +static int pd_power_on(struct generic_pm_domain *domain)
> +{
> +       struct dbx500_powerdomain_info *info =3D
> +               container_of(domain, struct dbx500_powerdomain_info, genp=
d);
> +       int ret =3D 0;
> +
> +       guard(mutex)(&ux500_pd_lock);
> +       if (info->epod_id < NUM_EPOD_ID)
> +               ret =3D enable_epod(info->epod_id, info->is_ramret);
> +
> +       return ret;
> +}
> +
>  /*
>   * Apart from these voltage domains there is also VSAFE which is always
>   * on. Vape_esram0_pwr for eSRAM0 is connected to VSAFE.
>   */
> -static struct generic_pm_domain ux500_pm_domain_vape =3D {
> +static struct dbx500_powerdomain_info ux500_pm_domain_vape =3D {
>         /* Vape_pwr */
> -       .name =3D "VAPE",  /* 0.95 .. 1.20 V */
> -       .power_off =3D pd_power_off,
> -       .power_on =3D pd_power_on,
> +       .genpd =3D {
> +               .name =3D "VAPE",  /* 0.95 .. 1.20 V */
> +               .power_off =3D pd_power_off,
> +               .power_on =3D pd_power_on,
> +       },
> +       .epod_id =3D UX500_EPOD_NONE,

Several power domains below share this epod_id. What does that really
mean? Or is this only temporary?

>  };
>
> -static struct generic_pm_domain ux500_pm_domain_varm =3D {
> -       .name =3D "VARM",
> -       .power_off =3D pd_power_off,
> -       .power_on =3D pd_power_on,
> +static struct dbx500_powerdomain_info ux500_pm_domain_varm =3D {
> +       .genpd =3D {
> +               .name =3D "VARM",
> +               .power_off =3D pd_power_off,
> +               .power_on =3D pd_power_on,
> +       },
> +       .epod_id =3D UX500_EPOD_NONE,
>  };
>
> -static struct generic_pm_domain ux500_pm_domain_vmodem =3D {
> -       .name =3D "VMODEM",
> -       .power_off =3D pd_power_off,
> -       .power_on =3D pd_power_on,
> +static struct dbx500_powerdomain_info ux500_pm_domain_vmodem =3D {
> +       .genpd =3D {
> +               .name =3D "VMODEM",
> +               .power_off =3D pd_power_off,
> +               .power_on =3D pd_power_on,
> +       },
> +       .epod_id =3D UX500_EPOD_NONE,
>  };
>
> -static struct generic_pm_domain ux500_pm_domain_vpll =3D {
> -       .name =3D "VPLL", /* 1.8 V */
> -       .power_off =3D pd_power_off,
> -       .power_on =3D pd_power_on,
> +static struct dbx500_powerdomain_info ux500_pm_domain_vpll =3D {
> +       .genpd =3D {
> +               .name =3D "VPLL", /* 1.8 V */
> +               .power_off =3D pd_power_off,
> +               .power_on =3D pd_power_on,
> +       },
> +       .epod_id =3D UX500_EPOD_NONE,
>  };
>
>  /*
>   * CHECKME: as these are used directly by peripherals as regulators,
>   * perhaps they should stay in the regulator subsystem?
>   */
> -static struct generic_pm_domain ux500_pm_domain_vsmps1 =3D {
> -       .name =3D "VSMPS1", /* Also called VIO (1.2V) */
> -       .power_off =3D pd_power_off,
> -       .power_on =3D pd_power_on,
> +static struct dbx500_powerdomain_info ux500_pm_domain_vsmps1 =3D {
> +       .genpd =3D {
> +               .name =3D "VSMPS1", /* Also called VIO (1.2V) */
> +               .power_off =3D pd_power_off,
> +               .power_on =3D pd_power_on,
> +       },
> +       .epod_id =3D UX500_EPOD_NONE,
>  };
>
> -static struct generic_pm_domain ux500_pm_domain_vsmps2 =3D {
> -       .name =3D "VSMPS2", /* Also called VIO (1.8V) */
> -       .power_off =3D pd_power_off,
> -       .power_on =3D pd_power_on,
> +static struct dbx500_powerdomain_info ux500_pm_domain_vsmps2 =3D {
> +       .genpd =3D {
> +               .name =3D "VSMPS2", /* Also called VIO (1.8V) */
> +               .power_off =3D pd_power_off,
> +               .power_on =3D pd_power_on,
> +       },
> +       .epod_id =3D UX500_EPOD_NONE,
>  };
>
> -static struct generic_pm_domain ux500_pm_domain_vsmps3 =3D {
> -       .name =3D "VSMPS3",
> -       .power_off =3D pd_power_off,
> -       .power_on =3D pd_power_on,
> +static struct dbx500_powerdomain_info ux500_pm_domain_vsmps3 =3D {
> +       .genpd =3D {
> +               .name =3D "VSMPS3",
> +               .power_off =3D pd_power_off,
> +               .power_on =3D pd_power_on,
> +       },
> +       .epod_id =3D UX500_EPOD_NONE,
>  };
>
> -static struct generic_pm_domain ux500_pm_domain_vrf1 =3D {
> -       .name =3D "VRF1",
> -       .power_off =3D pd_power_off,
> -       .power_on =3D pd_power_on,
> +static struct dbx500_powerdomain_info ux500_pm_domain_vrf1 =3D {
> +       .genpd =3D {
> +               .name =3D "VRF1",
> +               .power_off =3D pd_power_off,
> +               .power_on =3D pd_power_on,
> +       },
> +       .epod_id =3D UX500_EPOD_NONE,
>  };

[...]

Kind regards
Uffe
