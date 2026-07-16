Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71E14248AD
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211074; cv=none; b=KVAQhNQz10KuN1ogK03MqM7A2WR40kz7YLjnuk28GpA+AiKZgD54Vrf0RIHmia8m7XiCgj4Dkq2LoOhjO7dG/CyKqzYXCnsSLxlSimij9F/Do/J9vJaPspBxKw6/KETTUVGNbWe6AU7XY0hqga7LXnPgWyLx3aW2v9sITSjfY1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211074; c=relaxed/simple;
	bh=VdSrM8Fd8Og8p4MALRBaWDIz/aVawIHFve9OkaRw5PA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S89LBjWcO/Qn76tyGOWFp5RzMx+R8mOw3peO/ghu5pxtR5JPQAYms0+B8g2h0wjIJRIYcU8fHYOf6XgkQCo3kmBojTuv4PI/GR7SW7Hf/Nu+VYYv+IQL2Ka/ImChBIdWA4Aj3/tzkQtMtl1DXZzUp09eDY29eOC9v7awwsh1nN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ossHlQal; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hj50smpN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ossHlQal";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hj50smpN"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDKSM92857935
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 14:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OjIUystLYQEiwLo6aFI8saCO3ZV7wLC349fLsPtJmWs=; b=ossHlQalD6s8vBa8
	8Zq84EMzX3ujU4YpDUxXC/FvT3BoIXerF4TI6PxpUEV3cPuDmGjqhPJuGtuoN0Z+
	TH4jpq2wQO+85KZuePDxuppCy1qvGG840EhGRArFs1amjHVQDE2sOuhvibeDiNZl
	V+O64kUZ51rCqF2K3NfZLlCi8LAZ1UEaXOltwwWRYsIhINJGYuZmbJDXLYB1Klps
	EFX5dfWjRGsHxi4f6T+EKxeAs4oYeDMZkQiGI0j6ScnjN6/sIdo6fkUMq8ggVvBm
	/Hhn8CH9CufMDgRx6L447kr6YqGGQMCGraT6c92cqJ5MbZibCEvFyjI9HOnfeL4G
	qVs+kA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feuex1hqn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 14:11:10 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccd1958e8fso46192785ad.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 07:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784211070; x=1784815870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OjIUystLYQEiwLo6aFI8saCO3ZV7wLC349fLsPtJmWs=;
        b=Hj50smpNLnSF85vaOkVxHoiSbNK9UfFbqz+wo7MK0o1p2nvdT4oxitXfW+IfrnSOUU
         FfOUWhSj6biQI6wEzHEwxNoua1YBBO7Rj8NfKAicIk/Cq9lfURW4jedMtWPrjylFGvEV
         MWhib3WvxIppRWBK8JovaXX1jliRZr8z6RimNYtqQN492IO94t+Q53RX6VIXFjkffj8Z
         T+XTzPktGXgm9YwZhs8uHKHYV12PLYi/9PxQoqfwbeQ++6fOeSz22nCiJMJK82ilyvgF
         L2oB6aBztDQdSeTY/Ry7cfpP25Xl7n0ybLPOuxu2ChR98pavYb7i5KJh9tWwYQaimo0y
         yUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784211070; x=1784815870;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OjIUystLYQEiwLo6aFI8saCO3ZV7wLC349fLsPtJmWs=;
        b=EnJPP3XqAgYtl1gSl4QvLFqI8O4SROMfAPnd5Oh/iWVG8GV9rOvhYM0Osf7zmV8Rmx
         jHpdLYV1qeyOBHVsFcMzIWp1EElyLODGzEs35jeUzmb1QuqUMO7otY4Dl3noROWH6hOA
         I/nOygFRhROXtA/tJn3ib5S1VaOtbyTUfKpoG0diDzTQq+YzoFgMgZ5UZpdKItnETUAJ
         P6BL8/iZeLekO/Si53jpsvwZFCItC4BBEcxKrFwF13AFUgzTUOsULamzbrpK5pCuJ49B
         L8mMkz8dhfmNI2OecdnMRhN+oDIcbaxP1RZoUS1GHh47nQdyhett5c+bHOOHVjB0GTwB
         jxcQ==
