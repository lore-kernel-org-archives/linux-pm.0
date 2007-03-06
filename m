From: Mark Gross <mgross@linux.intel.com>
Subject: Re: [RFC] [PATCH] Power Managed memory base enabling
Date: Tue, 6 Mar 2007 08:47:22 -0800
Message-ID: <20070306164722.GB22725@linux.intel.com>
References: <20070305181826.GA21515@linux.intel.com>
	<Pine.LNX.4.64.0703051941310.18703@chino.kir.corp.google.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703051941310.18703@chino.kir.corp.google.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Rientjes <rientjes@google.com>
Cc: linux-mm@kvack.org, mark.gross@intel.com, linux-pm@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, neelam.chandwani@intel.com
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 06, 2007 at 07:09:14AM -0800, David Rientjes wrote:
> On Mon, 5 Mar 2007, Mark Gross wrote:
> =

> > To exercise the capability on a platform with PM-memory, you will still
> > need to include a policy manager with some code to trigger the state
> > changes to enable transition into and out of a low power state. =

> > =

> =

> Thanks for pushing this type of work to the community.
> =

> What type of policy manager did you have in mind for state transition?  =

> Since you're basing it on existing NUMA code, are you looking at somethin=
g =

> like /sys/devices/system/node/node*/power that would be responsible for =

> migrating pages off the PM-memory it represents and then transitioning th=
e =

> hardware into a suspend or standby state?

For the initial version of HW that can do this we are stuck with
allocation based decisions where a complete solution needs page
migration.

Yes, a sysfs interface is being looked at to export the control to a
user mode daemon doing running some kind of policy manager, and if/when
page migration happens it will be hooked up to this interface.


> =

> The biggest concern is obviously going to be the interleaving.

Power friendly interleaving schemes will still be available.  They will
likely be limited to interleaving across at most 2 sticks.

The tests I've seen have shown that by-4 verses by-2 interleave on
modern hardware, isn't noticeable except for lmbench stream.  =


It may not be a one size fits all technology.

> =

> > More will be done, but for now we would like to get this base enabling
> > into the upstream kernel as an initial step.
> > =

> =

> Might be a premature question, but will there be upstream support for =

> transitioning the hardware state?  If so, it would be interesting to hear =

> what the preliminary enter and exit latencies are for each.

The code MC registers to re-train the memory lanes are somewhat
protected and will be implemented in the platform FW / BIOS.  I don't
think code to do that will be pushed up stream. =


> =

> Few comments on the patch follow.
> =

> > diff -urN -X linux-2.6.20-mm2/Documentation/dontdiff linux-2.6.20-mm2/a=
rch/x86_64/mm/numa.c linux-2.6.20-mm2-monroe/arch/x86_64/mm/numa.c
> > --- linux-2.6.20-mm2/arch/x86_64/mm/numa.c	2007-02-23 11:20:38.00000000=
0 -0800
> > +++ linux-2.6.20-mm2-monroe/arch/x86_64/mm/numa.c	2007-03-02 15:15:53.0=
00000000 -0800
> > @@ -156,12 +156,55 @@
> >  }
> >  #endif
> >  =

> > +/* we need a place to save the next start address to use for each node=
 because
> > + * we need to allocate the pgdata and bootmem for power managed memory=
 in
> > + * non-power managed nodes.  We do this by saving off where we can sta=
rt
> > + * allocating in the nodes and updating them as the boot up proceeds.
> > + */
> > +static unsigned long bootmem_start[MAX_NUMNODES];
> > +
> =

> When we're going through setup_node_bootmem(), we're already going to hav=
e =

> the pm_node[] information populated for power management node detection. =

> It can be represented by a nodemask (see below).  So the code in =

> early_node_mem() could be simplified and more robust by eliminating =

> bootmem_start[] and exporting nodes_parsed from srat.c.
> =

> We can get away with this because nodes_parsed is marked __initdata and =

> will still be valid at this point.
> =

