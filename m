Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED21C26B755
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 04:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778129087; cv=none; b=a4XMutk1b6rlc8Nh7XDhSyaQrxc5wmlm5voLxY2ftkFLNnJ53cl76+cXYMZN5bU3bMAD65Yxn7RavIRjKgQFUMVmvrLLZxP9/3h0/6mCzPICqzenn9+UI29FJAYn2/5I7JACnBe2GcdO/GQXBjLoh6E1JAa4J2eqfg+9g2T+2vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778129087; c=relaxed/simple;
	bh=tnhIOCL+xNnplydUI/qF2P/AgYmmBKT1oW2qU1iTQGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJDYMZ6O0i4qZkkPscZ6qycfjNRNXdp29awbm2Zks7ZWZXwh5CFYvb3DpufRRv4wZeTdsReseuf93LH8ertuBShEKXu6hY+Vr1RNNnwuSVYW8YK858UDiRf3PUl2jk6HRm6JQsdvUKpVPayoC1uxdkv2PGVEQGHzyu+kqfIGACY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O+d9GyK9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jyVLCKn0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O+d9GyK9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jyVLCKn0"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646MYS6x3309176
	for <linux-pm@vger.kernel.org>; Thu, 7 May 2026 04:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EM+AHwi/TQ0ZXjnKKM7fIcSXzsuI4UJ/Vxly4Jl/dgc=; b=O+d9GyK9oMXaW4Fc
	6GoL6SBQeGXriYijtIB9xc2GX6fFF5aMmhcAsv4zBSUrCKafFmu2JKdFyewFX7MY
	kV2f7ajwpf0OHJ2yGc38GIeHvkwcDRRNzYXPMUuqQODUiNu2GSCaIg26yNIWhTB+
	1EZ1D8At519MeoFhikB9mI4mja8fadYXhdxJLhHkqKgqJ1OHVKngKnvcHKUUX0EH
	HgkuBkNEWYosLn+CXoKlLCGIgcpPQzXWg/RLuCacdIQ1Unp3+zWTPsJNgkMjuUhZ
	Vl4mrSUE9W6fCFwkW0/m+f3APHe2mTfLGOlCudtguCvICH+bQrbmBwmmuwasjcT0
	nAkIhQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e078sjn65-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 04:44:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36529b265cfso613430a91.2
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 21:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778129083; x=1778733883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EM+AHwi/TQ0ZXjnKKM7fIcSXzsuI4UJ/Vxly4Jl/dgc=;
        b=jyVLCKn0EDykyCLXPUcE9RZSJjJj7SPLgk7iYUo8XCvtFI5/Dnk2uNFZ5Ge/vrso44
         /T2lQ8rGJYo4Cu7eTVSg+HcirLx3hHqjU/7HQcTQQJRobjFjaH2emFZiTU157JZkIEAA
         yVd0h+oDDS2fhf3IHwbVWnWPBmxspPyLlhcjfTxRWX6522UGZtY4PGoF2QFIsJFN2BXp
         /4L82ojsld4mpKL/0JuPyqP8MtFy79J4QLHzvjb7uK9WDteHMb1oJchwooSCbxRIUBbq
         4w6yZI9Pkki03M0wFVYGRy+iwYTLKknnXyB40nR0YyT1pido8l/1tKFxt40+M7DWbXg1
         WoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778129083; x=1778733883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EM+AHwi/TQ0ZXjnKKM7fIcSXzsuI4UJ/Vxly4Jl/dgc=;
        b=BKE1xvTQcWylXvI+T6iuh6aLMK/JL4cgdCxAIRJrv2rlXAXMP4PrUin04QHqoKadlI
         SmaaypqDn6nJAL1/LCpspdX5rqSMKJSh8ek/gyypR88upw7C2Zb2WXva+bcv43/LJHqh
         3rAVlHVML8+ChP5wEGw742h/wWTXxrjfAT3Xy4zoiEXVwO8CcokiHxdkYbov/YfZtjuk
         eqsekYK8f0tXmNNzIx8Z/roBlqJMuwgg/lylNkCaGqKwwd/UsChA/2+WEIEmytKD6Pzd
         STNvn3lphccn2PExOEKEUxiHZ4vDp+sO3B4fwx6gYZ7fwRDMchNO098VQqB9IpEkbwUw
         Oy4Q==
