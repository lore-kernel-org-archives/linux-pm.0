From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS
 handling
Date: Thu, 21 Mar 2019 10:32:17 +0100
Message-ID: <20190321093217.GB7022@nazgul.tnic>
References: <2816566.rddYshD6lm@aspire.rjw.lan>
 <20190321075807.GK6058@hirez.programming.kicks-ass.net>
 <20190321092055.GA7022@nazgul.tnic>
 <CAJZ5v0iiV3djzJrgj0GCeDuVs4hrtWKT9chtwLah5DpCw2sRaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iiV3djzJrgj0GCeDuVs4hrtWKT9chtwLah5DpCw2sRaw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Simon Schricker <sschricker@suse.de>, Hannes Reinecke <hare@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 21, 2019 at 10:28:50AM +0100, Rafael J. Wysocki wrote:
> So as I've just said, I'm going to add a sysfs knob for adjusting EPB,
> but I'd rather not do that in this patch.

Yes, but let's do it ontop pls. Otherwise we'll never get off this
/dev/msr perpetual insanity.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
