Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794657021;
	b=15Icym4SJERctEXsXHAaH2KFmdNfdU6GJw++hyYWnyBh8NGT7NDIL3lMaZ+s8dtS9tKy
	 DFWy0H+tmEZSThuAldMHg0wJvrQFk5Nn7LvIlcXE6xFYAdZzxrYn1yTFq6uv6EYnhvis3
	 26v9TR116mIMQcAGhyQQ+lExuOzDcgD2z3oJ/Gdui+oiNr8y8bqMSYlH2I3fC+1Cmnt4B
	 nwxOnRCHieS826DbYi1kt70zRHUj4x4hOA9lUUPgcAb079NmnWhGjz2RHEcVhUlb+KqPG
	 np9qYQosPSB4Tu+jvKeHZhYlwGpkyoECnlulAZzfyS4gqyh/zqaCmKBHUaXQmta78/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657021;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3WT+t3FInytvXm1mhUrW8IU5slGuhWBT6i903Bgr7MA=;
	b=kXyRMFMsJvQ+pG/w1lb2jCh2geUdVHk+5V+TXAg7EJOBfd7MwAqF6ImcGkaLgrFtDJqO
	 5aPVP00VkWkj7tZNUXW1uXOrgNoBitmu5Hf4wFWU01moSsRjtC/4DXapRcwjovb4qeKfJ
	 CnIXWxoOVQMcMd5220mTzddDhqYQfB2H99TqnuxzFbUxHNwywUuwuPeQ0UOR+v/Gb74x4
	 gUNi2H/l26jNDnsLynYHbliidXssaPLU04CLx0EyxMaUiSAFAQDzDUM2FQkv8wEHwwOcA
	 rlYGTvZ8CihUF3rrN8NOvkL6o8NJb3+JCbH3QioMTy9nHzTMNLMmKs56QtD22wFE03A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=evgrxfI2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Agj4Y+w8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA76606A323
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DA76606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=evgrxfI2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Agj4Y+w8
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9wWOk3379716
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3WT+t3FInytvXm1mhUrW8IU5slGuhWBT6i903Bgr7MA=; b=evgrxfI2jraTFdFB
	Zux+Ealuwzn/cNDaiX/6G4yXxBo3JwZm1xS4OyzRKtgngeW5vOMYostRzGgD2vUb
	ys4yhJgD0dSd9bz93SFAT5lXVbsxYDkCRhySJQAs2nJf6zAALm1lgqSbHopb9/jp
	LT1JA6dnIyOtlKMcuVsIFh2cKeOfkyJ3ZcQx3GKyG7GIM/g8mcCXP4jbxvPOTmHn
	vLXZ/Iw9/xE8AgvfnYxyPXaQ9ZVjpuS9t+roL0zs31SCABLXal7SckTveiMZ/1WM
	Ue29HHOoK/nCzPWe98nLyqszHUUZL2cvH/BhmiM1/JVGalS+g8Fca0g/V3M3O3W+
	nh9Ehw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhnx0p6k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:50:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b10afdf947so2686307a91.0
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 03:50:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794657018; cv=none;
        d=google.com; s=arc-20260327;
        b=KxJ0Lni8L791PSi1MhYq6jyXUstYW9UhAa7QqkirYUjJSbnthohsMUNKmehlTZGvLT
         i4h0MHLRGgb/Q5p933kTYgjEoY6JAT4jb8ijtQwefrJ2QWO4uHYXkpKE7wuItLlDLaon
         YOi1v5lSJOHwdsbuUTSsgEjlAxIvDV5fu+K048Xt/RbwL4Sk+xHTfKGZuxhrqDaEmaRY
         L9Xe7k6J+Vyd5vbrfNMuJhU1aKPePPmmp5wYKgUbZe0fuI3eh5Pw7omUR1vL0SgdcQS2
         MCKNlaocEqWXqGgAqBx7Uuvos81JbHX2fhx5zajCdbt1z3aLhdX6WP80bI/y+7gUCwxN
         bPeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3WT+t3FInytvXm1mhUrW8IU5slGuhWBT6i903Bgr7MA=;
        fh=O/PcFU4xrrz/M6Wj4LQJhZjtkI4HpBRMe48n/IKoT0Q=;
        b=YPwQCXwDsjLshTjcIEdFyd5mrDxAGfM/B9JJzJu9hoWoTMWCypwTWiKZLCBkVgissp
         obrB08Jkm7m9D7cGgODAoM+GrGrmHseZV0LEcbVmbqiuFc76NRgC28drKII/fhFuSmta
         O9/U2Lyosh99R28Q7ZbJ/xnqywY7e2uddcc7GO4PJ4ZDbyLf7Vonw9lnfBg/byCcuUxf
         QQo+Du35EqMptNgJUAvgmloSlhtTqrDEp+fu+87hpHl4foBjI3r5sxYGum4uOnU9w1TP
         NAshSvmWdL8HobSRQueSyJrC0DuO073n6D+15CZrqCAiJChWHzzVYSOgDNZm/pNKm5mS
         pVpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794657018; x=1795261818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3WT+t3FInytvXm1mhUrW8IU5slGuhWBT6i903Bgr7MA=;
        b=Agj4Y+w8gMjXoViCM/a2gHLHpJnfeB+T5S4nufSB7yl/TwdfR4epJII7whF4ww8/NA
         l7FrlKZQjtRT3cEvTYJ1Y22gyJ7ebh+lxbGu82MJYdiIPItvE+iNr2Jk2sYCgVjtZqEG
         hX9O5+4Vv1Ar29O/Vivnh9qav5rcNg2trJXY942ooIOf63xh5r5tpt9EDmF8RSEJUh4L
         911xOsaWErfKtD3N18yLz/wb6tLEGUx3s+YVRT8wbGAtfGp4YA4uogGs0HQOP4pUeiXV
         xGPdd7iqM4HSe8O81mfxLgkuo53Acv2wH9wU7KhtLGeeB0LsAdI9EKf5evQqWw3MBlZA
         4OWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794657018; x=1795261818;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3WT+t3FInytvXm1mhUrW8IU5slGuhWBT6i903Bgr7MA=;
        b=GyEmGdjpqcHWTBz+x2iEA8eWLVQqBtC2Ma/aGhoCHIJE9DdO0872eVz94BlWFr040d
         j6dmlMjXlF2xcFqKhJdphDV7jxQ+N4qkGCQeUPR2Gy+uMrqzuGg17GqdrzdBZzn8TYJK
         sH3E3k/M1dF0sgFX+KISF1gHxwHaLeXbV3Jply/wQ2RLrERz62I9T9cmQQLvOQiBHiBN
         BB5dOmjRFPgGEsnfQALRHjnNw8c176SlNFUwoF3VsyD+GVHQYG+lQ8AizW1c1E2F9eJ5
         zekdGKh1E0ytN50rNXCt/GgTNKslnwRrQml1lea18agY+2Y5czujJVDTv/JyEOr3OrIm
         6BKg==