X-Gm-Message-State: AOJu0Yz/6mRMIJpjPq14YQGToBI6Nt1vaZUMTx1tfTid3zSSR7ozzcyD
	P2ZRdzmCYXACN1Lcuho1cv0zhfz00GhQV+mC++EG/DehHJiDoMlh7XaQaLJfEpMxEp/3xShUa5k
	4Wtzrnwsmsc2Qf+uxCcR+1G6GhEEb0msNRkahyGcrso0RtYQyNQUeyTVSGeA40JG1OC0bWMmC
X-Gm-Gg: AeBDiet18xF4s5I102lT3EuTqPjQLmsCqjHhP0gfJYb9hkEHYHeC9M95UxpOl6++Fd7
	UJx/m0vDRrmD5F2TbClMSHJcBwA58tTj2Edaqr5wzw/o9+veay1C8zOy3U+uhPzk7ce3NuoYF3e
	LgiDekyx4KwG24AO+DyeGGZmwwqFcvVNs9PWzZerVcHUOztCP2IKb6dBmo0FIbCDPVtFqlwPc6b
	oScunojhUJuT1KMSBKIX6t65SrVAHQ/b2fQSL6grcXTVe4ouqErL7D+1mn1pWjqCjhZBYNp3HcT
	DNusvMkZ9Z2YkKAeEml4OwLnsKLYPN7G7xR70gw5EOKretDY3tzbMCNrr8Yk+Ia3nR4vpyw8SCe
	gRK30/Uvh4kGRFzjXyXiEs4E0cN7tawsNhJfzC3/SDw53P3dOlTkhnrfWOQnKH7WPUoLuiY4v+W
	V2E3sswikIiaGTCGPEMwN94y16zJU=
X-Received: by 2002:a17:903:3bd0:b0:2b0:7d3d:756a with SMTP id d9443c01a7336-2ba794c05aemr77557385ad.35.1778129083210;
        Wed, 06 May 2026 21:44:43 -0700 (PDT)
X-Received: by 2002:a17:903:3bd0:b0:2b0:7d3d:756a with SMTP id d9443c01a7336-2ba794c05aemr77557165ad.35.1778129082694;
        Wed, 06 May 2026 21:44:42 -0700 (PDT)
Received: from [10.133.33.84] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2babb2e5bf3sm9282825ad.83.2026.05.06.21.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 21:44:42 -0700 (PDT)
Message-ID: <22cab2f4-1538-44e2-ac96-fb2b39d92bbf@oss.qualcomm.com>
Date: Thu, 7 May 2026 12:44:37 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] cpufreq: sc520_freq: Drop support for AMD Elan SC520
To: Sean Young <sean@mess.org>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <cover.1778071745.git.sean@mess.org>
 <12a3abd097fda750ae905290c86ddb8d2b0a716c.1778071745.git.sean@mess.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <12a3abd097fda750ae905290c86ddb8d2b0a716c.1778071745.git.sean@mess.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Lc8MLDfi c=1 sm=1 tr=0 ts=69fc18bc cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=xGAvDSoXAAAA:8 a=EUspDBNiAAAA:8 a=PPKScp5biaQuhl8iTOUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=I9AbH5bZuplaqbmfSwNo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA0MyBTYWx0ZWRfXwWRvVPMYIiSq
 WOKbNBqfqWzgqvh1jFzBoB7jN/RIxsTLXPqibAMUIujV/WxeE9WZKej/WguKZzSkQrmubx0EJ3d
 48gHFzQMGE+twIr+dWbJDNdUFRzEziqJF2NE2VO//vmUxEcY0M9Q3tfhTvOpR3tKCmXOZtvGY0h
 B5c1Q0weM5CQv84yDo9jA2fs4LbWpcEuct48XQp8H0EKCGY4t+ANVCWLtMj8HHNhxJwvTUvmLB0
 kZuzbk47Vw4+f3+EXAGY16wQbDg8Td1lLhIOUUkTib1szZnpyLAJSQBozqmSOgSZY7r6NbGIG9c
 /TJpFz9YUplhaPJ22kkwo7aeT8DEZ9XDGOt04KdqFJ9jDm8lLheN/wGy71DX3OJHUJgs/BWtRg+
 Y6sn7SoDwrpBaXHDtIkBTq8Sx2lhKU/2vvYEjHw/3YVZK01U6SkFGiMxBlVt68s3CviWFCUAbh4
 D1npR9CWE+O0B+DT0Vg==
