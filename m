Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794484793;
	b=JtJga7nORScxLGzfqyCFuWxb8hhg/OKtj9qWwPRhWVIuimT9sShs/uGfzG6hm3AYZSLU
	 mU8h4m9VQ8Npq/j7lEEncY4FqLrj0ncE/byHzLRAgeT3q5C6U9YSFUt8jk4/cxNQ4Isu7
	 Henf7Eeuv4N6RmI02TDquRl6czsGfhlRbeZ2cUUogJnGE7IMD6SDwNYf3H4xrO20PCyfB
	 +IRqUnXaH1Ev8qTNC1XrHRK4dmiW3wDRDY2YKgyXhP+N7WIbOjpINse4nGRDgTnGIH95j
	 u07e4kRyZ75mGRt5kxD9RX38O82bmwi4hdu/kSA3Vf4IoZNSLpIDcOoCqOYW2wMq3vQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484793;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ZR6uEupV3b8QdmVl/kBFL9B59flqS8UblZlb2kXnBgc=;
	b=nZj4+C8Sh34gGlvcb6rOo0PBmCR42k6bQPKiFURS3t/sTnr49N8jVN0jsOBlyL/EuWO0
	 XyuaGWcWaMmXnBZgdzzLVk13APS2ymx6uolC6QAx94Fvp0PZZgShZeRT6LucCkldNJxyK
	 KROjkH7xHaoqmQjAVL5VCpLaAA5MFqe+qj038HTZYkIIhNOw3+J7pbfOTUEklp3UgbfK2
	 LSdKrbE5oUrdGHuBSoakIn3ZKYIrMDGSuSO7Arj6HKvXaysykw9OK9bwKAxzgmoFSI5Zh
	 D0zOC85ssQSOMpuPFEuF7C6Fh7/jYLhIZhmPMuw+VpV5ajpfyzy+K3T2zLWrpxcvQKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Odek9yIx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=drrfBw5V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A86606A323
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 11:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59A86606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Odek9yIx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=drrfBw5V
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC9NZxU2514152
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 11:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZR6uEupV3b8QdmVl/kBFL9B59flqS8UblZlb2kXnBgc=; b=Odek9yIxy2RQwzEJ
	ShuYPAxPgB7O7ey45gGAkbeykB2677X//cT4Ih6YUaCDlpecCZmYQA+xXbM6WBHE
	SsACw6Zd09s/8R5YviUMlrf+fy4kCkzEiHADo6/FE1e1T5e5dsrHwGHmHyFY0+Lv
	+N18vgPWUdy0aiOwtM8gGKcospPvMGIwvU8zOvnztsL0x8IFW+ePNH1w2zPOUOq/
	cMN/riIJ/+HwZxzp0heE3brsoWbjURCPNpc77rMAjSUvPXgNtAYcHKfcXchmpK0j
	pbr1Wz5sBEdCPB7RHVsRu5powGIPuZSAUPrWmqEYBv8AHXc/4Egdo3+wcep+NVSa
	GBMm+g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvwm1ueq8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 11:59:52 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdb45b4ed6bso4014795a12.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 03:59:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794484792; cv=none;
        d=google.com; s=arc-20260327;
        b=YgiCD25IS/qpsU2lqIPGYwgFG4aZuCfDTr4YzmHrp1LuFJe0gQ5d0kbE2POahqFInw
         mC6ESEZTt+ewFRUbiFFIROMgOUiyK3sYV/IguLZigm+YBueMa+qv9s1gbpqHOQnVMFJq
         ChXqsLDgUVn4qG4GAPvJRTEp/z4k+GOX7ceDU67M1icLqaSfEVI1WEc6Ve3OLKjUAM60
         /Vwj2HY9AZvbTTJAYapayAVp3qZbYzoZYdoMigJrcVfp4row2sKwouq2bPNuS2gw/qg+
         PJVUahA3pWblwpNAE96BP8SMNgBAonekL4xsFppqn2I+EumzCtQOVB+CcwVmdosYAZsE
         u+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZR6uEupV3b8QdmVl/kBFL9B59flqS8UblZlb2kXnBgc=;
        fh=z6mlh8ywiBanP9b6/pPifxiB6UTITm+aoHZFDP5BGVM=;
        b=oy9laqHP/PvsIxLUYPsXqCRUSwDkzwmfzg11kG8d2mV1pYbHPyEjN8ipfDBvpVkzvm
         8ug0DWEhWYJxVDWO9viywT3ifJqlGREr1QYv18uyR7NnxLRIvLn0uIfSpvbL+/PXIc2D
         UBehILQ5NVMCRux7LE+MwtFKXA+Rz1SL5kpaJSPKlssF9XJMznO9sCKzFECQ+ZNC0mBU
         2cokpEnhSqRJoRX0OAXC/tgvvmyOL4IstUFOe6W9SFz5rSMY9sTsLamP/SzxBzwdpKWe
         zkV5RW8AQI9b/Fv/c/A9b+Jk9EGxnj54S6cargPsWDJtIUzLhaIRsj6uZixmdFAbkEqN
         VZfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794484792; x=1795089592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZR6uEupV3b8QdmVl/kBFL9B59flqS8UblZlb2kXnBgc=;
        b=drrfBw5VhXgSUxmeQBsuifFk8gVMmGGMBij0Pwgdfjq/Z3snOvgX61IDvQtnhk53Vp
         UYN8bhjxF3KV0J0xyM0IvIl1dBYF31aHN83OgEsDCN3hEnB52Iic/7eeSe3MKGFgKyUK
         kU7voNQvxz4QIrDRaHYMHADADuF51r2h2sE0rJl8cOHE8Xh74KNY6LrXYGxoUOehAOzJ
         JzWJ7PgxuEVSN0HhRWxQb5JlgLei+pWfFHe4Fa4X5vuR7BJkH24XJhmMVE21d81Gl6SP
         JXdC9RRe7lqndam+cR0cDEfkOIxpE18C7fdsTEy9XCyO+1OxjThKfVSoTuFrNhSmCE55
         VoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794484792; x=1795089592;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZR6uEupV3b8QdmVl/kBFL9B59flqS8UblZlb2kXnBgc=;
        b=Sqqiq/ticFpkosrS/Ctbd7Ee0F4k59zV4j3ZDPxM1ZoWsuAInT2Faatfhp3F3CYR9U
         GY3zGEFjVI7A0bNY3uD8aL1/ewXrMJvoZBhWNgRHNQEaiSDSFKl67ZGHA5X3+HaIsMvy
         42TvGPfrxByhAqBncKTl0xO7QH3FGIr5gdL5X+EfreeciwaRFW2uHZ1hX2vCiNKVohvE
         IFVz/hcu3wTT20KuQEENrpGU5lOgMBRSmfEnahNHAJ9qTfNZJUAv/zi6x/t+s1BUvgSB
         EEl3466PmVm2KBkeozhyqxEP3rudocyiZeFGzika0NXWs6BqpZDlBFn4dJSyaM+mznIQ
         YCCw==
