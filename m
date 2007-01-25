From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: [PATCH] Fix swsusp-change-code-order-in-diskc.patch
Date: Thu, 25 Jan 2007 15:36:38 +0300
Message-ID: <45B8A456.2010301@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040002050003080509090101"
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>, "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------040002050003080509090101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Recent patch from Rafael changed the order of platform_prepare() and
swsusp_read(). platform_prepare() should happen before swsusp_read()
in order to get nice LED blinking during load of the image and time for
GPE activity to settle down.

Attaching the patch to fix order.
Regards,
    Alex.

--------------040002050003080509090101
Content-Type: text/plain; name="fix-swsusp-change-code-ordering-in-diskc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="fix-swsusp-change-code-ordering-in-diskc.patch"

Recent patch from Rafael changed the order of platform_prepare() and 
swsusp_read(). platform_prepare() should happen before swsusp_read()
in order to get nice LED blinking during load of the image and time for
GPE activity to settle down.

From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>

LED blinking and time for GPE activity to stop.
---

 kernel/power/disk.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index 33e67b4..406b20a 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -240,21 +240,22 @@ static int software_resume(void)
 		goto Done;
 	}
 
-	pr_debug("PM: Reading swsusp image.\n");
-
-	error = swsusp_read();
+	error = platform_prepare();
 	if (error) {
 		swsusp_free();
 		goto Thaw;
 	}
 
-	pr_debug("PM: Preparing devices for restore.\n");
+	pr_debug("PM: Reading swsusp image.\n");
 
-	error = platform_prepare();
+	error = swsusp_read();
 	if (error) {
 		swsusp_free();
 		goto Thaw;
 	}
+
+	pr_debug("PM: Preparing devices for restore.\n");
+
 	suspend_console();
 	error = device_suspend(PMSG_PRETHAW);
 	if (error)

--------------040002050003080509090101
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--------------040002050003080509090101--
