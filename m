From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 08/14] powercap/intel_rapl: Support multi-die/package
Date: Mon, 08 Apr 2019 09:35:47 +0800
Message-ID: <1554687347.2178.1.camel@intel.com>
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
         <680e11fe0dcc65e4cfa5bfeaa0d1cdbe7896e3c0.1551160674.git.len.brown@intel.com>
         <alpine.DEB.2.21.1904052022310.1802@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1904052022310.1802@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 五, 2019-04-05 at 20:27 +0200, Thomas Gleixner wrote:
> On Tue, 26 Feb 2019, Len Brown wrote:
> 
> > 
> > From: Zhang Rui <rui.zhang@intel.com>
> > 
> > On the new dual-die/package systems, the RAPL MSR becomes die-
> > scope.
> > Thus instead of one powercap device per physical package, now there
> > should be one powercap device for each unique die on these systems.
> > 
> > This patch introduces intel_rapl driver support for new
> > dual-die/package systems.
> This patch .... See Documentation/processs/
> 
> and this sentence is not really helpful either.
> 
> > 
> > On the hardwares that do not have multi-die,
> > topology_logical_die_id()
> > equals topology_physical_package_id(), thus there is no functional
> > change.
> Something like this:
> 
> To support this the RAPL package domain has to be identified by the
> die id
> instead of the package id. On single die CPUs the die id is the same
> as the
> physical package id.
> 
> Hmm?

Yeah, sounds much better.
Len, will you help me update the changelog or do you want me to send an
updated version to you?

thanks,
rui

> 
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > Signed-off-by: Len Brown <len.brown@intel.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: linux-pm@vger.kernel.org
> > ---
> >  drivers/powercap/intel_rapl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/powercap/intel_rapl.c
> > b/drivers/powercap/intel_rapl.c
> > index 6057d9695fed..8723e9ae7436 100644
> > --- a/drivers/powercap/intel_rapl.c
> > +++ b/drivers/powercap/intel_rapl.c
> > @@ -266,7 +266,7 @@ static struct rapl_domain
> > *platform_rapl_domain; /* Platform (PSys) domain */
> >  /* caller to ensure CPU hotplug lock is held */
> >  static struct rapl_package *rapl_find_package(int cpu)
> >  {
> > -	int id = topology_physical_package_id(cpu);
> > +	int id = topology_logical_die_id(cpu);
> >  	struct rapl_package *rp;
> >  
> >  	list_for_each_entry(rp, &rapl_packages, plist) {
> > @@ -1457,7 +1457,7 @@ static void rapl_remove_package(struct
> > rapl_package *rp)
> >  /* called from CPU hotplug notifier, hotplug lock held */
> >  static struct rapl_package *rapl_add_package(int cpu)
> >  {
> > -	int id = topology_physical_package_id(cpu);
> > +	int id = topology_logical_die_id(cpu);
> >  	struct rapl_package *rp;
> >  	int ret;
> >  
