From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC Add in_use attribute] Let the driver know if
	it's in use
Date: Thu, 23 Apr 2009 16:56:51 +0200
Message-ID: <200904231656.51895.rjw@sisk.pl>
References: <20090416131323.GA16752@gandalf.sssup.it>
	<200904212046.45671.rjw@sisk.pl>
	<49F0067F.6050403@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <49F0067F.6050403@gandalf.sssup.it>
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
To: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Cc: len.brown@intel.com, linux-pm@lists.linux-foundation.org, pavel@suse.cz, Greg KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 23 April 2009, Michael Trimarchi wrote:
> Rafael J. Wysocki wrote:
> > On Tuesday 21 April 2009, Michael Trimarchi wrote:
> >   
> >> Rafael J. Wysocki wrote:
> >>     
> >>> On Thursday 16 April 2009, Michael Trimarchi wrote:
> >>>   
> >> Maybe the idea is if the parent is in_use the child are may_inuse so 
> >> they are potentialy in
> >> use. The user can disable a tree and after reanable a child.
> >>     
> >
> > So I'd call the flag subtree_in_use or better subtree_no_suspend, then.
> >   
> If you say just subtree is in use, you have this case:

I didn't mean that.  The suggestion was only to change the _names_ of the
flags, so that 'no_suspend' means "leave this device alone during suspend" and
'subtree_no_suspend' means "you may want to leave this device alone during
suspend, because one of the devices it depends on has no_suspend set".  This
still is a per-device flag, though, so the user space may be allowed to unset
it if there's an interface for that.

> A in_use ---> A1 may_inuse----->A4 may_inuse---- A6 no_in_use
> |              |
> \----> A2      \ --A7 may_inuse ---- A5 no_in_use
> |
> \----> A3
> 
> The user do echo "enabled" > in_use for device A
> 
> A1, A2, A4, A6, A7, A5 go in may_inuse state.
> 
> The user space can check that the device is in_use. it does't know is for
> an in_use or may_inuse condition but it doesnt metter because the user space
> can change for example the A5 and A6 and give the graph above. This is 
> the recursion
> issue.
>
> > Moreover, you don't really have to propagate the no_suspend bit down the
> > device tree when the flag is set for a device.  You can simply modify the
> > prepare phase of suspend to check if the current device's parent has
> > no_suspend or subtree_no_suspend set and to set that for the current device
> > if so (or clear otherwise).
> >   
> If I understand we don't want that this flag change the pm transition.

The idea was that if you wanted to propagate 'no_suspend' down the device
tree from given parent, then you could use the existing suspend code for
that without adding any new code walking the device tree.

Still, if you want the user space to be able to allow the device to suspend
even if, for example, its parent has 'no_suspend' set, then IMO the best
approach would be to require the user space to set 'no_suspend' directly for
each device it doesn't want to suspend, regardless of the dependencies
between the devices.

Thanks,
Rafael
