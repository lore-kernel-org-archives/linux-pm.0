From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: replace strlen("string") with
	sizeof("string") -1
Date: Thu, 26 Jul 2012 21:39:38 -0400
Message-ID: <5011F15A.3060007@kernel.org>
References: <Pine.LNX.4.44L0.1206301023540.29029-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1206301023540.29029-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Vasilyev <pavel@pavlinux.ru>
List-Id: linux-pm@vger.kernel.org

...both give the number of chars in the string
without the '\0', as strncmp() wants,
but sizeof() is compile-time.

Reported-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Vasilyev <pavel@pavlinux.ru>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 240a244..7c3f98b 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -173,7 +173,7 @@ static int param_set_trace_state(const char *val,
struct kernel_param *kp)
 {
 	int result = 0;

-	if (!strncmp(val, "enable", strlen("enable"))) {
+	if (!strncmp(val, "enable", sizeof("enable") - 1)) {
 		result = acpi_debug_trace(trace_method_name, trace_debug_level,
 					  trace_debug_layer, 0);
 		if (result)
@@ -181,7 +181,7 @@ static int param_set_trace_state(const char *val,
struct kernel_param *kp)
 		goto exit;
 	}

-	if (!strncmp(val, "disable", strlen("disable"))) {
+	if (!strncmp(val, "disable", sizeof("disable") - 1)) {
 		int name = 0;
 		result = acpi_debug_trace((char *)&name, trace_debug_level,
 					  trace_debug_layer, 0);
-- 
1.7.12.rc0
