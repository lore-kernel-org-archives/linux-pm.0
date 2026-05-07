Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CC63EE1DC
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157312; cv=none; b=SO4LCVOjWfeMjcr57eWC8toF5pPuIsNTsw3h03tvE7DOahQY4GR1YE1bzjjnuuJs/omcYvjggW+nzLTQWP1LRwMCX910fR7PQhcs6FKwDbuYpsl+V8s9xz66aJV57vr7c3K5BzE5WjvACWITTLobb9h2YFWj3YgBVKuqyHqvaWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157312; c=relaxed/simple;
	bh=ETuDtSwyaUddnAug53346DgVOI/9ZQNWbc7pgqdfZVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNJQXUM3DsNvMXIkIg2oBfLeDB5tqItyjKql/jHb9KkJA7OSlKLoB3Js54xDRaatcAdqFbrCSCFaW6QgH8IH6oiZXne6Mlfyj54QjUl4I0+EHNbMzOHthkHRaFoZlp5Z9fOpwiOcnmQxl3X89YzCM6nBkfQF+qFhATy3ZrJTD0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WnGe8msX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d0RhSNXX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WnGe8msX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d0RhSNXX"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647C5YUB1971735
	for <linux-pm@vger.kernel.org>; Thu, 7 May 2026 12:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cp/b8ILc3ZsSOIZ8f2jupbkg6WAQAkIuZCfNcQoaBiA=; b=WnGe8msXks6nrWfj
	Ak4QFi+SrRu0cVy07aMUhhpwq9+AmUiEinnXJfPHn60q3H+5rVzUFq3Ax2w+hrt7
	6GfF2h9SzvvZOC3UtZpx4tCdvkAfy+C/u/X8byYIw+xhH6rl27XYa20hTpqsHp8O
	D/QA1KjBmdg8wGAz1678SBYywj1cftJpOb00PoT1mP+7Swq4r2KZsIKogLNci3we
	TnbcT09T8E/GdYYpKYdEqRULm+deND2mlLX3CtdOghhEFOtY8xtfYebhjm7cIE5X
	zb7AGwm8KWGNpvbkNjCTIG7Ym3+8qK0Kkkn8rbb3z5GGyPSIgrRMYj6M4uqOlq3h
	n7Cvaw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tej836j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 12:35:08 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-837d0d71c61so470875b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 05:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778157308; x=1778762108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cp/b8ILc3ZsSOIZ8f2jupbkg6WAQAkIuZCfNcQoaBiA=;
        b=d0RhSNXXJAbC6hb9QzRqHcfiet23aHwwXCwOXjroM11c9OR+zGR6pS8FkvdIViaJKB
         /6m9WT3BkwQiTp9QSS+mWm+z9TJ5za+VocCMoQeXUkrfH6401f9LMMhJ4aY0AeLl/QhA
         hFR3xrfyDzB9LNBQHH+qSoJWS1KJz+zrhmZpHJhR9gXUIen6/CB/IQNFyiz7X0aVYy0/
         6mupywPjvLIrST73R6TOT1vr96CCwsiJJhdG3PNUTmlIlWcH7coLEoXkLIcYLCuKRMg9
         /1Z1U5RXkviZn0OV6vBtZiUZsYL6CUMZXfBr+VGHaDnDkniZqeUI7C5FapJf1hUqRgkM
         /v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778157308; x=1778762108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cp/b8ILc3ZsSOIZ8f2jupbkg6WAQAkIuZCfNcQoaBiA=;
        b=Lw1UhWAuKsyYskW2BqN6aq4xvkGPQR2qOu3dxCbFvQcp4I72LmQSloDu8qBdwNojbX
         rbdfeX9wCJ5tfdYFUEJzVwLtl4kijqjC8CffqF5eJN9ul+Yt+6u0x3sKnFaR2yRv7PN7
         u1yDg+7vNeA57/mzYYO+pNcmqxPlraHRZkVWXtQYdKAT0M8sTTfCnb6pL8thGEwtWAHZ
         zWyQNdFPSVRgkDoz/86FFaUAith9eZUsS+9H4Y4IaZl9aYq2oDGwJu65uoO/BuRC+3VB
         Nj2REwe6AdkAdkcVKkXOTdBpXqahwif1PNj3652dCtcBu308p1X2Uu3FikLpyIxAqFsE
         0ULg==
