From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/11] ACPI: Fixes and cleanups related to iomaps
	management
Date: Thu, 20 Jan 2011 12:26:40 +0100
Message-ID: <201101201226.41021.rjw__25698.2129453265$1295523810$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Len,

The following series of patches implements some fixes of the ACPI iomaps
management.  I found the problems trying to resolve the issue of creating
iomaps of regions that have been mapped already when we save the NVS region.

The first two patches are the same as https://patchwork.kernel.org/patch/490071/
(except for the changelog) and https://patchwork.kernel.org/patch/490061/,
respectively, and they are 2.6.38 regression fix material.  The other patches
are not that urgent, because the related issues are generally long-standing,
but some bugs addressed by them (especially [3/11]) may be actively hurting
people right now, so the patches look suitable for .38 to me as well, but this
is your call.

[1/11] - Introduce acpi_os_ioremap() to be called by ACPI code creating
         iomaps, so that they are mapped in the consistent way.

[2/11] - Move the call to suspend_nvs_free() to acpi_pm_finish() so that it's
         executed before device drivers' resume routines to avoid possible
         iomaps conflicts.

[3/11] - Fix routines for reading and writing iomem (RCU bug and mapping
         regions on the fly).

[4/11] - (cleanup) Do not export local functions in osl.c.

[5/11] - Use a mutex (instead of a spinlock) for the locking of iomap
         manipulations in osl.c.

[6/11] - Avoid unnecessary walks of the list of iomaps in osl.c.

[7/11] - Avoid creating iomaps for regions that have been mapped already.

[8/11] - Replace krefs used for iomap refcounting with simple reference
         counters (they are manipulated under a lock anyway).

[9/11] - Introduce function for getting a reference to an ACPI iomap (to be
         used by the NVS save/restore code).

[10/11] - Make the NVS code use existing iomaps if possible.

[11/11] - (cleanup) Remove an unnecessary field from struct nvs_page.

The patches have been tested on HP nx6325, Toshiba Portege R500 and Acer
Ferrari One without causing any visible problems to happen.  Also Jeff has
tested [1/11] and [2/11] and he reports that they fix the synchronize_rcu()
problem for him.  [Jeff, can you test the whole series, please, and see if
it doesn't introduce any new issues, [10/11] in particular?]

Thanks,
Rafael