X-Forwarded-Encrypted: i=1; AL+hErHx8RgUpVWf6e7QMVLWMyQ7u2bcJIiahiA/xSVLYfTmc9qurkRtO5orVcU7A/HuEi9Bxk4/F4r9Dg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+AWj5DtY9YLjoHoVkqykZrk+Huf/0Z7RmmVSZgqx8iPpJ7uIWG
	XAX9LpTyADWrPurdm9wPjt8w7YRNd+yx05Bf2XxjjAAtmDwHvpTr0tyyttUOqF31UjhkyRzGTUv
	rawf71RjIE6ZIwUwMmIDBrRNxaHyoElFI3iPrzpyy1IDm0t9KCiv6cILUla74XwbMbafn6JCW8R
	zqMU/1ty/EKYKW6Ty+Zb8Z3Aek8CtesQrYmFXW
X-Gm-Gg: AYBFou22vx+VvPzAcIQ+P8OkkPwNKf7NkdA2m8D43zH1GLVanEfRIlCvRDP4bzXgDzS
	ZXzirvjD15/ipAULHVL5S/SZIMbz+3Tk4BudOaWUR9rgPEu/Edc8YAF4xA27LQGxr6iZD6vUHZl
	NQPhmDI6iDORCD4TdchGz0NaDIgVmWtrCysg8NAGzR5/pGIwT3ivZ9o/Vvsw==
X-Received: by 2002:a17:90b:5910:b0:3ae:3b3d:c617 with SMTP id 98e67ed59e1d1-3b1b0cc8f69mr3190571a91.29.1794657018096;
        Sat, 14 Nov 2026 03:50:18 -0800 (PST)
X-Received: by 2002:a17:90b:5910:b0:3ae:3b3d:c617 with SMTP id
 98e67ed59e1d1-3b1b0cc8f69mr3190554a91.29.1794657017610; Sat, 14 Nov 2026
 03:50:17 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112172241.1.Ibe6dddf06a4b7e5b24af24dc85d053e36f940549@changeid>
