Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21906486629;
	Thu, 20 Aug 2026 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261323; cv=none; b=ckhmm+bm8AprZzy9swdoGltZiwX4qTjP5dwOQTskm2YNd5dhxBUUi5LUP2lCOLRLMm6cy1qdbs61fjO7VnlSJBdjypuMsdCwa8ewBYDxJXqAoAkiYZpuD1eV5YId7ITn74iECs8KUptJZyATBV2qz001zsd6mUGqJf4ND9O8AvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261323; c=relaxed/simple;
	bh=WJM6b8mH31M7b0pWglLLjRsyhinKZq6lgRO0pSS4K7s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=k2rVMTP+zTFkSzHK779wnGnSRZCatU+ngO+W+uoE7RSpqusJoXAwCA8xNLDkAcc9RsiyDe38gMuj3zNXqhuZAEbTjImo9KPqL8zATxXmuyU3ujDNj1R27q91nWYNo+UTA/OMz9gqXhx2SSnnm0Z9+//1nQvAEzgo9/dC+pwsRgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=d24793U9; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="d24793U9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787261319;
	bh=YNFXL8RPUdxEnqU8ky258yUWZV+07SyP4fsqVZwMTsE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=d24793U9YsOtuE8YuXt3Q4qA+M9LKliVIVDmr5qvGg4uXOrY1HKt8XaYoodQIEUvm
	 8riN5aCBzm8c7h+0+Ip55DM0kce2QLhyeQeH9ez23svK05N2beqP2iHzZxzIZqPKsx
	 +oBeR7ggKH6UIqmLDE9TbM7jsRXejif/ul96+zes=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hQxPz1CRwz6vLf;
	Thu, 20 Aug 2026 21:28:39 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hQxPy5Lx6z4y6W;
	Thu, 20 Aug 2026 21:28:38 +0000 (UTC)
Date: Thu, 20 Aug 2026 22:28:39 +0100
From: Bradley Morgan <include@grrlz.net>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Daniel Leznan <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Valentin Schneider <vschneid@redhat.com>, Rosen Penev <rosenp@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_PM=3A_cpu=3A_Restore_synchron?=
 =?US-ASCII?Q?ize=5Frcu=28=29_to_cpu=5Fpm=5Funregister=5Fnotifier=28=29?=
In-Reply-To: <CAJZ5v0jJDUZ6HH44GK6sGdVKNAY+i7EMsqdFPNcGvoW4d7W4kg@mail.gmail.com>
References: <20260813074343.26460-1-include@grrlz.net> <20260813074343.26460-3-include@grrlz.net> <CAJZ5v0jJDUZ6HH44GK6sGdVKNAY+i7EMsqdFPNcGvoW4d7W4kg@mail.gmail.com>
Message-ID: <DBBFB51F-27A2-4FFB-91D8-F16AE910872C@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 20 August 2026 22:24:51 BST, "Rafael J. Wysocki (Intel)"
<rafael@kernel.org> wrote:
>On Thu, Aug 13, 2026 at 9:43 AM Bradley Morgan <include@grrlz.net> wrote:
>>
>> cpu_pm_notify() walks the notifier chain lockless under only
>> rcu_read_lock(). That only works if a removed notifier block is not
>> freed until every concurrent walker is done with it.
>>
>> The chain used to be an atomic_notifier, whose unregister ends in
>> synchronize_rcu(). Commit b2f6662ac08d ("PM: cpu: Make notifier chain
>> use a raw_spinlock_t") switched it over to a raw_notifier, and in
>> doing so replaced that with raw_notifier_chain_unregister(), which
>> does not synchronize. The grace period quietly went away, so a driver
>> that frees the memory holding its notifier block right after
>> cpu_pm_unregister_notifier() returns can race with a concurrent
>> walker:
>>
>>   cpu1 (idle exit)                  cpu2 (driver remove)
>>   ----------------                  --------------------
>>   cpu_pm_notify(CPU_PM_EXIT)
>>     rcu_read_lock()
>>     nb = rcu_dereference_raw(*nl)
>>                                     cpu_pm_unregister_notifier(&od->nb)
>>                                       unlink, no grace period
>>                                       remove() frees od (devm)
>>     nb->notifier_call(nb, ...)
>>       /* use after free */
>>
>> The rcu_read_lock() on cpu1 does not stop cpu2 from freeing the
>> block, and nothing else does. The read side is the idle exit path,
>> so this can hit on any system where a driver with a cpu_pm notifier
>> gets unbound.
>>
>> Add the grace period back. It is only needed when a notifier was
>> actually removed, so wait on success and return -ENOENT without
>> waiting otherwise. The kerneldoc gets back the "may sleep" note that
>> the same commit dropped.
>>
>> Fixes: b2f6662ac08d ("PM: cpu: Make notifier chain use a
>raw_spinlock_t")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>
>Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
>
>or if you want me to pick up this series, I need an ACK on the first
>patch.
>

Waiting game... (And I can't take it! I'm not maintainer of anything
sadly, one day, one day, I'm manifesting it.. one day)

>> ---
>>  kernel/cpu_pm.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
>> index 7481fbb947d3..a2a598ad6e6d 100644
>> --- a/kernel/cpu_pm.c
>> +++ b/kernel/cpu_pm.c
>> @@ -10,6 +10,7 @@
>>  #include <linux/cpu_pm.h>
>>  #include <linux/module.h>
>>  #include <linux/notifier.h>
>> +#include <linux/rcupdate.h>
>>  #include <linux/spinlock.h>
>>  #include <linux/syscore_ops.h>
>>
>> @@ -76,7 +77,8 @@ EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
>>   *
>>   * Remove a driver from the CPU PM notifier list.
>>   *
>> - * This function has the same return conditions as
>raw_notifier_chain_unregister.
>> + * This function may sleep, and has the same return conditions as
>> + * raw_notifier_chain_unregister.
>>   */
>>  int cpu_pm_unregister_notifier(struct notifier_block *nb)
>>  {
>> @@ -86,6 +88,11 @@ int cpu_pm_unregister_notifier(struct notifier_block
>*nb)
>>         raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
>>         ret = raw_notifier_chain_unregister(&cpu_pm_notifier.chain, nb);
>>         raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
>> +
>> +       /* Wait for the rcu_read_lock() walkers in cpu_pm_notify(). */
>> +       if (!ret)
>> +               synchronize_rcu();
>> +
>>         return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
>> --
>> 2.47.3
>>
>

Thanks!
