From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/5] x86: use common aperfmperf_khz_on_cpu() to calculate KHz using APERF/MPERF
Date: Mon, 19 Jun 2017 16:18:07 +0200
Message-ID: <4066164.lk5f1Ou666@aspire.rjw.lan>
References: <1496889556-17923-1-git-send-email-lenb@kernel.org> <CAJvTdKmK6SPq1L1nWpkAcVgXBT92r=-EZsTNPi1C5eBDaux5xQ@mail.gmail.com> <136184443.Dv0asqkIzm@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <136184443.Dv0asqkIzm@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: X86 ML <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Monday, June 19, 2017 02:28:21 PM Rafael J. Wysocki wrote:
> On Friday, June 16, 2017 09:49:00 PM Len Brown wrote:
> > On Fri, Jun 16, 2017 at 8:30 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > On Wednesday, June 07, 2017 07:39:13 PM Len Brown wrote:
> > >> From: Len Brown <len.brown@intel.com>
> 
> [cut]
> 
> > >
> > > I wonder if we could change intel_pstate_get() to simply return
> > > aperfmperf_khz_on_cpu(cpu_num)?
> > >
> > > That would allow us to avoid the extra branch here and get rid of the
> > > #ifdef x86 from the header.
> > 
> > The reason I put the hook here is specifically so that the same
> > code would always be called on the x86 architecture,
> > no not matter what cpufreq driver is loaded.
> > 
> > Yes, alternatively, all possible driver.get routines could be updated
> > to call the same routine.  That is acpi-cpufreq.c, intel_pstate.c,
> > others?
> 
> Just acpi-cpufreq.c and intel_pstate.c.
> 
> Moreover, I wouldn't change the behavior on systems using acpi-cpufreq.c,
> because why really?

Actually, having thought a bit more about this, I see why that may be useful.

Also the #ifdef CONFIG_X86 in the header is better than an arch header, at
least for now, so I agree with the approach in your patch.

Thanks,
Rafael
