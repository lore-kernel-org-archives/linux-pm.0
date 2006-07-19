From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.18-rc2-mm 2/2] PM:
	/sys/devices/.../power/state updates
Date: Wed, 19 Jul 2006 13:40:13 -0700
Message-ID: <200607191340.14371.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uipvEaIA/eKGXdA"
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
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_uipvEaIA/eKGXdA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Two changes here:  (a) make writes to these files fail on devices that
may need the new operations in Linus' patch; (b) update in-source docs
to match current behavior, including that change.

I hope nobody has issues with (a), but I can't see a good reason to
do more than reject such writes since the notions behind that file
are so broken.

- Dave

p.s. Greg, these two should IMO merge into your tree along with
    Linus' patches, in addition to

   http://lists.osdl.org/pipermail/linux-pm/2006-July/002968.html

--Boundary-00=_uipvEaIA/eKGXdA
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linus-tweak2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linus-tweak2.patch"

Two updates to the /sys/devices/.../power/state code:

(a) Changes write path code so that it returns errors for devices using the
    new not-callable-here suspend_prepare(), suspend_late(), or resume_early()
    methods.

(a) Corrects some of the documentation about what's legal for writing to
    /sys/devices/.../power/state files to match the current code (including
    the minor changes for those new methods) below that documentation.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: linux/drivers/base/power/sysfs.c
===================================================================
--- linux.orig/drivers/base/power/sysfs.c	2006-07-18 11:00:35.000000000 -0700
+++ linux/drivers/base/power/sysfs.c	2006-07-18 11:13:56.000000000 -0700
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
+ *	0, 2, or 3.  Devices with bus.suspend_prepare(), bus.suspend_late(),
+ *	or bus.resume_early() methods fail this operation; those methods
+ *	won't be called.  Otherwise,
+ *
+ *	- If the recorded dev->power.power_state.event matches the
+ *	  target value (PM_EVENT_ON or PM_EVENT_SUSPEND), nothing is done.
+ *	- If the recorded event code is nonzero, the device is reactivated
+ *	  by calling bus.resume() and/or class.resume().
+ *	- If the target value is nonzero, the device is suspended by
+ *	  calling class.suspend() and/or bus.suspend() with event code
+ *	  PM_EVENT_SUSPEND.
+ *
+ *	This mechanism is DEPRECATED and should only be used for testing.
  */
 
 static ssize_t state_show(struct device * dev, struct device_attribute *attr, char * buf)
@@ -38,6 +43,12 @@
 	pm_message_t state;
 	int error = -EINVAL;
 
+	/* disallow incomplete suspend sequences */
+	if (dev->bus && (dev->bus->suspend_prepare
+			|| dev->bus->suspend_late
+			|| dev->bus->resume_early))
+		return error;
+
 	state.event = PM_EVENT_SUSPEND;
 	/* Older apps expected to write "3" here - confused with PCI D3 */
 	if ((n == 1) && !strcmp(buf, "3"))

--Boundary-00=_uipvEaIA/eKGXdA
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_uipvEaIA/eKGXdA--