X-Forwarded-Encrypted: i=1; AFNElJ+OXf6+DbOfCeDxJrzJWZbMwqxsg/NeuoGwq2Byqtroptnd+Ap1s1PeF0dKxXwzvtDyAeDbNRf5kQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0vkPzF3NG7F59x3uCkGPOt5eYJ2Fz0E/nMY9HO9v2dpWBm6AZ
	vzaiOdW7Io+P9lcnzH218kIgtqEsjWFyhnwJBYZXv1MyKam4PqNM3IybwP4UYZaIih+poFBhsZS
	DwGVr6ZvRU5O+Q2kqcGjUduainyDHJYSw0+Ed7LymZ8qcWpjTHKKbOXQX5Xt7ww==
X-Gm-Gg: AeBDieu/xxP3IBpZP6YJ25HpTRfrdBUWQczMPq624tTUMjxXxMc/E6uJoMhGHchBsMe
	qtkcOpf5tWcYNNkqYk2OxBrBFP17Ol5DU8Us/UbR1BDLoVZzb68rOV+cuFatuuHgwJ1z+ephrkm
	aDj6WZu1U5LEesH12NUj2Z3jxXCzS1cTfQgbPXbpu77zj+ym/TPb8gjJuT00X3dfge6ne1pcXN5
	F/jzfj7G8Ppc5QzBu2NSbeGRYiUgJlMlbkwE/ITcJ/PcaBv7uU9aLoP6q+ENTSHo1PUHJBWnc4O
	tcto2yBtqm4ue3SeezSWRJ3Bq0eUGjk1a5GJ8Sxe8779KPOO8x7fI9KrOdWiLhcSrVlYrAElE0Q
	NuhmP7YdNBN5sdwdJBZ4qzpAZr+GLU4jxhdqtLxKW9r6p5D0JyvFCHQSNxRVohVgOlpHZH7Pt7Q
	tWtQobxeMQb13n2VxsLa34ZI/qTGk=
X-Received: by 2002:a05:6a00:3e21:b0:82f:120:fd6f with SMTP id d2e1a72fcca58-83a585411cfmr7197077b3a.0.1778157307972;
        Thu, 07 May 2026 05:35:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e21:b0:82f:120:fd6f with SMTP id d2e1a72fcca58-83a585411cfmr7197024b3a.0.1778157307350;
        Thu, 07 May 2026 05:35:07 -0700 (PDT)
Received: from [10.133.33.84] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965c30ddasm11025255b3a.21.2026.05.07.05.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 05:35:06 -0700 (PDT)
Message-ID: <a8501d98-7bd9-491b-81f5-fa343c2ecd42@oss.qualcomm.com>
Date: Thu, 7 May 2026 20:35:02 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: elanfreq: Drop support for AMD Elan SC4*
To: Sean Young <sean@mess.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20260507090107.10113-1-sean@mess.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260507090107.10113-1-sean@mess.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEyNSBTYWx0ZWRfX0MaYhz/srY56
 H3XNa1RecwI6aBMwj7SjQ8DGAF6ZGTwXPhVOaVg+LMEb862GSCC4j+9EJQYpUnls0LP0PN6dCO+
 4JzD9lHXrLn2qJhOGWIIqZO7HXcjF1W7bOFwEWLUhKpBiUxY7xIeqr0v02TeZz9Gyrrj5VmZsXL
 wkG1jgvwYNSd2uVpu/uD4pJeUh9WYyHu21Jb7seaorJtWdj64jwVaLqn3FtfzFSaATV3fCeVidc
 QBEMXZjD/WQYzR51Pbz/WbSrENgVubZshqe2V8wkCxgjfLU4+AngS9wF3d1VsYm1GYmZssuvqfk
 ZJUAYVO+Ycb52XiDbNSiFFx/KOx6PVAU8OO2D2r6JnBTWlv/7wbp2ppgGpCo1lwjX7DeS1mpOXS
 pNnjUz08BUle9Q9qLFHv93fvrEmgvYdsFdCOrVjL7MeKHhjMgeVaH6jvaEqly+XsbEo41CR/7C3
 AFb/btblN3oW1VwSVNQ==
