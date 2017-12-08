From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] sched/autogroup: move sched.h include
Date: Fri, 8 Dec 2017 09:57:55 +0100
Message-ID: <20171208085755.GA3148@linux.suse>
References: <20171208025616.16267-2-sergey.senozhatsky@gmail.com>
 <20171208082422.5021-1-sergey.senozhatsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171208082422.5021-1-sergey.senozhatsky@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri 2017-12-08 17:24:22, Sergey Senozhatsky wrote:
> Move local "sched.h" include to the bottom. sched.h defines
> several macros that are getting redefined in ARCH-specific
> code, for instance, finish_arch_post_lock_switch() and
> prepare_arch_switch(), so we need ARCH-specific definitions
> to come in first.

This patch is needed to fix compilation error [1] caused by a patchset
that deprecates %pf/%pF printk modifiers[2].

IMHO, we should make sure that this fix goes into Linus' tree
before the printk-related patchset. What is the best practice,
please?

I see two reasonable possibilities. Either sched people could
push this for-4.15-rcX. Or I could put it into printk.git for-4.16
in the right order.

What do you think?

Referece:
[0] http://lkml.kernel.org/r/201712080259.tvO64XfA%fengguang.wu@intel.com
[1] https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/commit/?h=for-next&id=98fff2c57b7e88d643cb42ffd910fe9905b33176

Best Regards,
Petr
