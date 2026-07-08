Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B77637FF54
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525411; cv=pass; b=Boe/nZfeKMJMv21HznLkiOswlqYvEpbFmkKVrDv3l2XaZQlkC1c+vY1M2j1Ln2oOMECXgGx2LgxiX75HQj954GI31wec5D/YNmv7q2acN2zbT+n/Mx1GtWZg+osX86IaFr0wGANS2OIT+zraCCi9W4m33RuXRKE7u7sD+K3/res=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525411; c=relaxed/simple;
	bh=V4fIwFsr0mLwchZrRcsUWwCmrPaULkaS8mPw6q6+HMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VS9wZJw8TbgmEafnMUCAa6ClkW31X3GOY0MwY5fV+Y4/8fZsnbHGUtG2hvN3C4e9b3h+4W9CkQEDfo9HI9aBty9JaYR330MXTQI98HMw8SnM8MFgvB+EvDl+r8bsUyM5JT1mN0HyJbzEogCZVi3HGibGDP36Y9AYxFEIDeUvojs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gpi7Z0iH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OM2/mEWl; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gpi7Z0iH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OM2/mEWl"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668Er3qT3100858
	for <linux-pm@vger.kernel.org>; Wed, 8 Jul 2026 15:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OW7Jo5BTMAK0p//WyaSFrL7dEi1HJV9QqxfZvItnF1A=; b=Gpi7Z0iHanVc4ewT
	7FQ/iOmgIDYfQPNsLWBPahVUdstaYgfQlDtGjG8VdQQA7J4awDImmOUNWK7vXyEM
	tSCOlLcy4XHryPydn5GaRVu0CuNO/LMFBPRrPiUtLOo8SoV/IcsywNpNveG3cn6g
	VDgjqyDZIdd4vgQqIb9ZYLZc55+qR8tBPSNrjrvHWDGsX/3Tk3aD30L/o2F4t6w2
	zphI+wMiWRJYxTClL0K5W1KWq+cUBGielBfTLp041HPpIH7eneORQez1UM2tN+J/
	M9UK/hSLMSNSRYjxhJwXnpci8Kuk8ap5IbJmXjvS3+m3abiBsrAgD6FN7RfdohoZ
	qd31EQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9rq307vv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 15:43:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c110a3b6aso11811681cf.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 08:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783525408; cv=none;
        d=google.com; s=arc-20260327;
        b=JX0mX16ufcCr9Q27mQmLnE53LHd52Fi0SgCnfTGmUguu3vyi8Ld8Nf83aP2A31UsGs
         CX94QRm5GnHGv3TJCSO5UzTeiHFX0gU7wlvguy1miZXGgLDyPnASx4dcqwohMK0Me9An
         WPu3P6c9E+mushoHRGHwWV6ys10wj9myJcZkq8icULzVCH9b9236Oo6rxnH+ZfnmjccR
         5n3/GE9nKZUNA2lrlugltLwVMeE3LpZyLAbNfutRsZrQQThNaUUGzBiUZKDCe1Vp8Hq0
         UbeAAbUpU6dJucvefLXqhfcEVY4IgcX58E8L23SaZoJcyEK4S+telsP12zwjH80O0VJz
         5Xqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OW7Jo5BTMAK0p//WyaSFrL7dEi1HJV9QqxfZvItnF1A=;
        fh=zadI8uHJ2TTKvCbzMzU6FUYSqaQN0+mHrNG4u4xZ6ws=;
        b=O1CkX2EpH4PwvkBG3SR+YoljPk3DOOUmo70Sqo6U7PgzJ2DRuqI1qtMER9McPBNJ28
         dGW0Ga21qfkLmGhpPLFATU+Q2QYntud5VAva0bXphddGDFze3OmYunLXmNhq4obFgHqG
         2vax/dCAT2271FSDkcWvOlXIpKNuhHM8bZaOO0n1Vr5qlg1SRLbIpP37ZB7T0DYm1Ir1
         Zir6vUC3CLAnBNEy0qnIYRZZQ4/I38BptzC5yuk0L4nNY0Gttna3QIB1B7y8ekNDAQ8+
         1dgh2vwoDiwQb4wqmMwC8YdvCn1PE354BanOfFWm1eWRunZQ665MPshAVkUy8vvJe7Qv
         Mccg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783525408; x=1784130208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OW7Jo5BTMAK0p//WyaSFrL7dEi1HJV9QqxfZvItnF1A=;
        b=OM2/mEWluCLsPbJC8eIOIzkXxij8UmJLfKyByk4qPV+sbPUyOqlm2t8vw//uyQWdn0
         Jq/rCWZxjVdCR+aGScQYfn0NDTftMWXaKVCIUN07zb7WBTeYwLMxnmO3Sa8duSlE+L+Y
         TABXd/t4XHU/YxZVu9YWx2n9+vQs3PU3gRPlpV+C/yyP80d+pAfX1kXrt2L6M7Ga/g4l
         R69vxny18tFaPVR8wAJlE72VK4NroHHWfw/rHH57FP+qpPG6TDmCdjQ1no5QykXRJnxE
         uqTijfGiYpIaxlxDgRFvXKT4evug4QCsD6UkG91i6lcLwiTQTDUo8bVTYvYT4rp3dws2
         psOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525408; x=1784130208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OW7Jo5BTMAK0p//WyaSFrL7dEi1HJV9QqxfZvItnF1A=;
        b=l+z9YqkNX538xmILTWfATkkuvZnHXuTY3LNX4Ix3GJP9QyyiwOqXhTaENsOmOaUTHR
         jrTK6DRhRdRbmxrI6qlRezBJi/QZqP7+4M+y6HAcGzpkXNfTPCFXKQZtokXXw4nIErAZ
         SvxMxxHCSvXSQ76T+VFcdLfx3TMVwV+Jjx2WAnDX07S1DDmMdklGu0q/CvyXT0ARX8gY
         +YWw6CaPdMg/WE5Qhdg5gesBUhibv6Vohfg0HBnq4x0C1fIy9CXM19OX2TNo6pf6gfRd
         gaKN1vHiBBuNU4o/+AAi9qb0FSxOVig5++ZFezj6umHBWIb8ZUaqWEKYpPnE9ytGtycl
         zdLw==
