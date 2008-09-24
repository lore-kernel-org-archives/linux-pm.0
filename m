From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend (uhci_hcd) defunct in mmotm 2008-09-13-03-09
Date: Wed, 24 Sep 2008 17:29:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0809241722010.2181-100000__35609.755657106$1222291981$gmane$org@iolanthe.rowland.org>
References: <48DA8CFC.9020304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <48DA8CFC.9020304@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 24 Sep 2008, Jiri Slaby wrote:

> On 09/24/2008 08:19 PM, Jiri Slaby wrote:
> > I see, I need to boot to that kernel anyway, with dynamic_printk param this time.
> 
> It didn't work as I expected, nevermind, here comes updated dmesg:
> http://decibel.fi.muni.cz/~xslaby/dmesg_fail.hcd

Got it.  I found the problem, and there is a patch below for you to 
test.

Rafael, since the type now has a complete pm_ops structure, is there
any reason we shouldn't use its suspend/resume methods along with
the bus's and the class's?  When writing the USB updates I assumed that
would be the case -- and as a result we now have a regression which
this patch should fix.

(Also, is there any reason why the pm_dev_dbg() shouldn't go inside 
pm_op()?  It precedes every call of that routine.)

If everyone is okay with it, I'll submit the patch with a proper 
Changelog and Signed-off-by.

Alan Stern



Index: usb-2.6/drivers/base/power/main.c
===================================================================
--- usb-2.6.orig/drivers/base/power/main.c
+++ usb-2.6/drivers/base/power/main.c
@@ -107,7 +107,7 @@ void device_pm_remove(struct device *dev
 }
 
 /**
- *	pm_op - execute the PM operation appropiate for given PM event
+ *	pm_op - execute the PM operation appropriate for given PM event
  *	@dev:	Device.
  *	@ops:	PM operations to choose from.
  *	@state:	PM transition of the system being carried out.
@@ -166,7 +166,7 @@ static int pm_op(struct device *dev, str
 }
 
 /**
- *	pm_noirq_op - execute the PM operation appropiate for given PM event
+ *	pm_noirq_op - execute the PM operation appropriate for given PM event
  *	@dev:	Device.
  *	@ops:	PM operations to choose from.
  *	@state: PM transition of the system being carried out.
@@ -363,6 +363,13 @@ static int resume_device(struct device *
 			goto End;
 	}
 
+	if (dev->type && dev->type->pm) {
+		pm_dev_dbg(dev, state, "type ");
+		error = pm_op(dev, dev->type->pm, state);
+		if (error)
+			goto End;
+	}
+
 	if (dev->class) {
 		if (dev->class->pm) {
 			pm_dev_dbg(dev, state, "class ");
@@ -596,6 +603,13 @@ static int suspend_device(struct device 
 			goto End;
 	}
 
+	if (dev->type && dev->type->pm) {
+		pm_dev_dbg(dev, state, "type ");
+		error = pm_op(dev, dev->type->pm, state);
+		if (error)
+			goto End;
+	}
+
 	if (dev->bus) {
 		if (dev->bus->pm) {
 			pm_dev_dbg(dev, state, "");
