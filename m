From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 09/12] powerpc: remove bogus comment about
	page_is_ram
Date: Wed, 07 Feb 2007 13:45:45 +0100
Message-ID: <20070207124614.109461000@sipsolutions.net>
References: <20070207124536.963531000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline; filename=remove-bogus-page_is_ram-comment.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linuxppc-dev@ozlabs.org
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

arch/powerpc/mm/mem.c states that page_is_ram is called by the code that
implements /dev/mem which isn't true. Remove the comment.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Paul Mackerras <paulus@samba.org>

---
Please apply to the powerpc tree.

--- linux-2.6-git.orig/arch/powerpc/mm/mem.c	2007-02-07 02:55:30.496884289 =
+0100
+++ linux-2.6-git/arch/powerpc/mm/mem.c	2007-02-07 02:55:34.636884289 +0100
@@ -61,10 +61,6 @@ unsigned long memory_limit;
 extern void hash_preload(struct mm_struct *mm, unsigned long ea,
 			 unsigned long access, unsigned long trap);
 =

-/*
- * This is called by /dev/mem to know if a given address has to
- * be mapped non-cacheable or not
- */
 int page_is_ram(unsigned long pfn)
 {
 	unsigned long paddr =3D (pfn << PAGE_SHIFT);

--
