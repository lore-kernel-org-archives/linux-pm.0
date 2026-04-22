Received: from mail.semaphore.gr (mail.semaphore.gr [91.99.171.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B003A7826;
	Wed, 22 Apr 2026 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.99.171.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776845694; cv=none; b=lxpL4htvwllzvzrDWk94KB/MMhmg2g/rETTEGbDJ2Fo21TfU9YiH0zH5qXjmoq+iseeQhITVzmEoIKUqpBPdBSlO+TdolA4BnlbSubuPu/CkDSeBv0IpGcl1P1bYUldufBTOHk6B9VfHMA60Ng3yb4QcVqyxxjPO9p7+2gQXDjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776845694; c=relaxed/simple;
	bh=Q4QGZg4z2h8XMijTOZpE+njeh4ue7cYGAagW5I3Rwbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8tGoVgePub0NtvHBmjQsjzNftLlYpGORIuuWZ7WhLmVHq8SYJoYgNilJfS1MCs2PuYpa+xscyQzfK09kT9jYRbt7+zyerMGA+wacNbVT5jeDrfQ1c1+pdM26TIGsJHTIenwX/idWCHBWrRYOnDZogiohxXYiD6YW+IOo9cyRok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semaphore.gr; spf=pass smtp.mailfrom=semaphore.gr; dkim=pass (2048-bit key) header.d=semaphore.gr header.i=@semaphore.gr header.b=gbGI7n6U; dkim=pass (2048-bit key) header.d=semaphore.gr header.i=@semaphore.gr header.b=gbGI7n6U; arc=none smtp.client-ip=91.99.171.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semaphore.gr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semaphore.gr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semaphore.gr header.i=@semaphore.gr header.b="gbGI7n6U";
	dkim=pass (2048-bit key) header.d=semaphore.gr header.i=@semaphore.gr header.b="gbGI7n6U"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=semaphore.gr;
	s=default; t=1776845191;
	bh=Q4QGZg4z2h8XMijTOZpE+njeh4ue7cYGAagW5I3Rwbs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gbGI7n6UyAry2dlCMrkJ2XvvkmqoyQupsjRFZ7MGDJDfypTZ0607G7DTu0EtFIrg9
	 G8e9IWOMsPawmRS2qNdPjVb5LaPUYqRbPD9CPFpQ9Bg69J+tS6GuF3qw59FF9QxwLy
	 lumCpFfiywlJLn3yE978niMZrSBcnKvpxMPhdwjdY18QNdwX4Qq5ZJllT8DJPGKmkB
	 HtW1x9q8HkchEFY6E7kBzY59VXHxf4+37QuvDKbd7WjmmS1JKhOscRRb3s/mRpV30D
	 7D5F4D+OQX78HET5yNCyf4pNdNtLd5F6sj1Q4Hlw6xK++sT8bQjvNyd7gZE5sXJIL1
	 TG0MHDgnuYK8w==
Received: from localhost (localhost [127.0.0.1])
	by mail.semaphore.gr (Postfix) with ESMTP id 741463E6FD;
	Wed, 22 Apr 2026 08:06:31 +0000 (UTC)
X-Virus-Scanned: Debian amavis at semaphore.gr
Received: from mail.semaphore.gr ([127.0.0.1])
 by localhost (sema.semaphore.gr [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RkT7wlywZYV1; Wed, 22 Apr 2026 08:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=semaphore.gr;
	s=default; t=1776845191;
	bh=Q4QGZg4z2h8XMijTOZpE+njeh4ue7cYGAagW5I3Rwbs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gbGI7n6UyAry2dlCMrkJ2XvvkmqoyQupsjRFZ7MGDJDfypTZ0607G7DTu0EtFIrg9
	 G8e9IWOMsPawmRS2qNdPjVb5LaPUYqRbPD9CPFpQ9Bg69J+tS6GuF3qw59FF9QxwLy
	 lumCpFfiywlJLn3yE978niMZrSBcnKvpxMPhdwjdY18QNdwX4Qq5ZJllT8DJPGKmkB
	 HtW1x9q8HkchEFY6E7kBzY59VXHxf4+37QuvDKbd7WjmmS1JKhOscRRb3s/mRpV30D
	 7D5F4D+OQX78HET5yNCyf4pNdNtLd5F6sj1Q4Hlw6xK++sT8bQjvNyd7gZE5sXJIL1
	 TG0MHDgnuYK8w==
Received: from [192.168.31.205] (unknown [188.117.229.165])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.semaphore.gr (Postfix) with ESMTPSA id 9A81E3E618;
	Wed, 22 Apr 2026 08:06:30 +0000 (UTC)
Message-ID: <2ca5b929-979e-4955-86a1-1987a9fee9c5@semaphore.gr>
Date: Wed, 22 Apr 2026 11:06:29 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: conservative: Fix incorrect frequency decrease
 due to stale target
To: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com,
 yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com,
 linhongye@h-partners.com
References: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Stratos Karafotis <stratosk@semaphore.gr>
In-Reply-To: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all!

I was struggling to see your point, but I think you are right.

The requested_freq could be equal to policy->min (due to idle periods)
while the dbs_info->requested_freq could be greater than policy->min.
So, in this case it breaks out early without the chance to further 
reduce the frequency, correct?

Stratos Karafotis

On 4/21/26 15:35, Lifeng Zheng wrote:
> In cs_dbs_update(), the requested frequency is decremented by one freq_step
> for each idle period. However, this can cause divergence between
> 'requested_freq' (target for current update) and 'dbs_info->requested_freq'
> (target from previous update).
> 
> When the load crosses up_threshold or down_threshold, the decision on
> whether to increase or decrease frequency should be based on the *previous*
> target (dbs_info->requested_freq), not the current one. Otherwise, the
> update step may be skipped entirely if the current target has already hit a
> boundary due to prior adjustments.
> 
> Ensure that frequency scaling decisions are made using the correct
> historical target, fixing cases where frequency fails to decrease despite
> sustained idle periods.
> 
> Fixes: 00bfe05889e9 ("cpufreq: conservative: Decrease frequency faster for deferred updates")
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>   drivers/cpufreq/cpufreq_conservative.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index df01d33993d8..f3c3b54e4bf8 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -104,7 +104,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>   		dbs_info->down_skip = 0;
>   
>   		/* if we are already at full speed then break out early */
> -		if (requested_freq == policy->max)
> +		if (dbs_info->requested_freq == policy->max)
>   			goto out;
>   
>   		requested_freq += freq_step;
> @@ -127,7 +127,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>   		/*
>   		 * if we cannot reduce the frequency anymore, break out early
>   		 */
> -		if (requested_freq == policy->min)
> +		if (dbs_info->requested_freq == policy->min)
>   			goto out;
>   
>   		if (requested_freq > freq_step)

