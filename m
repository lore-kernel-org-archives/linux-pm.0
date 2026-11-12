Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453753;
	b=4W6KPz8r9lfd/BDGzTHVl2LCrZot5l61V6Rz5B4P347wit1CpXD8RCyA6tUF2xuxll+g
	 s5A6E7Dzz6ndVacbWuJtrrI/aipK+WJQB54QvHvvdPiGljWaJl+An6YsEJofAphFRSFTu
	 NVARq0XUVmKx93TKE6QIZcoNVVRXgzbfDIL2QI6qIpca+TXG3z8TisqujzhoGoiSLvul9
	 +mI3LXxpWEcCOwoMDVzBhLYE6dIrpvG5h6D7IVflfjpb5ANQkbjHHyBI4/5GAHsXofMQM
	 Try2sCVZzDq1xd/YhW0asKxpqeCXgi31qefFrHnTXLJxTHaUhkPkAXw4VRz4LHqLQEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453753;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=;
	b=CwX2IIjegSOyrcP+jW9xKjYOThfoMBf00cU4GnYDY9RkJcyxChenp63Ftzv93OfCSGRp
	 YRcm9/Db6FvOxfGZcKrlgMyAMT3FrZUn2lqTbxNEV497ITuOqWYZIUY6XhHKvS5MZGn7U
	 tmgFhCfpltsJY1DR4JReeA0XXSYMAy9202k7WCOLDjUf6kbcYSAzOKwJ3TVsRnqXbMgrr
	 MYvV01LLBBPOxj7FzUha5077jwm0jefVY8buI0c7FN7qgxElT4uqmtDFlzTrE3gMDHXbj
	 npuUxm8TL6SUhKJWbSWSKJtnQ8A/mZhcrTtAcQSTS0PQeUR10Mm6/hdneWRNoe8Jrfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LOpIkJFk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YfcOO+8b;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8977606A32D
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 03:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8977606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LOpIkJFk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YfcOO+8b
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2Zfaf3812887
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 03:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=; b=LOpIkJFk1qcw9dNR
	IGn4sA5UCOtmAyOLiqsLJomBSihf4tRG/wVsCktehqAKlkuNZgtYphQhJjW6Y110
	kTG5YWTTru2Y4kr1/8Qaz2fJNsQUA5m5Ka/oMwTdFZcaTTHwgtDbyWShJX3YM2kD
	EmjFp/er0dKt0SxCLGtWua47LlVvaLI2blykILXXkO3UwS+VXzUWZRxAMyr0kUAL
	D2ZraxIHHVBA5T54djHiEvNFaJ4a29MejhkgHnvgHbDKd2hHf1ktkpCFc9c1JW8w
	HlSYTbk1ggYxW2ytlV2rCexQSaEEvjbUKJ7IAbCnqhsZMIW4j1I8fuadDWk7094Z
	MUoEtQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvvw0hw5x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 03:22:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eaae8d29e0so49239875ad.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 19:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794453750; x=1795058550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=;
        b=YfcOO+8b58GCURpz5PXBLv24Uv1uH24sUAtfEyQOlUc9OwlPaHxRxUSu2Wb/xdKsDw
         9nNqgW7xq0qxgqaMr2Wbnrv2lxWwKO4qCJVKmNAeaWhLXOGKsyLr2FO3tqwiyEMcAKtF
         eopnhJ2XDhlR/ff9EIlREaT/fP6MarfDEOyZpQsDkJyCbP5b5QTm1G2QanAcyDn6yL7u
         0qFRl5AhkJ0RAI9Wh563lPvd12X53SiZRpjEphQr471LwLTDeEKjlyJMstJfqPSTjrJF
         KTU8mWBvJpuhlrCtzB3cY0UePYFekSC+EjfzsbCf/ghfk3y3qXlpZsicnvGR3fXBghZJ
         RL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794453750; x=1795058550;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=;
        b=Z6UnS8deGOiiFMiEgVqWU2DWKiotOiaa9VZdXZsGjRrG7NaNEvXsmKj1AbNlcB+g8A
         qjHyT8aHYtqB8dgSkwS/W0v0BO9sqFf2/KM8Q7bFw28PN5JvIn+mXM+Bm/7FxnYROHGD
         mg/pIEgoRVPEm+pcWthMvAimEMH2XwLyBRwd1Feu02dHWo00DZGCnQ/TBvxed6Hijc8I
         PnDRoViDInxwEwKLKPd2wE7INrUL8Id+/VRfQAhtInamXN/KyCSue6qNl8xDj9q+AB9V
         22JH7jhOMJOOVZxYSvL/eA87sw0KELr1mCZNj9vqPMLVPe6heRrW0U0sBH4WZ9Mli5q6
         hp1g==
X-Forwarded-Encrypted: i=1; AL+hErEPlHpvLpor5NrTVrNN1Lm2KZPLdO1HoR5zQhaqEgMT6vU48RlNc+90CBnNmlC4XNPeZx/kZ71jUQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+pxn3sGRlD+6aj10q8hEjTW8WLHZLLIo92KDRvYNE+XwmY3OgJ
	4qlzDjf+hmq37tdkSM4jn2Ne5yS8GwOceL1JQyVitlNmUiNHK8M/ouUR2LB7dvabD0cg+LLJSNp
	kl2QD0VHb/4l5GDB8Dvi7sej6gltzzRz0Mt23nc6lV9JLn6LNIcaDcNr5Sq56zw==
