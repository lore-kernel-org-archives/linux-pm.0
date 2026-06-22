Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6322E1746
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782126106; cv=none; b=sMXb0J7ojpf3ykkVKQLV8kCgVFfdI9PXpmOJXi3pFYWujBZk7c5bO34sWKRk4aFN2fSJ6wA3OntT3PC35AEQrEbbAvHGE3XwNQlu6rd41DgFEpKiMc75oZ0nYKiipbNsnMMXlqXPKzJkhx7ivZ/OAXSqTaOPgqKwUNQHCwk8Pdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782126106; c=relaxed/simple;
	bh=NDQUSnItSW38oUJTEm8zZeXFfK/1bxhGeF1F7VfHarA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KELUSNLR/aycC0HJORxsn+ijT2QwsIPl9GlwhhAtFdyTLzUSm5afghUatSKeNUv1JCVunyrPeOYRiP58GV/ni1Z3OIMHTK6WBKKZjU5S8yDqAtMeSomk7JUBQIPLA7GswrPUbOPnajmz8l8Yw5t224nhdtPuaQl6MLadxyMbq98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a7wLSAlG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CtJofmeB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a7wLSAlG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CtJofmeB"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MAoY9x1017679
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 11:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AARN7G4QPvec8eqob/vF17xv4KWR384m4AJdD/OA+fM=; b=a7wLSAlGJ4kyyYYH
	cemNmeOIbU3IZNPy1FyLqpUR/mNR1hviUFtMuS1oDxwFA4Tkvj+e6JnDWI9oEkOq
	hSmX2LhrBQciyatQSJAHGUSI/QqStP716PSzPGFw8Q5DMbVxDxzgJ60OUb9PeuJc
	9/VYn2F2RNHYkZ4OHHqodJNqkjul8/WtRfV0n7Vbcefv9aYXtFWQYFufhmwtH9+K
	/jkUgEzTxIIgMl2OIsmwJwDo+hF75LyAJ2YIugFVpPp4J+xLA+7WRXlc93r+EwgJ
	h9+rW4wwRkJ/TQxjeFT1IGgMSzjU7w/OuB79rPt8+GQVCtX/JdsBmcRDZB2Srwu4
	SSWufQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37h845t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 11:01:43 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4853fc7bd03so983225b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 04:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782126103; x=1782730903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AARN7G4QPvec8eqob/vF17xv4KWR384m4AJdD/OA+fM=;
        b=CtJofmeB3Iab7kmz52xstnP+1ZD22tg6TgeIeOffwtCbIU9111VFjTikaPDVrBSS/s
         C8AQVQKMDp01CraXvSnIUDh/1R6+01DjeAj+/f0vGA0DfhdxCym0uMhY9z0c6e3xrxzo
         WDCQThicVkUPsEXG1lBgr5PzZC4t7mtzotNcEIenqL2TUifW9fB+2oLEcYndNUZOutEr
         8v+pGSR5qsmK9cUZIU0fPSZ8A0QeEBw/uECgFTs+qTsPwmmhanoDGjGvsAo3WYbOwacs
         PGB9szp1kI8uZLhNee3C2jIFrOP7klY+QLC7zDUFVlKo/MBGPgNTG7G2vGtLLn3iyrry
         /zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782126103; x=1782730903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AARN7G4QPvec8eqob/vF17xv4KWR384m4AJdD/OA+fM=;
        b=X3q6JdHogtBLaBpuCM9064rJbnOHHeyYm1E6vRKhExnQClQrV2tW2Hp4MyqUbbPo6S
         1ePsk0vaxYwVGr+n9SlNVJvsPq5itqjq8t0JIjKjbkpw1ZsLu9PtYKOdifmRkepfJnQf
         V02UxT9kKRlyeL7h/23pcbBKZ8ZuwFpK5auWOuVVP+edn/tld40qsN83GOsn00dafs+z
         z5xcKxEoH3ahGLTa3kVbC+ojQ9nsqdFDFysaC74fqar1aOkpLIG8CbY7Lg5O7IM+XkxW
         xup0Dn+wzm5wT4WzDI8pHJuYP7VRWudsxPuJRrhWktI4uPusNbNVvQyY2NoWF3GP9H72
         i6lQ==
