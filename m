From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Fix cpupower reporting uninitialized values for offline cpus
Date: Mon, 19 Oct 2015 17:39:18 +0200
Message-ID: <2009729.RxmnnDn8cy@skinner>
References: <1443726584-18709-1-git-send-email-jtanenba@redhat.com> <9276359.hpYRDABKuX@skinner> <5624F295.3070101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35630 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138AbbJSPjU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 19 Oct 2015 11:39:20 -0400
In-Reply-To: <5624F295.3070101@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Tanenbaum <jtanenba@redhat.com>
Cc: prarit@redhat.com, linux-pm@vger.kernel.org

On Monday, October 19, 2015 09:39:33 AM Jacob Tanenbaum wrote:
> On 10/16/2015 10:32 AM, Thomas Renninger wrote:
> > On Thursday, October 15, 2015 06:06:04 PM Jacob Tanenbaum wrote:
> >> Hi Thomas,
> >> 
> >> Have you gotten a chance to look at this patch?
> > 
> > Yes, but there are issues and I did not had time to come up with
> > a modified patch or concrete suggestions.
> > 
> > Ok, let's discuss things first and get to a patch everybody agrees to.
> > I have 2 orther patches, I can then pick this one as well and send
> > all to Rafael.
> > 
> > ...
> 
> your suggestions look pretty good, I just have a question on one and a
> correction to show you here.
> 
> >>> diff --git a/tools/power/cpupower/utils/helpers/topology.c
> >>> b/tools/power/cpupower/utils/helpers/topology.c index cea398c..019a712
> >>> 100644
> >>> --- a/tools/power/cpupower/utils/helpers/topology.c
> >>> +++ b/tools/power/cpupower/utils/helpers/topology.c
> >>> @@ -73,8 +73,11 @@ int get_cpu_topology(struct cpupower_topology
> >>> *cpu_top)
> >>> 
> >>>    	for (cpu = 0; cpu < cpus; cpu++) {
> >>>    	
> >>>    		cpu_top->core_info[cpu].cpu = cpu;
> >>>    		cpu_top->core_info[cpu].is_online = sysfs_is_cpu_online(cpu);
> >>> 
> >>> -		if (!cpu_top->core_info[cpu].is_online)
> >>> +		if (!cpu_top->core_info[cpu].is_online) {
> >>> +			cpu_top->core_info[cpu].pkg = -1;
> >>> +			cpu_top->core_info[cpu].core = -1;
> >>> 
> >>>    			continue;
> >>> 
> >>> +		}
> > 
> > But here we said, we do not want to check for (soft/real) online/offline.
> > When the CPU is soft-offlined, in future there might
> > still be sane values in the topology fields?
> > So better first do sysfs_topology_read_file() and then check for offline.
> 
> You are right the flow here is better and allows for more sane behavior
> when/if other sysfs changes are implemented.
> 
> >>>    		if(sysfs_topology_read_file(
> >>>    		
> >>>    			cpu,
> >>>    			"physical_package_id",
> >>> 
> >>> @@ -95,12 +98,15 @@ int get_cpu_topology(struct cpupower_topology
> >>> *cpu_top)
> >>> 
> >>>    	   done by pkg value. */
> >>>    	
> >>>    	last_pkg = cpu_top->core_info[0].pkg;
> >>>    	for(cpu = 1; cpu < cpus; cpu++) {
> >>> 
> >>> -		if(cpu_top->core_info[cpu].pkg != last_pkg) {
> >>> +		if (cpu_top->core_info[cpu].pkg != last_pkg &&
> >>> +				cpu_top->core_info[cpu].pkg != -1) {
> >>> +
> >>> 
> >>>    			last_pkg = cpu_top->core_info[cpu].pkg;
> >>>    			cpu_top->pkgs++;
> >>>    		
> >>>    		}
> >>>    	
> >>>    	}
> >>> 
> >>> -	cpu_top->pkgs++;
> >>> +	if (!cpu_top->core_info[0].is_online)
> >>> +		cpu_top->pkgs++;
> > 
> > Why is that?
> > 
> > I guess we can leave this:
> >>> +	if (!cpu_top->core_info[0].is_online)
> >>> +		cpu_top->pkgs++;
> > 
> > out?
> 
> That is needed because adding an offline cpu creates an additional
> package at the moment (we set offline CPU's physical_pakage_id= -1)
> so a machine with a single socket and an offline CPU will display as a
> two socket machine. The logic here was slightly
> incorrect, it should be "if(cpu->core_info[0].is_online)", but I think
> it would be better to check if cpu_top->core_info[0] == -1
> because that will do the right thing when the topology for offline CPU's
> is a sane value.

Ah yes, got it. Thanks.

...
> >>>    	/* Intel's cores count is not consecutively numbered, there may
> >>>    	
> >>>    	 * be a core_id of 3, but none of 2. Assume there always is 0
> >>> 
> >>> diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> >>> b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c index
> >>> c4bae92..8efc5b9 100644
> >>> --- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> >>> +++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> >>> @@ -143,6 +143,8 @@ void print_results(int topology_depth, int cpu)
> >>> 
> >>>    	/* Be careful CPUs may got resorted for pkg value do not just use
> >>>    	cpu
> >>>    	*/
> >>>    	if (!bitmask_isbitset(cpus_chosen, cpu_top.core_info[cpu].cpu))
> >>>    	
> >>>    		return;
> >>> 
> >>> +	if (!cpu_top.core_info[cpu].is_online)
> >>> +		return;
> >>> 
> >>>    	if (topology_depth > 2)
> >>>    	
> >>>    		printf("%4d|", cpu_top.core_info[cpu].pkg);
> >>> 
> >>> @@ -191,11 +193,7 @@ void print_results(int topology_depth, int cpu)
> >>> 
> >>>    	 * It's up to the monitor plug-in to check .is_online, this one
> >>>    	 * is just for additional info.
> >>>    	 */
> >>> 
> >>> -	if (!cpu_top.core_info[cpu].is_online) {
> >>> -		printf(_(" *is offline\n"));
> >>> -		return;
> >>> -	} else
> >>> -		printf("\n");
> > 
> > Hm, again. If this is a soft-offlined core and we may get topology
> > info for this one in the future, we want to show it as offlined.
> > -> It is important that this core, in this package (should) enter(s)
> > 
> >     deepest sleep states
> > 
> > We only want to totally remove it if it is hard-offlined.
> > 
> > This cannot be distinguished yet, but if we get a patch which
> > keeps topology files if soft-offlined, we can.
> > 
> > Please have a look at my modified one.
> > This one could automatically distinguish between:
> > - soft-offlined (as soon as a kernel patch would still show topology info)
> > - hard-offlined (nothing printed)
> 
> I like your modifications but as a question will we need to distinguish
> between hard-offlined
> and soft-offlined cpu's? Shouldn't the system forget about a
> hard-offlined cpu just like it does
> when hard-drives are removed?

Hm, this is what it does?
Hard-/soft is not checked at all.
IMO it would make sense to expose this (hard or softofflined)
to userspace at some point of time, but not sure cpupower could do
something useful with it.

If we can parse the topology information of a not available
core (which certainly must/may be softofflined), we should show
the info "Which core in which package/socket is offlined/missing".
As this is relevant information if you examine the power consumption
of the processors of your system, right?

Ok, let's do this short:
I fully agree with your patch, only one thing:

I'd like to keep to set both pkg and core to -1 in case one sysfs file,
core or package cannot be read:

                if(sysfs_topology_read_file(
                        cpu,
                        "physical_package_id",
-                       &(cpu_top->core_info[cpu].pkg)) < 0)
-                       return -1;
+                       &(cpu_top->core_info[cpu].pkg)) < 0) {
+                       cpu_top->core_info[cpu].pkg = -1;
+                       cpu_top->core_info[cpu].core = -1;
+                       continue;
+               }

The idea is: physical_package_id and core_id always must be
there, right? Not sure for other architectures, but what I see
this is at least the case for x86.

So if only one can be read, something is wrong. In fact this
would be the "race" case that a core is going offline right
at the moment and one sysfs has been removed already.
Yeah, this should never happen, but still either both are correct
or we shouldn't show or work with a -1 core/pkg id somewhere...

Yes, call it nit picking, it's a rare case... whatever.

I'll repost with some more patches tomorrow.

Thanks a lot!

        Thomas

