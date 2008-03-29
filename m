From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/3] PM: Rework suspend and hibernation code
	for devices (rev. 3)
Date: Sat, 29 Mar 2008 23:17:49 +0100
Message-ID: <200803292317.50218.rjw__26237.2999954552$1206829786$gmane$org@sisk.pl>
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

The first one is the 5th revision of the patch introducing new callbacks for
suspend and hibernation.

The other two patches implement the new suspend and hibernation callbacks
for the platform and PCI bus types (3rd revision of both).

The main differences between these patches and the previous revision:
* Dropped 'struct pm_noirq_ops' and introduced 'struct pm_ext_ops' that is a
  derivative of 'struct pm_ops' (adds the _noirq operations).
* Made device_pm_add() refuse to add devices for which
  dev->parent->power.status == DPM_INVALID
* Clarified (hopefully) the new platform and pci driver code

Please review.

Thanks,
Rafael
