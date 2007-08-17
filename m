From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm] PNP: Make pnpacpi_suspend handle errors
Date: Fri, 17 Aug 2007 15:30:28 +0200
Message-ID: <200708171530.29592.rjw__44504.0535335012$1187356916$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>, Jaroslav Kysela <perex@suse.cz>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

pnpacpi_suspend() doesn't check the result returned by
acpi_pm_device_sleep_state() before passing it to acpi_bus_set_power(), w=
hich
may not be desirable. =A0Make it select the target power state of the dev=
ice
using its second argument if acpi_pm_device_sleep_state() fails.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Looks-ok-to: Pavel Machek <pavel@ucw.cz>
---
 drivers/pnp/pnpacpi/core.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

Index: linux-2.6.23-rc3/drivers/pnp/pnpacpi/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-rc3.orig/drivers/pnp/pnpacpi/core.c	2007-08-15 14:56:58.=
000000000 +0200
+++ linux-2.6.23-rc3/drivers/pnp/pnpacpi/core.c	2007-08-15 15:08:36.00000=
0000 +0200
@@ -130,11 +130,16 @@ static int pnpacpi_disable_resources(str
 #ifdef CONFIG_ACPI_SLEEP
 static int pnpacpi_suspend(struct pnp_dev *dev, pm_message_t state)
 {
-	return acpi_bus_set_power((acpi_handle) dev->data,
-				  acpi_pm_device_sleep_state(&dev->dev,
-							     device_may_wakeup
-							     (&dev->dev),
-							     NULL));
+	int power_state;
+
+	power_state =3D acpi_pm_device_sleep_state(&dev->dev,
+						device_may_wakeup(&dev->dev),
+						NULL);
+	if (power_state < 0)
+		power_state =3D (state.event =3D=3D PM_EVENT_ON) ?
+				ACPI_STATE_D0 : ACPI_STATE_D3;
+
+	return acpi_bus_set_power((acpi_handle) dev->data, power_state);
 }
=20
 static int pnpacpi_resume(struct pnp_dev *dev)
