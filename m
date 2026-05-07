Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B0305E32
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 04:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778129465; cv=none; b=EZhtUm/d3ewNQGadfSgYGPDzy37LghYLhMIF1zkUCpLn+9lZDfPRMKooxvmL5qBabO4frQfDZpb8t+LxoMlEooz0MQ9qseC+pldevlzXKPf/OBzsvNWGEToYC2e4AKc26lQuhI2jdXVhJkYTNef1++jSY7IV7czWjx+l18810lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778129465; c=relaxed/simple;
	bh=r9GAL9TOpi5hj33TCH30gBDHe8cT1DT9NiCUNbNKrJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8wUjNJVo+WSX+wPud7g1gQj1+7b/LXvW19wVGNEtpGfxMpAg6lYJbD/2A0gEKxuEUkLddiA6SckQUbvOXnC2HQkzDUSgbAE9zb24h1NZxzCfpR+yttgtkQPHJAUcpjVdFLIAq9KrNn0hWNrx7rCRORO4OcHd+oERLtQI7kQroM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MXqD2zL5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FSm1gIEZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MXqD2zL5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FSm1gIEZ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6473eStl026471
	for <linux-pm@vger.kernel.org>; Thu, 7 May 2026 04:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d0GMGU1Xt1bopKbNCrBCNpO1/omI2AExqR4WkzmpAPQ=; b=MXqD2zL5NH8at79c
	k+6Xzjjw/pH9uKDEuxr/YTC4ikugMFMJlzD5zTDc0oOGewjY+cEmG69TI9knNx22
	hbQAnLWIJLtNmTeNYFyy04Jzd4cv2b1DE84tD+VjBF+8qE4OpWx0gibdQZr0pbS2
	gTDXv1hESFlrT5iDXZAQTI4cASr+mlYMZqGvdTJkYzFH/65TfOGhuAalCCIeZCFt
	70wFZLhR3Cgkw8Ujost2RpmB2jdJdVr5RM3grsCIFzQTuBB0j1hFb7pVMVnRMt0r
	VQU3fNbbY8TVITbPNtj3W4dXQApKKybUpgt8QODXfb7TJxvK2fs5YUQs3z80Gpsb
	Xv46Jg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1t05gb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 04:51:01 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8252a49ffcso537300a12.1
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 21:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778129460; x=1778734260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d0GMGU1Xt1bopKbNCrBCNpO1/omI2AExqR4WkzmpAPQ=;
        b=FSm1gIEZsPkbyEkNdRdl/R56wSeOXdkK36oH5Xg3rKQHtu3CgKAyLavU3WWbs7TrNf
         Gmwf5E0W3trMnjY7FQSMIuQ0zzs00D85irsNB2MKWKBYQ4EPgE0BOyCWzppfRb53Vzyh
         kOgu5QZzM1XZUngVk+DkmsFHcSegW6YYQY7isz8+fQoBg+vU1GyLjolwAI1gXWWSjjhF
         Gs5Ba6TLcypphvV5ckVYMRwfps1+P0VGv8o8ADMWF0pDEnAGt7DEDwPRuW0P4tlo0e0L
         GQMX9KKR7l3pZVl6dhC4wYz62HCrcTR53J6NnGzi1G4q70xjo9xlAbBnByea94ErXJJE
         +Dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778129460; x=1778734260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0GMGU1Xt1bopKbNCrBCNpO1/omI2AExqR4WkzmpAPQ=;
        b=QdhjIFeMWkytQdxQSFiTXkzrZsRxDgwNpY2D9ULKQ21WvDrik1RYI+S/QN2Uv46s7/
         6Z/vKMwjLGOWo6fJ9laPK5CXQRhyG/kZLXlx6c1sP2fqGy3zr2Nts5ASOsYnkiIjXraP
         OsPETi/nIWnbD7utQkgwevxBV02J3yCSDZqFORhYxd4ci7EyM903W2WiwaANWITcfQCa
         79uuLqogmHMDe9TZaEeNyMJTrUHpG2MF0Q41pLQJ+3FgnPtUy+mQ6eMQfm3RHloAWce3
         1XYURvUkiPZGiKVZoE3YpDTJTLFzhNPxQdd54YpiXkkA9isBt8h/TWvfDYytb3hXac+m
         uubw==
X-Gm-Message-State: AOJu0YzW66Zt1p5MfK/oSTr4iTd0GQUdxIQFTotcvY0jsv006GkrjBc6
	xhNyUzFR6ouXFW6bE9JnHXMgt5NCHljXWbOsqeyoUs+boqDBsylV2v7g6RFyCpIeSTTgjR7rtCG
	4z/4rZo6llGXwvFzFdFApppEfn4lgRle6CO79xsKp9uAdSxRJ7/k9THSWyp4VTg==
