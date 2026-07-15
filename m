Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE39031716D
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124063; cv=none; b=OmvLvlpdHmXry7IU5JH+G3dyEg2EihohKc5/tAmHMI3fnzrddZKGsgIYnWiGBbolmhSKSmYnDVLDV5gAoD9Rgak1fbNhyxoGGvfxhD/4pC21tlfw77bNRmoxu9EnzMi4O0tbZdvhBGn3FzGyTf2KJDxqsn3DkP5DKz1PadjpUm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124063; c=relaxed/simple;
	bh=qVOdtxzIBYmdAG1iXlq25IWbzv8cZ/3iHmmI7Ynl5+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJa0/qlvyzqXPbsYP9H5DYk3075Z/ns2acRGafbhx8bQquelS7qVwB+DJX6CERLR28L2J3kWpcfrc6zeV/STKzcB8gsPv4xPeLZfjAODPxVQ2Dgg51FFrc0RdIxOPY+PPcwKZAbnvXNWlOeknkD6P7DcDqx1eLplcrPSFfP8qdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AAIrtIHe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e1azRXsq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AAIrtIHe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e1azRXsq"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBdUeV3697872
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 14:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AkI9ZljfEAoSPZamC8DXcGGfqQBFXrQhqMpAP3gbVLc=; b=AAIrtIHeHH5286oP
	4vA2We19ORsDYQebbfNvfHwlfyA2Yth67klVdkpgJAPXwFaIjlrCeWxW9yWF+Tct
	psND1AxMxgMdTML3IbD3ui3+pu9MXvgJpMAX0iStAMYtOr8jT/J88aaCN5Fm53kZ
	np53/l78oOBlBA9rc1wNuCwV1+7Pg7vrKA+m7Z0ft1142zk8AarAMawTyV89dX6X
	a4LGGz6QUuz8P1+9P1TEYelkmfZSDhI5waW9uFRwEmDhyC3GmxtfOZGYQtYh46A2
	bZbu3TBfZyYjmYnKaC/BSw7WlQ/6JnIXU3ppt+YvW2jGwuPaKVlTtjsuTofNye7P
	bYQWNA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe03vjn3s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 14:01:00 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso1049608b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 07:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784124059; x=1784728859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AkI9ZljfEAoSPZamC8DXcGGfqQBFXrQhqMpAP3gbVLc=;
        b=e1azRXsqAdUVWvIY6AhJNaiDyFYgi1UvU10ct6q6TTvm6NDUFPN8qVl6s95Q1M1SbF
         El6vUgR5HzD99upgnqV761onuHhMTo9Cf888aOhYG4NuyUlZapIAHgLAdKgA/TFRlw7v
         kCRvt+7OzREcI48FU7wLX9Uxd/OdZ7UESV9iY0ebU1oea2/CEJMh7ZTZsvI6FAGVDvvR
         /sUvBHUu/yr2ptiiPvb82qPa38LJLbL0Jka1YFohw5w8DGVQVzi5p14XCoIaf2azaT8K
         7ygOEZ4DtUooysol1OQhTWIghgeTP4bD8XqSlZAUFSHmlspDsxgl132BbpFftM4NgSt0
         16gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784124059; x=1784728859;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AkI9ZljfEAoSPZamC8DXcGGfqQBFXrQhqMpAP3gbVLc=;
        b=iSVQbU1QV6gn0FM36ZI8UhoW63yW7GH/3Ut4Bt1yH+eAHDGp0RZ33rTcY9Y6Y6SxXH
         WcQZEkhr+UJ05pENwZhDdNTP3Yfgtby5EknSgBbp66poCuraoEErHhIje4QDAxIe5Qdd
         6WIXJBNc3iYNeygwaugkx0S0QJmNEIqoDKyLJON288jBDvJKC3Jp99OLkFmaC4yIqstT
         Rs9mzxY2jXEVtuvG0c0jEKvVbYYLiQFf+uSBN5jmXzGctN+fEMEHr1rhWWw4Eu+5Ijt3
         1KXMEdjPmD5XK005NhBoI6adfLqULAJX64ss7casCNV8Xsm/DcbEx9T2OtJGkBno8N61
         IsyA==
