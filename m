Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCC2284B25;
	Tue, 31 Mar 2026 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941420; cv=none; b=tsmpQVvHAb7JDlJeekKpdrhR3VfqMmexgOgfD8uF4EXFkITeE2V6UQcgWQs4Hj1y3NHX/n0jBCTHv9ReRWwz2nQ60nXkYPQoNj53V36uBE+CyJ3H1Sl9jH9FkUeTnShvcSzFCj5+JhpxxsZhygbaYFXqKdz+EtjtWrwJ6noDCvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941420; c=relaxed/simple;
	bh=ee0V/ErYfztUw5p+oLc/QZwSSRR6umvaZTYk3k96UcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bx1gm/bX8dY2UPGCEc17CK6PNyzmEz2NWLFShoBGh4GNDI3y7zPbLUNN9t3HLPVlLemOIpwUXBR+vg+9FS7+RgbIa+Gzi7KN+z6yEzMkbGwdhDNy3nuQ8Sb7fBm+OUyyPEycKSKnNMsN3Aj8Fp9vNCCky5l6sqFLhcB1zwIz5GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from canpmsgout03.his.huawei.com (unknown [172.19.92.159])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4flKDL2LsZz1BG6r;
	Tue, 31 Mar 2026 15:16:34 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4flK5q3sVfzpSys;
	Tue, 31 Mar 2026 15:10:55 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id A0C9340561;
	Tue, 31 Mar 2026 15:16:41 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 31 Mar
 2026 15:16:41 +0800
Message-ID: <5ac69894-aa0d-475f-8950-a0ff98f9fa2e@hisilicon.com>
Date: Tue, 31 Mar 2026 15:16:40 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 3/4] PM / devfreq: Fix governor_store() failing
 when device has no current governor
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>, <nm@ti.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260319091409.998397-1-tianyaxiong@kylinos.cn>
 <20260319091710.1006814-1-tianyaxiong@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260319091710.1006814-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 3/19/2026 5:17 PM, Yaxiong Tian wrote:
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
>  drivers/devfreq/devfreq.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0bf320123e3a..4a312f3c2421 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1425,9 +1425,6 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	char str_governor[DEVFREQ_NAME_LEN + 1];
>  	const struct devfreq_governor *governor, *prev_governor;
>  
> -	if (!df->governor)
> -		return -EINVAL;
> -
>  	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>  	if (ret != 1)
>  		return -EINVAL;
> @@ -1438,6 +1435,18 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
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
> +		}
> +		goto out;
> +	}
> +
The sequence that starts the governor, and stops, and then re-starts looks
quite weird.
Can you do a NULL pointer check before the IMMUTABLE flag check and
stopping governor, rather than this?
>  	if (df->governor == governor) {
>  		ret = 0;
>  		goto out;
