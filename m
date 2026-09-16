Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E754FB9B9
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555460; cv=pass; b=U8Kv4r5fSsgbNMvvuhU0dAE5UJdCSmxKXlq1RxF9wxJAghCPqq6n3NGuNeBZOzc2hrvVTQAV9HLPx0d/D6mIo0inT2XoCehUpwS1PDvDEoXPGmlSeuB7aNDm17XjNJL5/sW63nugYFGtIaiANIPmdIluW5Qvw0ZMzDXmVMRRcYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555460; c=relaxed/simple;
	bh=t3edYH2dAigivGId7bqN7noCiMnep0+qs+Sg8AmKu+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uzTyXH6rAbYd3FvTe7r2xonBmVZMA6dAdGDmXxyGIbKUgKOZEPh2fcEwr4SjRYY/YjKefTSW87OT6BfVX2pj4C+XXm46f2/hNYxpTZVCrZa5y8LhawTq5+2JRoWr4/166pJ1D/viAN8hXJsxV+LSIYU2Z93zTB69RsED9FLw/nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gZ6rf+w/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jHitcd5J; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gZ6rf+w/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jHitcd5J"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G92qdV2122513
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 10:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y78+lX6853THQh6jPcfwva/3VXgIgZTi+BGi02lDQZU=; b=gZ6rf+w/JxrYaFon
	cAmk0VrD2q8pKL0OPvZ3al69fUVfVzDvkNnCHE6Qlv8nv34ChsLpavY203CRAB0x
	93GWKMN1JcVWg4bOhdajrp8/xoC/6LY9wvXR/zJQ5wenH8WaD9vs8A8SQdePID/x
	lm23etvWY5Hb8wWgXdIEg2Sb0ra+LbbFwxNZxdZHtiYbuPJ5DTd+8IjMODWM7Hex
	xXZJF/SEN9zjbw03BPLeo2Z4JV+7E2nVLFvizlijXCM3gJ87d5OmcY7UPhOAsx39
	HHanUQYp5RWi08xs+NvgtA3ZWMYw+OzW/3q9nKB2imUVIvCmlHKTJu473C37frjI
	tguuxg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqkv7hk9s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 10:43:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d94f086fedso79004615ad.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 03:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789555438; cv=none;
        d=google.com; s=arc-20260327;
        b=iylIrU4YUjnHwrd14YcAhk5JmU6Sh7lQkozIOuLP8iQYLGARgDdirWzFa9tXFEscN0
         z5N3BGBdPP9MuoTt+e87dyPEVJBzdPakwnI7mb1sf/jODa7+Ibcab9koY9HigSvtkiBL
         8ThUUewC1WxdzGttU6NGBSHYG02IQzmcvnyxD/ikHReJHgWJczBEVdQCgWKrSvLtTYjj
         OUq9/c/Z7RFZtPL+bAUJBrF1+xLwQyTyM/oGmWqezr01r9CeoZF6pC+8zMjv/vnsWciV
         ClnYqAnPBAdu7y+V/zIlK453bQM7azlbDATjVE98MOORR/lqMoX46o3Y5WBPMwlOu9kO
         zYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y78+lX6853THQh6jPcfwva/3VXgIgZTi+BGi02lDQZU=;
        fh=zFGGbFzVnbrrnRUhpLSnihtYZvEk6G4ztnvRjI3rWvE=;
        b=eXJXtqa/9fgIKkPwiL3RGzm8r8UIbsqlSxYIFFfY9d961ET6sVd4DbzIqDIrVuGySb
         LKwHgwKjv3DqLAQBuUPKYfnZT95TzEJa1uFvyHM/DxYrnRrrDX6DfpzlUWRpKMcv7dYR
         x5jX1s3hIUFsiKMBbGpwDeVVvRnDGYJ/OxCcrjTYtlYeu3+RyACsim8f8dY6feGoZOqK
         R/qPL0LCmaRTYPba+80q9JUANcY5524rOa+XSCYZ6nG3eUoS6R1FchwDPIOM/GEHRlP/
         quEahnpMyg1qtvIQZlNX5RsHYzoLhkQXl+dxL2QBjPpeYw+VlIr5yl2ndT6OKnxV/lNx
         yj4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789555438; x=1790160238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y78+lX6853THQh6jPcfwva/3VXgIgZTi+BGi02lDQZU=;
        b=jHitcd5JsTA9hU27MfOt4sX8PixgUDakuNFD1erGzcEyrtczrfCdX/yIza7e+XTwaM
         yfFh1TzUdoCKKJ6Z8TF5W7dfmxPqaYItzF7qUCu362Yonv2FzPUc+40XsqrXm/7XSaKU
         0K1VUROLxYhlYtZAI5RTiJ/Kef/CNTBi36BVjzCFVDk63jPwTPOC555IeD4Q94WT9LHK
         o+hoDObpVPK5OiHJXPR8OdA1w5ROEJDzZtxIsjBVeW80bNnwZGvoSEbyVyNm/30rOMSf
         7auVBa/ngOw1EbopQCBYQQKbvsDEeQG5GjlcW5LnTBQE3rQ8f7zv6WD2KnHIUODuU6oH
         LBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789555438; x=1790160238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y78+lX6853THQh6jPcfwva/3VXgIgZTi+BGi02lDQZU=;
        b=SDCOVLceCGs93L13ldJ0dgY0LadNOvoX1UK3hdNCKdODNaxmXuJDWwesjC56RwzdgU
         OSe/bjqvo0/Igx+Fz7vhxD4UlIASLZ+mL81W2aTJg8ixqHvshe/dGrvbvAf0jFmGGtuh
         vX/pY7XD7DuMAl9cKVQZ8MuuCmLaTYwNIT0uM9SFA7n0JBdYgfuLdIAZwGa2j25GoOFr
         b9Cq4knLwhkS3G5pO9an/vd4VF9tCi1sOpYWaosa1baaoeeqDe1MNweWekQlkJQNz4bu
         er7UlUouRXp4oXjYV7aiBAtw3wgpyAWHNL25Mf9z2+BbmEGK/kDKbgTrM2wycv85INfm
         HuCQ==
