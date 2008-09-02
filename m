From: Oliver Neukum <oneukum@suse.de>
Subject: Re: autosuspend for SCSI devices
Date: Tue, 2 Sep 2008 11:39:15 +0200
Message-ID: <200809021139.16624.oneukum__37262.6715260141$1220348419$gmane$org@suse.de>
References: <20080822105626.GA9475@elf.ucw.cz>
	<200808282317.38703.oneukum@suse.de>
	<20080902090800.GA25178@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080902090800.GA25178@elf.ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: James.Bottomley@hansenpartnership.com, linux-kernel@vger.kernel.org, teheo@novell.com, stefanr@s5r6.in-berlin.de, Martin.Leisner@xerox.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Dienstag 02 September 2008 11:08:00 schrieb Pavel Machek:

Hello!

> > /**
> >  * scsi_block_when_processing_errors - Prevent cmds from being queued.
> >  * @sdev:	Device on which we are performing recovery.
> >  *
> >  * Description:
> >  *     We block until the host is out of error recovery, and then check to
> >  *     see whether the host or the device is offline.
> >  *
> >  * Return value:
> >  *     0 when dev was taken offline by error recovery. 1 OK to proceed.
> >  */
> > int scsi_block_when_processing_errors(struct scsi_device *sdev)
> 
> 
> Hmm, scsi_block_when_ function, which does not _block_, and returns

/**
 * scsi_block_when_processing_errors - Prevent cmds from being queued.
 * @sdev:	Device on which we are performing recovery.
 *
 * Description:
 *     We block until the host is out of error recovery, and then check to
 *     see whether the host or the device is offline.
 *
 * Return value:
 *     0 when dev was taken offline by error recovery. 1 OK to proceed.
 */
int scsi_block_when_processing_errors(struct scsi_device *sdev)
{
	int online;

	wait_event(sdev->host->host_wait, !scsi_host_in_recovery(sdev->host));

This I would expect to block. But it may be unwise to block this long.

	online = scsi_device_online(sdev);

	SCSI_LOG_ERROR_RECOVERY(5, printk("%s: rtn: %d\n", __func__,
					  online));

	return online;
}
> inverted values from what would people expect.
> 
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

Why this? It seems to me for purpose of autosuspend an offlined device
should be totally ignored.

	Regards
		Oliver
