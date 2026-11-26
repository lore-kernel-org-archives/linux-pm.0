Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795699946;
	b=Is9OKEK6ULl/mazYIbbfey3jHgBv5ZeNHzJmI/Wwae2kIuTV9bf7DTS1ilgUte0KJt2M
	 0Mvzln7yGzwen3GA/cxh8gKaEaIEx9v+Lopcvdt3/lloifKUI/q4BtUU2rNSxdb8uFf/t
	 jduLxNq5VrIsRnydsmMp3HHd+cFUzga84zyP/yC8kCkzlluPQ7xYubTo0a3KHmzVUuOxm
	 ONgA3fBIYpm0+XJG0YcMQEzMtY3/zS3RJH2grJeUHo91hpAYK2RG/KDuk9O6rhoU9HfS8
	 +33b2eaXi/CLzfRHJJPEG97GqLxaGdIdkZ7MAJa8dShlr3uF5P4F3kAHXlgnEn104yg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699946;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sI28Li+DzLKmJsQ0m+B2azDOTyIHcTaeGPC7ob45wUs=;
	b=K98SunVNEA1Azr0j2gzQX3LqvZUh8L7WNdL6Ox3fk9eYhx/O/aqIEMHKSxofw0eeqz/I
	 cpQkkSR39Emkqy09mI/ovEBLsLclfOdrsrdnslkP1QdtDOAI0PgadOs4dhQp+RgdO+DUD
	 LDebRl+QddJcssdVVdIivQrZLant7eZ0ftvt+Nq4LObbE/1lPs4EsP5iL24BbQ1hT+Ncf
	 X9H9HfUrY389w7t3VagjZHD6K2dzM+VSB9SZ5gc0IbzfktSnjWnDlUwqFHGUNmIDyjg3o
	 j3eQvi6pRssqFt6KohpxjdNE2FKUrfyaRqpefcgg+fbRHsN7KUNxWZ6SvBkndQfkRaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E8kd7VCY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SBvTLwR3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2932606A32C
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2932606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E8kd7VCY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SBvTLwR3
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBVShZ1497091
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sI28Li+DzLKmJsQ0m+B2azDOTyIHcTaeGPC7ob45wUs=; b=E8kd7VCYIxTT4Cpu
	lgGMUnLXpD0kZUAL6X+P5Rog3SYs5GFO2dju2DtYH4R9i9kNtjh0dDOym0Ft8QYZ
	g018+IOtBPipDyEAPe5srii8EzkRDO9lR6uoz6FjQE319ejxX2degYTOzj1FWaRB
	X0Cpe5Wqn/ljiQnqi0AIdDtud/gAQUMPkpUmv9yc0BZ58uTZIjGSRn/gaoUoqzaj
	Vjkk3BesHUMhzvq3JRfpwpC1MuBj9+LWobwpWirCh/qAIU10kOm7AqDDYFKGFwJc
	13hOiJWCZH9KkbeDaRP3cXE8JT18zUIBAhNbvFeH+aRh0gV4Pjp2PS71WT25SfsS
	8nmmRg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662y38fj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:32:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2f0f5721453so4826085ad.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 05:32:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795699944; cv=none;
        d=google.com; s=arc-20260327;
        b=VDOIhX50YHF+xfB8VhHzhZVrYay4pisfUT+I/Jwdbss8LB819hPYPdWaqJuUU7rTtS
         p6bkKOBVDu/OGsqUA3DdOzN9wOKySRHVPVtO1JG7Xliw2GDyiwFEmhsgvafrnCUGonrp
         kQnK6dSVPI8/zJmpJVfkLLN3a4SecPJFq1yaI7h3crK3v5Wygh3GXY68VBOTxy0w5Mav
         ihbF0QD+ERbwoHAbOCGNYObvdwCVzM2oC2S4XV00xcEoq6aQXBOOrJqwr4WP2Bw2QaLq
         esFqx5ulONjm5KkOtes/MbYFk8M1g42vhMRn7OfoV/dfugYiJMRB1ZmHGiimUyqwKygW
         xAIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sI28Li+DzLKmJsQ0m+B2azDOTyIHcTaeGPC7ob45wUs=;
        fh=LYWH64PLUkj5j2JGTxdIlOiASw4X5KWOpph3OHOIBzo=;
        b=O6E0wCGincqDxvDllg07HA5fzdJYgMsW5mRMvUFPuZE0p6dlLaazoKXncppY5yf5CN
         SlzlQDGqYgB/P3lMttSA+BHW8Nyx5a5IT5L/yff51XIkeE+Xy6ie2pCLCnKrieoyZ7IZ
         bohA4kVatyoPZba346bFSCHdB/BWc7hg7llb1PH5Yo9CJ4HpsXfhYzny7c1C5pRMCMG6
         Nym1mHoR1IffxJCbXBgAbCWfUF8bZAheDWNos8S1uqFPAeyo0Cpd5hi7TcvCWvjCyKlK
         mvfQS7cfItBIOyHHuUd98GeQEjUSp3JgwAqn5i5OCJDKBn2CVqf/g6G5cbhjUsxF0KNA
         zbDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795699944; x=1796304744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sI28Li+DzLKmJsQ0m+B2azDOTyIHcTaeGPC7ob45wUs=;
        b=SBvTLwR3xCLqLWk8VfxQgXoSSF72XtLrs8Ad5pPRfCBGelN766IO8WZA+H0XoKQjMe
         axZk3uHK6XSu5wwcOlXgrGDB58jDG14IfTLziTnVbVobLvGM/KdzEW/kQsh/4VuTwPxq
         Rqcqgl+JGxxCEwKXlHP/pYCAAg8rniJFk7KuWD39/Pi429r73++xZwo6M+LPzDMpZID2
         BcSKvZQV2tNrOU2m4nVt+geotB5Zb5NmlSYQ91Io01Tfka2TvM1m3ekDhmZeGAP6IeZH
         Ay7+YhA8OjWTnvrHX7L/uev4aG+O0aPXEhjps2RqiViNcQPFj41FkzsVmLzwT6VXP03d
         PE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795699944; x=1796304744;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sI28Li+DzLKmJsQ0m+B2azDOTyIHcTaeGPC7ob45wUs=;
        b=g+1WacWGYvOsES9EW6u9ceSx0r2Hx3l/HxptZwEvSdqA7oYKyfYsin6VoC6XSUN6G0
         u2sETOqhcU0MAMAcaStROpbzUplysLLG/L4WkL1JhwDURfCqbcuOmIPCL4SN+maA8qKx
         A5Q1yXFjMXFHGIR/2Leh9LzVWNAJHD7GPgB6cid2TSReI1La7XZra5v976S7oqEQCo7E
         eLF7QDdtut4YeiSpTs1+AnejbsrIrc/R5KGiCNqCJJEnBpp6/RVtUbzc9slPeE0/KPiZ
         PN8lk27dqqrMZLTEQbBA2ou/UZuhy/w9zg1VZWDXSQiiIulYNx/l5UjjWB2Ue4O+iFk7
         1+ng==
