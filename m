From: Oliver Neukum <oneukum@suse.de>
Subject: Re: autosuspend for SCSI devices
Date: Thu, 28 Aug 2008 23:17:37 +0200
Message-ID: <200808282317.38703.oneukum__33290.9313533039$1219958394$gmane$org@suse.de>
References: <20080822105626.GA9475@elf.ucw.cz>
	<200808261301.45167.oneukum@suse.de>
	<20080828080427.GD15474@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080828080427.GD15474@elf.ucw.cz>
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

Am Donnerstag 28 August 2008 10:04:27 schrieb Pavel Machek:
> On Tue 2008-08-26 13:01:43, Oliver Neukum wrote:
> > Am Dienstag 26 August 2008 11:43:55 schrieb Pavel Machek:
> > > > firstly, it doesn't consider error handling before suspending.
> > > 
> > > What problems do you see with error handling? This patch does not
> > > touch the error handling, and I do not think it needs to touch it.
> > 
> > You'd make scsi driver writers' life easier if you made sure no autosuspends
> > happen while they recover from errors. After all, you have no idea which
> > commands will get through while the bus is in disarray.
> 
> Well, they have to handle other commands while bus has problems,
> anyway, right? So I'm not creating any _new_ problems for them. 
> 
> 									Pavel


I am afraid this is not true.

	Regards
		Oliver
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


/**
 * scsi_restart_operations - restart io operations to the specified host.
 * @shost:	Host we are restarting.
 *
 * Notes:
 *    When we entered the error handler, we blocked all further i/o to
 *    this device.  we need to 'reverse' this process.
 */
static void scsi_restart_operations(struct Scsi_Host *shost)
