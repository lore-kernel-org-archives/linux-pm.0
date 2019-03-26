From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 07/14] powercap/intel_rapl: Simplify rapl_find_package()
Date: Tue, 26 Mar 2019 14:27:30 -0400
Message-ID: <CAJvTdKmg4YwzYGfPZKdAFZCqA6hFROdSVT46iDk0mb1rL-TKvg@mail.gmail.com>
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
 <4dd94a34999d6db4ced7a0759c02f7cd93729dc4.1551160674.git.len.brown@intel.com> <20190226190658.GS2861@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226190658.GS2861@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 26, 2019 at 2:07 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Feb 26, 2019 at 01:20:05AM -0500, Len Brown wrote:
> > -static struct rapl_package *find_package_by_id(int id)
> > +static struct rapl_package *rapl_find_package(int cpu)
> >  {
> > +     int id = topology_physical_package_id(cpu);
> >       struct rapl_package *rp;
>
> Which you'll change to topology_physical_die_id() in the next patch.
>
> If you respin the series again, could we pick a better name?

Done.
I called this routine "rapl_find_package_domain()" -- since that is
what it does --
it finds what RAPL calls a "Package Domain", no matter if that domain
is implemented in the topology by a die or a physical package.

thanks,
Len Brown, Intel Open Source Technology Center
