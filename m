From: David Brownell <david-b@pacbell.net>
Subject: Re: parallel suspend/resume
Date: Fri, 07 Dec 2007 10:01:12 -0800
Message-ID: <20071207180112.8C68B1E3692@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0712071120400.4209-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0712071120400.4209-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: stern@rowland.harvard.edu, pavel@ucw.cz, marcelo@kvack.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> What about ordering constraints?  A lot of them aren't explicit.  We 
> just depend on the fact that devices get suspended in reverse order of 
> registration.  You can't do that in parallel.

Those constraints should *become* explicit ... not stay implicit!

FWIW the appended patch removes that rude "order of registration"
policy, so that the suspend/resume list matches the device tree.
It's behaved OK on PCs and, in light duty, a few development boards;
I've carried it around most of this year.

I'd expect this to eventually turn up some cases where Linux is
right now doing a bad job of exposing devices with multiple such
ordering constraint ... power management via I2C seems likely to
turn up a few of them.  We'd need some automatic way to detect
and report such problems so that they could be fixed.

- Dave


============= SNIP!
Change how the PM list is constructed, so that devices are added right
after their parents (when they have one) rather than at the end of the
list.  This preserves sequencing guarantees, but enables sequencing of
suspend/resume operations by more important characteristics than "when
device happened to enumerate" ... e.g. clocksources and clockevents
at a clearly defined point during suspend and resume, power management
chips nearer their I2C parent.

This patch has a potential downside for devices that have multiple
power dependencies and which "just happened to work" before.  Or
looking at it the other way around:  a potential upside for devices
that didn't work before.

---
 drivers/base/power/main.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- g26.orig/drivers/base/power/main.c	2007-11-29 20:06:04.000000000 -0800
+++ g26/drivers/base/power/main.c	2007-11-29 20:11:38.000000000 -0800
@@ -40,11 +40,17 @@ int (*platform_enable_wakeup)(struct dev
 
 void device_pm_add(struct device *dev)
 {
-	pr_debug("PM: Adding info for %s:%s\n",
+	struct device *parent = dev->parent;
+
+	pr_debug("PM: Adding info for %s:%s after %s\n",
 		 dev->bus ? dev->bus->name : "No Bus",
-		 kobject_name(&dev->kobj));
+		 kobject_name(&dev->kobj),
+		 parent ? parent->bus_id : "(no parent)");
 	mutex_lock(&dpm_list_mtx);
-	list_add_tail(&dev->power.entry, &dpm_active);
+	if (parent)
+		list_add(&dev->power.entry, &parent->power.entry);
+	else
+		list_add_tail(&dev->power.entry, &dpm_active);
 	mutex_unlock(&dpm_list_mtx);
 }
 
