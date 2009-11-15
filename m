From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/10] PCI run-time PM support
Date: Mon, 16 Nov 2009 00:47:46 +0100
Message-ID: <200911160047.46299.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following series of patches provides run-time power management support
through ACPI and the native PCIe PME.

[1/10] - Add flag for marking devices capable of generating wake-up events at run time

[2/10] - Add function for checking PME status of devices

[3/10] - Modify wake-up enable propagation so that it's done for PCIe devices too

[4/10] - PCIe PME root port service driver

[5/10] - ACPI GPE refcounting from Matthew

[6/10] - ACPI drivers support for GPE refcounting from Matthew

[7/10] - ACPI removal of the old GPE API from Matthew

[8/10] - ACPI add fields for handling run-wake devices

[9/10] - PCI ACPI platform support for run-time power management

[10/10] - Runtime PM callbacks for the PCI bus type

Comments welcome.

Best,
Rafael
