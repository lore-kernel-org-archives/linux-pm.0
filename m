From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/8] ACPI: Fixes and cleanups related to iomaps
	management (v2)
Date: Tue, 25 Jan 2011 00:25:10 +0100
Message-ID: <201101250025.10817.rjw__8956.18604631654$1295912249$gmane$org@sisk.pl>
References: <201101201226.41021.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101201226.41021.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Len,

The following series of patches implements some fixes of the ACPI iomaps
management.  I found the problems trying to resolve the issue of creating
iomaps of regions that have been mapped already when we save the NVS region.

To me, they are not extremely urgent, because the related issues are generally
long-standing, but some bugs addressed by them (especially [1/9]) may be
actively hurting people right now, so they look suitable for .38 as well.
This is your call, though.
 
[1/8] - Fix routines for reading and writing iomem (RCU bug; new version of the
        patch).

[2/8] - (cleanup) Do not export local functions in osl.c (this one is the same
        as https://patchwork.kernel.org/patch/491551/).

[3/8] - Use a mutex (instead of a spinlock) for the locking of iomap
        manipulations in osl.c (same as
        https://patchwork.kernel.org/patch/491751/).

[4/8] - Avoid unnecessary walks of the list of iomaps in osl.c (same as
        https://patchwork.kernel.org/patch/491671/).

[5/8] - Avoid creating iomaps for regions that have been mapped already (same
         as https://patchwork.kernel.org/patch/491741/).

[6/8] - Replace krefs used for iomap refcounting with simple reference
        counters (they are manipulated under a lock anyway; same as
        https://patchwork.kernel.org/patch/491681/).

[7/8] - Introduce function for getting a reference to an ACPI iomap (to be
        used by the NVS save/restore code; same as
        https://patchwork.kernel.org/patch/491701/).

[8/8] - Make the NVS code use existing iomaps if possible (new version).

The patches have been tested on HP nx6325, Toshiba Portege R500 and Acer
Ferrari One without causing any visible problems to happen.
 
Thanks,
Rafael
