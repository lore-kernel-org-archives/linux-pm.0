Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793752347;
	b=0d17wW8MIO5ltF4iYFgwyucHFolCC94goFY1007VhDxeZobtausHCaOeAyMp39q2zYqM
	 v1uscth03+UWTBy/LN5XaQhIDCvPKvILsyV38fTVgTWJ3eh4jc95bzynu9/cE6vsBsADz
	 byVsOeYxcYCJKRjkbPbnIaJ1+IvlS8489GmrZlVjbciXCMKtYYOdiiy9A7E4mPMzxvEvg
	 e6ifSA/5M4c78TsGMc5vLpOIhkC590She4Xdc2ElEUogxPx/WBFAlMVLYBIBOEECXhqN7
	 /z9fI+ptCkWPS1BpmyWxEaZvIKsREimSfMVB6dHd8vnCC/jBlh7dwbI6vW001sWVgiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752347;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=E3LEqmXFvCMbyxfxq/JJyPbTV3zJ6Nq1u+0O1KDxtrs=;
	b=wcskhu5WqGTjJ+ryFqIfoMCVPUzwgYb49fZgX3HdGp0plir0S87K8qbvFXbgHsEVY3nW
	 JeIt2/KaWgkxE/kZwnQZa7wxZXNRmLZnR5UmmtBVlTYDTJl7hLAF82JhbAjJC99WF4OvZ
	 VQ8XOx46oqXZRueRJvWoRVliHrHh5HhVs76sSLjF7wIYa0A2uHYSkYhutaJvtEcUdUcpU
	 7i9kVBk/PCEojVZMbsTTDbQnGcg6G89SyygkOCpKTh17pVApsUO4vbF45XYmW/gcCxXQA
	 FSZ2ZIXEpqB3kXeMJa90XzyADJE2ai/+0GJSGV0yZMljIcpzWBECMHVYDKpibs+xjZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=paiI94ky;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TQYs9AZx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE872606A31B
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 00:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE872606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=paiI94ky;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TQYs9AZx
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40R15V1191097
	for <linux-pm@vger.kernel.org>; Wed, 4 Nov 2026 00:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E3LEqmXFvCMbyxfxq/JJyPbTV3zJ6Nq1u+0O1KDxtrs=; b=paiI94ky07z36C9R
	BtdvPo084taLci37jZ/cv/Fv+bqQY1xY8PlFhH6tigp16aICkFdPaWXfy+U/jMfR
	akbJ0N8AoAhHPBl8+9GqFTDfm1xmfoPmcnLULxly/FO2YMN7hO/h0632CQ+XCJFu
	9zyLNGvLA8Fo4IiV7O16a8UWwj8kAdE8djso/2/gYMNWwM8Ip05fi8s729SQLPzj
	vzkoAxXHDYMrcti/uBaJsFyL39EXJi7kA3kvUW6kEkdSXljydXDiOvKb4bwKjxMZ
	ffxpScMbmBARv+lADcOX86zuUrSPCk5uliWos+/GRoe0/hGCUnDZtsjOeRs2oTYz
	eev0Fg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqm2phf4d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 00:32:25 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e9d52f684fso1435105ad.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 16:32:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793752344; cv=none;
        d=google.com; s=arc-20260327;
        b=Jm3jHeTdsEx5n8cSWvPsH0rKfKLKXUuhW1Q8VnM3ccFCUdc/Kw+A5wJzYrXf1yYMg4
         FPBnnc/iwKNCn0CuAq1Yf2+LYQ6mk7BcFh1ygWBfnlJVFxe8Te40Y+o12/uiMZSm+7Ft
         KTKI2Gyvafnmie4rZF3X5R8/GjkGx9EJ+ZHeM7miuvaJOFVbC1HsVxdx5goX8J00QWrZ
         rJOJoUH/9KPw2rcK65MtBJLEIgjhuUjGJXPCe82xaKmMKZ7BYQ1NrbAjS1jMzoKaiXVL
         qUk8f8KNYweZnkyL0uqJHHpE3wqytSgHJq6kdDsGgdrzwr+l0Am5CqHm8brQy6mnRbJr
         9yEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E3LEqmXFvCMbyxfxq/JJyPbTV3zJ6Nq1u+0O1KDxtrs=;
        fh=E8A3tbjOb4oZAmrQjCOs/pMnk6ioxplGCOrHOzbU+o8=;
        b=iLWTvtrKQfjdcPxg17/XvCQEiCEkB3dmgkUH0WFZ+ROMgQRgtqco5310ptGEBtRWR6
         9zGVlnZQD/YONIEaL6ZglyDtmavn3fggAEuMv6zv4F0mdLfVddvDTpKr5hmnsXQ8T56g
         AHOCHLC/D/d8Zs2OqM1iMeHMB/L+Z43OmeOZ7H/4vVmWQxofbPvNy3fhNTb6PNjNoYgz
         +CN3UHA8CuS9VBuu/30pgkWGqemWSd35aaubbfeSA/JvtFrMY8kYkhmnqV4Fa4X+4cQx
         QETdj7YK9MbwMoyesxr+f6nJiRvFWuVS6S4MPRM5tY71hKGyEl3vGgQat1TMSJWL391N
         4p8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793752344; x=1794357144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E3LEqmXFvCMbyxfxq/JJyPbTV3zJ6Nq1u+0O1KDxtrs=;
        b=TQYs9AZx3UZffDbI7HR50AL5laQngj0Tr/BhplqwFL5UTFBS7Ut4wtdNcwR7xxxMUA
         hTHBXUo9Qc4JxyHaKxdQffADLJMAPkr53MDJEOcAUOpnLp2X+82DHArJVcetDruBrgff
         0xxmv/44/weCM3dcqD93qLH8ogjEyt0jxJ7ATO65lUtQSactrdbMyiSwxLs8wFXBBLU8
         +Flr5nLkyWHCSlndHK4Jbbkhk1J1z9cTVcznCcyP1tWDk6qM4h86p9g9rbs3OQhFQUrx
         5rJuCylBQbmXshxbv0HFZvqH+HlUjHQH0DiJJFEm60CGiLzkeqeK1TWqncgkQQLj5nKg
         YAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752344; x=1794357144;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E3LEqmXFvCMbyxfxq/JJyPbTV3zJ6Nq1u+0O1KDxtrs=;
        b=NmUqxjdVdoPDgUQuZ8MELwmr6a3EY9L2QYVRUE3+vshRTHailcSeEGifcoiHUl3yqn
         OD2ULiVMijRkpCfLBRhSLFX483FrRJ9XVgP4LDqc+TlV6fZHGUK4knskiQ9BUPJfSShS
         W5uKUltXvNnfmAkEIrUi9WX2ko2HNRUMNW/WiGOPbd1xkuQgg5YVh4jK5AEiHqwb0CRr
         kAXE7eA7CR21hq1wC3wxaABoM6TcN69fglDL3CihW6tF7hkELEh0beJ0ZufxCB5hB0iU
         h8VjHkWYC1dPm6DQ21h8jyY45Y4blM/SAIH4Xm/pPKvM8pgiMcmz2sx3mGYVugLE2hqZ
         uDPA==