X-Gm-Message-State: AOJu0Yw+9OSVZTR2MUKkT4OMseNUP8pXWfhIi/pgLhZHVFY6tN5HLVK0
	ZduDa3tjAFMGsPTLzPgR/wcbb/8S0hIa2Peb/ldGP+j5/3H683MTu2/i9g0OYNsr7Gvt/l5SB/F
	OGhdr+bIGynsximsVnnkUg3sVJm6CptN2ShtTTqVQYdm5JTYd/HKb8CpyZW0V1MrdFPkmqcej
X-Gm-Gg: AfdE7cmIRgq+vCJ3r2oUx0q5Gmp/vOBQ36dyIzbXtqRUio5w1U0h3JBgmstH5dMzr1F
	E1rQmvbiaUH2tGdJtdv4Z0+1tWyEcYFDIKta+c6hZf7VXoPN2DSOgP+1zsJ/86nm+rljf7MGj3x
	0IIw6vg+MyGKLJKHuWglnUuss6Yuwospw61mnmG6TvC+vrCD+jB10OeOGKz1LoxbTD++YA9WS/R
	dedihbJocnKmRBWMIB1GKJplV1N4h/rMa2eojZf2c3vnOzXyVyrkn1x8O+72dxAxW06s88nqMEv
	9RUdf7+6OPMoJpmHjDUmMykmT/DUsEa3rqfdGulMSn4GWKn67/KI2kPyHV5Bauaavebu1laE/az
	nmeTSrkRyd2v3hHQfym+x09a7DiGtGA==
X-Received: by 2002:a17:903:32cc:b0:2c9:854c:a45c with SMTP id d9443c01a7336-2ce9f02bb90mr225676795ad.34.1784211069495;
        Thu, 16 Jul 2026 07:11:09 -0700 (PDT)
X-Received: by 2002:a17:903:32cc:b0:2c9:854c:a45c with SMTP id d9443c01a7336-2ce9f02bb90mr225676285ad.34.1784211069010;
        Thu, 16 Jul 2026 07:11:09 -0700 (PDT)
Received: from [10.239.133.197] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1059782csm20527265ad.58.2026.07.16.07.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 07:11:08 -0700 (PDT)
Message-ID: <09b4f56e-0bc7-4b5e-8d97-a0c924be67f7@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 22:11:02 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq: amd-pstate-ut: bail out early on non-AMD
 platform
To: Qianheng Peng <pengqh1@chinatelecom.cn>, ray.huang@amd.com,
        mario.limonciello@amd.com, perry.yuan@amd.com, kprateek.nayak@amd.com,
        rafael@kernel.org, viresh.kumar@linaro.org, skhan@linuxfoundation.org,
        li.meng@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangxb12@chinatelecom.cn, xiongl24@chinatelecom.cn,
        zhangar@chinatelecom.cn, zhongqiu.han@oss.qualcomm.com
References: <1784191899-28957-1-git-send-email-pengqh1@chinatelecom.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <1784191899-28957-1-git-send-email-pengqh1@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JeeMa0KV c=1 sm=1 tr=0 ts=6a58e67e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KMAsm0FWdzjmD8Gr-2AA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: gUas1nc33mHxA3VKjhMkW3J2xXM43ce5
X-Proofpoint-GUID: gUas1nc33mHxA3VKjhMkW3J2xXM43ce5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0NSBTYWx0ZWRfX+KHF8aWtIM25
 cSqKSVbnRGcimKjw+x2E33WHyj9yFO7UZrYBGXC6YS2MRAC6V7H2niKnU1+FHsYr2d1H0cAYM3A
 dC6opOoQ5VFKYffJrM7c8XA7EZJHCAU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0NSBTYWx0ZWRfX3xc3ZYiA2IJy
 U0QCvo609oyyMIoSxs3vOyNevltThW+DWcKUnzAaCBFjXBv2lk+EzkZZeJDoHrp2ONsxBGKN+3G
 5+Akn6IRK340et5NQnGBKz6FpZaCYgXd1VM9JM46iOuvnIcb9GtsjHM0UxAzgPDGgshE/mwYA6i
 pcHi+fPMuKO2agauupqBiNxOvsslWGDELM8fiNXEMzH3SM4KIVw4Wy1LpyKo0JziQPiyVO5msrV
 T3cnzsI7L1xgmHpqjktILhYhSzDs8WkMU6Nc9zVXxth3GIdHLMKONiSzA7NFjgkOe2yoBl9oabJ
 NL6z7QeV3KiUWr8vZ9cS00kM1eDEoYGXXEfXJISrosGFh0LcKJDfcNBSlZmJKhq+RoVSEIRCOfk
 AMYGq8tPPcu9YW7GU8CI1Az3Vwr0yKoDvrjhpThYTa1sagMtj8/Jc0Y/ECRW1vMHBzq3nBzMPes
 lruw1oV/GFbB7lDA8eA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160145

