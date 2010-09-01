From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bisected Regression in 2.6.35] A full tmpfs
	filesystem causeshibernation to hang
Date: Thu, 2 Sep 2010 00:02:24 +0200
Message-ID: <201009020002.25113.rjw__27748.9311564297$1283378836$gmane$org@sisk.pl>
References: <20100830083704.5231.A69D9226@jp.fujitsu.com>
	<4C7BE25B.1020504@superonline.com>
	<20100901093219.9744.A69D9226@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100901093219.9744.A69D9226@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: linux-pm@lists.linux-foundation.org, "M. Vefa Bicakci" <bicave@superonline.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 01, 2010, KOSAKI Motohiro wrote:
> > === 8< ===
> > PM: Marking nosave pages: ...0009f000 - ...000100000
> > PM: basic memory bitmaps created
> > PM: Syncing filesystems ... done
> > Freezing user space processes ... (elapsed 0.01 seconds) done.
> > Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
> > PM: Preallocating image memory...
> > shrink_all_memory start
> > PM: shrink memory: pass=1, req:310171 reclaimed:15492 free:360936
> > PM: shrink memory: pass=2, req:294679 reclaimed:28864 free:373981
> > PM: shrink memory: pass=3, req:265815 reclaimed:60311 free:405374
> > PM: shrink memory: pass=4, req:205504 reclaimed:97870 free:443024
> > PM: shrink memory: pass=5, req:107634 reclaimed:146948 free:492141
> > shrink_all_memory: req:107634 reclaimed:146948 free:492141
> > PM: preallocate_image_highmem 556658 278329
> > PM: preallocate_image_memory 103139 103139
> > PM: preallocate_highmem_fraction 183908 556658 760831 -> 183908
> > === >8 ===
> 
> Rafael, this log mean hibernate_preallocate_memory() has a bug.

Well, it works as designed ...

> It allocate memory as following order.
>  1. preallocate_image_highmem()  (i.e. __GFP_HIGHMEM)
>  2. preallocate_image_memory()   (i.e. GFP_KERNEL)
>  3. preallocate_highmem_fraction (i.e. __GFP_HIGHMEM)
>  4. preallocate_image_memory()   (i.e. GFP_KERNEL)
> 
> But, please imazine following scenario (as Vefa's scenario).
>  - system has 3GB memory. 1GB is normal. 2GB is highmem.
>  - all normal memory is free
>  - 1.5GB memory of highmem are used for tmpfs. rest 500MB is free.

Indeed, that's a memory allocation pattern I didn't anticipate.

> At that time, hibernate_preallocate_memory() works as following.
> 
> 1. call preallocate_image_highmem(1GB)
> 2. call preallocate_image_memory(500M)		total 1.5GB allocated
> 3. call preallocate_highmem_fraction(660M)	total 2.2GB allocated
> 
> then, all of normal zone memory was exhaust. next preallocate_image_memory()
> makes OOM, and oom_killer_disabled makes infinite loop.
> (oom_killer_disabled careless is vmscan bug. I'll fix it soon)

So, it looks like the problem will go away if we check if there are any normal
pages to allocate from before calling the last preallocate_image_memory()?

Like in the patch below, perhaps?

> The problem is, alloc_pages(__GFP_HIGHMEM) -> alloc_pages(GFP_KERNEL) is
> wrong order. alloc_pages(__GFP_HIGHMEM) may allocate page from lower zone.
> then, next alloc_pages(GFP_KERNEL) lead to OOM.
> 
> Please consider alloc_pages(GFP_KERNEL) -> alloc_pages(__GFP_HIGHMEM) order.
> Even though vmscan fix can avoid infinite loop, OOM situation might makes
> big slow down on highmem machine. It seems no good.

There's a problem with the ordering change that it wouldn't be clear how many
pages to request from the normal zone in step 1 and 3.

Thanks,
Rafael 

---
 kernel/power/snapshot.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

Index: linux-2.6/kernel/power/snapshot.c
===================================================================
--- linux-2.6.orig/kernel/power/snapshot.c
+++ linux-2.6/kernel/power/snapshot.c
@@ -1259,7 +1259,7 @@ int hibernate_preallocate_memory(void)
 {
 	struct zone *zone;
 	unsigned long saveable, size, max_size, count, highmem, pages = 0;
-	unsigned long alloc, save_highmem, pages_highmem;
+	unsigned long alloc, save_highmem, pages_highmem, size_normal;
 	struct timeval start, stop;
 	int error;
 
@@ -1296,6 +1296,7 @@ int hibernate_preallocate_memory(void)
 		else
 			count += zone_page_state(zone, NR_FREE_PAGES);
 	}
+	size_normal = count;
 	count += highmem;
 	count -= totalreserve_pages;
 
@@ -1344,7 +1345,13 @@ int hibernate_preallocate_memory(void)
 	size = preallocate_highmem_fraction(size, highmem, count);
 	pages_highmem += size;
 	alloc -= size;
-	pages += preallocate_image_memory(alloc);
+	/* Check if there are any non-highmem pages to allocate from. */
+	if (alloc_normal < size_normal) {
+		size_normal -= alloc_normal;
+		if (alloc > size_normal)
+			alloc = size_normal;
+		pages += preallocate_image_memory(alloc);
+	}
 	pages += pages_highmem;
 
 	/*
