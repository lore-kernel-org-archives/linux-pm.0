Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC103CD8C7;
	Thu, 21 May 2026 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366184; cv=none; b=lKJi7vsMaWp5T6sIK6fHolJTw559HCoidzqZ2D0ApEvWpyUJiuEwut932oW5/60y9A4EG6C8SHr2YSkO9pG4xMnGU2qXnB+NX0hhen5Nd3AvqdCZdwT0cN6CDNkOIfRsugfJex1ZY3T2bgSPxnLpUI71og+acNLORLBw+6RWwWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366184; c=relaxed/simple;
	bh=1XFn7Ktf2O9hnTWVhIFaQs+iv6QZWebvBwLwbjM9J4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZRgV3r29w3vHT5E/QNmCsWHtYm8az23+PnjI30uN4FxtdBgSxT1g4ZxijuhY9mtAYi29K9hTFPovBekZjkvzDWJSIYatUCD0xYhjABVXSBcFpPZcpLnkmuuIIOYHu97x83YzhyL0WFAtnJJ2HP41FsqwOWMULon+O1tufOxscxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ua/QpZFS; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ua/QpZFS"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BbhXJc4Kk8mAkPS6Z+ldMvtEPzzQworR68rQFh2fNUo=;
	b=ua/QpZFSwO/963ISxGUPXC8kTZgQw1i+9+aO4yJdE4nLpGFq2dgdMmzMtWLh3IbRYesoWALKc
	IhEyi4l1w3FdHT/9RZJeOXFv9hwLB8MVz5vYrU3q3CiEemOXEl5OIl27SOd4mcFd/k5fCx/eVh0
	l48/fZXZRsMleRmiqnQhXVk=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gLnRY4jtqzcb4G;
	Thu, 21 May 2026 20:15:21 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id B470140571;
	Thu, 21 May 2026 20:22:57 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf100001.china.huawei.com
 (7.202.181.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 21 May
 2026 20:22:57 +0800
Message-ID: <88b19c68-2a0e-4a65-948c-9c535b75620a@huawei.com>
Date: Thu, 21 May 2026 20:22:56 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cpufreq: Fix typo in comment
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	Sumit Semwal <sumit.semwal@linaro.org>, <linux-kernel@vger.kernel.org>
References: <6fef156008fc6b70069f3cfedb7de02fe54f2696.1779360823.git.viresh.kumar@linaro.org>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <6fef156008fc6b70069f3cfedb7de02fe54f2696.1779360823.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100001.china.huawei.com (7.202.181.215)

On 5/21/2026 7:39 PM, Viresh Kumar wrote:
> Replace "diver" with "driver" in the comment describing
> CPUFREQ_NEED_UPDATE_LIMITS.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/linux/cpufreq.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 2ab691828e48..4d4b4ed24b30 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -434,7 +434,7 @@ struct cpufreq_driver {
>  /*
>   * Set by drivers that need to update internal upper and lower boundaries along
>   * with the target frequency and so the core and governors should also invoke
> - * the diver if the target frequency does not change, but the policy min or max
> + * the driver if the target frequency does not change, but the policy min or max
>   * may have changed.
>   */
>  #define CPUFREQ_NEED_UPDATE_LIMITS		BIT(0)

For all three patches:

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>

Thanks for always doing things so fast.