X-Forwarded-Encrypted: i=1; AL+hErHs+wGVlDpAFTB6x0LwfRs5GhM4TjDbxlgDMPmZdlg05K9hm43VthSRBcp0PZGoo4XGUItqK/Glgw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/2gnzYjc5+8VoXaSQgUlEuf1X/JucQpc1jI+MBq4gs8/q1jL4T
	ydL4o6HBoYMHkntcsoPmfKfmeRpeMK7/nakYr89bv4LjBuFKzrZFv9JW4QZkdXATlcldx3mHeQR
	s0tj6uWaTt5xH2J/iOV7kbrSDuisc8DfKffDf3EvQ1aA6SCBcM98+oBXxaXXuZu0tpD2hXn1efb
	efhEh88hVvxWDytDrTFEGAw1wde0/FOvKMqFI5
X-Gm-Gg: AZFdTZc2QiOMInCzMm68Mbtinj1eJzzha+16YFon/GG5K4sNptMY6i65EKeguwZ3Q5S
	fhWkJhi69FvDNYqk2zeSEW5qZ9KdsshRb3JtRDjTgiVlv079V5n11AdR7+Ug2jQM6zJTvAd6gMJ
	wwMKtt7j+74OG6+/RvuxCCy0AFkUpUqVm4mE1z2RaMsdDZz6jAyz0D2IgVTA==
