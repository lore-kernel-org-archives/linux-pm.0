Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A83B1022
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525997; cv=pass; b=aNsryZWuWsojfNlYXUW/bEGcSZsCi+vOcVcH5brsQNohBxwfT5kVVcPXu7brRrZr446oYqjlOW3rNM4p8zJJMSYUE+Ewfqod3mRaoDwqPym/AguYllhSELZJZvfH5dYx5G90UBnei1N+5b9uEyHQQLXVLsygLz9yV7DgJBiFuF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525997; c=relaxed/simple;
	bh=4fZLufBRbYv0ZeoDpC9ZF+sMAM/7XhJjxJD/9UyzC3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1jtk9RunyIvM1RT/W3SrkLOvn86QC/qbMl3bqbfB1l+WxPFHGMueFHYykpCQkYOWjJvBUEclBbs77lHF4dIe70qViNAQy2Bl2zmKLeyPIBTNY9mK9fik2ajL7un22+K3rcLE6xIZcp4kbxwZcJ4qtQ3wcOFgPeKbnKqdv9KYUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=povksdEE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NDt9Givq; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="povksdEE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NDt9Givq"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3Wvu2753651
	for <linux-pm@vger.kernel.org>; Wed, 8 Jul 2026 15:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	euqtbZ8JKHVRTKJRjjj0PorQ8eQxhdkHP+XNgxpwhdw=; b=povksdEEU32r3U2F
	208oi4s1n1bP0yeqPcIppmU/CFq/z0p08+vUOGb1+bJfQopePrfbWPCi5pKmapfu
	xY5ZMZL+fhM+mHK636+iv6T2bySKiKVPwxvAafADP1rm0E9YF71ZlCObddX9+b7h
	eJ2ZLa89O4/eY1XXhqiLtPo3zpQQUrhecZ1u9YWOyFZncUKFGmH4wNDPyVYOcFWx
	C4TRD1jkgEth0B8iasVRKmeX2uUWUJw3TedN9oHHXd/jfF9gRTq6QBCYw9Rvfbya
	yN2GRoHefAatw7UHrkAFHJQ5+aqvsBJYfxPgWtc66NTUjrf/uYyO0qdv7XZbyuUl
	8jB6Eg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9g7hjjy5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 15:53:15 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f18c4d1f82so21438016d6.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 08:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783525995; cv=none;
        d=google.com; s=arc-20260327;
        b=TpamGIhxFofVSlL89GxlpFT/6iZ3DjgG64988qDMi2XwMUz+3Slix9bFe5o/Bl//SL
         2GHZLd4EwjHyBZxNBKJwg1k8M34Goye2dp7etd2BLAkO5uVViyrikwgSAKkvXLhb0+U0
         p/YuPPHugq1fs3UdvlWvAJoNHc8KR08y5Uffu3rWU2jKHn5sk76TRuKmcwG7zkf9+kot
         G5MR7CaZJ4if4fY0QJ7ATLZl8lJD8/aWHYMJyqWjIMPPB6J32q4u17zWgmhQUzGfO2Rj
         hOAKvA3g9rq9gSmTZAPJCqkZwEP0Zt4LwSq1sxLS/4r9inf5THkTcK0INWiddj9VDafI
         II2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=euqtbZ8JKHVRTKJRjjj0PorQ8eQxhdkHP+XNgxpwhdw=;
        fh=n1GpTMpPDwJ6jm11f3vCnHr0AtB/VwGsCRdDkW2nD3c=;
        b=XwQnQ4RYRkfHEoTlIujCkV/pUxovHXc8umBKHg05fDS8rIcnMIgq3G75G92hSI6Aiw
         x7Aa0O3bMjD/fmXCTEimX8VgEBIn0ol3Sj0ayBDCT3JeK8u/h3d4Zt8GuRd4PY2m4W6f
         JYJFiuWEMlskAocpJa+6Fl9X3NZBXxj+YzGubwWSf2mZGPMulJ2T6HSty8lOdScjMPvB
         8HcDs9RkX1tA7bEHCLR0mcAmNtoEObEMgDl9ZJRkZRx5T6FtKy+9qw8+zrkFKyKfKYJ6
         Q7qjQ4owRVz/h1R3Rlxb3XQ+dvGf56r44Gua1kJR9kB7QYIkBIiCYrLai8Owo7IX1nSC
         Tz8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783525995; x=1784130795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=euqtbZ8JKHVRTKJRjjj0PorQ8eQxhdkHP+XNgxpwhdw=;
        b=NDt9Givqru9KH49LUNTBx7QzaIDYfb3qEeX9kaDF10u9+HJpj62ndtvjczDL0P8gL4
         A+PGxJOgZkhyA5ISv8eurCsOgHbhHn6NG9DPrkUkSe8UKwDrL76WFSQCVyd/3A7Ds3Ht
         En0LC6IMiA/qm1dmNYkiqVUU/yqSuuU1XC006tOOnwukzx+pKGTk5LRH8w4H1NNdwNHq
         SR6nA8ql38aQx8HvFmNt7X+4MMuzDIOscnr8YHmjzImCTdJNc7hWSSHIYpxI0W7Faco6
         /F5dtU8EPbnNQeqotNXhUONIIIkkucpb53jS9xSSd9ozETg36QBS4EBHZNGaKVEQsfFP
         IDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525995; x=1784130795;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=euqtbZ8JKHVRTKJRjjj0PorQ8eQxhdkHP+XNgxpwhdw=;
        b=W9DVz6SsZ15GmPjXTBUnQbWsNyOiudrRQzIoMDlUsEw+d9bBXFmX3+HaBaIPdk5wr8
         jN2/PgcEPLyEG9+hP5GuXArCMT2mJpYS+lYnqSzQx1cHVV/0HgWchiQDPDd3jPPPmSB7
         HZasNyc3kXgBY22APlZwsa7WvpCUw64MdcOZWnoFpmIq5xESn7JNeL4Cj3hr2lw3mDF3
         58ZPRxkm82t3OCXtDFlv5EKTLYmWgShTsNOKKzjBUV2MX4hQLSi+i4cCWMq0TEz32odV
         5IOpuzcq09AjlxLz7OoMct/Ma1EO4k45wCUIxAlJGJCSKrF49QMtEKWCTKAlFXZXvyM3
         pQKg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2UaB6Svl4BnrJREJICPWnKZCFXAX2YudU09FpP6l3GKtf34tsxHCcOgW1Km2jbyQtANsLwFAQRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAV4SaVGdnEJ3hFtpvWg6jlZcc1YIruSRv4MmQoqf+59w6y8Xx
	9TJmm+VLB/wvnz9zOg4HsR25jdGerqp+TBR/cVJrDYKCGJ5r8Tj5bJzY0y4e5hiE6FzITOnXx3v
	eIqI97HDIpm0c0iN+5f5XdGzwP0Exp1UnNoDS768E/ZZGy6/vQgCkAVoJIJMid9/hX0Jq+yII8l
	CWXDCgOcfKtvcybfnMSa6DZPuO8XGaX4/0V4KM
