From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/10] ACPI / PCI / PCIe: Rework _OSC handling (v4)
Date: Sat, 21 Aug 2010 01:49:39 +0200
Message-ID: <201008210149.39576.rjw__23175.0808925883$1282348955$gmane$org@sisk.pl>
References: <201008060303.51224.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008060303.51224.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi,
 
This is the 4th iteration of the patchset based on
https://patchwork.kernel.org/patch/114917/ and the comments I received on that
patch and the previous three iterations of this patchset.
 
[1/10] - Introduce pci_aer_available() allowing the caller to check if the
         AER service driver should be enabled.
 
[2/10] - Introduce kernel command line switch pcie_ports=.
 
[3/10] - Reorder checks in acpi_pci_osc_control_set().

[4/10] - Make acpi_pci_query_osc() return control bits obtained from the BIOS.

[5/10] - Do not cache _OSC query results.

[6/10] - Negotiate _OSC control bits before requesting control from the BIOS.

[7/10] - Rework the PCIe port driver to request _OSC control for all serives at
          once (that also affects ASPM now, Matthew please check).

[8/10] - Disable PCIe port services (that might be enabled by the BIOS) during
          initialization.

[9/10] - Move the PCIe PME code to drivers/pci/pcie/.

[10/10] - Remove the PCIe port driver modules exit function.

Comments welcome.
 
Thanks,
Rafael
