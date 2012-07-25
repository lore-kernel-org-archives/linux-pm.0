From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/52] ACPICA: Object dump routines: Use common
	function for string output
Date: Tue, 24 Jul 2012 23:40:58 -0400
Message-ID: <579e3820bd1381d36b2c41485e9e7a94216bb7ed.1343187617.git.len.brown@intel.com>
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

For ACPI string objects, always use the common string dump
function, acpi_ut_print_string. This function surrounds the string
with quotes and handles allowed escape sequences.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exdump.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 2a6ac0a..836fe76 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -926,9 +926,7 @@ acpi_ex_dump_package_obj(union acpi_operand_object *obj_desc,
 	case ACPI_TYPE_STRING:
 
 		acpi_os_printf("[String] Value: ");
-		for (i = 0; i < obj_desc->string.length; i++) {
-			acpi_os_printf("%c", obj_desc->string.pointer[i]);
-		}
+		acpi_ut_print_string(obj_desc->string.pointer, ACPI_UINT8_MAX);
 		acpi_os_printf("\n");
 		break;
 
-- 
1.7.12.rc0