X-Gm-Gg: AfdE7cngsGapbiq2PPGWsFL/dUZm40PZUlSV4ZqSNWGPS1Kwm2sNpqEoZiXrul9FfEY
	WXO2hK2FdKVo1MZLm1GKGENGidpB3b8RDnTQf7QhrSVk7SmHXFLc0WCLIw7lYk4nq6+wMDKh9d9
	5X1FTXR8McvNTKG7cWY/uxFtlr+3JCwQL1hUSlkDTymUZBzWz1IYwXehRnehOnYYxd62Bg
X-Received: by 2002:a05:6214:5508:b0:8f1:323a:fc54 with SMTP id 6a1803df08f44-8fec361ce5fmr26792726d6.42.1783525994684;
        Wed, 08 Jul 2026 08:53:14 -0700 (PDT)
X-Received: by 2002:a05:6214:5508:b0:8f1:323a:fc54 with SMTP id
 6a1803df08f44-8fec361ce5fmr26792106d6.42.1783525993919; Wed, 08 Jul 2026
 08:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org> <20260618-ux500-power-domains-v7-1-v1-10-eb5e50b1a588@kernel.org>
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-10-eb5e50b1a588@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 17:53:01 +0200
X-Gm-Features: AVVi8Cfl9mmuZ0-N0YzXyQTku0PxVhLh9qj1SZFF_tsUR-VGJVPz8z3CnsVKBnw
Message-ID: <CAPx+jO-ow2vo2wMxERLGse88wLoaR=HLdOWk6Qwv97ZdbE4R5Q@mail.gmail.com>
Subject: Re: [PATCH 10/11] regulator: db8500: Add power domain regulators
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1NiBTYWx0ZWRfXxHgSjRawdzCW
 ejdsDH0HrcIjIeZQEptX4yKaoPJCIhp2mLFw6pMoQbgG4BzuliIck8KbIkKQHnat13tMVLa7PaQ
 jgYzRhymc62v2KSU7dQ6A1oswv9FiouHNEdOC/QSnvvy6oHzqI5WVTecMAIrMgMVbv2yL/X5+9X
 8eLGvEVfMuzRIzsA9YYNa0WK51Epu3OjOqI2ZrjpHLh29BY+bi5q4D3J+Xp2O+//rNRk8Iy3VBB
 1wdc605eJtoTBnaOFhZ16bSgzPwfoq6umpW7EKOWgfWtx/qaattmux2g3dEo7akr1gRMN3jPgV9
 D0lgVsuBbJV58aGsKmL4vxGh5M6WX0ga4z0GlQPFRWRGHmvEyQmG9Nkg2QU3JDyTVHaLrpemm68
 2TvkiLSrbgktPkZWI63V6fZwMqCdezDo5T8Hizocf6I4pD1LWq8FL6mKLhvQKo2nAGOl2I9jE7b
 EyiqcwBXV8y9HYmYQ8g==
