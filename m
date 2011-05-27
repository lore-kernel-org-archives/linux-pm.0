From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 2/3] introduce intel_rapl driver
Date: Fri, 27 May 2011 21:56:33 +0200
Message-ID: <1306526193.2497.474.camel__36375.384257599$1306538836$gmane$org@laptop>
References: <1306398857.2207.157.camel@rui> <1306403003.1200.41.camel@twins>
	<1306484810.16581.375.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1306484810.16581.375.camel@rui>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matt Fleming <matt@console-pimps.org>, "Lin, Ming M" <ming.m.lin@intel.com>, LKML <linux-kernel@vger.kernel.org>, "acme@redhat.com" <acme@redhat.com>, linux-pm <linux-pm@lists.linux-foundation.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Fri, 2011-05-27 at 16:26 +0800, Zhang Rui wrote:
> > > +static void rapl_event_update(struct perf_event *event)
> > > +{
> > > +   s64 prev;
> > > +   u64 now;
> > > +   struct rapl_domain *domain = to_rapl_domain(event->pmu);
> > > +
> > > +   now = rapl_read_energy(domain);
> > 
> > So I had to get the Intel SDM because your driver lacks all useful
> > information, and I learned that the RAPL status MSRs contain 32 bits.
> > 
> > So you get those 32 bits, divide them by some number,
> > 
> > > +   prev = local64_xchg(&event->hw.prev_count, now);
> > > +   local64_add(now - prev, &event->count);
> > 
> > And then expect that to work?
> > 
> rapl_read_energy first reads energy status from MSR and then invokes
> rapl_unit_xlate to translate it into Joules.
> For example, on the laptop I tested, the energy unit bits is 0x10, which
> means that the energy unit is 1/65536 Joule.
> So I need to divide the value read from MSR by 65536 to calculate how
> many Joules of energy are cost. 
> 
> But this reveals a problem. If the task is scheduled out with energy
> consumption less than 1 Joule, we failed to record it.
> 
> IMO, a new callback should be introduced so that I can save the MSR
> value first and translate it to Joule when the task exits. Or just do
> the translation in user space.
> 
> what do you think? 

That's not the problem I meant, but lets start with that, you can solve
that differently, just keep a fraction somewhere in hw_perf_event.

Anyway, the problem you missed is what happens when those 32 bits roll
over, at that point you get now < prev and the value added to
event->count is a _HUGE_ 64 bit number.
