From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v16 2/7] power: add power sequence library
Date: Fri, 07 Jul 2017 15:03:06 +0200
Message-ID: <2042394.b4eZkzrJ5f@aspire.rjw.lan>
References: <1498027328-25078-1-git-send-email-peter.chen@nxp.com> <2629938.X3D3UTyHBr@aspire.rjw.lan> <20170707080107.GC21909@b29397-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57551 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750726AbdGGNKo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2017 09:10:44 -0400
In-Reply-To: <20170707080107.GC21909@b29397-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Peter Chen <peter.chen@nxp.com>, mark.rutland@arm.com, ulf.hansson@linaro.org, heiko@sntech.de, stephen.boyd@linaro.org, frank.li@nxp.com, linux-kernel@vger.kernel.org, gary.bisson@boundarydevices.com, festevam@gmail.com, stillcompiling@gmail.com, arnd@arndb.de, dbaryshkov@gmail.com, vaibhav.hiremath@linaro.org, krzk@kernel.org, mka@chromium.org, stern@rowland.harvard.edu, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, hverkuil@xs4all.nl, oscar@naiandei.net, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, sre@kernel.org, broonie@kernel.org, p.zabel@pengutronix.de, shawnguo@kernel.org, jun.li@nxp.com

On Friday, July 07, 2017 04:01:07 PM Peter Chen wrote:
> On Fri, Jul 07, 2017 at 03:13:48AM +0200, Rafael J. Wysocki wrote:
> > > 
> > > - Can I write new code for it or I need to depend on something?
> > 
> > There is nothing this code needs to depend on AFAICS, but there are existing
> > solutions in this problem space (ACPI power management, genpd), so it needs to
> > be careful enough about possible overlaps etc.
> > 
> > > I find there is already "power state" concept at documentation.
> > > Documentation/ABI/testing/sysfs-devices-power_state
> > 
> > This is ACPI-specific and only in sysfs directories representing ACPI device
> > objects (which aren't physical devices).
> > 
> > Anyway, since ACPI covers the problem space you are working in already,
> > your code has to be mutually exclusive with it.
> > 
> > > - If I can write the new code for it, except the problems I want
> > > to fix, are there any other use cases I need to consider?
> > 
> > I would start simple and focus on the particular problem at hand, that is
> > devices with two power states ("on" and "off") where the "on" state
> > depends on a number of clocks and/or GPIOs.  Still, I'd also avoid making
> > design choices that might prevent it from being extended in the future
> > if need be.
> > 
> > One major problem I can see is how to "attach" the power states framework
> > to a particular device (once we have discovered that it should be used with
> > that device).
> > 
> > For bus types that don't do power management of their own you could follow
> > ACPI (and genpd) and provide a PM domain for this purpose, but bus types
> > doing their own PM (like USB) will probably need to be treated differently.
> > In those cases the bus type code will have to know that it should call some
> > helpers to switch power states of devices.
> > 
> 
> After thinking more, using a power state framework is seems too heavy
> for this use case. This use case is just do some clock and gpio
> operations before device is created, and do some put operations
> after device is deleted. We just need some helpers in one structure
> (called "power sequence" or "power state") for this purpose.
> 
> For the use case, the clock and gpio operation can be done after device
> is created, the power domain is more suitable.

There is a problem with PM domains that they only provide hooks for runtime PM
and system suspend/resume (including hibernation) and not for generic
"power up" and "power down" operations that may need to be carried out at
probe time before the runtime PM framework can be used (and analogously
at remove time).

I would consider starting with the patch below or similar.

Then you can define something like POWER_STATE_SEQUENCE type for your
case and basically use almost what you have already with it, except that
struct pwrsec_generic will now become struct power_state_sequence and
struct power_state_info will be embedded in it instead of struct pwrsec.

The major comceptual difference is that ->power_up and ->power_down are
now available at the level of the device that needs the power sequence and
pm_device_power_up/down() can be used wherever necessary (in the code,
in a bus type, in a controller driver or even in the driver for this particular
device).

Most likely you will need a PM domain in addition to that, but mostly to avoid
code duplication.

And in the future other types of power state definitions may be hooked up
to that, including ACPI etc.


Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/common.c |   35 +++++++++++++++++++++++++++++++++++
 include/linux/pm.h          |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -550,6 +550,30 @@ struct pm_subsys_data {
 #endif
 };
 
+enum power_state_type {
+	POWER_STATE_GENERIC = 0,
+};
+
+/**
+ * struct power_state_info - information related to device power states.
+ *
+ * @type: Power states definition type.
+ * @power_up: Device power up method.
+ * @power_down: Device power down method.
+ *
+ * @power_up is expected to put the device into a power state in which it can
+ * be operated by software (it doesn't have to be the full power state in
+ * principle as long as the device will respond to all software accesses in
+ * this state) and @power_down is expected to put the device into the lowest
+ * power state the device can be put into given all of the applicable
+ * constraints and limitations (it may not mean completely off).
+ */
+struct power_state_info {
+	enum power_state_type type;
+	int (*power_up)(struct device *dev);
+	int (*power_down)(struct device *dev);
+};
+
 struct dev_pm_info {
 	pm_message_t		power_state;
 	unsigned int		can_wakeup:1;
@@ -600,6 +624,7 @@ struct dev_pm_info {
 	unsigned long		active_jiffies;
 	unsigned long		suspended_jiffies;
 	unsigned long		accounting_timestamp;
+	struct power_state_info	*state;
 #endif
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	void (*set_latency_tolerance)(struct device *, s32);
@@ -610,6 +635,14 @@ extern void update_pm_runtime_accounting
 extern int dev_pm_get_subsys_data(struct device *dev);
 extern void dev_pm_put_subsys_data(struct device *dev);
 
+#ifdef CONFIG_PM
+extern int pm_device_power_up(struct device *dev);
+extern int pm_device_power_down(struct device *dev);
+#else
+static inline int pm_device_power_up(struct device *dev) { return 0; }
+static inline int pm_device_power_down(struct device *dev) { return 0; }
+#endif /* CONFIG_PM */
+
 /**
  * struct dev_pm_domain - power management domain representation.
  *
Index: linux-pm/drivers/base/power/common.c
===================================================================
--- linux-pm.orig/drivers/base/power/common.c
+++ linux-pm/drivers/base/power/common.c
@@ -152,3 +152,38 @@ void dev_pm_domain_set(struct device *de
 	device_pm_check_callbacks(dev);
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_set);
+
+/**
+ * pm_device_power_up - Power up a device using the power states framework.
+ * @dev: Device to power up.
+ *
+ * Put the device into a power state in which it will respond to all software
+ * accesses (that may not mean maximum power) using the callback provided
+ * through the device power state framework, if present.
+ */
+int pm_device_power_up(struct device *dev)
+{
+	if (dev->power.state && dev->power.state->power_up)
+		return dev->power.state->power_up(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pm_device_power_up);
+
+/**
+ * pm_device_power_down - Power down a device using the power states framework.
+ * @dev: Device to power down.
+ *
+ * Put the device into the lowest power state it can be put into given the
+ * applicable constraints and limitations (that may not mean maximum power)
+ * using the callback provided through the device power state framework, if
+ * present.
+ */
+int pm_device_power_down(struct device *dev)
+{
+	if (dev->power.state && dev->power.state->power_down)
+		return dev->power.state->power_down(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pm_device_power_down);
