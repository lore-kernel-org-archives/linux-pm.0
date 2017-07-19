From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [patch v3 2/5] acpi / boot: correct address space of
 __acpi_map_table()
Date: Wed, 19 Jul 2017 16:40:51 +0300
Message-ID: <20170719134051.zuf2rji46rfier64@yury-thinkpad>
References: <20170718150420.61600-1-andriy.shevchenko@linux.intel.com>
 <20170718150420.61600-3-andriy.shevchenko@linux.intel.com>
 <20170719130636.apmaj5ya4obkhvga@yury-thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170719130636.apmaj5ya4obkhvga@yury-thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
To: andy shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "rafael j . wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, thomas gleixner <tglx@linutronix.de>, ingo molnar <mingo@redhat.com>, "h . peter anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, hanjun guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org, geert uytterhoeven <geert@linux-m68k.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 19, 2017 at 04:06:36PM +0300, yury norov wrote:
> Hi Andy,
> 
> > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > index 09ddb3cd627a..6d5b1346268a 100644
> > --- a/arch/x86/kernel/acpi/boot.c
> > +++ b/arch/x86/kernel/acpi/boot.c
> > @@ -118,7 +118,7 @@ static u32 isa_irq_to_gsi[nr_irqs_legacy] __read_mostly = {
> >   * this is just a simple wrapper around early_ioremap(),
> >   * with sanity checks for phys == 0 and size == 0.
> >   */
> > -char *__init __acpi_map_table(unsigned long phys, unsigned long size)
> > +void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
> >  {
> >  
> >  	if (!phys || !size)
> > @@ -127,7 +127,7 @@ char *__init __acpi_map_table(unsigned long phys, unsigned long size)
> >  	return early_ioremap(phys, size);
> >  }
> 
> I just found this patch in next tree, and it seems it breaks build for
> arm64, and probably for ia64:
> 
> arch/arm64/kernel/acpi.c:98:14: error: conflicting types for ‘__acpi_map_table’
>  char *__init __acpi_map_table(unsigned long phys, unsigned long size)
>               ^~~~~~~~~~~~~~~~
> in file included from arch/arm64/kernel/acpi.c:18:0:
> ./include/linux/acpi.h:231:15: note: previous declaration of ‘__acpi_map_table’ was here
>  void __iomem *__acpi_map_table(unsigned long phys_addr, unsigned long size);
>                ^~~~~~~~~~~~~~~~
> arch/arm64/kernel/acpi.c:106:13: error: conflicting types for ‘__acpi_unmap_table’
>  void __init __acpi_unmap_table(char *map, unsigned long size)
>              ^~~~~~~~~~~~~~~~~~
> in file included from arch/arm64/kernel/acpi.c:18:0:
> ./include/linux/acpi.h:232:6: note: previous declaration of ‘__acpi_unmap_table’ was here
>  void __acpi_unmap_table(void __iomem *map, unsigned long size);
>       ^~~~~~~~~~~~~~~~~~
> 
> the patch below fixes it. (Tested on arm64 only.)

Ah, sorry. This is correct version.

>From 484d3dd1d20f7c9494e85c4ac669909155366958 Mon Sep 17 00:00:00 2001
From: Yury Norov <ynorov@caviumnetworks.com>
Date: Wed, 19 Jul 2017 16:00:02 +0300
Subject: [PATCH] ACPI / boot: fix prototypes for __acpi_{un}map_table for
 arm64 and ia64

The prototypes were changed in patch "ACPI / boot: Correct address space
of  __acpi_map_table()"

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/acpi.c | 4 ++--
 arch/ia64/kernel/acpi.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index e25c11e727fe..c7acba3e17d9 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -95,7 +95,7 @@ static int __init dt_scan_depth1_nodes(unsigned long node,
  * __acpi_map_table() will be called before page_init(), so early_ioremap()
  * or early_memremap() should be called here to for ACPI table mapping.
  */
-char *__init __acpi_map_table(unsigned long phys, unsigned long size)
+void __iomem __init *__acpi_map_table(unsigned long phys, unsigned long size)
 {
 	if (!size)
 		return NULL;
@@ -103,7 +103,7 @@ char *__init __acpi_map_table(unsigned long phys, unsigned long size)
 	return early_memremap(phys, size);
 }
 
-void __init __acpi_unmap_table(char *map, unsigned long size)
+void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
 {
 	if (!map || !size)
 		return;
diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index 7508c306aa9e..4df611746dab 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -159,12 +159,12 @@ int acpi_request_vector(u32 int_type)
 	return vector;
 }
 
-char *__init __acpi_map_table(unsigned long phys_addr, unsigned long size)
+void __iomem __init *__acpi_map_table(unsigned long phys_addr, unsigned long size)
 {
 	return __va(phys_addr);
 }
 
-void __init __acpi_unmap_table(char *map, unsigned long size)
+void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
 {
 }
 
-- 
2.11.0

