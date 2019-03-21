From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS handling
Date: Thu, 21 Mar 2019 10:28:50 +0100
Message-ID: <CAJZ5v0iiV3djzJrgj0GCeDuVs4hrtWKT9chtwLah5DpCw2sRaw@mail.gmail.com>
References: <2816566.rddYshD6lm@aspire.rjw.lan> <20190321075807.GK6058@hirez.programming.kicks-ass.net>
 <20190321092055.GA7022@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321092055.GA7022@nazgul.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Simon Schricker <sschricker@suse.de>, Hannes Reinecke <hare@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 21, 2019 at 10:21 AM Borislav Petkov <bp@suse.de> wrote:
>
> On Thu, Mar 21, 2019 at 08:58:07AM +0100, Peter Zijlstra wrote:
> > So I hate /dev/msr with a passion. It is absolute atrocious crap.
> >
> > Please, just make a real interface for this if it is important.
>
> Yeah, and we will start converting everything using /dev/msr to real
> interfaces and then taint on MSR write because, this should not have
> been allowed in the first place.

So as I've just said, I'm going to add a sysfs knob for adjusting EPB,
but I'd rather not do that in this patch.

This stuff doesn't work as intended right now, so let's fix it first
and then extend, OK?
