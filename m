From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 0/6] mm/kdump: allow to exclude pages that are logically
 offline
Date: Wed, 14 Nov 2018 22:16:58 +0100
Message-ID: <20181114211704.6381-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: linux-mm@kvack.org
Cc: Michal Hocko <mhocko@suse.com>, linux-doc@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>, Pavel Machek <pavel@ucw.cz>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Omar Sandoval <osandov@fb.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Stefano Stabellini <sstabellini@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>, xen-devel@lists.xenproject.org, Dave Young <dyoung@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, Len Brown <len.brown@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-pm@vger.kernel.org

Right now, pages inflated as part of a balloon driver will be dumped
by dump tools like makedumpfile. While XEN is able to check in the
crash kernel whether a certain pfn is actuall backed by memory in the
hypervisor (see xen_oldmem_pfn_is_ram) and optimize this case, dumps of
virtio-balloon and hv-balloon inflated memory will essentially result in
zero pages getting allocated by the hypervisor and the dump getting
filled with this data.

The allocation and reading of zero pages can directly be avoided if a
dumping tool could know which pages only contain stale information not to
be dumped.

Also for XEN, calling into the kernel and asking the hypervisor if a
pfn is backed can be avoided if the duming tool would skip such pages
right from the beginning.

Dumping tools have no idea whether a given page is part of a balloon driver
and shall not be dumped. Esp. PG_reserved cannot be used for that purpose
as all memory allocated during early boot is also PG_reserved, see
discussion at [1]. So some other way of indication is required and a new
page flag is frowned upon.

We have PG_balloon (MAPCOUNT value), which is essentially unused now. I
suggest renaming it to something more generic (PG_offline) to mark pages as
logically offline. This flag can than e.g. also be used by virtio-mem in
the future to mark subsections as offline. Or by other code that wants to
put pages logically offline (e.g. later maybe poisoned pages that shall
no longer be used).

This series converts PG_balloon to PG_offline, allows dumping tools to
query the value to detect such pages and marks pages in the hv-balloon
and XEN balloon properly as PG_offline. Note that virtio-balloon already
set pages to PG_balloon (and now PG_offline).

Please note that this is also helpful for a problem we were seeing under
Hyper-V: Dumping logically offline memory (pages kept fake offline while
onlining a section via online_page_callback) would under some condicions
result in a kernel panic when dumping them.

As I don't have access to neither XEN nor Hyper-V installation, this was
not tested yet (and a makedumpfile change will be required to skip
dumping these pages).

[1] https://lkml.org/lkml/2018/7/20/566

David Hildenbrand (6):
  mm: balloon: update comment about isolation/migration/compaction
  mm: convert PG_balloon to PG_offline
  kexec: export PG_offline to VMCOREINFO
  xen/balloon: mark inflated pages PG_offline
  hv_balloon: mark inflated pages PG_offline
  PM / Hibernate: exclude all PageOffline() pages

 Documentation/admin-guide/mm/pagemap.rst |  6 +++++
 drivers/hv/hv_balloon.c                  | 14 ++++++++--
 drivers/xen/balloon.c                    |  3 +++
 fs/proc/page.c                           |  4 +--
 include/linux/balloon_compaction.h       | 34 +++++++++---------------
 include/linux/page-flags.h               | 11 +++++---
 include/uapi/linux/kernel-page-flags.h   |  1 +
 kernel/crash_core.c                      |  2 ++
 kernel/power/snapshot.c                  |  5 +++-
 tools/vm/page-types.c                    |  1 +
 10 files changed, 51 insertions(+), 30 deletions(-)

-- 
2.17.2
