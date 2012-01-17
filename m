From: Len Brown <lenb@kernel.org>
Subject: [PATCH 27/50] ACPI, APEI, Print resource errors in conventional format
Date: Tue, 17 Jan 2012 07:21:19 -0500
Message-ID: <46b91e379f7180b482b789fbe615946d91e3a07f.1326802230.git.len.brown@intel.com>
References: <1326802902-21583-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1326802902-21583-1-git-send-email-lenb@kernel.org>
In-reply-to: <553575f1ae048aa44682b46b3c51929a0b3ad337.1326802228.git.len.brown@intel.com>
References: <553575f1ae048aa44682b46b3c51929a0b3ad337.1326802228.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Huang Ying <ying.huang@intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use the normal %pR-like format for MMIO and I/O port ranges.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/apei/apei-base.c |    8 ++++----
 drivers/acpi/apei/einj.c      |   11 ++++++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 6154036..3492896 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -460,9 +460,9 @@ int apei_resources_request(struct apei_resources *resources,
 				       desc);
 		if (!r) {
 			pr_err(APEI_PFX
-		"Can not request iomem region <%016llx-%016llx> for GARs.\n",
+		"Can not request [mem %#010llx-%#010llx] for %s registers\n",
 			       (unsigned long long)res->start,
-			       (unsigned long long)res->end);
+			       (unsigned long long)res->end - 1, desc);
 			res_bak = res;
 			goto err_unmap_iomem;
 		}
@@ -472,9 +472,9 @@ int apei_resources_request(struct apei_resources *resources,
 		r = request_region(res->start, res->end - res->start, desc);
 		if (!r) {
 			pr_err(APEI_PFX
-		"Can not request ioport region <%016llx-%016llx> for GARs.\n",
+		"Can not request [io  %#06llx-%#06llx] for %s registers\n",
 			       (unsigned long long)res->start,
-			       (unsigned long long)res->end);
+			       (unsigned long long)res->end - 1, desc);
 			res_bak = res;
 			goto err_unmap_ioport;
 		}
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 589b96c..d253902 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -209,9 +209,10 @@ static int __einj_error_trigger(u64 trigger_paddr)
 			       "APEI EINJ Trigger Table");
 	if (!r) {
 		pr_err(EINJ_PFX
-	"Can not request iomem region <%016llx-%016llx> for Trigger table.\n",
+	"Can not request [mem %#010llx-%#010llx] for Trigger table\n",
 		       (unsigned long long)trigger_paddr,
-		       (unsigned long long)trigger_paddr+sizeof(*trigger_tab));
+		       (unsigned long long)trigger_paddr +
+			    sizeof(*trigger_tab) - 1);
 		goto out;
 	}
 	trigger_tab = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
@@ -232,9 +233,9 @@ static int __einj_error_trigger(u64 trigger_paddr)
 			       "APEI EINJ Trigger Table");
 	if (!r) {
 		pr_err(EINJ_PFX
-"Can not request iomem region <%016llx-%016llx> for Trigger Table Entry.\n",
-		       (unsigned long long)trigger_paddr+sizeof(*trigger_tab),
-		       (unsigned long long)trigger_paddr + table_size);
+"Can not request [mem %#010llx-%#010llx] for Trigger Table Entry\n",
+		       (unsigned long long)trigger_paddr + sizeof(*trigger_tab),
+		       (unsigned long long)trigger_paddr + table_size - 1);
 		goto out_rel_header;
 	}
 	iounmap(trigger_tab);
-- 
1.7.9.rc1
