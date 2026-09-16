Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086104C9571
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789553136; cv=pass; b=lQWyF6sLBnjS+Nvy7lQmq7XNtc/ARIwvIYW0bolB3yfHspi71phrR1D0kLgD8rKWWfgjd3FOtMC4biIZ3/4mpyUfMZVMsFtu+Ik6IOOomvJClmjxqP1XpA/8aQUdRfzABg7tjAUnorwVlDyeFXNWgJZrHDC2waI/XgDuQUMiYxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789553136; c=relaxed/simple;
	bh=KlpZ4C0QQdv2EApImmTIaLHJ1hkTLasWN8lwuqZplfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5p0aS8U8Tzv8PlnW3U6lfl3SrTNjaV//PS0F38v22ERjVASO5X+BZ7jJekZE1PlpkrsU0OVTIK+iLa2k57/bm+epgZz1rng1cW/vs94kg9P6jE75zXkWx4BHBLrHGMDgq0L4aVrjq0LzoQgEhojPourd5x5Tb65qQlhbPIL+OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GPiNzVCM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IznMqMN0; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GPiNzVCM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IznMqMN0"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G93AcJ2823494
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 10:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PSR5EOGHcLdXyZAnVrMn+XyqdBGVNfkPcLIWWuDPkWo=; b=GPiNzVCMH+ZeUP9A
	uSspZ9ihshyuZvEwAjs5fyDGQDVtt42buciCHKFvCJCtZxh0jiT/hg0vG9Z54Yzr
	5fuORHgosgbGnX7g38g52Y4vg/8GsJ37wopKXy7Kio5ZMs3bNG1csOD3lDGWLi42
	L9R3H5IEmItJF2+QnCo1bVdf2x9pyVNAp1QfVkPC3a+fogxZQ/91LwXyB+4CgxKY
	QLuKlUEkjzDjLRsf+p4Rt0Bv/x4Kkdu4ckBC0K8OPj0g6ss7xO6kqpSeZcwuKfZv
	Z6EaQfmVi8AlraOX37PLYMVteKKBnV18EpoNA0NI55uRZhYUenT63u1/FeTsfI5R
	9R+wtg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqfvfj7f0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 10:05:16 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so10781459a91.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 03:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789553115; cv=none;
        d=google.com; s=arc-20260327;
        b=emEcyYb83o036lSBODXJYw5KjAnYTei8kk2i1aTiTr0v1CDVpvchimds2F50Lx8xqY
         t1VW+A1GlQxPhRgUHzJx3mG+pmq+9lCEWxc5E8rZOmTWwuJTK6euynoF4gKVf4nwEI4S
         Rqedw7poDYeAHNj1Kwy4knePMayqPMEHQ0dKz2KD7YWVeRYGYJ4wzT8rwOyHP9CnxlVz
         O30n0N7jmcyeABFZv9l96jlD9iw6KK+ZABvo5AHJIu4twWjTaSu0qb8sQjFRNklkUkQI
         G0q+hRRrsbwEbwd11zUjixZPXoZBRoyuEHP6XVYmOgAplCn56adUxdZulZwq/47NtSFG
         5m5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PSR5EOGHcLdXyZAnVrMn+XyqdBGVNfkPcLIWWuDPkWo=;
        fh=pluai/i0eCO/wmd01qifiPKijAzxLifC0r9sViNQjc4=;
        b=mXI59eMaZdFh4YTCRmXfTvGCj/W1fsTUa/7QPoRkyaedT/w1AChayrzKp+guBppfLk
         OrN8AKBeXKVd17hfKCTte3fcT5s+YbbNeQ1bVYivIl1BYdox/F3kGLOeOb1wGarGGC++
         W8UbH5j4DCzjTeOLI0lVSVeRKKO5ar1otz2XuSdnlhWU3Pv1LaofiQ+mTNjTFg6EuoU4
         ASIrjJn0RA73EfWRX9x+VyPw7WkmxQnZ+Pt2UL1N+9yVs3q9poLR74niv3HZtJWlca/P
         VTchYweTKGg81gx1y8DEIalqx75MSz3CPa8f63bURRt2Ex7PYVCksn6Jnjbjq0ohBvHm
         JoMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789553115; x=1790157915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PSR5EOGHcLdXyZAnVrMn+XyqdBGVNfkPcLIWWuDPkWo=;
        b=IznMqMN0lvMew+jiZRR4yw8z2dhXSPAeRYsmd7/m5q5C5LzDvQuhPg4wexSOe2OdYE
         zVZvoU5jLvicmETFMTbnhHvpPuY3jWYRkO76IpKWZQcARoMpY6GNhTQO9ds25p1dWzii
         wqMCTIpmd7aAWQzcz9EqFQz26x6cHAbgTBTRFQwGc5NjZ9tXtqqOO8gWhE5QALez68fC
         ph2xI8ktVAlngEvsdDgMuBfJMSV3Vq8iHWWviXshkXkSr2NSJ62vv8sb3d6vyUz+AcGe
         uBnSxutepiRC2jLRjgCEqfWgIaRnR7Xo0wMdW8uCeRrggDOfj8VL141s2QTq8KtFv3wJ
         Y+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789553115; x=1790157915;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PSR5EOGHcLdXyZAnVrMn+XyqdBGVNfkPcLIWWuDPkWo=;
        b=mR+L2u7usDnzQeipzRPSX9jk/rIfN0ssQGpR6Zuxq1CFEEMs/ZV8n7r8ehHklarc7s
         qyTBiY/XmVx4YlPWkOx/J4q4Vg+KBWysRG96VuT54ABJQdAKHQrxJ+C8LQ2gAXQIxmqS
         4FMyKQsS2tUMgU7dpaPcOtnPqTbQ2TVghbR2ShoXK4+xpcuJ/sLaCfpXqCEJ4W0cB8qN
         EW1IGfMIjjwVxM7W9DNmSi3cU1Y8JiQ5V4atpm8oTVX6EXLEjLTTx7kv/hPdgR7uVIez
         huw9NQ79AUmQT6kio8B0vv6n476BHYk9G8Mi7SeZbl37WUWcpSXFg1OLdCN3MfVm/6ut
         Y/oQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4ak2ekWjgXAKhPsWVsvYXpv2Zp/tikPMqofxOcGboL2JSZyDvnxiwDvGcRtpvLKg7dNZGV3b5rw==@vger.kernel.org
