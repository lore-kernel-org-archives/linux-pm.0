Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150853A16BE;
	Tue, 31 Mar 2026 07:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941693; cv=none; b=LAoS8OIuv2tkjXDw9Hn2bar/g9iyFq4f8NWUxEs64b+OJ3lZ63DOTDepdr/uULHmg4NaXTEd/86Q+sNE8MaqGk819en/f/KmQsHMDE4UIG1XIr7fs6WO2RBoH64u8PhwfqHTnrKsfgdo0ruWMSaC+oPk55neMcUIohdEzpPooSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941693; c=relaxed/simple;
	bh=dvqTyph6b8G+W8CHdo5hfmvbmwhG8H2t8g/2wLtI5M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f1mLS4JwPxM2m8DPc0vdLHfQ+MCbdKf8HM3B5iOgWwBfvjk0ir/tIyhgaN6PE7wc1oYOT5RDkNjgkGpr3djVv/AtKsmj7JCqrrDPYOzkxhEvQXZlJo7XxkUeQC4Su34Tj3CWQ7P+dqvqPgPkXRAdNJEA7cF2h4yL7Lo9/8PcEeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4flKBy0QcXz1K9W2;
	Tue, 31 Mar 2026 15:15:22 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id E59DF402AB;
	Tue, 31 Mar 2026 15:21:28 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 31 Mar
 2026 15:21:28 +0800
Message-ID: <9f58b042-d420-4e9b-a26b-b95bc6e11fac@hisilicon.com>
Date: Tue, 31 Mar 2026 15:21:27 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 4/4] PM / devfreq: Optimize error return value of
 governor_show()
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>, <nm@ti.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260319091409.998397-1-tianyaxiong@kylinos.cn>
 <20260319091719.1007244-1-tianyaxiong@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260319091719.1007244-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 3/19/2026 5:17 PM, Yaxiong Tian wrote:
> When df->governor is NULL, governor_show() returns -EINVAL, which
> confuses users.
> 
> To fix this issue, return -ENOENT to indicate that no governor is
> currently set for the device.
> 
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 4a312f3c2421..7cc60711fafd 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1412,7 +1412,7 @@ static ssize_t governor_show(struct device *dev,
>  	struct devfreq *df = to_devfreq(dev);
>  
>  	if (!df->governor)
> -		return -EINVAL;
> +		return -ENOENT;
What about -ENODEV?
>  
>  	return sprintf(buf, "%s\n", df->governor->name);
>  }
