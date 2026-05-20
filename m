Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9085B3AFCE0;
	Wed, 20 May 2026 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266305; cv=none; b=L/ch5bygwhZnTjHJDVectRPKETeLTiF27ILYbO/GT8xA5YJQGUPVozhAKT3N9+zxZklnwDI1ySq57bPFKTsFmkseUCwtW+r9zuwfB/IB1VKfM1cpdXsZUd9ysfS1dD9hzEQ+WEU+sSjw1ioQ31nMiHZDZNwOgYzx9wE6yI4I0hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266305; c=relaxed/simple;
	bh=6TdI/ja1PsNCKs9SKLEiLWFN4YwBa8l55w+8z4ynOIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e1od1cBcE9LzvfYZ2CzpO+fUgds0/0MfEtnoEuNAwPgS8/Vakp3z581SFip8cLRQ3v/Ol7QuXLuJk9DW2BCi2DGznI2oj7Nvitp1b98XzT/O98q5G/sFXo/CTqAvBsreJ3P3N0hHPRgj8DXnOZXFv34IbxzPn7BFcPUdIfv1Pt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gL4Vq6j2wzcb0T;
	Wed, 20 May 2026 16:30:43 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id DED7F4056D;
	Wed, 20 May 2026 16:38:17 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 20 May
 2026 16:38:16 +0800
Message-ID: <112c6947-d496-46a9-8561-bbc23793e615@hisilicon.com>
Date: Wed, 20 May 2026 16:38:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] cpufreq: Use policy->min/max init as QoS request
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
 <20260511135538.522653-5-pierre.gondois@arm.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260511135538.522653-5-pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 5/11/2026 9:55 PM, Pierre Gondois wrote:
> Consider policy->min/max being set in the driver .init()
> callback as a QoS request. Impacted driver are:
> - gx-suspmod.c (min)
> - cppc-cpufreq.c (min)
> - longrun.c (min/max)
> 
> Update the documentation accordingly.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  Documentation/cpu-freq/cpu-drivers.rst | 10 ++++++++--
>  drivers/cpufreq/cpufreq.c              | 12 ++++++++++--
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/cpu-freq/cpu-drivers.rst b/Documentation/cpu-freq/cpu-drivers.rst
> index c5635ac3de547..ab4f3c0f3a89b 100644
> --- a/Documentation/cpu-freq/cpu-drivers.rst
> +++ b/Documentation/cpu-freq/cpu-drivers.rst
> @@ -114,8 +114,14 @@ Then, the driver must fill in the following values:
>  |policy->cur			    | The current operating frequency of   |
>  |				    | this CPU (if appropriate)		   |
>  +-----------------------------------+--------------------------------------+
> -|policy->min,			    |					   |
> -|policy->max,			    |					   |
> +|policy->min			    | If set by the driver in ->init(),    |
> +|				    | used as initial minimum frequency	   |
> +|				    | QoS request.			   |
> ++-----------------------------------+--------------------------------------+
> +|policy->max			    | If set by the driver in ->init(),    |
> +|				    | used as initial maximum frequency	   |
> +|				    | QoS request.			   |
> ++-----------------------------------+--------------------------------------+
Hi Pierre,

Trivial bit: add the general meaning alongside its driver usage at the init
stage, and mention it defaults to cpuinfo_min/max_freq if not set?

I mean something like:
The minimum/maximum scaling frequency.  If set by the driver in ->init(),
used as initial minimum/maximum frequency QoS request; otherwise, follow
policy->cpuinfo.min/max_freq.

Thanks,
Jie
>  |policy->policy and, if necessary,  |					   |
>  |policy->governor		    | must contain the "default policy" for|
>  |				    | this CPU. A few moments later,       |
[ ... ]
