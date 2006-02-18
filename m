From: Patrick Mochel <mochel@digitalimplant.org>
Subject: [PATCH 4/5] [pm] Minor updates to core suspend/resume
	functions
Date: Fri, 17 Feb 2006 18:03:43 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0602171758520.30811-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============016724999776934091=="
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
To: greg@kroah.com, torvalds@osdl.org, akpm@osdl.org
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============016724999776934091==
Content-Type: TEXT/PLAIN; charset=US-ASCII


- Check the real state the device and parent are in compared
  to the the real state requested, instead of just checking
  that the event types are the same.

- Update debug and error messages to display the real states.

- Always print the state we're entering when debug is enabled.

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/base/power/resume.c  |   11 +++++++----
 drivers/base/power/runtime.c |   11 ++++++-----
 drivers/base/power/suspend.c |   34 +++++++++++++++++++---------------
 3 files changed, 32 insertions(+), 24 deletions(-)

applies-to: f7ec3dc82e3cc4661a7aaf32a8a79cef0e10c236
f78ca60a58439953b4e1fe61a648ed92970d7f1e
diff --git a/drivers/base/power/resume.c b/drivers/base/power/resume.c
index 478e116..3101431 100644
--- a/drivers/base/power/resume.c
+++ b/drivers/base/power/resume.c
@@ -24,16 +24,19 @@ int resume_device(struct device * dev)
 	int error = 0;

 	if (dev->power.pm_parent
-			&& dev->power.pm_parent->power.power_state.event) {
-		dev_err(dev, "PM: resume from %d, parent %s still %d\n",
-			dev->power.power_state.event,
+	    && dev->power.pm_parent->power.power_state.state) {
+		dev_err(dev, "PM: resume from state %u, parent %s still in state %u\n",
+			dev->power.power_state.state,
 			dev->power.pm_parent->bus_id,
-			dev->power.pm_parent->power.power_state.event);
+			dev->power.pm_parent->power.power_state.state);
 	}
 	if (dev->bus && dev->bus->resume) {
 		dev_dbg(dev,"resuming\n");
 		error = dev->bus->resume(dev);
 	}
+	dev->power.prev_state = dev->power.power_state;
+	dev->power.power_state.state = 0;
+	dev->power.power_state.event = PM_EVENT_ON;
 	return error;
 }

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 96370ec..d224761 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -45,19 +45,20 @@ EXPORT_SYMBOL(dpm_runtime_resume);
  *	@state:	State to enter.
  */

-int dpm_runtime_suspend(struct device * dev, pm_message_t state)
+int dpm_runtime_suspend(struct device * dev, pm_message_t msg)
 {
 	int error = 0;

 	down(&dpm_sem);
-	if (dev->power.power_state.event == state.event)
+	if (dev->power.power_state.event == msg.event &&
+	    dev->power.power_state.state == msg.state)
 		goto Done;

-	if (dev->power.power_state.event)
+	if (dev->power.power_state.event != PM_EVENT_ON)
 		runtime_resume(dev);

-	if (!(error = suspend_device(dev, state)))
-		dev->power.power_state = state;
+	if (!(error = suspend_device(dev, msg)))
+		dev->power.power_state = msg;
  Done:
 	up(&dpm_sem);
 	return error;
diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
index a59158c..67bc5ce 100644
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -34,29 +34,33 @@
  *	@state:	Power state device is entering.
  */

-int suspend_device(struct device * dev, pm_message_t state)
+int suspend_device(struct device * dev, pm_message_t msg)
 {
+	struct device * pm_parent;
 	int error = 0;

-	if (dev->power.power_state.event) {
-		dev_dbg(dev, "PM: suspend %d-->%d\n",
-			dev->power.power_state.event, state.event);
-	}
+	dev_dbg(dev, "Suspend [Event %d: %u --> %u]\n",
+		msg.event, dev->power.power_state.state, msg.state);
+
+	pm_parent = dev->power.pm_parent;
 	if (dev->power.pm_parent
-			&& dev->power.pm_parent->power.power_state.event) {
-		dev_err(dev,
-			"PM: suspend %d->%d, parent %s already %d\n",
-			dev->power.power_state.event, state.event,
-			dev->power.pm_parent->bus_id,
-			dev->power.pm_parent->power.power_state.event);
+	    && dev->power.pm_parent->power.power_state.state) {
+		dev_err(dev,
+			"Suspend [Event %d: %u --> %u], parent %s already in [State %u]\n",
+			msg.event, dev->power.power_state.state, msg.state,
+			pm_parent->bus_id, pm_parent->power.power_state.state);
 	}

-	dev->power.prev_state = dev->power.power_state;
-
-	if (dev->bus && dev->bus->suspend && !dev->power.power_state.event) {
+	if (dev->bus && dev->bus->suspend) {
 		dev_dbg(dev, "suspending\n");
-		error = dev->bus->suspend(dev, state);
+		error = dev->bus->suspend(dev, msg);
 	}
+
+	if (!error) {
+		dev->power.prev_state = dev->power.power_state;
+		dev->power.power_state = msg;
+	}
+
 	return error;
 }

---
0.99.9.GIT

--===============016724999776934091==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============016724999776934091==--
