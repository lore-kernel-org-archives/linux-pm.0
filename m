From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2 3/8] kexec: export PG_offline to VMCOREINFO
Date: Mon, 11 Mar 2019 18:04:38 +0800
Message-ID: <20190311100438.GA12545@dhcp-128-65.nay.redhat.com>
References: <20181122100627.5189-1-david@redhat.com>
 <20181122100627.5189-4-david@redhat.com>
 <20190311090402.GA12071@dhcp-128-65.nay.redhat.com>
 <d9e578c3-5ae6-5e82-a0a8-14c7e12c729f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d9e578c3-5ae6-5e82-a0a8-14c7e12c729f@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org, kexec-ml <kexec@lists.infradead.org>, pv-drivers@vmware.com, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Baoquan He <bhe@redhat.com>, Omar Sandoval <osandov@fb.com>, Arnd Bergmann <arnd@arndb.de>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>, Lianbo Jiang <lijiang@redhat.com>, Borislav Petkov <bp@alien8.de>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>
List-Id: linux-pm@vger.kernel.org

> > The patch has been merged, would you mind to send a documentation patch
> > for the vmcoreinfo, which is added recently in Documentation/kdump/vmcoreinfo.txt
> > 
> > A brief description about how this vmcoreinfo field is used is good to
> > have.
> > 
> 
> Turns out, it was already documented
> 
> PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_slab|PG_hwpoision
> |PG_head_mask|PAGE_BUDDY_MAPCOUNT_VALUE(~PG_buddy)
> |PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)
> -----------------------------------------------------------------
> 
> Page attributes. These flags are used to filter various unnecessary for
> dumping pages.

Good enough, just ignore the request!

Thanks!
