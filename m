From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 10/10] cpufreq: intel_pstate: Use CPPC to get max
 performance
Date: Thu, 22 Sep 2016 20:56:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1609222055110.5640@nanos>
References: <1474485552-141429-1-git-send-email-srinivas.pandruvada@linux.intel.com>  <1474485552-141429-11-git-send-email-srinivas.pandruvada@linux.intel.com>  <CAJZ5v0h3=JLw8mH=x4jXNec9CGZWiCt+pPmrD1L4=QutT8=g0Q@mail.gmail.com>
 <1474570233.3916.197.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-827554592-1474570563=:5640"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1474570233.3916.197.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, jolsa@redhat.com
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-827554592-1474570563=:5640
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 22 Sep 2016, Tim Chen wrote:
> On Wed, 2016-09-21 at 22:30 +0200, Rafael J. Wysocki wrote:
> > My current understanding is that we need to rebuild sched domains
> > after setting the priorities, 
> 
> No, that's not true.  We need to rebuild the sched domains only
> when the sched domain flags are changed, not when we are changing
> the priorities.  Only the sched domain flag is a property of
> the sched domain. CPU priority values are not part of sched domain.
> 
> Morten had similar question about whether we need to rebuild sched domain
> when we change cpu priorities when we first post the patches. 
> Peter has explained that it wasn't necessary.
> http://lkml.iu.edu/hypermail/linux/kernel/1608.3/01753.html

And why is there no explanation in form of a comment in the code?

Thanks,

	tglx
--8323329-827554592-1474570563=:5640--