X-Gm-Gg: AeBDiet/Al0RBkO9O5L4o3zkMn3GNwLN30J8BXbKBkrnt9F8kVBBp6iI/ch/g7OshOc
	fYV4cehJaDw/KGxD0S1YW5T3pDY4D8pNGt/ex2m9l4di7BwIzQy4KWWbaC2MPDScSfGDskJnFg4
	Bkqs8C6PZ6b7p+93W/TJIeh72sdge2PM6646lq3BhWohl2z+Fu92iD0GmzlV7HP/Fmv/tx2i6Ug
	3JjyzUQ998ImlZUeyJiMGBLooQ6J8Ec+wDTnRxyKWevif0j/7soakAGDu3XZDP5LAb/erV8jNNq
	ZScAfqiyxRpGewqrKwxyUnLgYvDu6EFGKfmfvTqdQ4HYKvLVNmQwYtwhmkCRXLKHil668fGoqJH
	Y9XY+6iQcny/PlqmSA581rf1jr3YYXFFzL2Jni9BxNdXa6SLWBoDIgSvMs+rCfFTvAuXyhO8Stw
	ZDmyhC8/WKlrg1TbMKOv9qa5QYchk=
X-Received: by 2002:a05:6a00:12d2:b0:835:cc47:6fe7 with SMTP id d2e1a72fcca58-83a5dd5c9f0mr6003777b3a.30.1778129460331;
        Wed, 06 May 2026 21:51:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:12d2:b0:835:cc47:6fe7 with SMTP id d2e1a72fcca58-83a5dd5c9f0mr6003762b3a.30.1778129459749;
        Wed, 06 May 2026 21:50:59 -0700 (PDT)
Received: from [10.133.33.84] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965945101sm7056906b3a.13.2026.05.06.21.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 21:50:59 -0700 (PDT)
Message-ID: <1680200e-453f-4a2b-b407-4f703dd0a541@oss.qualcomm.com>
Date: Thu, 7 May 2026 12:50:55 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] cpufreq: elanfreq: Drop support for AMD Elan SC4*
To: Sean Young <sean@mess.org>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <cover.1778071745.git.sean@mess.org>
 <ab6775ddd8aa71f3a5a329500de24ff7f5c25ac8.1778071745.git.sean@mess.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <ab6775ddd8aa71f3a5a329500de24ff7f5c25ac8.1778071745.git.sean@mess.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EoPiaycA c=1 sm=1 tr=0 ts=69fc1a35 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=xGAvDSoXAAAA:8 a=WQVVGId5AAAA:8 a=7ol_Tg62x6MP1AucwT0A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=I9AbH5bZuplaqbmfSwNo:22
 a=Ro4MoL-rP1oEvTRli_YJ:22
X-Proofpoint-ORIG-GUID: WehoKVo6uS6CSCERu9HfEfLWI3jEUR4K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA0NSBTYWx0ZWRfX6l6WRvyaNnGQ
 wRLsV+pHCPlaAT6igGxjAXV0/nJ9fbub51ttyq5xyuCPQ9k/AKyygEYKzlQx54osJl5gDeNzI7I
 Z4sNqk9WBFo730kAMiDGktFijI7OfunSFKMbXNYNa1o3gZlQ8BOA4rifquUg8yAwX+gaRm7corG
 uA35T1XgpQeUc9QD833HWP7LPLmilywT3sWxJsEs//CjQzBVW9+ybEQoPu/fqv3mXViQq8wTZCs
 JNMqsYxQxctajH6lwWvmWzLcwHMK/xMPBTVPr35Yp3h8kGtDc1fyDDGKC7nhV5l6txkcXvDVKxz
 +refpde2PlyrPTOwI7JV0nGG8sEqpBtMsJOk35idxkyBu2AsRby9w0mx61Tm5vKNH98c+mXu9bW
 kCNQrjtr+rdrH/tH/C7jLjChzoT/VD/umGlcY2HpkA92f16VAKsBx4mY6pZg7Vpcijh2bAeUp7b
 BJp3bN7Mtp6iYKE/Usw==
X-Proofpoint-GUID: WehoKVo6uS6CSCERu9HfEfLWI3jEUR4K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070045

On 5/6/2026 10:42 PM, Sean Young wrote:
> Since commit 8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"),
> the AMD Elan SC4* is no longer supported, so the cpu frequency
> driver is no longer needed.
> 
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>   drivers/cpufreq/Kconfig.x86 |  15 ---
>   drivers/cpufreq/Makefile    |   1 -
>   drivers/cpufreq/elanfreq.c  | 226 ------------------------------------
>   3 files changed, 242 deletions(-)
>   delete mode 100644 drivers/cpufreq/elanfreq.c
> 

Thanks Sean,

One minor nit: now that the elanfreq driver and its setup code are
removed, should the corresponding elanfreq= entry in
Documentation/admin-guide/kernel-parameters.txt be dropped as well?

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/tree/Documentation/admin-guide/kernel-parameters.txt?h=linux-next#n1671


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
