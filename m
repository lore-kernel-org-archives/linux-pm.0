From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/9] PCI run-time PM support (rev. 3)
Date: Sun, 10 Jan 2010 14:31:38 +0100
Message-ID: <201001101431.38630.rjw@sisk.pl>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi,

The following (updated) series of patches provides basic run-time power
management support for PCI devices through ACPI and/or the native PCIe
PME.

[1/9] - Add function for checking PME status of devices

[2/9] - PCIe PME root port service driver

[3/9] - "Don't use MSIs for PME signaling" switch for PCIe
 
[4/9] - ACPI GPE refcounting, from Matthew Garrett
 
[5/9] - ACPI drivers support for GPE refcounting, from Matthew Garrett
 
[6/9] - ACPI removal of the old GPE API, from Matthew Garrett
 
[7/9] - ACPI add fields for handling run-wake devices

[8/9] - PCI / ACPI platform support for run-time power management

[9/9] - Runtime PM callbacks for the PCI bus type

Bob, patches [4/9] - [6/9] from Matthew introduce GPE refconting which is
necessary for the PCI run-time power management.  If I remeber correctly, you
saw these patches some time ago, but we need your ack before they can go
upstream.  Please let us know if there's anything to fix in these patches.

Thanks,
Rafael
