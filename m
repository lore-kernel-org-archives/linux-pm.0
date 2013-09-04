From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [RFC PATCH v3 08/35] mm: Demarcate and maintain pageblocks in
 region-order in the zones' freelists
Date: Wed, 4 Sep 2013 16:49:56 +0900
Message-ID: <5226E624.9090908@jp.fujitsu.com>
References: <20130830131221.4947.99764.stgit@srivatsabhat.in.ibm.com> <20130830131619.4947.56734.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:42666 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762057Ab3IDHvA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Sep 2013 03:51:00 -0400
In-Reply-To: <20130830131619.4947.56734.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: akpm@linux-foundation.org, mgorman@suse.de, hannes@cmpxchg.org, tony.luck@intel.com, matthew.garrett@nebula.com, dave@sr71.net, riel@redhat.com, arjan@linux.intel.com, srinivas.pandruvada@linux.intel.com, willy@linux.intel.com, kamezawa.hiroyu@jp.fujitsu.com, lenb@kernel.org, rjw@sisk.pl, gargankita@gmail.com, paulmck@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, andi@firstfloor.org, santosh.shilimkar@ti.com, kosaki.motohiro@gmail.com, linux-pm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

(2013/08/30 22:16), Srivatsa S. Bhat wrote:
> The zones' freelists need to be made region-aware, in order to influe=
nce
> page allocation and freeing algorithms. So in every free list in the =
zone, we
> would like to demarcate the pageblocks belonging to different memory =
regions
> (we can do this using a set of pointers, and thus avoid splitting up =
the
> freelists).
>
> Also, we would like to keep the pageblocks in the freelists sorted in
> region-order. That is, pageblocks belonging to region-0 would come fi=
rst,
> followed by pageblocks belonging to region-1 and so on, within a give=
n
> freelist. Of course, a set of pageblocks belonging to the same region=
 need
> not be sorted; it is sufficient if we maintain the pageblocks in
> region-sorted-order, rather than a full address-sorted-order.
>
> For each freelist within the zone, we maintain a set of pointers to
> pageblocks belonging to the various memory regions in that zone.
>
> Eg:
>
>      |<---Region0--->|   |<---Region1--->|   |<-------Region2--------=
->|
>       ____      ____      ____      ____      ____      ____      ___=
_
> --> |____|--> |____|--> |____|--> |____|--> |____|--> |____|--> |____=
|-->
>
>                   ^                  ^                              ^
>                   |                  |                              |
>                  Reg0               Reg1                          Reg=
2
>
>
> Page allocation will proceed as usual - pick the first item on the fr=
ee list.
> But we don't want to keep updating these region pointers every time w=
e allocate
> a pageblock from the freelist. So, instead of pointing to the *first*=
 pageblock
