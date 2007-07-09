From: Oliver Neukum <oliver@neukum.org>
Subject: [mm-patch]Documentation:reference notifiers.txt in
	freezing-of-tasks.txt
Date: Mon, 9 Jul 2007 10:26:19 +0200
Message-ID: <200707091026.20463.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@osdl.org>, rjw@sisk.pl
List-Id: linux-pm@vger.kernel.org

Hi,

freezing-of-tasks.txt mentions firmware issues without mentioning the use
of the new notifier API to overcome them. Here's an update.

	Regards
		Oliver
Signed-off-by: Oliver Neukum <oneukum@suse.de>
----

--- a/Documentation/power/freezing-of-tasks.txt	2007-07-09 10:06:51.000000000 +0200
+++ b/Documentation/power/freezing-of-tasks.txt	2007-07-09 10:24:05.000000000 +0200
@@ -155,6 +155,8 @@ Suppose, however, that the firmware file
 only through another device that hasn't been resumed yet.  In that case,
 request_firmware() will fail regardless of whether or not the freezing of tasks
 is used.  Consequently, the problem is not really related to the freezing of
-tasks, since it generally exists anyway.  [The solution to this particular
-problem is to keep the firmware in memory after it's loaded for the first time
-and upload if from memory to the device whenever necessary.]
+tasks, since it generally exists anyway.
+
+A driver must have all firmwares it may need in RAM before suspend() is called.
+If keeping them is not practical, for example due to their size, they must be
+requested early enough using the suspend notifier API described in notifiers.txt.