X-Gm-Message-State: AOJu0YxF8Ywtt1uIeIlmy051L74IxyTMthXec3dI0qVLbuAMZnI8Y9kV
	edDn9N4pWokYElWWdOjPoDspn7tmWh8Up7wL4TqrQP3qLwzjUufe1dowZ2hIfS1uuw0g2Ja2Eos
	4ELTmAzJaDHMVUpjG+ITMj23r+I6+Jb5Ay3jkZDNDCfZrUMIGh1cqY6Y1X/C9hA==
X-Gm-Gg: AfdE7cmkyWlB5zFE5jQI4K5oGg/lVv1RDd+5muekdSa8Cja/ZvlVkEUnJq3Ks0cPFmL
	US0pQ3DC8YW7l13NLWf6/oAH3Zzw4ZzG9vdOuXPWWxnJfGjeNKcHrhzqUf4mQSCOJrUJaxugVwV
	cNL7aaDQRQKyOZe31eHO0SY/LA+vw0sjOEQdwYzXCLDt8Ki/dsOxgrNGavUWNj5/KvEaUL9yXmb
	wAEC0iVxDDvpgRRtO3mizOhBhU1Jsmz+VLTshakSzaPB0j1JuaBrRoC8qnxxLw93LH1iRFibHx9
	VhBE6H0e0pv6Tj12FSebJTIMqWDnxvtz/0QKFuL2q1Q7tnIgFWJ/YDLvcI9R3BlsEZgVI33n+sY
	U2cRMgnjfrj71NJSDpZPALOnSX9f9FtRqWsCtKUhV
X-Received: by 2002:a05:6a00:a14:b0:848:452d:9a14 with SMTP id d2e1a72fcca58-8487037f5c3mr21136249b3a.16.1784124059322;
        Wed, 15 Jul 2026 07:00:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:a14:b0:848:452d:9a14 with SMTP id d2e1a72fcca58-8487037f5c3mr21136176b3a.16.1784124058715;
        Wed, 15 Jul 2026 07:00:58 -0700 (PDT)
Received: from [10.239.133.197] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eb82desm273331a12.2.2026.07.15.07.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 07:00:57 -0700 (PDT)
Message-ID: <96c49e02-12bd-4f2b-b4bd-ccb98d2e530e@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 22:00:50 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: amd-pstate-ut: fix null pointer dereference
To: Qianheng Peng <pengqh1@chinatelecom.cn>, ray.huang@amd.com,
        mario.limonciello@amd.com, perry.yuan@amd.com, kprateek.nayak@amd.com,
        rafael@kernel.org, viresh.kumar@linaro.org, skhan@linuxfoundation.org,
        li.meng@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangxb12@chinatelecom.cn, xiongl24@chinatelecom.cn,
        zhangar@chinatelecom.cn, zhongqiu.han@oss.qualcomm.com
References: <1784108124-19988-1-git-send-email-pengqh1@chinatelecom.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <1784108124-19988-1-git-send-email-pengqh1@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ife3n2qa c=1 sm=1 tr=0 ts=6a57929c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=XyLTfj0TmM6u0BRaSL4A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: zECjxh3BrSpuyqHzNjwXB7vlIN-97fKE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEzOSBTYWx0ZWRfX12ZHkMZIQE5X
 C1cK0vN9Ito5s+uPZY89EEOcIFsIZKYos0A0qJ56NbihRfXivdEOM6EKridSVgpdS7dAY++t8KO
 kaLnktO5UUnO4xe8wBn2VShibbQlE56/dndbyBJHrzKqpSKnJ7RVWkMenf1+m59GNOgnilAJ40K
 sjUgCaC3Dx6MKAsoXF9q5f9Qe9YsJblgIOii4yJ1Dgb3cdFWZFCIs0trFy5anjENlxUMnduFpvu
 Sy8J640rPyeBKlNh+nnEklylmpaGZZawmL6e2QzrMt0uyI9NFoFiJpqaZCsc4smKIcFvLDdHUxT
 8HzHMnKic5Sk4zSh84kgViR6hJ/Yy6k3rlIftKHq/imc35C7x5i/ei9uHfTROdMXlNfYPHTRVQE
 ikyg6+o6jgNtoKblBD9RiBLiTdCxOYqONafB4b0A1Z13CIjUorXYDxVZ3qFYPrLdyDGJNFXe8iV
 E7k076YFyuUWOew8n6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEzOSBTYWx0ZWRfX+a9FT1L4zuTe
 79sLxeLRjaaEFGMYYQN+vo+lWkLF4Q0Vl2zc5b9JNfiEJQUM8rkoHSsF04Z4slP7L0BazVuwczf
 svw+Dja6qcov7spNeaQ9FG7laF4Xo3U=
