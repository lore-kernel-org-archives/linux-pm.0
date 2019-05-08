From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 10/22] powercap/intel_rapl: Support multi-die/package
Date: Wed, 8 May 2019 15:45:24 -0400
Message-ID: <CAJvTdKndWcuq+hbJS+ksnUeqqzt-tgXxUYikgLqWeUYG1PuuRA@mail.gmail.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
 <9f6958c231347e639e322de8d8c3de6859559345.1557177585.git.len.brown@intel.com> <20190507121459.GL2623@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190507121459.GL2623@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 7, 2019 at 8:15 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, May 06, 2019 at 05:26:05PM -0400, Len Brown wrote:
> > From: Zhang Rui <rui.zhang@intel.com>
> >
> > RAPL "package" domains are actually implemented in hardware per-die.
> > Thus, the new multi-die/package systems have mulitple domains
> > within each physical package.
> >
> > Update the intel_rapl driver to be "die aware" -- exporting multiple
> > domains within a single package, when present.
> > No change on single die/package systems.
> >
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > Signed-off-by: Len Brown <len.brown@intel.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: linux-pm@vger.kernel.org
> > ---
> >  drivers/powercap/intel_rapl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> > index 3c3c0c23180b..9202dbcef96d 100644
> > --- a/drivers/powercap/intel_rapl.c
> > +++ b/drivers/powercap/intel_rapl.c
> > @@ -266,7 +266,7 @@ static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
> >  /* caller to ensure CPU hotplug lock is held */
> >  static struct rapl_package *rapl_find_package_domain(int cpu)
> >  {
> > -     int id = topology_physical_package_id(cpu);
> > +     int id = topology_logical_die_id(cpu);
> >       struct rapl_package *rp;

> Both functions are still misnomers. rapl_find_package_domain() does in
> fact now do rapl_find_die_domain(), right? Same for rapl_add_package()

A "RAPL Package Domain" (rapl_package, above) is a known proper noun --
it is a known documented capability.

When there could be just 1 die in a package, the name of this capability
also always matched the scope of a physical package.

Now that some products have two die in the same package, there
can be two of these inside a package, and they are associated with
each die.

There are no plans to re-name the Package RAPL Domain capability
in the hardware documentation.

Similarly, there are no plans to re-name any of the other "PACKAGE"
scoped MSRs to have "DIE" in their name instead.  The ship with
those names sailed long ago.

I think the code above reflects its function, and that somebody maintaining
it will be clear on this.  That is important, because in the future, there will
be a concept of PACKAGE scoped MSRs that span multiple DIE...

cheers,
Len Brown, Intel Open Source Technology Center
