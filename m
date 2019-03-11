From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2 3/8] kexec: export PG_offline to VMCOREINFO
Date: Mon, 11 Mar 2019 17:04:02 +0800
Message-ID: <20190311090402.GA12071@dhcp-128-65.nay.redhat.com>
References: <20181122100627.5189-1-david@redhat.com>
 <20181122100627.5189-4-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181122100627.5189-4-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org, kexec-ml <kexec@lists.infradead.org>, pv-drivers@vmware.com, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Baoquan He <bhe@redhat.com>, Omar Sandoval <osandov@fb.com>, Arnd Bergmann <arnd@arndb.de>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>, Lianbo Jiang <lijiang@redhat.com>, Borislav Petkov <bp@alien8.de>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>
List-Id: linux-pm@vger.kernel.org

Hi David,
On 11/22/18 at 11:06am, David Hildenbrand wrote:
> Right now, pages inflated as part of a balloon driver will be dumped
> by dump tools like makedumpfile. While XEN is able to check in the
> crash kernel whether a certain pfn is actuall backed by memory in the
> hypervisor (see xen_oldmem_pfn_is_ram) and optimize this case, dumps of
> other balloon inflated memory will essentially result in zero pages getting
> allocated by the hypervisor and the dump getting filled with this data.
> 
> The allocation and reading of zero pages can directly be avoided if a
> dumping tool could know which pages only contain stale information not to
> be dumped.
> 
> We now have PG_offline which can be (and already is by virtio-balloon)
> used for marking pages as logically offline. Follow up patches will
> make use of this flag also in other balloon implementations.
> 
> Let's export PG_offline via PAGE_OFFLINE_MAPCOUNT_VALUE, so
> makedumpfile can directly skip pages that are logically offline and the
> content therefore stale. (we export is as a macro to match how it is
> done for PG_buddy. This way it is clearer that this is not actually a flag
> but only a very specific mapcount value to represent page types).
> 
> Please note that this is also helpful for a problem we were seeing under
> Hyper-V: Dumping logically offline memory (pages kept fake offline while
> onlining a section via online_page_callback) would under some condicions
> result in a kernel panic when dumping them.
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
> Cc: Lianbo Jiang <lijiang@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Dave Young <dyoung@redhat.com>
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

The patch has been merged, would you mind to send a documentation patch
for the vmcoreinfo, which is added recently in Documentation/kdump/vmcoreinfo.txt

A brief description about how this vmcoreinfo field is used is good to
have.

Thanks
Dave
