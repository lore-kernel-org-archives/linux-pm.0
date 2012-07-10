From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: use of pm_runtime_disable() from driver probe?
Date: Wed, 11 Jul 2012 00:31:06 +0200
Message-ID: <201207110031.06662.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1207101615320.1308-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1207101615320.1308-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@ti.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 10, 2012, Alan Stern wrote:
> On Tue, 10 Jul 2012, Rafael J. Wysocki wrote:
> 
> > > If .probe() enabled runtime PM and called pm_runtime_get_sync() (or _resume),
> > > it can't clean up properly in case of an error, because its
> > > pm_runtime_put_sync() (or _suspend) won't be effective and you're right that
> > > it has to call pm_runtime_disable().
> > > 
> > > So, we don't handle this particular case correctly.
> > > 
> > > I'm not sure what the solution should be, though.  We could remove the
> > > runtime PM operations around really_probe(), but then there may be drivers
> > > assuming that the core will call pm_runtime_put_sync() after .probe()
> > > has returned.
> > 
> > I have an idea.
> > 
> > What about the following patch?  It shouldn't matter except for the cases when
> > .probe() attempts to suspend the device by itself.
> > 
> > ---
> >  drivers/base/dd.c |    7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > Index: linux/drivers/base/dd.c
> > ===================================================================
> > --- linux.orig/drivers/base/dd.c
> > +++ linux/drivers/base/dd.c
> > @@ -356,10 +356,8 @@ int driver_probe_device(struct device_dr
> >  	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
> >  		 drv->bus->name, __func__, dev_name(dev), drv->name);
> >  
> > -	pm_runtime_get_noresume(dev);
> > -	pm_runtime_barrier(dev);
> >  	ret = really_probe(dev, drv);
> > -	pm_runtime_put_sync(dev);
> > +	pm_runtime_idle(dev);
> >  
> >  	return ret;
> >  }
> > @@ -406,9 +404,8 @@ int device_attach(struct device *dev)
> >  			ret = 0;
> >  		}
> >  	} else {
> > -		pm_runtime_get_noresume(dev);
> >  		ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
> > -		pm_runtime_put_sync(dev);
> > +		pm_runtime_idle(dev);
> >  	}
> >  out_unlock:
> >  	device_unlock(dev);
> 
> 
> This opens up the possibility of calling probe while a runtime resume
> or suspend is in progress.  (On the other hand, the existing code
> doesn't prevent a concurrent runtime resume.)  Maybe it would be best
> to leave the pm_runtime_barrier().

That wouldn't close the race, though, because the suspend/resume may still
be started right after _barrier has returned.

The race is only possible if runtime PM is enabled by a subsystem or PM domain
code before the first eligible driver is registered and if that code is not
careful enough to get ready for driver registration.  I'm not sure how likely
it is to happen in practice.

Thanks,
Rafael
