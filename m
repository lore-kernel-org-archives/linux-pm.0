From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 2/8] mm: convert PG_balloon to PG_offline
Date: Mon, 19 Nov 2018 17:06:12 +0100
Message-ID: <94387ebe-9fb3-9471-9fb3-b66abf899a3f@redhat.com>
References: <20181119101616.8901-1-david@redhat.com>
 <20181119101616.8901-3-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119101616.8901-3-david@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org, kexec-ml <kexec@lists.infradead.org>, pv-drivers@vmware.com, Jonathan Corbet <corbet@lwn.net>, Alexey Dobriyan <adobriyan@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Christian Hansen <chansen3@cisco.com>, Vlastimil Babka <vbabka@suse.cz>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Matthew Wilcox <willy@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

>  
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 50ce1bddaf56..f91da3d0a67e 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -670,7 +670,7 @@ PAGEFLAG_FALSE(DoubleMap)
>  #define PAGE_TYPE_BASE	0xf0000000
>  /* Reserve		0x0000007f to catch underflows of page_mapcount */
>  #define PG_buddy	0x00000080
> -#define PG_balloon	0x00000100
> +#define PG_offline	0x00000100
>  #define PG_kmemcg	0x00000200
>  #define PG_table	0x00000400
>  
> @@ -700,10 +700,13 @@ static __always_inline void __ClearPage##uname(struct page *page)	\
>  PAGE_TYPE_OPS(Buddy, buddy)
>  
>  /*
> - * PageBalloon() is true for pages that are on the balloon page list
> - * (see mm/balloon_compaction.c).
> + * PageOffline() indicates that the pages is logically offline although the

s/pages/page/

:)


-- 

Thanks,

David / dhildenb
