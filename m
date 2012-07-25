From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/52] ACPICA: AML Parser: Fix two possible
	memory leaks in error path
Date: Tue, 24 Jul 2012 23:40:57 -0400
Message-ID: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
References: <1343187708-19532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1343187708-19532-1-git-send-email-lenb@kernel.org>
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
Cc: Len Brown <len.brown@intel.com>, Jesper Juhl <jj@chaosbits.net>, linux-kernel@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Jesper Juhl <jj@chaosbits.net>

Fixes a couple of memory leaks in the error recovery path.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/psargs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 5ac36ab..a683d66 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -618,6 +618,7 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 
 				arg = acpi_ps_alloc_op(AML_INT_BYTELIST_OP);
 				if (!arg) {
+					acpi_ps_free_op(field);
 					return_PTR(NULL);
 				}
 
@@ -662,6 +663,7 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 		} else {
 			arg = acpi_ps_alloc_op(AML_INT_NAMEPATH_OP);
 			if (!arg) {
+				acpi_ps_free_op(field);
 				return_PTR(NULL);
 			}
 
-- 
1.7.12.rc0
