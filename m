Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728F851992A;
	Fri,  4 Sep 2026 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543003; cv=none; b=Nj9RJG1HZ7BTmoqcWaEDab9gyEaCV0AgKvNlh1dmE83k6nSPE7/KfpQrUjxTuuSB4oMOl0m0FT0PZ3GqkGSUxu8sfSndJQlhWWqR+S5u1vqZs2NgMsA8MzzjYvAhoBwNzt1EjbTPqT0b46LkxWxiMvpE6DcJfo7a/n1XhM2xmgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543003; c=relaxed/simple;
	bh=AKAk3zbuNYnhlpklfK3dhSjhJiB4p3CTOx+Aaa3ijps=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=kT5rti5ztiQ3PXibu5I4ixl4PFf0pmsQDKcXmBqa3HxOJo5uViz79JGv4y3VK/OctdT61VaK3Vszrm9YVCtGZwmUbOJ3H5fB2LLrjzrI289MbHdoJ4nSmvLW7NR2NhD6xH6dLxzMDpuxrRHYoE2rqhK0vj5MX0U3yx9xZ84IOTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=fnFJJCkN; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=d5W1yLWe; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="fnFJJCkN";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="d5W1yLWe"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788542993; bh=r+8mzCVOFq1SAA8CgGmGBKY
	IYp12JiOrneuQSUh4QZ4=; b=fnFJJCkNF5NL/kNjE8JHydEYSHU1s5s9vswJTurhZ7UOZid/fp
	SP3nV3resmdS+EL0zpIqdGUb0vHa/i1970+B1mxYtgTD2hx8vhSXtMZ5iTz2zesRe1pz27YUo5E
	HaHsHNM1p1sWiPEFtVa7sxmi5k0Nx399QQBApqzVdTpUZivf5tT6c7V72djv/7D6rlp/bckOoCk
	zL9FEjSIy2CC+oiTybcsYo3TXSiKJycHq2UMoFpe0v4LDD0rb+52x6htalFFBt3huccpq3RrebP
	Lo8yks+a9FCj7WWEeUXRowV98khsKB85xtWMWNnhAXZ6HZbCYNMukAu/HOIKn6LkVwg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788542993; bh=r+8mzCVOFq1SAA8CgGmGBKY
	IYp12JiOrneuQSUh4QZ4=; b=d5W1yLWe3N3QDimA/Ha0IYQVDiyfpqtCdTm6cEmVwC6J6rxjNI
	SLul/fSXTxaiHrUKWrYQUPYOp3QwyTfC0zAQ==;
Date: Fri, 04 Sep 2026 18:29:52 +0100
From: Bradley Morgan <brads@mainlining.org>
To: rafael@kernel.org
CC: daniel.lezcano@kernel.org, include@grrlz.net, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rosenp@gmail.com, tglx@kernel.org,
 treding@nvidia.com, vschneid@redhat.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_clocksource/drivers/timer-ti-dm=3A_U?=
 =?US-ASCII?Q?nregister_CPU_PM_notifier_outside_of_the_timer_lock?=
In-Reply-To: <CAJZ5v0iLnyRzM2g-k5ky0ofgVOttYU5w5Agb0EE21ejS_vWJ0g@mail.gmail.com>
Message-ID: <AA645B1E-9F44-4326-A6D0-FCEB408D0562@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 4 September 2026 15:17:54 BST, "Rafael J. Wysocki (Intel)"
<rafael@kernel.org> wrote:
>On Thu, Aug 13, 2026 at 9:43 AM Bradley Morgan <include@grrlz.net> wrote:
>>
>> omap_dm_timer_remove() calls cpu_pm_unregister_notifier() with
>> dm_timer_lock held and interrupts disabled. Nothing sleeps in there
>> today, but it pins the helper into a context where it can never be
>> allowed to sleep, which is in the way of restoring the RCU grace
>> period on the cpu_pm notifier chain.
>>
>> Do the list lookup under the lock and move the unregister after the
>> unlock. Nothing can race it at that point: remove() owns the device,
>> and once the timer is off the list nobody can reach it anymore.
>>
>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>> ---
>>  drivers/clocksource/timer-ti-dm.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-ti-dm.c
>b/drivers/clocksource/timer-ti-dm.c
>> index bd06afb7d522..032e102bdd0a 100644
>> --- a/drivers/clocksource/timer-ti-dm.c
>> +++ b/drivers/clocksource/timer-ti-dm.c
>> @@ -1530,7 +1530,7 @@ static int omap_dm_timer_probe(struct
>platform_device *pdev)
>>   */
>>  static void omap_dm_timer_remove(struct platform_device *pdev)
>>  {
>> -       struct dmtimer *timer;
>> +       struct dmtimer *timer, *found = NULL;
>>         unsigned long flags;
>>         int ret = -EINVAL;
>>
>> @@ -1538,14 +1538,17 @@ static void omap_dm_timer_remove(struct
>platform_device *pdev)
>>         list_for_each_entry(timer, &omap_timer_list, node)
>>                 if (!strcmp(dev_name(&timer->pdev->dev),
>>                             dev_name(&pdev->dev))) {
>> -                       if (!(timer->capability & OMAP_TIMER_ALWON))
>> -                               cpu_pm_unregister_notifier(&timer->nb);
>>                         list_del(&timer->node);
>> +                       found = timer;
>>                         ret = 0;
>>                         break;
>>                 }
>>         spin_unlock_irqrestore(&dm_timer_lock, flags);
>>
>> +       /* Unregister outside the lock: cpu_pm_unregister_notifier() may
>sleep. */
>> +       if (found && !(found->capability & OMAP_TIMER_ALWON))
>> +               cpu_pm_unregister_notifier(&found->nb);
>> +
>>         pm_runtime_disable(&pdev->dev);
>>
>>         if (ret)
>> --
>
>Nobody seems to be interested in this patch, but Sashiko only sees
>pre-existing issues related to it:
>
>https://sashiko.dev/#/patchset/20260813074343.26460-1-include%40grrlz.net
>
>and the second patch in the series depends on it, so in the absence of
>any objections or concerns, I'm going to apply them both.
>
>Thanks!
>
>
Ugh, I'll check / fix the pre existing issues now

Id like to wonder why Google didn't use their 3.8 flash, considering it's
like 10x more capable
--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