X-Forwarded-Encrypted: i=1; AKwUvByNjfrn2447OnzUv3ou/K+zM1GqnL2Ge2yXu0eMSgcuVKGA3kly2An9HN7V6klcPGCDjRVcj/tYog==@vger.kernel.org
X-Gm-Message-State: AFuF++ly7UXytMiK+84NCO96d7/5hNSqeJTQVWAyJIc7Sr5d5CE3e1I3
	UUBZjjvcr7r8pFs5fmF4GY96MYIbt0btxlUYRGfyWpVe0H9QIWRcekzDi5OWKBJB+XUKPqvV/Ff
	0Cum4GHphFum/Wd3NRyeko2D/2SFBk7Y92/69vmNXWR7GQaB1mXBRpb0OJrsirmNHdB9H1Dz8QQ
	6BFpPBt2UX1RZPNPpmVQtOGpynitpCp1iNvIy5
X-Gm-Gg: AYBFou27i6gZpzA59vcm45a49QFXWFBMGPlf1Q/tKoZFobwfmnEWyKSQOJrt+isgFSI
	Uj7D1n9SmPi5j1RLaVmExHJ3cOfkEQ4NlZ1Y1Tk2fc/LvFh8aGexIthEfpP3pOOMb0/T1dXFJ/U
	9P1bq0xHFLiOn24mQe3OjCVijOGXOhifguQK/Fos2KJbETDPCt7KrfF6GmfQ==
X-Received: by 2002:a17:902:db0c:b0:2c9:c952:6e9 with SMTP id d9443c01a7336-2dd8dc0a434mr43262605ad.2.1789555438316;
        Wed, 16 Sep 2026 03:43:58 -0700 (PDT)
