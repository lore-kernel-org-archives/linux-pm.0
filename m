From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH update x2] PM: Introduce core framework for
 run-time PM of I/O devices (rev. 13)
Date: Sat, 8 Aug 2009 22:28:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908082219380.27004-100000__17915.4124264189$1249784994$gmane$org@netrider.rowland.org>
References: <200908082355.32749.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908082355.32749.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 8 Aug 2009, Rafael J. Wysocki wrote:

> > The problem with this is that it calls pm_runtime_disable() at a time 
> > when the driver is still supposed to be in control of the device.  
> > Interfering with the driver's legitimate activity in this way is a bad 
> > thing to do.
> > 
> > The difficulty here is that our requirements are a little
> > contradictory.  We want to prevent all runtime PM callbacks while the
> > remove method is running, but we also want the remove method to be able
> > to carry out its own runtime PM activities.
> > 
> > So maybe what we really need is more like a barrier.  That is,
> > something that will do a "get", wait for outstanding callbacks to
> > finish, carry out a resume if one is pending, and cancel other pending
> > requests.  This could easily share code with pm_runtime_disable.  We 
> > should be able to use this for both probe and remove.
> 
> Isn't it what's done in rev. 14?
> 
> pm_runtime_disable(dev);
> pm_runtime_get_noresume(dev);
> pm_runtime_enable(dev);
> 
> is exactly a barrier like this.

It's not exactly the same because it disables runtime PM for a short 
time.  A barrier never disables runtime PM.

>  How exactly would you like to implement it
> instead?

As described above.  The barrier would be equivalent to
pm_runtime_get_noresume followed by pm_runtime_disable except that it
wouldn't actually disable anything.

> > Perhaps this means we don't want to disable runtime PM during system
> > sleep callbacks, but instead use the "barrier" scheme.
> 
> I'm not really sure about that.  I'd rather do what's right now in the patch
> (well, that's why it's in there) until drivers and bus types start using the
> runtime PM framework.  If it turns out to be problematic, we'll change it
> later.

All right.  Since it involves a race, the problem may not show up for a
while.

Alan Stern