Hi Qianheng,

Thank you for your patience. It looks good to me overall, just a few
nits inline.

On 7/16/2026 4:51 PM, Qianheng Peng wrote:
> The crash issue may occur when modprobe amd_pstate_ut on intel platform.
> 

It is better to start with:

"Loading the amd-pstate-ut module on a non-AMD platform triggers a NULL
pointer dereference:"

or

"A kernel NULL pointer dereference occurs when loading the amd-pstate-ut
module on a non-AMD (e.g. Intel) platform"

>     amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
>     amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
>     BUG: kernel NULL pointer dereference, address: 0000000000000080
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 0 P4D 0
>     Oops: 0000 [#1] SMP NOPTI
>     CPU: 0 PID: 20300 Comm: modprobe
>     Kdump: loaded Tainted: G O 6.6.0-0010.rc1.ctl4.x86_64 #1
>     Hardware name: FiberHome R2200 V5/Xeon Boards, BIOS 3.1a 02/24/2020
>     RIP: 0010:amd_pstate_ut_check_perf+0x141/0x280 [amd_pstate_ut]
>     Call Trace:
>      <TASK>
>      amd_pstate_ut_init+0x1b/0xff0 [amd_pstate_ut]
>      ? __pfx_amd_pstate_ut_init+0x10/0x10 [amd_pstate_ut]
>      do_one_initcall+0x42/0x2e0
>      ? kmalloc_trace+0x26/0x90
>      do_init_module+0x60/0x240
>      __se_sys_init_module+0x185/0x1c0
>      do_syscall_64+0x62/0x190
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>      </TASK>
> 
> Add state detection to amd pstate driver to prevent amd_pstate_ut driver

This change fixes the amd-pstate-ut module rather than the amd-pstate
driver itself. Maybe something like:

"Add driver-state detection to the amd-pstate-ut module ..."

> from testing on non-AMD platforms.

It also covers the AMD_PSTATE_DISABLE case but not only non-AMD platforms.

And likewise, the subject may be changed as well, for example:

"cpufreq: amd-pstate-ut: Bail out early if the amd-pstate driver is not
running"

or

"cpufreq: amd-pstate-ut: Skip tests when amd-pstate driver is not
active"


> 
> Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
> Suggested-by: Li Xiong <xiongl24@chinatelecom.cn>
> Suggested-by: Xibo Wang <wangxb12@chinatelecom.cn>
> Signed-off-by: Qianheng Peng <pengqh1@chinatelecom.cn>
> 
> ---
> v3:
>    - Remove unnecessary NULL check
>    - Add detection to driver state instead of driver name
> 
> v2: https://lore.kernel.org/all/1784108124-19988-1-git-send-email-pengqh1@chinatelecom.cn
>    - Print policy->cpu instead of policy->kboj.name
>    - Add cpufreq driver name detection to amd_pstate_ut
> 
> v1: https://lore.kernel.org/all/1784015941-26535-1-git-send-email-pengqh1@chinatelecom.cn
> ---
>   drivers/cpufreq/amd-pstate-ut.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 735b29f..2142838 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -560,6 +560,11 @@ static int amd_pstate_ut_check_freq_attrs(u32 index)
>   static int __init amd_pstate_ut_init(void)
>   {
>   	u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
> +	enum amd_pstate_mode mode = amd_pstate_get_status();
> +
> +	/* don't test if no running amd-pstate driver */

How about:

"/* Do not run tests when the amd-pstate driver is not active. */"

> +	if (mode == AMD_PSTATE_UNDEFINED || mode == AMD_PSTATE_DISABLE)
> +		return -EOPNOTSUPP;
>   
>   	for (i = 0; i < arr_size; i++) {
>   		int ret;


Anyone, please feel free to correct or ignore any of the nits above.

Regardless, the patch code looks good to me.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


-- 
Thx and BRs,
Zhongqiu Han
