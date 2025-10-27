Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FCA2C08D4;
	Mon, 27 Oct 2025 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761532117; cv=none; b=IzPoTpACX+noK4wPelzeI199nIfWGwW+/V6qJWY3z11VM7slAmleAIqVcEIkAxghSnNSGqtn81rGzuV+c9F88GkRmoB5vigzmxTDKohpRzyjDIwuR5mssGdOI+oDT1tyKfZNTm+1W0H30+NkzwfR3v9Gir42L/g19zIZKJiBCGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761532117; c=relaxed/simple;
	bh=u83twR9OiwbSgnrLOPsQ/qeevQIpIACX0JjFu5egPMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AFcxlzn6CsvRTMKPYPP6CKJnPriB5TWOI1i/sxNCzSWZ0byPkyVjSgNmZYpg3a1pnBDAcfPyfKTL/9r9EAbw9x5IeVxCbTHmv7PNYYFAZeqEYrq2jKotM6E8EyZvDq8oTYe7MEWx35uVFq4cEKw2DVEEkAejt+qZ/vn+xL5tTCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RkSX6cAE; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RkSX6cAE"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=X3q1pkIg21024rAyEiQr9DMPlEj5XAufmPzfN6iNKK8=;
	b=RkSX6cAEuq0u5M46qTxKLRPIUptWGjUloHkAgCoYcBtwrh7MMoNwqzfmbg79Qh8OxdZa4wPmL
	yel6iaZzJ8tQN3n5asReXoNylV1AziOxlyYCy6npJHF8HnPu8SIEF+OS0CG6lcORffQr9wO+9Hg
	bjK0FT6cxDAgJQeklKMaJn8=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cvy8C54LNz1T4HL;
	Mon, 27 Oct 2025 10:27:23 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 655DF180B69;
	Mon, 27 Oct 2025 10:28:24 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 27 Oct
 2025 10:28:23 +0800
Message-ID: <651ffa3f-9098-4d00-877b-d22e3e8cd64a@huawei.com>
Date: Mon, 27 Oct 2025 10:28:23 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM / devfreq: hisi: Fix potential UAF in OPP handling
To: <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>
References: <20250915062135.748653-1-zhangpengjie2@huawei.com>
From: "zhangpengjie (A)" <zhangpengjie2@huawei.com>
In-Reply-To: <20250915062135.748653-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr200004.china.huawei.com (7.202.195.241)

On 9/15/2025 2:21 PM, Pengjie Zhang wrote:
> Ensure all required data is acquired before calling dev_pm_opp_put(opp)
> to maintain correct resource acquisition and release order.
>
> Fixes: 7da2fdaaa1e6 ("PM / devfreq: Add HiSilicon uncore frequency scaling driver")
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
>   drivers/devfreq/hisi_uncore_freq.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/hisi_uncore_freq.c b/drivers/devfreq/hisi_uncore_freq.c
> index 96d1815059e3..c1ed70fa0a40 100644
> --- a/drivers/devfreq/hisi_uncore_freq.c
> +++ b/drivers/devfreq/hisi_uncore_freq.c
> @@ -265,10 +265,11 @@ static int hisi_uncore_target(struct device *dev, unsigned long *freq,
>   		dev_err(dev, "Failed to get opp for freq %lu hz\n", *freq);
>   		return PTR_ERR(opp);
>   	}
> -	dev_pm_opp_put(opp);
>   
>   	data = (u32)(dev_pm_opp_get_freq(opp) / HZ_PER_MHZ);
>   
> +	dev_pm_opp_put(opp);
> +
>   	return hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_SET_FREQ, &data);
>   }

Gentle ping on this reviewed patch. 🙂

Thanks!