X-Gm-Gg: AYBFou2FuKa/ZzhKBkwS93Ww9V0ldAOxZvkXJ+cliNQrgpSoO2Bm9IAKYDITnZYG1/K
	L+efy7SJQegSpXnPjaCuR/32mtfS5Va1wDaI+TKskwqGF+EF3sTl7JUpc50fKnzhomAqthDxXbv
	YLS1S42M28P3QP5VQpuOAU2vIPdijoGCJp5qUbCI9HU38bwo6WnoLPSvel+1v0ZnJ5L+YpjKiv0
	/PahRzcToMWcNt1KEJpmi876glO9AiuYHQIsTPqSKkuCNzTerPE8OJNlWiEVS42h0X6pFCjhb6q
	BB6I+cIr5L5NQfKlRVRVwyAA8RBbpHQlHoeBYb2jk2auEeTWSNJYNwtnWntnkCGCfA/q45mAq0J
	O0qp7j9HAlf0i3T+IgYUhyiunGDTY9shb9TwFt5KtLlOLCqh7jrgXh1XYnXajZnZ4aSXoira/1o
	S46Z01JuvGbqYBuORGiX/KOdP/1PqqU8nHnS1/983dy4p4Vg==
X-Received: by 2002:a17:903:2ad0:b0:2e9:58c5:8c68 with SMTP id d9443c01a7336-2edd7acfcd0mr38209095ad.54.1794453750554;
        Wed, 11 Nov 2026 19:22:30 -0800 (PST)
X-Received: by 2002:a17:903:2ad0:b0:2e9:58c5:8c68 with SMTP id d9443c01a7336-2edd7acfcd0mr38208695ad.54.1794453750048;
        Wed, 11 Nov 2026 19:22:30 -0800 (PST)
Received: from [10.133.33.220] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6dfb58dsm26134275ad.66.2026.11.11.19.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 19:22:29 -0800 (PST)
Message-ID: <acd476e0-fb24-4f11-b917-c4e86f86171a@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 11:22:16 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] cpufreq: ondemand: Include <asm/cpu_device_id.h>
 unconditionally
To: Pavel Popov <pavel.e.popov@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin
 <tursulin@ursulin.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>, Arnd Bergmann <arnd@arndb.de>,
        Len Brown <lenb@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>,
        "David S . Miller" <davem@davemloft.net>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261111234821.4814-1-pavel.e.popov@intel.com>
 <20261111234821.4814-5-pavel.e.popov@intel.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261111234821.4814-5-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AxDwwVXMe1nvY9A8ppKDzuRsW4wpr-OL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAxMyBTYWx0ZWRfXz8GXeIdyAfYg
 77gCTgZZw7KaSsWPETlg5KL5CengysBs3vhzjOR7xuZtdGW2YBwoZdUe8wq1JXm4H1hJ9t7QtCN
 spdc4r8iJqHEOyffKOVySLmscLnDH4l1P2ZFLN3zsk4NOiia1rpyuqm4Z8v6mYGW/+dzQF97EJm
 rgFFu2dA2D8vTIIfj/+OJVUKIzAILyHu7SuivT240dc2wKL4W7TznjtQ7c2CmEKdmigyZzHbJ3R
 ihYLZ/zsl9P2mxPivUQIWXiYikYkuBEjL5r+wrL/wrzLqFmUNwCPYAjuTZZFSzg7g0hPnyHiN1b
 juto/SjL9uNRRqG6dFc4E0sKajeUqBej+zPTGmP7jhg80+g92omxntdp+umc5jT44hx7sRRykCZ
 SEofDMqhmSUgw4FHyYDyKz0gtH0CY6eaR/TMOa0A8uO5/eGkOJP2SFy8n/G39VdHNnTx2c2PSO+
 K1ABZGevUDQ/E0p7oEA==
X-Proofpoint-ORIG-GUID: AxDwwVXMe1nvY9A8ppKDzuRsW4wpr-OL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAxMyBTYWx0ZWRfXxW3TyPNYB+cz
 75hH5boHX31VMKq3YbrQ73V5ePpdbWtg387Z90s0VfoiHpYijuBI1DTBl/dsJ5CN8mQFG215Ppv
 FSLjjTCanx1337zaDQsxU2/rlcxXpiE=
X-Authority-Analysis: v=2.4 cv=ct8OAF4i c=1 sm=1 tr=0 ts=6af530f7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=L27Nr_72VT4YvYD4_PkA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120013

On 11/12/2026 7:48 AM, Pavel Popov wrote:
> <asm/cpu_device_id.h> now has a generic version, so the #ifdef
> CONFIG_X86 around the include is no longer needed.
> 
> od_should_io_be_busy() still needs CONFIG_X86 for boot_cpu_data.
> 
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
> ---
> Depends on <asm-generic/cpu_device_id.h> from [1]; please apply after
> it is in mainline.


Yeah, this patch strictly depends on [1] (series patch 1/3) being in
mainline first; otherwise non-x86 builds break.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> 
> [1] https://lore.kernel.org/r/20261111234439.4098-1-pavel.e.popov@intel.com
> 
>   drivers/cpufreq/cpufreq_ondemand.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_ondemand.h b/drivers/cpufreq/cpufreq_ondemand.h
> index 2ca8f1aaf2e..0e33865f9d3 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.h
> +++ b/drivers/cpufreq/cpufreq_ondemand.h
> @@ -6,6 +6,8 @@
>    * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>    */
>   
> +#include <asm/cpu_device_id.h>
> +
>   #include "cpufreq_governor.h"
>   
>   struct od_policy_dbs_info {
> @@ -26,8 +28,6 @@ struct od_dbs_tuners {
>   };
>   
>   #ifdef CONFIG_X86
> -#include <asm/cpu_device_id.h>
> -
>   /*
>    * Not all CPUs want IO time to be accounted as busy; this depends on
>    * how efficient idling at a higher frequency/voltage is.


-- 
Thx and BRs,
Zhongqiu Han
