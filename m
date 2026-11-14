Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665807;
	b=vtCWcBUJRiM7uCSJKzBkOMZOdY3CS5aaIVnGU2HK0OG2PFUOfa6D+eus8ugv3kYgKqS5
	 wJe0HEWdqRhbSrNCkg90/1mhrNlz9jf+5Nt1sswIs7YHo3T85zwGA/DBHli6Efelc/KSQ
	 IgVT6iynOfP1I0nJsqOR2fBUKiCnLj1uaIyZxi2mRnbGIAXsNcophtzermdBziywISTNq
	 i/2ggHlyZbiZzS1WmPWKvQqekY255RsRpgtpWC05iwrPTk1gcRm7mLiJuu01xwKioU9mg
	 CZCC+ynrvEhBIYolVDtEAabzLNbM4YxUDOxPoYrEwWJvkkswZy48d1asUf/+nZ9gBxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Rsh3PSgy5EeLZfkj2Ume/HSuLoP9g7O08oXc9D5ZzEE=;
	b=GwNPcIGX7OkD57SVOcmfXQAbhIuTCZOrrRVm9aedZclAHqzC2Shct8mqSiyDgXlqGFVZ
	 ELoT4mGMvy01RuJ6Jh0em0JW3uUl1avlo5L9BMwOXvUyXBohaHTu38safSV+F1Zu9hLBU
	 IolTUnpVX59qkA12gvr3+YBh9ZWq0KjusXAjSHrR5DrhM9rrZFYZq1r+6neIEF3xPQbcJ
	 8rCOUeUlGdLfcL6CMxE5x7i0tBvR4Jp66VLGZQ2SxY/kkQnJveWCdTfmOcjdXsiaqrUJO
	 3ibroIyRBQH6rGh7HinyJXEzBQmX8H9iiJXH5MtSoMzSZqYe3ErQYENTD3DcCBlRH6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0c5nFMdk;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2155606A323
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 14:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2155606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0c5nFMdk
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso878695a91.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 06:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794665806; x=1795270606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rsh3PSgy5EeLZfkj2Ume/HSuLoP9g7O08oXc9D5ZzEE=;
        b=0c5nFMdk+yWbf+C71VnSAz6BsODM7dxwkDZmx2JZm5IkItwZpYWzZfIvg6VsN8404b
         HTmIIYJuqYP2sCa26kYtaDGmw6/fSO7ma0s4eNBzdDrUw3NI2mgBJn6HxyZACOODKRbJ
         bBZJb8UzWt3pXG97XUG3hFsbegZjKtfiU5HgKEYcOGj1LdurgttVu+PCFtUoacel/GXa
         zKWYHFe572C1e/q2OkehmmkkAFBLAmY6X/Qu0lQGzE+2FU6SrMxsAsjFV+jPxQNxVGMJ
         kxtKQovgbBec4A8Y6J4uilYZFLQB1yzzBSyO3jfoToPvImCHJOga22LziUdcDaYNuwu1
         5aCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794665806; x=1795270606;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rsh3PSgy5EeLZfkj2Ume/HSuLoP9g7O08oXc9D5ZzEE=;
        b=WBef2lsGAhtjr0qjCnjO0J01ccm4Ibdb6+cde1xA36G1naRWzKu6keYnXsF9gsqY9h
         XPmQ6HBs5u/WI0yODfrjWXAcntObStIMrg+cP/Geu1rzZDnlSlV6oIedXaoD1CtR9sVK
         yh5eor1YJ2MZbdYmcqlbAqI1fbTl10OD/yJmKKApQNrktrgF7aMvdK12OT5EUqDDcdk3
         Kk3gaW0b76MpHUWqID17YiWTchDycZ1SFsMtm9Cd5c6/Rxd4g17gH/1pGgr0myRo8pqd
         KbDjxViZIg8efhhiMRplRUr2tN6CP1ZGHRZpuS1vLtRUtFIJP4EBD0Zxp36UcLiK3f14
         KBxw==
