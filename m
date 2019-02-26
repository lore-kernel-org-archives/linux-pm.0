From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 08/11] powercap/intel_rapl: Support multi-die/package
Date: Mon, 25 Feb 2019 23:41:58 -0500
Message-ID: <CAJvTdKnCSPzpr7NqqaKLTaBc5LuXjd0mwR7WhEkUK=pPuzTGaA@mail.gmail.com>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <3349c9e551eecbfe849320c0e938daf4e0126734.1550545163.git.len.brown@intel.com>
 <20190220110200.GD17969@hirez.programming.kicks-ass.net> <CAJvTdKnpOdDiCaW9ntkNof+Ji7+HPaQqEk=ou-hWnw-BJxMGTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJvTdKnpOdDiCaW9ntkNof+Ji7+HPaQqEk=ou-hWnw-BJxMGTQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 21, 2019 at 12:44 AM Len Brown <lenb@kernel.org> wrote:
>
> On Wed, Feb 20, 2019 at 6:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > >       list_for_each_entry(rp, &rapl_packages, plist) {
> > > @@ -1457,7 +1457,7 @@ static void rapl_remove_package(struct rapl_package *rp)
> > >  /* called from CPU hotplug notifier, hotplug lock held */
> > >  static struct rapl_package *rapl_add_package(int cpu)
> > >  {
> > > -     int id = topology_physical_package_id(cpu);
> > > +     int id = topology_unique_die_id(cpu);
> > >       struct rapl_package *rp;
> > >       int ret;
> >
> > And now your new function names are misnomers.
>
> That is fair.
>
> Seems that a subsequent re-name-only patch is appropriate.

I'm not sure that re-naming these functions is a good idea.

Fundamentally, the reason stems from the SDM being in-consistent.
And the reason that the SDM is inconsistent is for compatibility.

ie. the PACKAGE MSRs in the SDM are still called PACKAGE MSRs,
even though on a multi-die system, they are DIE scoped.
There is no plan to re-name all of those MSRs.

And so what do you call a routine that parses a PACKAGE_RAPL domain?
Well, it is still called PACKAGE MSR, even though the code is smart enough
to know that on a multi-die system, its scope is die-scoped, not package-scoped.

And yes, just to confuse things, there WILL be PACKAGE scope MSRs
in the future that span multiple die on multi-die systems.  No, it will not
be a surprise when they appear -- by definition, they will be different
and incompatible with previous PACKAGE MSRs.  We will need to update
some software to be smart about handling them -- no blind assumptions
on using the word "package" in this context.

So unless Rui disagrees, I'm inclined to leave these routine names alone.

thanks,
Len Brown, Intel Open Source Technology Center
