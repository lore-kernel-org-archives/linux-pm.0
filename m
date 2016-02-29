From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 0/6] PCI: Add support for suspending (including runtime) of PCIe ports
Date: Mon, 29 Feb 2016 14:56:00 +0200
Message-ID: <1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Qipeng Zha <qipeng.zha@intel.com>, Qi Zheng <qi.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

This series add support for moving PCIe ports to D3hot both runtime and
during system suspend.

When PCIe port is suspended connected devices are effectively moved to
D3cold because their config space is not accessible anymore (and the link
may be powered down as well). So we need to make sure the devices are
allowed to go to D3cold and, if they are wake capable, can do so from
D3cold. Only then we can suspend the port.

Patch [3/6] adds support for system suspend of PCIe ports. Since we do not
know how well this has been supported in older hardware, enable this only
for quite recent hardware (starting from 2015). This can still be
disallowed per port as needed by adding entries to pcie_port_configs[].

Patch [4/6] then extends this to allow runtime PM of PCIe ports whenever
all connected devices are runtime suspended. Patches [5,6/6] enable runtime
PM for recent Intel hardware including Sunrisepoint (Skylake) and Broxton.
These are meant to be alternative for patches by Qipeng Zha here:

  http://www.spinics.net/lists/linux-pci/msg48103.html
  http://www.spinics.net/lists/linux-pci/msg48104.html

The idea how this is supposed to be implemented came from Rafael Wysocki.

Mika Westerberg (6):
  PCI: No need to set d3cold_allowed to PCIe ports
  PCI: Make __pci_bus_set_current_state() available to other files
  PCI: Move PCIe ports to D3hot during suspend
  PCI: Add runtime PM support for PCIe ports
  PCI: Enable runtime PM for Intel Sunrisepoint PCIe root ports
  PCI: Enable runtime PM for Intel Broxton PCIe root ports

 drivers/pci/pci.c              |   2 +-
 drivers/pci/pci.h              |   1 +
 drivers/pci/pcie/portdrv_pci.c | 170 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 164 insertions(+), 9 deletions(-)

-- 
2.7.0
