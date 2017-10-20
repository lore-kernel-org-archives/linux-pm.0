From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 1/7] ACPI/PPTT: Add Processor Properties Topology
 Table parsing
Date: Fri, 20 Oct 2017 11:15:04 +0100
Message-ID: <20171020101453.GA22767@red-moon>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
 <20171012194856.13844-2-jeremy.linton@arm.com>
 <20171019102207.GB17450@red-moon>
 <100c52ef-4215-4d43-4c57-a5810f834fb9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <100c52ef-4215-4d43-4c57-a5810f834fb9@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 19, 2017 at 10:43:46AM -0500, Jeremy Linton wrote:
> On 10/19/2017 05:22 AM, Lorenzo Pieralisi wrote:
> >On Thu, Oct 12, 2017 at 02:48:50PM -0500, Jeremy Linton wrote:
> >>ACPI 6.2 adds a new table, which describes how processing units
> >>are related to each other in tree like fashion. Caches are
> >>also sprinkled throughout the tree and describe the properties
> >>of the caches in relation to other caches and processing units.
> >>
> >>Add the code to parse the cache hierarchy and report the total
> >>number of levels of cache for a given core using
> >>acpi_find_last_cache_level() as well as fill out the individual
> >>cores cache information with cache_setup_acpi() once the
> >>cpu_cacheinfo structure has been populated by the arch specific
> >>code.
> >>
> >>Further, report peers in the topology using setup_acpi_cpu_topology()
> >>to report a unique ID for each processing unit at a given level
> >>in the tree. These unique id's can then be used to match related
> >>processing units which exist as threads, COD (clusters
> >>on die), within a given package, etc.
> >
> >I think this patch should be split ((1) topology (2) cache), it is doing
> >too much which makes it hard to review.
> 
> If you look at the RFC, it only did cache parsing, the topology
> changes were added for v1. The cache bits are the ugly parts because
> they are walking up/down both the node tree, as well as the cache
> tree's attached to the nodes during the walk. Once that was in the
> place the addition of the cpu topology was trivial. But, trying to
> understand the cpu topology without first understanding the weird
> stuff done for the cache topology might not be the right way to
> approach this code.

Topology and cache bindings parsing seem decoupled to me:

cache_setup_acpi(cpu)
setup_acpi_cpu_topology(cpu, level)

I mentioned that because it can simplify review (and merging)
of this series.

> >
> >[...]
> >
> >>+/* determine if the given node is a leaf node */
> >>+static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
> >>+			       struct acpi_pptt_processor *node)
> >>+{
> >>+	struct acpi_subtable_header *entry;
> >>+	unsigned long table_end;
> >>+	u32 node_entry;
> >>+	struct acpi_pptt_processor *cpu_node;
> >>+
> >>+	table_end = (unsigned long)table_hdr + table_hdr->length;
> >>+	node_entry = (u32)((u8 *)node - (u8 *)table_hdr);
> >>+	entry = (struct acpi_subtable_header *)((u8 *)table_hdr +
> >>+						sizeof(struct acpi_table_pptt));
> >>+
> >>+	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) < table_end) {
> >>+		cpu_node = (struct acpi_pptt_processor *)entry;
> >>+		if ((entry->type == ACPI_PPTT_TYPE_PROCESSOR) &&
> >>+		    (cpu_node->parent == node_entry))
> >>+			return 0;
> >>+		entry = (struct acpi_subtable_header *)((u8 *)entry + entry->length);
> >>+	}
> >
> >A leaf node is a node with a valid acpi_id corresponding to an MADT
> >entry, right ? By the way, is this function really needed ?
> 
> Yes, because the only way to determine if it is a leaf node is to
> see if there are any references to it elsewhere in the table because
> the nodes point towards the root of the tree (rather than the other
> way).

The question is whether we need to know a node is a leaf, see below.