X-Proofpoint-GUID: AAhjnEL2HQU-Cdjq8NTP9NrytFe-sydq
X-Authority-Analysis: v=2.4 cv=TMp1jVla c=1 sm=1 tr=0 ts=6a4e726b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=l53Gh-upYCO10StVhpkA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1NiBTYWx0ZWRfXyuneuHMFId6h
 xKD/OPYNXoAMhtnesBKPZB+mj2ctfMGOKnLxtiQYONutMEBmD05qKrrpvvi7JujN31jvTqxCwk3
 ZNHDR2HQk4GgcNXr7miUFZSzviCwwjE=
X-Proofpoint-ORIG-GUID: AAhjnEL2HQU-Cdjq8NTP9NrytFe-sydq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080156

On Thu, Jun 18, 2026 at 7:01=E2=80=AFAM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Add a DB8500 regulator driver for the VAPE and VSMPS2 compatibility nodes=
.
>
> Back the regulator enable state with the corresponding power domains.
>
> This is done for off-chip consumers: the corresponding voltage rails are
> routed out so they are used for powering different peripherals using
> these voltages as supplies.
>
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  arch/arm/boot/dts/st/ste-dbx5x0.dtsi |   2 +
>  drivers/regulator/Kconfig            |  11 ++
>  drivers/regulator/Makefile           |   1 +
>  drivers/regulator/db8500-regulator.c | 221 +++++++++++++++++++++++++++++=
++++++
>  4 files changed, 235 insertions(+)
>
> diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/=
ste-dbx5x0.dtsi
> index a6fef302c994..fd6a075e4c93 100644
> --- a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
> +++ b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
> @@ -673,6 +673,7 @@ db8500-prcmu-regulators {
>                                 // DB8500_REGULATOR_VAPE
>                                 db8500_vape_reg: db8500_vape {
>                                         regulator-always-on;
> +                                       power-domains =3D <&pm_domains DO=
MAIN_VAPE>;

Hmm, isn't this the other way around? The power-domains node should
have a regulator supply?

We may even consider to skip to model the regulator altogether and
make the power domain operate directly on the prcmu instead.

>                                 };
>
>                                 // DB8500_REGULATOR_VARM
> @@ -693,6 +694,7 @@ db8500_vsmps1_reg: db8500_vsmps1 {
>
>                                 // DB8500_REGULATOR_VSMPS2
>                                 db8500_vsmps2_reg: db8500_vsmps2 {
> +                                       power-domains =3D <&pm_domains DO=
MAIN_VSMPS2>;

Ditto.

>                                 };
>
>                                 // DB8500_REGULATOR_VSMPS3
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index acc698c17bd2..8db63d8d3fa4 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -397,6 +397,17 @@ config REGULATOR_DA9210
>           converter 12A DC-DC Buck controlled through an I2C
>           interface.
>

[...]

Kind regards
Uffe
