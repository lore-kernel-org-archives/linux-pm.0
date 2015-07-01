From: "SungEun Kim(cleaneye.kim@lge.com)" <cleaneye.kim@lge.com>
Subject: Re: Re: [PATCH] PM / Sleep: Use workqueue for user space wakeup
 sources garbage collector
Date: Wed, 1 Jul 2015 16:25:06 +0900
Message-ID: <559395D2.4070906@lge.com>
References: <1435718938-19088-1-git-send-email-cleaneye.kim@lge.com>
 <CAJKOXPcENx5_uHQTzEnUg6nJgpeqqR8+Ra7JxFaB-Jk_b9vF2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lgeamrelo02.lge.com ([156.147.1.126]:55634 "EHLO
	lgeamrelo02.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbbGAHZL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2015 03:25:11 -0400
In-Reply-To: <CAJKOXPcENx5_uHQTzEnUg6nJgpeqqR8+Ra7JxFaB-Jk_b9vF2g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: k.kozlowski.k@gmail.com
Cc: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 2015-07-01 =EC=98=A4=ED=9B=84 12:51, k.kozlowski.k@gmail.com wrote:
> 2015-07-01 11:48 GMT+09:00 SungEun Kim <cleaneye.kim@lge.com>:
>> From: "cleaeye.kim" <cleaneye.kim@lge.com>
>>
>> The synchronous synchronize_rcu in wakeup_source_remove makes user
> process
>> which writes to /sys/kernel/wake_unlock blocked sometimes.
>>
>> For example, when android eventhub tries to release wakelock,
>> this blocking process can occur, and eventhub can't get input event
>> for a while.
>>
>> Using workqueue instead of direct function call at pm_wake_unlock
>> can prevent this unnecessary delay of an user space process.
>>
>> Signed-off-by: cleaeye.kim <cleaneye.kim@lge.com>
>=20
> Hi,
>=20
> You send this patch for third time, without changelog and any
> versioning. The signed-off and from fields look incorrect (no real
> name?). What is more important I have doubts that it even compiles
> (see below).
>=20
> Could you follow the Documentation/SubmittingPatches?
>=20
>=20

Hi,

I'm sorry for my lack knowledge of submitting patch.
I have read that document but not carefully.
I will correct signed-off and please forgive my mistake of three times
sending generously.

And, I have not done compiling with no CONFIG_PM_WAKELOCKS_GC .
It's my fault. I will send v2.

Thank you.
SungEun Kim

>> ---
>> kernel/power/wakelock.c | 11 ++++++++---
>> 1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
>> index 019069c..ea10baa 100644
>> --- a/kernel/power/wakelock.c
>> +++ b/kernel/power/wakelock.c
>> @@ -17,6 +17,7 @@
>> #include <linux/list.h>
>> #include <linux/rbtree.h>
>> #include <linux/slab.h>
>> +#include <linux/workqueue.h>
>>
>> #include "power.h"
>>
>> @@ -96,7 +97,7 @@ static inline void wakelocks_lru_most_recent(struc=
t
> wakelock *wl)
>> list_move(&wl->lru, &wakelocks_lru_list);
>> }
>>
>> -static void wakelocks_gc(void)
>> +static void wakelocks_gc(struct work_struct *work)
>> {
>> struct wakelock *wl, *aux;
>> ktime_t now;
>> @@ -105,6 +106,7 @@ static void wakelocks_gc(void)
>> return;
>>
>> now =3D ktime_get();
>> + mutex_lock(&wakelocks_lock);
>> list_for_each_entry_safe_reverse(wl, aux, &wakelocks_lru_list, lru) =
{
>> u64 idle_time_ns;
>> bool active;
>> @@ -126,12 +128,15 @@ static void wakelocks_gc(void)
>> decrement_wakelocks_number();
>> }
>> }
>> + mutex_unlock(&wakelocks_lock);
>> wakelocks_gc_count =3D 0;
>> }
>> +
>> +static DECLARE_WORK(wakelock_work, wakelocks_gc);
>> #else /* !CONFIG_PM_WAKELOCKS_GC */
>> static inline void wakelocks_lru_add(struct wakelock *wl) {}
>> static inline void wakelocks_lru_most_recent(struct wakelock *wl) {}
>> -static inline void wakelocks_gc(void) {}
>> +static void wakelocks_gc(struct worksturct) {}
>=20
> worksturct? Does it compile?
>=20
> Best regards,
> Krzysztof