X-Forwarded-Encrypted: i=1; AHgh+RoiOySeg/14gL2WQu6vyZXGIWJoNLLkfHXOCDaFeFfbw4XoN8EBaD+qDuRjonZqMYgyyb3I1UlkLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC5qXciTvQXSZxyMEfS7fPLfAyTMASqPHcg3W5gvoku4r/GQwP
	DXc+87CstRnErKo3taZVEajw7kWGRZVv9ogRG/ff+cWeFTHeVSUOoV25DYA5m2mu92Ujn6SWIJc
	vFXJpodqwj7yYNAUGxZFwjVDI0uptegBM38VwOGOaKP1KGOqc+XHEAAmXYObdLaOsuEnHO8Qaa8
	uVbSaSLUHwbjXWVqKGzTpkLw8WtnH88gU8ksIj
X-Gm-Gg: AfdE7ckrb0kXdR3DxgbHk5kxbVU2tZJJLmCKpFdPGIyY6yJ5x7pvetyp5JI/n9M6bcQ
	Owo2pe9zB1TklpIIanUPxoHAUkLgeC6d7BXz0F72cgcylooOev3tAPxD93s5uBpSiam4mKluajI
	+2gqCo+pPo12OAkq+zxnda+vbkUXv6fVU1XG7/hm9K/hjGd9TdY8Vs60w7ZtCPe5OhiJRG
X-Received: by 2002:a05:622a:4c05:b0:51a:8b64:69e0 with SMTP id d75a77b69052e-51c8b398897mr31023761cf.11.1783525407488;
        Wed, 08 Jul 2026 08:43:27 -0700 (PDT)
