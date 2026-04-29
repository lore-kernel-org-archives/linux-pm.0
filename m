Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FD9378D95;
	Wed, 29 Apr 2026 02:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777428304; cv=none; b=la85DyGB4QLq3VfCrO3aCbleGaMvACK99sEIJEleTu+PJNR9fQiOen/BiNC+ZyCtOblRnrjey3Efe682D+U5LvrrwpwPAN/B+6SaTJ14gSaSwW6MWtewEoSvSjuQaIZPJidi3dbcOPKVZ+Z1PLqcQouYhBJl6dPgZrmiLYCXa5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777428304; c=relaxed/simple;
	bh=ZLHNlf0aUmvxoPF9m7+y4esTzwL1ydqrLpNaFVWn81Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kYtRKjax6wsZNM0hDM039yS5cOZfWFqmVWZjvAdWvDCNXazIy2Mlen0xUUxM0gMHjfcSTGoCMPmHPr4M76g9c9SJy+kjDA58FGdZiAQrvfSFoaxm1DJjMti14RzAxCwZDRNwbaSKtI4uRM3aOPj+LZo0wrDVYXvEXhj7gA/0qyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4g50n82NynznTb8;
	Wed, 29 Apr 2026 09:57:48 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 5BB8840572;
	Wed, 29 Apr 2026 10:04:59 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Apr
 2026 10:04:58 +0800
Message-ID: <d4126b42-d76c-4c4b-b08f-797822572f75@hisilicon.com>
Date: Wed, 29 Apr 2026 10:04:58 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Fix some errors in the devfreq core layer when
 governor is NULL
To: <cw00.choi@samsung.com>, Chanwoo Choi <chanwoo@kernel.org>,
	<cwchoi00@gmail.com>, Yaxiong Tian <tianyaxiong@kylinos.cn>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, MyungJoo Ham
	<myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
	<nm@ti.com>
References: <20260401032838.66168-1-tianyaxiong@kylinos.cn>
 <27c3f3af-beee-422d-b96a-60472a16b0aa@hisilicon.com>
 <5563d184-f867-40a0-ac39-93fa60969164@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <5563d184-f867-40a0-ac39-93fa60969164@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 4/28/2026 10:59 AM, Yaxiong Tian wrote:
> 
> 在 2026/4/28 10:50, Jie Zhan 写道:
>>
>> On 4/1/2026 11:28 AM, Yaxiong Tian wrote:
>>> While doing some development work with devfreq_add_governor()/
>>> devfreq_remove_governor(), I discovered several bugs caused when
>>> devfreq->governor is NULL. Specifically:
>>>
>>> 1) A possible null pointer issue in devfreq_add_governor(), caused
>>> by devfreq_remove_governor() setting devfreq->governor to NULL in
>>> certain situations, while devfreq_add_governor() lacks corresponding
>>> checks for devfreq->governor.
>>>
>>> 2) When operating on governor and available_governors under /sys,
>>> there are also some unexpected errors.
>>>
>>> For issue 1, the solution is similar to Jie Zhan's PATCH.
>>> https://lore.kernel.org/linux-pm/20260326123428.800407-6-zhanjie9@hisilicon.com/
>>>
>>> The original v1 approach actually changed the original logic, which is incorrect.
>>>
>>> See the following patches for details.
>>>
>>> change in v2:
>>> 1) rebase to  linux-next(20260326) /devfreq-next
>>> 2) remove some code to fix null pointer in patch1
>>> 3) add  sysfs_update_group() in patch2
>>>
>>>
>>> Yaxiong Tian (4):
>>>    PM / devfreq: Fix possible null pointer issue in
>>>      devfreq_add_governor()
>>>    PM / devfreq: Fix available_governors_show() when no governor is set
>>>    PM / devfreq: Fix governor_store() failing when device has no current
>>>      governor
>>>    PM / devfreq: Optimize error return value of governor_show()
>>>
>>>   drivers/devfreq/devfreq.c | 57 +++++++++++----------------------------
>>>   1 file changed, 16 insertions(+), 41 deletions(-)
>>>
>> Hi Yaxiong,
>>
>> Any plan for updating this in the 7.1 cycle?
>>
>> Jie
> No plans for now. I tried using BT4 and found that it can automatically extract your tags. Currently, we only have some disagreements on patch 4. This patch isn't very important and can be ignored. Let's just wait for the maintainers to decide—maybe your solution or someone else's will be better.
Sure.


Hi Chanwoo,

Can you take a look at Patch 1-3 and check if they can be applied?

We have some following patches in development that depends on this.

PS: Sorry I'm not sure which email address gets to you easier, so include
them all!

Thanks!
Jie


	
