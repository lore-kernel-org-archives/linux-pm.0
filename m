From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/3] x86: Remove duplicate turbo ratio MSRs
Date: Thu, 7 Jul 2016 09:37:21 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1607070937000.4083@nanos>
References: <1467846477-13659-1-git-send-email-srinivas.pandruvada@linux.intel.com> <CAJZ5v0iTb5GMwLgHnMJOCQnwnCwgDQyziCdoxWaX5Bq57Qk=+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iTb5GMwLgHnMJOCQnwnCwgDQyziCdoxWaX5Bq57Qk=+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@suse.de>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 7 Jul 2016, Rafael J. Wysocki wrote:
> On Thu, Jul 7, 2016 at 1:07 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > MSR_NHM_TURBO_RATIO_LIMIT and MSR_IVT_TURBO_RATIO_LIMIT are
> > duplicate MSRs with MSR_TURBO_RATIO_LIMIT and MSR_TURBO_RATIO_LIMIT1
> > respectively. So remove them by first removing their usage and then
> > from msr-index.h.
> >
> > Srinivas Pandruvada (3):
> >   cpufreq: intel_pstate: Replace MSR_NHM_TURBO_RATIO_LIMIT
> >   tools/power turbostat: Replace MSR_NHM_TURBO_RATIO_LIMIT
> >   x86: remove duplicate turbo ratio limit MSRs
> >
> >  arch/x86/include/asm/msr-index.h      | 2 --
> >  drivers/cpufreq/intel_pstate.c        | 4 ++--
> >  tools/power/x86/turbostat/turbostat.8 | 2 +-
> >  tools/power/x86/turbostat/turbostat.c | 2 +-
> >  4 files changed, 4 insertions(+), 6 deletions(-)
> 
> The series looks good to me.
> 
> If anyone has any objections against this going in through the PM
> tree, please let me know.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
