From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/3] PM: Rework suspend and hibernation code
	for devices
Date: Mon, 17 Mar 2008 00:20:54 +0100
Message-ID: <200803170020.55473.rjw__10504.5988959775$1205710115$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi,

The following three patches are intended to start the redesign of the suspend
and hibernation framework for devices.

The first patch defines the new framework.  Specifically, it introduces the
structure 'struct pm_ops' containing a set of hibernation and suspend
callbacks to be defined by bus types, device types, device classes and,
finally, by device drivers (the role of each callback is described in the
comment in pm.h; the documentation will be updated later).  It also modifies
the code in drivers/base/power/main.c to use the new framework, if available,
and fall back to the old one otherwise (no visible functional changes should be
added).

The other two patches implement the new suspend and hibernation callbacks
for the platform and PCI bus types.

Please review and tell me what you think.

Thanks,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
