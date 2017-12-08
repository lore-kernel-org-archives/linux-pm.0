From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 1/9] sched/autogroup: remove unneeded kallsyms include
Date: Fri, 8 Dec 2017 14:43:30 +0100
Message-ID: <20171208134330.gcimodmkzxfovvm7@pathway.suse.cz>
References: <20171208025616.16267-1-sergey.senozhatsky@gmail.com>
 <20171208025616.16267-2-sergey.senozhatsky@gmail.com>
 <20171208105611.rcoxze4erxkpimad@hirez.programming.kicks-ass.net>
 <20171208112048.GH628@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20171208112048.GH628@jagdpanzerIV>
Sender: owner-linux-mm@kvack.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Vlastimil Babka <vbabka@suse.cz>, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Fengguang Wu <fengguang.wu@intel.com>, Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri 2017-12-08 20:20:48, Sergey Senozhatsky wrote:
> On (12/08/17 11:56), Peter Zijlstra wrote:
> > On Fri, Dec 08, 2017 at 11:56:08AM +0900, Sergey Senozhatsky wrote:
> > > Autogroup does not seem to use any of kallsyms functions/defines.
> > > 
> > > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > 
> > Feel free to take this through whatever tree you need this in.
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks!

> Petr, let's pick up sched/autogroup patches then. Thank you.

Yup, I have pushed both patches into printk.git for-4.16:

https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/commit/?h=for-4.16&id=79ee842891595293be37c5aed0e75b4630166c5a
https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/commit/?h=for-4.16&id=25493e5fba2f7b8cdade29d0fc8945114ee7732b

Best Regards,
Petr

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
