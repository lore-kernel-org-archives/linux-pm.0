From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v2 09/13] PCI/portdrv: Remove unnecessary include of
 <linux/pci-aspm.h>
Date: Fri, 09 Mar 2018 13:00:38 -0600
Message-ID: <152062203834.77693.14346655067368975701.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Keith Busch <keith.busch@intel.com>, Sinan Kaya <okaya@codeaurora.org>, Lukas Wunner <lukas@wunner.de>, Frederick Lawler <fred@fredlawl.com>
List-Id: linux-pm@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

portdrv_pci.c doesn't use anything from <linux/pci-aspm.h>.  Remove the
include of it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pcie/portdrv_pci.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 127321e17184..1997d9f2743e 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -17,7 +17,6 @@
 #include <linux/init.h>
 #include <linux/aer.h>
 #include <linux/dmi.h>
-#include <linux/pci-aspm.h>
 
 #include "../pci.h"
 #include "portdrv.h"
