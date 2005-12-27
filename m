From: Pavel Machek <pavel@ucw.cz>
Subject: [patch] pm: fix runtime powermanagement's /sys interface
Date: Tue, 27 Dec 2005 22:34:39 +0100
Message-ID: <20051227213439.GA1884@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============63584531616570672=="
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
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============63584531616570672==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

/sys/devices/..../power interface is currently very broken. It takes
integer from user, and passes it to drivers as pm_message_t.event
... without even checking it. This changes the interface to pass
strings, and introduces checks.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -27,22 +27,25 @@
 
 static ssize_t state_show(struct device * dev, struct device_attribute *attr, char * buf)
 {
-	return sprintf(buf, "%u\n", dev->power.power_state.event);
+	if (dev->power.power_state.event)
+		return sprintf(buf, "suspend\n");
+	else
+		return sprintf(buf, "on\n");
 }
 
 static ssize_t state_store(struct device * dev, struct device_attribute *attr, const char * buf, size_t n)
 {
 	pm_message_t state;
-	char * rest;
-	int error = 0;
+	int error = -EINVAL;
 
-	state.event = simple_strtoul(buf, &rest, 10);
-	if (*rest)
-		return -EINVAL;
-	if (state.event)
-		error = dpm_runtime_suspend(dev, state);
-	else
+	state.event = PM_EVENT_SUSPEND;
+	if ((n == 2) && !strncmp(buf, "on", 2)) {
 		dpm_runtime_resume(dev);
+		error = 0;
+	}
+	if ((n == 7) && !strncmp(buf, "suspend", 7))
+		error = dpm_runtime_suspend(dev, state);
+
 	return error ? error : n;
 }
 

-- 
Thanks, Sharp!

--===============63584531616570672==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============63584531616570672==--
