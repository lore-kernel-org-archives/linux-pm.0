Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C900A3F105B
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901292; cv=none; b=U/0v8LwC1JfLjsEYQPJ7xdQYGtu4wxT+zXZyFGHgFjmHaIuhrL9Sv2lUgQcq0NB5HhAVYUmXqqB69wDxOm3tWmNzyE8D4smv2Y2YbWP6b19b5btxGU0rP9rD6Ugn13YE0oQcUaeHzsi8VUUNVHSIdbpwkZbPEcCtcITlJYjseog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901292; c=relaxed/simple;
	bh=kAZfWxx+z0SgWc8J/biv/5+yxYpYE0hkaDwyZi8Omi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JPvyJIA6xzXzdSHKjrBmoj3FAi3xhX03VxXSGpQf3SYj16hpo/9V73PO6pOIHaojOWMhlSpeYp2b9kptpgH1tnoQ0BZ13KLZaibUAyaG0Xk9NgAmdgo2/Fb1ozDeAhPzJUebZulWHQBoX94ptHu7NbLzYX599flETq4cshZo92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4j3x5y1tQjzRhRS;
	Tue, 13 Oct 2026 22:09:10 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 380DB40538;
	Tue, 13 Oct 2026 22:21:24 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 13 Oct
 2026 22:21:23 +0800
Message-ID: <07877e67-4cb0-4391-9d63-bbf73b40bee3@hisilicon.com>
Date: Tue, 13 Oct 2026 22:21:22 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] devfreq: Add refcounts for governor modules
To: <cwchoi00@gmail.com>, <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <linuxarm@huawei.com>, <tianyaxiong@kylinos.cn>,
	<zhenglifeng1@huawei.com>, <zhangpengjie2@huawei.com>,
	<lihuisong@huawei.com>, <prime.zeng@hisilicon.com>
References: <20260729102348.3857779-1-zhanjie9@hisilicon.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260729102348.3857779-1-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200017.china.huawei.com (7.202.181.10)

Hi Chanwoo,

Can we get some feedback on this series to move things forward?

Thanks!
Jie

On 7/29/2026 6:23 PM, Jie Zhan wrote:
> A governor module can be dynamically inserted or removed if compiled as a
> kernel module.  'devfreq->governor' would become NULL if the governor
> module is removed when it's in use.
> 
> For user-friendliness, get and put the module refcount of a governor module
> when it's in use.  As a result, unloading a governor module in use returns
> an error, e.g.:
> 
> $ cat governor
> performance
> $ rmmod governor_performance
> rmmod: ERROR: Module governor_performance is in use
> 
> Note that this can't stop force unload, so it's more of a
> user-friendliness improvement rather than strict protection.  The
> existing code that keeps devfreq working when 'devfreq->governor' is
> NULL should still be there.
> 
> Patch 1-3 clean up mutex with guards and factor out a common governor
> setting function, so as to prepare for implementing governor reference
> counting.  They can be applied separately.
> 
> Patch 4 adds the reference counting mechanism for devfreq governor
> modules.
> 
> This set is based on devfreq-next of 7.1-rc1.
> 
> Changelog
> ---------
> v4:
> - Patch 3: Return an error if starting new governor fails and restoring
>   old governor succeeds, such that the caller won't get misled.
> 
> v3:
> - Link: https://lore.kernel.org/all/20260519113251.3745140-1-zhanjie9@hisilicon.com/
> - Rework patch 4 to make the 'owner' field assignment optional in the
>   governor code.  This prevents device-driver-bundled governors (such as
>   those in hisi_uncore_freq and tegra30-devfreq) from causing
>   self-reference issues that block module removal. Additionally, merge
>   patches 4 and 5 to clearly present the new 'owner' member alongside
>   its usage.
> - Drop patch 6 because it's no longer needed since v2.
> - Update commit logs of patch 3 and 4 to clarify background and
>   motivation.
> - Pick up 2 tags from Yaxiong (thanks!).
> - Trivial cleanups.
> 
> v2:
> - Link: https://lore.kernel.org/all/20260513093832.1645890-1-zhanjie9@hisilicon.com/
> - Rebase on devfreq-next of 7.1-rc1.
> - Drop the patches related to the NULL pointer deference issue of
>   'devfreq->governor', which has been solved and merged recently.
> - Remove the dedicated mutex for 'devfreq_governor_list' because the
>   refcount changes don't depend on that.
> - Some minor cleanups and fixes.
> 
> v1:
> - Link: https://lore.kernel.org/all/20260326123428.800407-1-zhanjie9@hisilicon.com/
> 
> Jie Zhan (4):
>   devfreq: Use mutex guard in governor_store()
>   devfreq: Use mutex guard in devfreq_add/remove_governor()
>   devfreq: Factor out devfreq_set_governor()
>   devfreq: Refcount governor modules while in use
> 
>  drivers/devfreq/devfreq.c                 | 185 +++++++++++-----------
>  drivers/devfreq/governor_passive.c        |   1 +
>  drivers/devfreq/governor_performance.c    |   1 +
>  drivers/devfreq/governor_powersave.c      |   1 +
>  drivers/devfreq/governor_simpleondemand.c |   1 +
>  drivers/devfreq/governor_userspace.c      |   1 +
>  include/linux/devfreq-governor.h          |  11 ++
>  7 files changed, 112 insertions(+), 89 deletions(-)
> 
