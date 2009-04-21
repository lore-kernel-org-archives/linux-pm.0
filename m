From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC Add in_use attribute] Let the driver know if
	it's in use
Date: Tue, 21 Apr 2009 20:30:56 +0200
Message-ID: <200904212030.57316.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0904201806420.6832-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0904201806420.6832-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>, Michael Trimarchi <trimarchi@gandalf.sssup.it>
Cc: len.brown@intel.com, linux-pm@lists.linux-foundation.org, pavel@suse.cz, Greg KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 21 April 2009, Alan Stern wrote:
> On Mon, 20 Apr 2009, Rafael J. Wysocki wrote:
> 
> > On Thursday 16 April 2009, Michael Trimarchi wrote:
> > > Drivers on embedded systems would be smart enough
> > > to know that some of the devices should remain powered up, because
> > > they could still be useful even when the CPU wasn't running.
> > > The patch add the in_use attribute, that it can be used by the
> > > the drivers to avoid power down during suspend.
> > 
> > OK, so the idea is that in_use will be set by the user space for devices that
> > shouldn't be suspended.  Is this correct?
> > 
> > Assuming it is, I'd call the flag 'in_use' rather than 'is_inuse'.  Also, if
> > may_inuse is supposed to mean that we can set in_use for this device, I'd call
> > it 'in_use_valid', I'd make it be unset by default and I'd allow the driver to
> > unset it if it is going to react to 'in_use'.
> 
> I don't see why two separate flags are needed.  Why can't there be just 
> one?

There could be one, but since the core would handle the sysfs attribute
associated with it, the second flag would be useful to indicate to the core
whether or not the attribute should be available at all.

> Also, I don't see why the in_use flag has to propagate down to all the 
> descendant devices when it is set.  Why not let userspace be 
> responsible for that?

Agreed.

Michael, would it be a problem if the user space were responsible for
setting the flag for all devices that shouldn't be suspended?

> Finally, I don't like either name very much.  This flag is supposed to
> indicate that the device is being used in a mode that can run by itself
> even when the rest of the system is suspended.  Calling it "in_use" 
> doesn't express the crucial fact that the device is self-sufficient.

You're rignt, it would be better to call it something like 'no_suspend'.

Thanks,
Rafael