> >  static void * __init
> >  early_node_mem(int nodeid, unsigned long start, unsigned long end,
> >  	      unsigned long size)
> >  {
> > -	unsigned long mem =3D find_e820_area(start, end, size);
> > +	unsigned long mem;
> >  	void *ptr;
> > +	if (bootmem_start[nodeid] <=3D start) {
> > +		bootmem_start[nodeid] =3D start;
> > +	}
> > +
> > +	mem =3D -1L;
> > +	if (power_managed_node(nodeid)) {
> > +		int non_pm_node =3D find_closest_non_pm_node(nodeid);
> > +
> > +		if (!node_online(non_pm_node)) {
> > +			return NULL; /* expect nodeid to get setup on the next
> > +					pass of setup_node_boot_mem after
> > +					non_pm_node is online*/
> > +		} else {
> > +			/* We set up the allocation in the non_pm_node
> > +			 * get the end of non_pm_node boot allocations
> > +			 * allocate from there.
> > +			 */
> > +			unsigned int non_pm_end;
> > +
> > +			non_pm_end =3D (NODE_DATA(non_pm_node)->node_start_pfn +
> > +				NODE_DATA(non_pm_node)->node_spanned_pages)
> > +					<< PAGE_SHIFT;
> > +
> > +			mem =3D find_e820_area(bootmem_start[non_pm_node],
> > +					non_pm_end, size);
> > +			/* now increment bootmem_start for next call */
> > +			if (mem!=3D -1L)
> > +				bootmem_start[non_pm_node] =3D
> > +					round_up(mem + size, PAGE_SIZE);
> > +		}
> > +	} else {
> > +		mem =3D find_e820_area(bootmem_start[nodeid], end, size);
> > +		if (mem!=3D -1L)
> > +			bootmem_start[nodeid] =3D round_up(mem + size, PAGE_SIZE);
> > +	}	=

> >  	if (mem !=3D -1L)
> >  		return __va(mem);
> >  	ptr =3D __alloc_bootmem_nopanic(size,
> =

> Then the change above becomes much easier:
> =

> 	if (power_managed_node(nodeid)) {
> 		int new_node =3D node_remap(nodeid, *nodes_parsed, *pm_nodes);
> 		if (nodeid !=3D new_node) {
> 			start =3D NODE_DATA(new_node)->node_start_pfn;
> 			end =3D start + NODE_DATA(new_node)->node_spanned_pages;
> 		}
> 	}
> 	mem =3D find_e820_area(start, end, size);
> =


Let me give your idea a spin and get back to you. =



> > diff -urN -X linux-2.6.20-mm2/Documentation/dontdiff linux-2.6.20-mm2/a=
rch/x86_64/mm/srat.c linux-2.6.20-mm2-monroe/arch/x86_64/mm/srat.c
> > --- linux-2.6.20-mm2/arch/x86_64/mm/srat.c	2007-02-23 11:20:38.00000000=
0 -0800
> > +++ linux-2.6.20-mm2-monroe/arch/x86_64/mm/srat.c	2007-03-02 15:15:53.0=
00000000 -0800
> > @@ -28,6 +28,7 @@
> >  static nodemask_t nodes_parsed __initdata;
> >  static struct bootnode nodes[MAX_NUMNODES] __initdata;
> >  static struct bootnode nodes_add[MAX_NUMNODES];
> > +static int pm_node[MAX_NUMNODES];
> >  static int found_add_area __initdata;
> >  int hotadd_percent __initdata =3D 0;
> >  =

> =

> I would recommend making this a nodemask that is an extern from =

> include/asm-x86_64/numa.h:
> =

> 	nodemask_t pm_nodes;
> =

> > @@ -479,5 +482,36 @@
> >  =

> >  	return ret;
> >  }
> > -EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> >  =

> > +int __power_managed_node(int srat_node)
> > +{
> > +	return pm_node[node_to_pxm(srat_node)];
> > +}
> > +
> > +int __power_managed_memory_present(void)
> > +{
> > +	int j;
> > +
> > +	for (j=3D0; j<MAX_LOCAL_APIC; j++) {
> > +		if(__power_managed_node(j) )
> > +			return 1;
> > +	}
> > +	return 0;
> > +}
> > +
> > +int __find_closest_non_pm_node(int nodeid)
> > +{
> > +	int i, dist, closest, temp;
> > +
> > +	dist =3D closest=3D 255;
> > +	for_each_node(i) {
> > +		if ((i !=3D nodeid) && !power_managed_node(i)) {
> > +			temp =3D __node_distance(nodeid, i );
> > +			if (temp < dist) {
> > +				closest =3D i;
> > +				dist =3D temp;
> > +			}
> > +		}
> > +	}
> > +	return closest;
> > +}
> =

> Then all these functions become trivial:
> =

> 	int __power_managed_node(int nid)
> 	{
> 		return node_isset(node_to_pxm(nid), pm_nodes);
> 	}
> =

> 	int __power_managed_memory_present(void)
> 	{
> 		return !nodes_empty(pm_nodes);
> 	}
> =

> 	int __find_closest_non_pm_node(int nid)
> 	{
> 		int node;
> 		node =3D next_node(nid, pm_nodes);
> 		if (node =3D=3D MAX_NUMNODES)
> 			node =3D first_node(pm_nodes);
> 	}
> =

> > diff -urN -X linux-2.6.20-mm2/Documentation/dontdiff linux-2.6.20-mm2/m=
m/memory.c linux-2.6.20-mm2-monroe/mm/memory.c
> > --- linux-2.6.20-mm2/mm/memory.c	2007-02-23 11:20:40.000000000 -0800
> > +++ linux-2.6.20-mm2-monroe/mm/memory.c	2007-03-02 15:15:53.000000000 -=
0800
> > @@ -2882,3 +2882,29 @@
> >  	return buf - old_buf;
> >  }
> >  EXPORT_SYMBOL_GPL(access_process_vm);
> > +
> > +#ifdef __x86_64__
> > +extern int __power_managed_memory_present(void);
> > +extern int __power_managed_node(int srat_node);
> > +extern int __find_closest_non_pm_node(int nodeid);
> > +#else
> > +inline int __power_managed_memory_present(void) { return 0};
> > +inline int __power_managed_node(int srat_node) { return 0};
> > +inline int __find_closest_non_pm_node(int nodeid) { return nodeid};
> > +#endif
> > +
> > +int power_managed_memory_present(void)
> > +{
> > +	return __power_managed_memory_present();
> > +}
> > +
> > +int power_managed_node(int srat_node)
> > +{
> > +	return __power_managed_node(srat_node);
> > +}
> > +
> > +int find_closest_non_pm_node(int nodeid)
> > +{
> > +	return __find_closest_non_pm_node(nodeid);
> > +}
> > +
> =

