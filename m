Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627EE2F4A0C
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775461007; cv=none; b=HnOIMAHk7WoDdRwyLGEI9FvrM8IE+qrxT1Z5JgbTlIP7xZyoaULTWbc6pfG0eWTvQ27jzO06NJ/SgkpyePdEEFxGi7QbEAtU1MBpguIDWpG2bm6uuJlQkj5w6Bsf4E1xi6YDyFKBgv8PDX7bRmkPVHOUzSq5iupaZy7IwbHEllk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775461007; c=relaxed/simple;
	bh=A5j6e3cqOg7yNX4hMaA5bMWHJ0RiNTfPfPFuKO7Imko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALEz6nlmxyNvHSMChIRpd1U+HaQ4RCm9St226oXuchCbgkADZaCfFCmycs06TJ8yczqBqho5+XRsHZJorPGO7cWdhlUYoKf/9KwiTzUpHFuyrN6iEwyEc6b4FZmAIZdblLRn4YB1JqzNuEwZByKBFnBPG9/R7cvKSvqtu5Gx7Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bCy6Qgz1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F+KhFt3N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bCy6Qgz1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F+KhFt3N"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6364K4pE2617803
	for <linux-pm@vger.kernel.org>; Mon, 6 Apr 2026 07:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Og+gS/7LhEE28OGj4l+LQ9SM0DiaD4s8OHH46+FD40k=; b=bCy6Qgz1f4bT6KeV
	/3e+cNg3Ex/VZzvTHkZwmtrwr86SCLI70JbNkIkLzNQK3eAhBeBGvILLaNFblJu3
	IO9df7W8NiplnRi8JajqTEMjaTXsPXUPIPALPHw87stS3FPn1R75hK7snY/EJFk5
	n69r1nBKpAEwO8/WJ8fx5znQE1d71TmAzSIYmd/IO+Jkrvuu1zZu/n+6FBjLZIu7
	vO+ikPgKkONqVfdCABY6fFJ8Zsjbs+in3trmOl3fnsXuU+OMrrAYRE533Tg4MVjP
	O/qZ1bN0nOVT+b1w1jDdzcuLIeO2BP1xtbjcBUAWPbvUNa4lZWM0E0Hq8MfrtVZa
	BaShMw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4daudd49u9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 07:36:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35d9e67f6dcso8438636a91.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 00:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775461005; x=1776065805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Og+gS/7LhEE28OGj4l+LQ9SM0DiaD4s8OHH46+FD40k=;
        b=F+KhFt3N6lKrB2Thmu2zID+PfnNjryK/BB1WNBFfJxoK85U79NZo71ZD/4ZS6+Ib2q
         G9uT5pyX38rTkevpSnycQYFATbGtzRCM6xgtyAs4ogzztHrU0e9BApzegH2FafKh7RJB
         lVPmmI+lSvZHrQ0l+YBhDo9qoyS3yq3QxpmrUCJJBX6m3mtKZshKRLzGF089hdnWiWg+
         sW54A0uBClFyfA19GSZxYzfebxlcgAFamduuRh45SlkpJriWVZHcB7rg6etxNuZ5O0J2
         wSf/kiFzzB/NdhP2ppRAFDxktS9f0K8bIwUCI86Ig2DLfFBnbad/EhVXb2lJtHpnWgSg
         jDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775461005; x=1776065805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Og+gS/7LhEE28OGj4l+LQ9SM0DiaD4s8OHH46+FD40k=;
        b=p+krEffS5pJwar3rZqQwQ5L04PewxVKAxYCqtM7M3GOsrXcvDFU/44NNVLI7UOdFFf
         NNhC2YxqRHrX+eXupQltcu6ggNw1aTm/K/HmmMIgCdnY9cH5FmSweJLePVgpni0nfYfB
         GlU1197VnNUPDlZnUyrMinxwdb/0WGCw6JzHWA1D9b4lRLtx3/EfErOEYS016pM26JmL
         S6uRfHoM3e86L2n1+nK5LGA+5W9ZzUDZVE/Tdmmj3UJgWI/0Gx8uo3ACz+YvRE6jcccT
         cqxPZNLSEdFZbJKGCnW9Uo8mkKKqIdxFUS+NfaS25W8rPHUCzPXUMK4iVmrLChGHqi7d
         dlgg==
X-Forwarded-Encrypted: i=1; AJvYcCV61/ZZ79yqWqyONzmAloVgWnfKGyzGscjP5q3UvrNxaki3UWZW/2XWUeSApO63wCoayuZEwNUWYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLDY7ddfAPwXIsV9CUCheFmMC/AWyVZ08GBvnMcFCl7sDJkdHY
	4EnVgTIwslF8ecqHTXPlTGqShiAR7gqhbE6cYlKxFHHk3VU4/go10X8veDDok42qChW0yFGf6+u
	NwTeh2g240Qe48InXQax0c1Bh/xzz9TIFuzWFH+7y2NZEsT043TnnoVipj0Nc/Q==
