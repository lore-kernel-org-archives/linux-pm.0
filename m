From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Removing dev.power.power_state (WAS: Feature
	Removals for 2.6.25)
Date: Fri, 1 Feb 2008 10:22:03 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802011019370.3839-100000__49195.968049071$1201879442$gmane$org@iolanthe.rowland.org>
References: <200801312128.10700.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801312128.10700.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Harvey.Harrison@gmail.com
List-Id: linux-pm@vger.kernel.org

On Thu, 31 Jan 2008, David Brownell wrote:

> Quoth Harvey Harrison:
> 
> > Ping?
> > What:	dev->power.power_state
> > When:	July 2007
> > Why:	Broken design for runtime control over driver power states, confusing
> > 	driver-internal runtime power management with:  mechanisms to support
> > 	system-wide sleep state transitions; event codes that distinguish
> > 	different phases of swsusp "sleep" transitions; and userspace policy
> > 	inputs.  This framework was never widely used, and most attempts to
> > 	use it were broken.  Drivers should instead be exposing domain-specific
> > 	interfaces either to kernel or to userspace.
> > Who:	Pavel Machek <pavel@suse.cz>
> 
> A lot of the infrastructure using that has already been deleted, and
> there are some incremental improvements pending for 2.6.25:

> But there are still quite a few users left, and a new one was (sigh)
> recently added.

>  - drivers/usb/... has various users, HCDs look easy enough to fix but
>    the other bits will take more thought

>  - drivers/scsi/mesh.c

> I'll probably send in a few more patches for easy stuff in areas
> that I touch semi-frequently, but other folk should fix ATA, IDE,
> SCSI, SERIO, and so forth.  It'd be good if Alan would help fix
> the USB stuff too.  I'm not sure what Pavel's doing there...

I can look at the USB and SCSI stuff.  It shouldn't be all that bad.  
The userspace interface has been gone for quite some time now, and most 
of the remaining uses of that field are write-only.

Alan Stern