In-Reply-To: <20261112172241.1.Ibe6dddf06a4b7e5b24af24dc85d053e36f940549@changeid>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 12:50:06 +0100
X-Gm-Features: AclHuK8CFmz3CQfa1T8ayq82nkVg2Q-hgsilrxt1aKjTCJE48ykohO33UTlirlo
Message-ID: <CAPx+jO-FRXoNjiCRuvfR+eG2fK3mxSb2RVwAsqAaWFoWH6+Mkg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Skip SET_SUSPEND_MODE when OSI is unsupported
To: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        dario.binacchi@amarulasolutions.com,
        Linux STM32 <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NiBTYWx0ZWRfX3O6O84ozoRIz
 ex0sLR+ECMWxLrKfhOh0BwPvlLt5lBpZg8G/hImobPiBPKGWmG7vYhYevY8USUZKBwxVrinZZzU
 Q4eS5yWOzQFNwd0njOFBuMej46FYGDe7ZbCgDXtGEG9f+7VJ/4PVtTRvFDvEtz5/z7Gpk88pqPO
 l6aYuKMP6kPogdnBttTnJpxyQ0YB/fCAelKcpVBtmJqF1ZguP3cCHRTu6LNnEGSTn2nPNH16l+9
 AmeM0eAML8N5RMK5UwfuXG5duwVtp1Ttz4F5vU2Y9RpWFEgPelH3AKXmtLV4v91pRY0jrx6ibl0
 7N/Oo7SxBisV2xpQkGynvkbDcuxAVp6W4xmsTNo2nKAn4G45xfPhnSZf/Dr5sYUeZ9JkgaInsYj
 /jzMQ0r1ayvOKDcycwgIpX/tVvHEOJ/ZbTmo3XSzHlxT3TXSjGTai4ZSqSYUktU8rxXeefxnTxW
 TAdlPl+CPjzX/se/avw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NiBTYWx0ZWRfX782fAsOBzm6S
 kLSXemECjQKaApNQGvVBlHq4B0QMfNimMKmpQHt7Fcwt2AwF7CjkDjR2sv8+oVu8gVWQOmbg7Kf
 ek1I7OcaRl0q/pZIMCyQ2E/4vxMBBVQ=
X-Proofpoint-ORIG-GUID: bBp-CXfYnquW3-9_pwZOl5jyoujjUQQN
X-Proofpoint-GUID: bBp-CXfYnquW3-9_pwZOl5jyoujjUQQN
X-Authority-Analysis: v=2.4 cv=Jr5kP84C c=1 sm=1 tr=0 ts=6af84afb cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8
 a=rMreS1aEiTCX3J7MmsgA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140046

On Thu, Nov 12, 2026 at 5:23=E2=80=AFPM Patrick Delaunay
<patrick.delaunay@foss.st.com> wrote:
>
> The PSCI cpuidle domain probe calls psci_set_osi_mode(use_osi) after
> creating the power domains. When OSI is unsupported, this still calls
> SET_SUSPEND_MODE to select platform-coordinated mode. Firmware that
> does not implement this optional function may return NOT_SUPPORTED,
> causing the probe to fail with -EOPNOTSUPP.
>
> When OSI is unsupported, the PSCI specification allows the OS to assume
> platform-coordinated mode. Skip the call in that case, and request OSI
> mode only when psci_has_osi_support() is true.
>
> Fixes: 12acb348fa45 ("cpuidle: psci: Move enabling OSI mode after power d=
omains creation")
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Hi,
>
> This patch replaces the previous patch [1] in SCMI lib
>
> The PSCI specification v1.3 describes the PSCI_SET_SUSPEND_MODE with:
>
> "
> 5.21 PSCI_SET_SUSPEND_MODE
> 5.21.3 Caller responsibilities
> The caller must be able to cope with the following error return codes:
> * NOT_SUPPORTED, in which case the calling OS can assume the platform
> will work in platform-coordinated mode. In this case,
> the PSCI_FEATURES feature flag 0 for CPU_SUSPEND is also 0.
> "
>
> This patch implements the expected behavior:
>
> PC mode by default when OSI is not supported, i.e. CPU_SUSPEND
> (optional) are not supported; PSCI_FEATURES(CPU_SUSPEND) return
> NOT_SUPPORTED or return psci_func_id Bit[0]=3D0 for OS-initiated mode
> not supported.
>
> When OSI is not supported PSCI_SET_SUSPEND_MODE (optional) can report
> NOT_SUPPORTED and by default the platform will boot in
> platform-coordinated mode.
>
> [1] "firmware: psci: handle unsupported SET_SUSPEND_MODE in PC mode"
>     https://patchwork.kernel.org/project/linux-arm-kernel/patch/202610291=
91624.1.I5f8f3d75a566b72250d629ac6f43cf0d387c0218@changeid/
>     https://lore.kernel.org/all/20261029191624.1.I5f8f3d75a566b72250d629a=
c6f43cf0d387c0218@changeid/
>
> Regards,
>
> Patrick
>
>  drivers/cpuidle/cpuidle-psci-domain.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpui=
dle-psci-domain.c
> index 5722365b943e..eed9ad94659a 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -159,10 +159,12 @@ static int psci_cpuidle_domain_probe(struct platfor=
m_device *pdev)
>         if (ret)
>                 goto remove_pd;
>
> -       /* let's try to enable OSI. */
> -       ret =3D psci_set_osi_mode(use_osi);
> -       if (ret)
> -               goto remove_pd;
> +       if (use_osi) {
> +               /* let's try to enable OSI. */
> +               ret =3D psci_set_osi_mode(true);
> +               if (ret)
> +                       goto remove_pd;
> +       }
>
>         pr_info("Initialized CPU PM domain topology using %s mode\n",
>                 use_osi ? "OSI" : "PC");
> ---
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> branch: master
>
> --
> 2.43.0
>
