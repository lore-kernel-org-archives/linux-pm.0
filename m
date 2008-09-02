From: Pavel Machek <pavel@suse.cz>
Subject: Re: autosuspend for SCSI devices
Date: Tue, 2 Sep 2008 11:08:00 +0200
Message-ID: <20080902090800.GA25178__28760.0184944042$1220347662$gmane$org@elf.ucw.cz>
References: <20080822105626.GA9475@elf.ucw.cz>
	<200808261301.45167.oneukum@suse.de>
	<20080828080427.GD15474@elf.ucw.cz>
	<200808282317.38703.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200808282317.38703.oneukum@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oneukum@suse.de>
Cc: James.Bottomley@hansenpartnership.com, linux-kernel@vger.kernel.org, teheo@novell.com, stefanr@s5r6.in-berlin.de, Martin.Leisner@xerox.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > > firstly, it doesn't consider error handling before suspending.
> > > > 
> > > > What problems do you see with error handling? This patch does not
> > > > touch the error handling, and I do not think it needs to touch it.
> > > 
> > > You'd make scsi driver writers' life easier if you made sure no autosuspends
> > > happen while they recover from errors. After all, you have no idea which
> > > commands will get through while the bus is in disarray.
> > 
> > Well, they have to handle other commands while bus has problems,
> > anyway, right? So I'm not creating any _new_ problems for them. 
> > 
> > 									Pavel
> 
> 
> I am afraid this is not true.

I guess you are right.

> /**
>  * scsi_block_when_processing_errors - Prevent cmds from being queued.
>  * @sdev:	Device on which we are performing recovery.
>  *
>  * Description:
>  *     We block until the host is out of error recovery, and then check to
>  *     see whether the host or the device is offline.
>  *
>  * Return value:
>  *     0 when dev was taken offline by error recovery. 1 OK to proceed.
>  */
> int scsi_block_when_processing_errors(struct scsi_device *sdev)


Hmm, scsi_block_when_ function, which does not _block_, and returns
inverted values from what would people expect.

...but this should fix it, no? [incremental to previous]
									Pavel

diff --git a/drivers/scsi/scsi_pm.c b/drivers/scsi/scsi_pm.c
index 3c184fe..7e5ea0d 100644
--- a/drivers/scsi/scsi_pm.c
+++ b/drivers/scsi/scsi_pm.c
@@ -10,6 +10,7 @@ #define DEBUG
 #include <scsi/scsi.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_eh.h>
 
 #include <linux/delay.h>
 
@@ -128,8 +129,11 @@ static int autosuspend_check(struct scsi
 	if (!(sdev->sdev_state == SDEV_RUNNING ||
 			sdev->sdev_state == SDEV_QUIESCE))
 		return -ENODEV;
+	if (!scsi_block_when_processing_errors(sdev))
+		return -EBUSY;
 
 	suspend_time = sdev->last_busy + sdev->autosuspend_delay;
+	/* FIXME: what if suspend_time - jiffies == -EPERM by some strange chance */
 	if (time_before(jiffies, suspend_time))
 		return suspend_time - jiffies;
 	return 0;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
