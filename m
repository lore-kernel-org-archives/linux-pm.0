From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Tue, 13 Jun 2006 16:20:44 -0700
Message-ID: <200606131620.45156.david-b@pacbell.net>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Nh0jEnq/Qg00NBk"
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Linus Torvalds <torvalds@osdl.org>
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_Nh0jEnq/Qg00NBk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here's a related patch (well, "hack") I found helpful ... specifically to
help let _serial_ consoles be more useful.  As a rule, RS-232 lines will get
shut down right before the most interesting point in the system suspend
process, so that the debug messages I'm most interested in seeing will
then be thrown into the bitbucket (especially when resume breaks).  But
this *cough* elegant patch lets you toss that bitbucket into itself.

Although I must say I like Nigel's "BDI-2000 per developer" hack better.
Even though not all boxes can hook up to a JTAG module.  :(

- Dave


--Boundary-00=_Nh0jEnq/Qg00NBk
Content-Type: text/x-diff;
  charset="us-ascii";
  name="serial-pm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="serial-pm.patch"

Leave serial console active during freeze and prethaw, so we don't discard
the most interesting diagnostics.

Note that wakeup-enabled serial ports may already be bypassing the suspend
logic on some platforms, for serial ports which are enabled as wakeup
event sources.

Index: linux/drivers/serial/8250.c
===================================================================
--- linux.orig/drivers/serial/8250.c	2006-05-20 11:28:30.000000000 -0700
+++ linux/drivers/serial/8250.c	2006-05-20 11:29:51.000000000 -0700
@@ -2455,13 +2455,37 @@
 	return 0;
 }
 
+/* HACK -- skipconsoles known to work with single serial port,
+ * allowing serial port to work during freeze/prethaw/thaw
+ * ... really the flag should be per-port
+ */
+static int skipconsoles;
+
+/* uart_console() should be in a header ... */
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
+#define uart_console(port)	((port)->cons && (port)->cons->index == (port)->line)
+#else
+#define uart_console(port)	(0)
+#endif
+
 static int serial8250_suspend(struct platform_device *dev, pm_message_t state)
 {
 	int i;
 
-	for (i = 0; i < UART_NR; i++) {
+	for (i = 0;
+			0 &&
+			i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
+		switch (state.event) {
+		case PM_EVENT_FREEZE:
+		case PM_EVENT_PRETHAW:
+			if (uart_console(&up->port)) {
+				skipconsoles = 1;
+				continue;
+			}
+		}
+
 		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
 			uart_suspend_port(&serial8250_reg, &up->port);
 	}
@@ -2473,9 +2497,16 @@
 {
 	int i;
 
-	for (i = 0; i < UART_NR; i++) {
+	for (i = 0;
+			0 &&
+			i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
+		if (skipconsoles && uart_console(&up->port)) {
+			skipconsoles = 0;
+			continue;
+		}
+
 		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
 			uart_resume_port(&serial8250_reg, &up->port);
 	}

--Boundary-00=_Nh0jEnq/Qg00NBk
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_Nh0jEnq/Qg00NBk--
