Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803123A6F0F
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778841129; cv=none; b=qqgOA64Scnq6bKhWSCgCzVvz+4zpzme0i8TSOPYsZ6eDfRowcAdyU1+QOvOGnN/Hw1RDFTwXX3NFOjfM5Omrrrq9YFQEZG8JnYC9bIzfv+8TO331sNo5nrE0lNX2Qkea5sOxuSGdvekf/vld96fE1Knj9SzvweswzcLmkfr+LL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778841129; c=relaxed/simple;
	bh=jYTzBhwRX45qyesNkXrZK8O/1qFUDWIuUEjMjMnn/yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VZv7Kup+/FmmMSFnfKLZNQnNmV+F21EYM/qpTLuyHORO5iqwAUgjCghXr+sO5HB7gnCAxdJ3zYyyZ9kNuAX4NdWIanjc485KE3FEq+O4bhnjBGLoYqAcnbVafLcpdhEmtEGwBNsCp+0ZrqneAcX0UjWAF7mEjemULNXvgB7I45k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gH3Gy3LLqz12LpG;
	Fri, 15 May 2026 18:24:58 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A0D040538;
	Fri, 15 May 2026 18:32:02 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 May
 2026 18:32:01 +0800
Message-ID: <93cbb609-9b90-4551-8bf9-19e9ca657baf@hisilicon.com>
Date: Fri, 15 May 2026 18:32:01 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] devfreq: Factor out devfreq_set_governor()
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, <cwchoi00@gmail.com>,
	<cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linuxarm@huawei.com>, <zhenglifeng1@huawei.com>,
	<zhangpengjie2@huawei.com>, <lihuisong@huawei.com>,
	<prime.zeng@hisilicon.com>
References: <20260513093832.1645890-1-zhanjie9@hisilicon.com>
 <20260513093832.1645890-4-zhanjie9@hisilicon.com>
 <418993e5-ae44-48a4-98d7-250d0f359b0a@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <418993e5-ae44-48a4-98d7-250d0f359b0a@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 5/14/2026 2:09 PM, Yaxiong Tian wrote:
> 
> 在 2026/5/13 17:38, Jie Zhan 写道:
>> Factor out common governor setting logic into devfreq_set_governor() so as
>> to consolidate the code in governor_store() and devfreq_add_device().
>>
>> The caller is expected to hold 'devfreq_list_lock', enforced via
>> lockdep_assert_held().  This is required because devfreq_add_device() must
>> hold the lock from setting governor until the device is added to
>> 'devfreq_list', so that a concurrent devfreq_remove_governor() cannot free
>> the governor in between.
>>
>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> 
> I'm a bit unclear about the purpose of this commit, or the problem it solves. Can you explain it more clearly?
> 
> 
`governor_store()` and `devfreq_add_device()` share the similar governor
setting code when `devfreq->governor` can be NULL, so unifying and
factoring out the common governor setting logic with two main purposes:
1. Reduce code duplication.
2. Prepare for the next few patches which add refcounting for the governor
modules -- There would be less `try_module_get()` and `module_put()` by
factoring out `devfreq_set_governor()`.

I'll explain this more in the commit log.

Thanks,
Jie
>> ---
>>   drivers/devfreq/devfreq.c | 117 ++++++++++++++++++--------------------
>>   1 file changed, 56 insertions(+), 61 deletions(-)
[ ... ]
