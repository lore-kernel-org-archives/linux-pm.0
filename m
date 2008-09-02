From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: autosuspend for SCSI devices
Date: Tue, 2 Sep 2008 10:04:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0809020957320.2489-100000__30862.639056477$1220364860$gmane$org@iolanthe.rowland.org>
References: <20080902090800.GA25178@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080902090800.GA25178@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: Oliver Neukum <oneukum@suse.de>, linux-kernel@vger.kernel.org, teheo@novell.com, James.Bottomley@hansenpartnership.com, stefanr@s5r6.in-berlin.de, Martin.Leisner@xerox.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2 Sep 2008, Pavel Machek wrote:

> > > > You'd make scsi driver writers' life easier if you made sure no autosuspends
> > > > happen while they recover from errors. After all, you have no idea which
> > > > commands will get through while the bus is in disarray.
> > > 
> > > Well, they have to handle other commands while bus has problems,
> > > anyway, right? So I'm not creating any _new_ problems for them. 
> > > 
> > > 									Pavel
> > 
> > 
> > I am afraid this is not true.
> 
> I guess you are right.

> ...but this should fix it, no? [incremental to previous]
> 									Pavel
> 
> diff --git a/drivers/scsi/scsi_pm.c b/drivers/scsi/scsi_pm.c
> index 3c184fe..7e5ea0d 100644
> --- a/drivers/scsi/scsi_pm.c
> +++ b/drivers/scsi/scsi_pm.c
> @@ -10,6 +10,7 @@ #define DEBUG
>  #include <scsi/scsi.h>
>  #include <scsi/scsi_device.h>
>  #include <scsi/scsi_host.h>
> +#include <scsi/scsi_eh.h>
>  
>  #include <linux/delay.h>
>  
> @@ -128,8 +129,11 @@ static int autosuspend_check(struct scsi
>  	if (!(sdev->sdev_state == SDEV_RUNNING ||
>  			sdev->sdev_state == SDEV_QUIESCE))
>  		return -ENODEV;
> +	if (!scsi_block_when_processing_errors(sdev))
> +		return -EBUSY;
>  
>  	suspend_time = sdev->last_busy + sdev->autosuspend_delay;
> +	/* FIXME: what if suspend_time - jiffies == -EPERM by some strange chance */
>  	if (time_before(jiffies, suspend_time))
>  		return suspend_time - jiffies;
>  	return 0;

If I'm not mistaken, while error hanlding is in progress we always have 
shost->shost_state equal to either SHOST_RECOVERY or 
SHOST_CANCEL_RECOVERY.  This is a better test to use.

Alan Stern
