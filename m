Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49C63921DB;
	Thu, 30 Jul 2026 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415891; cv=none; b=YJWImNGQotJ2rbf+EVKbd01XzcXeFeW3y65QGMTlpouahEB//f50p/CncTqUCneCSbuqc9Yk99EZuzOyCckvgr2oqzlpnY1GByy0eysc6i3q1UJ164+19laL9buULMZCzZZz/PGbmawKAfcHZOl+G2kgnQhUcLQxW+KLE9F6qi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415891; c=relaxed/simple;
	bh=ztyly4hA58Bk56dQp/eNVxisjBefURqN0vRCcyUZvZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fi23z4jNgT21Fil7PQGSPSsJRu62O7MoAT7TQIm+FAl7ZceBw4KvKEQ014C3t1e61mkS1jCKoIxVjc9yFu00nIBtpDt2mbPzpvgtc6b8MJOXr9N2xUJ5B7AvfBCs2drjDl7s+LZSdEVyUth73ZdmrwKOpDqqCD1KW+UhR0mBCe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4h9pjj58CXz1K98V;
	Thu, 30 Jul 2026 20:41:45 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 357AB40586;
	Thu, 30 Jul 2026 20:51:12 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Jul
 2026 20:51:11 +0800
Message-ID: <dc2f03bc-037c-49ab-a34f-caf4dc4c4afa@hisilicon.com>
Date: Thu, 30 Jul 2026 20:51:10 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM / devfreq: userspace: Fix memory leak in
 userspace_init()
To: Malaya Kumar Rout <malayarout91@gmail.com>, <linux-pm@vger.kernel.org>,
	<myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<cw00.choi@samsung.com>, <kant@allwinnertech.com>
CC: <skhan@linuxfoundation.org>, <me@brighamcampbell.com>,
	<linux-kernel@vger.kernel.org>
References: <511c7f13-3344-44bf-a960-044fc2401789@hisilicon.com>
 <20260729133523.357383-1-malayarout91@gmail.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260729133523.357383-1-malayarout91@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 7/29/2026 9:35 PM, Malaya Kumar Rout wrote:
> Fix a memory leak in the userspace_init() function where allocated
> memory is not freed when sysfs_create_group() fails.
> 
> When sysfs_create_group() fails, the function returns without freeing
> the memory allocated for 'data', leading to a memory leak. This patch
> adds proper error handling to free the allocated memory and reset
> governor_data to NULL on failure.
> 
> v2:
> - Removed redundant 'out:' goto label and returned -ENOMEM directly
>   on allocation failure.
> 
> Fixes: 5fdded844892 ("PM/devfreq: governor: Add a private governor_data for governor")
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
Thanks. LGTM.
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/devfreq/governor_userspace.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index 3906ebedbae8..8211aadb81f0 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -89,15 +89,18 @@ static int userspace_init(struct devfreq *devfreq)
>  	int err = 0;
>  	struct userspace_data *data = kzalloc_obj(struct userspace_data);
>  
> -	if (!data) {
> -		err = -ENOMEM;
> -		goto out;
> -	}
> +	if (!data)
> +		return -ENOMEM;
> +
>  	data->valid = false;
>  	devfreq->governor_data = data;
>  
>  	err = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
> -out:
> +	if (err) {
> +		kfree(data);
> +		devfreq->governor_data = NULL;
> +	}
> +
>  	return err;
>  }
>  
