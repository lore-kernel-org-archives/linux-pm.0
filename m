From: Oliver Neukum <oneukum@suse.de>
Subject: Re: autosuspend for SCSI devices
Date: Mon, 25 Aug 2008 10:55:44 +0200
Message-ID: <200808251055.45582.oneukum__18871.4062366218$1219654693$gmane$org@suse.de>
References: <20080822105626.GA9475@elf.ucw.cz> <200808222252.52947.rjw@sisk.pl>
	<20080825081901.GA32128@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080825081901.GA32128@elf.ucw.cz>
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

Am Montag 25 August 2008 10:19:01 schrieb Pavel Machek:
> From: Alan Stern <stern@rowland.harvard.edu>
> 
> Add support for autosuspend/autoresume of the SCSI devices. Lowlevel
> driver can use it to spin the disk down... and it is neccessary step
> for powering down the controllers.
> 
> Spinning down the disk is useful - saves ~0.5W here, and it is last
> major thing we can do to save power on some small machines like
> Kohjinsha subnotebooks.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>

Hi,

firstly, it doesn't consider error handling before suspending.
Secondly, it is simply not true that in SCSI suspending the disks
is always necessary before suspending the controller.

	Regards
		Oliver
