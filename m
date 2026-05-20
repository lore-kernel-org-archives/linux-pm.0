Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2332C924;
	Wed, 20 May 2026 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264738; cv=none; b=q0A1ngz3Q/PcQi429HY2LE4G9CRTvlL85bY7m9ohuP+zNpkctCG7wsY7HpfI+BHVpcoVnB9Mo4qmDwxjt6hKNOzBbYiNKA3UYoNhuCDbT3iZ6PpDrnj8/MtMwUVn7p/OqAai6UP1JstjePUUIN7eKe+Mn2D9H8DutkqowevHn5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264738; c=relaxed/simple;
	bh=MhXaYiT85I2NMAt1mEC1GMFV7LCZ6SP31AjjdrB9eQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JPYGdsUtZhljLgYfQ7rQDCt8SDyP6zCzeJqCvWHAdI4l/f/8YL9/pceov0FqKMFGNQcLTplHX9TZ/C7/53ATFndO/meJ0038yUFHTb3d54lcvW3djHQMK9nUO/xAbcry6l2ieBB9N9PE8jPxwewhyeY6H8CI8LY/KuAhiW/TGew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gL3wQ3DTrz1T4Ht;
	Wed, 20 May 2026 16:04:22 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 9ED6F4056A;
	Wed, 20 May 2026 16:12:13 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 20 May
 2026 16:12:12 +0800
Message-ID: <a2446156-99c3-4f5a-8868-a4c8d3323a34@hisilicon.com>
Date: Wed, 20 May 2026 16:12:11 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cpufreq: Set default policy->min/max values for
 all drivers
To: Pierre Gondois <pierre.gondois@arm.com>, <linux-kernel@vger.kernel.org>
CC: Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu
	<ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>, Zhongqiu Han
	<zhongqiu.han@oss.qualcomm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>, Mario
 Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Saravana
 Kannan <saravanak@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
References: <20260511135538.522653-1-pierre.gondois@arm.com>
 <20260511135538.522653-3-pierre.gondois@arm.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260511135538.522653-3-pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 5/11/2026 9:55 PM, Pierre Gondois wrote:
> Some drivers set policy->min/max in their .init() callback.
> cpufreq_set_policy() will ultimately override them through:
> cpufreq_policy_online()
> \-cpufreq_init_policy()
>   \-cpufreq_set_policy()
>     \-/* Set policy->min/max */
> Thus the policy min/max values provided are only temporary.
> 
> There is an exception if CPUFREQ_NEED_INITIAL_FREQ_CHECK is set and:
> cpufreq_policy_online()
> \-__cpufreq_driver_target()
>   \-cpufreq_driver->target()
> 
> To prepare for a following patch that will remove all
> policy->min/max initialization in the driver .init() callback
> if the min/max value is equal to the cpuinfo.min/max_freq,
> set a default policy->min/max value for all drivers.
> 
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
[ ... ]
