From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async serio suspend/resume?
Date: Wed, 2 Dec 2009 00:22:59 +0100
Message-ID: <200912020023.00067.rjw@sisk.pl>
References: <200912012355.49050.rjw@sisk.pl>
	<20091201231008.GB20335@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091201231008.GB20335@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 02 December 2009, Dmitry Torokhov wrote:
> Hi Rafael,
> 
> On Tue, Dec 01, 2009 at 11:55:48PM +0100, Rafael J. Wysocki wrote:
> > Hi Dmitry,
> > 
> > Do you think it would be safe to allow serio devices to use the async
> > suspend/resume now?
> > 
> 
> Should be fine now, although I would not enable it in .32. But .33 seems
> like a good target.

The entire async suspend/resume patchset is targeted at .33, so this is all
fine.

So, I guess I can put the appended patch into my linux-next branch?

Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM: Allow serio input devices to suspend/resume asynchronously

Set async_suspend for all serio input devices, so that they can be
suspended and resumed asynchronously with other devices they don't
depend on in a known way (i.e. devices which are not their parents
or children and to which they are not connected via struct pm_link
objects).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/input/serio/serio.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/input/serio/serio.c
===================================================================
--- linux-2.6.orig/drivers/input/serio/serio.c
+++ linux-2.6/drivers/input/serio/serio.c
@@ -576,6 +576,7 @@ static void serio_add_port(struct serio 
 			printk(KERN_ERR
 				"serio: sysfs_create_group() failed for %s (%s), error: %d\n",
 				serio->phys, serio->name, error);
+		device_enable_async_suspend(&serio->dev, true);
 	}
 }
 
