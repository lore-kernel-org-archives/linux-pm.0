Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004431;
	b=ulUWxQdXlMP51m37+tBX+jdx0IM+WD/izIj37BD8lATprP5KjQbzb6phzg+I3YU0drKt
	 UkEwZ8ydvWwoKGLo0hYvxxB8/i9RrJdtWX7Gu4FOXm/clw4F+5QtaFOAk6NZONzafv2/C
	 dcofs8OaEGYLQX6Q/3CxR5LZHVr2RXqYBCNp79NVSfgyTv0zUGAtUghbutV4PAcwTz6fZ
	 sgGmg8BCw0pVIj7X0yF2hUrmrLfr+BKqPw24NKsNJp2HRzKG2ueCWBrPncGZWTVbc8/Bs
	 6zYr6Qg5/h0qYhW/sPmYnpcQ8Ma/vFY+VT0QPIzOxMdnRljkuL9vhSidTTw4nyNXXHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004431;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=e3zWJzgW4jzf73NI3aUIWoYqQvEATIJvDrMWobNUPtI=;
	b=jQ6QCb5WR0N61h9dMWkKC6DFw2koTPvvx5hYpLEglLtoK+s8apq26wmboatq9drVgMLp
	 ldlvn1+w/oxGq4TSbTlEMcE8uY/7Ri7DUyFI5S6w10C73CEGrIg/A+Diw2++QxQLPT1pt
	 yxReC4lcG951L4SCj2mvSYRvy4eWJ+hCP4dokao220T6VRMVRA9p7KxG+sxI3CrqgV/2u
	 1uXdDx43aX7GMeJAY2lYhkBrpnj9XoXWsWA/tjPS9ONzms2HpEIZBqUipWjEk6Q7YN2tS
	 GM7hG7DpLjY4D8GTIytO1dAkVkR71VBTZlQloh0SI2RFR1vdNtPjOHJij7Ko9kSb3Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=KsIn9zk8;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88871606A31A;
	Mon, 26 Oct 2026 08:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88871606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=KsIn9zk8
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=e3zWJzgW4jzf73NI3aUIWoYqQvEATIJvDrMWobNUPtI=;
	b=KsIn9zk8xlPqJpPb3Gv8ZS2b9osDPSkoQxy4pMOdfllcy54bAww7QJbJXVSCSOLkhvW7No6/x
	0kdKSr86in4kjmut1LfJJ77148k2DvvAilGahhazzvs71QnyxBweSLfnWoSFqzrZAZrGJEd4W+V
	njcJaZLnug8/lW9IN48xF4w=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jCnL83Fbqz1T4KV;
	Mon, 26 Oct 2026 16:46:56 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CFF640537;
	Mon, 26 Oct 2026 16:47:03 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 16:47:02 +0800
Message-ID: <4df4a309-ffd5-4f46-856e-6ba21a614d72@huawei.com>
Date: Mon, 26 Oct 2026 16:47:01 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: CPPC: Enable boost by default when supported
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>, <xuwei5@huawei.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <pierre.gondois@arm.com>,
	<sumitg@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mojunjun4@huawei.com>, Christian Loehle
	<christian.loehle@arm.com>
References: <20261022075901.3436021-1-zhangpengjie2@huawei.com>
From: Pengjie Zhang <zhangpengjie2@huawei.com>
In-Reply-To: <20261022075901.3436021-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr200004.china.huawei.com (7.202.195.241)

+cc Christian Loehle

On 10/22/2026 3:59 PM, Pengjie Zhang wrote:
> The CPPC driver leaves boost disabled by default when Highest Performance
> exceeds Nominal Performance. Userspace must explicitly enable boost
> before governors can use the full advertised performance range.
>
> Enable boost by default when at least one possible CPU reports support,
> while users who prefer to stay within the sustained nominal limit can
> still disable it via the boost knob without determining scaling_max_freq
> for each policy.
>
> Check the performance capabilities before registering the driver so that
> the cpufreq core enables boost for each policy that supports it.
>
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
> Changes in v2:
> - Drop "even" and clarify the commit message (Christian).
> - Link to v1: https://lore.kernel.org/all/20261015015812.867988-1-zhangpengjie2@huawei.com/
>
>   drivers/cpufreq/cppc_cpufreq.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 80893844353c..0a4255a36f60 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -1052,6 +1052,25 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>   	.name = "cppc_cpufreq",
>   };
>   
> +static void __init cppc_cpufreq_default_boost_init(void)
> +{
> +	struct cppc_perf_caps caps;
> +	bool enable = false;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (cppc_get_perf_caps(cpu, &caps))
> +			continue;
> +
> +		if (caps.highest_perf > caps.nominal_perf) {
> +			enable = true;
> +			break;
> +		}
> +	}
> +
> +	cppc_cpufreq_driver.boost_enabled = enable;
> +}
> +
>   static int __init cppc_cpufreq_init(void)
>   {
>   	int ret;
> @@ -1061,6 +1080,7 @@ static int __init cppc_cpufreq_init(void)
>   
>   	cppc_freq_invariance_init();
>   	populate_efficiency_class();
> +	cppc_cpufreq_default_boost_init();
>   
>   	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
>   	if (ret)
