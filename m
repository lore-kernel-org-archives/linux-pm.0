From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Do not create wakeup sysfs files for
	devices that cannot wake up (v2)
Date: Sun, 6 Feb 2011 21:03:11 +0100
Message-ID: <201102062103.12139.rjw__3216.04935820705$1297022683$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1102061024150.20379-100000@netrider.rowland.org>
	<201102061953.17433.rjw@sisk.pl> <20110206191421.GB7818@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110206191421.GB7818@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, February 06, 2011, Greg KH wrote:
> On Sun, Feb 06, 2011 at 07:53:17PM +0100, Rafael J. Wysocki wrote:
> > On Sunday, February 06, 2011, Alan Stern wrote:
> > > On Sun, 6 Feb 2011, Rafael J. Wysocki wrote:
> > > 
> > > > Hi,
> > > > 
> > > > Below is the next version of the patch changing the PM core to only create
> > > > wakeup sysfs files for devices that are wakeup-capable.  It contains a change
> > > > in drivers/usb/core/hub.c that should avoid the problem described in the thread
> > > > at https://lkml.org/lkml/2011/2/5/108 , but I'm not 100% it's the right
> > > > approach.  Please have a look.
> > > 
> > > Yes, that's right -- in fact, it's exactly the same as what I was going
> > > to do.  Of course, it should be separated out into a separate patch, to
> > > be applied before the other wakeup changes.
> > 
> > OK, I'll split it out.
> > 
> > Greg, any objections to me putting the change below into the suspend tree as
> > a separate commit:
> 
> No objection from me at all:
> 	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

Thanks!

Rafael
