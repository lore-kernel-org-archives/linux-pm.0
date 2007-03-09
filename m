From: Mark Gross <mgross@linux.intel.com>
Subject: Re: [RFC] [PATCH] Power Managed memory base enabling
Date: Fri, 9 Mar 2007 12:53:44 -0800
Message-ID: <20070309205344.GA16777@linux.intel.com>
References: <20070305181826.GA21515@linux.intel.com>
	<Pine.LNX.4.64.0703051941310.18703@chino.kir.corp.google.com>
	<20070306164722.GB22725@linux.intel.com>
	<Pine.LNX.4.64.0703061838390.13314@chino.kir.corp.google.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703061838390.13314@chino.kir.corp.google.com>
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

On Tue, Mar 06, 2007 at 06:40:36PM -0800, David Rientjes wrote:
> On Tue, 6 Mar 2007, Mark Gross wrote:
> =

> > Let me give your idea a spin and get back to you. =

> > =

> =

> Something like the following might be a little better.

Thanks!  I've got things cleaned up and working with as many of your
ideas as I could get working.  I liked many of the changes you offered
in the patch you sent to me off list.  =


One thing I found was your patch didn't use the SLIT data in computing
the nearest non PM node, and I had to be careful about the difference
between the PM memory PXM bitmap and node id's.  After I accounted for
the not_to_pxm mapping things started working for me.

BTW re basing to 2.6.21rc3mm2, resulted in one 4k allocation in my
PM-zones.  I'll be looking for where that allocation is coming from
after I get this post finished.

--mgross

Singed-off-by: Mark Gross <mark.gross@intel.com>

diff -urN -X linux-2.6.21rc3mm2/Documentation/dontdiff linux-2.6.21rc3mm2/a=
rch/x86_64/mm/numa.c linux-2.6.21rc3mm2-monroe/arch/x86_64/mm/numa.c
--- linux-2.6.21rc3mm2/arch/x86_64/mm/numa.c	2007-03-08 11:14:19.000000000 =
-0800
+++ linux-2.6.21rc3mm2-monroe/arch/x86_64/mm/numa.c	2007-03-09 10:23:25.000=
000000 -0800
@@ -155,19 +155,47 @@
 }
 #endif
 =

+/* we need a place to save the next start address to use for each node bec=
ause
+ * we need to allocate the pgdata and bootmem for power managed memory in
+ * non-power managed nodes.  We do this by saving off where we can start
+ * allocating in the nodes and updating them as the boot up proceeds.
+ */
+static unsigned long bootmem_start[MAX_NUMNODES];
+
+
 static void * __init
 early_node_mem(int nodeid, unsigned long start, unsigned long end,
 	      unsigned long size)
 {
-	unsigned long mem =3D find_e820_area(start, end, size);
+	unsigned long mem;
 	void *ptr;
-	if (mem !=3D -1L)
+	int nid;
+	=

+	if (bootmem_start[nodeid] < start) {
+		bootmem_start[nodeid] =3D start;
+	}
+
+	mem =3D -1L;
+	nid =3D nearest_non_pm_node(nodeid);
+	if (nid !=3D nodeid) {
+		if (!node_online(nid))
+			return NULL;
+
+		end =3D (NODE_DATA(nid)->node_start_pfn +
+			NODE_DATA(nid)->node_spanned_pages)
+				<< PAGE_SHIFT;
+	}
+	mem =3D find_e820_area(bootmem_start[nid], end, size);
+	if (mem!=3D -1L) {
+		/* now increment bootmem_start for next call */
+		bootmem_start[nid] =3D round_up(mem + size, PAGE_SIZE);
 		return __va(mem);
+	}
 	ptr =3D __alloc_bootmem_nopanic(size,
 				SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS));
 	if (ptr =3D=3D 0) {
 		printk(KERN_ERR "Cannot find %lu bytes in node %d\n",
-			size, nodeid);
+			size, nid);
 		return NULL;
 	}
 	return ptr;
