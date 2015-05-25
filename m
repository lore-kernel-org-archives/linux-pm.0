From: Illia Smyrnov <illia.smyrnov@globallogic.com>
Subject: Hibernate: issue: need to do 3 tries before enter hibernation
Date: Mon, 25 May 2015 21:55:43 +0300
Message-ID: <CALeaAntkAvun05SwvPtC5hB+=PsiCnc-mnPWd4jP+vZLbTSMeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33661 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbbEYSzq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2015 14:55:46 -0400
Received: by lbbzk7 with SMTP id zk7so56363955lbb.0
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2015 11:55:44 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, pavel@ucw.cz
Cc: Grygorii Strashko <grygorii.strashko@globallogic.com>

Hi All,

I'm using TI Jacinto 6 based custom board with 1G RAM (similar to dra7-evm),
running Android based on TI 6AL.1.0 Release
(http://omappedia.org/wiki/6AL.1.0_Release_Notes)
and kernel 3.14, with hibernate support based on the following patches:
https://git.linaro.org/people/grygorii.strashko/p-ti-linux-3.14.y-android-hib.git
branch: p-ti-linux-3.14.y-android-hib-dra7

Swap partition is placed on eMMC, size is 2G

Following commands used to run hibernate (hibernate.sh script):

swapon /dev/block/platform/44000000.ocp/by-name/swap
sync
echo 3 > /proc/sys/vm/drop_caches
echo 536870912 > /sys/power/image_size
echo disk > /sys/power/state
swapoff /dev/block/platform/44000000.ocp/by-name/swap

The system successfully goes to hibernate state if no apps are runing
(MemFree: 603268 kB),
but fails to go to hibernate if custom app is runing (MemFree: 437036
kB, see Log 1 below).
The problem is in the hibernate_preallocate_memory() (kernel/power/snapshot.c).
It calculates free pages count and this count is enough to store
hibernate image,
but later preallocate_image_pages failes to allocate enough pages.
As result swsusp_save() failed later with
        [  197.368434] sh: page allocation failure: order:0, mode:0x120

The system with custom app running will go to the hibernation
state successfully if hibernate.sh runs 3 times.

I found 2 solutions to avoid this issue:
1. call shrink_all_memory() few times if preallocate_image_x() can't
allocate requested number
   of pages (see Diff 1 below).
2. Add __GFP_MOVABLE flag to GFP_IMAGE.
   Seems it allows to use memory, reserved for CMA memory pools (see
Diff 2 and Log 2 below).

Could anybody confirm these solutions are reliable?
Is there any different/better solutions?

Thanks in advance.

Log 1 was taken with some additional debug output (see Diff 3 below).

=== Diff 1 begin ===============
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index d9f61a1..8d212fc 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1314,6 +1314,12 @@ int hibernate_preallocate_memory(void)
     unsigned long alloc, save_highmem, pages_highmem, avail_normal;
     struct timeval start, stop;
     int error;
+#ifdef CONFIG_HIBERNATION_PREALLOC_MEM_WA
+    unsigned long shrink_pages = 0;
+    int shrink_and_retry_count =
+        CONFIG_HIBERNATION_PREALLOC_MEM_RETRY_COUNT;
+    int shrink_and_retry = 0;
+#endif

     printk(KERN_INFO "PM: Preallocating image memory... ");
     do_gettimeofday(&start);
@@ -1329,6 +1335,15 @@ int hibernate_preallocate_memory(void)
     alloc_normal = 0;
     alloc_highmem = 0;

+#ifdef CONFIG_HIBERNATION_PREALLOC_MEM_WA
+shrink_and_retry:
+    if (shrink_and_retry) {
+        shrink_all_memory(shrink_pages +
+                  PAGES_FOR_IO +
+                  2 * DIV_ROUND_UP(reserved_size, PAGE_SIZE));
+    }
+#endif
+
     /* Count the number of saveable data pages. */
     save_highmem = count_highmem_pages();
     saveable = count_data_pages();
@@ -1367,11 +1382,27 @@ int hibernate_preallocate_memory(void)
      * current number of saveable pages in memory, allocate page frames for
      * the image and we're done.
      */
+#ifndef CONFIG_HIBERNATION_PREALLOC_MEM_WA
     if (size >= saveable) {
         pages = preallocate_image_highmem(save_highmem);
         pages += preallocate_image_memory(saveable - pages, avail_normal);
         goto out;
     }
+#else
+    if (size >= saveable || shrink_and_retry) {
+        pages += preallocate_image_highmem(save_highmem);
+        pages += preallocate_image_memory(saveable - pages, avail_normal);
+
+        if (shrink_and_retry < shrink_and_retry_count && pages < saveable) {
+            shrink_and_retry++;
+            shrink_pages = saveable - pages;
+            printk(KERN_WARNING "PM: page allocation failed, shrink
and retry (# %d)\n",
+                   shrink_and_retry);
+            goto shrink_and_retry;
+        }
+        goto out;
+    }
+#endif

     /* Estimate the minimum size of the image. */
     pages = minimum_image_size(saveable);
-- 
2.4.1
=== Diff 1 end =================


=== Diff 2 begin ===============
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index d9f61a1..fd6063d 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1120,7 +1120,7 @@ void swsusp_free(void)

 /* Helper functions used for the shrinking of memory. */

-#define GFP_IMAGE    (GFP_KERNEL | __GFP_NOWARN)
+#define GFP_IMAGE    (GFP_KERNEL | __GFP_NOWARN | __GFP_MOVABLE)

 /**
  * preallocate_image_pages - Allocate a number of pages for hibernation image
-- 
2.4.1
=== Diff 2 end =================


=== Diff 3 begin ===============
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index d9f61a1..e1334a4 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1315,6 +1315,10 @@ int hibernate_preallocate_memory(void)
     struct timeval start, stop;
     int error;

+printk(KERN_INFO "\n====== mem info 1 begin ======\n");
+show_mem(0);
+printk(KERN_INFO "\n====== mem info 1 end ======\n");
+
     printk(KERN_INFO "PM: Preallocating image memory... ");
     do_gettimeofday(&start);

@@ -1352,6 +1356,13 @@ int hibernate_preallocate_memory(void)
     count += highmem;
     count -= totalreserve_pages;

+printk(KERN_INFO "\n\n============\n");
+printk(KERN_INFO "count_highmem_pages() returned %lu\n", save_highmem);
+printk(KERN_INFO "count_data_pages() returned %lu\n", saveable);
+printk(KERN_INFO "number of highmem page frames we can use (highmem)
%lu\n", highmem);
+printk(KERN_INFO "total number of page frames we can use (count)
%lu\n", count);
+printk(KERN_INFO "\n============\n");
+
     /* Add number of pages required for page keys (s390 only). */
     size += page_key_additional_pages(saveable);

@@ -1368,8 +1379,22 @@ int hibernate_preallocate_memory(void)
      * the image and we're done.
      */
     if (size >= saveable) {
+
+printk(KERN_INFO "\n====== mem info 2 begin ======\n");
+show_mem(0);
+printk(KERN_INFO "\n====== mem info 2 end ======\n");
+
         pages = preallocate_image_highmem(save_highmem);
+
+printk(KERN_INFO "\n====== mem info 3 begin ======\n");
+show_mem(0);
+printk(KERN_INFO "\n====== mem info 3 end ======\n");
+
         pages += preallocate_image_memory(saveable - pages, avail_normal);
+
+printk(KERN_INFO "\n====== mem info 4 begin ======\n");
+show_mem(0);
+printk(KERN_INFO "\n====== mem info 4 end ======\n");
         goto out;
     }
=== Diff 3 end ===============


=== Log 1 begin ================
# hibernate.sh
[  193.604814] Adding 2097148k swap on
/dev/block/platform/44000000.ocp/by-name/swap.  Priority:-1 extents:1
across:2097148k SS
[  193.702880]  remoteproc1: stopped remote processor 55020000.ipu
[  193.713078]  remoteproc3: releasing 41000000.dsp
[  193.718109]  remoteproc2: releasing 40800000.dsp
[  193.723321]  remoteproc1: releasing 55020000.ipu
[  193.728376]  remoteproc0: releasing 58820000.ipu
[  193.896616] (NULL device *): Direct firmware load failed with error -2
[  193.903509] (NULL device *): Direct firmware load failed with error -2
[  193.910491] (NULL device *): Falling back to user helper
[  193.910502] (NULL device *): Falling back to user helper
[  193.970467] PM: Syncing filesystems ... done.
[  193.975310] Freezing user space processes ... (elapsed 0.001 seconds) done.
[  193.984538] PM: Basic memory bitmaps created
[  193.989024]
[  193.989024] ====== mem info 1 begin ======
[  193.994847] Mem-info:
[  193.997255] Normal per-cpu:
[  194.000172] CPU    0: hi:  186, btch:  31 usd:  58
[  194.005185] CPU    1: hi:  186, btch:  31 usd: 171
[  194.010212] HighMem per-cpu:
[  194.013219] CPU    0: hi:   90, btch:  15 usd:  27
[  194.018295] CPU    1: hi:   90, btch:  15 usd:  77
[  194.023311] active_anon:57308 inactive_anon:17035 isolated_anon:0
[  194.023311]  active_file:2244 inactive_file:12084 isolated_file:0
[  194.023311]  unevictable:0 dirty:0 writeback:0 unstable:0
[  194.023311]  free:136368 slab_reclaimable:995 slab_unreclaimable:3281
[  194.023311]  mapped:49046 shmem:17035 pagetables:1640 bounce:0
[  194.023311]  free_cma:65070
[  194.057472] Normal free:397912kB min:3484kB low:13100kB
high:13972kB active_anon:164480kB inactive_anon:50028kB
active_file:6260kB inactive_file:34672kB unevictable:0kB
isolated(anon):0kB isolated(file):0kB present:778240kB
managed:759392kB mlocked:0kB dirty:0kB writeback:0kB mapped:143268kB
shmem:50012kB slab_reclaimable:3980kB slab_unreclaimable:13124kB
kernel_stack:6424kB pagetables:6560kB unstable:0kB bounce:0kB
free_cma:260280kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable?
no
[  194.102779] lowmem_reserve[]: 0 2104 2104
[  194.107004] HighMem free:147560kB min:260kB low:3668kB high:3976kB
active_anon:64776kB inactive_anon:18104kB active_file:2720kB
inactive_file:13708kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB present:269312kB managed:269312kB mlocked:0kB
dirty:0kB writeback:0kB mapped:52900kB shmem:18128kB
slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB
pagetables:0kB unstable:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB
pages_scanned:0 all_unreclaimable? no
[  194.150384] lowmem_reserve[]: 0 0 0
[  194.154049] Normal: 2506*4kB (EMC) 1425*8kB (UEMC) 873*16kB (EMC)
464*32kB (UEMC) 179*64kB (UEMC) 51*128kB (UEMC) 24*256kB (UEMC)
24*512kB (UMC) 20*1024kB (UMC) 14*2048kB (UEC) 64*4096kB (MRC) =
397952kB
[  194.173108] HighMem: 836*4kB (M) 451*8kB (UM) 256*16kB (UM)
144*32kB (UM) 55*64kB (UM) 15*128kB (M) 8*256kB (UM) 1*512kB (U)
1*1024kB (U) 2*2048kB (U) 29*4096kB (UMR) = 147560kB
[  194.189806] 31398 total pagecache pages
[  194.193820] 0 pages in swap cache
[  194.197305] Swap cache stats: add 0, delete 0, find 0/0
[  194.202773] Free swap  = 2097148kB
[  194.206328] Total swap = 2097148kB
[  194.214199] 262144 pages of RAM
[  194.217505] 137671 free pages
[  194.220605] 4968 reserved pages
[  194.223886] 3983 slab pages
[  194.226812] 682426 pages shared
[  194.230094] 0 pages swap cached
[  194.233375]
[  194.233375] ====== mem info 1 end ======
[  194.239034] PM: Preallocating image memory...
[  194.320139]
[  194.320139]
[  194.320139] ============
[  194.326065] count_highmem_pages() returned 30438
[  194.330911] count_data_pages() returned 125491
[  194.335561] number of highmem page frames we can use (highmem) 67328
[  194.342212] total number of page frames we can use (count) 255278
[  194.348590]
[  194.348590] ============
[  194.352778]
[  194.352778] ====== mem info 2 begin ======
[  194.358622] Mem-info:
[  194.360993] Normal per-cpu:
[  194.363916] CPU    0: hi:  186, btch:  31 usd:  60
[  194.368948] CPU    1: hi:  186, btch:  31 usd: 153
[  194.373958] HighMem per-cpu:
[  194.376977] CPU    0: hi:   90, btch:  15 usd:  27
[  194.381985] CPU    1: hi:   90, btch:  15 usd:  77
[  194.387010] active_anon:57303 inactive_anon:17028 isolated_anon:0
[  194.387010]  active_file:2259 inactive_file:12110 isolated_file:0
[  194.387010]  unevictable:0 dirty:0 writeback:0 unstable:0
[  194.387010]  free:136378 slab_reclaimable:996 slab_unreclaimable:3292
[  194.387010]  mapped:49053 shmem:17035 pagetables:1628 bounce:0
[  194.387010]  free_cma:65081
[  194.421173] Normal free:397952kB min:3484kB low:13100kB
high:13972kB active_anon:164436kB inactive_anon:50008kB
active_file:6316kB inactive_file:34732kB unevictable:0kB
isolated(anon):0kB isolated(file):0kB present:778240kB
managed:759392kB mlocked:0kB dirty:0kB writeback:0kB mapped:143312kB
shmem:50012kB slab_reclaimable:3984kB slab_unreclaimable:13168kB
kernel_stack:6464kB pagetables:6512kB unstable:0kB bounce:0kB
free_cma:260324kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable?
no
[  194.466492] lowmem_reserve[]: 0 2104 2104
[  194.470719] HighMem free:147560kB min:260kB low:3668kB high:3976kB
active_anon:64776kB inactive_anon:18104kB active_file:2720kB
inactive_file:13708kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB present:269312kB managed:269312kB mlocked:0kB
dirty:0kB writeback:0kB mapped:52900kB shmem:18128kB
slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB
pagetables:0kB unstable:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB
pages_scanned:0 all_unreclaimable? no
[  194.514037] lowmem_reserve[]: 0 0 0
[  194.517711] Normal: 2506*4kB (EMC) 1425*8kB (UEMC) 873*16kB (EMC)
464*32kB (UEMC) 179*64kB (UEMC) 51*128kB (UEMC) 24*256kB (UEMC)
24*512kB (UMC) 20*1024kB (UMC) 14*2048kB (UEC) 64*4096kB (MRC) =
397952kB
[  194.536777] HighMem: 836*4kB (M) 451*8kB (UM) 256*16kB (UM)
144*32kB (UM) 55*64kB (UM) 15*128kB (M) 8*256kB (UM) 1*512kB (U)
1*1024kB (U) 2*2048kB (U) 29*4096kB (UMR) = 147560kB
[  194.553470] 31398 total pagecache pages
[  194.557505] 0 pages in swap cache
[  194.560972] Swap cache stats: add 0, delete 0, find 0/0
[  194.566442] Free swap  = 2097148kB
[  194.570003] Total swap = 2097148kB
[  194.577816] 262144 pages of RAM
[  194.581100] 137653 free pages
[  194.584200] 4968 reserved pages
[  194.587495] 3983 slab pages
[  194.590412] 682426 pages shared
[  194.593695] 0 pages swap cached
[  194.596983]
[  194.596983] ====== mem info 2 end ======
[  194.620333]
[  194.620333] ====== mem info 3 begin ======
[  194.626169] Mem-info:
[  194.628557] Normal per-cpu:
[  194.631484] CPU    0: hi:  186, btch:  31 usd:  60
[  194.636485] CPU    1: hi:  186, btch:  31 usd: 152
[  194.641506] HighMem per-cpu:
[  194.644517] CPU    0: hi:   90, btch:  15 usd:  27
[  194.649533] CPU    1: hi:   90, btch:  15 usd:  81
[  194.654554] active_anon:57303 inactive_anon:17028 isolated_anon:0
[  194.654554]  active_file:2259 inactive_file:12110 isolated_file:0
[  194.654554]  unevictable:0 dirty:0 writeback:0 unstable:0
[  194.654554]  free:105937 slab_reclaimable:996 slab_unreclaimable:3292
[  194.654554]  mapped:49053 shmem:17035 pagetables:1628 bounce:0
[  194.654554]  free_cma:65081
[  194.688740] Normal free:307928kB min:3484kB low:13100kB
high:13972kB active_anon:164436kB inactive_anon:50008kB
active_file:6316kB inactive_file:34732kB unevictable:0kB
isolated(anon):0kB isolated(file):0kB present:778240kB
managed:759392kB mlocked:0kB dirty:0kB writeback:0kB mapped:143312kB
shmem:50012kB slab_reclaimable:3984kB slab_unreclaimable:13168kB
kernel_stack:6464kB pagetables:6512kB unstable:0kB bounce:0kB
free_cma:260324kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable?
no
[  194.734076] lowmem_reserve[]: 0 2104 2104
[  194.738307] HighMem free:115820kB min:260kB low:3668kB high:3976kB
active_anon:64776kB inactive_anon:18104kB active_file:2720kB
inactive_file:13708kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB present:269312kB managed:269312kB mlocked:0kB
dirty:0kB writeback:0kB mapped:52900kB shmem:18128kB
slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB
pagetables:0kB unstable:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB
pages_scanned:0 all_unreclaimable? no
[  194.781627] lowmem_reserve[]: 0 0 0
[  194.785291] Normal: 1688*4kB (UMC) 1035*8kB (UMC) 614*16kB (UMC)
316*32kB (UMC) 117*64kB (UMC) 14*128kB (MC) 2*256kB (C) 2*512kB (C)
2*1024kB (C) 3*2048kB (C) 62*4096kB (RC) = 307928kB
[  194.802609] HighMem: 837*4kB (UM) 451*8kB (UM) 256*16kB (UM)
144*32kB (UM) 55*64kB (UM) 15*128kB (M) 8*256kB (UM) 1*512kB (U)
0*1024kB 1*2048kB (U) 22*4096kB (MR) = 115820kB
[  194.818963] 31398 total pagecache pages
[  194.822976] 0 pages in swap cache
[  194.826447] Swap cache stats: add 0, delete 0, find 0/0
[  194.831923] Free swap  = 2097148kB
[  194.835480] Total swap = 2097148kB
[  194.843755] 262144 pages of RAM
[  194.847059] 107215 free pages
[  194.850162] 4968 reserved pages
[  194.853446] 3983 slab pages
[  194.856390] 682426 pages shared
[  194.859685] 0 pages swap cached
[  194.862968]
[  194.862968] ====== mem info 3 end ======
[  195.787623]
[  195.787623] ====== mem info 4 begin ======
[  195.793464] Mem-info:
[  195.795835] Normal per-cpu:
[  195.798778] CPU    0: hi:  186, btch:  31 usd:  30
[  195.804058] CPU    1: hi:  186, btch:  31 usd:  64
[  195.809093] HighMem per-cpu:
[  195.812103] CPU    0: hi:   90, btch:  15 usd:   0
[  195.817129] CPU    1: hi:   90, btch:  15 usd:   0
[  195.822149] active_anon:34334 inactive_anon:33825 isolated_anon:0
[  195.822149]  active_file:700 inactive_file:3429 isolated_file:0
[  195.822149]  unevictable:7 dirty:0 writeback:11250 unstable:0
[  195.822149]  free:95147 slab_reclaimable:994 slab_unreclaimable:3700
[  195.822149]  mapped:39024 shmem:17010 pagetables:1628 bounce:0
[  195.822149]  free_cma:65198
[  195.856397] Normal free:264336kB min:3484kB low:13100kB
high:13972kB active_anon:94832kB inactive_anon:94924kB
active_file:80kB inactive_file:8kB unevictable:28kB isolated(anon):0kB
isolated(file):0kB present:778240kB managed:759392kB mlocked:0kB
dirty:0kB writeback:45000kB mapped:103196kB shmem:49912kB
slab_reclaimable:3976kB slab_unreclaimable:14800kB kernel_stack:6464kB
pagetables:6512kB unstable:0kB bounce:0kB free_cma:260792kB
writeback_tmp:0kB pages_scanned:1152 all_unreclaimable? no
[  195.901842] lowmem_reserve[]: 0 2104 2104
[  195.906077] HighMem free:116252kB min:260kB low:3668kB high:3976kB
active_anon:42504kB inactive_anon:40376kB active_file:2720kB
inactive_file:13708kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB present:269312kB managed:269312kB mlocked:0kB
dirty:0kB writeback:0kB mapped:52900kB shmem:18128kB
slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB
pagetables:0kB unstable:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB
pages_scanned:256 all_unreclaimable? no
[  195.949628] lowmem_reserve[]: 0 0 0
[  195.953314] Normal: 49*4kB (MRC) 8*8kB (MC) 7*16kB (MRC) 4*32kB
(RC) 3*64kB (RC) 4*128kB (RC) 2*256kB (C) 1*512kB (C) 2*1024kB (RC)
3*2048kB (RC) 62*4096kB (C) = 264372kB
[  195.969447] HighMem: 882*4kB (UM) 468*8kB (UM) 258*16kB (M)
146*32kB (M) 54*64kB (M) 16*128kB (UM) 8*256kB (UM) 1*512kB (U)
0*1024kB 1*2048kB (U) 22*4096kB (MR) = 116296kB
[  195.985929] 32251 total pagecache pages
[  195.989954] 11110 pages in swap cache
[  195.993783] Swap cache stats: add 17378, delete 6268, find 0/0
[  195.999909] Free swap  = 2027636kB
[  196.003469] Total swap = 2097148kB
[  196.012003] 262144 pages of RAM
[  196.015647] 96443 free pages
[  196.018675] 4968 reserved pages
[  196.021958] 4392 slab pages
[  196.024876] 607696 pages shared
[  196.028176] 11110 pages swap cached
[  196.031823]
[  196.031823] ====== mem info 4 end ======
[  196.037482] done (allocated 57307 pages)
[  196.041582] PM: Allocated 229228 kbytes in 1.79 seconds (128.06 MB/s)
[  196.048474] Freezing remaining freezable tasks ... (elapsed 0.103
seconds) done.
[  196.169712] coproc dsp_coproc.5: suspend
[  196.173921] coproc iva_coproc.4: suspend
[  197.338484] PM: freeze of devices complete after 1177.957 msecs
[  197.345794] PM: late freeze of devices complete after 1.077 msecs
[  197.353445] PM: noirq freeze of devices complete after 1.213 msecs
[  197.359979] Disabling non-boot CPUs ...
[  197.364851] CPU1: shutdown
[  197.368434] PM: Creating hibernation image:
[  197.368434] PM: Need to copy 107702 pages
[  197.368434] PM: Normal pages needed: 77379 + 1024, available pages: 117156
[  197.368434] sh: page allocation failure: order:0, mode:0x120
[  197.368434] CPU: 0 PID: 4285 Comm: sh Tainted: G           O
3.14.31-00158-g4c954a1-dirty #159
[  197.368434] Backtrace:
[  197.368434] [<c001228c>] (dump_backtrace) from [<c00124a4>]
(show_stack+0x18/0x1c)
[  197.368434]  r6:c08a3fd0 r5:ffffffff r4:00000000 r3:00000000
[  197.368434] [<c001248c>] (show_stack) from [<c06289cc>]
(dump_stack+0x84/0xc4)
[  197.368434] [<c0628948>] (dump_stack) from [<c00bdfbc>]
(warn_alloc_failed+0xd4/0x118)
[  197.368434]  r6:00000000 r5:00000000 r4:00000120 r3:00000000
[  197.368434] [<c00bdeec>] (warn_alloc_failed) from [<c00c1258>]
(__alloc_pages_nodemask+0x688/0x924)
[  197.368434]  r3:00000000 r2:00000000
[  197.368434]  r7:00000000 r6:00000000 r5:00000000 r4:00000000
[  197.368434] [<c00c0bd0>] (__alloc_pages_nodemask) from [<c0073230>]
(alloc_image_page+0x1c/0x3c)
[  197.368434]  r10:c088a844 r9:00000000 r8:0001a4b6 r7:c08e9000
r6:c08ce178 r5:c088a844
[  197.368434]  r4:000064ab
[  197.368434] [<c0073214>] (alloc_image_page) from [<c00745a0>]
(swsusp_save+0x128/0x40c)
[  197.368434]  r4:000064ab r3:10000000
[  197.368434] [<c0074478>] (swsusp_save) from [<c0013720>]
(arch_save_image+0x10/0x34)
[  197.368434]  r10:00000005 r9:c089a5dc r8:0000000f r7:00000007
r6:00000000 r5:d49d3e1c
[  197.368434]  r4:00000030
[  197.368434] [<c0013710>] (arch_save_image) from [<c00134ac>]
(cpu_suspend_abort+0x0/0x14)
[  197.368434]  r4:00000030 r3:e8846700
[  197.368434] [<c001355c>] (cpu_suspend) from [<c0013808>]
(swsusp_arch_suspend+0x1c/0x20)
[  197.368434]  r6:00000000 r5:00000000 r4:c08ce02c r3:00000001
[  197.368434] [<c00137ec>] (swsusp_arch_suspend) from [<c0072688>]
(hibernation_snapshot+0x31c/0x384)
[  197.368434] [<c007236c>] (hibernation_snapshot) from [<c0072b8c>]
(hibernate+0x168/0x214)
[  197.368434]  r7:c08ce050 r6:00000000 r5:d49d2010 r4:c089a674
[  197.368434] [<c0072a24>] (hibernate) from [<c0070864>]
(state_store+0xd4/0xdc)
[  197.368434]  r9:e11a2b48 r8:e11a2b40 r7:d564e340 r6:00000004
r5:d564e340 r4:e8935630
[  197.368434] [<c0070790>] (state_store) from [<c026ffa8>]
(kobj_attr_store+0x1c/0x28)
[  197.368434]  r10:00000005 r9:e11a2b48 r8:e11a2b40 r7:d564e340
r6:d49d3f78 r5:d564e340
[  197.368434]  r4:e8935630 r3:00000005
[  197.368434] [<c026ff8c>] (kobj_attr_store) from [<c015806c>]
(sysfs_kf_write+0x4c/0x50)
[  197.368434] [<c0158020>] (sysfs_kf_write) from [<c015b81c>]
(kernfs_fop_write+0xbc/0x154)
[  197.368434]  r5:00000000 r4:00000000
[  197.368434] [<c015b760>] (kernfs_fop_write) from [<c00f5d4c>]
(vfs_write+0xb4/0x190)
[  197.368434]  r10:00000000 r9:b7b8c2c4 r8:00000005 r7:00000005
r6:d49d3f78 r5:b7b8c2c4
[  197.368434]  r4:d2a56900
[  197.368434] [<c00f5c98>] (vfs_write) from [<c00f635c>] (SyS_write+0x44/0x98)
[  197.368434]  r9:b7b8c2c4 r8:00000005 r7:d2a56900 r6:d2a56900
r5:00000000 r4:00000000
[  197.368434] [<c00f6318>] (SyS_write) from [<c000e8a0>]
(ret_fast_syscall+0x0/0x30)
[  197.368434]  r9:d49d2000 r8:c000ea24 r7:00000004 r6:00000001
r5:00000005 r4:00000003
[  197.368434] Mem-info:
[  197.368434] Normal per-cpu:
[  197.368434] CPU    0: hi:  186, btch:  31 usd:  30
[  197.368434] HighMem per-cpu:
[  197.368434] CPU    0: hi:   90, btch:  15 usd:   3
[  197.368434] active_anon:33822 inactive_anon:33296 isolated_anon:0
[  197.368434]  active_file:680 inactive_file:3444 isolated_file:0
[  197.368434]  unevictable:7 dirty:0 writeback:9 unstable:0
[  197.368434]  free:72202 slab_reclaimable:961 slab_unreclaimable:3307
[  197.368434]  mapped:39024 shmem:16996 pagetables:1628 bounce:0
[  197.368434]  free_cma:65198
[  197.368434] Normal free:262092kB min:3484kB low:13100kB
high:13972kB active_anon:92784kB inactive_anon:92808kB active_file:0kB
inactive_file:112kB unevictable:28kB isolated(anon):0kB
isolated(file):0kB present:778240kB managed:759392kB mlocked:0kB
dirty:0kB writeback:36kB mapped:103196kB shmem:49856kB
slab_reclaimable:3844kB slab_unreclaimable:13228kB kernel_stack:6480kB
pagetables:6512kB unstable:0kB bounce:0kB free_cma:260792kB
writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
[  197.368434] lowmem_reserve[]: 0 2104 2104
[  197.368434] HighMem free:26716kB min:260kB low:3668kB high:3976kB
active_anon:42504kB inactive_anon:40376kB active_file:2720kB
inactive_file:13664kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB present:269312kB managed:269312kB mlocked:0kB
dirty:0kB writeback:0kB mapped:52900kB shmem:18128kB
slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB
pagetables:0kB unstable:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB
pages_scanned:256 all_unreclaimable? no
[  197.368434] lowmem_reserve[]: 0 0 0
[  197.368434] Normal: 7*4kB (RC) 4*8kB (C) 3*16kB (RC) 3*32kB (C)
2*64kB (C) 3*128kB (C) 3*256kB (RC) 1*512kB (C) 2*1024kB (RC) 2*2048kB
(C) 62*4096kB (C) = 262092kB
[  197.368434] HighMem: 809*4kB (M) 433*8kB (UM) 259*16kB (UM)
148*32kB (UM) 56*64kB (UM) 17*128kB (M) 5*256kB (M) 0*512kB 0*1024kB
0*2048kB 1*4096kB (R) = 26716kB
[  197.368434] 31292 total pagecache pages
[  197.368434] 10165 pages in swap cache
[  197.368434] Swap cache stats: add 17378, delete 7213, find 0/0
[  197.368434] Free swap  = 2027636kB
[  197.368434] Total swap = 2097148kB
[  197.368434] 262144 pages of RAM
[  197.368434] 73195 free pages
[  197.368434] 4968 reserved pages
[  197.368434] 3962 slab pages
[  197.368434] 607696 pages shared
[  197.368434] 10165 pages swap cached
[  197.368434] PM: Memory allocation failed
[  197.368434] PM: Error -12 creating hibernation image
[  197.368443] Enabling non-boot CPUs ...
=== Log 1 end ==================


=== Lod 2 begin ===============
...
[    0.000000] Machine model: TI DRA742
[    0.000000] Reserved memory: created CMA memory pool at 0x95800000,
size 56 MiB
[    0.000000] Reserved memory: initialized node ipu2_cma@95800000,
compatible id shared-dma-pool
[    0.000000] Reserved memory: created CMA memory pool at 0x99000000,
size 64 MiB
[    0.000000] Reserved memory: initialized node dsp1_cma@99000000,
compatible id shared-dma-pool
[    0.000000] Reserved memory: created CMA memory pool at 0x9d000000,
size 32 MiB
[    0.000000] Reserved memory: initialized node ipu1_cma@9d000000,
compatible id shared-dma-pool
[    0.000000] Reserved memory: created CMA memory pool at 0x9f000000,
size 8 MiB
[    0.000000] Reserved memory: initialized node dsp2_cma@9f000000,
compatible id shared-dma-pool
[    0.000000] cma: CMA: reserved 96 MiB at a9800000
...
=== Lod 2 end ===============
