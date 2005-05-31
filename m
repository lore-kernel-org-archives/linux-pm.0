From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] Don't explode on swsusp failure to find swap
Date: Tue, 31 May 2005 17:13:05 +1000
Message-ID: <1117523585.5826.18.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============78163512628139253=="
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
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============78163512628139253==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi !

If we specify a swap device for swsusp using resume= kernel argument and
that device doesn't exist in the swap list, we end up calling
swsusp_free() before we have allocated pagedir_save. That causes us to
explode when trying to free it.

Pavel, does that look right ?

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/kernel/power/swsusp.c
===================================================================
--- linux-work.orig/kernel/power/swsusp.c	2005-05-31 16:29:22.000000000 +1000
+++ linux-work/kernel/power/swsusp.c	2005-05-31 16:57:30.000000000 +1000
@@ -730,10 +730,13 @@
 
 void swsusp_free(void)
 {
+	if (pagedir_save == NULL)
+		return;
 	BUG_ON(PageNosave(virt_to_page(pagedir_save)));
 	BUG_ON(PageNosaveFree(virt_to_page(pagedir_save)));
 	free_image_pages();
 	free_pagedir(pagedir_save);
+	pagedir_save = NULL;
 }
 
 



--===============78163512628139253==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============78163512628139253==--
