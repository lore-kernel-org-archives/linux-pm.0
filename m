From: Len Brown <lenb@kernel.org>
Subject: [PATCH 36/76] ACPICA: Debugger: Add missing object info
 to namespace dump
Date: Fri, 30 Mar 2012 06:13:39 -0400
Message-ID: <4acb6884b5568f19bd47173cba8bc1f2289d6baa.1333101989.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Many namespace node types must have an attached object. For
these node types, print a message about a missing object during
a namespace dump.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nsdump.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index b7f2b3b..3f7f3f6 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -242,7 +242,20 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 
 		if (!obj_desc) {
 
-			/* No attached object, we are done */
+			/* No attached object. Some types should always have an object */
+
+			switch (type) {
+			case ACPI_TYPE_INTEGER:
+			case ACPI_TYPE_PACKAGE:
+			case ACPI_TYPE_BUFFER:
+			case ACPI_TYPE_STRING:
+			case ACPI_TYPE_METHOD:
+				acpi_os_printf("<No attached object>");
+				break;
+
+			default:
+				break;
+			}
 
 			acpi_os_printf("\n");
 			return (AE_OK);
-- 
1.7.10.rc2.19.gfae9d
