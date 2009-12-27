From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/12] PCI run-time PM support (rev. 2)
Date: Sun, 27 Dec 2009 20:57:10 +0100
Message-ID: <200912272057.10443.rjw__45594.7063783698$1261944790$gmane$org@sisk.pl>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Francois Romieu <romieu@fr.zoreil.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following (updated) series of patches provides preliminary run-time power
management support for PCI devices through ACPI and/or the native PCIe PME.

Some patches have been modified since the previous iteration, one patch has
been merged and there's one more.

I've tested this patchset with the native PCIe PME mechanism using the r8169
driver on the MSI Wind U-100 (see the last patch for details) and with the ACPI
mechanism using the e1000e driver on the Toshiba Portege R500 (the patch still
requires some work to be shown in public ;-)).

[1/12] - Add function for checking PME status of devices
 
[2/12] - Modify wake-up enable propagation so that it's done for PCIe devices
         too (this one is in the Jesse's tree already, but it's reproduced here
         for completness)
 
[3/12] - PCIe PME root port service driver

[4/12] - "Don't use MSIs for PME signaling" switch for PCIe
 
[5/12] - ACPI GPE refcounting, from Matthew
 
[6/12] - ACPI drivers support for GPE refcounting, from Matthew
 
[7/12] - ACPI removal of the old GPE API, from Matthew
 
[8/12] - ACPI add fields for handling run-wake devices
 
[9/12][New] - ACPI add helper function for enabling/disabling wake-up power

[10/12] - PCI / ACPI platform support for run-time power management

[11/12] - Runtime PM callbacks for the PCI bus type

[12/12] - Runtime PM support for r8169 (experimental)

If there are no objections, I think the patches [1-11/12] are ready for the
upstream.

Thanks,
Rafael
