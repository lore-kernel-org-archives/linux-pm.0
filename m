From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 8/8] PM / Hibernate: exclude all PageOffline() pages
Date: Wed, 21 Nov 2018 13:21:08 +0100
Message-ID: <88f19102-9830-1ed0-1f46-56e11316ca09@redhat.com>
References: <20181119101616.8901-1-david@redhat.com>
 <20181119101616.8901-9-david@redhat.com>
 <11E3C0B0-AEED-42C6-A21C-1820F4B47A68@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11E3C0B0-AEED-42C6-A21C-1820F4B47A68@oracle.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: William Kucharski <william.kucharski@oracle.com>
Cc: Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org, kexec-ml <kexec@lists.infradead.org>, pv-drivers@vmware.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: linux-pm@vger.kernel.org

On 21.11.18 12:35, William Kucharski wrote:
> If you are adding PageOffline(page) to the condition list of the already existing if in
> saveable_highmem_page(), why explicitly add it as a separate statement in saveable_page()?
> 
> It would seem more consistent to make the second check:
> 
> -	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
> +	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page) ||
> +		PageOffline(page))
> 
> instead.
> 
> It's admittedly a nit but it just seems cleaner to either do that or, if your intention
> was to separate the Page checks from the swsusp checks, to break the calls to
> PageReserved() and PageOffline() into their own check in saveable_highmem_page().

I'll split PageReserved() and PageOffline() off from the swsusp checks,
thanks for your comment!

> 
> Thanks!
>     -- Bill


-- 

Thanks,

David / dhildenb
