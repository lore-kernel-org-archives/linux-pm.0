Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE5526E706
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416104; cv=none; b=DjiVufLcfbj+8xwqX2uo1dNdifLedioUy0kw6ihtnC2FN1aZWgsppB11lp6pATa0GdQB7kOTCUeEPYmiIMO697ecyHCtIXn2a7/3RGlSFEejwcgjbPTqT1J1yDJqVhkvg30XYPAslg/bzWhW0T+IgeHMDrghu30ciSz7qseracU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416104; c=relaxed/simple;
	bh=U8u87X4cEVl7xeiYNxJ9zFvPFZ++Mg3bP33Z2AuGVtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U26HQd1HTpPohpiU6L9XGpZJP5nac9Ibo/DPCz/zEgNFUnD0S8Dx6AkvHpxiLtrIKJe7MxeB/boLhByg7JIH/JATGi7ADdDD0BHeXQ+rINlE17OYIsxWTAihQfmWGNi9rxs8327ank1HKkfZrA5+aO1Aovni/kI0YZ12erkcZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ecnlHgn9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f0G/Hnhu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ecnlHgn9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f0G/Hnhu"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652DBLp62885132
	for <linux-pm@vger.kernel.org>; Tue, 2 Jun 2026 16:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9cHo+HdLfWszrxz8FIlQUKjxLUJPM3VQU+KKIaZgzs8=; b=ecnlHgn9Mot6/zjN
	P/Lx9gAlO0F9M5Kvyys6oergtAHmwf0hlMC/HPcSzcdCKheQFuMK71KnDqiEfI6d
	5DuV7b0zGAXkDtD0/6wRkIGlOG8vdpY1uGDoEFEJvHDgGS+ngjGxhXHUgNGDWR6P
	Kf6+Dd9zji1rcznj+z9+EsUrpcQjEOQCG6S1KCXE4dAVYno1cVJaVyS50SCiAfsZ
	N+MnBRBijUy66CdEy25rXcteN97sWzBHdf4Vfy0sJM8USRWa87SQh8KkM1oUao5f
	N20FQe41eDuQq2kAxYpSFuIFIdeycxrJsFbAwIysRq/6PKFwZRZrLr5Q/BKl/f69
	oKE2Hw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsu12b4w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 16:01:42 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6cfb918a9d7so3674259137.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 09:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780416102; x=1781020902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9cHo+HdLfWszrxz8FIlQUKjxLUJPM3VQU+KKIaZgzs8=;
        b=f0G/Hnhu5TetNIO11Mkkb58zCRB8VUsmztYr/Ns0ncdKWT5Tp4n1DZl40+zDyOAGRk
         N7+uGXnQrb9d+h4nCnFO6zRglTel7laoOOvb9Rnr7Xqu9nl8EEaHPt3X6y0iV2bTuHzT
         E8IPyyMZiepGkwogzcePiNIhsx1YQqumKC3vk9d/bklZAUgi+mjjCGjF0EcqfdXhw+Kh
         Lrn8Agw1WzGa8yJnzmWazxf08Fv2DaGhGyj7d6x1vIHwujJiYZ4ThmyKtN01Ok758bm0
         PmUJU+brVmv/MF0+YO6xtbcQxoBz72oC9BBYw92AoT8JBROifQSVv6xCcYkKxb7Ch+R7
         Y1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780416102; x=1781020902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cHo+HdLfWszrxz8FIlQUKjxLUJPM3VQU+KKIaZgzs8=;
        b=AJoPoUOAG9R6JGNSoaZcLBTUf+KIBOY/dqZ2tE+kU3uFSMIasOPIuwg/CUgcdlMFlq
         7EPdxAChk1fx7LMaqYhm0cNiA9l6fjkf5Z6LgfBajBLuHrpNMW9AmPXEojbdxPvfLOVl
         PbOt13/iybuztr/2Y2Sm2mZtMI2ZlfU8qb7DjW3+KcpMtM2UDPSab7q0eNM8CXjnMxY9
         KSKZC4+xsU8YhM0j+isP9V+Ko0XYLQ0GqVAUOh71H4aniO78kmQn9g0UTwkKckOAlGOQ
         qsVhMzsx3/7p/PQA7e9Fqtvl4wha3b6VfTBKSD5cfayAMjIUBA44NvAokDk7zlKNoS0E
         stAw==
X-Forwarded-Encrypted: i=1; AFNElJ/MjC9HPveEjnNINILydBTEU2jErMyzefjS4oHiAzQZ48nWwLpsDw5b59Kvaz2NHD33hWomODzAeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZC1ANZn+v0e5/nIQefqqiwkj4pvPSLYRiOyZSerVnoQhQL1eO
	EpepbBHfV+p4/wimEJfxxVOE2/WHV3xEKM1HeTkAEvthBJf/fbaR4WZpZ9MHHMZTVZE8vkb/cPP
	oXUGWJ+MtKYnh/WJgGurpu8xcgWkYbZ0qs/BB54vs7jUxhqdeeZGCBnBmjWYyRw==