X-Received: by 2002:a17:902:db0c:b0:2c9:c952:6e9 with SMTP id
 d9443c01a7336-2dd8dc0a434mr43262135ad.2.1789555437854; Wed, 16 Sep 2026
 03:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826-topic-lpm-pmdomain-device-constraints-v5-0-28cbf43f7e38@baylibre.com>
 <20260826-topic-lpm-pmdomain-device-constraints-v5-4-28cbf43f7e38@baylibre.com>
In-Reply-To: <20260826-topic-lpm-pmdomain-device-constraints-v5-4-28cbf43f7e38@baylibre.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 12:43:46 +0200
X-Gm-Features: AcwNN1VkH7KPswGrczeol-ocx85P_bczEGyw91JrnZAhKZTlY_XQFiC5DnHJBfA
Message-ID: <CAPx+jO8UWa37s0XSZN2gGjcBrYOR9i_YMyZ8QWqkHoXrqVkorQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] pmdomain: add support system-wide resume latency constraints
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Kendall Willis <k-willis@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: glDsVTQHZH1am6WaSW_88nNZxBW7bobI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MCBTYWx0ZWRfX2PalGKLULI8n
 Zcox/h3oLStupyF0Y7HTOmGFfPjzWy7VGPVmPUEhe5kvs2dw+nOmO48892YTxCkKIlAxToB1fhF
 Crcsjx7NR6O57NVSkcU5Kwzzdq1B3lSL0X9NUVaLymsFzqEOb8xTFDKuVf1ERnFlj2p5FuNYKQh
 XczcsfYnJ3iWgFmHP8IE/HX6gm3VeWvEQl+/mz3gLPG9tTST2efhUimBNe64GgfOFN34b2jFRoH
 UXZnsF3qKunL3uHsufmZ2iknCPc07h3570m0LoW1TRrdpz0mWt3Y9lJnSUG/032Gikx8jSJJvUm
 MNlvmSrAy7YaRabzThkgqQaXw8KmbN7MJTrmkLUlGHpqVdI5xQt908xoUzXfi+OSXaQj0mk4Q2n
 RMsF3uznB+JhaGb4OT3qxWnth/bQQujQvLpQB+k++CrHp6dOJImYLjauDlLvfsiCo01Euy9oKBd
 /tIIXhjckA3TzHhgE0Q==
X-Authority-Analysis: v=2.4 cv=eKmGH3p1 c=1 sm=1 tr=0 ts=6aaa72ef cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=sozttTNsAAAA:8
 a=mx85aQPinzMc39kOTU0A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MCBTYWx0ZWRfX2rGSKwPgOBkA
 HrwsqSyayqWBVKqSlrC90SbCm4KXkr2H4+GP6cUpYMRwsVhjCPQ3u6JLWSFCLdWvHEg6a9jCMe4
 if4YFHHI8dGwVju/+XoE+fkZ4cp+ItQ=
X-Proofpoint-GUID: glDsVTQHZH1am6WaSW_88nNZxBW7bobI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160140

On Thu, Aug 27, 2026 at 12:23=E2=80=AFAM Kevin Hilman (TI) <khilman@baylibr=
e.com> wrote:
>
> In addition to checking for CPU latency constraints when checking if
> OK to power down a domain, also check for QoS latency constraints in
> all devices of a domain and use that in determining the final latency
> constraint to use for the domain.
>
> Since cpu_system_power_down_ok() is used for system-wide suspend, the
> per-device constratints are only relevant if the LATENCY_SYS QoS flag
> is set.

cpu_system_power_down_ok() is especially used for genpd's that have
the GENPD_FLAG_CPU_DOMAIN bit set (cpuidle-psci-domain and
cpuidle-riscv-sbi).

In other words, this has no effect on other types of PM domains that
are managed by genpd. Are you planning on adding that on top or this
is sufficient for your use cases?

