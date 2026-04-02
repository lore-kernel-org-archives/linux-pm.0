Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8559619D08F;
	Thu,  2 Apr 2026 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775100121; cv=none; b=q/WYdKmJ1DLv9Khca6mTAwyZ78aDnwGxyqK5YftY1UPVpr4Xq9ubCZLLzFNegvsEBaVyjrOAgW5ECGt2X/I9GAYS9beAOc+vyCdqfeAORBs0p336DNMpADnyUdt6jy0eczcxGNhdpWH6CheE2tDvCybmCekuu0T4nyZltnwUfKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775100121; c=relaxed/simple;
	bh=V6eaP9tA8tiy9EemeBCUfvIzgn7DJu4eHflYc2QC+Xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uV3dutIeQR9EN+D2luZj8qw+hs2Qt1jS8coDFyr+x5MGsd8BXNFY6pJ3AfkTpGRtkaj19DDNqDE4CIvqCXhN45WXyYpTECzqjDoY917KkpNfv56RMftkJ19ZuAcIwroBI6QqOCwW5KokKQEkbVYKwN5t+xkVqUL1Bfik6l7kE+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fmRnV6JJBz1prLN;
	Thu,  2 Apr 2026 11:15:42 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id EADBA4056E;
	Thu,  2 Apr 2026 11:21:55 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Apr
 2026 11:21:55 +0800
Message-ID: <a9edebc1-6a28-4ab3-8016-793c585da9c4@hisilicon.com>
Date: Thu, 2 Apr 2026 11:21:54 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] PM / devfreq: Fix governor_store() failing when
 device has no current governor
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>, <nm@ti.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260401032838.66168-1-tianyaxiong@kylinos.cn>
 <20260401033119.67821-1-tianyaxiong@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260401033119.67821-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 4/1/2026 11:31 AM, Yaxiong Tian wrote:
> Since devfreq_remove_governor() may clear the device's current governor
> in certain situations, while governors actually exist independently
> of the device, directly returning EINVAL in this case is inaccurate.
> 
> To fix this issue, remove this check and add relevant logic for when
> df->governor is NULL.
> 
> Fixes: 483d557ee9a3 ("PM / devfreq: Clean up the devfreq instance name in sysfs attr")
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>  drivers/devfreq/devfreq.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 2977b07be939..975f82d7a9d1 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1390,9 +1390,6 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	char str_governor[DEVFREQ_NAME_LEN + 1];
>  	const struct devfreq_governor *governor, *prev_governor;
>  
> -	if (!df->governor)
> -		return -EINVAL;
> -
>  	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>  	if (ret != 1)
>  		return -EINVAL;
> @@ -1403,6 +1400,20 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  		ret = PTR_ERR(governor);
>  		goto out;
>  	}
> +
> +	if (!df->governor) {
> +		df->governor = governor;
> +		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
> +		if (ret) {
> +			dev_warn(dev, "%s: Governor %s not started(%d)\n",
> +				__func__, df->governor->name, ret);
> +			df->governor = NULL;
> +		} else {
> +			ret = sysfs_update_group(&df->dev.kobj, &gov_attr_group);
> +		}
> +		goto out;
> +	}
> +
>  	if (df->governor == governor) {
>  		ret = 0;
>  		goto out;
Hi Yaxiong,

I'd suggest something like this, such that the main body of the function is
not changed.

Note that this is just an example. Not tested or carefully checked.

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2977b07be939..aa0f1db3225c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1390,9 +1390,6 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
        char str_governor[DEVFREQ_NAME_LEN + 1];
        const struct devfreq_governor *governor, *prev_governor;

-       if (!df->governor)
-               return -EINVAL;
-
        ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
        if (ret != 1)
                return -EINVAL;
@@ -1403,6 +1400,10 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
                ret = PTR_ERR(governor);
                goto out;
        }
+
+       if (!df->governor)
+               goto skip_stop;
+
        if (df->governor == governor) {
                ret = 0;
                goto out;
@@ -1423,6 +1424,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
                goto out;
        }

+skip_stop:
        /*
         * Start the new governor and create the specific sysfs files
         * which depend on the new governor.
@@ -1435,6 +1437,8 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
                         __func__, df->governor->name, ret);

                /* Restore previous governor */
+               if (!prev_governor)
+                       goto out;
                df->governor = prev_governor;
                ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
                if (ret) {