@@ -179,6 +207,7 @@
 	unsigned long start_pfn, end_pfn, bootmap_pages, bootmap_size, bootmap_st=
art; =

 	unsigned long nodedata_phys;
 	void *bootmap;
+	int non_pm_node =3D nearest_non_pm_node(nodeid);
 	const int pgdat_size =3D round_up(sizeof(pg_data_t), PAGE_SIZE);
 =

 	start =3D round_up(start, ZONE_ALIGN); =

@@ -218,8 +247,8 @@
 =

 	free_bootmem_with_active_regions(nodeid, end);
 =

-	reserve_bootmem_node(NODE_DATA(nodeid), nodedata_phys, pgdat_size); =

-	reserve_bootmem_node(NODE_DATA(nodeid), bootmap_start, bootmap_pages<<PAG=
E_SHIFT);
+	reserve_bootmem_node(NODE_DATA(non_pm_node), nodedata_phys, pgdat_size);
+	reserve_bootmem_node(NODE_DATA(non_pm_node), bootmap_start, bootmap_pages=
<<PAGE_SHIFT);
 #ifdef CONFIG_ACPI_NUMA
 	srat_reserve_add_area(nodeid);
 #endif
@@ -230,8 +259,9 @@
 void __init setup_node_zones(int nodeid)
 { =

 	unsigned long start_pfn, end_pfn, memmapsize, limit;
+	int non_pm_node =3D nearest_non_pm_node(nodeid);
 =

- 	start_pfn =3D node_start_pfn(nodeid);
+	start_pfn =3D node_start_pfn(nodeid);
  	end_pfn =3D node_end_pfn(nodeid);
 =

 	Dprintk(KERN_INFO "Setting up memmap for node %d %lx-%lx\n",
@@ -242,11 +272,11 @@
 	memmapsize =3D sizeof(struct page) * (end_pfn-start_pfn);
 	limit =3D end_pfn << PAGE_SHIFT;
 #ifdef CONFIG_FLAT_NODE_MEM_MAP
-	NODE_DATA(nodeid)->node_mem_map =3D =

-		__alloc_bootmem_core(NODE_DATA(nodeid)->bdata, =

-				memmapsize, SMP_CACHE_BYTES, =

-				round_down(limit - memmapsize, PAGE_SIZE), =

-				limit);
+	NODE_DATA(nodeid)->node_mem_map =3D
+		__alloc_bootmem_core(NODE_DATA(non_pm_node)->bdata,
+			memmapsize, SMP_CACHE_BYTES,
+			round_down(limit - memmapsize, PAGE_SIZE),
+			limit);
 	printk(KERN_DEBUG "Node %d memmap at 0x%p size %lu first pfn 0x%p\n",
 			nodeid, NODE_DATA(nodeid)->node_mem_map,
 			memmapsize, NODE_DATA(nodeid)->node_mem_map);
@@ -265,7 +295,8 @@
 	for (i =3D 0; i < NR_CPUS; i++) {
 		if (cpu_to_node[i] !=3D NUMA_NO_NODE)
 			continue;
- 		numa_set_node(i, rr);
+		numa_set_node(i,nearest_non_pm_node(rr));
+		//numa_set_node(i, rr);
 		rr =3D next_node(rr, node_online_map);
 		if (rr =3D=3D MAX_NUMNODES)
 			rr =3D first_node(node_online_map);
diff -urN -X linux-2.6.21rc3mm2/Documentation/dontdiff linux-2.6.21rc3mm2/a=
rch/x86_64/mm/srat.c linux-2.6.21rc3mm2-monroe/arch/x86_64/mm/srat.c
--- linux-2.6.21rc3mm2/arch/x86_64/mm/srat.c	2007-03-08 11:14:19.000000000 =
-0800
+++ linux-2.6.21rc3mm2-monroe/arch/x86_64/mm/srat.c	2007-03-09 11:00:51.000=
000000 -0800
@@ -27,6 +27,7 @@
 =

 static nodemask_t nodes_parsed __initdata;
 static struct bootnode nodes_add[MAX_NUMNODES];
+static nodemask_t pm_nodes __read_mostly;
 static int found_add_area __initdata;
 int hotadd_percent __initdata =3D 0;
 =

@@ -34,6 +35,9 @@
    from BIOS bugs. */
 #define NODE_MIN_SIZE (4*1024*1024)
 =

+/* ACPI bit to represent power management node */
+#define POWER_MANAGEMENT_ACPI_BIT	(1 << 31)
+
 static __init int setup_node(int pxm)
 {
 	return acpi_map_pxm_to_node(pxm);
@@ -298,7 +302,10 @@
 		return;
 	start =3D ma->base_address;
 	end =3D start + ma->length;
-	pxm =3D ma->proximity_domain;
+	pxm =3D ma->proximity_domain & ~POWER_MANAGEMENT_ACPI_BIT;
+	if (ma->proximity_domain & POWER_MANAGEMENT_ACPI_BIT)
+		node_set(pxm, pm_nodes);
+
 	node =3D setup_node(pxm);
 	if (node < 0) {
 		printk(KERN_ERR "SRAT: Too many proximity domains.\n");
@@ -486,3 +493,35 @@
 }
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 =

+int __power_managed_node(int nid)
+{
+	return node_isset(node_to_pxm(nid), pm_nodes);
+}
+
+int __power_managed_memory_present(void)
+{
+	return !nodes_empty(pm_nodes);
+}
+
+int __nearest_non_pm_node(int nid)
+{
+	int i, dist, closest, temp;
+	=

+	if (!__power_managed_node(nid))
+		return nid;
+	dist =3D closest=3D 255;
+	for_each_node(i) {
+		if (__power_managed_node(i))
+			continue;
+
+		if (i !=3D nid) {
+			temp =3D __node_distance(nid, i );
+			if (temp < dist) {
+				closest =3D i;
+				dist =3D temp;
+			}
+		}
+	}
+	BUG_ON(closest =3D=3D 255);
+	return closest;
+}
diff -urN -X linux-2.6.21rc3mm2/Documentation/dontdiff linux-2.6.21rc3mm2/i=
nclude/asm-x86_64/topology.h linux-2.6.21rc3mm2-monroe/include/asm-x86_64/t=
opology.h
--- linux-2.6.21rc3mm2/include/asm-x86_64/topology.h	2007-03-08 11:14:20.00=
0000000 -0800
+++ linux-2.6.21rc3mm2-monroe/include/asm-x86_64/topology.h	2007-03-09 10:2=
3:25.000000000 -0800
@@ -18,6 +18,13 @@
 /* #else fallback version */
 #endif
 =

+extern int __power_managed_node(int);
+extern int __power_managed_memory_present(void);
+extern int __nearest_non_pm_node(int);
+#define power_managed_node(nid)		__power_managed_node(nid)
+#define power_managed_memory_present()	__power_managed_memory_present()
+#define nearest_non_pm_node(nid)	__nearest_non_pm_node(nid)
+
 #define cpu_to_node(cpu)		(cpu_to_node[cpu])
 #define parent_node(node)		(node)
 #define node_to_first_cpu(node) 	(first_cpu(node_to_cpumask[node]))
diff -urN -X linux-2.6.21rc3mm2/Documentation/dontdiff linux-2.6.21rc3mm2/i=
nclude/linux/topology.h linux-2.6.21rc3mm2-monroe/include/linux/topology.h
--- linux-2.6.21rc3mm2/include/linux/topology.h	2007-03-08 11:14:08.0000000=
00 -0800
+++ linux-2.6.21rc3mm2-monroe/include/linux/topology.h	2007-03-09 10:23:25.=
000000000 -0800
@@ -67,6 +67,24 @@
 #ifndef PENALTY_FOR_NODE_WITH_CPUS
 #define PENALTY_FOR_NODE_WITH_CPUS	(1)
 #endif
+#ifndef power_managed_node
+static inline int power_managed_node(int nid)
+{
+	return 0;
+}
+#endif
+#ifndef power_managed_memory_present
+static inline int power_managed_memory_present(void)
+{
+	return 0;
+}
+#endif
+#ifndef nearest_non_pm_node
+static inline int nearest_non_pm_node(int nid)
+{
+	return nid;
+}
+#endif
 =

 /*
  * Below are the 3 major initializers used in building sched_domains:
diff -urN -X linux-2.6.21rc3mm2/Documentation/dontdiff linux-2.6.21rc3mm2/m=
m/bootmem.c linux-2.6.21rc3mm2-monroe/mm/bootmem.c
--- linux-2.6.21rc3mm2/mm/bootmem.c	2007-02-04 10:44:54.000000000 -0800
+++ linux-2.6.21rc3mm2-monroe/mm/bootmem.c	2007-03-09 10:23:25.000000000 -0=
800
@@ -417,11 +417,14 @@
 void * __init __alloc_bootmem_nopanic(unsigned long size, unsigned long al=
ign,
 				      unsigned long goal)
 {
-	bootmem_data_t *bdata;
 	void *ptr;
+	int i;
 =

-	list_for_each_entry(bdata, &bdata_list, list) {
-		ptr =3D __alloc_bootmem_core(bdata, size, align, goal, 0);
+	for_each_online_node(i) {
+		if (power_managed_node(i))
+			continue;
+		ptr =3D __alloc_bootmem_core(NODE_DATA(i)->bdata, size,
+					align, goal, 0);
 		if (ptr)
 			return ptr;
 	}
@@ -463,12 +466,14 @@
 void * __init __alloc_bootmem_low(unsigned long size, unsigned long align,
 				  unsigned long goal)
 {
-	bootmem_data_t *bdata;
 	void *ptr;
+	int i;
 =

-	list_for_each_entry(bdata, &bdata_list, list) {
-		ptr =3D __alloc_bootmem_core(bdata, size, align, goal,
-						ARCH_LOW_ADDRESS_LIMIT);
+	for_each_online_node(i) {
+		if (power_managed_node(i))
+			continue;
+		ptr =3D __alloc_bootmem_core(NODE_DATA(i)->bdata, size, align,
+					goal, ARCH_LOW_ADDRESS_LIMIT);
 		if (ptr)
 			return ptr;
 	}
diff -urN -X linux-2.6.21rc3mm2/Documentation/dontdiff linux-2.6.21rc3mm2/m=
m/mempolicy.c linux-2.6.21rc3mm2-monroe/mm/mempolicy.c
--- linux-2.6.21rc3mm2/mm/mempolicy.c	2007-03-08 11:14:20.000000000 -0800
+++ linux-2.6.21rc3mm2-monroe/mm/mempolicy.c	2007-03-09 10:23:25.000000000 =
-0800
@@ -1609,8 +1609,13 @@
 	/* Set interleaving policy for system init. This way not all
 	   the data structures allocated at system boot end up in node zero. */
 =

-	if (do_set_mempolicy(MPOL_INTERLEAVE, &node_online_map))
-		printk("numa_policy_init: interleaving failed\n");
+	if (power_managed_memory_present()) {
+		if (do_set_mempolicy(MPOL_DEFAULT, &node_online_map))
+			printk("numa_policy_init: default failed\n");
+	} else {
+		if (do_set_mempolicy(MPOL_INTERLEAVE, &node_online_map))
+			printk("numa_policy_init: interleaving failed\n");
+	}
 }
 =

 /* Reset policy of current process to default */
diff -urN -X linux-2.6.21rc3mm2/Documentation/dontdiff linux-2.6.21rc3mm2/m=
m/page_alloc.c linux-2.6.21rc3mm2-monroe/mm/page_alloc.c
--- linux-2.6.21rc3mm2/mm/page_alloc.c	2007-03-08 11:14:20.000000000 -0800
+++ linux-2.6.21rc3mm2-monroe/mm/page_alloc.c	2007-03-09 10:23:25.000000000=
 -0800
@@ -2600,8 +2600,10 @@
 					* sizeof(wait_queue_head_t);
 =

  	if (system_state =3D=3D SYSTEM_BOOTING) {
+		int nid =3D nearest_non_pm_node(pgdat->node_id);
+		=

 		zone->wait_table =3D (wait_queue_head_t *)
-			alloc_bootmem_node(pgdat, alloc_size);
+			alloc_bootmem_node(NODE_DATA(nid), alloc_size);
 	} else {
 		/*
 		 * This case means that a zone whose size was 0 gets new memory
@@ -3215,8 +3217,11 @@
 		end =3D ALIGN(end, MAX_ORDER_NR_PAGES);
 		size =3D  (end - start) * sizeof(struct page);
 		map =3D alloc_remap(pgdat->node_id, size);
-		if (!map)
-			map =3D alloc_bootmem_node(pgdat, size);
+		if (!map) {
+			int nid =3D nearest_non_pm_node(pgdat->node_id);
+
+			map =3D alloc_bootmem_node(NODE_DATA(nid), size);
+		}
 		pgdat->node_mem_map =3D map + (pgdat->node_start_pfn - start);
 		printk(KERN_DEBUG
 			"Node %d memmap at 0x%p size %lu first pfn 0x%p\n",
diff -urN -X linux-2.6.21rc3mm2/Documentation/dontdiff linux-2.6.21rc3mm2/m=
m/slab.c linux-2.6.21rc3mm2-monroe/mm/slab.c
--- linux-2.6.21rc3mm2/mm/slab.c	2007-03-08 11:14:20.000000000 -0800
+++ linux-2.6.21rc3mm2-monroe/mm/slab.c	2007-03-09 10:23:25.000000000 -0800
@@ -3399,6 +3399,7 @@
 	if (unlikely(nodeid =3D=3D -1))
 		nodeid =3D numa_node_id();
 =

+	nodeid =3D nearest_non_pm_node(nodeid);
 	if (unlikely(!cachep->nodelists[nodeid])) {
 		/* Node not bootstrapped yet */
 		ptr =3D fallback_alloc(cachep, flags);
@@ -3672,6 +3673,7 @@
 #ifdef CONFIG_NUMA
 void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int no=
deid)
 {
+	nodeid =3D nearest_non_pm_node(nodeid);
 	return __cache_alloc_node(cachep, flags, nodeid,
 			__builtin_return_address(0));
 }
diff -urN -X linux-2.6.21rc3mm2/Documentation/dontdiff linux-2.6.21rc3mm2/m=
m/sparse.c linux-2.6.21rc3mm2-monroe/mm/sparse.c
--- linux-2.6.21rc3mm2/mm/sparse.c	2007-02-04 10:44:54.000000000 -0800
+++ linux-2.6.21rc3mm2-monroe/mm/sparse.c	2007-03-09 10:23:25.000000000 -08=
00
@@ -49,7 +49,8 @@
 	struct mem_section *section =3D NULL;
 	unsigned long array_size =3D SECTIONS_PER_ROOT *
 				   sizeof(struct mem_section);
-
+	=

+	nid =3D nearest_non_pm_node(nid);
 	if (slab_is_available())
 		section =3D kmalloc_node(array_size, GFP_KERNEL, nid);
 	else
@@ -215,6 +216,7 @@
 	struct mem_section *ms =3D __nr_to_section(pnum);
 	int nid =3D sparse_early_nid(ms);
 =

+	nid =3D nearest_non_pm_node(nid);
 	map =3D alloc_remap(nid, sizeof(struct page) * PAGES_PER_SECTION);
 	if (map)
 		return map;
