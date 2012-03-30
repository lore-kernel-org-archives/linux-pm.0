From: Len Brown <lenb@kernel.org>
Subject: [PATCH 55/76] ACPI / PM: print physical addresses consistently with
 other parts of kernel
Date: Fri, 30 Mar 2012 06:13:58 -0400
Message-ID: <c6436f5a395d346e9f4892d7aeed4c3f99261f0f.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Print physical address info in a style consistent with the %pR style used
elsewhere in the kernel.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/nvs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nvs.c b/drivers/acpi/nvs.c
index 7a2035f..266bc58 100644
--- a/drivers/acpi/nvs.c
+++ b/drivers/acpi/nvs.c
@@ -95,8 +95,8 @@ static int suspend_nvs_register(unsigned long start, unsigned long size)
 {
 	struct nvs_page *entry, *next;
 
-	pr_info("PM: Registering ACPI NVS region at %lx (%ld bytes)\n",
-		start, size);
+	pr_info("PM: Registering ACPI NVS region [mem %#010lx-%#010lx] (%ld bytes)\n",
+		start, start + size - 1, size);
 
 	while (size > 0) {
 		unsigned int nr_bytes;
-- 
1.7.10.rc2.19.gfae9d

