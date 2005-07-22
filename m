From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: [PATCH] Address BUG: using smp_processor_id() in
	preemptible [00000001] code
Date: Fri, 22 Jul 2005 13:59:01 +1000
Message-ID: <1122004741.3033.49.camel@localhost>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============99383816617657939=="
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
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============99383816617657939==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes a warning in the disable_nonboot_cpus call in
kernel/power/smp.c.

Please apply.

Signed-off by: Nigel Cunningham <nigel@suspend2.net>

 smp.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
diff -ruNp 830-smp_processor_id_warning.patch-old/kernel/power/smp.c 830-smp_processor_id_warning.patch-new/kernel/power/smp.c
--- 830-smp_processor_id_warning.patch-old/kernel/power/smp.c	2005-07-18 06:37:08.000000000 +1000
+++ 830-smp_processor_id_warning.patch-new/kernel/power/smp.c	2005-07-22 11:09:16.000000000 +1000
@@ -38,7 +38,7 @@ void disable_nonboot_cpus(void)
 		}
 		printk("Error taking cpu %d down: %d\n", cpu, error);
 	}
-	BUG_ON(smp_processor_id() != 0);
+	BUG_ON(raw_smp_processor_id() != 0);
 	if (error)
 		panic("cpus not sleeping");
 }

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.


--===============99383816617657939==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============99383816617657939==--
