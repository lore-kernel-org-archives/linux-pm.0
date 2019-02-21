From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 08/11] powercap/intel_rapl: Support multi-die/package
Date: Thu, 21 Feb 2019 00:44:11 -0500
Message-ID: <CAJvTdKnpOdDiCaW9ntkNof+Ji7+HPaQqEk=ou-hWnw-BJxMGTQ@mail.gmail.com>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <3349c9e551eecbfe849320c0e938daf4e0126734.1550545163.git.len.brown@intel.com> <20190220110200.GD17969@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220110200.GD17969@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 20, 2019 at 6:02 AM Peter Zijlstra <peterz@infradead.org> wrote:

> >       list_for_each_entry(rp, &rapl_packages, plist) {
> > @@ -1457,7 +1457,7 @@ static void rapl_remove_package(struct rapl_package *rp)
> >  /* called from CPU hotplug notifier, hotplug lock held */
> >  static struct rapl_package *rapl_add_package(int cpu)
> >  {
> > -     int id = topology_physical_package_id(cpu);
> > +     int id = topology_unique_die_id(cpu);
> >       struct rapl_package *rp;
> >       int ret;
>
> And now your new function names are misnomers.

That is fair.

Seems that a subsequent re-name-only patch is appropriate.

Len Brown, Intel Open Source Technology Center
