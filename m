From: Greg KH <greg@kroah.com>
Subject: Re: [RFC Add in_use attribute] Let the driver know if
	it's in use
Date: Tue, 21 Apr 2009 14:55:00 -0700
Message-ID: <20090421215500.GA10343@kroah.com>
References: <200904202354.04777.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0904201806420.6832-100000@iolanthe.rowland.org>
	<20090420221518.GA28499@kroah.com> <200904212033.02035.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200904212033.02035.rjw@sisk.pl>
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
Cc: len.brown@intel.com, linux-pm@lists.linux-foundation.org, pavel@suse.cz
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 21, 2009 at 08:33:01PM +0200, Rafael J. Wysocki wrote:
> On Tuesday 21 April 2009, Greg KH wrote:
> > 
> > I seem to not have seen the original post about this, thanks Alan for
> > adding me to the cc:
> > 
> > On Mon, Apr 20, 2009 at 06:11:18PM -0400, Alan Stern wrote:
> > > On Mon, 20 Apr 2009, Rafael J. Wysocki wrote:
> > > 
> > > > On Thursday 16 April 2009, Michael Trimarchi wrote:
> > > > > Drivers on embedded systems would be smart enough
> > > > > to know that some of the devices should remain powered up, because
> > > > > they could still be useful even when the CPU wasn't running.
> > > > > The patch add the in_use attribute, that it can be used by the
> > > > > the drivers to avoid power down during suspend.
> > 
> > I'm confused, why would a driver not know if it was in use or not?
> > Actually, how would it not know already by virtue of what is happening
> > within it (io in flight, buttons being pushed, dma streaming, etc.)?
> > 
> > > > OK, so the idea is that in_use will be set by the user space for devices that
> > > > shouldn't be suspended.  Is this correct?
> > 
> > So userspace knows better than the kernel as to if a specific driver is
> > being used at the moment?  Why is this so?
> 
> The name of the flag is not the best one. :-)
> 
> The flag is supposed to mean "don't suspend this device during system-wide
> suspend, because it's being used for something you may be unaware of".
> AFAICS.

Then it needs to be changed, as it is not obvious at all what is going
on here.  Your "no_suspend" suggestion would be good.

thanks,

greg k-h