X-Proofpoint-GUID: NUBmMSkwzKBnf4VbQGQbR9nogRhJc7U4
X-Authority-Analysis: v=2.4 cv=VNbtWdPX c=1 sm=1 tr=0 ts=69fc86fc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=xGAvDSoXAAAA:8 a=EUspDBNiAAAA:8 a=WQVVGId5AAAA:8 a=hSG5pozmvi54k6qu7kUA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=I9AbH5bZuplaqbmfSwNo:22
 a=Ro4MoL-rP1oEvTRli_YJ:22
X-Proofpoint-ORIG-GUID: NUBmMSkwzKBnf4VbQGQbR9nogRhJc7U4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070125

On 5/7/2026 5:01 PM, Sean Young wrote:
> Since commit 8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"),
> the AMD Elan SC4* is no longer supported, so the cpu frequency
> driver is no longer needed.
> 
> Signed-off-by: Sean Young <sean@mess.org>
> ---
> Changes since v1:
>   - Also removes elanfreq= entry from kernel-parameters.txt


Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> 
>   .../admin-guide/kernel-parameters.txt         |   4 -
>   drivers/cpufreq/Kconfig.x86                   |  15 --
>   drivers/cpufreq/Makefile                      |   1 -
>   drivers/cpufreq/elanfreq.c                    | 226 ------------------
>   4 files changed, 246 deletions(-)
>   delete mode 100644 drivers/cpufreq/elanfreq.c
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 4d0f545fb3ec..7ab0e58c4aa9 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1669,10 +1669,6 @@ Kernel parameters
>   			very early in the boot process. For early debugging
>   			via a serial port see kgdboc_earlycon instead.
>   
> -	elanfreq=	[X86-32]
> -			See comment before function elanfreq_setup() in
> -			arch/x86/kernel/cpu/cpufreq/elanfreq.c.
> -
>   	elfcorehdr=[size[KMG]@]offset[KMG] [PPC,SH,X86,S390,EARLY]
>   			Specifies physical address of start of kernel core
>   			image elf header and optionally the size. Generally
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 865b290b01ff..c42dd39e0b2a 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -126,21 +126,6 @@ config X86_ACPI_CPUFREQ_CPB
>   	  By enabling this option the acpi_cpufreq driver provides the old
>   	  entry in addition to the new boost ones, for compatibility reasons.
>   
> -config ELAN_CPUFREQ
> -	tristate "AMD Elan SC400 and SC410"
> -	depends on MELAN
> -	help
> -	  This adds the CPUFreq driver for AMD Elan SC400 and SC410
> -	  processors.
> -
> -	  You need to specify the processor maximum speed as boot
> -	  parameter: elanfreq=maxspeed (in kHz) or as module
> -	  parameter "max_freq".
> -
> -	  For details, take a look at <file:Documentation/cpu-freq/>.
> -
> -	  If in doubt, say N.
> -
>   config X86_POWERNOW_K6
>   	tristate "AMD Mobile K6-2/K6-3 PowerNow!"
>   	depends on X86_32
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 96196edf79d5..6c7a39b7f8d2 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -40,7 +40,6 @@ obj-$(CONFIG_X86_POWERNOW_K6)		+= powernow-k6.o
>   obj-$(CONFIG_X86_POWERNOW_K7)		+= powernow-k7.o
>   obj-$(CONFIG_X86_LONGHAUL)		+= longhaul.o
>   obj-$(CONFIG_X86_E_POWERSAVER)		+= e_powersaver.o
> -obj-$(CONFIG_ELAN_CPUFREQ)		+= elanfreq.o
>   obj-$(CONFIG_X86_LONGRUN)		+= longrun.o
>   obj-$(CONFIG_X86_GX_SUSPMOD)		+= gx-suspmod.o
>   obj-$(CONFIG_X86_SPEEDSTEP_ICH)		+= speedstep-ich.o
> diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
> deleted file mode 100644
> index fc5a58088b35..000000000000
> --- a/drivers/cpufreq/elanfreq.c
> +++ /dev/null
> @@ -1,226 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - *	elanfreq:	cpufreq driver for the AMD ELAN family
> - *
> - *	(c) Copyright 2002 Robert Schwebel <r.schwebel@pengutronix.de>
> - *
> - *	Parts of this code are (c) Sven Geggus <sven@geggus.net>
> - *
> - *      All Rights Reserved.
> - *
> - *	2002-02-13: - initial revision for 2.4.18-pre9 by Robert Schwebel
> - */
> -
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/init.h>
> -
> -#include <linux/delay.h>
> -#include <linux/cpufreq.h>
> -
> -#include <asm/cpu_device_id.h>
> -#include <linux/timex.h>
> -#include <linux/io.h>
> -
> -#define REG_CSCIR 0x22		/* Chip Setup and Control Index Register    */
> -#define REG_CSCDR 0x23		/* Chip Setup and Control Data  Register    */
> -
> -/* Module parameter */
> -static int max_freq;
> -
> -struct s_elan_multiplier {
> -	int clock;		/* frequency in kHz                         */
> -	int val40h;		/* PMU Force Mode register                  */
> -	int val80h;		/* CPU Clock Speed Register                 */
> -};
> -
> -/*
> - * It is important that the frequencies
> - * are listed in ascending order here!
> - */
> -static struct s_elan_multiplier elan_multiplier[] = {
> -	{1000,	0x02,	0x18},
> -	{2000,	0x02,	0x10},
> -	{4000,	0x02,	0x08},
> -	{8000,	0x00,	0x00},
> -	{16000,	0x00,	0x02},
> -	{33000,	0x00,	0x04},
> -	{66000,	0x01,	0x04},
> -	{99000,	0x01,	0x05}
> -};
> -
> -static struct cpufreq_frequency_table elanfreq_table[] = {
> -	{0, 0,	1000},
> -	{0, 1,	2000},
> -	{0, 2,	4000},
> -	{0, 3,	8000},
> -	{0, 4,	16000},
> -	{0, 5,	33000},
> -	{0, 6,	66000},
> -	{0, 7,	99000},
> -	{0, 0,	CPUFREQ_TABLE_END},
> -};
> -
> -
> -/**
> - *	elanfreq_get_cpu_frequency: determine current cpu speed
> - *
> - *	Finds out at which frequency the CPU of the Elan SOC runs
> - *	at the moment. Frequencies from 1 to 33 MHz are generated
> - *	the normal way, 66 and 99 MHz are called "Hyperspeed Mode"
> - *	and have the rest of the chip running with 33 MHz.
> - */
> -
> -static unsigned int elanfreq_get_cpu_frequency(unsigned int cpu)
> -{
> -	u8 clockspeed_reg;    /* Clock Speed Register */
> -
> -	local_irq_disable();
> -	outb_p(0x80, REG_CSCIR);
> -	clockspeed_reg = inb_p(REG_CSCDR);
> -	local_irq_enable();
> -
> -	if ((clockspeed_reg & 0xE0) == 0xE0)
> -		return 0;
> -
> -	/* Are we in CPU clock multiplied mode (66/99 MHz)? */
> -	if ((clockspeed_reg & 0xE0) == 0xC0) {
> -		if ((clockspeed_reg & 0x01) == 0)
> -			return 66000;
> -		else
> -			return 99000;
> -	}
> -
> -	/* 33 MHz is not 32 MHz... */
> -	if ((clockspeed_reg & 0xE0) == 0xA0)
> -		return 33000;
> -
> -	return (1<<((clockspeed_reg & 0xE0) >> 5)) * 1000;
> -}
> -
> -
> -static int elanfreq_target(struct cpufreq_policy *policy,
> -			    unsigned int state)
> -{
> -	/*
> -	 * Access to the Elan's internal registers is indexed via
> -	 * 0x22: Chip Setup & Control Register Index Register (CSCI)
> -	 * 0x23: Chip Setup & Control Register Data  Register (CSCD)
> -	 *
> -	 */
> -
> -	/*
> -	 * 0x40 is the Power Management Unit's Force Mode Register.
> -	 * Bit 6 enables Hyperspeed Mode (66/100 MHz core frequency)
> -	 */
> -
> -	local_irq_disable();
> -	outb_p(0x40, REG_CSCIR);		/* Disable hyperspeed mode */
> -	outb_p(0x00, REG_CSCDR);
> -	local_irq_enable();		/* wait till internal pipelines and */
> -	udelay(1000);			/* buffers have cleaned up          */
> -
> -	local_irq_disable();
> -
> -	/* now, set the CPU clock speed register (0x80) */
> -	outb_p(0x80, REG_CSCIR);
> -	outb_p(elan_multiplier[state].val80h, REG_CSCDR);
> -
> -	/* now, the hyperspeed bit in PMU Force Mode Register (0x40) */
> -	outb_p(0x40, REG_CSCIR);
> -	outb_p(elan_multiplier[state].val40h, REG_CSCDR);
> -	udelay(10000);
> -	local_irq_enable();
> -
> -	return 0;
> -}
> -/*
> - *	Module init and exit code
> - */
> -
> -static int elanfreq_cpu_init(struct cpufreq_policy *policy)
> -{
> -	struct cpuinfo_x86 *c = &cpu_data(0);
> -	struct cpufreq_frequency_table *pos;
> -
> -	/* capability check */
> -	if ((c->x86_vendor != X86_VENDOR_AMD) ||
> -	    (c->x86 != 4) || (c->x86_model != 10))
> -		return -ENODEV;
> -
> -	/* max freq */
> -	if (!max_freq)
> -		max_freq = elanfreq_get_cpu_frequency(0);
> -
> -	/* table init */
> -	cpufreq_for_each_entry(pos, elanfreq_table)
> -		if (pos->frequency > max_freq)
> -			pos->frequency = CPUFREQ_ENTRY_INVALID;
> -
> -	policy->freq_table = elanfreq_table;
> -	return 0;
> -}
> -
> -
> -#ifndef MODULE
> -/**
> - * elanfreq_setup - elanfreq command line parameter parsing
> - *
> - * elanfreq command line parameter.  Use:
> - *  elanfreq=66000
> - * to set the maximum CPU frequency to 66 MHz. Note that in
> - * case you do not give this boot parameter, the maximum
> - * frequency will fall back to _current_ CPU frequency which
> - * might be lower. If you build this as a module, use the
> - * max_freq module parameter instead.
> - */
> -static int __init elanfreq_setup(char *str)
> -{
> -	max_freq = simple_strtoul(str, &str, 0);
> -	pr_warn("You're using the deprecated elanfreq command line option. Use elanfreq.max_freq instead, please!\n");
> -	return 1;
> -}
> -__setup("elanfreq=", elanfreq_setup);
> -#endif
> -
> -
> -static struct cpufreq_driver elanfreq_driver = {
> -	.get		= elanfreq_get_cpu_frequency,
> -	.flags		= CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
> -	.verify		= cpufreq_generic_frequency_table_verify,
> -	.target_index	= elanfreq_target,
> -	.init		= elanfreq_cpu_init,
> -	.name		= "elanfreq",
> -};
> -
> -static const struct x86_cpu_id elan_id[] = {
> -	X86_MATCH_VENDOR_FAM_MODEL(AMD, 4, 10, NULL),
> -	{}
> -};
> -MODULE_DEVICE_TABLE(x86cpu, elan_id);
> -
> -static int __init elanfreq_init(void)
> -{
> -	if (!x86_match_cpu(elan_id))
> -		return -ENODEV;
> -	return cpufreq_register_driver(&elanfreq_driver);
> -}
> -
> -
> -static void __exit elanfreq_exit(void)
> -{
> -	cpufreq_unregister_driver(&elanfreq_driver);
> -}
> -
> -
> -module_param(max_freq, int, 0444);
> -
> -MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Robert Schwebel <r.schwebel@pengutronix.de>, "
> -		"Sven Geggus <sven@geggus.net>");
> -MODULE_DESCRIPTION("cpufreq driver for AMD's Elan CPUs");
> -
> -module_init(elanfreq_init);
> -module_exit(elanfreq_exit);


-- 
Thx and BRs,
Zhongqiu Han
