From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 0/4] PCI/PM: D3cold support for system suspend
Date: Tue, 29 Jan 2013 12:34:14 +0800
Message-ID: <1359434058-15918-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Huang Ying <ying.huang@intel.com>
List-Id: linux-pm@vger.kernel.org

[PATCH 1/4] PCI/ACPI: Add target state as parameter to pci_platform_pm_ops->run_wake
[PATCH 2/4] PCI: Rename pci_dev->runtime_d3cold to pci_dev->set_d3cold
[PATCH 3/4] PCI/PM: Set pci_dev->set_d3cold in pci_set_power_state
[PATCH 4/4] PCI/PM: Enable D3cold support for system suspend

Huang Ying
Best Regards,
