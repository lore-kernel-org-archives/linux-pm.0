From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH v2 07/10] futex: use freezable blocking call
Date: Thu, 02 May 2013 20:12:58 -0700
Message-ID: <51832B3A.4070703@linux.intel.com>
References: <1367458508-9133-1-git-send-email-ccross@android.com> <1367458508-9133-8-git-send-email-ccross@android.com> <alpine.LFD.2.02.1305022145300.2891@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51930 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758906Ab3ECDNA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 2 May 2013 23:13:00 -0400
In-Reply-To: <alpine.LFD.2.02.1305022145300.2891@ionos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Colin Cross <ccross@android.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, arve@android.com, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>



On 05/02/2013 12:45 PM, Thomas Gleixner wrote:
> On Wed, 1 May 2013, Colin Cross wrote:
> 
>> Avoid waking up every thread sleeping in a futex_wait call during
>> suspend and resume by calling a freezable blocking call.  Previous
>> patches modified the freezer to avoid sending wakeups to threads
>> that are blocked in freezable blocking calls.
>>
>> This call was selected to be converted to a freezable call because
>> it doesn't hold any locks or release any resources when interrupted
>> that might be needed by another freezing task or a kernel driver
>> during suspend, and is a common site where idle userspace tasks are
>> blocked.
>>
>> Signed-off-by: Colin Cross <ccross@android.com>
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

Beat me to it :-) Also agreed.

Acked-by: Darren Hart <dvhart@linux.intel.com>

> 
>> ---
>>  kernel/futex.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/futex.c b/kernel/futex.c
>> index b26dcfc..d710fae 100644
>> --- a/kernel/futex.c
>> +++ b/kernel/futex.c
>> @@ -61,6 +61,7 @@
>>  #include <linux/nsproxy.h>
>>  #include <linux/ptrace.h>
>>  #include <linux/sched/rt.h>
>> +#include <linux/freezer.h>
>>  
>>  #include <asm/futex.h>
>>  
>> @@ -1807,7 +1808,7 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
>>  		 * is no timeout, or if it has yet to expire.
>>  		 */
>>  		if (!timeout || timeout->task)
>> -			schedule();
>> +			freezable_schedule();
>>  	}
>>  	__set_current_state(TASK_RUNNING);
>>  }
>> -- 
>> 1.8.2.1
>>
>>

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Technical Lead - Linux Kernel
