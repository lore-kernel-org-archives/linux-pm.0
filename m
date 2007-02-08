From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 10/12] powerpc: remove unneeded page_is_ram export
Date: Thu, 08 Feb 2007 14:27:44 +0100
Message-ID: <1170941264.4385.59.camel@johannes.berg>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124614.830282000@sipsolutions.net>
	<17866.42529.436809.257415@cargo.ozlabs.ibm.com>
	<1170940253.4385.44.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1170940253.4385.44.camel@johannes.berg>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

arch/powerpc/mm/mem.c exports page_is_ram which is not used anywhere
that could be modular.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6.orig/arch/powerpc/mm/mem.c	2007-02-08 14:07:05.446944128 +0100
+++ linux-2.6/arch/powerpc/mm/mem.c	2007-02-08 14:26:24.016944128 +0100
@@ -83,7 +83,6 @@ int page_is_ram(unsigned long pfn)
 	return 0;
 #endif
 }
-EXPORT_SYMBOL(page_is_ram);
 =

 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