X-Forwarded-Encrypted: i=1; AFNElJ/D3G00YLs/tgYsPDpsHwutXI63iDEVHUGMwI/sx+b6ogHYmRu+2EkpEFpUKEm5mow1mP0q9ZuQSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMIPy9L1jXjgwHRphkM2dc6o0rFPywnYYRmsGb8JKGcv/pchX7
	JyGxNA9J1oFNDoH2784ipCydIFdCa6oUDaEnTmyRbdFfFsqlZjG9xxZp4H2Ax5kQ3jEVCmwoIBK
	0c0Az4NNwy0knA08Nw+DGJYn8Cb3NndVXHLDaWo3Q/veDq070aEgN26l3g0dtAQ==
X-Gm-Gg: AfdE7cmFqgQQrayuKjzgooRlQW/ERseGaHeuum8Dirqh78Vo+rJUdcYkmPW4SYux6rq
	M6HevyVtVRMPyfSvj2HWU+VPlkJS5ZqQG6Mu1f89z8Wc4UvcH7MaYBiLa02uqnyA2wWPuTwO6zm
	HRLXiCmtoclxT9PSJsnEA3p1dPQogSQzDf6lsefl7AodZrG+LrmqBCH6PqNAJmJIOOc4L6aX51E
	d7hNVLV58u0XQ+2OYfDpd3Kgp3R0cwkZNEgO1lq/iUY30QuKNn7qXpGeTFPcNHW1BJqGMe3IN4V
	EzqWbj3HnkwM+whPTqkwGvbrjNzq8U1NqzlFpcEDseXYjbkOwueyuvshS6BeQN2GpOJNNitC32o
	YMEIc9/getBWb0drSwMik72IhDHBZKV7ogRw=
X-Received: by 2002:a05:6808:4f22:b0:48b:f341:1148 with SMTP id 5614622812f47-48bf34123afmr3761713b6e.3.1782126102395;
        Mon, 22 Jun 2026 04:01:42 -0700 (PDT)
X-Received: by 2002:a05:6808:4f22:b0:48b:f341:1148 with SMTP id 5614622812f47-48bf34123afmr3761687b6e.3.1782126101919;
        Mon, 22 Jun 2026 04:01:41 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60ac98c9sm336066766b.29.2026.06.22.04.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 04:01:41 -0700 (PDT)
Message-ID: <e203221b-5de5-4cc3-b65a-a3545986a954@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 13:01:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] powercap: qcom: Add SPEL powercap driver
To: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260620-qcom_spel_driver_upstream-v2-0-a3ee6837c18f@oss.qualcomm.com>
 <20260620-qcom_spel_driver_upstream-v2-2-a3ee6837c18f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260620-qcom_spel_driver_upstream-v2-2-a3ee6837c18f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ehwLTZJCyJWl3UbQq3HFGKoCpOZ_NnKM
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a391617 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=02jEIrHkWd2Y-gyNavAA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDEwOCBTYWx0ZWRfX5qLDPnVKmXrn
 5DzblPtQUzboSlfnT+u127avDDvnGUlFgPSiUNn8pgs8AYkVCcsQyWZ4pTbFb1DDjEkF8l91IYL
 ypmRyqbhoJbY5rWkkiMKtzgL1aahMCY=
