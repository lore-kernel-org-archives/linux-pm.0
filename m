From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] Don't "lose" devices on suspend on failure
Date: Tue, 31 May 2005 17:08:49 +1000
Message-ID: <1117523329.5826.14.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============23937756601658222=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============23937756601658222==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi !

I think we need this patch or we might "lose" devices to the dpm_irq_off
list if a failure occurs during the suspend process.

Patrick, Greg, your opinion ?

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/base/power/suspend.c
===================================================================
--- linux-work.orig/drivers/base/power/suspend.c	2005-05-31 16:29:22.000000000 +1000
+++ linux-work/drivers/base/power/suspend.c	2005-05-31 16:57:29.000000000 +1000
@@ -113,8 +113,19 @@
 		put_device(dev);
 	}
 	up(&dpm_list_sem);
-	if (error)
+	if (error) {
+		/* we failed... before resuming, bring back devices from
+		 * dpm_off_irq list back to main dpm_off list, we do want
+		 * to call resume() on them, in case they partially suspended
+		 * despite returning -EAGAIN
+		 */
+		while (!list_empty(&dpm_off_irq)) {
+			struct list_head * entry = dpm_off_irq.next;
+			list_del(entry);
+			list_add(entry, &dpm_off);
+		}
 		dpm_resume();
+	}
 	up(&dpm_sem);
 	return error;
 }



--===============23937756601658222==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============23937756601658222==--
