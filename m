From: Len Brown <lenb@kernel.org>
Subject: [PATCH 72/76] ACPI: Fix logic for removing mappings in
	'acpi_unmap'
Date: Fri, 30 Mar 2012 06:14:15 -0400
Message-ID: <8cdde126aa60ced0d63ff137378e09dd01dfadda.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, Myron Stowe <myron.stowe@redhat.com>, linux-kernel@vger.kernel.org, Myron Stowe <mstowe@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Myron Stowe <mstowe@redhat.com>

Make sure the removal of mappings uses the same logic that put the
mappings in place.

Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
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
