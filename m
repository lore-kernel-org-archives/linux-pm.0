From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [PATCH] x86, irq: Fix regression caused by commit b568b8601f05
Date: Mon, 16 Feb 2015 10:11:13 +0800
Message-ID: <1424052673-22974-1-git-send-email-jiang.liu@linux.intel.com>
References: <1424039150-4115-1-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1424039150-4115-1-git-send-email-syrjala@sci.fi>
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <syrjala@sci.fi>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Sander Eikelenboom <linux@eikelenboom.it>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Commit b568b8601f05 ("Treat SCI interrupt as normal GSI interrupt")
accidently removes support of legacy PIC interrupt when fixing a
regression for Xen, which causes a nasty regression on HP/Compaq
nc6000 where we fail to register the ACPI interrupt, and thus
lose eg. thermal notifications leading a potentially overheated
machine.

So reintroduce support of legacy PIC based ACPI SCI interrupt.

Reported-by: Ville Syrj=C3=A4l=C3=A4 <syrjala@sci.fi>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
Hi Ville,
	Could you please help to try this patch instead of revert commit
b568b8601f05?
Thanks!
Gerry
---
 arch/x86/kernel/acpi/boot.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index ae97ed0873c6..3d525c6124f6 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -613,6 +613,11 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
 {
 	int rc, irq, trigger, polarity;
=20
+	if (acpi_irq_model =3D=3D ACPI_IRQ_MODEL_PIC) {
+		*irqp =3D gsi;
+		return 0;
+	}
+
 	rc =3D acpi_get_override_irq(gsi, &trigger, &polarity);
 	if (rc =3D=3D 0) {
 		trigger =3D trigger ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