X-Received: by 2002:a17:902:ea0c:b0:2ed:15af:d38c with SMTP id d9443c01a7336-2f03ef44c04mr239219815ad.4.1795699943973;
        Thu, 26 Nov 2026 05:32:23 -0800 (PST)
X-Received: by 2002:a17:902:ea0c:b0:2ed:15af:d38c with SMTP id
 d9443c01a7336-2f03ef44c04mr239219555ad.4.1795699943484; Thu, 26 Nov 2026
 05:32:23 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-add-pmdomain-tracepoints-v3-1-1b41d412b455@oss.qualcomm.com>
In-Reply-To: <20261123-add-pmdomain-tracepoints-v3-1-1b41d412b455@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 14:32:12 +0100
X-Gm-Features: Aa3M54pWNY5rCJkG2YtJadZQS6MdGQmAUqNo-VtLVNXPchDOohVuC4g745cB6ME
Message-ID: <CAPx+jO-M-Mm72q4QL+SGiyZ_8GPLomYGnPH0JVEsSUkt0+opBQ@mail.gmail.com>
Subject: Re: [PATCH v3] pmdomain: core: Add tracepoints for domain state changes
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1MiBTYWx0ZWRfX1g4IlYTR6Emm
 1RwEMzGUVEQ4JguJul+lCUoQI+hxPfelhDQyk9pOy3eQ6ESkhRtSyMKZF6Ra6fwCFWg7/cbFb65
 nJMvOucFo6HQmIEEWSW7PCh4WbXwSgLwtQ24/w4aUbbokJ+cf9dz+ahfIQW9UGKBKB9RC6i07H1
 +PtGz6TjnEUMUNVKyqsJJ/GbD9ifFN8KX2vkX+A4z063QLhfyPLKxW7H5x6RRQIfN7LjLKwhJ4V
 zfOAAUpukDjfsvUOZ2hN8/k6tmbyOcH/PFjUQquRcDt8XcftdajKayPDYt6atBea5KfNZdejm5S
 nKJWyp7mkJbHRaHxGpWnhc4SjPXGgD1UwIVXLXyGoAWZP3vcrPjOIVYFIKLhx4SrxYrGCTi79dT
 sp0cjpDxYfMupXil3uwKiHGTn1B5w1dWRmKd/WyjXad5+LKqQM1aKROxVfEXASzK1ED2rupWSR/
 AzI9MZ83apyo9ioEEmg==
X-Proofpoint-GUID: 6TrRtYZzqeCqdedGDfJWk3-oP1sdJT5B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1MiBTYWx0ZWRfXwM8khP88f8GV
 Yqt+lUdrW+mQe49z89aNuzxwNKKN3+HboqQ/aunJIiJRdwwrwuvPOZeA2zjgVDx03fG+Zzmd3BP
 bKIYBLcIYXX0AE0IN7c2BX4f4BHjBKw=
X-Proofpoint-ORIG-GUID: 6TrRtYZzqeCqdedGDfJWk3-oP1sdJT5B
X-Authority-Analysis: v=2.4 cv=W/KtxhWk c=1 sm=1 tr=0 ts=6b0834e8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=DEse3a4IbsX6LT34LuUA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260052

