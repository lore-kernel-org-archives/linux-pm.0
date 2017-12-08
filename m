From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/9] sched/autogroup: remove unneeded kallsyms include
Date: Fri, 8 Dec 2017 11:56:11 +0100
Message-ID: <20171208105611.rcoxze4erxkpimad@hirez.programming.kicks-ass.net>
References: <20171208025616.16267-1-sergey.senozhatsky@gmail.com>
 <20171208025616.16267-2-sergey.senozhatsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20171208025616.16267-2-sergey.senozhatsky@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Vlastimil Babka <vbabka@suse.cz>, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Fengguang Wu <fengguang.wu@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 08, 2017 at 11:56:08AM +0900, Sergey Senozhatsky wrote:
> Autogroup does not seem to use any of kallsyms functions/defines.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>

Feel free to take this through whatever tree you need this in.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/sched/autogroup.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
> index a43df5193538..0786227a3f48 100644
> --- a/kernel/sched/autogroup.c
> +++ b/kernel/sched/autogroup.c
> @@ -3,7 +3,6 @@
>  
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
> -#include <linux/kallsyms.h>
>  #include <linux/utsname.h>
>  #include <linux/security.h>
>  #include <linux/export.h>
> -- 
> 2.15.1
> 

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
