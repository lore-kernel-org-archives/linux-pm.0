From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2 0/8] mm/kdump: allow to exclude pages that are
 logically offline
Date: Wed, 27 Feb 2019 13:32:14 +0800
Message-ID: <20190227053214.GA12302@dhcp-128-65.nay.redhat.com>
References: <20181122100627.5189-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20181122100627.5189-1-david@redhat.com>
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
Cc: Pankaj gupta <pagupta@redhat.com>, Michal Hocko <mhocko@suse.com>, Lianbo Jiang <lijiang@redhat.com>, linux-doc@vger.kernel.org, pv-drivers@vmware.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Nadav Amit <namit@vmware.com>, Pavel Machek <pavel@ucw.cz>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Omar Sandoval <osandov@fb.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Stefano Stabellini <sstabellini@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "Michael S. Tsirkin" <mst@redhat.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, Matthew Wilcox <willy@infradead.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, xen-devel@lists.xenproject.org, Alexey Dobriyan <adobriyan@gmail.>
List-Id: linux-pm@vger.kernel.org

On 11/22/18 at 11:06am, David Hildenbrand wrote:
> Right now, pages inflated as part of a balloon driver will be dumped
> by dump tools like makedumpfile. While XEN is able to check in the
> crash kernel whether a certain pfn is actually backed by memory in the
> hypervisor (see xen_oldmem_pfn_is_ram) and optimize this case, dumps of
> virtio-balloon, hv-balloon and VMWare balloon inflated memory will
> essentially result in zero pages getting allocated by the hypervisor and
> the dump getting filled with this data.
> 
> The allocation and reading of zero pages can directly be avoided if a
> dumping tool could know which pages only contain stale information not to
> be dumped.
> 
> Also for XEN, calling into the kernel and asking the hypervisor if a
> pfn is backed can be avoided if the duming tool would skip such pages
> right from the beginning.
> 
> Dumping tools have no idea whether a given page is part of a balloon driver
> and shall not be dumped. Esp. PG_reserved cannot be used for that purpose
> as all memory allocated during early boot is also PG_reserved, see
> discussion at [1]. So some other way of indication is required and a new
> page flag is frowned upon.
> 
> We have PG_balloon (MAPCOUNT value), which is essentially unused now. I
> suggest renaming it to something more generic (PG_offline) to mark pages as
> logically offline. This flag can than e.g. also be used by virtio-mem in
> the future to mark subsections as offline. Or by other code that wants to
> put pages logically offline (e.g. later maybe poisoned pages that shall
> no longer be used).
> 
> This series converts PG_balloon to PG_offline, allows dumping tools to
> query the value to detect such pages and marks pages in the hv-balloon
> and XEN balloon properly as PG_offline. Note that virtio-balloon already
> set pages to PG_balloon (and now PG_offline).
> 
> Please note that this is also helpful for a problem we were seeing under
> Hyper-V: Dumping logically offline memory (pages kept fake offline while
> onlining a section via online_page_callback) would under some condicions
> result in a kernel panic when dumping them.
> 
> As I don't have access to neither XEN nor Hyper-V nor VMWare installations,
> this was only tested with the virtio-balloon and pages were properly
> skipped when dumping. I'll also attach the makedumpfile patch to this
> series.
> 
> [1] https://lkml.org/lkml/2018/7/20/566
> 
> v1 -> v2:
> - "kexec: export PG_offline to VMCOREINFO"
> -- Add description why it is exported as a macro
> - "vmw_balloon: mark inflated pages PG_offline"
> -- Use helper function + adapt comments
> - "PM / Hibernate: exclude all PageOffline() pages"
> -- Perform the check separate from swsusp checks.
> - Added RBs/ACKs
> 
> 
> David Hildenbrand (8):
>   mm: balloon: update comment about isolation/migration/compaction
>   mm: convert PG_balloon to PG_offline
>   kexec: export PG_offline to VMCOREINFO
>   xen/balloon: mark inflated pages PG_offline
>   hv_balloon: mark inflated pages PG_offline
>   vmw_balloon: mark inflated pages PG_offline
>   PM / Hibernate: use pfn_to_online_page()
>   PM / Hibernate: exclude all PageOffline() pages
> 
>  Documentation/admin-guide/mm/pagemap.rst |  9 ++++---
>  drivers/hv/hv_balloon.c                  | 14 ++++++++--
>  drivers/misc/vmw_balloon.c               | 32 ++++++++++++++++++++++
>  drivers/xen/balloon.c                    |  3 +++
>  fs/proc/page.c                           |  4 +--
>  include/linux/balloon_compaction.h       | 34 +++++++++---------------
>  include/linux/page-flags.h               | 11 +++++---
>  include/uapi/linux/kernel-page-flags.h   |  2 +-
>  kernel/crash_core.c                      |  2 ++
>  kernel/power/snapshot.c                  | 17 +++++++-----
>  tools/vm/page-types.c                    |  2 +-
>  11 files changed, 90 insertions(+), 40 deletions(-)
> 
> -- 
> 2.17.2
> 

This series have been in -next for some days, could we get this in
mainline? 

Andrew, do you have plan about them, maybe next release?

Thanks
Dave
