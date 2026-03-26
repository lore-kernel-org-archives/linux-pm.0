Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8024E23EAB4
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774530849; cv=none; b=i8yZyXF4cqLTrsa1ImmToKKwrWVJJyVauX4Xnl/z4lDUqJ59Kc1kl1DXDy9yy+e4eJpi53u0Qp1YIawA3lqPAlqIq9uVHWDVbdX338l/6JMhsoiSiT5lizfdL8IlAcTWQJXd9Sxgl7bnukzl8OCWCKUQta10hw3cH0bSZm12dSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774530849; c=relaxed/simple;
	bh=VBEpYJXRYQhaZtvk0vH6nMCG6tqhF4Gh5FY0U6O0SI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j6EobOh2xsydLYnQn5I/MWA7KCYQ8BYR6NJ8qaJvFjyCjgmag3O1D18oBf0FxP/O88+efk4lUzTxQ3T+FZK3Fh70+gvuNyXX2RrRNfGG7MmrvnvXQEkut4xZGs69MGLCAa0AmiWOyx0NIviHzBR3efB105q0OzLDvyQqDnMrsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fhPGr210jznTVZ;
	Thu, 26 Mar 2026 21:08:36 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 439F840568;
	Thu, 26 Mar 2026 21:14:03 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 26 Mar
 2026 21:14:02 +0800
Message-ID: <ff1c030a-075e-4693-bad6-404428289301@hisilicon.com>
Date: Thu, 26 Mar 2026 21:14:01 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/10] devfreq: Fix NULL pointer dereference when a
 governor module is unloaded
To: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <tianyaxiong@kylinos.cn>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhenglifeng1@huawei.com>, <zhangpengjie2@huawei.com>,
	<lihuisong@huawei.com>, <prime.zeng@hisilicon.com>
References: <20260326123428.800407-1-zhanjie9@hisilicon.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260326123428.800407-1-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 3/26/2026 8:34 PM, Jie Zhan wrote:
> When compiled as a kernel module, the governor module can be dynamically
> inserted or removed.  'devfreq->governor' would become NULL if the governor
> module is removed when it's in use, and NULL pointer dereference would be
> triggered.  A similar issue was also reported in [1].
> 
> To address this issue:
> 
> Patch 1-5 rework mutex, factor out a common governor setting function, and
> clean up some unreachable code.
> 
> Patch 6-8 prevent a governor module in use from being removed (except for
> force unload) by getting/putting a refcount of the governor's module when
> switching governors.
> 
> Patch 9-10 allow 'governor' and 'available_governors' to work normally even
> when a governor module in use is force unloaded.
> 
> Note that this series is based on [1] or devfreq-next, otherwise code
sorry, based on [2] or devfreq-next
> would conflict.
> 
> [1] https://lore.kernel.org/all/20260319091409.998397-1-tianyaxiong@kylinos.cn/
> [2] https://lore.kernel.org/all/20251216031153.2242306-1-zhangpengjie2@huawei.com/