X-Gm-Message-State: AFuF++mBpn/jdXte+/3Kx2rEMcDrvPmJekMxSQ0ETao407oT8+fUuwZH
	g32Jvj2kUesai7GawKmlg1FFbkHEQHloMH4jVvT9Q0TNGptCMzlvghQi5ISR5IUah4V0oNlTZ5U
	Jj4rOzOueugmTGhEzzxMuXgREi5EgXRCiy/C6rijzrw65ULoHn55blmoFgWITfOVRn7WWEJx/U8
	jQEH9Uip5REjqaRkZ74I5eateq9wmN5zZseuu18vw9/y6VeVU=
X-Gm-Gg: AYBFou1CPDTwDgFX3w74PHWxeS6qop4PCHItLdVTpe5uJJWNpWOrnaFFlvyhu05f2zi
	iMj4/WhqfmRcJrSQ/RG4Yei3vJTNrbiHvoVPGJgpyxXVMMr4FO7XXxh+BUgtxxcz5PDM1vWhvRQ
	lTb3m4Djthxvnue56OgaZLVeOzCQybHYIO5/zqHecC9y3OPZfJd1swcVCH0Q==
X-Received: by 2002:a17:90b:380f:b0:395:7fff:a08f with SMTP id 98e67ed59e1d1-39e1df8d6b4mr4834573a91.0.1789553111782;
        Wed, 16 Sep 2026 03:05:11 -0700 (PDT)
X-Received: by 2002:a17:90b:380f:b0:395:7fff:a08f with SMTP id
 98e67ed59e1d1-39e1df8d6b4mr4834324a91.0.1789553110438; Wed, 16 Sep 2026
 03:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826-topic-lpm-pmdomain-device-constraints-v5-0-28cbf43f7e38@baylibre.com>
 <20260826-topic-lpm-pmdomain-device-constraints-v5-3-28cbf43f7e38@baylibre.com>
In-Reply-To: <20260826-topic-lpm-pmdomain-device-constraints-v5-3-28cbf43f7e38@baylibre.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 12:04:59 +0200
X-Gm-Features: AcwNN1WI-MdWn8rAblKl-alZ71Ey8wbhj5YrVkwbn7F-hMM0YrftV2KIH8INN4c
Message-ID: <CAPx+jO98X6dr20r3o7iHUq7zrjsDy+6YDM=FiO6MOkpCJFfhEA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] pmdomain: core: add genpd_for_each_child() helper
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=JYkpPkKV c=1 sm=1 tr=0 ts=6aaa69dc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8
 a=gpB5Iu8SvZwnZuIWQ9MA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEzMSBTYWx0ZWRfX6pYKwmgjP/Hb
 69SD9/TTkHA2fj/y/rxfcYvillGtL0oB/yFtOLT08H2XG5Xlo2O8Euu8QAcPxxZdqsHuX67+G6j
 Z2fu8t3IiX2VkBizGqmzYYP3U7cWEOA8cWgr7Y1y+aEgaoPb/ffqt9b04BmK6TWMJy8qnzMLJRN
 6xXoxR6d7w6Uh5Skv2rYGhXDoROodQ62nNPg5gVQ6MdRXIx86xQELIrY2ysefuuX37tAk2TP/pa
 oCOgxe1ZSBXtTHVpPFR4lQWzqXECOesiXGlN6zBnXKmZHVAh2QyKoBihw5L6Mn6aag79C6MdzTK
 EfWaIuegVH3Ccln1pnn8EBLNvCr0quMTUjzkGsIUXRgsdQUo8MtcZ2lmktwn6HpdE5si2mHqq3V
 G4uAHi+TanMTCPhbjit0CNkexpFyxBjkrzOH7C0SZ5TyLxFdsYkYTbmsfJx6atMOAMPGS9nhjHY
 TglGFt4mNDoBm6vQ9ZA==
