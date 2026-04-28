Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CB113FEE;
	Tue, 28 Apr 2026 02:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777344650; cv=none; b=Bm4yQbYhqRL3lnGYw/85Rlw3rAkNyfZT9f/gE9D/k5STO9+l3HYIn0hief71L7kbJs/6+vfDEcqG6jW9LCiAHVGq27xoiBCDOG3u8jib2Y1B9+lc+AhKDWh3lzjJOcHQDNm7KCGe90eKovrfxcaI0yaDEpJ6UM4j3ZMVYEAqffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777344650; c=relaxed/simple;
	bh=zexroanumtaN0C7bYm3ToQDfgJPaLWHjJ75nkm1wraw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iyhL+1ZgULB3Rgim+zAFP+1bdp2lpy8yC58BAadmPeEcQfyoktAJZxo9T6eFyVnSQZDgPNr0hIHwXlx4TxGGMyV7QtOR3CKlnl5joNh//burdVa9/IndpvkMFnSH6HgbupMwTXAxcuIY3w+dW0QAYXOrL6RkbGW7WCqorT7Sv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4g4PsQ6zPYz1T4Gh;
	Tue, 28 Apr 2026 10:44:26 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A58E20333;
	Tue, 28 Apr 2026 10:50:45 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Apr
 2026 10:50:45 +0800
Message-ID: <27c3f3af-beee-422d-b96a-60472a16b0aa@hisilicon.com>
Date: Tue, 28 Apr 2026 10:50:44 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Fix some errors in the devfreq core layer when
 governor is NULL
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>, <nm@ti.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260401032838.66168-1-tianyaxiong@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260401032838.66168-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 4/1/2026 11:28 AM, Yaxiong Tian wrote:
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
> For issue 1, the solution is similar to Jie Zhan's PATCH.
> https://lore.kernel.org/linux-pm/20260326123428.800407-6-zhanjie9@hisilicon.com/
> 
> The original v1 approach actually changed the original logic, which is incorrect.
> 
> See the following patches for details.
> 
> change in v2:
> 1) rebase to  linux-next(20260326) /devfreq-next 
> 2) remove some code to fix null pointer in patch1
> 3) add  sysfs_update_group() in patch2
> 
> 
> Yaxiong Tian (4):
>   PM / devfreq: Fix possible null pointer issue in
>     devfreq_add_governor()
>   PM / devfreq: Fix available_governors_show() when no governor is set
>   PM / devfreq: Fix governor_store() failing when device has no current
>     governor
>   PM / devfreq: Optimize error return value of governor_show()
> 
>  drivers/devfreq/devfreq.c | 57 +++++++++++----------------------------
>  1 file changed, 16 insertions(+), 41 deletions(-)
> 

Hi Yaxiong,

Any plan for updating this in the 7.1 cycle?

Jie
