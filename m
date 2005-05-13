From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] kernel/power/swsusp.c: make a variable static
Date: Fri, 13 May 2005 02:47:04 +0200
Message-ID: <20050513004704.GO3603@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============86373976068726188=="
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============86373976068726188==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch makes a needlessly global variable static.

This patch was already ACK'ed by Pavel Machek.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 May 2005

--- linux-2.6.12-rc3-mm2-full/kernel/power/swsusp.c.old	2005-05-03 07:48:39.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/kernel/power/swsusp.c	2005-05-03 07:48:49.000000000 +0200
@@ -81,7 +81,7 @@
 extern char resume_file[];
 
 /* Local variables that should not be affected by save */
-unsigned int nr_copy_pages __nosavedata = 0;
+static unsigned int nr_copy_pages __nosavedata = 0;
 
 /* Suspend pagedir is allocated before final copy, therefore it
    must be freed after resume


--===============86373976068726188==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============86373976068726188==--
