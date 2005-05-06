From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] kernel/power/swsusp.c: make a variable static
Date: Fri, 6 May 2005 23:27:35 +0200
Message-ID: <20050506212734.GQ3590@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============83205151667387556=="
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
To: pavel@suse.cz
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============83205151667387556==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch makes a needlessly global variable static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc3-mm2-full/kernel/power/swsusp.c.old	2005-05-03 07:48:39.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/kernel/power/swsusp.c	2005-05-03 07:48:49.000000000 +0200
@@ -81,7 +81,7 @@
 extern char resume_file[];
 
 /* Local variables that should not be affected by save */
-unsigned int nr_copy_pages __nosavedata = 0;
+static unsigned int nr_copy_pages __nosavedata = 0;
 
 /* Suspend pagedir is allocated before final copy, therefore it
    must be freed after resume


--===============83205151667387556==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============83205151667387556==--
