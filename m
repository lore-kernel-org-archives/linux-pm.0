From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 03/10] powerpc: fix comment in kernel/irq.c
Date: Mon, 05 Feb 2007 19:30:30 +0100
Message-ID: <20070205185836.099816000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline; filename=irq-comment.patch
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
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

kernel/irq.c contains a comment that speaks of -1 and -2 as interrupt
numbers. Replace by NO_IRQ and NO_IRQ_IGNORE.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@osdl.org>

--- mb-wireless.orig/arch/powerpc/kernel/irq.c	2007-02-05 14:24:06.69452686=
4 +0100
+++ mb-wireless/arch/powerpc/kernel/irq.c	2007-02-05 14:24:37.084526864 +01=
00
@@ -281,10 +281,10 @@ void do_IRQ(struct pt_regs *regs)
 =

 	/*
 	 * Every platform is required to implement ppc_md.get_irq.
-	 * This function will either return an irq number or -1 to
+	 * This function will either return an irq number or NO_IRQ to
 	 * indicate there are no more pending.
-	 * The value -2 is for buggy hardware and means that this IRQ
-	 * has already been handled. -- Tom
+	 * The value NO_IRQ_IGNORE is for buggy hardware and means that this
+	 * IRQ has already been handled. -- Tom
 	 */
 	irq =3D ppc_md.get_irq();
 =


--
