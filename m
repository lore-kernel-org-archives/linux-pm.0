Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB463C3438;
	Tue, 31 Mar 2026 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947010; cv=none; b=c2WWfKNpnJBye50OcRPT0ZM9fZjMCe1ow/dE/4yu2B/KKpCcnh692aUL22Xaf5hzgggnbc5Idfb/qz8vUlHCGS64sBt0Sg7GFtlzttpXcd9NB807jiEugWG+B1qA1O4f61D5/O6qXYnyUOAJf55/S4G9wueLos/8QdGhHFwbZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947010; c=relaxed/simple;
	bh=WfFsxWv+/kCrWHaKOoAXTGcd7FJeVN9RmnXQ0ZFGJig=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ke5UI1Dfz9rcvonJQvUxATGd0YdumnzYQWPbNMTdOFhIBzI8z+7TtrxLEY9wSQWyRIX3lIo0iVRUTCRitp0O/8G0y0WImSDzpPbP+2Lrd0J+zmzRSEEzUqv6yYuspiD7QnHIYzT9U0ioIxsby7pWgNkQ2m/x6D6/Qg+e7MIy8Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4flM9t2P4Fz12LFm;
	Tue, 31 Mar 2026 16:44:34 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 39B8B203D0;
	Tue, 31 Mar 2026 16:49:58 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 31 Mar
 2026 16:49:57 +0800
Message-ID: <a7c1c3ce-7938-4dcf-83be-32cf4aceb965@hisilicon.com>
Date: Tue, 31 Mar 2026 16:49:57 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/4] PM / devfreq: Fix possible null pointer issue
 in devfreq_add_governor()
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>, <nm@ti.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260319091409.998397-1-tianyaxiong@kylinos.cn>
 <20260319091653.1005878-1-tianyaxiong@kylinos.cn>
 <f167d24d-73f9-4463-889e-89fb9f1e4a1a@hisilicon.com>
 <aa7ee42d-0685-4a70-a084-bf0bdfa82e4a@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <aa7ee42d-0685-4a70-a084-bf0bdfa82e4a@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 3/31/2026 3:49 PM, Yaxiong Tian wrote:
> 
> 在 2026/3/31 15:04, Jie Zhan 写道:
>>
>> On 3/19/2026 5:16 PM, Yaxiong Tian wrote:
>>> When a user removes a governor using devfreq_remove_governor(), if
>>> the current device is using this governor, devfreq->governor will
>>> be set to NULL. When the user registers any governor
>>> using devfreq_add_governor(), since devfreq->governor is NULL, a
>>> null pointer error occurs in strncmp().
>>>
>>> For example: A user loads the userspace gov through a module, then
>>> a device selects userspace. When unloading the userspace module and
>>> then loading it again, the null pointer error occurs:
>>>
>>> Unable to handle kernel NULL pointer dereference at virtual address
>>> 0000000000000010
>>> Mem abort info:
>>> ESR = 0x0000000096000004
>>> EC = 0x25: DABT (current EL), IL = 32 bits
>>> *******************skip *********************
>>> Call trace:
>>> __pi_strncmp+0x20/0x1b8
>>> devfreq_userspace_init+0x1c/0xff8 [governor_userspace]
>>> do_one_initcall+0x4c/0x278
>>> do_init_module+0x5c/0x218
>>> load_module+0x1f1c/0x1fc8
>>> init_module_from_file+0x8c/0xd0
>>> __arm64_sys_finit_module+0x220/0x3d8
>>> invoke_syscall+0x48/0x110
>>> el0_svc_common.constprop.0+0xbc/0xe8
>>> do_el0_svc+0x20/0x30
>>> el0_svc+0x24/0xb8
>>> el0t_64_sync_handler+0xb8/0xc0
>>> el0t_64_sync+0x14c/0x150
>>>
>>> To fix this issue, modify the relevant logic in devfreq_add_governor():
>>> Only check whether the new governor matches the existing one when
>>> devfreq->governor exists. When devfreq->governor is NULL, directly
>>> select the new governor and perform the DEVFREQ_GOV_START operation.
>>>
>>> Fixes: 1b5c1be2c88e ("PM / devfreq: map devfreq drivers to governor using name")
>>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>> ---
>>>   drivers/devfreq/devfreq.c | 24 +++++++++++-------------
>>>   1 file changed, 11 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 54f0b18536db..63ce6e25abe2 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -1288,23 +1288,21 @@ int devfreq_add_governor(struct devfreq_governor *governor)
>>>           int ret = 0;
>>>           struct device *dev = devfreq->dev.parent;
>>>   -        if (!strncmp(devfreq->governor->name, governor->name,
>>> +        if (devfreq->governor && !strncmp(devfreq->governor->name, governor->name,
>>>                    DEVFREQ_NAME_LEN)) {
>> Probaly do:
>> if (!devfreq->governor)
>>     continue;
>> so as to keep the line short and the "else if (!devfreq->governor) {" below
>> can be removed.
> If that's the case, a dev without a governor would not be able to add a new governor.
It's not about adding.

The whole point here (the block inside list_for_each_entry()) is a very
rare safe check that you're adding a governor of the same name of a
governor used by an existing devfreq device.  If so, stop the old one and
start the new one.

Therefore, it doesn't have to start/restart it if devfreq->governor is
NULL.
>>
>> and also:
>> if (!strncmp(devfreq->governor->name, governor->name,
>>     DEVFREQ_NAME_LEN))
>>     continue;
>> so we don't have to indent that much.
> 
> Currently, governor->name can be set arbitrarily, so duplicate names are possible.
> 
> But they could still be two different governors. Leaving it unchanged seems fine to me.
> 
Sorry, my mistake!

I mean:
if (strncmp(devfreq->governor->name, governor->name,
	DEVFREQ_NAME_LEN))
	continue;

>>
>>>               /* The following should never occur */
>>> -            if (devfreq->governor) {
>>> +            dev_warn(dev,
>>> +                 "%s: Governor %s already present\n",
>>> +                 __func__, devfreq->governor->name);
>>> +            ret = devfreq->governor->event_handler(devfreq,
>>> +                        DEVFREQ_GOV_STOP, NULL);
>>> +            if (ret) {
>>>                   dev_warn(dev,
>>> -                     "%s: Governor %s already present\n",
>>> -                     __func__, devfreq->governor->name);
>>> -                ret = devfreq->governor->event_handler(devfreq,
>>> -                            DEVFREQ_GOV_STOP, NULL);
>>> -                if (ret) {
>>> -                    dev_warn(dev,
>>> -                         "%s: Governor %s stop = %d\n",
>>> -                         __func__,
>>> -                         devfreq->governor->name, ret);
>>> -                }
>>> -                /* Fall through */
>>> +                     "%s: Governor %s stop = %d\n",
>>> +                     __func__,
>>> +                     devfreq->governor->name, ret);
>>>               }
>>> +        } else if (!devfreq->governor) {
>>>               devfreq->governor = governor;
>>>               ret = devfreq->governor->event_handler(devfreq,
>>>                           DEVFREQ_GOV_START, NULL);
