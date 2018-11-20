From: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [PATCH v1 5/8] hv_balloon: mark inflated pages PG_offline
Date: Tue, 20 Nov 2018 04:37:16 -0500 (EST)
Message-ID: <1380154502.35259416.1542706636322.JavaMail.zimbra@redhat.com>
References: <20181119101616.8901-1-david@redhat.com> <20181119101616.8901-6-david@redhat.com> <1747228.35250472.1542703532881.JavaMail.zimbra@redhat.com> <6258a58b-28c7-c055-0752-e8bd085b835f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6258a58b-28c7-c055-0752-e8bd085b835f@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org, kexec-ml <kexec@lists.infradead.org>, pv-drivers@vmware.com, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Kairui Song <kasong@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: linux-pm@vger.kernel.org


> >> ---
> >>  drivers/hv/hv_balloon.c | 14 ++++++++++++--
> >>  1 file changed, 12 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> >> index 211f3fe3a038..47719862e57f 100644
> >> --- a/drivers/hv/hv_balloon.c
> >> +++ b/drivers/hv/hv_balloon.c
> >> @@ -681,8 +681,13 @@ static struct notifier_block hv_memory_nb = {
> >>  /* Check if the particular page is backed and can be onlined and online
> >>  it.
> >>  */
> >>  static void hv_page_online_one(struct hv_hotadd_state *has, struct page
> >>  *pg)
> >>  {
> >> -	if (!has_pfn_is_backed(has, page_to_pfn(pg)))
> >> +	if (!has_pfn_is_backed(has, page_to_pfn(pg))) {
> >> +		if (!PageOffline(pg))
> >> +			__SetPageOffline(pg);
> >>  		return;
> >> +	}
> >> +	if (PageOffline(pg))
> >> +		__ClearPageOffline(pg);
> >>  
> >>  	/* This frame is currently backed; online the page. */
> >>  	__online_page_set_limits(pg);
> >> @@ -1201,6 +1206,7 @@ static void free_balloon_pages(struct
> >> hv_dynmem_device
> >> *dm,
> >>  
> >>  	for (i = 0; i < num_pages; i++) {
> >>  		pg = pfn_to_page(i + start_frame);
> >> +		__ClearPageOffline(pg);
> > 
> > Just thinking, do we need to care for clearing PageOffline flag before
> > freeing
> > a balloon'd page?
> 
> Yes we have to otherwise the code will crash when trying to set PageBuddy.
> 
> (only one page type at a time may be set right now, and it makes sense.
> A page that is offline cannot e.g. be a buddy page)

o.k
> 
> So PageOffline is completely managed by the page owner.

Makes sense. Thanks for explaining.

Pankaj
> 
> > 
> > Thanks,
> > Pankaj
> 
> 
> --
> 
> Thanks,
> 
> David / dhildenb
> 