X-Proofpoint-ORIG-GUID: C6WtKxGl7AcM5XNkvrjvAmkFk0zq0GkE
X-Proofpoint-GUID: C6WtKxGl7AcM5XNkvrjvAmkFk0zq0GkE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070043

On 5/6/2026 10:42 PM, Sean Young wrote:
> Since commit 8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"),
> the AMD Elan SC520 is no longer supported, so the cpu frequency
> driver is no longer needed.
> 
> Signed-off-by: Sean Young <sean@mess.org>


Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> ---
>   drivers/cpufreq/Kconfig.x86  |  11 ---
>   drivers/cpufreq/Makefile     |   1 -
>   drivers/cpufreq/sc520_freq.c | 136 -----------------------------------
>   3 files changed, 148 deletions(-)
>   delete mode 100644 drivers/cpufreq/sc520_freq.c
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 027e6ea2e038..865b290b01ff 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -141,17 +141,6 @@ config ELAN_CPUFREQ
>   
>   	  If in doubt, say N.
>   
> -config SC520_CPUFREQ
> -	tristate "AMD Elan SC520"
> -	depends on MELAN
> -	help
> -	  This adds the CPUFreq driver for AMD Elan SC520 processor.
> -
> -	  For details, take a look at <file:Documentation/cpu-freq/>.
> -
> -	  If in doubt, say N.
> -
> -
>   config X86_POWERNOW_K6
>   	tristate "AMD Mobile K6-2/K6-3 PowerNow!"
>   	depends on X86_32
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 385c9fcc65c6..96196edf79d5 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -41,7 +41,6 @@ obj-$(CONFIG_X86_POWERNOW_K7)		+= powernow-k7.o
>   obj-$(CONFIG_X86_LONGHAUL)		+= longhaul.o
>   obj-$(CONFIG_X86_E_POWERSAVER)		+= e_powersaver.o
>   obj-$(CONFIG_ELAN_CPUFREQ)		+= elanfreq.o
> -obj-$(CONFIG_SC520_CPUFREQ)		+= sc520_freq.o
>   obj-$(CONFIG_X86_LONGRUN)		+= longrun.o
>   obj-$(CONFIG_X86_GX_SUSPMOD)		+= gx-suspmod.o
>   obj-$(CONFIG_X86_SPEEDSTEP_ICH)		+= speedstep-ich.o
> diff --git a/drivers/cpufreq/sc520_freq.c b/drivers/cpufreq/sc520_freq.c
> deleted file mode 100644
> index b360f03a116f..000000000000
> --- a/drivers/cpufreq/sc520_freq.c
> +++ /dev/null
> @@ -1,136 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - *	sc520_freq.c: cpufreq driver for the AMD Elan sc520
> - *
> - *	Copyright (C) 2005 Sean Young <sean@mess.org>
> - *
> - *	Based on elanfreq.c
> - *
> - *	2005-03-30: - initial revision
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
> -#include <linux/timex.h>
> -#include <linux/io.h>
> -
> -#include <asm/cpu_device_id.h>
> -
> -#define MMCR_BASE	0xfffef000	/* The default base address */
> -#define OFFS_CPUCTL	0x2   /* CPU Control Register */
> -
> -static __u8 __iomem *cpuctl;
> -
> -static struct cpufreq_frequency_table sc520_freq_table[] = {
> -	{0, 0x01,	100000},
> -	{0, 0x02,	133000},
> -	{0, 0,	CPUFREQ_TABLE_END},
> -};
> -
> -static unsigned int sc520_freq_get_cpu_frequency(unsigned int cpu)
> -{
> -	u8 clockspeed_reg = *cpuctl;
> -
> -	switch (clockspeed_reg & 0x03) {
> -	default:
> -		pr_err("error: cpuctl register has unexpected value %02x\n",
> -		       clockspeed_reg);
> -		fallthrough;
> -	case 0x01:
> -		return 100000;
> -	case 0x02:
> -		return 133000;
> -	}
> -}
> -
> -static int sc520_freq_target(struct cpufreq_policy *policy, unsigned int state)
> -{
> -
> -	u8 clockspeed_reg;
> -
> -	local_irq_disable();
> -
> -	clockspeed_reg = *cpuctl & ~0x03;
> -	*cpuctl = clockspeed_reg | sc520_freq_table[state].driver_data;
> -
> -	local_irq_enable();
> -
> -	return 0;
> -}
> -
> -/*
> - *	Module init and exit code
> - */
> -
> -static int sc520_freq_cpu_init(struct cpufreq_policy *policy)
> -{
> -	struct cpuinfo_x86 *c = &cpu_data(0);
> -
> -	/* capability check */
> -	if (c->x86_vendor != X86_VENDOR_AMD ||
> -	    c->x86 != 4 || c->x86_model != 9)
> -		return -ENODEV;
> -
> -	/* cpuinfo and default policy values */
> -	policy->cpuinfo.transition_latency = 1000000; /* 1ms */
> -	policy->freq_table = sc520_freq_table;
> -
> -	return 0;
> -}
> -
> -
> -static struct cpufreq_driver sc520_freq_driver = {
> -	.get	= sc520_freq_get_cpu_frequency,
> -	.verify	= cpufreq_generic_frequency_table_verify,
> -	.target_index = sc520_freq_target,
> -	.init	= sc520_freq_cpu_init,
> -	.name	= "sc520_freq",
> -};
> -
> -static const struct x86_cpu_id sc520_ids[] = {
> -	X86_MATCH_VENDOR_FAM_MODEL(AMD, 4, 9, NULL),
> -	{}
> -};
> -MODULE_DEVICE_TABLE(x86cpu, sc520_ids);
> -
> -static int __init sc520_freq_init(void)
> -{
> -	int err;
> -
> -	if (!x86_match_cpu(sc520_ids))
> -		return -ENODEV;
> -
> -	cpuctl = ioremap((unsigned long)(MMCR_BASE + OFFS_CPUCTL), 1);
> -	if (!cpuctl) {
> -		pr_err("sc520_freq: error: failed to remap memory\n");
> -		return -ENOMEM;
> -	}
> -
> -	err = cpufreq_register_driver(&sc520_freq_driver);
> -	if (err)
> -		iounmap(cpuctl);
> -
> -	return err;
> -}
> -
> -
> -static void __exit sc520_freq_exit(void)
> -{
> -	cpufreq_unregister_driver(&sc520_freq_driver);
> -	iounmap(cpuctl);
> -}
> -
> -
> -MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Sean Young <sean@mess.org>");
> -MODULE_DESCRIPTION("cpufreq driver for AMD's Elan sc520 CPU");
> -
> -module_init(sc520_freq_init);
> -module_exit(sc520_freq_exit);
> -


-- 
Thx and BRs,
Zhongqiu Han
