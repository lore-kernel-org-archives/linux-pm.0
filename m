From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/4] Hibernate: Call platform_begin before
	swsusp_shrink_memory
Date: Sun, 26 Oct 2008 20:50:26 +0100
Message-ID: <200810262050.26875.rjw__30644.4373484284$1225050949$gmane$org@sisk.pl>
References: <200810262048.23468.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200810262048.23468.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>
Subject: Hibernate: Call platform_begin before swsusp_shrink_memory

Call platform_begin() before swsusp_shrink_memory() so that we can
always allocate enough memory to save the ACPI NVS region from
platform_begin().

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Nigel Cunningham <nigel@tuxonice.net>
Acked-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/disk.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index c9d7408..096fe48 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -259,12 +259,12 @@ int hibernation_snapshot(int platform_mode)
 {
 	int error, ftrace_save;
 
-	/* Free memory before shutting down devices. */
-	error = swsusp_shrink_memory();
+	error = platform_begin(platform_mode);
 	if (error)
 		return error;
 
-	error = platform_begin(platform_mode);
+	/* Free memory before shutting down devices. */
+	error = swsusp_shrink_memory();
 	if (error)
 		goto Close;
 
-- 
1.5.6