X-Proofpoint-GUID: ehwLTZJCyJWl3UbQq3HFGKoCpOZ_NnKM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDEwOCBTYWx0ZWRfXw0dVv8wn+jTC
 ZbdKlzpkV3TqsUWOVplcTg879pr8PYRImVrW7yDx4JxEFnu45Z3psbzoM3yjEso9t9rCzkI7ON3
 X+E1P5WFDhCB+2zw51OpTEQ2QOp+ZkbJckze/LTT/7m6bivJ3LiAo/KWamQwvcYlz1xzjFOxMoU
 LJc7xIDg3lwZcBNJ3m7BgBLxhE4HDuLx60yGMcg+l3UTf53uImXLqb7o2J+g9W+h8oWK+e0y2e+
 x+vSB+PE82r3tSTVLXaZ6vSBGhivUwPnd8OXQNqghj6spG9eiUhfB0Rx7mrGhZEwTyGuqNJv5cP
 l/OvHJIU11cG26pI3JDh7Aclb7sSTuDwW68ItwUOia/xRCFDb2LYy/dcsiSDdLLgUIcN0cMFR2G
 PTtFZspdKblgluYxd7YFwLK39hxlv3qRJ+cWYGJVD5iKJX3j+E/OhBbCQzusv4yVaXhYdFr8nB2
 PGRog3VAkwkZnsPESVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220108

On 6/19/26 10:39 PM, Manaf Meethalavalappu Pallikunhi wrote:
> The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
> based power monitoring and limiting capabilities for various power
> domains including System, SoC, CPU clusters, GPU, and various other
> subsystems.
> 
> The driver integrates with the Linux powercap framework, exposing SPEL
> capabilities through powercap sysfs interfaces.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
> ---

[...]

> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/powercap.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>

Please ensure all the includes are necessary

> +
> +/* SPEL register bitmasks */
> +#define ENERGY_STATUS_MASK		GENMASK(31, 0)
> +
> +#define POWER_LIMIT_MASK		GENMASK(14, 0)
> +#define POWER_LIMIT_ENABLE		BIT(31)
> +
> +#define TIME_WINDOW_MASK_L		GENMASK(14, 0)
> +#define TIME_WINDOW_MASK_H		GENMASK(22, 16)

Is BIT(15) not part of this?

[...]

> +/* Domain configuration */
> +static const struct spel_domain_info domain_info[SPEL_DOMAIN_MAX] = {
> +	[SPEL_DOMAIN_SYS]	= { "sys", 0x40 },
> +	[SPEL_DOMAIN_SOC]	= { "soc", 0x00 },
> +	[SPEL_DOMAIN_CL0]	= { "cl0", 0x5c },
> +	[SPEL_DOMAIN_CL1]	= { "cl1", 0x60 },
> +	[SPEL_DOMAIN_CL2]	= { "cl2", 0x64 },
> +	[SPEL_DOMAIN_IGPU]	= { "igpu", 0x08 },
> +	[SPEL_DOMAIN_DGPU]	= { "dgpu", 0x44 },
> +	[SPEL_DOMAIN_NSP]	= { "nsp", 0x0c },
> +	[SPEL_DOMAIN_MMCX]	= { "mmcx", 0x10 },
> +	[SPEL_DOMAIN_INFRA]	= { "infra", 0x18 },
> +	[SPEL_DOMAIN_DRAM]	= { "dram", 0x1c },
> +	[SPEL_DOMAIN_MDM]	= { "mdm", 0x48 },
> +	[SPEL_DOMAIN_WLAN]	= { "wlan", 0x4c },
> +	[SPEL_DOMAIN_USB1]	= { "usb1", 0x50 },
> +	[SPEL_DOMAIN_USB2]	= { "usb2", 0x54 },
> +	[SPEL_DOMAIN_USB3]	= { "usb3", 0x58 },
> +};

I would expect that the names are going to stay common, but the offsets
will be different. This array should probably be called
glymur_domain_info[]. We may have another LUT just for names of indices
(i.e. [SPEL_DOMAIN_xxx] = "xxx")

