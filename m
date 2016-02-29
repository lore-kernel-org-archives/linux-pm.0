From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/6] PCI: Make __pci_bus_set_current_state() available to other files
Date: Mon, 29 Feb 2016 14:56:02 +0200
Message-ID: <1456750566-116248-3-git-send-email-mika.westerberg@linux.intel.com>
References: <1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Qipeng Zha <qipeng.zha@intel.com>, Qi Zheng <qi.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

We are going to take advantage of this function in PCIe root port driver so
make it available for other files inside drivers/pci/* directories.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci.c | 2 +-
 drivers/pci/pci.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 602eb4223510..e450b20ed4f3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -811,7 +811,7 @@ static int __pci_dev_set_current_state(struct pci_dev *dev, void *data)
  * @bus: Top bus of the subtree to walk.
  * @state: state to be set
  */
-static void __pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state)
+void __pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state)
 {
 	if (bus)
 		pci_walk_bus(bus, __pci_dev_set_current_state, &state);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9a1660f592ef..e021da7ad0ff 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -238,6 +238,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 				struct list_head *realloc_head,
 				struct list_head *fail_head);
 bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
+void __pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state);
 
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
-- 
2.7.0