X-Gm-Gg: AeBDietj2XVPrwp6saCKRYLi1YbUiZw6zAEuVmP9AFXeglcWSQK9A1fpnW3nMpK2DSm
	jk8EI+0MdO5EYi0iA7xlaAqIMBUG4t/xb4nR+fFVC3NC3XEJvfn2DRRbcu2UuO7uXnJCmqKVL0Z
	jD2SDo2wBK93A9t0qZw9M32cWT4qhTUj8Otm2t4d696LSmXbDz4mlZ8xLpvQ+22JkAikh86nY3B
	1WautT7AlbAGnA6BVhobB4yfvB0sC8ocfCo5MF/5IDONovanwZGcSD4dG2HxCf6akgvrfRYERRn
	oP4WH6olUCyiUlMKshdL8TwITWEqPWWF+FDKS6U/+LJVn1UYNuBQGBVZ3czE2mI8rY4xthrY29I
	ZTm3pXTnsslQGcRFjDqgSB36sPpZU0PmBOiSu2RXFjmw8MKGMHJTOfvwbESEnD12z+megVG/k3v
	xKfFBq0eAoJGRBzC2vmGeA7lXP+g==
X-Received: by 2002:a17:90a:d005:b0:35d:9d28:e897 with SMTP id 98e67ed59e1d1-35de699f483mr10698422a91.28.1775461004605;
        Mon, 06 Apr 2026 00:36:44 -0700 (PDT)
X-Received: by 2002:a17:90a:d005:b0:35d:9d28:e897 with SMTP id 98e67ed59e1d1-35de699f483mr10698388a91.28.1775461004071;
        Mon, 06 Apr 2026 00:36:44 -0700 (PDT)
Received: from [10.50.10.255] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35ddb973ffasm11678053a91.2.2026.04.06.00.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 00:36:43 -0700 (PDT)
Message-ID: <c8fbb242-c1df-4db5-8fda-705e9df4a894@oss.qualcomm.com>
Date: Mon, 6 Apr 2026 13:06:34 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 00/10] Implement PSCI reboot mode driver for PSCI
 resets
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan
 <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz
 <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>,
        Song Xue <quic_songxue@quicinc.com>
References: <20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4zPHfkezmiuHm3iA0-bkWnLEQXgcyCHf
X-Authority-Analysis: v=2.4 cv=JZ2xbEKV c=1 sm=1 tr=0 ts=69d3628d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=RXLY-4Gv9SH2gAdi2bgA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA3MiBTYWx0ZWRfXzKqE9eTc83C1
 Ndi/DjhZb39yIxzVJeLCvbQEKoWqrNHCtWAnn4ielJxY5x7iwv/SjQT+aAaI1AcEOdD5V0hYILx
 XM1fEbqxzt/EXBNmNj1JnbxsxR49NYvqoqmbsQVEAoaLbWN1F4O9/wpuMOI4sorCe0T10y5Cjmm
 99+D38LWDC5BTynQBsPGKnszPQFL204xD2jazqc+J3/sNxWHCOs6g+49XyaPWGfBPZKCQU5FMXM
 JGdiDVWNGFp+t1gLY/R0wQFdm5siEPUIc3b6IXtIRWeJVF4mWqI83cGsC1EjUNcv7ER/3WagG9C
 SjMIm6jXVvaHe1Io4pcbZWrgTpTy9MJf/TbsSxMPTeTI7SWl0wAtyhR/+yZapVxZx1IjZn1SQJi
 Qts8/dO0cMu66XE5mUNTdnj2RfkSSKJwws/Nmpsaq7PQbxTVpyaJ2fyhkAt0TSarPfGbaCTvkWx
 /8G1K90fXCUsPkK5K0w==
X-Proofpoint-GUID: 4zPHfkezmiuHm3iA0-bkWnLEQXgcyCHf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060072

