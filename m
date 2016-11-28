From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 1/2] idle: add support for tasks that inject idle
Date: Mon, 28 Nov 2016 13:46:22 -0800
Message-ID: <20161128134622.622689ab@icelake>
References: <1480368809-23685-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1480368809-23685-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <CAJZ5v0iLf5JpdzRnjk+TxKVuX2GkLx4-0p8SJb1uxFsKGe0ksg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22436 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754377AbcK1VsM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Nov 2016 16:48:12 -0500
In-Reply-To: <CAJZ5v0iLf5JpdzRnjk+TxKVuX2GkLx4-0p8SJb1uxFsKGe0ksg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, jacob.jun.pan@linux.intel.com

On Mon, 28 Nov 2016 22:39:07 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Mon, Nov 28, 2016 at 10:33 PM, Jacob Pan
> <jacob.jun.pan@linux.intel.com> wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > Idle injection drivers such as Intel powerclamp and ACPI PAD
> > drivers use realtime tasks to take control of CPU then inject idle.
> > There are two issues with this approach:
> >
> >  1. Low efficiency: injected idle task is treated as busy so sched
> > ticks do not stop during injected idle period, the result of these
> >     unwanted wakeups can be ~20% loss in power savings.
> >
> >  2. Idle accounting: injected idle time is presented to user as
> > busy.
> >
> > This patch addresses the issues by introducing a new PF_IDLE flag
> > which allows any given task to be treated as idle task while the
> > flag is set. Therefore, idle injection tasks can run through the
> > normal flow of NOHZ idle enter/exit to get the correct accounting
> > as well as tick stop when possible.
> >
> > The implication is that idle task is then no longer limited to PID
> > == 0.
> >
> > Acked-by: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> Have you made any changes to the original Peter's patch, or is this
> just a resend of that?
No changes made to Peter's patch. I just rebased to v4.9-rc7 and tested
it.
