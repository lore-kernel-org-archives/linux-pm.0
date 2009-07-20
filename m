From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] hibernate / memory hotplug: always use
	for_each_populated_zone()
Date: Mon, 20 Jul 2009 18:04:59 +0200
Message-ID: <200907201804.59851.rjw__681.162896990095$1248112069$gmane$org@sisk.pl>
References: <1248103551.23961.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1248103551.23961.0.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Yasunori Goto <y-goto@jp.fujitsu.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

On Monday 20 July 2009, Gerald Schaefer wrote:
> From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> 
> Use for_each_populated_zone() instead of for_each_zone() in hibernation
> code. This fixes a bug on s390, where we allow both config options
> HIBERNATION and MEMORY_HOTPLUG, so that we also have a ZONE_MOVABLE
> here. We only allow hibernation if no memory hotplug operation was
> performed, so in fact both features can only be used exclusively, but
> this way we don't need 2 differently configured (distribution) kernels.
> 
> If we have an unpopulated ZONE_MOVABLE, we allow hibernation but run
> into a BUG_ON() in memory_bm_test/set/clear_bit() because hibernation
> code iterates through all zones, not only the populated zones, in
> several places. For example, swsusp_free() does for_each_zone() and
> then checks for pfn_valid(), which is true even if the zone is not
> populated, resulting in a BUG_ON() later because the pfn cannot be
> found in the memory bitmap.
> 
> Replacing all occurences of for_each_zone() in hibernation code with
> for_each_populated_zone() would fix this issue.

Thanks for the patch, I'm going to add it to my 2.6.32 queue.

Best,
Rafael


> Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> ---
>  kernel/power/snapshot.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Index: linux-2.6-work/kernel/power/snapshot.c
> ===================================================================
> --- linux-2.6-work.orig/kernel/power/snapshot.c
> +++ linux-2.6-work/kernel/power/snapshot.c
> @@ -853,7 +853,7 @@ static unsigned int count_highmem_pages(
>  	struct zone *zone;
>  	unsigned int n = 0;
>  
> -	for_each_zone(zone) {
> +	for_each_populated_zone(zone) {
>  		unsigned long pfn, max_zone_pfn;
>  
>  		if (!is_highmem(zone))
> @@ -916,7 +916,7 @@ static unsigned int count_data_pages(voi
>  	unsigned long pfn, max_zone_pfn;
>  	unsigned int n = 0;
>  
> -	for_each_zone(zone) {
> +	for_each_populated_zone(zone) {
>  		if (is_highmem(zone))
>  			continue;
>  
> @@ -1010,7 +1010,7 @@ copy_data_pages(struct memory_bitmap *co
>  	struct zone *zone;
>  	unsigned long pfn;
>  
> -	for_each_zone(zone) {
> +	for_each_populated_zone(zone) {
>  		unsigned long max_zone_pfn;
>  
>  		mark_free_pages(zone);
> @@ -1046,7 +1046,7 @@ void swsusp_free(void)
>  	struct zone *zone;
>  	unsigned long pfn, max_zone_pfn;
>  
> -	for_each_zone(zone) {
> +	for_each_populated_zone(zone) {
>  		max_zone_pfn = zone->zone_start_pfn + zone->spanned_pages;
>  		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
>  			if (pfn_valid(pfn)) {
> @@ -1166,7 +1166,7 @@ static int enough_free_mem(unsigned int 
>  	struct zone *zone;
>  	unsigned int free = 0, meta = 0;
>  
> -	for_each_zone(zone) {
> +	for_each_populated_zone(zone) {
>  		meta += snapshot_additional_pages(zone);
>  		if (!is_highmem(zone))
>  			free += zone_page_state(zone, NR_FREE_PAGES);
> @@ -1474,7 +1474,7 @@ static int mark_unsafe_pages(struct memo
>  	unsigned long pfn, max_zone_pfn;
>  
>  	/* Clear page flags */
> -	for_each_zone(zone) {
> +	for_each_populated_zone(zone) {
>  		max_zone_pfn = zone->zone_start_pfn + zone->spanned_pages;
>  		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
>  			if (pfn_valid(pfn))
> 
> 
> 
