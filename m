From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 1/2] idle: add support for tasks that inject idle
Date: Mon, 28 Nov 2016 23:22:50 +0100
Message-ID: <CAJZ5v0iXSJQOWgr5W+YXzbvsK5GFLbA+cuD17++boDXHAxjorQ@mail.gmail.com>
References: <1480368809-23685-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1480368809-23685-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <CAJZ5v0iLf5JpdzRnjk+TxKVuX2GkLx4-0p8SJb1uxFsKGe0ksg@mail.gmail.com> <20161128134622.622689ab@icelake>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33143 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755669AbcK1WWw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 17:22:52 -0500
In-Reply-To: <20161128134622.622689ab@icelake>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On Mon, Nov 28, 2016 at 10:46 PM, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:
> On Mon, 28 Nov 2016 22:39:07 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
>> On Mon, Nov 28, 2016 at 10:33 PM, Jacob Pan
>> <jacob.jun.pan@linux.intel.com> wrote:
>> > From: Peter Zijlstra <peterz@infradead.org>
>> >
>> > Idle injection drivers such as Intel powerclamp and ACPI PAD
>> > drivers use realtime tasks to take control of CPU then inject idle.
>> > There are two issues with this approach:
>> >
>> >  1. Low efficiency: injected idle task is treated as busy so sched
>> > ticks do not stop during injected idle period, the result of these
>> >     unwanted wakeups can be ~20% loss in power savings.
>> >
>> >  2. Idle accounting: injected idle time is presented to user as
>> > busy.
>> >
>> > This patch addresses the issues by introducing a new PF_IDLE flag
>> > which allows any given task to be treated as idle task while the
>> > flag is set. Therefore, idle injection tasks can run through the
>> > normal flow of NOHZ idle enter/exit to get the correct accounting
>> > as well as tick stop when possible.
>> >
>> > The implication is that idle task is then no longer limited to PID
>> > == 0.
>> >
>> > Acked-by: Ingo Molnar <mingo@kernel.org>
>> > Signed-off-by: Peter Zijlstra <peterz@infradead.org>
>> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>
>> Have you made any changes to the original Peter's patch, or is this
>> just a resend of that?
> No changes made to Peter's patch. I just rebased to v4.9-rc7 and tested
> it.

OK, thanks!
