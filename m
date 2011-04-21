From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH/RFC] MMC: remove unbalanced
	pm_runtime_suspend()
Date: Fri, 22 Apr 2011 00:06:09 +0200
Message-ID: <201104220006.09982.rjw__25457.7387044721$1303423676$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1104211741090.1939-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1104211741090.1939-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-pm@vger.kernel.org

On Thursday, April 21, 2011, Alan Stern wrote:
> On Thu, 21 Apr 2011, Rafael J. Wysocki wrote:
> 
> > > > If we choose this approach, then yes, we should provide a suitable API, but
> > > > I'm still thinking it would be simpler to move the pm_runtime_put_sync() before driver_sysfs_remove() and make the rule as I said previously. :-)
> > > 
> > > The problem is synchronization.  At what point is the driver supposed 
> > > to stop queuing runtime PM requests?  It would have to be sometime 
> > > before the pm_runtime_barrier() call.  How is the driver supposed to 
> > > know when that point is reached?  The remove routine isn't called until 
> > > later.
> > 
> > Executing the driver's callback is not an ideal solution either, because
> > it simply may be insufficient (it may be necessary to execute the power
> > domain and/or subsystem callbacks, pretty much what rpm_suspend() does,
> > but without taking the usage counter into consideration).
> 
> That's why I suggested a new API.  It could do the right callbacks.
> 
> > Moreover,  if we want the driver's ->remove() to do the cleanup anyway,
> > there's not much point in doing any cleanup before in the core.  Also,
> > there's a little problem that the bus ->remove() is called before the
> > driver's ->remove(), so it may not be entirely possible to power down
> > the device when the driver's ->remove() is called already.
> 
> Actually, the bus->remove() callback (if there is one) is responsible
> for invoking the driver's callback.

Ah, sorry, I misread the code in __device_release_driver() (too little
coffee perhaps).

> The subsystem should be smart enough to handle runtime PM requests while
> the driver's remove callback is running.

If we make such a rule, we may as well remove all of the runtime PM
calls from __device_release_driver().
 
> > I think the current code is better than any of the alternatives considered
> > so far.
> 
> Then you think Guennadi should leave his patch as it is, including the 
> "reversed" put/get?

This, or we need to remove the runtime PM calls from __device_release_driver().

I'm a bit worried about the driver_sysfs_remove() and the bus notifier that
in theory may affect the runtime PM callbacks potentially executed before
->remove() is called.

Rafael
