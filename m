From: Todd Poynor <tpoynor@mvista.com>
Subject: XScale PXA27x wakeup info
Date: Tue, 20 Dec 2005 17:27:31 -0800
Message-ID: <20051221012731.GA18246@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============34813027152254072=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============34813027152254072==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's an embedded implementation of the proposed /sys/power/waker
attribute.  In this case, several potential wakeup sources as defined by
the SoC are checked and strings identifying these are added to
/sys/power/waker.  Most are numbered GPIO lines.

A nicer way of implementing this would be to have real drivers for each
actually-used wakeup source ("the red power button driver" instead of an
arch-level check for GPIO42), and the driver resume method writes its
sysfs bus/device identifier to /sys/power/waker.  I'm not sure what the
state of the art is in representing raw GPIO drivers in the driver
model, but how to selectively enable wakeup from specific GPIO lines
will be another topic floated real soon now.

Thanks - Todd

Intel XScale PXA27x support for wakeup source identification via
/sys/power/waker.

Index: linux-2.6.15-rc4/arch/arm/mach-pxa/pxa27x.c
===================================================================
--- linux-2.6.15-rc4.orig/arch/arm/mach-pxa/pxa27x.c
+++ linux-2.6.15-rc4/arch/arm/mach-pxa/pxa27x.c
@@ -133,6 +133,78 @@ int pxa_cpu_pm_prepare(suspend_state_t s
 	}
 }
 
+static void set_wakeinfo(void)
+{
+	char wakeinfo[128];
+	u32 gpioed;
+	int i;
+
+	wakeinfo[0] = '\0';
+
+	if (PKSR)
+		strlcat(wakeinfo, "keypad ", sizeof(wakeinfo));
+
+	gpioed = PEDR;
+
+	if (gpioed & (1 << 31))
+		strlcat(wakeinfo, "rtc ", sizeof(wakeinfo));
+	if (gpioed & (1 << 30))
+		strlcat(wakeinfo, "pi ", sizeof(wakeinfo));
+	if (gpioed & (1 << 28))
+		strlcat(wakeinfo, "usbhost2 ", sizeof(wakeinfo));
+	if (gpioed & (1 << 27))
+		strlcat(wakeinfo, "usbhost1 ", sizeof(wakeinfo));
+	if (gpioed & (1 << 26))
+		strlcat(wakeinfo, "usbclient ", sizeof(wakeinfo));
+	if (gpioed & (1 << 25))
+		strlcat(wakeinfo, "msl ", sizeof(wakeinfo));
+	if (gpioed & (1 << 24))
+		strlcat(wakeinfo, "gpio35 ", sizeof(wakeinfo));
+	if (gpioed & (1 << 20)) {
+		u32 wemux3 = (PWER & 0x180000) >> 19;
+
+		switch (wemux3) {
+		case 1:
+			strlcat(wakeinfo, "gpio31 ", sizeof(wakeinfo));
+			break;
+		case 2:
+			strlcat(wakeinfo, "gpio113 ", sizeof(wakeinfo));
+			break;
+		}
+	}
+	if (gpioed & (1 << 17)) {
+		u32 wemux2 = (PWER & 0x70000) >> 16;
+
+		switch (wemux2) {
+		case 1:
+			strlcat(wakeinfo, "gpio38 ", sizeof(wakeinfo));
+			break;
+		case 2:
+			strlcat(wakeinfo, "gpio53 ", sizeof(wakeinfo));
+			break;
+		case 3:
+			strlcat(wakeinfo, "gpio40 ", sizeof(wakeinfo));
+			break;
+		case 4:
+			strlcat(wakeinfo, "gpio36 ", sizeof(wakeinfo));
+			break;
+		}
+	}
+
+
+	gpioed &= 0xfffffe1b; /* clear reserved bits 8:5, 2 */
+
+	for (i = 15; i >= 0; i--)
+		if (gpioed & (1 << i)) {
+			char name[32];
+
+			sprintf(name, "gpio%d ", i);
+			strlcat(wakeinfo, name, sizeof(wakeinfo));
+		}
+
+	pm_add_waker(wakeinfo);
+}
+
 void pxa_cpu_pm_enter(suspend_state_t state)
 {
 	extern void pxa_cpu_standby(void);
@@ -160,6 +232,8 @@ void pxa_cpu_pm_enter(suspend_state_t st
 		pxa_cpu_suspend(PWRMODE_SLEEP);
 		break;
 	}
+
+	set_wakeinfo();
 }
 
 #endif


--===============34813027152254072==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============34813027152254072==--
