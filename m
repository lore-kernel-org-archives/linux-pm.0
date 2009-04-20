From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC Add in_use attribute] Let the driver know if
	it's in use
Date: Mon, 20 Apr 2009 18:11:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0904201806420.6832-100000@iolanthe.rowland.org>
References: <200904202354.04777.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904202354.04777.rjw@sisk.pl>
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
Cc: len.brown@intel.com, linux-pm@lists.linux-foundation.org, Greg KH <greg@kroah.com>, pavel@suse.cz
List-Id: linux-pm@vger.kernel.org

On Mon, 20 Apr 2009, Rafael J. Wysocki wrote:

> On Thursday 16 April 2009, Michael Trimarchi wrote:
> > Drivers on embedded systems would be smart enough
> > to know that some of the devices should remain powered up, because
> > they could still be useful even when the CPU wasn't running.
> > The patch add the in_use attribute, that it can be used by the
> > the drivers to avoid power down during suspend.
> 
> OK, so the idea is that in_use will be set by the user space for devices that
> shouldn't be suspended.  Is this correct?
> 
> Assuming it is, I'd call the flag 'in_use' rather than 'is_inuse'.  Also, if
> may_inuse is supposed to mean that we can set in_use for this device, I'd call
> it 'in_use_valid', I'd make it be unset by default and I'd allow the driver to
> unset it if it is going to react to 'in_use'.

I don't see why two separate flags are needed.  Why can't there be just 
one?

Also, I don't see why the in_use flag has to propagate down to all the 
descendant devices when it is set.  Why not let userspace be 
responsible for that?

Finally, I don't like either name very much.  This flag is supposed to
indicate that the device is being used in a mode that can run by itself
even when the rest of the system is suspended.  Calling it "in_use" 
doesn't express the crucial fact that the device is self-sufficient.

Alan Stern
