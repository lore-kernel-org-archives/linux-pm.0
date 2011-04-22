From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH/RFC] MMC: remove unbalanced
	pm_runtime_suspend()
Date: Fri, 22 Apr 2011 17:20:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104221709030.1791-100000__39534.2953307138$1303507301$gmane$org@iolanthe.rowland.org>
References: <201104222225.24472.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104222225.24472.rjw@sisk.pl>
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
Cc: linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-pm@vger.kernel.org

On Fri, 22 Apr 2011, Rafael J. Wysocki wrote:

> > The barrier would not prevent the race between the notifier and runtie PM
> > from taking place.  Why don't we do something like this instead:
> > 
> > ---
> >  drivers/base/dd.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > Index: linux-2.6/drivers/base/dd.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/base/dd.c
> > +++ linux-2.6/drivers/base/dd.c
> > @@ -326,6 +326,8 @@ static void __device_release_driver(stru
> >  						     BUS_NOTIFY_UNBIND_DRIVER,
> >  						     dev);
> >  
> > +		pm_runtime_put_sync(dev);
> > +
> 
> In fact, I think this one may be _noidle.  If we allow the bus/driver
> to do what they wont, we might as well let them handle the "device idle"
> case from ->remove().

Maybe...  But keeping it put_sync doesn't do any harm.  In Guennadi's 
case, it might allow him to get rid of the pm_runtime_suspend() call in 
the remove routine.

> >  		if (dev->bus && dev->bus->remove)
> >  			dev->bus->remove(dev);
> >  		else if (drv->remove)
> > @@ -338,7 +340,6 @@ static void __device_release_driver(stru
> >  						     BUS_NOTIFY_UNBOUND_DRIVER,
> >  						     dev);
> >  
> > -		pm_runtime_put_sync(dev);
> >  	}
> >  }

Basically this is okay with me, and it should allow Guennadi to avoid
the extra put/get pair.  Do you know if any other subsystems rely on
the usage_count being > 0 during unbinding?

Alan Stern