X-Forwarded-Encrypted: i=1; AL+hErFHM4L2nTYE58sJzqv0u0YGWKQbKO3/oRCyl3j0++sld+QTVkCdzsvBRLu3R3J6lIOef+FjwKMR8A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/QWRsYJ1fr5S6R6cuXsHn0cIDni4CPAe8qDdq2wdUqMvRf3RcA
	dK+zaPJvYsCvyKvlsEG0j/6HUSfiM5XW2jSdwwj/ZumCmzcApelt/Hmy4VwGTdQHc/IZ0NX3Xel
	7QYwMT5XOMziQfxya/953pMsOKJOVvOu405vWz/a6ihr5q/mWiRfIThIjsPLSrVGjSCRsf6ChWz
	BVtQ3yPzR/X7H7LAm0djkXJ5mG2Dvem0f3S7qi9U4v4eFS69c=
X-Gm-Gg: AYBFou0ujp/fb41WM9nFz6w0BJcRDAXps8LtvGFuJMx3yKVg+qVp1LvTUnvE/ILEMe+
	M/Zn5o0ZDaAE+FsMKCBKZdctRvWhk11t98lrGPM+1GbbuBrfn2InqhzZ4w0ntPLKOd5sCd+3idZ
	pRKCiQC/NCJj3Xl/jJ8Vh90pZfqk75fe1oRWILj6bPZt27xgxqDRSFTaWyfA==
X-Received: by 2002:a05:6a20:938a:b0:3e2:8513:a1a with SMTP id adf61e73a8af0-3f2fd595d81mr5861001637.15.1794484791739;
        Thu, 12 Nov 2026 03:59:51 -0800 (PST)
X-Received: by 2002:a05:6a20:938a:b0:3e2:8513:a1a with SMTP id
 adf61e73a8af0-3f2fd595d81mr5860973637.15.1794484791221; Thu, 12 Nov 2026
 03:59:51 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013-genpd-boot-performance-floor-v1-0-a765dc83e6d7@oss.qualcomm.com>
 <20261013-genpd-boot-performance-floor-v1-1-a765dc83e6d7@oss.qualcomm.com>
