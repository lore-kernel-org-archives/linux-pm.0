From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.18-rc5 + pm patches] PM: update docs for
	writing .../power/state
Date: Wed, 30 Aug 2006 14:12:48 -0700
Message-ID: <200608301412.49442.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

[ resend, goes on top of Linus' patch ]

Updates to match current code:

 - Make writes to the /sys/devices/.../power/state files fail cleanly
   if the device requires the irqs-off call variants.

 - Fix comments describing the /sys/devices/.../power/state file writes
   to match the code; the last several releases have invalidated the
   previous text.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/base/power/sysfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- g26.orig/drivers/base/power/sysfs.c	2006-08-30 09:51:42.000000000 -0700
+++ g26/drivers/base/power/sysfs.c	2006-08-30 14:09:57.000000000 -0700
@@ -11,18 +11,23 @@
  *	state - Control current power state of device
  *
  *	show() returns the current power state of the device. '0' indicates
- *	the device is on. Other values (1-3) indicate the device is in a low
+ *	the device is on. Other values (2) indicate the device is in some low
  *	power state.
  *
- *	store() sets the current power state, which is an integer value
- *	between 0-3. If the device is on ('0'), and the value written is
- *	greater than 0, then the device is placed directly into the low-power
- *	state (via its driver's ->suspend() method).
- *	If the device is currently in a low-power state, and the value is 0,
- *	the device is powered back on (via the ->resume() method).
- *	If the device is in a low-power state, and a different low-power state
- *	is requested, the device is first resumed, then suspended into the new
- *	low-power state.
+ *	store() sets the current power state, which is an integer valued
+ *	0, 2, or 3.  Devices with bus.suspend_late(), or bus.resume_early()
+ *	methods fail this operation; those methods couldn't be called.
+ *	Otherwise,
+ *
+ *	- If the recorded dev->power.power_state.event matches the
+ *	  target value, nothing is done.
+ *	- If the recorded event code is nonzero, the device is reactivated
+ *	  by calling bus.resume() and/or class.resume().
+ *	- If the target value is nonzero, the device is suspended by
+ *	  calling class.suspend() and/or bus.suspend() with event code
+ *	  PM_EVENT_SUSPEND.
+ *
+ *	This mechanism is DEPRECATED and should only be used for testing.
  */
 =

 static ssize_t state_show(struct device * dev, struct device_attribute *at=
tr, char * buf)
@@ -38,6 +43,10 @@ static ssize_t state_store(struct device
 	pm_message_t state;
 	int error =3D -EINVAL;
 =

+	/* disallow incomplete suspend sequences */
+	if (dev->bus && (dev->bus->suspend_late || dev->bus->resume_early))
+		return error;
+
 	state.event =3D PM_EVENT_SUSPEND;
 	/* Older apps expected to write "3" here - confused with PCI D3 */
 	if ((n =3D=3D 1) && !strcmp(buf, "3"))
