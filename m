Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57BB286D7D;
	Sat,  9 May 2026 02:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778292098; cv=none; b=eyReSsR+tFJgHukerZipAjEBb7sODmkR3si58TFbzlCBqWyHG68yaWluJFX2tIxZvc+VVFIEq10wS6eXQFHqMcT9il/CkLyX0UKbyGg21scJ+MOqH1yNQEa5lEX0xx/QhGWRAvQ3ExE3+AZ0UUiY04ngYAN+w4gpWF6uSwkpGSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778292098; c=relaxed/simple;
	bh=nnPUCPPWQ3CntrxsgTLK/8BWNmKXNW6z0FujZlspcYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A1Yi3Bz3lyL8zEsxn0R8PYE23NWr4FIBKISA12PK3T8TFERU+sA7uzpO2Dpk6qBO1lzvg3EasqiUQ3o4h4x5XPlmss9yTo6XEKf0NrzVqilW5pcme2EmzNSEoPekqa7zc40LTMvhGFA+qjlxh88Ytt3FRu75o6h1b7spedyyKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1fklqAZI; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1fklqAZI"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mo0zKzqaZj1i/oxW9pR6gbyoq59+tl0QHXs9Rx42bsI=;
	b=1fklqAZI9MR5Tsgf+LRCwYeR58VRz5ajWWRT5fkTHbsJuF8BGwIhuXzw3D0/jEHBnfoYZbUui
	9kjegiWc5HDEoi9GtGekvGFWzlIvdLUqw89wU0gl+Tx2xlJ2gdKCESE9eI9JvKPU3rzqhfNk5MD
	IK75OQmoJzAq1B1T5hnX51w=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gC8D32LQTz1K9ZP;
	Sat,  9 May 2026 09:53:55 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 612A5402AB;
	Sat,  9 May 2026 10:01:28 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf100001.china.huawei.com
 (7.202.181.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Sat, 9 May
 2026 10:01:27 +0800
Message-ID: <bcd46d21-77a4-4f67-a82d-f32618f7fac2@huawei.com>
Date: Sat, 9 May 2026 10:01:26 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: conservative: Fix incorrect frequency decrease
 due to stale target
To: Viresh Kumar <viresh.kumar@linaro.org>, Zhongqiu Han
	<zhongqiu.han@oss.qualcomm.com>
CC: <rafael@kernel.org>, <stratosk@semaphore.gr>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>
References: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
 <cb369a6a-5462-4e6b-a132-ee016a4163ea@oss.qualcomm.com>
 <b6d995f7-91c0-4f87-82e7-87cc50faa43d@huawei.com>
 <aoo2k2uzi6zg6owrmi7qgcgjryxzk7l7f2mdo6vtjjdd576hpn@rg6zyqgn7grr>
 <80d32bdb-f661-44cb-b529-3d5ce2142af0@oss.qualcomm.com>
 <pr25udlbea4vwtx27gfzlnqzv3lmmphkjx5xj2ggzdegmd4ntn@kiytfovoifi3>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <pr25udlbea4vwtx27gfzlnqzv3lmmphkjx5xj2ggzdegmd4ntn@kiytfovoifi3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100001.china.huawei.com (7.202.181.215)

On 5/8/2026 6:14 PM, Viresh Kumar wrote:
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index df01d33993d8..c7ec11de9a43 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -103,10 +103,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>         if (load > dbs_data->up_threshold) {
>                 dbs_info->down_skip = 0;
> 
> -               /* if we are already at full speed then break out early */
> -               if (requested_freq == policy->max)
> -                       goto out;
> -
>                 requested_freq += freq_step;
>                 if (requested_freq > policy->max)
>                         requested_freq = policy->max;
> @@ -124,15 +120,8 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
> 
>         /* Check for frequency decrease */
>         if (load < cs_tuners->down_threshold) {
> -               /*
> -                * if we cannot reduce the frequency anymore, break out early
> -                */
> -               if (requested_freq == policy->min)
> -                       goto out;
> -
> -               if (requested_freq > freq_step)
> -                       requested_freq -= freq_step;
> -               else
> +               requested_freq -= freq_step;

Small probability but it is still possible that freq_step is larger than
requested_freq.

> +               if (requested_freq < policy->min)
>                         requested_freq = policy->min;
> 
>                 __cpufreq_driver_target(policy, requested_freq,
> 