On Mon, Nov 23, 2026 at 9:23=E2=80=AFPM Abel Vesa <abel.vesa@oss.qualcomm.c=
om> wrote:
>
> Power domain state changes are difficult to correlate with device activit=
y
> using snapshots of the genpd debugfs state alone.
>
> Add tracepoints for domain initialization, power-on and power-off
> operations, and performance-state changes. Record the domain name and
> initial power and performance states at initialization. For power
> operations, record the idle-state index and return value, and for
> performance-state changes, record the requested state and return value.
>
> Emit the operation tracepoints on both success and failure paths,
> including power notifier failures and performance-state rollback paths,
> to make failed transitions visible alongside successful ones.
>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v3:
> - Reuse the genpd_power event class for genpd_set_performance_state
>   through DEFINE_EVENT_PRINT, to save memory (Steven)
> - Link to v2: https://patch.msgid.link/20261105-add-pmdomain-tracepoints-=
v2-1-10672995e155@oss.qualcomm.com
>
> Prepared with help from an LLM-based assistant.
>
> Changes in v2:
> - Initialize ret to 0 at declaration instead of assigning it before the
>   trace labels in _genpd_set_performance_state(), _genpd_power_on() and
>   _genpd_power_off() (Ulf)
> - Link to v1: https://patch.msgid.link/20260924-add-pmdomain-tracepoints-=
v1-1-d89f3f0a6998@oss.qualcomm.com
> ---
>  drivers/pmdomain/core.c      | 30 ++++++++++------
>  include/trace/events/genpd.h | 85 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 105 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index e0bf30c59cce..c8bc57407634 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -29,6 +29,9 @@
>  #include <trace/events/ipi.h>
>  #include "core.h"
>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/genpd.h>
> +
>  /* Provides a unique ID for each genpd device */
>  static DEFINE_IDA(genpd_ida);
>
> @@ -510,7 +513,7 @@ static int _genpd_set_performance_state(struct generi=
c_pm_domain *genpd,
>                                         unsigned int state, int depth)
>  {
>         struct gpd_link *link =3D NULL;
> -       int ret;
> +       int ret =3D 0;
>
>         if (state =3D=3D genpd->performance_state)
>                 return 0;
> @@ -529,7 +532,7 @@ static int _genpd_set_performance_state(struct generi=
c_pm_domain *genpd,
>                 if (ret) {
>                         if (link)
>                                 goto rollback_parents_up;
> -                       return ret;
> +                       goto out;
>                 }
>         }
>
> @@ -543,15 +546,17 @@ static int _genpd_set_performance_state(struct gene=
ric_pm_domain *genpd,
>         }
>
>         genpd->performance_state =3D state;
> -       return 0;
> +       goto out;
>
>  rollback_parents_up:
>         list_for_each_entry_continue_reverse(link, &genpd->child_links, c=
hild_node)
>                 _genpd_rollback_parent_state(link, depth);
> -       return ret;
> +       goto out;
>  rollback_parents_down:
>         list_for_each_entry_continue(link, &genpd->child_links, child_nod=
e)
>                 _genpd_rollback_parent_state(link, depth);
> +out:
> +       trace_genpd_set_performance_state(dev_name(&genpd->dev), state, r=
et);
>         return ret;
>  }
>
> @@ -878,7 +883,7 @@ static int _genpd_power_on(struct generic_pm_domain *=
genpd, bool timed)
>         unsigned int state_idx =3D genpd->state_idx;
>         ktime_t time_start;
>         s64 elapsed_ns;
> -       int ret;
> +       int ret =3D 0;
>
>         /* Notify consumers that we are about to power on. */
>         ret =3D raw_notifier_call_chain_robust(&genpd->power_notifiers,
> @@ -886,7 +891,7 @@ static int _genpd_power_on(struct generic_pm_domain *=
genpd, bool timed)
>                                              GENPD_NOTIFY_OFF, NULL);
>         ret =3D notifier_to_errno(ret);
>         if (ret)
> -               return ret;
> +               goto trace;
>
>         if (!genpd->power_on)
>                 goto out;
> @@ -917,10 +922,12 @@ static int _genpd_power_on(struct generic_pm_domain=
 *genpd, bool timed)
>  out:
>         raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON,=
 NULL);
>         genpd->synced_poweroff =3D false;
> -       return 0;
> +       goto trace;
>  err:
>         raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF=
,
>                                 NULL);
> +trace:
> +       trace_genpd_power_on(dev_name(&genpd->dev), state_idx, ret);
>         return ret;
>  }
>
> @@ -929,7 +936,7 @@ static int _genpd_power_off(struct generic_pm_domain =
*genpd, bool timed)
>         unsigned int state_idx =3D genpd->state_idx;
>         ktime_t time_start;
>         s64 elapsed_ns;
> -       int ret;
> +       int ret =3D 0;
>
>         /* Notify consumers that we are about to power off. */
>         ret =3D raw_notifier_call_chain_robust(&genpd->power_notifiers,
> @@ -937,7 +944,7 @@ static int _genpd_power_off(struct generic_pm_domain =
*genpd, bool timed)
>                                              GENPD_NOTIFY_ON, NULL);
>         ret =3D notifier_to_errno(ret);
>         if (ret)
> -               return ret;
> +               goto trace;
>
>         if (!genpd->power_off)
>                 goto out;
> @@ -968,9 +975,11 @@ static int _genpd_power_off(struct generic_pm_domain=
 *genpd, bool timed)
