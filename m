From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Fix cpupower reporting uninitialized values for offline cpus
Date: Fri, 16 Oct 2015 16:32:15 +0200
Message-ID: <9276359.hpYRDABKuX@skinner>
References: <1443726584-18709-1-git-send-email-jtanenba@redhat.com> <5620234C.5000104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54750 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbbJPOcR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 10:32:17 -0400
In-Reply-To: <5620234C.5000104@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Tanenbaum <jtanenba@redhat.com>
Cc: prarit@redhat.com, linux-pm@vger.kernel.org

On Thursday, October 15, 2015 06:06:04 PM Jacob Tanenbaum wrote:
> Hi Thomas,
> 
> Have you gotten a chance to look at this patch?

Yes, but there are issues and I did not had time to come up with
a modified patch or concrete suggestions.

Ok, let's discuss things first and get to a patch everybody agrees to.
I have 2 orther patches, I can then pick this one as well and send
all to Rafael.

...

> > 
> > diff --git a/tools/power/cpupower/utils/helpers/topology.c
> > b/tools/power/cpupower/utils/helpers/topology.c index cea398c..019a712
> > 100644
> > --- a/tools/power/cpupower/utils/helpers/topology.c
> > +++ b/tools/power/cpupower/utils/helpers/topology.c
> > @@ -73,8 +73,11 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
> > 
> >   	for (cpu = 0; cpu < cpus; cpu++) {
> >   	
> >   		cpu_top->core_info[cpu].cpu = cpu;
> >   		cpu_top->core_info[cpu].is_online = sysfs_is_cpu_online(cpu);
> > 
> > -		if (!cpu_top->core_info[cpu].is_online)
> > +		if (!cpu_top->core_info[cpu].is_online) {
> > +			cpu_top->core_info[cpu].pkg = -1;
> > +			cpu_top->core_info[cpu].core = -1;
> > 
> >   			continue;
> > 
> > +		}

But here we said, we do not want to check for (soft/real) online/offline.
When the CPU is soft-offlined, in future there might
still be sane values in the topology fields?
So better first do sysfs_topology_read_file() and then check for offline.

> >   		if(sysfs_topology_read_file(
> >   		
> >   			cpu,
> >   			"physical_package_id",
> > 
> > @@ -95,12 +98,15 @@ int get_cpu_topology(struct cpupower_topology
> > *cpu_top)
> > 
> >   	   done by pkg value. */
> >   	
> >   	last_pkg = cpu_top->core_info[0].pkg;
> >   	for(cpu = 1; cpu < cpus; cpu++) {
> > 
> > -		if(cpu_top->core_info[cpu].pkg != last_pkg) {
> > +		if (cpu_top->core_info[cpu].pkg != last_pkg &&
> > +				cpu_top->core_info[cpu].pkg != -1) {
> > +
> > 
> >   			last_pkg = cpu_top->core_info[cpu].pkg;
> >   			cpu_top->pkgs++;
> >   		
> >   		}
> >   	
> >   	}
> > 
> > -	cpu_top->pkgs++;
> > +	if (!cpu_top->core_info[0].is_online)
> > +		cpu_top->pkgs++;

Why is that?
I guess we can leave this:
> > +	if (!cpu_top->core_info[0].is_online)
> > +		cpu_top->pkgs++;
out?
Only place ->pkgs is checked is whether we have a multi socket machine.
If not, do not print CPU package id/core info:
cpupower monitor -mMperf
    |Mperf               
CPU | C0   | Cx   | Freq 
   0|  1.61| 98.39|  2585
   4|  2.59| 97.41|  2443
   1|  3.09| 96.91|  2537
   5|  1.01| 98.99|  2517
   2|  5.21| 94.79|  2583
   6|  2.08| 97.92|  2528
   3| 11.27| 88.73|  2686
   7|  1.69| 98.31|  2387

if yes, print the package details which are very relevant for CPU powersavings:

              |Mperf               
PKG |CORE|CPU | C0   | Cx   | Freq 
   0|   0|   0|  0.01| 99.99|  1448
   0|   0|  16|  0.00|100.00|  3134
..
   1|   0|   8|  0.00|100.00|  1199
   1|   0|  24|  0.00|100.00|   944
..

> > 
> >   	/* Intel's cores count is not consecutively numbered, there may
> >   	
> >   	 * be a core_id of 3, but none of 2. Assume there always is 0
> > 
> > diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> > b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c index
> > c4bae92..8efc5b9 100644
> > --- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> > +++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> > @@ -143,6 +143,8 @@ void print_results(int topology_depth, int cpu)
> > 
> >   	/* Be careful CPUs may got resorted for pkg value do not just use cpu
> >   	*/
> >   	if (!bitmask_isbitset(cpus_chosen, cpu_top.core_info[cpu].cpu))
> >   	
> >   		return;
> > 
> > +	if (!cpu_top.core_info[cpu].is_online)
> > +		return;
> > 
> >   	if (topology_depth > 2)
> >   	
> >   		printf("%4d|", cpu_top.core_info[cpu].pkg);
> > 
> > @@ -191,11 +193,7 @@ void print_results(int topology_depth, int cpu)
> > 
> >   	 * It's up to the monitor plug-in to check .is_online, this one
> >   	 * is just for additional info.
> >   	 */
> > 
> > -	if (!cpu_top.core_info[cpu].is_online) {
> > -		printf(_(" *is offline\n"));
> > -		return;
> > -	} else
> > -		printf("\n");

Hm, again. If this is a soft-offlined core and we may get topology
info for this one in the future, we want to show it as offlined.
-> It is important that this core, in this package (should) enter(s)
   deepest sleep states

We only want to totally remove it if it is hard-offlined.

This cannot be distinguished yet, but if we get a patch which
keeps topology files if soft-offlined, we can.

Please have a look at my modified one.
This one could automatically distinguish between:
- soft-offlined (as soon as a kernel patch would still show topology info)
- hard-offlined (nothing printed)

Thanks,

        Thomas


>From jtanenba@redhat.com Thu Oct 01 19:09:44 2015

cpupower monitor reports uninitialized values for offline cpus

[root@hp-dl980g7-02 linux]# cpupower monitor
...
5472|   0|   1|******|******|******|******||******|******|******|| 0.00|  0.00|  0.00|  0.00|  0.00 *is offline
10567|   0| 159|******|******|******|******||******|******|******||  0.00|  0.00|  0.00|  0.00|  0.00 *is offline
1661206560|859272560| 150|******|******|******|******||******|******|******|| 0.00|  0.00|  0.00|  0.00|  0.00 *is offline
1661206560|943093104| 140|******|******|******|******||******|******|******|| 0.00|  0.00|  0.00|  0.00|  0.00 *is offline

because of this cpupower also holds the incorrect value for the number
of physical packages in the machine

Changed cpupower to initialize the values of an offline cpu's socket and
core to -1, warn the user that one or more cpus is/are
offline and not print statistics for offline cpus.

Thomas Renninger suggested fixing the issue by checking for the
existence of the topology files which the code already does, so I
decided to use a check on if the cpu was online.

Example output after the patch is applied:
[root@hp-dl980g7-02 ~]# cpupower monitor
WARNING: at least one cpu is offline
              |Nehalem                    || Mperf              || Idle_Stats
PKG |CORE|CPU | C3   | C6   | PC3  | PC6  || C0   | Cx   | Freq || POLL || C1-N | C1E- | C3-N | C6-N
   0|   0|   0|  0.00| 99.37|  0.00|  0.00||  0.35| 99.65|  1596||  0.00|  0.00|  0.00|  0.00| 99.85
   0|   0|  80|  0.00| 99.37|  0.00|  0.00||  0.30| 99.70|  1645||  0.00|  0.00|  0.00|  0.00| 99.98
   0|   1|  81|  0.00| 99.53|  0.00|  0.00||  0.29| 99.71|  1655||  0.00|  0.00|  0.00|  0.00| 99.33
   0|   2|   2|  0.00| 99.47|  0.00|  0.00||  0.29| 99.71|  1660||  0.00|  0.00|  0.00|  0.00| 99.35
...

Signed-off-by: Jacob Tanenbaum <jtanenba@redhat.com>

diff --git a/tools/power/cpupower/utils/helpers/topology.c b/tools/power/cpupower/utils/helpers/topology.c
index cea398c..385fd7c 100644
--- a/tools/power/cpupower/utils/helpers/topology.c
+++ b/tools/power/cpupower/utils/helpers/topology.c
@@ -73,18 +73,22 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 	for (cpu = 0; cpu < cpus; cpu++) {
 		cpu_top->core_info[cpu].cpu = cpu;
 		cpu_top->core_info[cpu].is_online = sysfs_is_cpu_online(cpu);
-		if (!cpu_top->core_info[cpu].is_online)
-			continue;
 		if(sysfs_topology_read_file(
 			cpu,
 			"physical_package_id",
-			&(cpu_top->core_info[cpu].pkg)) < 0)
-			return -1;
+			&(cpu_top->core_info[cpu].pkg)) < 0) {
+			cpu_top->core_info[cpu].pkg = -1;
+			cpu_top->core_info[cpu].core = -1;
+			continue;
+		}
 		if(sysfs_topology_read_file(
 			cpu,
 			"core_id",
-			&(cpu_top->core_info[cpu].core)) < 0)
-			return -1;
+			&(cpu_top->core_info[cpu].core)) < 0) {
+			cpu_top->core_info[cpu].pkg = -1;
+			cpu_top->core_info[cpu].core = -1;
+			continue;
+		}
 	}
 
 	qsort(cpu_top->core_info, cpus, sizeof(struct cpuid_core_info),
@@ -95,12 +99,15 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 	   done by pkg value. */
 	last_pkg = cpu_top->core_info[0].pkg;
 	for(cpu = 1; cpu < cpus; cpu++) {
-		if(cpu_top->core_info[cpu].pkg != last_pkg) {
+		if (cpu_top->core_info[cpu].pkg != last_pkg &&
+				cpu_top->core_info[cpu].pkg != -1) {
+
 			last_pkg = cpu_top->core_info[cpu].pkg;
 			cpu_top->pkgs++;
 		}
 	}
-	cpu_top->pkgs++;
+	if (!cpu_top->core_info[0].is_online)
+		cpu_top->pkgs++;
 
 	/* Intel's cores count is not consecutively numbered, there may
 	 * be a core_id of 3, but none of 2. Assume there always is 0
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index c4bae92..05f953f 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -143,6 +143,9 @@ void print_results(int topology_depth, int cpu)
 	/* Be careful CPUs may got resorted for pkg value do not just use cpu */
 	if (!bitmask_isbitset(cpus_chosen, cpu_top.core_info[cpu].cpu))
 		return;
+	if (!cpu_top.core_info[cpu].is_online &&
+	    cpu_top.core_info[cpu].pkg == -1)
+		return;
 
 	if (topology_depth > 2)
 		printf("%4d|", cpu_top.core_info[cpu].pkg);
@@ -191,7 +194,8 @@ void print_results(int topology_depth, int cpu)
 	 * It's up to the monitor plug-in to check .is_online, this one
 	 * is just for additional info.
 	 */
-	if (!cpu_top.core_info[cpu].is_online) {
+	if (!cpu_top.core_info[cpu].is_online &&
+	    cpu_top.core_info[cpu].pkg != -1) {
 		printf(_(" *is offline\n"));
 		return;
 	} else
@@ -388,6 +392,9 @@ int cmd_monitor(int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
+	if (!cpu_top.core_info[0].is_online)
+		printf("WARNING: at least one cpu is offline\n");
+
 	/* Default is: monitor all CPUs */
 	if (bitmask_isallclear(cpus_chosen))
 		bitmask_setall(cpus_chosen);

