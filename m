From: William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v1 8/8] PM / Hibernate: exclude all PageOffline() pages
Date: Wed, 21 Nov 2018 04:35:46 -0700
Message-ID: <11E3C0B0-AEED-42C6-A21C-1820F4B47A68@oracle.com>
References: <20181119101616.8901-1-david@redhat.com>
 <20181119101616.8901-9-david@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20181119101616.8901-9-david@redhat.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: David Hildenbrand <david@redhat.com>
Cc: Len Brown <len.brown@intel.com>, Michal Hocko <mhocko@suse.com>, linux-pm@vger.kernel.org, pv-drivers@vmware.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-doc@vger.kernel.org, kexec-ml <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Linux-MM <linux-mm@kvack.org>, "Michael S. Tsirkin" <mst@redhat.com>, Pavel Machek <pavel@ucw.cz>, xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, devel@linuxdriverproject.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

If you are adding PageOffline(page) to the condition list of the already existing if in
saveable_highmem_page(), why explicitly add it as a separate statement in saveable_page()?

It would seem more consistent to make the second check:

-	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
+	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page) ||
+		PageOffline(page))

instead.

It's admittedly a nit but it just seems cleaner to either do that or, if your intention
was to separate the Page checks from the swsusp checks, to break the calls to
PageReserved() and PageOffline() into their own check in saveable_highmem_page().

Thanks!
    -- Bill
     

> On Nov 19, 2018, at 3:16 AM, David Hildenbrand <david@redhat.com> wrote:
> 
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1222,7 +1222,7 @@ static struct page *saveable_highmem_page(struct zone *zone, unsigned long pfn)
> 	BUG_ON(!PageHighMem(page));
> 
> 	if (swsusp_page_is_forbidden(page) ||  swsusp_page_is_free(page) ||
> -	    PageReserved(page))
> +	    PageReserved(page) || PageOffline(page))
> 		return NULL;
> 
> 	if (page_is_guard(page))
> @@ -1286,6 +1286,9 @@ static struct page *saveable_page(struct zone *zone, unsigned long pfn)
> 	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
> 		return NULL;
> 
> +	if (PageOffline(page))
> +		return NULL;
> +
> 	if (PageReserved(page)
> 	    && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
> 		return NULL;
> -- 
> 2.17.2
> 