In-Reply-To: <20261013-genpd-boot-performance-floor-v1-1-a765dc83e6d7@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 12:59:39 +0100
X-Gm-Features: AclHuK_O5nFvGtE_KeD3RvWxSqq8Y9bCLDqrXk6wDOSNp9OUWlbNX9mKOhOCpr0
Message-ID: <CAPx+jO8bFnK9omp7GyCYqfSP=8c0ihQeF8Us2TwDCz6ieVjJRg@mail.gmail.com>
Subject: Re: [PATCH 1/4] pmdomain: core: Support a boot performance floor
 until sync_state
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=KsnYSmWN c=1 sm=1 tr=0 ts=6af5aa38 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=IuyjCjZgo-2BtYxH3yoA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 2og36UpYswCk7ZZbqqnd9NfAsX_sECfW
X-Proofpoint-ORIG-GUID: 2og36UpYswCk7ZZbqqnd9NfAsX_sECfW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NyBTYWx0ZWRfXzZnG4K2UldXm
 qU9IQyz8FFyByhS92PizS4Ahqy6Yyvyc8VtEPw4YfgzZmBQaYhFJodDiOCifgbB3NiSuEQfMMyV
 /vPT8tLzVcgJ2FrweNfiBjZn6cO71zmTelo/vC3SszKJlo88uvuOFkxlYCvg+uQ1Vzop1PrvqpT
 WYGzjaWKG1gITfLzZgTTnTRFbm6rV6pLweusS7/snVoMHdtMzkxvHBncTCILICG4gVNDODdpz/M
 g7m6xBZJTMfGSUtv7A5e96pcv4lr9ibX6Cgu44i0JNRYlaSEXg5Hu+dEthzbO9XD+Exfk5cHdt7
 sXWpXNZKgi02Vdnq0Le55qgTsqS3v0zZ36WXkWDUG9KCdH7q5V3mzgOAc6xhozVZi6kMlzffWas
 v/KQqOV6ceWN4k4R3w74UiCGrWPtekAXM014zBc+HwVLtsrE3VSVIfsJoWK0GrsncIgsDvbilK6
 mJuvsxQ7W6cMKR9Cr0A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NyBTYWx0ZWRfXyXV4D3nRcPd5
 gP/ntGeVvU6mLvTNOX/glDUJyTFaS5WLy4o4wGJp+EACDIx4PFXPFV6LvxSPlHoChYxcZnv+sxH
 72xjrtstndlV+mF3lG0YZB28NeW8e8Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120047

On Tue, Oct 13, 2026 at 2:49=E2=80=AFPM Abel Vesa <abel.vesa@oss.qualcomm.c=
om> wrote:
>
> Some providers retain conservative performance votes until their
> sync_state() callbacks run to accommodate hardware configured by
> firmware. Enforcing this policy inside the provider hides the floor
> from genpd when aggregating performance requirements towards parents.

Perhaps elaborate a bit more what this means for the performance
states for the parents.

>
> Add a provider-specified boot_performance_state for domains using
> GENPD_FLAG_POWER_UNKNOWN. Clamp the effective domain vote without
> changing individual consumer requests, and reaggregate those requests
> when sync_state releases the floor. Zero imposes no additional floor.

Why do we need to hook this up to GENPD_FLAG_POWER_UNKNOWN?

