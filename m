From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 13/12] mpic: set IPIs to be per-CPU
Date: Mon, 12 Feb 2007 16:20:18 +0100
Message-ID: <1171293618.10344.11.camel@johannes.berg>
References: <20070207124536.963531000@sipsolutions.net>
	<1170940611.4385.56.camel@johannes.berg>
	<1170969252.2620.335.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1170969252.2620.335.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

This patch changes the MPIC IPIs to be per-CPU to avoid getting a
warning ("Cannot set affinity for irq 251") when taking a CPU
offline via sysfs or during suspend.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
Yup, that's a lot better, thanks.

 arch/powerpc/sysdev/mpic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6-git.orig/arch/powerpc/sysdev/mpic.c	2007-02-12 15:12:36.07952=
4117 +0100
+++ linux-2.6-git/arch/powerpc/sysdev/mpic.c	2007-02-12 15:23:18.812465943 =
+0100
@@ -1388,7 +1388,7 @@ void mpic_request_ipis(void)
 			printk(KERN_ERR "Failed to map IPI %d\n", i);
 			break;
 		}
-		request_irq(vipi, mpic_ipi_action, IRQF_DISABLED,
+		request_irq(vipi, mpic_ipi_action, IRQF_DISABLED|IRQF_PERCPU,
 			    ipi_names[i], mpic);
 	}
 }