X-Received: by 2002:a05:622a:4c05:b0:51a:8b64:69e0 with SMTP id
 d75a77b69052e-51c8b398897mr31022071cf.11.1783525405268; Wed, 08 Jul 2026
 08:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org> <20260618-ux500-power-domains-v7-1-v1-6-eb5e50b1a588@kernel.org>
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-6-eb5e50b1a588@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 17:43:14 +0200
X-Gm-Features: AVVi8Cdq0rtjAP0YSg4WhxzCqmLPP1um1vAPUHWXvoo9MmpPquQaWcjqsUHRPk4
Message-ID: <CAPx+jO-teiu9vQfw+MeTbixH4PnARaqSC+_7bvHUMAAEPqtDaQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] pmdomain: st: ux500: Control DB8500 EPODs
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
X-Proofpoint-ORIG-GUID: qIw4ZQgUb62WoVsEQmMOLwZnax0J-8LT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1NSBTYWx0ZWRfX8hrmK6EiE6WO
 msPCS70mazjgQrSdYpfz+ikKxECVTjN4zrMOZON0sa2qM4T6q306SJPHnD+i7e6BEuOpz09Tw/i
 v2k6aRxqTi1ScQseSroLlhL9dIU3ocWcoSioRJ+rSjjBsSzducV0lfoYxQ4XiOnKHHxeEZijtYa
 LpQItpN8iVggIsr6H3IgdGU6H6OKCJ0AmPhJ9ljeZKeXtYC7uLFaYYWudrgtpCqeqh9UIx++i27
 8b1JNbABrVKbM08C0WxtKqUisHajosaZE6knTbDoZ8RcOt368tgYUhWYzg7KWVslUXMaRwtWKt+
 TdWbavgnplloCpM3+I11pU59hL4j64UmRKgLH5rZF6CBs9K0MlY0Bs4xmldPX7714fgXdwX/mVH
 jE64vcI51ODyllmCEpQSeSTt36vbFDjjJrjzT4Cpk5LVMHwNnMDLHgrLHqBr1yGZO49cfZ1DSNZ
 zCPJYi/f7XfVnwxAhMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1NSBTYWx0ZWRfX++23zMNY5LEp
 2SWGfLix1oUVs5FSOhPNQ6u6sLWEDFnmZgl/gz7GigwAe7Sfr09Xk3jTQWzZaDPMlmG1a9OMQwq
 tp68WYAkmrUQmSUr7/1EaU3BMobQkOg=
X-Authority-Analysis: v=2.4 cv=PYPPQChd c=1 sm=1 tr=0 ts=6a4e7020 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=-O4hDVTBhx9-GJANRbkA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: qIw4ZQgUb62WoVsEQmMOLwZnax0J-8LT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080155

