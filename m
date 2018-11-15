From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH RFC 3/6] kexec: export PG_offline to VMCOREINFO
Date: Thu, 15 Nov 2018 14:19:23 +0800
Message-ID: <20181115061923.GA3971@dhcp-128-65.nay.redhat.com>
References: <20181114211704.6381-1-david@redhat.com>
 <20181114211704.6381-4-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181114211704.6381-4-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Baoquan He <bhe@redhat.com>, Omar Sandoval <osandov@fb.com>, Arnd Bergmann <arnd@arndb.de>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, Lianbo Jiang <lijiang@redhat.com>, Borislav Petkov <bp@alien8.de>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi David,

On 11/14/18 at 10:17pm, David Hildenbrand wrote:
> Let's export PG_offline via PAGE_OFFLINE_MAPCOUNT_VALUE, so
> makedumpfile can directly skip pages that are logically offline and the
> content therefore stale.

It would be good to copy some background info from cover letter to the
patch description so that we can get better understanding why this is
needed now.

BTW, Lianbo is working on a documentation of the vmcoreinfo exported
fields. Ccing him so that he is aware of this.

Also cc Boris,  although I do not want the doc changes blocks this
he might have different opinion :)

> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  kernel/crash_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 933cb3e45b98..093c9f917ed0 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -464,6 +464,8 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
>  #ifdef CONFIG_HUGETLB_PAGE
>  	VMCOREINFO_NUMBER(HUGETLB_PAGE_DTOR);
> +#define PAGE_OFFLINE_MAPCOUNT_VALUE	(~PG_offline)
> +	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
>  #endif
>  
>  	arch_crash_save_vmcoreinfo();
> -- 
> 2.17.2
> 

Thanks
Dave
