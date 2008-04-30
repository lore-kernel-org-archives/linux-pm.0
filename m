From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] acpi: acpi_numa_init() build fix
Date: Wed, 30 Apr 2008 22:56:15 +0200
Message-ID: <20080430205615.GA23694__10732.200012035$1209589272$gmane$org@elte.hu>
References: <200804301420.11696.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200804301420.11696.lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


* Len Brown <lenb@kernel.org> wrote:

> This batch is a proper super-set of the pull request I made a week 
> ago. It will update the files shown below.

something in this batch broke the build on x86 on current -git. Somewhat 
band-aid-ish fix below.

	Ingo

------------->
Subject: acpi: acpi_numa_init() build fix
From: Ingo Molnar <mingo@elte.hu>
Date: Tue Apr 29 00:40:16 CEST 2008

x86.git testing found the following build error on latest -git:

 drivers/acpi/numa.c: In function 'acpi_numa_init':
 drivers/acpi/numa.c:226: error: 'NR_NODE_MEMBLKS' undeclared (first use in this function)
 drivers/acpi/numa.c:226: error: (Each undeclared identifier is reported only once
 drivers/acpi/numa.c:226: error: for each function it appears in.)

with this config:

 http://redhat.com/~mingo/misc/config-Wed_Apr_30_22_42_42_CEST_2008.bad

i suspect we dont want SRAT parsing when CONFIG_HAVE_ARCH_PARSE_SRAT
is unset - but the fix looks a bit ugly. Perhaps we should define
NR_NODE_MEMBLKS even in this case and just let the code fall back
to some sane behavior?

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/acpi/numa.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux/drivers/acpi/numa.c
===================================================================
--- linux.orig/drivers/acpi/numa.c
+++ linux/drivers/acpi/numa.c
@@ -176,6 +176,7 @@ acpi_parse_processor_affinity(struct acp
 	return 0;
 }
 
+#ifdef CONFIG_HAVE_ARCH_PARSE_SRAT
 static int __init
 acpi_parse_memory_affinity(struct acpi_subtable_header * header,
 			   const unsigned long end)
@@ -193,6 +194,7 @@ acpi_parse_memory_affinity(struct acpi_s
 
 	return 0;
 }
+#endif
 
 static int __init acpi_parse_srat(struct acpi_table_header *table)
 {
@@ -221,9 +223,11 @@ int __init acpi_numa_init(void)
 	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
 		acpi_table_parse_srat(ACPI_SRAT_TYPE_CPU_AFFINITY,
 				      acpi_parse_processor_affinity, NR_CPUS);
+#ifdef CONFIG_HAVE_ARCH_PARSE_SRAT
 		acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
 				      acpi_parse_memory_affinity,
 				      NR_NODE_MEMBLKS);
+#endif
 	}
 
 	/* SLIT: System Locality Information Table */
