From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: use of pm_runtime_disable() from driver probe?
Date: Tue, 10 Jul 2012 21:41:24 +0200
Message-ID: <201207102141.24775.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1207101437230.1308-100000@iolanthe.rowland.org>
	<201207102114.05001.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201207102114.05001.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Kevin Hilman <khilman@ti.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 10, 2012, Rafael J. Wysocki wrote:
> On Tuesday, July 10, 2012, Alan Stern wrote:
> > On Tue, 10 Jul 2012, Rafael J. Wysocki wrote:
> > 
> > > > > Anyway, you can't force the device into a low-power state using
> > > > > runtime PM after a failing probe, at least in general.
> > > > 
> > > > Well, using PM domains, that's exactly what can happen if the driver
> > > > doesn't call pm_runtime_disable() because the _put_sync() in the driver
> > > > core will trigger the PM domain callbacks.
> > > 
> > > OK, so if you have PM domains, then the case is equivalent to having a bus
> > > type with its own runtime PM callbacks.  In that case, if .probe() fails,
> > > it obviously doesn't mean that the device shouldn't be power managed,
> > > so the driver shouldn't call pm_runtime_disable().
> > > 
> > > Generally, if runtime PM was enabled for a device before .probe() has been
> > > called, the driver shouldn't disable it in .probe() whatever the reason,
> > > because it may not have enough information for deciding whether or not
> > > runtime PM should be disabled.
> > 
> > So if the PM domain code called pm_runtime_enable() then the domain
> > code should be responsible for calling pm_runtime_disable() too, 
> > presumably after putting the device back into a low-power state.  I'm 
> > not sure when that would occur, however.  Immediately after registering 
> > the device, if no driver is bound?
> > 
> > In the case where the probe routine called pm_runtime_enable(), you're
> > stuck.  The probe routine _has_ to call pm_runtime_disable() when a
> > failure occurs, to keep the disable count balanced.
> 
> Yes, I has just been thinking about that.
> 
> If .probe() enabled runtime PM and called pm_runtime_get_sync() (or _resume),
> it can't clean up properly in case of an error, because its
> pm_runtime_put_sync() (or _suspend) won't be effective and you're right that
> it has to call pm_runtime_disable().
> 
> So, we don't handle this particular case correctly.
> 
> I'm not sure what the solution should be, though.  We could remove the
> runtime PM operations around really_probe(), but then there may be drivers
> assuming that the core will call pm_runtime_put_sync() after .probe()
> has returned.

I have an idea.

What about the following patch?  It shouldn't matter except for the cases when
.probe() attempts to suspend the device by itself.

---
 drivers/base/dd.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: linux/drivers/base/dd.c
===================================================================
--- linux.orig/drivers/base/dd.c
+++ linux/drivers/base/dd.c
@@ -356,10 +356,8 @@ int driver_probe_device(struct device_dr
 	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
 		 drv->bus->name, __func__, dev_name(dev), drv->name);
 
-	pm_runtime_get_noresume(dev);
-	pm_runtime_barrier(dev);
 	ret = really_probe(dev, drv);
-	pm_runtime_put_sync(dev);
+	pm_runtime_idle(dev);
 
 	return ret;
 }
@@ -406,9 +404,8 @@ int device_attach(struct device *dev)
 			ret = 0;
 		}
 	} else {
-		pm_runtime_get_noresume(dev);
 		ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
-		pm_runtime_put_sync(dev);
+		pm_runtime_idle(dev);
 	}
 out_unlock:
 	device_unlock(dev);
