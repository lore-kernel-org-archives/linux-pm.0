From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.17-rc4-git] PM_DEBUG device suspend()
	messages become informative
Date: Tue, 16 May 2006 17:03:25 -0700
Message-ID: <200605161703.26678.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OhmaEBuvxjhX0fn"
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
To: Greg KH <greg@kroah.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_OhmaEBuvxjhX0fn
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Now FREEZE is visibly different from real SUSPEND messages, and when
a real suspend is initiated it will report wakeup-enabled devices.


--Boundary-00=_OhmaEBuvxjhX0fn
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pm-diag.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pm-diag.patch"

This makes the driver model PM suspend debug messages more useful, by

  (a) explaining what event is being sent, since not all suspend()
      requests mean the same thing;

  (b) reporting when a PM_EVENT_SUSPEND call is allowing the device
      to issue wakeup events.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -30,6 +30,15 @@
  * lists. This way, the ancestors will be accessed before their descendents.
  */
 
+static inline char *suspend_verb(u32 event)
+{
+	switch (event) {
+	case PM_EVENT_SUSPEND:	return "suspend";
+	case PM_EVENT_FREEZE:	return "freeze";
+	default:		return "(unknown suspend event)";
+	}
+}
+
 
 /**
  *	suspend_device - Save state of one device.
@@ -58,7 +67,13 @@ int suspend_device(struct device * dev, 
 	dev->power.prev_state = dev->power.power_state;
 
 	if (dev->bus && dev->bus->suspend && !dev->power.power_state.event) {
-		dev_dbg(dev, "suspending\n");
+		dev_dbg(dev, "%s%s\n",
+			suspend_verb(state.event),
+			((state.event == PM_EVENT_SUSPEND)
+					&& device_may_wakeup(dev))
+				? ", may wakeup"
+				: ""
+			);
 		error = dev->bus->suspend(dev, state);
 		suspend_report_result(dev->bus->suspend, error);
 	}

--Boundary-00=_OhmaEBuvxjhX0fn
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_OhmaEBuvxjhX0fn--
