From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 0/3] Stop sched tick in idle injection task
Date: Thu, 24 Nov 2016 05:21:30 +0100
Message-ID: <20161124042129.GC29338@gmail.com>
References: <1479931990-11732-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <CAJZ5v0g6==h_qBQ1x6wbV+N3MjjWRb-iNmF4OShFrD0qR2L9JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35350 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbcKXFeH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2016 00:34:07 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g6==h_qBQ1x6wbV+N3MjjWRb-iNmF4OShFrD0qR2L9JA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>


* Rafael J. Wysocki <rafael@kernel.org> wrote:

> On Wed, Nov 23, 2016 at 9:13 PM, Jacob Pan
> <jacob.jun.pan@linux.intel.com> wrote:
> > Changelog:
> > v3:     - rearrange idle.c change based on Rafael's suggestion.
> >
> > v2:
> >         - moved duration timer from powerclamp driver to play_idle()
> >         - unexport cpuidle_use_deepest_state
> >         - indentation fix
> >
> > Idle injection drivers today use RT threads to run idle loop. There are
> > efficiency and accounting issues with the current intel_powerclamp.c
> > and acpi_pad.c. A while ago, I posted CFS based idle injection patch trying
> > to address them:
> > https://lkml.org/lkml/2015/11/13/576
> >
> > Peter proposed another approach with the introduction of a PF_IDLE flag.
> > This patchset is based on his original posting:
> > https://lkml.org/lkml/2014/6/4/56
> >
> > These patches apply on top of the kworker and cpu hotplug state machine
> > changes made to Intel powerclamp driver.
> > https://lkml.org/lkml/2016/10/17/362
> >
> > Similar changes to ACPI PAD driver is developed along with other
> > enhancements. It will be posted after this patchset is accepted.
> >
> > Jacob Pan (2):
> >   cpuidle: allow setting deepest idle
> >   thermal/powerclamp: stop sched tick in forced idle
> >
> > Peter Zijlstra (1):
> >   idle: add support for tasks that inject idle
> >
> >  drivers/cpuidle/cpuidle.c          |  11 +++
> >  drivers/thermal/intel_powerclamp.c |  35 +------
> >  include/linux/cpu.h                |   2 +
> >  include/linux/cpuidle.h            |   4 +-
> >  include/linux/sched.h              |   3 +-
> >  kernel/fork.c                      |   3 +
> >  kernel/sched/core.c                |   1 +
> >  kernel/sched/idle.c                | 183 +++++++++++++++++++++++--------------
> >  8 files changed, 139 insertions(+), 103 deletions(-)
> 
> Any objections anyone?
> 
> If not, I'll queue up this series for 4.10.

NAK. The first patch alone has a dozen of trivial problems - very sloppy.

Guys, please rework, double check and actually _READ_ the fine patches you are 
promoting and then in a couple of days I'll review this series again to see 
whether the NAK can be lifted ...

Thanks,

	Ingo