> This piece was the primary change for v1->v2.
> 
> >
> >>+	return 1;
> >>+}
> >>+
> >>+/*
> >>+ * Find the subtable entry describing the provided processor
> >>+ */
> >>+static struct acpi_pptt_processor *acpi_find_processor_node(
> >>+	struct acpi_table_header *table_hdr,
> >>+	u32 acpi_cpu_id)
> >>+{
> >>+	struct acpi_subtable_header *entry;
> >>+	unsigned long table_end;
> >>+	struct acpi_pptt_processor *cpu_node;
> >>+
> >>+	table_end = (unsigned long)table_hdr + table_hdr->length;
> >>+	entry = (struct acpi_subtable_header *)((u8 *)table_hdr +
> >>+						sizeof(struct acpi_table_pptt));
> >>+
> >>+	/* find the processor structure associated with this cpuid */
> >>+	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) < table_end) {
> >>+		cpu_node = (struct acpi_pptt_processor *)entry;
> >>+
> >>+		if ((entry->type == ACPI_PPTT_TYPE_PROCESSOR) &&
> >>+		    acpi_pptt_leaf_node(table_hdr, cpu_node)) {
> >
> >Is the leaf node check necessary ? Or you just need to check the
> >ACPI Processor ID valid flag (as discussed offline) ?
> 
> The valid flag doesn't mean anything for the leaf nodes, so its the
> only correct way of determining if the node _might_ have a valid
> madt/acpi ID. This actually should have the acpi_cpu_id checked as
> part of the if statement and the leaf node check below because doing
> it this way makes this parse n^2 instead of 2n. Of course in my
> mind, checking the id before we know it might be valid is backwards
> of the "logical" way to do it.

Ok, it is not clearly worded in the specs (we can update it though) but I
think the valid flag must be set for leaf nodes, which would make the
leaf node check useless because you just have to match a PPTT node with
a valid ACPI Processor ID.

Lorenzo

> >>+			pr_debug("checking phy_cpu_id %d against acpi id %d\n",
> >>+				 acpi_cpu_id, cpu_node->acpi_processor_id);
> >
> >Side note: I'd question (some of) these pr_debug() messages
> >
> >>+			if (acpi_cpu_id == cpu_node->acpi_processor_id) {
> >>+				/* found the correct entry */
> >>+				pr_debug("match found!\n");
> >
> >Like this one for instance.
> 
> This one is a bit redundant, but I come from the school that I want
> to be able to debug a remote machine. Large blocks of silent code
> are a nightmare, particularly if you have a sysadmin level user
> driving the keyboard/etc.
> 
> >
> >>+				return (struct acpi_pptt_processor *)entry;
> >>+			}
> >>+		}
> >>+
> >>+		if (entry->length == 0) {
> >>+			pr_err("Invalid zero length subtable\n");
> >>+			break;
> >>+		}
> >
> >This should be moved at the beginning of the loop.
> 
> Yah, the intention was to verify the next entry, but if its 0 then
> good point, the current one is probably invalid.
> 
> >
> >>+		entry = (struct acpi_subtable_header *)
> >>+			((u8 *)entry + entry->length);
> >>+	}
> >>+
> >>+	return NULL;
> >>+}
> >>+
> >>+/*
> >>+ * Given a acpi_pptt_processor node, walk up until we identify the
> >>+ * package that the node is associated with or we run out of levels
> >>+ * to request.
> >>+ */
> >>+static struct acpi_pptt_processor *acpi_find_processor_package_id(
> >>+	struct acpi_table_header *table_hdr,
> >>+	struct acpi_pptt_processor *cpu,
> >>+	int level)
> >>+{
> >>+	struct acpi_pptt_processor *prev_node;
> >>+
> >>+	while (cpu && level && !(cpu->flags & ACPI_PPTT_PHYSICAL_PACKAGE)) {
> >
> >I really do not understand what ACPI_PPTT_PHYSICAL_PACKAGE means and
> >more importantly, how it is actually used in this code.
> 
> ?
> 
> Physical package maps to the package_id, which is generally defined
> to mean the "socket" and is used to terminate the cpu topology side
> of the parse.
> 
> >
> >This function is used to get a topology id (that is just a number for
> >a given topology level) for a given level starting from a given leaf
> >node.
> 
> This flag is the one decent part of the spec, because its the only
> level which actually is guaranteed to mean anything. Because the
> requirement that the sharability of cache nodes is described with
> general processor nodes it means that the number of nodes within a
> given leg of the tree is mostly meaningless because people sprinkle
> caches around the system, including potentially above the "socket"
> level.
> 
> >Why do we care at all about ACPI_PPTT_PHYSICAL_PACKAGE ?
> 
> Because, it gives us a hard mapping to core siblings.
> 
> >
> >>+		pr_debug("level %d\n", level);
> >>+		prev_node = fetch_pptt_node(table_hdr, cpu->parent);
> >>+		if (prev_node == NULL)
> >>+			break;
> >>+		cpu = prev_node;
> >>+		level--;
> >>+	}
> >>+	return cpu;
> >>+}
> >>+
> >>+static int acpi_parse_pptt(struct acpi_table_header *table_hdr, u32 acpi_cpu_id)
> >>+{
> >>+	int number_of_levels = 0;
> >>+	struct acpi_pptt_processor *cpu;
> >>+
> >>+	cpu = acpi_find_processor_node(table_hdr, acpi_cpu_id);
> >>+	if (cpu)
> >>+		number_of_levels = acpi_process_node(table_hdr, cpu);
> >>+
> >>+	return number_of_levels;
> >>+}
> >>+
> >>+#define ACPI_6_2_CACHE_TYPE_DATA		      (0x0)
> >>+#define ACPI_6_2_CACHE_TYPE_INSTR		      (1<<2)
> >>+#define ACPI_6_2_CACHE_TYPE_UNIFIED		      (1<<3)
> >>+#define ACPI_6_2_CACHE_POLICY_WB		      (0x0)
> >>+#define ACPI_6_2_CACHE_POLICY_WT		      (1<<4)
> >>+#define ACPI_6_2_CACHE_READ_ALLOCATE		      (0x0)
> >>+#define ACPI_6_2_CACHE_WRITE_ALLOCATE		      (0x01)
> >>+#define ACPI_6_2_CACHE_RW_ALLOCATE		      (0x02)
> >>+
> >>+static u8 acpi_cache_type(enum cache_type type)
> >>+{
> >>+	switch (type) {
> >>+	case CACHE_TYPE_DATA:
> >>+		pr_debug("Looking for data cache\n");
> >>+		return ACPI_6_2_CACHE_TYPE_DATA;
> >>+	case CACHE_TYPE_INST:
> >>+		pr_debug("Looking for instruction cache\n");
> >>+		return ACPI_6_2_CACHE_TYPE_INSTR;
> >>+	default:
> >>+		pr_debug("Unknown cache type, assume unified\n");
> >>+	case CACHE_TYPE_UNIFIED:
> >>+		pr_debug("Looking for unified cache\n");
> >>+		return ACPI_6_2_CACHE_TYPE_UNIFIED;
> >>+	}
> >>+}
> >>+
> >>+/* find the ACPI node describing the cache type/level for the given CPU */
> >>+static struct acpi_pptt_cache *acpi_find_cache_node(
> >>+	struct acpi_table_header *table_hdr, u32 acpi_cpu_id,
> >>+	enum cache_type type, unsigned int level,
> >>+	struct acpi_pptt_processor **node)
> >>+{
> >>+	int total_levels = 0;
> >>+	struct acpi_pptt_cache *found = NULL;
> >>+	struct acpi_pptt_processor *cpu_node;
> >>+	u8 acpi_type = acpi_cache_type(type);
> >>+
> >>+	pr_debug("Looking for CPU %d's level %d cache type %d\n",
> >>+		 acpi_cpu_id, level, acpi_type);
> >>+
> >>+	cpu_node = acpi_find_processor_node(table_hdr, acpi_cpu_id);
> >>+	if (!cpu_node)
> >>+		return NULL;
> >>+
> >>+	do {
> >>+		found = acpi_find_cache_level(table_hdr, cpu_node, &total_levels, level, acpi_type);
> >>+		*node = cpu_node;
> >>+		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
> >>+	} while ((cpu_node) && (!found));
> >>+
> >>+	return found;
> >>+}
> >>+
> >>+int acpi_find_last_cache_level(unsigned int cpu)
> >>+{
> >>+	u32 acpi_cpu_id;
> >>+	struct acpi_table_header *table;
> >>+	int number_of_levels = 0;
> >>+	acpi_status status;
> >>+
> >>+	pr_debug("Cache Setup find last level cpu=%d\n", cpu);
> >>+
> >>+	acpi_cpu_id = acpi_cpu_get_madt_gicc(cpu)->uid;
> >
> >This would break !ARM64.
> 
> >
> >>+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> >>+	if (ACPI_FAILURE(status)) {
> >>+		pr_err_once("No PPTT table found, cache topology may be inaccurate\n");
> 
> Yup, as in a way this does too... Without writing the binding code
> for another arch where that line is isn't clear at the moment. Part
> of the reason I put this in the arm64 directory.
> 
> 
> >>+	} else {
> >>+		number_of_levels = acpi_parse_pptt(table, acpi_cpu_id);
> >>+		acpi_put_table(table);
> >>+	}
> >>+	pr_debug("Cache Setup find last level level=%d\n", number_of_levels);
> >>+
> >>+	return number_of_levels;
> >>+}
> >>+
> >>+/*
> >>+ * The ACPI spec implies that the fields in the cache structures are used to
> >>+ * extend and correct the information probed from the hardware. In the case
> >>+ * of arm64 the CCSIDR probing has been removed because it might be incorrect.
> >>+ */
> >>+static void update_cache_properties(struct cacheinfo *this_leaf,
> >>+				    struct acpi_pptt_cache *found_cache,
> >>+				    struct acpi_pptt_processor *cpu_node)
> >>+{
> >>+	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
> >>+		this_leaf->size = found_cache->size;
> >>+	if (found_cache->flags & ACPI_PPTT_LINE_SIZE_VALID)
> >>+		this_leaf->coherency_line_size = found_cache->line_size;
> >>+	if (found_cache->flags & ACPI_PPTT_NUMBER_OF_SETS_VALID)
> >>+		this_leaf->number_of_sets = found_cache->number_of_sets;
> >>+	if (found_cache->flags & ACPI_PPTT_ASSOCIATIVITY_VALID)
> >>+		this_leaf->ways_of_associativity = found_cache->associativity;
> >>+	if (found_cache->flags & ACPI_PPTT_WRITE_POLICY_VALID)
> >>+		switch (found_cache->attributes & ACPI_PPTT_MASK_WRITE_POLICY) {
> >>+		case ACPI_6_2_CACHE_POLICY_WT:
> >>+			this_leaf->attributes = CACHE_WRITE_THROUGH;
> >>+			break;
> >>+		case ACPI_6_2_CACHE_POLICY_WB:
> >>+			this_leaf->attributes = CACHE_WRITE_BACK;
> >>+			break;
> >>+		default:
> >>+			pr_err("Unknown ACPI cache policy %d\n",
> >>+			      found_cache->attributes & ACPI_PPTT_MASK_WRITE_POLICY);
> >>+		}
> >>+	if (found_cache->flags & ACPI_PPTT_ALLOCATION_TYPE_VALID)
> >>+		switch (found_cache->attributes & ACPI_PPTT_MASK_ALLOCATION_TYPE) {
> >>+		case ACPI_6_2_CACHE_READ_ALLOCATE:
> >>+			this_leaf->attributes |= CACHE_READ_ALLOCATE;
> >>+			break;
> >>+		case ACPI_6_2_CACHE_WRITE_ALLOCATE:
> >>+			this_leaf->attributes |= CACHE_WRITE_ALLOCATE;
> >>+			break;
> >>+		case ACPI_6_2_CACHE_RW_ALLOCATE:
> >>+			this_leaf->attributes |=
> >>+				CACHE_READ_ALLOCATE|CACHE_WRITE_ALLOCATE;
> >>+			break;
> >>+		default:
> >>+			pr_err("Unknown ACPI cache allocation policy %d\n",
> >>+			   found_cache->attributes & ACPI_PPTT_MASK_ALLOCATION_TYPE);
> >>+		}
> >>+}
> >>+
> >>+static void cache_setup_acpi_cpu(struct acpi_table_header *table,
> >>+				 unsigned int cpu)
> >>+{
> >>+	struct acpi_pptt_cache *found_cache;
> >>+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> >>+	u32 acpi_cpu_id = acpi_cpu_get_madt_gicc(cpu)->uid;
> >
> >Ditto.
> >
> >>+	struct cacheinfo *this_leaf;
> >>+	unsigned int index = 0;
> >>+	struct acpi_pptt_processor *cpu_node = NULL;
> >>+
> >>+	while (index < get_cpu_cacheinfo(cpu)->num_leaves) {
> >>+		this_leaf = this_cpu_ci->info_list + index;
> >>+		found_cache = acpi_find_cache_node(table, acpi_cpu_id,
> >>+						   this_leaf->type,
> >>+						   this_leaf->level,
> >>+						   &cpu_node);
> >>+		pr_debug("found = %p %p\n", found_cache, cpu_node);
> >>+		if (found_cache)
> >>+			update_cache_properties(this_leaf,
> >>+						found_cache,
> >>+						cpu_node);
> >>+
> >>+		index++;
> >>+	}
> >>+}
> >>+
> >>+static int topology_setup_acpi_cpu(struct acpi_table_header *table,
> >>+				    unsigned int cpu, int level)
> >>+{
> >>+	struct acpi_pptt_processor *cpu_node;
> >>+	u32 acpi_cpu_id = acpi_cpu_get_madt_gicc(cpu)->uid;
> >
> >Ditto.
> >
> >>+	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> >>+	if (cpu_node) {
> >>+		cpu_node = acpi_find_processor_package_id(table, cpu_node, level);
> >
> >If level is 0 there is nothing to do here.
> >
> >>+		/* Only the first level has a guaranteed id */
> >>+		if (level == 0)
> >>+			return cpu_node->acpi_processor_id;
> >>+		return (int)((u8 *)cpu_node - (u8 *)table);
> >
> >Please explain to me the rationale behind this. To me acpi_processor_id
> >is as good as the cpu_node offset in the table to describe the topology
> >id at a given level, why special case level 0.
> 
> Level 0 is the only level guaranteed to have something set in the
> acpi_processor_id field. Its possible that values exist in nodes
> above this one, but they must _all_ be flagged and have matching
> container ids, and nothing in the spec requires that. Meaning that
> we need a guaranteed way to generate ids. This was added between
> v2->v3 after the discussion about making the ids a little nicer for
> the user.
> 
> 
> >
> >On top of that, with this ID scheme, we would end up with
> >thread/core/cluster id potentially being non-sequential values
> >(depending on the PPTT table layout) which should not be a problem but
> >we'd better check how people are using them.
> 
> The thread (or core, depending on which is the 0 level) will have
> firmware provided Ids, everything else gets somewhat random looking
> but consistent ids. I commented earlier in this series that
> "normalizing" them is totally doable, although at the moment really
> only the physical_id is user visible and that should probably be
> normalized outside of this module in the arm64 topology parser if we
> want to actually do it. I'm not sure its worth the effort at least
> not as part of the general PPTT changes.
> 
> 
> >
> >>+	}
> >>+	pr_err_once("PPTT table found, but unable to locate core for %d\n",
> >>+		    cpu);
> >>+	return -ENOENT;
> >>+}
> >>+
> >>+/*
> >>+ * simply assign a ACPI cache entry to each known CPU cache entry
> >>+ * determining which entries are shared is done later.
> >
> >Add a kerneldoc style comment for an external interface.
> 
> That is a good point.
> 
> >
> >>+ */
> >>+int cache_setup_acpi(unsigned int cpu)
> >>+{
> >>+	struct acpi_table_header *table;
> >>+	acpi_status status;
> >>+
> >>+	pr_debug("Cache Setup ACPI cpu %d\n", cpu);
> >>+
> >>+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> >>+	if (ACPI_FAILURE(status)) {
> >>+		pr_err_once("No PPTT table found, cache topology may be inaccurate\n");
> >>+		return -ENOENT;
> >>+	}
> >>+
> >>+	cache_setup_acpi_cpu(table, cpu);
> >>+	acpi_put_table(table);
> >>+
> >>+	return status;
> >>+}
> >>+
> >>+/*
> >>+ * Determine a topology unique ID for each thread/core/cluster/socket/etc.
> >>+ * This ID can then be used to group peers.
> >
> >Ditto.
> >
> >>+ */
> >>+int setup_acpi_cpu_topology(unsigned int cpu, int level)
> >>+{
> >>+	struct acpi_table_header *table;
> >>+	acpi_status status;
> >>+	int retval;
> >>+
> >>+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> >>+	if (ACPI_FAILURE(status)) {
> >>+		pr_err_once("No PPTT table found, cpu topology may be inaccurate\n");
> >>+		return -ENOENT;
> >>+	}
> >>+	retval = topology_setup_acpi_cpu(table, cpu, level);
> >>+	pr_debug("Topology Setup ACPI cpu %d, level %d ret = %d\n",
> >>+		 cpu, level, retval);
> >>+	acpi_put_table(table);
> >>+
> >>+	return retval;
> >
> >This value is just a token - with no HW meaning whatsoever and that's
> >where I question the ACPI_PPTT_PHYSICAL_PACKAGE flag usage in retrieving
> >it, you are not looking for a packageid (which has no meaning whatsoever
> >anyway and I wonder why it was added to the specs at all) you are
> >looking for an id at a given level.
> 
> If you look at the next patch in the series, to get the top level I
> pass an arbitrary large value as the "level" which should terminate
> on the PHYSICAL_PACKAGE rather than any intermediate nodes.
> 
> 
> >
> >I will comment on the cache code separately - which deserves to
> >be in a separate patch to simplify the review, I avoided repeating
> >already reported review comments.
> >
> >Lorenzo
> >
> 