>
> Apply the floor before runtime power-on even without a preceding
> performance request. Do not skip an unchanged consumer request if the
> boot performance floor has yet to be applied.
>
> Report sync-time performance errors and continue the normal power-off
> attempt. Leave the provider sync callbacks and existing performance
> error handling in place, without introducing retries or a new recovery
> policy.
>
> Assisted-by: LLM
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  drivers/pmdomain/core.c   | 45 ++++++++++++++++++++++++++++++++++++++++-=
----
>  include/linux/pm_domain.h |  6 ++++++
>  2 files changed, 46 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 964e44c2f78f..6f2b406ce049 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -512,6 +512,10 @@ static int _genpd_set_performance_state(struct gener=
ic_pm_domain *genpd,
>         struct gpd_link *link =3D NULL;
>         int ret;
>
> +       /* Keep consumer votes intact; clamp only the effective domain vo=
te. */
> +       if (genpd_is_power_unknown(genpd) && genpd->stay_on)
> +               state =3D max(state, genpd->boot_performance_state);
> +
>         if (state =3D=3D genpd->performance_state)
>                 return 0;
>
> @@ -555,6 +559,12 @@ static int _genpd_set_performance_state(struct gener=
ic_pm_domain *genpd,
>         return ret;
>  }
>
> +static bool genpd_needs_boot_performance_state(struct generic_pm_domain =
*genpd)
> +{
> +       return genpd_is_power_unknown(genpd) && genpd->stay_on &&
> +               genpd->performance_state < genpd->boot_performance_state;
> +}
> +
>  static int genpd_set_performance_state(struct device *dev, unsigned int =
state)
>  {
>         struct generic_pm_domain *genpd =3D dev_to_genpd(dev);
> @@ -563,7 +573,7 @@ static int genpd_set_performance_state(struct device =
*dev, unsigned int state)
>         int ret;
>
>         prev_state =3D gpd_data->performance_state;
> -       if (prev_state =3D=3D state)
> +       if (prev_state =3D=3D state && !genpd_needs_boot_performance_stat=
e(genpd))
>                 return 0;
>
>         gpd_data->performance_state =3D state;
> @@ -1180,6 +1190,14 @@ static int genpd_power_on(struct generic_pm_domain=
 *genpd, struct device *dev,
>                 }
>         }
>
> +       /* A consumer may enable a domain without first requesting an OPP=
. */
> +       if (genpd_needs_boot_performance_state(genpd)) {
> +               ret =3D _genpd_set_performance_state(genpd,
> +                                                genpd->performance_state=
, depth);
> +               if (ret)
> +                       goto err;
> +       }
> +
>         ret =3D _genpd_power_on(genpd, true);
>         if (ret)
>                 goto err;
> @@ -3794,6 +3812,25 @@ int of_genpd_parse_idle_states(struct device_node =
*dn,
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>
> +/* Called with the domain lock held. */
> +static void genpd_sync_boot_state(struct generic_pm_domain *genpd)
> +{
> +       unsigned int state;
> +       int ret;
> +
> +       genpd->stay_on =3D false;
> +       if (genpd_is_power_unknown(genpd) && genpd->boot_performance_stat=
e) {
> +               /* Reaggregate real votes, excluding the boot performance=
 floor. */
> +               state =3D _genpd_reeval_performance_state(genpd, 0);
> +               ret =3D _genpd_set_performance_state(genpd, state, 0);
> +               if (ret)
> +                       pr_err("%s: Failed to sync boot performance state=
: %d\n",
> +                              genpd->name, ret);
> +       }
> +
> +       genpd_power_off(genpd, false, 0);
> +}
> +
>  /**
>   * of_genpd_sync_state() - A common sync_state function for genpd provid=
ers
>   * @np: The device node the genpd provider is associated with.
> @@ -3813,8 +3850,7 @@ void of_genpd_sync_state(struct device_node *np)
>         list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
>                 if (genpd->provider =3D=3D of_fwnode_handle(np)) {
>                         genpd_lock(genpd);
> -                       genpd->stay_on =3D false;
> -                       genpd_power_off(genpd, false, 0);
> +                       genpd_sync_boot_state(genpd);
>                         genpd_unlock(genpd);
>                 }
>         }
> @@ -3841,8 +3877,7 @@ static void genpd_provider_sync_state(struct device=
 *dev)
>
>         case GENPD_SYNC_STATE_SIMPLE:
>                 genpd_lock(genpd);
> -               genpd->stay_on =3D false;
> -               genpd_power_off(genpd, false, 0);
> +               genpd_sync_boot_state(genpd);
>                 genpd_unlock(genpd);
>                 break;
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 14e0e346c610..5927d9485054 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -129,6 +129,11 @@ struct dev_pm_domain_list {
>   *                             powered on during boot, genpd will preven=
t it
>   *                             from being powered off until the ->sync_s=
tate
>   *                             callback is invoked for it.
> + *                             Providers may also set boot_performance_s=
tate
> + *                             before pm_genpd_init() to specify a perfo=
rmance
> + *                             floor until sync_state. This must be a va=
lid
> + *                             provider performance level, not a corner =
index.

What's a "corner index"?

> + *                             Zero disables the boot performance floor.
>   */
>  #define GENPD_FLAG_PM_CLK       (1U << 0)
>  #define GENPD_FLAG_IRQ_SAFE     (1U << 1)
> @@ -221,6 +226,7 @@ struct generic_pm_domain {
>         unsigned int suspended_count;   /* System suspend device counter =
*/
>         unsigned int prepared_count;    /* Suspend counter of prepared de=
vices */
>         unsigned int performance_state; /* Aggregated max performance sta=
te */
> +       unsigned int boot_performance_state; /* Provider-specified boot f=
loor */
>         cpumask_var_t cpus;             /* A cpumask of the attached CPUs=
 */
>         bool synced_poweroff;           /* A consumer needs a synced powe=
roff */
>         bool stay_on;                   /* Stay powered-on during boot. *=
/
>
> --
> 2.54.0
>

Kind regards
Uffe