X-Proofpoint-GUID: BZqA2hcDB2O_XADtKpd0JNMC2puqgO7n
X-Proofpoint-ORIG-GUID: BZqA2hcDB2O_XADtKpd0JNMC2puqgO7n
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDEzMSBTYWx0ZWRfX8685xYaXJIzD
 VK2CUijJKb9TguUHLgGrezkO3qD5ym+/os+PH7p0MF8w2dvcNooOnUicyoLzXBL89sDiKO9smqW
 SQd+xmxIy3NIkX7NPuVFCKTB2u2BfXk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160131

On Thu, Aug 27, 2026 at 12:23=E2=80=AFAM Kevin Hilman (TI) <khilman@baylibr=
e.com> wrote:
>
> Add a new internal helper function genpd_for_each_child() that recursivel=
y
> iterates over all devices in a PM domain and its child domains (subdomain=
s).
> This helper is useful for governors and other core PM domain code that ne=
eds
> to examine or apply operations to all devices within a domain hierarchy.
>
> The function takes a callback that is invoked for each device, and suppor=
ts
> early termination if the callback returns a non-zero value.
>
> The helper is defined in a new internal header drivers/pmdomain/core.h an=
d
> implemented in drivers/pmdomain/core.c, making it available to other PM
> domain subsystem components.
>
> The first user of this helper is the cpu_system_power_down_ok() governor
> function, which uses it to check device QoS latency constraints across th=
e
> entire domain hierarchy.
>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---
>  drivers/pmdomain/core.c | 45 +++++++++++++++++++++++++++++++++++++++++++=
++
>  drivers/pmdomain/core.h | 17 +++++++++++++++++
>  2 files changed, 62 insertions(+)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 842c4169e290..ff27369d9a97 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -24,6 +24,8 @@
>  #include <linux/cpu.h>
>  #include <linux/debugfs.h>
>
> +#include "core.h"
> +
>  /* Provides a unique ID for each genpd device */
>  static DEFINE_IDA(genpd_ida);
>
> @@ -276,6 +278,49 @@ static void genpd_sd_counter_inc(struct generic_pm_d=
omain *genpd)
>         smp_mb__after_atomic();
>  }
>
> +/**
> + * genpd_for_each_child - Recursively iterate over all devices
> + *                        in a PM domain and its subdomains.
> + * @genpd: PM domain to iterate over.
> + * @fn: Callback function to invoke for each device.
> + * @data: Data to pass to the callback function.
> + *
> + * This function recursively walks through all devices in the given PM d=
omain
> + * and all devices in its child PM domains (subdomains). For each device=
 found,
> + * the callback function @fn is invoked with the device and @data as arg=
uments.
> + *
> + * Note: this function is inteded for use by the core and governors,
> + * not for pmdomain providers.
> + *
> + * Returns: 0 on success, or the first non-zero value returned by @fn.
> + */
> +int genpd_for_each_child(struct generic_pm_domain *genpd,
> +                        int (*fn)(struct device *dev, void *data),
> +                        void *data)
> +{
> +       struct pm_domain_data *pdd;
> +       struct gpd_link *link;
> +       int ret;
> +
> +       /* First, iterate over all devices in this domain */
> +       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> +               ret =3D fn(pdd->dev, data);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       /* Then, recursively iterate over all child domains (subdomains) =
*/
> +       list_for_each_entry(link, &genpd->parent_links, parent_node) {
> +               struct generic_pm_domain *child_pd =3D link->child;
> +
> +               ret =3D genpd_for_each_child(child_pd, fn, data);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  #ifdef CONFIG_DEBUG_FS
>  static struct dentry *genpd_debugfs_dir;
>
> diff --git a/drivers/pmdomain/core.h b/drivers/pmdomain/core.h
> new file mode 100644
> index 000000000000..a296134d4005
> --- /dev/null
> +++ b/drivers/pmdomain/core.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Internal header for PM domain core
> + *
> + * Copyright (C) 2026 Kevin Hilman <khilman@baylibre.com>, Texas Instrum=
ents
> + */
> +
> +#ifndef __PM_DOMAIN_CORE_H__
> +#define __PM_DOMAIN_CORE_H__
> +
> +#include <linux/pm_domain.h>

I don't think this is needed. Instead please make forward declaration
of the structs we need. Like:

struct device;
struct generic_pm_domain;

> +
> +int genpd_for_each_child(struct generic_pm_domain *genpd,
> +                        int (*fn)(struct device *dev, void *data),
> +                        void *data);
> +
> +#endif /* __PM_DOMAIN_CORE_H__ */
>
> --
> 2.47.3
>

Kind regards
Uffe
