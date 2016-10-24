From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 3/3] thermal/intel_powerclamp: Convert to CPU hotplug
 state
Date: Mon, 24 Oct 2016 17:48:07 +0200
Message-ID: <20161024154807.GQ23809@pathway.suse.cz>
References: <1476707572-32215-1-git-send-email-pmladek@suse.com>
 <1476707572-32215-4-git-send-email-pmladek@suse.com>
 <20161021132118.4239af86@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161021132118.4239af86@jacob-builder>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri 2016-10-21 13:21:18, Jacob Pan wrote:
> On Mon, 17 Oct 2016 14:32:52 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> Hi Sebastian,
> I applied this patchset on 4.9-rc1 and run some cpu online/offline
> loops test while injecting idle, e.g. 25%. I got system hang after a
> few cycles. Still looking into root cause.

You might need the patch
("sched/fair: Fix sched domains NULL deference in select_idle_sibling()")
from linux-tip, see
https://lkml.kernel.org/r/tip-9cfb38a7ba5a9c27c1af8093fb1af4b699c0a441@git.kernel.org

I have mentioned it in the cover letter. I am sorry if it was not
visible enough.

Best Regards,
Petr
