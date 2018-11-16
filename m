From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 0/6] mm/kdump: allow to exclude pages that are
 logically offline
Date: Fri, 16 Nov 2018 19:23:20 +0100
Message-ID: <a0b995a2-d78e-8413-f232-9a82b4d4f5b5@redhat.com>
References: <20181114211704.6381-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114211704.6381-1-david@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Christian Hansen <chansen3@cisco.com>, Dave Young <dyoung@redhat.com>, David Rientjes <rientjes@google.com>, Haiyang Zhang <haiyangz@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>, Kairui Song <kasong@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: linux-pm@vger.kernel.org

On 14.11.18 22:16, David Hildenbrand wrote:
> Right now, pages inflated as part of a balloon driver will be dumped
> by dump tools like makedumpfile. While XEN is able to check in the
> crash kernel whether a certain pfn is actuall backed by memory in the
> hypervisor (see xen_oldmem_pfn_is_ram) and optimize this case, dumps of
> virtio-balloon and hv-balloon inflated memory will essentially result in
> zero pages getting allocated by the hypervisor and the dump getting
> filled with this data.
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
> As I don't have access to neither XEN nor Hyper-V installation, this was
> not tested yet (and a makedumpfile change will be required to skip
> dumping these pages).
> 
> [1] https://lkml.org/lkml/2018/7/20/566
> 
> David Hildenbrand (6):
>   mm: balloon: update comment about isolation/migration/compaction
>   mm: convert PG_balloon to PG_offline
>   kexec: export PG_offline to VMCOREINFO
>   xen/balloon: mark inflated pages PG_offline
>   hv_balloon: mark inflated pages PG_offline
>   PM / Hibernate: exclude all PageOffline() pages
> 
>  Documentation/admin-guide/mm/pagemap.rst |  6 +++++
>  drivers/hv/hv_balloon.c                  | 14 ++++++++--
>  drivers/xen/balloon.c                    |  3 +++
>  fs/proc/page.c                           |  4 +--
>  include/linux/balloon_compaction.h       | 34 +++++++++---------------
>  include/linux/page-flags.h               | 11 +++++---
>  include/uapi/linux/kernel-page-flags.h   |  1 +
>  kernel/crash_core.c                      |  2 ++
>  kernel/power/snapshot.c                  |  5 +++-
>  tools/vm/page-types.c                    |  1 +
>  10 files changed, 51 insertions(+), 30 deletions(-)
> 

I just did a test with virtio-balloon (and a very simple makedumpfile
patch which I can supply on demand).

1. Guest with 8GB. Inflate balloon to 4GB via
 sudo virsh setmem f29 --size 4096M --live

2. Trigger a kernel panic in the guest
    echo 1 > /proc/sys/kernel/sysrq
    echo c > /proc/sysrq-trigger

Original pages  : 0x00000000001e1da8
  Excluded pages   : 0x00000000001c9221
    Pages filled with zero  : 0x00000000000050b0
    Non-private cache pages : 0x0000000000046547
    Private cache pages     : 0x0000000000002165
    User process data pages : 0x00000000000048cf
    Free pages              : 0x00000000000771f6
    Hwpoison pages          : 0x0000000000000000
    Offline pages           : 0x0000000000100000
  Remaining pages  : 0x0000000000018b87
  (The number of pages is reduced to 5%.)
Memory Hole     : 0x000000000009e258
--------------------------------------------------
Total pages     : 0x0000000000280000

(Offline patches matches the 4GB)

-- 

Thanks,

David / dhildenb