> of that region, we maintain the region pointers such that they point =
to the
> *last* pageblock in that region, as shown in the figure above. That w=
ay, as
> long as there are > 1 pageblocks in that region in that freelist, tha=
t region
> pointer doesn't need to be updated.
>
>
> Page allocation algorithm:
> -------------------------
>
> The heart of the page allocation algorithm remains as it is - pick th=
e first
> item on the appropriate freelist and return it.
>
>
> Arrangement of pageblocks in the zone freelists:
> -----------------------------------------------
>
> This is the main change - we keep the pageblocks in region-sorted ord=
er,
> where pageblocks belonging to region-0 come first, followed by those =
belonging
> to region-1 and so on. But the pageblocks within a given region need =
*not* be
> sorted, since we need them to be only region-sorted and not fully
> address-sorted.
>
> This sorting is performed when adding pages back to the freelists, th=
us
> avoiding any region-related overhead in the critical page allocation
> paths.
>
> Strategy to consolidate allocations to a minimum no. of regions:
> ---------------------------------------------------------------
>
> Page allocation happens in the order of increasing region number. We =
would
> like to do light-weight page reclaim or compaction (for the purpose o=
f memory
> power management) in the reverse order, to keep the allocated pages w=
ithin
> a minimum number of regions (approximately). The latter part is imple=
mented
> in subsequent patches.
>
> ---------------------------- Increasing region number----------------=
------>
>
> Direction of allocation--->                <---Direction of reclaim/c=
ompaction
>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
>
>   mm/page_alloc.c |  154 ++++++++++++++++++++++++++++++++++++++++++++=
+++++------
>   1 file changed, 138 insertions(+), 16 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fd6436d0..398b62c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -514,6 +514,111 @@ static inline int page_is_buddy(struct page *pa=
ge, struct page *buddy,
>   	return 0;
>   }
>
> +static void add_to_freelist(struct page *page, struct free_list *fre=
e_list)
> +{
> +	struct list_head *prev_region_list, *lru;
> +	struct mem_region_list *region;
> +	int region_id, i;
> +
> +	lru =3D &page->lru;
> +	region_id =3D page_zone_region_id(page);
> +
> +	region =3D &free_list->mr_list[region_id];
> +	region->nr_free++;
> +
> +	if (region->page_block) {
> +		list_add_tail(lru, region->page_block);
> +		return;
> +	}
> +
> +#ifdef CONFIG_DEBUG_PAGEALLOC
> +	WARN(region->nr_free !=3D 1, "%s: nr_free is not unity\n", __func__=
);
> +#endif
> +
> +	if (!list_empty(&free_list->list)) {
> +		for (i =3D region_id - 1; i >=3D 0; i--) {
> +			if (free_list->mr_list[i].page_block) {
> +				prev_region_list =3D
> +					free_list->mr_list[i].page_block;
> +				goto out;
> +			}
> +		}
> +	}
> +
> +	/* This is the first region, so add to the head of the list */
> +	prev_region_list =3D &free_list->list;
> +
> +out:
> +	list_add(lru, prev_region_list);
> +
> +	/* Save pointer to page block of this region */
> +	region->page_block =3D lru;
> +}
> +
> +static void del_from_freelist(struct page *page, struct free_list *f=
ree_list)
> +{

> +	struct list_head *prev_page_lru, *lru, *p;
nitpick

*p is used only when enabling CONFIG_DEBUG_PAGEALLOC option.
When disabling the config option and compiling kernel, the
messages are shown.

   CC      mm/page_alloc.o
mm/page_alloc.c: In function =E2=80=98del_from_freelist=E2=80=99:
mm/page_alloc.c:560: =E8=AD=A6=E5=91=8A: unused variable =E2=80=98p=E2=80=
=99

Thanks,
Yasuaki Ishimatsu

> +	struct mem_region_list *region;
> +	int region_id;
> +
> +	lru =3D &page->lru;
> +	region_id =3D page_zone_region_id(page);
> +	region =3D &free_list->mr_list[region_id];
> +	region->nr_free--;
> +
> +#ifdef CONFIG_DEBUG_PAGEALLOC
> +	WARN(region->nr_free < 0, "%s: nr_free is negative\n", __func__);
> +
> +	/* Verify whether this page indeed belongs to this free list! */
> +
> +	list_for_each(p, &free_list->list) {
> +		if (p =3D=3D lru)
> +			goto page_found;
> +	}
> +
> +	WARN(1, "%s: page doesn't belong to the given freelist!\n", __func_=
_);
> +
> +page_found:
> +#endif
> +
> +	/*
> +	 * If we are not deleting the last pageblock in this region (i.e.,
> +	 * farthest from list head, but not necessarily the last numericall=
y),
> +	 * then we need not update the region->page_block pointer.
> +	 */
> +	if (lru !=3D region->page_block) {
> +		list_del(lru);
> +#ifdef CONFIG_DEBUG_PAGEALLOC
> +		WARN(region->nr_free =3D=3D 0, "%s: nr_free messed up\n", __func__=
);
> +#endif
> +		return;
> +	}
> +
> +	prev_page_lru =3D lru->prev;
> +	list_del(lru);
> +
> +	if (region->nr_free =3D=3D 0) {
> +		region->page_block =3D NULL;
> +	} else {
> +		region->page_block =3D prev_page_lru;
> +#ifdef CONFIG_DEBUG_PAGEALLOC
> +		WARN(prev_page_lru =3D=3D &free_list->list,
> +			"%s: region->page_block points to list head\n",
> +								__func__);
> +#endif
> +	}
> +}
> +
> +/**
> + * Move a given page from one freelist to another.
> + */
> +static void move_page_freelist(struct page *page, struct free_list *=
old_list,
> +			       struct free_list *new_list)
> +{
> +	del_from_freelist(page, old_list);
> +	add_to_freelist(page, new_list);
> +}
> +
>   /*
>    * Freeing function for a buddy system allocator.
>    *
> @@ -546,6 +651,7 @@ static inline void __free_one_page(struct page *p=
age,
>   	unsigned long combined_idx;
>   	unsigned long uninitialized_var(buddy_idx);
>   	struct page *buddy;
> +	struct free_area *area;
>
>   	VM_BUG_ON(!zone_is_initialized(zone));
>
> @@ -575,8 +681,9 @@ static inline void __free_one_page(struct page *p=
age,
>   			__mod_zone_freepage_state(zone, 1 << order,
>   						  migratetype);
>   		} else {
> -			list_del(&buddy->lru);
> -			zone->free_area[order].nr_free--;
> +			area =3D &zone->free_area[order];
> +			del_from_freelist(buddy, &area->free_list[migratetype]);
> +			area->nr_free--;
>   			rmv_page_order(buddy);
>   		}
>   		combined_idx =3D buddy_idx & page_idx;
> @@ -585,6 +692,7 @@ static inline void __free_one_page(struct page *p=
age,
>   		order++;
>   	}
>   	set_page_order(page, order);
> +	area =3D &zone->free_area[order];
>
>   	/*
>   	 * If this is not the largest possible page, check if the buddy
> @@ -601,16 +709,22 @@ static inline void __free_one_page(struct page =
*page,
>   		buddy_idx =3D __find_buddy_index(combined_idx, order + 1);
>   		higher_buddy =3D higher_page + (buddy_idx - combined_idx);
>   		if (page_is_buddy(higher_page, higher_buddy, order + 1)) {
> -			list_add_tail(&page->lru,
> -				&zone->free_area[order].free_list[migratetype].list);
> +
> +			/*
> +			 * Implementing an add_to_freelist_tail() won't be
> +			 * very useful because both of them (almost) add to
> +			 * the tail within the region. So we could potentially
> +			 * switch off this entire "is next-higher buddy free?"
> +			 * logic when memory regions are used.
> +			 */
> +			add_to_freelist(page, &area->free_list[migratetype]);
>   			goto out;
>   		}
>   	}
>
> -	list_add(&page->lru,
> -		&zone->free_area[order].free_list[migratetype].list);
> +	add_to_freelist(page, &area->free_list[migratetype]);
>   out:
> -	zone->free_area[order].nr_free++;
> +	area->nr_free++;
>   }
>
>   static inline int free_pages_check(struct page *page)
> @@ -830,7 +944,7 @@ static inline void expand(struct zone *zone, stru=
ct page *page,
>   			continue;
>   		}
>   #endif
> -		list_add(&page[size].lru, &area->free_list[migratetype].list);
> +		add_to_freelist(&page[size], &area->free_list[migratetype]);
>   		area->nr_free++;
>   		set_page_order(&page[size], high);
>   	}
> @@ -897,7 +1011,7 @@ struct page *__rmqueue_smallest(struct zone *zon=
e, unsigned int order,
>
>   		page =3D list_entry(area->free_list[migratetype].list.next,
>   							struct page, lru);
> -		list_del(&page->lru);
> +		del_from_freelist(page, &area->free_list[migratetype]);
>   		rmv_page_order(page);
>   		area->nr_free--;
>   		expand(zone, page, order, current_order, area, migratetype);
> @@ -938,7 +1052,8 @@ int move_freepages(struct zone *zone,
>   {
>   	struct page *page;
>   	unsigned long order;
> -	int pages_moved =3D 0;
> +	struct free_area *area;
> +	int pages_moved =3D 0, old_mt;
>
>   #ifndef CONFIG_HOLES_IN_ZONE
>   	/*
> @@ -966,8 +1081,10 @@ int move_freepages(struct zone *zone,
>   		}
>
>   		order =3D page_order(page);
> -		list_move(&page->lru,
> -			  &zone->free_area[order].free_list[migratetype].list);
> +		old_mt =3D get_freepage_migratetype(page);
> +		area =3D &zone->free_area[order];
> +		move_page_freelist(page, &area->free_list[old_mt],
> +				    &area->free_list[migratetype]);
>   		set_freepage_migratetype(page, migratetype);
>   		page +=3D 1 << order;
>   		pages_moved +=3D 1 << order;
> @@ -1061,7 +1178,7 @@ __rmqueue_fallback(struct zone *zone, int order=
, int start_migratetype)
>   	struct free_area * area;
>   	int current_order;
>   	struct page *page;
> -	int migratetype, new_type, i;
> +	int migratetype, new_type, i, mt;
>
>   	/* Find the largest possible block of pages in the other list */
>   	for (current_order =3D MAX_ORDER-1; current_order >=3D order;
> @@ -1086,7 +1203,8 @@ __rmqueue_fallback(struct zone *zone, int order=
, int start_migratetype)
>   							  migratetype);
>
>   			/* Remove the page from the freelists */
> -			list_del(&page->lru);
> +			mt =3D get_freepage_migratetype(page);
> +			del_from_freelist(page, &area->free_list[mt]);
>   			rmv_page_order(page);
>
>   			/*
> @@ -1446,7 +1564,8 @@ static int __isolate_free_page(struct page *pag=
e, unsigned int order)
>   	}
>
>   	/* Remove page from free list */
> -	list_del(&page->lru);
> +	mt =3D get_freepage_migratetype(page);
> +	del_from_freelist(page, &zone->free_area[order].free_list[mt]);
>   	zone->free_area[order].nr_free--;
>   	rmv_page_order(page);
>
> @@ -6353,6 +6472,8 @@ __offline_isolated_pages(unsigned long start_pf=
n, unsigned long end_pfn)
>   	int order, i;
>   	unsigned long pfn;
>   	unsigned long flags;
> +	int mt;
> +
>   	/* find the first valid pfn */
>   	for (pfn =3D start_pfn; pfn < end_pfn; pfn++)
>   		if (pfn_valid(pfn))
> @@ -6385,7 +6506,8 @@ __offline_isolated_pages(unsigned long start_pf=
n, unsigned long end_pfn)
>   		printk(KERN_INFO "remove from free list %lx %d %lx\n",
>   		       pfn, 1 << order, end_pfn);
>   #endif
> -		list_del(&page->lru);
> +		mt =3D get_freepage_migratetype(page);
> +		del_from_freelist(page, &zone->free_area[order].free_list[mt]);
>   		rmv_page_order(page);
>   		zone->free_area[order].nr_free--;
>   #ifdef CONFIG_HIGHMEM
>