>  out:
>         raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF=
,
>                                 NULL);
> -       return 0;
> +       goto trace;
>  busy:
>         raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON,=
 NULL);
> +trace:
> +       trace_genpd_power_off(dev_name(&genpd->dev), state_idx, ret);
>         return ret;
>  }
>
> @@ -2576,6 +2585,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>                 return ret;
>
>         mutex_lock(&gpd_list_lock);
> +       trace_genpd_init(dev_name(&genpd->dev), !is_off, genpd->performan=
ce_state);
>         list_add(&genpd->gpd_list_node, &gpd_list);
>         mutex_unlock(&gpd_list_lock);
>         genpd_debug_add(genpd);
> diff --git a/include/trace/events/genpd.h b/include/trace/events/genpd.h
> new file mode 100644
> index 000000000000..2113bec56e09
> --- /dev/null
> +++ b/include/trace/events/genpd.h
> @@ -0,0 +1,85 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM genpd
> +
> +#if !defined(_TRACE_GENPD_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_GENPD_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(genpd_init,
> +
> +       TP_PROTO(const char *name, bool on, unsigned int performance_stat=
e),
> +
> +       TP_ARGS(name, on, performance_state),
> +
> +       TP_STRUCT__entry(
> +               __string(name, name)
> +               __field(bool, on)
> +               __field(unsigned int, performance_state)
> +       ),
> +
> +       TP_fast_assign(
> +               __assign_str(name);
> +               __entry->on =3D on;
> +               __entry->performance_state =3D performance_state;
> +       ),
> +
> +       TP_printk("%s on=3D%d performance_state=3D%u", __get_str(name),
> +                 __entry->on, __entry->performance_state)
> +);
> +
> +/*
> + * state_idx identifies the idle state entered or exited for the power
> + * events and the requested performance state for the performance event.
> + */
> +DECLARE_EVENT_CLASS(genpd_power,
> +
> +       TP_PROTO(const char *name, unsigned int state_idx, int ret),
> +
> +       TP_ARGS(name, state_idx, ret),
> +
> +       TP_STRUCT__entry(
> +               __string(name, name)
> +               __field(unsigned int, state_idx)
> +               __field(int, ret)
> +       ),
> +
> +       TP_fast_assign(
> +               __assign_str(name);
> +               __entry->state_idx =3D state_idx;
> +               __entry->ret =3D ret;
> +       ),
> +
> +       TP_printk("%s state_idx=3D%u ret=3D%d", __get_str(name),
> +                 __entry->state_idx, __entry->ret)
> +);
> +
> +DEFINE_EVENT(genpd_power, genpd_power_on,
> +
> +       TP_PROTO(const char *name, unsigned int state_idx, int ret),
> +
> +       TP_ARGS(name, state_idx, ret)
> +);
> +
> +DEFINE_EVENT(genpd_power, genpd_power_off,
> +
> +       TP_PROTO(const char *name, unsigned int state_idx, int ret),
> +
> +       TP_ARGS(name, state_idx, ret)
> +);
> +
> +DEFINE_EVENT_PRINT(genpd_power, genpd_set_performance_state,
> +
> +       TP_PROTO(const char *name, unsigned int state_idx, int ret),
> +
> +       TP_ARGS(name, state_idx, ret),
> +
> +       TP_printk("%s state=3D%u ret=3D%d", __get_str(name),
> +                 __entry->state_idx, __entry->ret)
> +);
> +
> +#endif /* _TRACE_GENPD_H */
> +
> +/* This part must be outside protection. */
> +#include <trace/define_trace.h>
>
> ---
> base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
> change-id: 20260924-add-pmdomain-tracepoints-15254f2cd40f
>
> Best regards,
> --
>
> Abel
>