X-Forwarded-Encrypted: i=1; AL+hErFcytIGD0miR4vI6MjLTQEwuioynjNmRbnj3zLQQu6Ff2bWkDrnRYW2i9lxRbPCA7IblkIm5rN5Ww==@vger.kernel.org
X-Gm-Message-State: APuU4Z8TXfHKInOyY4cw3iTZIlroMcHhbbP5W8vj+9idp6XpcXkIuJAd
	dXUYiuh4KJlfC/Jx/gXT5a2Ex91fGYGUqi0gBBHmFeVHj+LuP+45cuSI
X-Gm-Gg: AYBFou2dPPOwZ7wv4CvU/f18Y5iB4zJfkhyGpsQtlWKjE/hSjbg/erBtJau6gBh1PXJ
	XhHnvWmT7Jhl5VMrE7IZwdfydiHgkdH15mXH1+iXvsTCpO1YzxVRpBpY0yyAtoTNeHXBDic+6c1
	REC9PjYkLkJIHGe/IEUa/I40eeGI7b/UQHtLKGoVDueoMMUy+8TOL3uB2msAFlWhf1iNYCHRRW1
	8p+o2g6Id3LXTq/0ry7CaYtSumjYnrVFknisHPpTDR6BWdFnOYAQcec/2lplYKj4Ybg5uj7mr3R
	Fv+dZSFoIUno5KB8lS7LjL2c4A6pd+L1MKNqVDUw1oQhpcvmc25oAJR0SFGOilip1hFRenDq63a
	PMXUkcb+PSF52Iw8uWHJdyvPTGamCuDyGzjg4RWP010LeJZFXYWXEyHq/gxxuxXXXIt6OySjDds
	ikMRSBi90fCpAS8j3dmt9K/e7j37D/drRIWdHkDof0qZjdBiBlh3/m21omv1WYwLT4Mdnsj+Wp6
	8BtViaqf5b+/KBOoO2qDoilDz00Zc65Mky6nakxexUpICg5VOtEkRg/sShJTNKu+OaIjEjjZCsb
	LJwx9SQeJlgkbeuxZw8E4SWBbORhjVHwh/wzHrwX9jFD+XvR0YzOwBjy8Xr7oGDkn2w=
X-Received: by 2002:a17:90b:440b:b0:3ac:adce:60a8 with SMTP id 98e67ed59e1d1-3b1b07ef8bbmr5367145a91.5.1794665805884;
        Sat, 14 Nov 2026 06:16:45 -0800 (PST)
Received: from [192.168.35.40] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b245f0c3sm4377768a91.0.2026.11.14.06.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 06:16:45 -0800 (PST)
Message-ID: <94a65d65-e81f-4942-b119-51b71e8eabb4@gmail.com>
Date: Sat, 14 Nov 2026 23:16:41 +0900
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
Subject: Re: [PATCH v2] PM / devfreq: governor_userspace: Guard against NULL
 governor_data during switch
Content-Language: ko
To: Finley Xiao <finley.xiao@rock-chips.com>, heiko@sntech.de,
 linux-pm@vger.kernel.org
Cc: cw00.choi@samsung.com, myungjoo.ham@samsung.com, kant@allwinnertech.com,
 kyungmin.park@samsung.com, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, tony.xie@rock-chips.com,
 huangtao@rock-chips.com, stable@vger.kernel.org
References: <20261022022109.642339-1-finley.xiao@rock-chips.com>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20261022022109.642339-1-finley.xiao@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/22/2026 11:21 AM, Finley Xiao wrote:
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
> Fixes: 5fdded844892 ("PM/devfreq: governor: Add a private governor_data for governor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> 
> Link: https://lore.kernel.org/linux-pm/20260723080806.1451-1-finley.xiao@rock-chips.com/
> ---
> Changes in v2:
> - Add Fixes: tag and Cc: stable@vger.kernel.org
> 
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
>  }
>  
>  static int devfreq_userspace_handler(struct devfreq *devfreq,

Hi,

Looks good to me.

I think that it is needed to lock  on usrespace_init.

diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index f7a485c43fd7..cfbd72892598 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -94,7 +94,9 @@ static int userspace_init(struct devfreq *devfreq)
 		goto out;
 	}
 	data->valid = false;
+	mutex_lock(&devfreq->lock);
 	devfreq->governor_data = data;
+	mutex_unlock(&devfreq->lock);
 
 	err = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
 out:

