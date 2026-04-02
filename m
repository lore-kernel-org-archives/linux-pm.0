Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E72630CDAE;
	Thu,  2 Apr 2026 03:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775101099; cv=none; b=oepeviJIYArIZnmdaz22K3kpiEDT/j82GESgo7w0KGoR91i24ndnz26xipHkOPxGwUW5LzZONYB9AuQ1NuDwaPVrvqhELcdqJ+7zAhv/hdS4kw6jc2gwgDHaNKGmDV21Dm99ccDq5pA8eP3gXMc+iapFTiBMQQt9ZXNeCLdLxI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775101099; c=relaxed/simple;
	bh=AzgXWgrPrY9STrDRxJ+zT8u4PTfxAZRNOgvK2g3dwtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WEsNafvWRMDs4U9yARjgvH+4CCjjXoeYDWz5PGgd2S6oDMXGlRU8DWGurKes70KeQvfAZBb6fXauBtDR0a1gYTpqKC9jtyrhIy2TjA+6R6ik1avDP2HJvZ8TQxC/ZunFUmbpdml2x1DfljmwgaKzqpacEe6cCuw93Xv4CgQ4z5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from canpmsgout03.his.huawei.com (unknown [172.19.92.159])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fmSH65yD5z1BG1g;
	Thu,  2 Apr 2026 11:37:54 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fmS8g28fYzpTLL;
	Thu,  2 Apr 2026 11:32:19 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 979FB40538;
	Thu,  2 Apr 2026 11:38:08 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Apr
 2026 11:38:07 +0800
Message-ID: <7fddbd0f-0d17-4e4b-925d-155964ad45b3@hisilicon.com>
Date: Thu, 2 Apr 2026 11:38:07 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] PM / devfreq: Optimize error return value of
 governor_show()
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>, <nm@ti.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260401032838.66168-1-tianyaxiong@kylinos.cn>
 <20260401033128.67925-1-tianyaxiong@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260401033128.67925-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 4/1/2026 11:31 AM, Yaxiong Tian wrote:
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
> index 975f82d7a9d1..c40568d2a4dc 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1377,7 +1377,7 @@ static ssize_t governor_show(struct device *dev,
>  	struct devfreq *df = to_devfreq(dev);
>  
>  	if (!df->governor)
> -		return -EINVAL;
> +		return -ENOENT;
Hi Yaxiong,

Usually we don't change sysfs error code because that might break userspace
if it depends on this to do some specific handling (although it shouldn't
do so!)

Besides that, from a user-friendliness point of view, I'd still prefer
ENODEV.

A user terminal is supposed to get "No such file" on -ENOENT and "No such
device" on -ENODEV.

I guess the latter is more meaningful since 'device' can mean 'object'?
"No such file" is a bit confusing because the sysfs file or entry is
clearly there.

Thanks,
Jie
>  
>  	return sprintf(buf, "%s\n", df->governor->name);
>  }
