From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2] PM: Document device power attributes in sysfs
Date: Fri, 22 Jan 2010 00:00:54 +0100
Message-ID: <201001220000.54860.rjw__18455.9259251275$1264114947$gmane$org@sisk.pl>
References: <201001180129.55219.rjw@sisk.pl> <201001212357.46483.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001212357.46483.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Greg KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

There are sysfs attributes in /sys/devices/.../power/ that haven't
been documented yet in Documentation/ABI/.  Document them as
appropriate.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/ABI/testing/sysfs-devices-power |   53 ++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

Index: linux-2.6/Documentation/ABI/testing/sysfs-devices-power
===================================================================
--- /dev/null
+++ linux-2.6/Documentation/ABI/testing/sysfs-devices-power
@@ -0,0 +1,53 @@
+What:		/sys/devices/.../power/
+Date:		January 2009
+Contact:	Rafael J. Wysocki <rjw@sisk.pl>
+Description:
+		The /sys/devices/.../power directory contains attributes
+		allowing the user space to check and modify some power
+		management related properties of given device.
+
+What:		/sys/devices/.../power/wakeup
+Date:		January 2009
+Contact:	Rafael J. Wysocki <rjw@sisk.pl>
+Description:
+		The /sys/devices/.../power/wakeup attribute allows the user
+		space to check if the device is enabled to wake up the system
+		from sleep states, such as the memory sleep state (suspend to
+		RAM) and hibernation (suspend to disk), and to enable or disable
+		it to do that as desired.
+
+		Some devices support "wakeup" events, which are hardware signals
+		used to activate the system from a sleep state.  Such devices
+		have one of the following two values for the sysfs power/wakeup
+		file:
+
+		+ "enabled\n" to issue the events;
+		+ "disabled\n" not to do so;
+
+		In that cases the user space can change the setting represented
+		by the contents of this file by writing either "enabled", or
+		"disabled" to it.
+
+		For the devices that are not capable of generating system wakeup
+		events this file contains "\n".  In that cases the user space
+		cannot modify the contents of this file and the device cannot be
+		enabled to wake up the system.
+
+What:		/sys/devices/.../power/control
+Date:		January 2009
+Contact:	Rafael J. Wysocki <rjw@sisk.pl>
+Description:
+		The /sys/devices/.../power/control attribute allows the user
+		space to control the run-time power management of the device.
+
+		All devices have one of the following two values for the
+		power/control file:
+
+		+ "auto\n" to allow the device to be power managed at run time;
+		+ "on\n" to prevent the device from being power managed;
+
+		The default for all devices is "auto", which means that they may
+		be subject to automatic power management, depending on their
+		drivers.  Changing this attribute to "on" prevents the driver
+		from power managing the device at run time.  Doing that while
+		the device is suspended causes it to be woken up.