On 3/4/2026 11:33 PM, Shivendra Pratap wrote:
> Userspace should be able to initiate device reboots using the various
> PSCI SYSTEM_RESET and SYSTEM_RESET2 types defined by PSCI spec. This
> patch series introduces psci-reboot-mode driver that registers with
> reboot-mode framework to provide this functionality.
> 
> The PSCI system reset calls takes two arguments: reset_type and cookie.
> It defines predefined reset types, such as warm and cold reset, and
> vendor-specific reset types which are SoC vendor specific. To support
> these requirements, the reboot-mode framework is enhanced in two key
> ways:
> 1. 64-bit magic support: Extend reboot-mode to handle two 32-bit
> arguments (reset_type and cookie) by encoding them into a single 64-bit
> magic value.
> 2. Predefined modes: Add support for predefined reboot modes in the
> framework.
> 
> With these enhancements, the patch series enables:
>  - Warm reset and cold reset as predefined reboot modes.
>  - Vendor-specific resets exposed as tunables, configurable via the
>    SoC-specific device tree.
> 
> Together, these changes allow userspace to trigger all above PSCI resets
> from userspace.
> 
> Currently three drivers register with reboot-mode framework -
> syscon-reboot-mode, nvmem-reboot-mode and qcom-pon. Consolidated
> list of commands currently added across various vendor DTs:
>  mode-loader
>  mode-normal
>  mode-bootloader
>  mode-charge
>  mode-fastboot
>  mode-reboot-ab-update
>  mode-recovery
>  mode-rescue
>  mode-shutdown-thermal
>  mode-shutdown-thermal-battery
> 
> On gs101 we also pass kernel-generated modes from kernel_restart()
> or panic(), specifically DM verity's 'dm-verity device corrupted':
> 	mode-dm-verity-device-corrupted = <0x50>;
> 
> - thanks Andre' for providing this.
> 
> Detailed list of commands being used by syscon-reboot-mode:
>     arm64/boot/dts/exynos/exynosautov9.dtsi:
> 	mode-bootloader = <EXYNOSAUTOV9_BOOT_BOOTLOADER>;
> 	mode-fastboot = <EXYNOSAUTOV9_BOOT_FASTBOOT>;
> 	mode-recovery = <EXYNOSAUTOV9_BOOT_RECOVERY>;
> 
>     arm64/boot/dts/exynos/google/gs101.dtsi:
>     	mode-bootloader = <0xfc>;
>     	mode-charge = <0x0a>;
>     	mode-fastboot = <0xfa>;
>     	mode-reboot-ab-update = <0x52>;
>     	mode-recovery = <0xff>;
>     	mode-rescue = <0xf9>;
>     	mode-shutdown-thermal = <0x51>;
>     	mode-shutdown-thermal-battery = <0x51>;
> 
>     arm64/boot/dts/hisilicon/hi3660-hikey960.dts:
>     	mode-normal = <0x77665501>;
>     	mode-bootloader = <0x77665500>;
>     	mode-recovery = <0x77665502>;
> 
>     arm64/boot/dts/hisilicon/hi6220-hikey.dts:
>     	mode-normal = <0x77665501>;
>     	mode-bootloader = <0x77665500>;
>     	mode-recovery = <0x77665502>;
> 
>     arm64/boot/dts/rockchip/px30.dtsi:
>     	mode-bootloader = <BOOT_BL_DOWNLOAD>;
>     	mode-fastboot = <BOOT_FASTBOOT>;
>     	mode-loader = <BOOT_BL_DOWNLOAD>;
>     	mode-normal = <BOOT_NORMAL>;
>     	mode-recovery = <BOOT_RECOVERY>;
> 
>     arm64/boot/dts/rockchip/rk3308.dtsi:
>     	mode-bootloader = <BOOT_BL_DOWNLOAD>;
>     	mode-loader = <BOOT_BL_DOWNLOAD>;
>     	mode-normal = <BOOT_NORMAL>;
>     	mode-recovery = <BOOT_RECOVERY>;
>     	mode-fastboot = <BOOT_FASTBOOT>;
> 
>     arm64/boot/dts/rockchip/rk3566-lckfb-tspi.dts:
>     	mode-normal = <BOOT_NORMAL>;
>     	mode-loader = <BOOT_BL_DOWNLOAD>;
> 			mode-recovery = <BOOT_RECOVERY>;
> 			mode-bootloader = <BOOT_FASTBOOT>;
> 
> Detailed list of commands being used by nvmem-reboot-mode:
>     arm64/boot/dts/qcom/pmXXXX.dtsi:(multiple qcom DTs)
> 			mode-recovery = <0x01>;
> 			mode-bootloader = <0x02>;
> 
> The patch is tested on rb3Gen2, lemans-ride, lemans-evk, monaco-ride,
> qcs615-ride.
> 
> @Florian/@Kathiravan, Please note that reset_type in DT needs to be
> full in itself with 31st bit set. (eg: 0x80000000).
> 
> PS: As advised from Lorenzo, "PSCI maintainers should be added as
> maintainers for psci-reboot-mode".
> 
> Previous discussions around SYSTEM_RESET2:
> - https://lore.kernel.org/lkml/20230724223057.1208122-2-quic_eberman@quicinc.com/T/
> - https://lore.kernel.org/all/4a679542-b48d-7e11-f33a-63535a5c68cb@quicinc.com/
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> 

Tested-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>

