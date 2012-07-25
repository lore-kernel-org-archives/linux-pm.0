From: Len Brown <lenb@kernel.org>
Subject: [PATCH 38/52] ACPICA: Add new interfaces for
	BIOS(firmware) errors and warnings
Date: Tue, 24 Jul 2012 23:41:34 -0400
Message-ID: <62cdd14191cdc6749fbc5e489cf80f5149c9ca15.1343187617.git.len.brown@intel.com>
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

These new interfaces will be deployed across ACPICA in order to
point a finger directly at any detected BIOS issues -- such as
issues with ACPI tables, etc.

https://www.acpica.org/bugzilla/show_bug.cgi?id=843

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/utxferror.c | 68 +++++++++++++++++++++++++++++++++++++++++
 include/acpi/acoutput.h         |  4 +++
 include/acpi/acpixf.h           |  8 +++++
 3 files changed, 80 insertions(+)

diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index 52b568a..87aaddf 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -82,6 +82,8 @@ extern FILE *acpi_gbl_output_file;
 #define ACPI_MSG_EXCEPTION      "ACPI Exception: "
 #define ACPI_MSG_WARNING        "ACPI Warning: "
 #define ACPI_MSG_INFO           "ACPI: "
+#define ACPI_MSG_BIOS_ERROR     "ACPI BIOS Bug: Error: "
+#define ACPI_MSG_BIOS_WARNING   "ACPI BIOS Bug: Warning: "
 /*
  * Common message suffix
  */
@@ -218,6 +220,72 @@ acpi_info(const char *module_name, u32 line_number, const char *format, ...)
 
 ACPI_EXPORT_SYMBOL(acpi_info)
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_bios_error
+ *
+ * PARAMETERS:  module_name         - Caller's module name (for error output)
+ *              line_number         - Caller's line number (for error output)
+ *              format              - Printf format string + additional args
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print "ACPI Firmware Error" message with module/line/version
+ *              info
+ *
+ ******************************************************************************/
+void ACPI_INTERNAL_VAR_XFACE
+acpi_bios_error(const char *module_name,
+		u32 line_number, const char *format, ...)
+{
+	va_list arg_list;
+
+	ACPI_MSG_REDIRECT_BEGIN;
+	acpi_os_printf(ACPI_MSG_BIOS_ERROR);
+
+	va_start(arg_list, format);
+	acpi_os_vprintf(format, arg_list);
+	ACPI_MSG_SUFFIX;
+	va_end(arg_list);
+
+	ACPI_MSG_REDIRECT_END;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_bios_error)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_bios_warning
+ *
+ * PARAMETERS:  module_name         - Caller's module name (for error output)
+ *              line_number         - Caller's line number (for error output)
+ *              format              - Printf format string + additional args
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print "ACPI Firmware Warning" message with module/line/version
+ *              info
+ *
+ ******************************************************************************/
+void ACPI_INTERNAL_VAR_XFACE
+acpi_bios_warning(const char *module_name,
+		  u32 line_number, const char *format, ...)
+{
+	va_list arg_list;
+
+	ACPI_MSG_REDIRECT_BEGIN;
+	acpi_os_printf(ACPI_MSG_BIOS_WARNING);
+
+	va_start(arg_list, format);
+	acpi_os_vprintf(format, arg_list);
+	ACPI_MSG_SUFFIX;
+	va_end(arg_list);
+
+	ACPI_MSG_REDIRECT_END;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_bios_warning)
+
 /*
  * The remainder of this module contains internal error functions that may
  * be configured out.
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index d7bd661..f1cb332 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -213,6 +213,8 @@
 #define ACPI_WARNING(plist)             acpi_warning plist
 #define ACPI_EXCEPTION(plist)           acpi_exception plist
 #define ACPI_ERROR(plist)               acpi_error plist
+#define ACPI_BIOS_WARNING(plist)        acpi_bios_warning plist
+#define ACPI_BIOS_ERROR(plist)          acpi_bios_error plist
 #define ACPI_DEBUG_OBJECT(obj,l,i)      acpi_ex_do_debug_object(obj,l,i)
 
 #else
@@ -223,6 +225,8 @@
 #define ACPI_WARNING(plist)
 #define ACPI_EXCEPTION(plist)
 #define ACPI_ERROR(plist)
+#define ACPI_BIOS_WARNING(plist)
+#define ACPI_BIOS_ERROR(plist)
 #define ACPI_DEBUG_OBJECT(obj,l,i)
 
 #endif				/* ACPI_NO_ERROR_MESSAGES */
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 18f023a..8f83f95 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -529,6 +529,14 @@ void ACPI_INTERNAL_VAR_XFACE
 acpi_info(const char *module_name,
 	  u32 line_number, const char *format, ...) ACPI_PRINTF_LIKE(3);
 
+void ACPI_INTERNAL_VAR_XFACE
+acpi_bios_error(const char *module_name,
+		u32 line_number, const char *format, ...) ACPI_PRINTF_LIKE(3);
+
+void ACPI_INTERNAL_VAR_XFACE
+acpi_bios_warning(const char *module_name,
+		  u32 line_number, const char *format, ...) ACPI_PRINTF_LIKE(3);
+
 /*
  * Debug output
  */
-- 
1.7.12.rc0
