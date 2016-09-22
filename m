From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v4 10/10] cpufreq: intel_pstate: Use CPPC to get max
 performance
Date: Thu, 22 Sep 2016 12:01:41 -0700
Message-ID: <1474570901.3916.198.camel@linux.intel.com>
References: <1474485552-141429-1-git-send-email-srinivas.pandruvada@linux.intel.com>
          <1474485552-141429-11-git-send-email-srinivas.pandruvada@linux.intel.com>
          <CAJZ5v0h3=JLw8mH=x4jXNec9CGZWiCt+pPmrD1L4=QutT8=g0Q@mail.gmail.com>
         <1474570233.3916.197.camel@linux.intel.com>
         <alpine.DEB.2.20.1609222055110.5640@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:38241 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933991AbcIVTB7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Sep 2016 15:01:59 -0400
In-Reply-To: <alpine.DEB.2.20.1609222055110.5640@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, jolsa@redhat.com

On Thu, 2016-09-22 at 20:56 +0200, Thomas Gleixner wrote:
> On Thu, 22 Sep 2016, Tim Chen wrote:
> > 
> > On Wed, 2016-09-21 at 22:30 +0200, Rafael J. Wysocki wrote:
> > > 
> > > My current understanding is that we need to rebuild sched domains
> > > after setting the priorities, 
> > No, that's not true.  We need to rebuild the sched domains only
> > when the sched domain flags are changed, not when we are changing
> > the priorities.  Only the sched domain flag is a property of
> > the sched domain. CPU priority values are not part of sched domain.
> > 
> > Morten had similar question about whether we need to rebuild sched domain
> > when we change cpu priorities when we first post the patches. 
> > Peter has explained that it wasn't necessary.
> > http://lkml.iu.edu/hypermail/linux/kernel/1608.3/01753.html
> And why is there no explanation in form of a comment in the code?

Sure, I'll add a comment.

Thanks.

Tim


