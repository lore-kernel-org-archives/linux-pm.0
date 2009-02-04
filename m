From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/7] PCI PM: Fixes and refinements
Date: Wed, 4 Feb 2009 01:54:35 +0100
Message-ID: <200902040154.36018.rjw__28802.1558117636$1233710770$gmane$org@sisk.pl>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following series of patches contains some fixes and refinements of the
PCI PM framework.

[1/7] fixes the problem that some driverless devices don't like to be power
managed and break things if we attempt to do it.

[2/7] and [3/7] fix the problem with devices in PCI_UNKNOWN that are
mishandled by the new code.

[4/7] fixes regression related to PCIe port suspend-resume.

[5/7] fixes the bug that bridges (and PCIe ports) are disabled during suspend,
althouth they shouldn't be.

[6/7] makes pci_restore_standard_config() read the current power state of the
device from the device itself after attempting to change it.

[7/7] makes the PCI PM core handle devices more carefully (details in the
changelog).

Please disregard any previous versions of these patches I sent to you.

Thanks,
Rafael