X-Forwarded-Encrypted: i=1; AKwUvBz7b0/PUiamJ57yFwkmFlhiZbJmwXOEWYxyA0zdKa8syDM3K8+l4y0DjggXa9g8R77+p6UIixu+Mg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9GeplCWpRJYW7+r3ftkM3vkBFNrBtAgi0fNtiq5k3AuvwsWJ7B
	VjeOBQ+uuAf0vxdzJIyeM8uVu1KSmD/KMdH91fowQqO4nC42IOtYVdgGVHGXNQnpbFcGBD5/+iZ
	gOmZvgiJkWGN+vVHL4EfzMpMYjqLUDW0QnUZMfx7acCW+5I6VQS1ATiozKnEktDZchi9fm+R31i
	0L2XZyKvIy2K6g0hpL8G/wX9s3fK1gtF9LkmunjXvd/XH16p0=
X-Gm-Gg: AYBFou0l+OOKJ0vmHsw8baYRySw72P4mqFFeRkA0ZtyuYfx9bu1hsiAlJm54Si/gYkB
	NMxHffVq2g1VnmzlxFVn95mP1qjVxVcRL1d6pv0somfiuD92+ohp5kfPs97tCZiXOjAHwZZgAkg
	e0vQNm7Z0a4LFX8ronPLPOTmsXwqoSmip14k6rvS9pMAkyZD3R1cP+ikOKQXw=
X-Received: by 2002:a17:902:da4b:b0:2ed:e0d:dbb2 with SMTP id d9443c01a7336-2ed0e0de332mr151285ad.36.1793752344404;
        Tue, 03 Nov 2026 16:32:24 -0800 (PST)
X-Received: by 2002:a17:902:da4b:b0:2ed:e0d:dbb2 with SMTP id
 d9443c01a7336-2ed0e0de332mr151045ad.36.1793752343938; Tue, 03 Nov 2026
 16:32:23 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260924-add-pmdomain-tracepoints-v1-1-d89f3f0a6998@oss.qualcomm.com>