> +
> +/**
> + * struct spel_constraint_info - Power limit constraint information
> + * @limit_offset:	Register offset for power limit value
> + * @time_window_offset:	Register offset for time window
> + * @supported_mask:	Bit mask in capability register
> + * @domain_id:		Domain this constraint applies to
> + * @pl_id:		Power limit ID (PL1, PL2, etc.)
> + */
> +struct spel_constraint_info {
> +	u32 limit_offset;
> +	u32 time_window_offset;
> +	u32 supported_mask;
> +	enum spel_domain_type domain_id;
> +	int pl_id;
> +};
> +
> +/* Constraint configuration */
> +static const struct spel_constraint_info constraints[] = {
> +	/* SYS domain constraints */
> +	{ 0x10, 0x70, BIT(0), SPEL_DOMAIN_SYS, POWER_LIMIT1 },
> +	{ 0x14, 0x74, BIT(1), SPEL_DOMAIN_SYS, POWER_LIMIT2 },
> +	{ 0x18, 0x78, BIT(2), SPEL_DOMAIN_SYS, POWER_LIMIT3 },
> +	{ 0x1c, 0x7c, BIT(3), SPEL_DOMAIN_SYS, POWER_LIMIT4 },
> +	/* SoC domain constraints */
> +	{ 0x00, 0x60, BIT(4), SPEL_DOMAIN_SOC, POWER_LIMIT1 },
> +	{ 0x04, 0x64, BIT(5), SPEL_DOMAIN_SOC, POWER_LIMIT2 },
> +	{ 0x08, 0x68, BIT(6), SPEL_DOMAIN_SOC, POWER_LIMIT3 },
> +	{ 0x0c, 0x6c, BIT(7), SPEL_DOMAIN_SOC, POWER_LIMIT4 },
> +};

Is this specific to Glymur, or SPEL-wide?

[...]

> +/**
> + * struct spel_system -	SPEL system

odd tab after '-'

[...]

> +	case PL_LIMIT:
> +		new_val = spel_unit_xlate(sd, POWER_UNIT, value, 1);
> +		if (new_val > FIELD_MAX(POWER_LIMIT_MASK))
> +			return -EINVAL;
> +		reg_val = (reg_val & ~POWER_LIMIT_MASK) | FIELD_PREP(POWER_LIMIT_MASK, new_val);

FIELD_MODIFY()

> +
> +		/*
> +		 * Enable/Disable PL based on the value:
> +		 * - If value is 0, disable the PL (clear enable bit)
> +		 * - If value is non-zero, enable the PL (set enable bit)
> +		 */
> +		if (new_val == 0)
> +			reg_val &= ~POWER_LIMIT_ENABLE;
> +		else
> +			reg_val |= POWER_LIMIT_ENABLE;

Likewise


> +
> +		writel(reg_val, reg_addr);
> +		return 0;
> +
> +	case PL_TIME_WINDOW:
> +		/*
> +		 * Encode time window: upper 7 bits to [22:16], lower 15 bits to [14:0]
> +		 */
> +		new_val = spel_unit_xlate(sd, TIME_UNIT, value, 1);
> +		if (new_val > TIME_WINDOW_MAX)
> +			return -EINVAL;
> +		/* Read-modify-write to preserve other bits */
> +		reg_val = (reg_val & ~(TIME_WINDOW_MASK_H | TIME_WINDOW_MASK_L)) |
> +			  FIELD_PREP(TIME_WINDOW_MASK_H, new_val >> 15) |
> +			  FIELD_PREP(TIME_WINDOW_MASK_L, new_val);

Also here

[...]

> +static void spel_detect_powerlimit(struct spel_domain *sd)
> +{
> +	struct spel_system *sp = sd->sp;
> +	u32 capabilities;
> +	int i, j;
> +
> +	capabilities = readl(sp->config_base + LIMITS_CAPABILITY_OFFSET);
> +
> +	/*
> +	 * Detect power limits from hardware capabilities.
> +	 * Start from index 1 (POWER_LIMIT2) since PL1 is always enabled in spel_init_domains().
> +	 */
> +	for (i = 1; i < ARRAY_SIZE(pl_names); i++) {

int i = POWER_LIMIT2

(yeah, nowadays you can finally declare the iterator inside the loop
in the kernel)

Konrad
