From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 7/9] workqueue: remove unneeded kallsyms include
Date: Tue, 12 Dec 2017 11:51:21 +0900
Message-ID: <20171212025121.GE7798@jagdpanzerIV>
References: <20171208025616.16267-1-sergey.senozhatsky@gmail.com>
 <20171208025616.16267-8-sergey.senozhatsky@gmail.com>
 <20171211151621.GF2421075@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45973 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbdLLCv0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Dec 2017 21:51:26 -0500
Content-Disposition: inline
In-Reply-To: <20171211151621.GF2421075@devbig577.frc2.facebook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Vlastimil Babka <vbabka@suse.cz>, Lai Jiangshan <jiangshanlai@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Fengguang Wu <fengguang.wu@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

On (12/11/17 07:16), Tejun Heo wrote:
> On Fri, Dec 08, 2017 at 11:56:14AM +0900, Sergey Senozhatsky wrote:
> > The filw was converted from print_symbol() to %pf some time
> > ago (044c782ce3a901fb "workqueue: fix checkpatch issues").
> > kallsyms does not seem to be needed anymore.
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> 
> Applied to wq/for-4.15-fixes.

thanks.

	-ss
