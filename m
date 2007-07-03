From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 2/9] ACPI: Add
	acpi_pm_device_sleep_state helper routine
Date: Tue, 3 Jul 2007 15:58:49 +0200
Message-ID: <200707031558.50799.rjw@sisk.pl>
References: <200706302257.17556.rjw@sisk.pl>
	<200707021024.58693.david-b@pacbell.net>
	<200707022215.09354.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707022215.09354.rjw@sisk.pl>
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
To: David Brownell <david-b@pacbell.net>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Monday, 2 July 2007 22:15, Rafael J. Wysocki wrote:
> On Monday, 2 July 2007 19:24, David Brownell wrote:
> > On Monday 02 July 2007, Rafael J. Wysocki wrote:
> > > On Monday, 2 July 2007 07:49, David Brownell wrote:
> > 
> > > > Also, recall that this was originally PCI-specific.  A generalized
> > > > approach would return a range of states, not a single state that
> > > > embeds a particular policy that may not be universally appropriate...
> > > 
> > > Via pointers and the return value equal to 0 on success?
> > 
> > It could as easily be one pointer:  "int minmax[2]".
> > Then min == minmax[0] and max == minmax[1], and the
> > ACPI calls could write the caller's data directly.
> > 
> > But in general, yes -- pointer, not single return value.
> > 
> > 
> > > > The logic was that PCI devices can all support PCI_D0 and PCI_D3.
> > > > For non-PCI devices we can't actually know that.  So "min" should
> > > > probably default to ACPI_STATE_D0.  If this returns a range, then
> > > > such issues can stay out of this code.
> > > 
> > > The ACPI spec says that all devices must support D0 and D3.
> > 
> > ISTR that it actually says they must "recognize" D3.  That's
> > not the same as actually implementing a software controllable
> > power-off state ... and not the same as imposing a "use the
> > biggest numbered D-state" policy at this level.
> 
> No, it literally says "All devices must support the D0 and D3 states" (that
> actually is stated in Appendix A, A.3.4 in the 3.0b specification).
> 
> Still, I think that the question really is what we should return if _SxD or
> _SxW are not present.
> 
> > > > > +	/*
> > > > > +	 * If _PRW says we can wake from the upcoming system state, the _SxD
> > > > > +	 * value can wake ... and we'll assume a wakeup-aware driver.  If _SxW
> > > > > +	 * methods exist (ACPI 3.x), they give the lowest power D-state that
> > > > > +	 * can also wake the system.  _S0W can be valid.
> > > > > +	 */
> > > > > +	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
> > > > > +	    (dev->wakeup.state.enabled &&
> 
> These things are the result of the evaluation of _PRW for that device and
> we need to check them here (or evaluate _PRW ourselves, but that wouldn't make
> sense, since it's already been evaulated), unless the caller tells us not to
> bother (we should provide the caller with a means to do it, though).

I looked at the ACPI spec again and updated the patch (please see below).

Greetings,
Rafael


---
From: Shaohua Li <shaohua.li@intel.com>, Rafael J. Wysocki <rjw@sisk.pl>

Based on the David Brownell's patch at
http://marc.info/?l=linux-acpi&m=117873972806360&w=2

Add a helper routine returning the lowest power (highest number) ACPI device
power state that given device can be in while the system is in the sleep state
indicated by acpi_target_sleep_state .

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h   |    2 +
 2 files changed, 74 insertions(+)

Index: linux-2.6.22-rc7/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.22-rc7.orig/drivers/acpi/sleep/main.c	2007-07-02 22:38:34.000000000 +0200
+++ linux-2.6.22-rc7/drivers/acpi/sleep/main.c	2007-07-03 11:57:27.000000000 +0200
@@ -269,6 +269,78 @@ static struct platform_hibernation_ops a
 };
 #endif				/* CONFIG_SOFTWARE_SUSPEND */
 
+/**
+ *	acpi_pm_device_sleep_state - return preferred power state of ACPI device
+ *		in the system sleep state given by %acpi_target_sleep_state
+ *	@dev: device to examine
+ *	@wake: if set, the device should be able to wake up the system
+ *	@d_min_p: used to store the upper limit of allowed states range
+ *	Return value: preferred power state of the device on success, -ENODEV on
+ *		failure (ie. if there's no 'struct acpi_device' for @dev)
+ *
+ *	Find the lowest power (highest number) ACPI device power state that
+ *	device @dev can be in while the system is in the sleep state represented
+ *	by %acpi_target_sleep_state.  If @wake is nonzero, the device should be
+ *	able to wake up the system from this sleep state.  If @d_min_p is set,
+ *	the highest power (lowest number) device power state of @dev allowed
+ *	in this system sleep state is stored at the location pointed to by it.
+ *
+ *	The caller must ensure that @dev is valid before using this function.
+ */
+
+int acpi_pm_device_sleep_state(struct device *dev, int wake, int *d_min_p)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
+	struct acpi_device *adev;
+	char acpi_method[] = "_SxD";
+	unsigned long d_min, d_max;
+
+	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &adev))) {
+		printk(KERN_ERR "ACPI handle has no context!\n");
+		return -ENODEV;
+	}
+
+	acpi_method[2] = '0' + acpi_target_sleep_state;
+	/*
+	 * If the sleep state is S0, we will return D3, but if the device has
+	 * _S0W, we will use the value from _S0W
+	 */
+	d_min = ACPI_STATE_D0;
+	d_max = ACPI_STATE_D3;
+
+	/*
+	 * If present, _SxD methods return the minimum D-state (highest power
+	 * state) we can use for the corresponding S-states.  Otherwise, the
+	 * minimum D-state is D0 (ACPI 3.x).
+	 *
+	 * NOTE: We rely on acpi_evaluate_integer() not clobbering the integer
+	 * provided -- that's our fault recovery, we ignore retval.
+	 */
+	if (acpi_target_sleep_state > ACPI_STATE_S0)
+		acpi_evaluate_integer(handle, acpi_method, NULL, &d_min);
+
+	/*
+	 * If _PRW says we can wake up the system from the target sleep state,
+	 * the D-state returned by _SxD is sufficient for that (we assume a
+	 * wakeup-aware driver if wake is set).  Still, if _SxW exists
+	 * (ACPI 3.x), it should return the maximum (lowest power) D-state that
+	 * can wake the system.  _S0W may be valid, too.
+	 */
+	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
+	    (wake && adev->wakeup.state.enabled &&
+	     adev->wakeup.sleep_state <= acpi_target_sleep_state)) {
+		acpi_method[3] = 'W';
+		acpi_evaluate_integer(handle, acpi_method, NULL, &d_max);
+		/* Sanity check */
+		if (d_max < d_min)
+			d_min = d_max;
+	}
+
+	if (d_min_p)
+		*d_min_p = d_min;
+	return d_max;
+}
+
 /*
  * Toshiba fails to preserve interrupts over S1, reinitialization
  * of 8259 is needed after S1 resume.
Index: linux-2.6.22-rc7/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.22-rc7.orig/include/acpi/acpi_bus.h	2007-07-02 22:36:30.000000000 +0200
+++ linux-2.6.22-rc7/include/acpi/acpi_bus.h	2007-07-02 23:06:34.000000000 +0200
@@ -364,6 +364,8 @@ acpi_handle acpi_get_child(acpi_handle, 
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int, unsigned int);
 #define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->archdata.acpi_handle))
 
+int acpi_pm_device_sleep_state(struct device *, int, int *);
+
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/