In-Reply-To: <20260924-add-pmdomain-tracepoints-v1-1-d89f3f0a6998@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 01:32:11 +0100
X-Gm-Features: AclHuK_yJ0UFNaHojG-mXEOXNFQIByshULBfM9QEn2cdyRS_Or0qUUS8_D9tVQw
Message-ID: <CAPx+jO97Af9xvSigY71U65GozKRCpuCjU=7DBEqBXMbN-fRcQA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Add tracepoints for domain state changes
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAwMSBTYWx0ZWRfX0J0+qrc8AClq
 FAaMz0svPmDDUfnr9IhidPnZCEv3AnG0YD7bC9JACTmoUrAtuU/Z+31Rf9z4n9cxB4eHjUtnKsI
 xuBUJA+LXW6Sie5s/tZwYCrAF00HZfUUC4iC0VutV/xlt6y1jDAQD+85+j3l7w6eGX4V/OZUQFx
 MBoOgcR57uOxsKVSu1XPSxqXsiIJMV8GTvpUyCBRVJaZy/cx32pFVaaMx3eCXE4lopxW7Dnh0PS
 SF7KFeGeUG6LN4MBZ5EegG4RomezUPNvXvLxEMKK7dfIFuY1Qs9M8rBmCprSUMOD34zOhQEYwVF
 67f00rhWF/5PzSG63Hn7iU1mOe9Vq9DOzrK5PjYOMMxCOUEYlU2EtkqBQDEQghntF4ft3fxT+Zi
 3KzPspNEdb+6z2lj8AMGB+sWwc4OJ2/KfqExP4b6u0raWhn78wM/bjg/iinykcGbr1SVn6hMtN/
 EVNuo1MnWsOrDdBgnuw==
X-Proofpoint-GUID: Bt66JTR51TKVACO5QF9QYv_vUtfR3MgU
X-Proofpoint-ORIG-GUID: Bt66JTR51TKVACO5QF9QYv_vUtfR3MgU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAwMSBTYWx0ZWRfX42kylfDeExao
 g+CE1+5ya0W4FsS/JxthXjs46DCW3M2BN8oIweg7jSCq40vl5Km20m+V0JC6AkxONw+oA9txX/N
 rSO4BN5dsu+nlYxpNE48c3wggKIvE00=
X-Authority-Analysis: v=2.4 cv=c64+0h9l c=1 sm=1 tr=0 ts=6aea7d19 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=a0ICRLMdHAicX5uOO4UA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040001

On Thu, Sep 24, 2026 at 5:07=E2=80=AFPM Abel Vesa <abel.vesa@oss.qualcomm.c=
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
> Assisted-by: LLM
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  drivers/pmdomain/core.c      | 27 +++++++++----
>  include/trace/events/genpd.h | 94 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 114 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index b99c2dcf3d8f..62bd29e5918d 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -28,6 +28,9 @@
>
>  #include <trace/events/ipi.h>
>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/genpd.h>
> +
>  /* Provides a unique ID for each genpd device */
>  static DEFINE_IDA(genpd_ida);
>
> @@ -485,7 +488,7 @@ static int _genpd_set_performance_state(struct generi=
c_pm_domain *genpd,
>                 if (ret) {
>                         if (link)
>                                 goto rollback_parents_up;
> -                       return ret;
> +                       goto out;
>                 }
>         }
>
> @@ -499,15 +502,18 @@ static int _genpd_set_performance_state(struct gene=
ric_pm_domain *genpd,
>         }
>
>         genpd->performance_state =3D state;
> -       return 0;
> +       ret =3D 0;

Nitpick, probably nicer to initialize ret to 0 while declaring it.

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
> @@ -842,7 +848,7 @@ static int _genpd_power_on(struct generic_pm_domain *=
genpd, bool timed)
>                                              GENPD_NOTIFY_OFF, NULL);
>         ret =3D notifier_to_errno(ret);
>         if (ret)
> -               return ret;
> +               goto trace;
>
>         if (!genpd->power_on)
>                 goto out;
> @@ -873,10 +879,13 @@ static int _genpd_power_on(struct generic_pm_domain=
 *genpd, bool timed)
>  out:
>         raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON,=
 NULL);
>         genpd->synced_poweroff =3D false;
> -       return 0;
> +       ret =3D 0;

Ditto.

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
> @@ -893,7 +902,7 @@ static int _genpd_power_off(struct generic_pm_domain =
*genpd, bool timed)
>                                              GENPD_NOTIFY_ON, NULL);
>         ret =3D notifier_to_errno(ret);
>         if (ret)
> -               return ret;
> +               goto trace;
>
>         if (!genpd->power_off)
>                 goto out;
> @@ -924,9 +933,12 @@ static int _genpd_power_off(struct generic_pm_domain=
 *genpd, bool timed)
>  out:
>         raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF=
,
>                                 NULL);
> -       return 0;
> +       ret =3D 0;

Ditto.

> +       goto trace;
>  busy:
>         raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON,=
 NULL);
> +trace:
> +       trace_genpd_power_off(dev_name(&genpd->dev), state_idx, ret);
>         return ret;
>  }

[...]

Kind regards
Uffe
