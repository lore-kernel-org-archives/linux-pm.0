From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: RFC: PNP: do not stop/start devices in suspend/resume
	path
Date: Wed, 5 Dec 2007 11:24:18 -0700
Message-ID: <200712051124.18852.bjorn.helgaas__18936.2713871107$1196879177$gmane$org@hp.com>
References: <4745F77C.7040402@gmail.com> <47511751.2010707@gmail.com>
	<47514CE2.3000600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47514CE2.3000600@gmail.com>
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
To: Jiri Slaby <jirislaby@gmail.com>
Cc: matthew@wil.cx, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, drzeus@drzeus.cx, Matthieu Castet <castet.matthieu@free.fr>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Re: warning on suspend-to-RAM caused by
pnp-request-ioport-and-iomem-resources-used-by-active-devices.patch,
thread here: http://lkml.org/lkml/2007/11/22/110

On Saturday 01 December 2007 05:00:34 am Jiri Slaby wrote:
> I didn't get it. Maybe some trolls poking around or something (maybe the
> ext3 breakage which fsck fixed). It works after recompilation of the
> whole tree. And the important part -- the warning has gone.

Good.  It's not clear to me whether it is safe to leave devices
enabled while we sleep.  I don't see an actual problem, but there
might be something related to hotplug while we're asleep or something.
So I'll cc: some additional people who might have some insight.



RFC: PNP: do not stop/start devices in suspend/resume path

Do not disable PNP devices in the suspend path.  We still call
the driver's suspend method, which should prevent further use of
the device, and the protocol suspend method, which may put the
device in a low-power state.

This means we will not disable the device and release its
resources.  The driver suspend method typically does not release
its resources in the suspend path.  For example, if we have:

  03f8-03ff : 00:06
    03f8-03ff : serial

pnp_stop_dev() would release the 00:06 region, which still
has a child.  This causes a warning from __release_resource
and corrupts /proc/ioports.

However, we should do this the same way Windows does, so if
Windows disables devices before going to sleep, we should, too.
It doesn't *look* necessary to me because

  - In the ACPI 3.0b spec, I can't find any mention of _DIS in
    connection with sleep.  And Device Object Notifications,
    Section 5.6.3, Table 5-43, says we should get a bus check
    after awakening if hardware was removed while we slept.

    This: http://msdn2.microsoft.com/en-us/library/ms810079.aspx
    makes a similar point about how the OS re-enumerates devices
    as a result of a power state change (3rd last paragraph of
    text).

  - This: http://msdn2.microsoft.com/en-us/library/aa489874.aspx
    suggests that Windows only stops a device to rebalance hardware
    resources.

[This should go before
pnp-request-ioport-and-iomem-resources-used-by-active-devices.patch
for best bisect-ability.]

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: linux-mm/drivers/pnp/driver.c
===================================================================
--- linux-mm.orig/drivers/pnp/driver.c	2007-11-30 13:58:25.000000000 -0700
+++ linux-mm/drivers/pnp/driver.c	2007-12-03 09:58:35.000000000 -0700
@@ -161,13 +161,6 @@
 			return error;
 	}
 
-	if (!(pnp_drv->flags & PNP_DRIVER_RES_DO_NOT_CHANGE) &&
-	    pnp_can_disable(pnp_dev)) {
-		error = pnp_stop_dev(pnp_dev);
-		if (error)
-			return error;
-	}
-
 	if (pnp_dev->protocol && pnp_dev->protocol->suspend)
 		pnp_dev->protocol->suspend(pnp_dev, state);
 	return 0;
@@ -177,7 +170,6 @@
 {
 	struct pnp_dev *pnp_dev = to_pnp_dev(dev);
 	struct pnp_driver *pnp_drv = pnp_dev->driver;
-	int error;
 
 	if (!pnp_drv)
 		return 0;
@@ -185,12 +177,6 @@
 	if (pnp_dev->protocol && pnp_dev->protocol->resume)
 		pnp_dev->protocol->resume(pnp_dev);
 
-	if (!(pnp_drv->flags & PNP_DRIVER_RES_DO_NOT_CHANGE)) {
-		error = pnp_start_dev(pnp_dev);
-		if (error)
-			return error;
-	}
-
 	if (pnp_drv->resume)
 		return pnp_drv->resume(pnp_dev);
 
