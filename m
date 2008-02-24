From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Bug 10030] Suspend doesn't work when SD card is
 inserted
Date: Sat, 23 Feb 2008 23:26:35 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802232240530.29968-100000__16869.5456850857$1203827407$gmane$org@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0802232143050.29968-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0802232143050.29968-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>, Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sat, 23 Feb 2008, Alan Stern wrote:

> It happened in a workqueue.  There could be lots of similar cases: Some 
> interrupt-driven event causes a hotplug action.  Since the action can't 
> be carried out in interrupt context, the driver has no choice but to 
> defer it to a workqueue or kernel thread.  Blocking that workqueue or 
> kernel thread won't cause a problem _unless_ the driver's 
> suspend/resume methods try to synchronize with it.  That's the 
> difficult case.

In fact this turns out to be exactly the problem with the MMC
subsystem.  It uses a dedicated workqueue (kmmcd) to handle state
changes, and mmc_suspend_host() does a flush_workqueue().  If the
workqueue contains an entry to register or unregister a device, this is
guaranteed to deadlock -- and that's exactly what happens when Zdenek 
inserts or removes a card during the disk-drive spindown time of a 
system sleep.

It looks like the best solution is for mmc_suspend_host() not to flush
the workqueue; instead the workqueue should prevent itself from
running during a suspend.  Right now the easiest way to accomplish this
is for the workqueue routines (mmc_detect() and siblings) to acquire
the mmc_host's device semaphore.  If in the future the MMC subsystem
adds dynamic PM support then a more complicated arrangement will be 
needed.

So the patch below, in combination with the previous patch, might just 
fix the whole problem.

Alan Stern



Index: usb-2.6/drivers/mmc/core/core.c
===================================================================
--- usb-2.6.orig/drivers/mmc/core/core.c
+++ usb-2.6/drivers/mmc/core/core.c
@@ -731,8 +731,6 @@ void mmc_stop_host(struct mmc_host *host
  */
 int mmc_suspend_host(struct mmc_host *host, pm_message_t state)
 {
-	mmc_flush_scheduled_work();
-
 	mmc_bus_get(host);
 	if (host->bus_ops && !host->bus_dead) {
 		if (host->bus_ops->suspend)
Index: usb-2.6/drivers/mmc/core/mmc.c
===================================================================
--- usb-2.6.orig/drivers/mmc/core/mmc.c
+++ usb-2.6/drivers/mmc/core/mmc.c
@@ -441,6 +441,7 @@ static void mmc_detect(struct mmc_host *
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
+	down(&mmc_classdev(host)->sem);
 	mmc_claim_host(host);
 
 	/*
@@ -449,6 +450,7 @@ static void mmc_detect(struct mmc_host *
 	err = mmc_send_status(host->card, NULL);
 
 	mmc_release_host(host);
+	up(&mmc_classdev(host)->sem);
 
 	if (err) {
 		mmc_remove(host);
Index: usb-2.6/drivers/mmc/core/sd.c
===================================================================
--- usb-2.6.orig/drivers/mmc/core/sd.c
+++ usb-2.6/drivers/mmc/core/sd.c
@@ -500,6 +500,7 @@ static void mmc_sd_detect(struct mmc_hos
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
+	down(&mmc_classdev(host)->sem);
 	mmc_claim_host(host);
 
 	/*
@@ -508,6 +509,7 @@ static void mmc_sd_detect(struct mmc_hos
 	err = mmc_send_status(host->card, NULL);
 
 	mmc_release_host(host);
+	up(&mmc_classdev(host)->sem);
 
 	if (err) {
 		mmc_sd_remove(host);
Index: usb-2.6/drivers/mmc/core/sdio.c
===================================================================
--- usb-2.6.orig/drivers/mmc/core/sdio.c
+++ usb-2.6/drivers/mmc/core/sdio.c
@@ -195,6 +195,7 @@ static void mmc_sdio_detect(struct mmc_h
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
+	down(&mmc_classdev(host)->sem);
 	mmc_claim_host(host);
 
 	/*
@@ -203,6 +204,7 @@ static void mmc_sdio_detect(struct mmc_h
 	err = mmc_select_card(host->card);
 
 	mmc_release_host(host);
+	up(&mmc_classdev(host)->sem);
 
 	if (err) {
 		mmc_sdio_remove(host);
