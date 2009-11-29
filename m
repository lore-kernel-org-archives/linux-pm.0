From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/12] PCI run-time PM support (updated)
Date: Sun, 29 Nov 2009 16:32:44 +0100
Message-ID: <200911291632.44763.rjw__29297.0915245407$1259509644$gmane$org@sisk.pl>
References: <200911160047.46299.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911160047.46299.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Francois Romieu <romieu@fr.zoreil.com>
List-Id: linux-pm@vger.kernel.org

Hi,
 
The following (updated) series of patches provides preliminary run-time power
management support for PCI devices through ACPI and/or the native PCIe PME.

Some patches have been modified since the previous iteration and two new
patches have been added.  Also, I've tested this patchset with the native PCIe
PME mechanism using the r8169 driver on the MSI Wind U-100 (see the last patch
for details).

[1/12] - Add flag for marking devices capable of generating wake-up events at run time
 
[2/12] - Add function for checking PME status of devices
 
[3/12] - Modify wake-up enable propagation so that it's done for PCIe devices too
 
[4/12] - PCIe PME root port service driver

[5/12][New] - "Don't use MSIs for PME signaling" switch for PCIe
 
[6/12] - ACPI GPE refcounting, from Matthew
 
[7/12] - ACPI drivers support for GPE refcounting, from Matthew
 
[8/12] - ACPI removal of the old GPE API, from Matthew
 
[9/12] - ACPI add fields for handling run-wake devices
 
[10/12] - PCI ACPI platform support for run-time power management

[11/12] - Runtime PM callbacks for the PCI bus type

[12/12] - Runtime PM support for r8169 (experimental)

If there are no objections, I think the patches [1-11/12] are ready for merging
at this point.

Thanks,
Rafael
