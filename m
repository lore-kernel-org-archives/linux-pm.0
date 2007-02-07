From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 10/12] powerpc: remove unneeded exports in mem.c
Date: Wed, 07 Feb 2007 13:45:46 +0100
Message-ID: <20070207124614.830282000@sipsolutions.net>
References: <20070207124536.963531000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline; filename=remove-unneeded-exports.patch
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

arch/powerpc/mm/mem.c exports page_is_ram and phys_mem_access_prot which
both are not used anywhere that could be modular.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Paul Mackerras <paulus@samba.org>

---
I don't see any possible way these could be used by external modules either,
especially since they are not portable across arches.

--- linux-2.6-git.orig/arch/powerpc/mm/mem.c	2007-02-07 02:55:34.636884289 =
+0100
+++ linux-2.6-git/arch/powerpc/mm/mem.c	2007-02-07 02:55:35.252884289 +0100
@@ -83,7 +83,6 @@ int page_is_ram(unsigned long pfn)
 	return 0;
 #endif
 }
-EXPORT_SYMBOL(page_is_ram);
 =

 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
@@ -96,7 +95,6 @@ pgprot_t phys_mem_access_prot(struct fil
 				    | _PAGE_GUARDED | _PAGE_NO_CACHE);
 	return vma_prot;
 }
-EXPORT_SYMBOL(phys_mem_access_prot);
 =

 #ifdef CONFIG_MEMORY_HOTPLUG
 =


--
