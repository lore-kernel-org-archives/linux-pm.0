Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6743B3BE3;
	Tue, 31 Mar 2026 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940894; cv=none; b=gXCIvJ+taLnfDcQWgMiWXiNA2NTVLJU4BbPYdETpaIZdCtuF7nCJo06ibaDLHbtrcHKjooPbaBtcWSfKf0wiTFp6xVGEHnrAjknDAINu8wZQfKbfJaQc7ccVEgvmSupBstZ/bxrZX5o+MI7pfI4EYhJwumvJA8T/qbLCfqFAjnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940894; c=relaxed/simple;
	bh=xC4JP8URHk9du6qDcbzn4tGOefK4XWS3yoqkgxHR1UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GEaTZzHua31jACbpxxqnaTHVBo5+BDJD/y6DVaQSgn5ANLP5Vhn4TWr6mkYE+ULs26MR9ehIvSTMObHxytSTK04us6bz1B4jLPkTTLznyJMioDdgs3NzNmjlGXCR4Nk5ziXd+unzb/Cv9xrDvFPxwq+P60rK3/NZ5NNUz7cLYe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4flJvR066Sz1K9VW;
	Tue, 31 Mar 2026 15:01:55 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id DB39240562;
	Tue, 31 Mar 2026 15:08:01 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 31 Mar
 2026 15:08:01 +0800
Message-ID: <baee47c8-7b29-42dd-a64a-167c19c4593b@hisilicon.com>
Date: Tue, 31 Mar 2026 15:08:00 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/4] PM / devfreq: Fix available_governors_show()
 when no governor is set
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>, <nm@ti.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260319091409.998397-1-tianyaxiong@kylinos.cn>
 <20260319091701.1006345-1-tianyaxiong@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260319091701.1006345-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 3/19/2026 5:17 PM, Yaxiong Tian wrote:
> Since devfreq_remove_governor() may clear the device's current governor
> in certain situations, while governors actually exist independently of
> the device, directly returning EINVAL in this case is inaccurate.
> 
> To fix this issue, remove this check and use df->governor for validity
> verification in the following code.
> 
> Fixes: 483d557ee9a3 ("PM / devfreq: Clean up the devfreq instance name in sysfs attr")
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
LGTM

Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/devfreq/devfreq.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 63ce6e25abe2..0bf320123e3a 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1504,16 +1504,13 @@ static ssize_t available_governors_show(struct device *d,
>  	struct devfreq *df = to_devfreq(d);
>  	ssize_t count = 0;
>  
> -	if (!df->governor)
> -		return -EINVAL;
> -
>  	mutex_lock(&devfreq_list_lock);
>  
>  	/*
>  	 * The devfreq with immutable governor (e.g., passive) shows
>  	 * only own governor.
>  	 */
> -	if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)) {
> +	if (df->governor && IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)) {
>  		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
>  				  "%s ", df->governor->name);
>  	/*