X-Proofpoint-GUID: zECjxh3BrSpuyqHzNjwXB7vlIN-97fKE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150139

Hi Qianheng,

On 7/15/2026 5:35 PM, Qianheng Peng wrote:
> The crash issue may occur when insmod amd_pstate_ut module on intel platform.
> 
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
> Add invalidation check of cpudata in amd_pstate_ut_check_perf() and
> amd_pstate_ut_check_freq() to avoid unpredicated null pointer dereference.
> Otherwise, add driver name detection for amd_pstate_ut driver to prevent it

The driver-name check in amd_pstate_ut_init() is the actual fix: it
prevents this module from running its test cases on non-AMD platforms.

The NULL check should not be necessary. On an already-registered amd
pstate driver, policy->driver_data is set only after a successful
->init() and is cleared only in ->exit(), so it is never legitimately
NULL for a live policy:

1. Hotplug offline path: a normal CPU hotplug offline does not hit
->exit(). The driver's .offline callback makes __cpufreq_offline() take
the light-weight teardown path and return early, so ->exit() (and the
kfree) is not invoked and cpudata stays valid. The full teardown only
happens on driver unregister / device unbind.

2. Driver exit path: the NULL check does not close the theoretical UAF
window here, since the test does not hold policy->rwsem: cpudata can be
kfree()'d between the check and the subsequent dereference. Worse, the
passive amd_pstate_cpu_exit() frees cpudata but does not reset policy
->driver_data to NULL, so the check would pass and then dereference a
dangling pointer. This is a pre-existing issue and out of scope for this
fix.

so it is better to drop the "NULL check of cpudata" commit msg and code.

(Others may have more context here, so please free free correct me if
I'm wrong.)



> from testing cpufreq driver on non-amd platform.
> 
> Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
> Suggested-by: Li Xiong <xiongl24@chinatelecom.cn>
> Suggested-by: Xibo Wang <wangxb12@chinatelecom.cn>
> Signed-off-by: Qianheng Peng <pengqh1@chinatelecom.cn>
> 
> ---
> v2:
>    - Print policy->cpu instead of policy->kboj.name
>    - Add cpufreq driver name detection to amd_pstate_ut
> 
> v1: https://lore.kernel.org/all/1784015941-26535-1-git-send-email-pengqh1@chinatelecom.cn
> ---
>   drivers/cpufreq/amd-pstate-ut.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 735b29f..5d71315 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -157,6 +157,10 @@ static int amd_pstate_ut_check_perf(u32 index)
>   		if (!policy)
>   			continue;
>   		cpudata = policy->driver_data;
> +		if (!cpudata) {
> +			pr_err("%s empty driver_data on cpu %d\n", __func__, policy->cpu);
> +			return -EINVAL;

Strictly speaking, it should be %u, right? Since policy->cpu is an
unsigned int, using %d is a format-specifier type mismatch.

> +		}
>   
>   		if (get_shared_mem()) {
>   			ret = cppc_get_perf_caps(cpu, &cppc_perf);
> @@ -229,6 +233,10 @@ static int amd_pstate_ut_check_freq(u32 index)
>   		if (!policy)
>   			continue;
>   		cpudata = policy->driver_data;
> +		if (!cpudata) {
> +			pr_err("%s empty driver_data on cpu %d\n", __func__, policy->cpu);
> +			return -EINVAL;
> +		}
>   
>   		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
>   			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
> @@ -560,6 +568,15 @@ static int amd_pstate_ut_check_freq_attrs(u32 index)
>   static int __init amd_pstate_ut_init(void)
>   {
>   	u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
> +	const char *driver_name = NULL;
> +
> +	driver_name = cpufreq_get_current_driver();
> +	if (!driver_name)
> +		return -ENOENT;
> +	/* don't test if non-amd cpufreq_driver exists */
> +	else if (strcmp(driver_name, "amd-pstate") &&

Nit: Redundant else after a return: since the previous branch already
returns, control can never reach the else if, so it is better to drop
the else and use a separate if.

> +		 strcmp(driver_name, "amd-pstate-epp"))
> +		return -EEXIST;

How about -EOPNOTSUPP or -ENODEV? And it would be helpful to log
error info here.


>   
>   	for (i = 0; i < arr_size; i++) {
>   		int ret;


-- 
Thx and BRs,
Zhongqiu Han
