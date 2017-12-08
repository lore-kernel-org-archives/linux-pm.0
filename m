From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 4/9] pci: remove unneeded kallsyms include
Date: Sat, 9 Dec 2017 08:55:49 +0900
Message-ID: <20171208235549.GD489@tigerII.localdomain>
References: <20171208025616.16267-1-sergey.senozhatsky@gmail.com>
 <20171208025616.16267-5-sergey.senozhatsky@gmail.com>
 <20171208175345.GA12367@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41935 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753566AbdLHXzx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Dec 2017 18:55:53 -0500
Content-Disposition: inline
In-Reply-To: <20171208175345.GA12367@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Vlastimil Babka <vbabka@suse.cz>, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Fengguang Wu <fengguang.wu@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

On (12/08/17 11:53), Bjorn Helgaas wrote:
> On Fri, Dec 08, 2017 at 11:56:11AM +0900, Sergey Senozhatsky wrote:
> > The file was converted from print_fn_descriptor_symbol()
> > to %pF some time ago (c9bbb4abb658da "PCI: use %pF instead
> > of print_fn_descriptor_symbol() in quirks.c"). kallsyms does
> > not seem to be needed anymore.
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> 
> Applied to pci/misc for v4.16, thanks for cleaning this up!

thanks!

> I *assume* there's no ordering dependency like the one you mentioned
> for sched/printk.

no dependency. you are right.

	-ss