> Probably should reconsider extern declarations in .c files.
>

Yeah, but I couldn't think of a better place to put this code or how to
make it portable to non x86_64 architectures.  Recommendations gratefully
accepted.


> > diff -urN -X linux-2.6.20-mm2/Documentation/dontdiff linux-2.6.20-mm2/m=
m/mempolicy.c linux-2.6.20-mm2-monroe/mm/mempolicy.c
> > --- linux-2.6.20-mm2/mm/mempolicy.c	2007-02-23 11:20:40.000000000 -0800
> > +++ linux-2.6.20-mm2-monroe/mm/mempolicy.c	2007-03-02 15:15:53.00000000=
0 -0800
> > @@ -1617,8 +1617,13 @@
> >  	/* Set interleaving policy for system init. This way not all
> >  	   the data structures allocated at system boot end up in node zero. =
*/
> >  =

> > -	if (do_set_mempolicy(MPOL_INTERLEAVE, &node_online_map))
> > -		printk("numa_policy_init: interleaving failed\n");
> > +	if (power_managed_memory_present()) {
> > +		if (do_set_mempolicy(MPOL_DEFAULT, &node_online_map))
> > +			printk("numa_policy_init: interleaving failed\n");
> > +	} else {
> > +		if (do_set_mempolicy(MPOL_INTERLEAVE, &node_online_map))
> > +			printk("numa_policy_init: interleaving failed\n");
> > +	}
> >  }
> >  =

> >  /* Reset policy of current process to default */
> =

> These prink comments are misleading since MPOL_DEFAULT doesn't attempt to =

> set interleaving policy.
>
oop, cut and paste bug. =



Thanks,

--mgross