X-Gm-Gg: Acq92OEnbsEvLidw6Ddr7veprtgsQAMnz2Gr62emCnc2almW862EEKT8CYCf62Yu/SL
	jqgCKjHAsWHSb5DiZAScJqGZd2GEjGVV303ozIYR1rbD+vj3YIzU1e+XA1Yb/74DrZF28S3UF37
	HYZ71cMWqGQ7snzEdpW7VeDlpmRrRz3h5vnWugewQF2z72LRm9WHvTJ57jhq+g5rra8UVUnfHV9
	mdhIPP/QG7HBfIWjJ6vOKqnZir57Q6CRt8tRaxZyweAYQZ4o7L79+veqe41hbkDcgXyg0b6tXGV
	ET3FOSDSuIxVIrYV7cGeVtt5pXMoL+f3XKLutzKXRCNS5w+3vhSbfMGn2mzT87OA6Y74RV3WfU7
	mWq3CWxnpo2B17hxprLC/K+hHBBU6LKMYjKFrOrAv0XA7sKyH1O1kknVj6Dy0yrfM6NpE/cWVn3
	Yz
X-Received: by 2002:a05:6102:a49:b0:639:4bb7:c916 with SMTP id ada2fe7eead31-6ea1cc674f6mr506753137.3.1780416088533;
        Tue, 02 Jun 2026 09:01:28 -0700 (PDT)
X-Received: by 2002:a05:6102:a49:b0:639:4bb7:c916 with SMTP id ada2fe7eead31-6ea1cc674f6mr505747137.3.1780416079609;
        Tue, 02 Jun 2026 09:01:19 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d40sm199325f8f.26.2026.06.02.09.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 09:01:18 -0700 (PDT)
Message-ID: <9adbe3cb-d42e-4b89-b6d7-62dd58b98e15@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 18:01:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] thermal: amlogic: add missing dependency on MESON_SM
To: linux-kernel-dev@aliel.fr, Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20260602-fix-missing-meson_sm-symbol-v3-1-6f7f69cd7d6c@aliel.fr>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260602-fix-missing-meson_sm-symbol-v3-1-6f7f69cd7d6c@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Oe5OW972sTVIbLPVWGBwLDSL09kOF7eY
X-Proofpoint-GUID: Oe5OW972sTVIbLPVWGBwLDSL09kOF7eY
X-Authority-Analysis: v=2.4 cv=MKFQXsZl c=1 sm=1 tr=0 ts=6a1efe66 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=tv4TSO8pNUtKKAd5OgUA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE1NSBTYWx0ZWRfXxlewkZ15285r
 F3kAH0lLELxhWqSUfs1BDxWmwivnV4TtKTJd8FPXAaailSGTQ/8ln/CaPgZsp3av8hnZSVKKlPi
 w3pVaAZ3PndQnfG+gx38B4n3swBRSqHUQv+iupCGWaaueIGuvaj1hhYXj7+SW1xQsxwGJQHa3ZQ
 W9/g5g472+Zcjs1hAeUi4PuGKjC5KDS6uZglRUugNSKt5skINbLY6LuAldRC2iWNj/zetW6g4Vh
 2F4yLaAePqvFsCYg4d4q732QOJnIsS8p2bsUN+4SZ4z2SCCTkK4ol2cCJgf5Dcnuypcm+yDDWxU
 P6M9FdNRpkItRk0UE+EVvkXL7ZJJkWbv59Wb/18VAtmvqLnuuZS+ds5iE7fgBGgLuSUPbV7n1eC
 ZZSJwOYpyjqu+1q4KvbrOf5jDW5suiUqtrqbfHDms0uaZkC7OZeZL0/ssUyn4r30NO8JBnYALUb
 iKzP6iEyjZAQi55WFDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606020155

On 6/2/26 16:19, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> The amlogic thermal driver calls meson_sm_get() and
> meson_sm_get_thermal_calib() which are exported by the meson_sm
> driver. Without CONFIG_MESON_SM enabled, the build fails with
> undefined references to these symbols.
> 
> Add a proper Kconfig dependency on MESON_SM instead of relying on
> stub functions, which makes the dependency explicit and prevents
> invalid configurations.
> 
> Closes: https://lore.kernel.org/oe-kbuild-all/202605291530.en7aGn7w-lkp@intel.com/
> Reported-by: Mark Brown <broonie@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
> Changes in v3:
> - Add a dependency on MESON_SM instead of stub functions.
> - Link to v2: https://lore.kernel.org/r/20260531-fix-missing-meson_sm-symbol-v2-1-1def8c3c169f@aliel.fr
> 
> Changes in v2:
> - Replace #ifdef CONFIG_MESON_SM by #if IS_ENABLED(CONFIG_MESON_SM)
>    to cover builtin and module in config.
> - Add missing trailers for kernel test robot.
> - Link to v1: https://lore.kernel.org/r/20260530-fix-missing-meson_sm-symbol-v1-1-3fb672b989d4@aliel.fr
> ---
>   drivers/thermal/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 1c4a5cd5a23ee..810eeccedfbab 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -436,6 +436,7 @@ config AMLOGIC_THERMAL
>   	tristate "Amlogic Thermal Support"
>   	default ARCH_MESON
>   	depends on OF && ARCH_MESON
> +	depends on MESON_SM
>   	help
>   	  If you say yes here you get support for Amlogic Thermal
>   	  for G12 SoC Family.

Did you forget to remove the stubs ?