>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reviewed-by: Kendall Willis <k-willis@ti.com>
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---
>  drivers/pmdomain/governor.c | 56 +++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
> index 96737abbb496..1a85fd375db9 100644
> --- a/drivers/pmdomain/governor.c
> +++ b/drivers/pmdomain/governor.c
> @@ -13,6 +13,8 @@
>  #include <linux/cpumask.h>
>  #include <linux/ktime.h>
>
> +#include "core.h"
> +
>  static int dev_update_qos_constraint(struct device *dev, void *data)
>  {
>         s64 *constraint_ns_p =3D data;
> @@ -425,17 +427,71 @@ static bool cpu_power_down_ok(struct dev_pm_domain =
*pd)
>         return true;
>  }
>
> +/**
> + * check_device_qos_latency - Callback to check device QoS latency const=
raints
> + * @dev: Device to check
> + * @data: Pointer to s32 variable holding minimum latency found so far
> + *
> + * This callback checks if the device has a system-wide resume latency Q=
oS
> + * constraint and updates the minimum latency if this device has a stric=
ter
> + * constraint.
> + *
> + * This runs in atomic context: for a CPU domain the genpd lock is a raw
> + * spinlock and the s2idle path runs in the syscore suspend window with
> + * interrupts disabled.  The lockless dev_pm_qos_raw_*() accessors must
> + * therefore be used here; the locked dev_pm_qos_read_value() /
> + * dev_pm_qos_flags() would take dev->power.lock, which is a sleeping lo=
ck
> + * on PREEMPT_RT and must not be acquired in this context.  The values r=
ead
> + * are best-effort, which matches the sibling cpu_power_down_ok() govern=
or.

This is a bit too much in my opinion, please leave out the parts
concerning the syscore/atomic/lockless parts.

If we want that information to be described (I guess it would make
sense), I suggest we add that along with cpu_system_power_down_ok()
instead as it better belongs there.

> + *
> + * The system-wide flag is checked first so that devices that have not o=
pted
> + * in only incur a single lockless read.
> + *
> + * Returns: 0 to continue iteration.
> + */
> +static int check_device_qos_latency(struct device *dev, void *data)
> +{
> +       s32 *min_dev_latency =3D data;
> +       s32 dev_latency;
> +
> +       if (!(dev_pm_qos_raw_flags(dev) & PM_QOS_FLAG_LATENCY_SYS))
> +               return 0;
> +
> +       dev_latency =3D dev_pm_qos_raw_resume_latency(dev);
> +       if (dev_latency !=3D PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) {
> +               dev_dbg(dev,
> +                       "has QoS system-wide resume latency=3D%d\n",
> +                       dev_latency);

Do we really need a dev_dbg() here? Leftover from debugging?

> +               if (dev_latency < *min_dev_latency)
> +                       *min_dev_latency =3D dev_latency;
> +       }
> +
> +       return 0;
> +}
> +
>  static bool cpu_system_power_down_ok(struct dev_pm_domain *pd)
>  {
>         s64 constraint_ns =3D cpu_wakeup_latency_qos_limit() * NSEC_PER_U=
SEC;
>         struct generic_pm_domain *genpd =3D pd_to_genpd(pd);
>         int state_idx =3D genpd->state_count - 1;
> +       s32 min_dev_latency =3D PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> +       s64 min_dev_latency_ns =3D PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS=
;

We don't need to assign a default value for min_dev_latency_ns.

>
>         if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN)) {
>                 genpd->state_idx =3D state_idx;
>                 return true;
>         }
>
> +       genpd_for_each_child(genpd, check_device_qos_latency,
> +                            &min_dev_latency);
> +
> +       /* If device latency < CPU wakeup latency, use it instead */
> +       if (min_dev_latency !=3D PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) {
> +               min_dev_latency_ns =3D min_dev_latency * NSEC_PER_USEC;
> +               if (min_dev_latency_ns < constraint_ns)
> +                       constraint_ns =3D min_dev_latency_ns;
> +       }
> +
>         /* Find the deepest state for the latency constraint. */
>         while (state_idx >=3D 0) {
>                 s64 latency_ns =3D genpd->states[state_idx].power_off_lat=
ency_ns +
>
> --
> 2.47.3
>

Kind regards
Uffe
