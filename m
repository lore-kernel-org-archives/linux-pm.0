From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 13/12] mpic: add affinity callback for IPI "chip"
Date: Thu, 08 Feb 2007 14:16:51 +0100
Message-ID: <1170940611.4385.56.camel@johannes.berg>
References: <20070207124536.963531000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070207124536.963531000@sipsolutions.net>
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

This patch adds a dummy affinity callback for the IPI "chip" to avoid
getting a warning ("Cannot set affinity for irq 251") when taking a
CPU offline via sysfs or during suspend.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-git.orig/arch/powerpc/sysdev/mpic.c	2007-02-08 00:19:46.10592=
6568 +0100
+++ linux-2.6-git/arch/powerpc/sysdev/mpic.c	2007-02-08 00:22:31.810926568 =
+0100
@@ -700,6 +700,12 @@ static void mpic_end_ipi(unsigned int ir
 	mpic_eoi(mpic);
 }
 =

+static void mpic_set_ipi_affinity(unsigned int irq, cpumask_t cpumask)
+{
+	/* we can't set affinity but also don't need to since we only
+	 * send IPIs to online CPUs */
+}
+
 #endif /* CONFIG_SMP */
 =

 static void mpic_set_affinity(unsigned int irq, cpumask_t cpumask)
@@ -788,6 +794,7 @@ static struct irq_chip mpic_ipi_chip =3D {
 	.mask		=3D mpic_mask_ipi,
 	.unmask		=3D mpic_unmask_ipi,
 	.eoi		=3D mpic_end_ipi,
+	.set_affinity	=3D mpic_set_ipi_affinity,
 };
 #endif /* CONFIG_SMP */
 =
