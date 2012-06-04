From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/15] acpi_video: fix leaking PCI references
Date: Mon,  4 Jun 2012 01:39:59 -0400
Message-ID: <cfb46f433a4da97c31780e08a259fac2cb6bd61f.1338786831.git.len.brown@intel.com>
References: <1338788406-29981-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1338788406-29981-1-git-send-email-lenb@kernel.org>
In-Reply-To: <c5971456964290da7e98222892797b71ef793e62.1338786831.git.len.brown@intel.com>
References: <c5971456964290da7e98222892797b71ef793e62.1338786831.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Signed-off-by: Alan Cox <alan@linux.intel.com>
Acked-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 9577b6f..66e8f73 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1745,6 +1745,7 @@ static int acpi_video_bus_remove(struct acpi_device *device, int type)
 
 static int __init intel_opregion_present(void)
 {
+	int i915 = 0;
 #if defined(CONFIG_DRM_I915) || defined(CONFIG_DRM_I915_MODULE)
 	struct pci_dev *dev = NULL;
 	u32 address;
@@ -1757,10 +1758,10 @@ static int __init intel_opregion_present(void)
 		pci_read_config_dword(dev, 0xfc, &address);
 		if (!address)
 			continue;
-		return 1;
+		i915 = 1;
 	}
 #endif
-	return 0;
+	return i915;
 }
 
 int acpi_video_register(void)
-- 
1.7.11.rc0.100.g5498c5f
