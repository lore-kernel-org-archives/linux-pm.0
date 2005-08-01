From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH]Trival patch for swsusp
Date: Mon, 01 Aug 2005 12:48:54 +0800
Message-ID: <1122871734.8216.4.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============30312897525416149=="
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
To: linux-pm <linux-pm@lists.osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============30312897525416149==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

A trival patch for swsusp.


Signed-off-by: Shaohua Li<shaohua.li@intel.com>
---

 linux-2.6.13-rc4-root/kernel/power/disk.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

diff -puN kernel/power/disk.c~swsusp-trival kernel/power/disk.c
--- linux-2.6.13-rc4/kernel/power/disk.c~swsusp-trival	2005-08-01 11:02:47.706757448 +0800
+++ linux-2.6.13-rc4-root/kernel/power/disk.c	2005-08-01 11:11:13.363885880 +0800
@@ -233,9 +233,12 @@ static int software_resume(void)
 {
 	int error;
 
+	down(&pm_sem);
 	if (!swsusp_resume_device) {
-		if (!strlen(resume_file))
+		if (!strlen(resume_file)) {
+			up(&pm_sem);
 			return -ENOENT;
+		}
 		swsusp_resume_device = name_to_dev_t(resume_file);
 		pr_debug("swsusp: Resume From Partition %s\n", resume_file);
 	} else {
@@ -248,6 +251,7 @@ static int software_resume(void)
 		 * FIXME: If noresume is specified, we need to find the partition
 		 * and reset it back to normal swap space.
 		 */
+		up(&pm_sem);
 		return 0;
 	}
 
@@ -284,6 +288,8 @@ static int software_resume(void)
  Cleanup:
 	unprepare_processes();
  Done:
+	/* For success case, the suspend path will release the lock */
+	up(&pm_sem);
 	pr_debug("PM: Resume from disk failed.\n");
 	return 0;
 }
@@ -390,7 +396,9 @@ static ssize_t resume_store(struct subsy
 	if (sscanf(buf, "%u:%u", &maj, &min) == 2) {
 		res = MKDEV(maj,min);
 		if (maj == MAJOR(res) && min == MINOR(res)) {
+			down(&pm_sem);
 			swsusp_resume_device = res;
+			up(&pm_sem);
 			printk("Attempting manual resume\n");
 			noresume = 0;
 			software_resume();
_



--===============30312897525416149==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============30312897525416149==--
