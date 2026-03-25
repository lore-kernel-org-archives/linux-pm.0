Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF4C3A6EF3;
	Wed, 25 Mar 2026 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433219; cv=none; b=KIBRYSHIxN2H+bCNK63BypOtOSatcq6X055XWQRrKFNm7ODpGFOIEC2mURhWPLQY67LDbBNH4jyJaSJR/6MZlaROwmPpzsjrGH8mskuDVQ5LNHuYw03mVT8nFTokteMSn2hxFYJAkuyG/nOiwYGQheGZsdn49dYHGzdpwvc9uz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433219; c=relaxed/simple;
	bh=LzQDw8mxolLXPgUwLtV03W/iuQKWPmw4950vTTvZi/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dVtrkbqDygNzgTWyp6XcZAmHpazomJC6rUvwjrhzqn4nMQlyZoEjh4lL/FAGcNy1wpY3jlsY8FIyVnwp8ouZAMt9OLeq4kkqQfhE2cOXH/39P+ZYaF2tk7kMA/AuHGTPhM9DIQGiSZenqoT4m2SC1GnTvQfUb71ppRMydyxNg4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fgj8Z2QXdzcb4W;
	Wed, 25 Mar 2026 18:00:46 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 365AF40569;
	Wed, 25 Mar 2026 18:06:38 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Mar
 2026 18:06:37 +0800
Message-ID: <80d8f3d3-578f-4c80-93c3-e24755c29027@hisilicon.com>
Date: Wed, 25 Mar 2026 18:06:36 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/4] Fix some errors in the devfreq core layer when
 governor is NULL
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>, <nm@ti.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260319091409.998397-1-tianyaxiong@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260319091409.998397-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 3/19/2026 5:14 PM, Yaxiong Tian wrote:
> While doing some development work with devfreq_add_governor()/
> devfreq_remove_governor(), I discovered several bugs caused when
> devfreq->governor is NULL. Specifically:
> 
> 1) A possible null pointer issue in devfreq_add_governor(), caused
> by devfreq_remove_governor() setting devfreq->governor to NULL in
> certain situations, while devfreq_add_governor() lacks corresponding
> checks for devfreq->governor.
> 
> 2) When operating on governor and available_governors under /sys,
> there are also some unexpected errors.
> 
> See the following patches for details.
Hi Yaxiong,

Sorry for catching this late.

I happen to be working on the same issues recently on a local tree, though
delayed for quite a while due to other business.

It would be a totally different approach by reworking the locking logic,
which, I supposed, can make the devfreq framework cleaner to maintain.

I'll send it out shortly.  Hopefully it can be a reference for us to
discuss with.

Thanks!
Jie
> 
> Yaxiong Tian (4):
>   PM / devfreq: Fix possible null pointer issue in
>     devfreq_add_governor()
>   PM / devfreq: Fix available_governors_show() when no governor is set
>   PM / devfreq: Fix governor_store() failing when device has no current
>     governor
>   PM / devfreq: Optimize error return value of governor_show()
> 
>  drivers/devfreq/devfreq.c | 46 +++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 21 deletions(-)
> 
