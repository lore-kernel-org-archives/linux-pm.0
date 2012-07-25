From: Len Brown <lenb@kernel.org>
Subject: [PATCH 33/52] ACPICA: Update comments;
	no functional change
Date: Tue, 24 Jul 2012 23:41:29 -0400
Message-ID: <e40d5940396aa4002feeab8323224b5c7f84246c.1343187617.git.len.brown@intel.com>
References: <1343187708-19532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1343187708-19532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
References: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
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

Cleanup a couple of comments.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acpredef.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index bbb34c9..c8e5756 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -511,14 +511,14 @@ static const union acpi_predefined_info predefined_names[] =
 	{{"_TMP", 0, ACPI_RTYPE_INTEGER}},
 	{{"_TPC", 0, ACPI_RTYPE_INTEGER}},
 	{{"_TPT", 1, 0}},
-	{{"_TRT", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each 2_ref/6_int */
+	{{"_TRT", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each 2 Ref/6 Int */
 			  {{{ACPI_PTYPE2, ACPI_RTYPE_REFERENCE, 2, ACPI_RTYPE_INTEGER}, 6, 0}},
 
-	{{"_TSD", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each 5_int with count */
+	{{"_TSD", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each 5 Int with count */
 			  {{{ACPI_PTYPE2_COUNT,ACPI_RTYPE_INTEGER, 5,0}, 0,0}},
 
 	{{"_TSP", 0, ACPI_RTYPE_INTEGER}},
-	{{"_TSS", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each 5_int */
+	{{"_TSS", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each 5 Int */
 			  {{{ACPI_PTYPE2, ACPI_RTYPE_INTEGER, 5,0}, 0,0}},
 
 	{{"_TST", 0, ACPI_RTYPE_INTEGER}},
-- 
1.7.12.rc0
