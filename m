From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs interface
Date: Mon, 25 Mar 2019 10:56:42 +0100
Message-ID: <CAJZ5v0j_gfneFY-7e48Oi5habQd+s3s+aJRN8DQcnJc7yN8CTw@mail.gmail.com>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan> <1762575.ER2xjzr9E1@aspire.rjw.lan>
 <20190322150009.GY6058@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322150009.GY6058@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Simon Schricker <sschricker@suse.de>, Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 22, 2019 at 4:00 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 21, 2019 at 11:20:17PM +0100, Rafael J. Wysocki wrote:
> > +     ret = rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = wrmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS,
> > +                         (epb & ~EPB_MASK) | val);
>
> That's two back-to-back IPIs and a giant waste.

Giant with respect to what?

I know that the read can be avoidable if more MSR bits are stored in
memory, but I don't expect this i/f to be used very often (once per
boot maybe or on AC<->DC changes at most), so I didn't think that this
would be a good tradeoff.

> If you'd use a proper msr shadow variable, you'd not have to do the
> rdmsr_on_cpu :-)

Not really.

The MSR can be updated from elsewhere which is not controlled by this code.