On Thu, Jun 18, 2026 at 7:01=E2=80=AFAM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Move the DB8500 EPOD state handling into the Ux500 power-domain driver.
>
> Keep the old regulator driver mutually exclusive with the pmdomain driver=
.
>
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  arch/arm/mach-ux500/Kconfig               |   2 +-
>  drivers/pmdomain/st/ste-ux500-pm-domain.c | 380 ++++++++++++++++++++++--=
------
>  drivers/regulator/Kconfig                 |   1 +
>  3 files changed, 282 insertions(+), 101 deletions(-)
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
> index 723001004690..1cd5b4985db0 100644
> --- a/drivers/pmdomain/st/ste-ux500-pm-domain.c
> +++ b/drivers/pmdomain/st/ste-ux500-pm-domain.c
> @@ -6,172 +6,315 @@
>   *
>   * Implements PM domains using the generic PM domain for ux500.
>   */
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
> +#include <linux/err.h>
>  #include <linux/kernel.h>
> +#include <linux/mfd/dbx500-prcmu.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/printk.h>
>  #include <linux/slab.h>
> -#include <linux/err.h>
> -#include <linux/of.h>
> -#include <linux/pm_domain.h>
>
>  #include <dt-bindings/arm/ux500_pm_domains.h>
>
> -static int pd_power_off(struct generic_pm_domain *domain)
> +#define UX500_EPOD_NONE                NUM_EPOD_ID
> +
> +/**
> + * struct dbx500_powerdomain_info - dbx500 power domain information
> + * @genpd: generic power domain
> + * @epod_id: id for EPOD (power domain)
> + * @is_ramret: RAM retention switch for EPOD (power domain)
> + * @exclude_from_power_state: exclude domain from power state count
> + */
> +struct dbx500_powerdomain_info {
> +       struct generic_pm_domain genpd;
> +       u16 epod_id;
> +       bool is_ramret;
> +       bool exclude_from_power_state;
> +};
> +
> +static DEFINE_MUTEX(ux500_pd_lock);
> +static int power_state_active_cnt;
> +static bool epod_on[NUM_EPOD_ID];
> +static bool epod_ramret[NUM_EPOD_ID];
> +
> +static void power_state_active_enable(void)
> +{
> +       power_state_active_cnt++;
> +}
> +
> +static int power_state_active_disable(void)
>  {
> -       /*
> -        * Handle the gating of the PM domain regulator here.
> -        *
> -        * Drivers/subsystems handling devices in the PM domain needs to =
perform
> -        * register context save/restore from their respective runtime PM
> -        * callbacks, to be able to enable PM domain gating/ungating.
> -        */
> +       if (power_state_active_cnt <=3D 0) {
> +               pr_err("power state: unbalanced enable/disable calls\n");
> +               return -EINVAL;
> +       }
> +
> +       power_state_active_cnt--;

The whole power_state_active_cnt thing seems to be a leftover from
debug exercise, no?

At least, I can't see that it actually adds much - or maybe following
patches makes use of it somehow?

>         return 0;
>  }
>
> -static int pd_power_on(struct generic_pm_domain *domain)
> +static int enable_epod(u16 epod_id, bool ramret)
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
> +                       ret =3D prcmu_set_epod(epod_id, EPOD_STATE_RAMRET=
);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +               epod_ramret[epod_id] =3D true;
> +       } else {
> +               ret =3D prcmu_set_epod(epod_id, EPOD_STATE_ON);
> +               if (ret < 0)
> +                       return ret;
> +               epod_on[epod_id] =3D true;
> +       }
> +
> +       return 0;
> +}
> +
> +static int disable_epod(u16 epod_id, bool ramret)
> +{
> +       int ret;
> +
> +       if (ramret) {
> +               if (!epod_on[epod_id]) {
> +                       ret =3D prcmu_set_epod(epod_id, EPOD_STATE_OFF);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +               epod_ramret[epod_id] =3D false;
> +       } else {
> +               if (epod_ramret[epod_id]) {
> +                       ret =3D prcmu_set_epod(epod_id, EPOD_STATE_RAMRET=
);
> +                       if (ret < 0)
> +                               return ret;
> +               } else {
> +                       ret =3D prcmu_set_epod(epod_id, EPOD_STATE_OFF);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +               epod_on[epod_id] =3D false;
> +       }
> +
>         return 0;
>  }
>
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
> +       else if (!info->exclude_from_power_state)
> +               ret =3D power_state_active_disable();
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
> +       else if (!info->exclude_from_power_state)
> +               power_state_active_enable();
> +
> +       return ret;
> +}

[...]

>
> +static int ux500_pm_domain_add_subdomain(struct generic_pm_domain *domai=
n)
> +{
> +       return pm_genpd_add_subdomain(&ux500_pm_domain_vape.genpd, domain=
);
> +}
> +
> +static int ux500_pm_domains_add_subdomains(void)
> +{
> +       int ret;
> +
> +       ret =3D ux500_pm_domain_add_subdomain(&ux500_pm_domain_sva_mmdsp.=
genpd);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ux500_pm_domain_add_subdomain(&ux500_pm_domain_sva_pipe.g=
enpd);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ux500_pm_domain_add_subdomain(&ux500_pm_domain_sia_mmdsp.=
genpd);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ux500_pm_domain_add_subdomain(&ux500_pm_domain_sia_pipe.g=
enpd);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ux500_pm_domain_add_subdomain(&ux500_pm_domain_sga.genpd)=
;
> +       if (ret)
> +               return ret;
> +
> +       return ux500_pm_domain_add_subdomain(&ux500_pm_domain_b2r2_mcde.g=
enpd);
> +}

We recently added a generic "power-domains-child-ids" DT property,
that allows us to describe child power-domains for these kinds of
cases.

Moreover, we have of_genpd_add|remove_child_ids() to easily hook them
up when probing. I suggest we use that here as well.

> +
>  static int ux500_pm_domains_probe(struct platform_device *pdev)
>  {
>         struct device_node *np =3D pdev->dev.of_node;
>         struct genpd_onecell_data *genpd_data;
>         int i;
> +       int ret;
>
>         if (!np)
>                 return -ENODEV;
> @@ -196,7 +372,11 @@ static int ux500_pm_domains_probe(struct platform_de=
vice *pdev)
>         genpd_data->num_domains =3D ARRAY_SIZE(ux500_pm_domains);
>
>         for (i =3D 0; i < ARRAY_SIZE(ux500_pm_domains); ++i)
> -               pm_genpd_init(ux500_pm_domains[i], NULL, false);
> +               pm_genpd_init(ux500_pm_domains[i], NULL, true);
> +
> +       ret =3D ux500_pm_domains_add_subdomains();
> +       if (ret)
> +               return ret;
>
>         of_genpd_add_provider_onecell(np, genpd_data);
>         return 0;
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 87554ab92801..35d1b191462c 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -414,6 +414,7 @@ config REGULATOR_DBX500_PRCMU
>  config REGULATOR_DB8500_PRCMU
>         bool "ST-Ericsson DB8500 Voltage Domain Regulators"
>         depends on MFD_DB8500_PRCMU
> +       depends on !UX500_PM_DOMAIN
>         select REGULATOR_DBX500_PRCMU
>         help
>           This driver supports the voltage domain regulators controlled b=
y the
>
> --
> 2.54.0
>

Kind regards
Uffe
