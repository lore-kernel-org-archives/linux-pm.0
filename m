Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F702C3255;
	Tue, 28 Jul 2026 03:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207994; cv=none; b=ENAVMlU/h3K2Op2kkhg8GMiLy1/VHaOmzl0UnATvYYMeMubU0k9Q+K6V5SLD5fDk6JUaDjulQFXhMwR2zav2e+lz4tEIqMAdBhB5WoTNG8oKg9+KUOdesxfoZy/Ju0N6A7svN84HeuioRg0e7p0WUGUsaZ5jGq2qJejQLWEX+D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207994; c=relaxed/simple;
	bh=BUIslYAPA2K6CKq4j0CEiejAnj5vY8yhOwu5INtAYtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CUuC5tNyV/vgDksEn16Wencs7/ekXYcxiKuR1obrat2ndRmw/KACSZ2wKCZLwOd9PnASiZW6vj7+G/n9TS7Y54LnrxKeQc2QLnqhVWeX0PTnsaPd5cYZ40kisI2HpvnfABmLuS8GZ1dnFy5p7JAS/InoqiihgzKMv48CKLWUikw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4h8Kqy1r7gzRhWS;
	Tue, 28 Jul 2026 10:57:02 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D622202E6;
	Tue, 28 Jul 2026 11:06:27 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Jul
 2026 11:06:26 +0800
Message-ID: <4e1b7360-4ab9-4c50-b4b9-61a44707068a@hisilicon.com>
Date: Tue, 28 Jul 2026 11:06:25 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM / devfreq: governor_userspace: Guard against NULL
 governor_data during switch
To: Finley Xiao <finley.xiao@rock-chips.com>, <heiko@sntech.de>,
	<myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<cw00.choi@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260723080806.1451-1-finley.xiao@rock-chips.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260723080806.1451-1-finley.xiao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200017.china.huawei.com (7.202.181.10)


Hi Finley,

On 7/23/2026 4:08 PM, Finley Xiao wrote:
> The userspace governor is the only one that uses devfreq->governor_data,
> allocated in its DEVFREQ_GOV_START handler (userspace_init()) and freed
> in its DEVFREQ_GOV_STOP handler (userspace_exit()).
> 
> When switching governors via sysfs (governor_store in devfreq.c), the
> sequence is:
> 
> STOP(old) -> df->governor = userspace -> START(userspace) -> userspace_init
> 
> Between the df->governor assignment and userspace_init() completing,
> governor_data is still NULL (the previous governor never touched it,
> and the core does not clear or pre-allocate it). During that window,
> asynchronous paths that call update_devfreq() outside of the driver's
> control -- the OPP notifier (devfreq.c:686) and the pm_qos notifier
> (devfreq.c:707) -- run devfreq_update_target() under df->lock and reach
> devfreq_userspace_func(), which dereferences governor_data without a
> NULL check, causing:
> 
>   Unable to handle kernel access to user memory outside uaccess routines
>   pc : devfreq_userspace_func+0xc/0x28
>   lr : devfreq_update_target+0x58/0x158
> 
> Add a NULL check in devfreq_userspace_func() and fall back to
> previous_freq, which is the same behaviour as the existing "no user
> frequency specified yet" branch. This closes the race for all callers
> since every path ultimately goes through get_target_freq.
> 
> Additionally, take devfreq->lock around the kfree()/NULL assignment in
> userspace_exit(). Without it, a concurrent OPP/pm_qos notifier running
> under devfreq->lock could read governor_data after it is freed but
> before it is set to NULL, constituting a use-after-free.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---
>  drivers/devfreq/governor_userspace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index 3906ebedbae8..f7a485c43fd7 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -24,7 +24,7 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
>  {
>  	struct userspace_data *data = df->governor_data;
>  
> -	if (data->valid)
> +	if (data && data->valid)
This one is fine.
>  		*freq = data->user_frequency;
>  	else
>  		*freq = df->previous_freq; /* No user freq specified yet */
> @@ -110,8 +110,10 @@ static void userspace_exit(struct devfreq *devfreq)
>  	if (devfreq->dev.kobj.sd)
>  		sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
>  
> +	mutex_lock(&devfreq->lock);
>  	kfree(devfreq->governor_data);
>  	devfreq->governor_data = NULL;
> +	mutex_unlock(&devfreq->lock);
However, for this one, I'm not sure it's the proper place to add the lock.

Why should we allow the whole governor switching to be concurrent with
frequency switching?  I guess there might be something wrong elsewhere.
The devfreq->lock should be held around governor switching.
Can you have a try?  but be careful of deadlock because the governor
switching currently holds devfreq_list_lock.

Thanks!
Jie
>  }
>  
>  static int devfreq_userspace_handler(struct devfreq *devfreq,
