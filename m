From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 07/10] futex: use freezable blocking call
Date: Mon, 29 Apr 2013 15:52:27 -0700
Message-ID: <517EF9AB.8080508@linux.intel.com>
References: <1367271946-7239-1-git-send-email-ccross@android.com> <1367271946-7239-8-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:28140 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758190Ab3D2Ww3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 29 Apr 2013 18:52:29 -0400
In-Reply-To: <1367271946-7239-8-git-send-email-ccross@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, arve@android.com, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Matthew Helsley <matthltc@us.ibm.com>

Colin,

I don't know anything about when or when not to use freezable*, and I
suspect that may be true for others as well. A more complete
description of why it's acceptable here in the commit log might help
expedite acceptance.


Matt,

I have a vague memory of discussing something similar to this with you.
Do you see any potential problems here?

--
Darren

On 04/29/2013 02:45 PM, Colin Cross wrote:
> Avoid waking up every thread sleeping in a futex_wait call during
> suspend and resume by calling a freezable blocking call.
> 
> Signed-off-by: Colin Cross <ccross@android.com>
> ---
>  kernel/futex.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index b26dcfc..d710fae 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -61,6 +61,7 @@
>  #include <linux/nsproxy.h>
>  #include <linux/ptrace.h>
>  #include <linux/sched/rt.h>
> +#include <linux/freezer.h>
>  
>  #include <asm/futex.h>
>  
> @@ -1807,7 +1808,7 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
>  		 * is no timeout, or if it has yet to expire.
>  		 */
>  		if (!timeout || timeout->task)
> -			schedule();
> +			freezable_schedule();
>  	}
>  	__set_current_state(TASK_RUNNING);
>  }
> 

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Technical Lead - Linux Kernel
