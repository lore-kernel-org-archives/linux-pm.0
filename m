From: Len Brown <lenb@kernel.org>
Subject: [PATCH 68/76] ACPI: consistently use should_use_kmap()
Date: Fri, 30 Mar 2012 06:14:11 -0400
Message-ID: <e252675fb722d4a307cc380a06a905f03cf9951c.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@suse.com>, Jan Beulich <jbeulich@suse.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Jan Beulich <JBeulich@suse.com>

... so that acpi_unmap()'s behavior gets in sync with acpi_map()'s.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 412a1e0..5aef087 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -347,7 +347,7 @@ static void acpi_unmap(acpi_physical_address pg_off, void __iomem *vaddr)
 	unsigned long pfn;
 
 	pfn = pg_off >> PAGE_SHIFT;
-	if (page_is_ram(pfn))
+	if (should_use_kmap(pfn))
 		kunmap(pfn_to_page(pfn));
 	else
 		iounmap(vaddr);
-- 
1.7.10.rc2.19.gfae9d

