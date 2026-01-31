Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4FC30AACA;
	Sat, 31 Jan 2026 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769830111; cv=none; b=QNSSGSCZ1Yg2/LUeIiuPHD1tS6MS5VVRVSNttxHe52mi7qSB0X9jsCbos0UWR0+vcYJ2y/NiGTHw3AuUHf/p5t2DDVmjjjDgkOQ3lbXWvCEIaZlPQH7Kj2plpXpmuta3euSJkDy8RPL9HKkcDvfTDVhM+HK4fYxHCIhI31kWWww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769830111; c=relaxed/simple;
	bh=0mtnfQtxg7QdsxYHUX/XNIc4HGqog3OtlXupiGcdgVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XpjJDZD94dspzIixo+22CdOX9cOVgbzztjKvs9864YcV4rv7EBz+6HYqhXXqd2Jm4Gv1RsG4OLjrZSOEBJJOaJluIca3Ky3gWq7K8VbCX0xFrshZ2eFB74pdI+Gw/dTAw26eubmXjESdwVijNY4gdDm73DMUa2+DSvGG3hN0p+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GNvoOeRv; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GNvoOeRv"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=T298TrAtGUnTDTh/OMLw0RpeL50vtnNqbPKtbF9TXyM=;
	b=GNvoOeRvkLIZTrWpogRtx3mPzhHb0ngeigan7jIUksEMQxgw63jkeBVo4oETrXTiOltzEUmkg
	r3rlEBVrRM2NZJjfkQd9DUfiuo2m5r95NwyF+AhjteOx+YM33heD2o+vK/qBAQKCEVWqx2j59fL
	Hd1byc3m254pHXzi9MeJClo=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4f2ysH11jjz1T4Fg;
	Sat, 31 Jan 2026 11:24:03 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 82A4440569;
	Sat, 31 Jan 2026 11:28:19 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 31 Jan
 2026 11:28:18 +0800
Message-ID: <f1ffeb2e-d235-454e-8425-490ea2d076e9@huawei.com>
Date: Sat, 31 Jan 2026 11:28:18 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] cpufreq: Remove per-CPU QoS constraint
To: Pierre Gondois <pierre.gondois@arm.com>
CC: Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu
	<ionela.voinescu@arm.com>, Christian Loehle <christian.loehle@arm.com>,
	<sumitg@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Saravana
 Kannan <saravanak@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260126101826.94030-1-pierre.gondois@arm.com>
 <20260126101826.94030-2-pierre.gondois@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260126101826.94030-2-pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2026/1/26 18:18, Pierre Gondois wrote:
> policy->max_freq_req represents the maximum allowed frequency as
> requested by the policyX/scaling_max_freq sysfs file. This request
> applies to all CPUs of the policy. It is not possible to request
> a per-CPU maximum frequency.
> 
> Thus, the interaction between the policy boost and scaling_max_freq
> settings should be handled by adding a boost specific QoS constraint.
> This will be handled in the following patches.
> 
> This patch reverts of:
> commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
> a CPU")
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4472bb1ec83c7..db414c052658b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1481,10 +1481,6 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>  
>  		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  				CPUFREQ_CREATE_POLICY, policy);
> -	} else {
> -		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> -		if (ret < 0)
> -			goto out_destroy_policy;

I think this shouldn't be the first patch. This can be removed only after
adding boost_freq_req, otherwise it's letting the problem out again.

>  	}
>  
>  	if (cpufreq_driver->get && has_target()) {

