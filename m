From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: A unresponsive file system can hang all I/O in
	the system on linux-2.6.23-rc6 (dirty_thresh problem?)
Date: Fri, 28 Sep 2007 12:45:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0709281244250.4336-100000__47063.5727434002$1190998031$gmane$org@iolanthe.rowland.org>
References: <1190986542.13204.10.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1190986542.13204.10.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Chakri n <chakriin5@gmail.com>, Jonathan Corbet <corbet@lwn.net>, lkml <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 28 Sep 2007, Peter Zijlstra wrote:

> On Fri, 2007-09-28 at 07:28 -0600, Jonathan Corbet wrote:

> > Is it really NFS-related?  I was trying to back up my 2.6.23-rc8 system
> > to an external USB drive the other day when something flaked and the
> > drive fell off the bus.  That, too, was sufficient to wedge the entire
> > system, even though the only thing which needed the dead drive was one
> > rsync process.  It's kind of a bummer to have to hit the reset button
> > after the failure of (what should be) a non-critical piece of hardware.
> > 
> > Not that I have a fix to propose...:)
> 
> the per bdi work in -mm should make the system not drop dead.
> 
> Still, would a remove,re-insert of the usb media end up with the same
> bdi? That is, would it recognise as the same and resume the transfer.

Removal and replacement of the media might work.  I have never tried 
it.

But Jon described removal of the device, not the media.  Replacing the 
device definitely will not work.

Alan Stern
