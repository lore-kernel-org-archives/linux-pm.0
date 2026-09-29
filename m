Received: from mail-m155100.qiye.163.com (mail-m155100.qiye.163.com [101.71.155.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A9D4FE2F3;
	Tue, 29 Sep 2026 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677036; cv=none; b=gqSDsxzXLeHy4Q4CGHs+sp2JPTuIlVYsVecfQtYaQZSJ3xohqrEL1HnYVeFCw7a6vgrmbFGQ9skTPz7B/N4RcO7sSOjGvexswO5DKC8TTgd4e+fHm/qeWSNl3Y3pmgvdI+iAI6yCr96PK2WBDijwHLL/fr08/3M6QPkcmZC1jss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677036; c=relaxed/simple;
	bh=gF+taqkEcxcO3WIFRjei2FuP2Hluu/NETaBeqyRE64Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bAh5ZD7f+snoNowNrXzF1Z7YsKsiy251FlukCdCAnBL4Fx75ngN9A14qcPFIanudPcSYrNsqpilkiUCOdMGCeW52FTp/rDIUc9Saixmv1Se4iMXW93hRl2+ilGCtT4kw2IxXCO+uCkU3fwzX3Thy/4z7t6Dwl3h9pkJYpEtIkD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gJj838I8; arc=none smtp.client-ip=101.71.155.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gJj838I8"
Received: from [172.16.12.11] (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f7eb7435;
	Tue, 29 Sep 2026 18:11:40 +0800 (GMT+08:00)
Message-ID: <8ab0f451-7be2-4c9d-8237-b27292bb3fa7@rock-chips.com>
Date: Tue, 29 Sep 2026 18:11:40 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM / devfreq: governor_userspace: Guard against NULL
 governor_data during switch
To: Jie Zhan <zhanjie9@hisilicon.com>, heiko@sntech.de,
 myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260723080806.1451-1-finley.xiao@rock-chips.com>
 <4e1b7360-4ab9-4c50-b4b9-61a44707068a@hisilicon.com>
From: Finley Xiao <finley.xiao@rock-chips.com>
In-Reply-To: <4e1b7360-4ab9-4c50-b4b9-61a44707068a@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0eca60db203a8kunm4df5fc7a41f296
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTBlLVh5OT0JOHh9CSR9CGVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=gJj838I8K/H0TcZgOEiluq/SJXdmNUxakdOUJ5QT/AayTPBFXrgrZD4FuFmpXW4XYJMrnpILV0eTTxGj7DQehS/nftp0j4/WlNjmJ6aNaQaq+oDGrJfyAAT6jwrzQMr/OqAXd6is66prgrkRLPX3F64dFIWMVz60gsvLocH+lnQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Z//izYTKBBySq35BtFboabm7+7Su7nvQvEU/xskjOvw=;
	h=date:mime-version:subject:message-id:from;


在 2026/7/28 11:06, Jie Zhan 写道:
> Hi Finley,
>
> On 7/23/2026 4:08 PM, Finley Xiao wrote:
>> The userspace governor is the only one that uses devfreq->governor_data,
>> allocated in its DEVFREQ_GOV_START handler (userspace_init()) and freed
>> in its DEVFREQ_GOV_STOP handler (userspace_exit()).
>>
>> When switching governors via sysfs (governor_store in devfreq.c), the
>> sequence is:
>>
>> STOP(old) -> df->governor = userspace -> START(userspace) -> userspace_init
>>
>> Between the df->governor assignment and userspace_init() completing,
>> governor_data is still NULL (the previous governor never touched it,
>> and the core does not clear or pre-allocate it). During that window,
>> asynchronous paths that call update_devfreq() outside of the driver's
>> control -- the OPP notifier (devfreq.c:686) and the pm_qos notifier
>> (devfreq.c:707) -- run devfreq_update_target() under df->lock and reach
>> devfreq_userspace_func(), which dereferences governor_data without a
>> NULL check, causing:
>>
>>    Unable to handle kernel access to user memory outside uaccess routines
>>    pc : devfreq_userspace_func+0xc/0x28
>>    lr : devfreq_update_target+0x58/0x158
>>
>> Add a NULL check in devfreq_userspace_func() and fall back to
>> previous_freq, which is the same behaviour as the existing "no user
>> frequency specified yet" branch. This closes the race for all callers
>> since every path ultimately goes through get_target_freq.
>>
>> Additionally, take devfreq->lock around the kfree()/NULL assignment in
>> userspace_exit(). Without it, a concurrent OPP/pm_qos notifier running
>> under devfreq->lock could read governor_data after it is freed but
>> before it is set to NULL, constituting a use-after-free.
>>
>> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
>> ---
>>   drivers/devfreq/governor_userspace.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
>> index 3906ebedbae8..f7a485c43fd7 100644
>> --- a/drivers/devfreq/governor_userspace.c
>> +++ b/drivers/devfreq/governor_userspace.c
>> @@ -24,7 +24,7 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
>>   {
>>   	struct userspace_data *data = df->governor_data;
>>   
>> -	if (data->valid)
>> +	if (data && data->valid)
> This one is fine.
>>   		*freq = data->user_frequency;
>>   	else
>>   		*freq = df->previous_freq; /* No user freq specified yet */
>> @@ -110,8 +110,10 @@ static void userspace_exit(struct devfreq *devfreq)
>>   	if (devfreq->dev.kobj.sd)
>>   		sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
>>   
>> +	mutex_lock(&devfreq->lock);
>>   	kfree(devfreq->governor_data);
>>   	devfreq->governor_data = NULL;
>> +	mutex_unlock(&devfreq->lock);
> However, for this one, I'm not sure it's the proper place to add the lock.
>
> Why should we allow the whole governor switching to be concurrent with
> frequency switching?  I guess there might be something wrong elsewhere.
> The devfreq->lock should be held around governor switching.
> Can you have a try?  but be careful of deadlock because the governor
> switching currently holds devfreq_list_lock.
I tried to hold devfreq->lock around the governor switching, but the
GOV_STOP event handlers cannot run with devfreq->lock held. There are
three independent reasons:

1. userspace_exit(): sysfs_remove_group() must not be called with
    devfreq->lock held.  The removal waits for the in-flight sysfs readers
    of the "set_freq" attribute to release the kernfs active reference, and
    those readers take the active reference first and then block on
    devfreq->lock inside set_freq_show()/set_freq_store(). Removing the
    group while holding devfreq->lock waits for a reader that is waiting for
    the same lock, i.e. a deadlock.

2. simple_ondemand: devfreq_monitor_stop() (DEVFREQ_GOV_STOP) has to call
    cancel_delayed_work_sync() with devfreq->lock released, because the
    monitoring work (devfreq_monitor()) takes devfreq->lock. Waiting for
    the work while holding devfreq->lock deadlocks.  This is also why
    devfreq_monitor_stop() drops the lock before cancel_delayed_work_sync()
    today.

3. passive: the passive governor's DEVFREQ_GOV_STOP calls
    devfreq_unregister_notifier() -> srcu_notifier_chain_unregister() ->
    synchronize_srcu(), which waits for the in-flight notifier callbacks.
    Those callbacks (devfreq_passive_notifier_call()) take the child's
    devfreq->lock, so unregistering while holding the child's devfreq->lock
    can deadlock if the parent's frequency transition is in flight.

In addition, the GOV_START handlers take devfreq->lock themselves:
performance/powersave call update_devfreq() under the lock, simple_ondemand
calls devfreq_monitor_start() which takes the lock, and the passive
governor's cpufreq path takes it.  Holding devfreq->lock around the
switching would therefore also self-deadlock unless their internal locking
is removed as well.

Even if devfreq->lock were held around the whole switch,
the userspace governor would still need to hold the devfreq->lock
around the kfree itself: because of (1), userspace_exit() has to remove the
sysfs files with the lock released, so the handler would have to drop the
lock for the sysfs part and take it again for the kfree.  Holding the lock
around the switching would not remove the lock from the userspace governor;
it would only add locking around it and require restructuring all
governors.
>
> Thanks!
> Jie
>>   }
>>   
>>   static int devfreq_userspace_handler(struct devfreq *devfreq,

-- 
Best regards,

底层平台中心 肖锋（Finley Xiao）
************************************************************************************
瑞芯微电子股份有限公司
Rockchip Electronics Co., Ltd.
福建省福州市铜盘路软件大道89号软件园A区21号楼 350003
No.21 Building, A District, Fuzhou Software Park, Fuzhou, Fujian 350003, P.R. China
Tel: 0591-83991906-8602 Mobile: 18506057603
************************************************************************************

