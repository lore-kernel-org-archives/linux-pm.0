From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 2/2] PM: Make system-wide PM and runtime
 PM handle subsystems consistently
Date: Thu, 17 Feb 2011 09:55:46 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102170951330.2153-100000__28128.1676296659$1297954709$gmane$org@iolanthe.rowland.org>
References: <201102170045.48975.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102170045.48975.rjw@sisk.pl>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 17 Feb 2011, Rafael J. Wysocki wrote:

> > > Apart from this I think the order of checks introduced by the $subject patch
> > > should be:
> > > (1) If dev->class != NULL and dev->class->pm != NULL, use dev->class,
> > >     or otherwise
> > > (2) if dev->type != NULL and dev->type->pm != NULL, use dev->type,
> > >     or otherwise
> > > (3) use dev->bus (if present).
> > > as that would allow classes and device types to override bus type PM
> > > callbacks if they wish to.
> > 
> > I haven't heard of any device types being present on more than one kind
> > of bus, so it makes sense for device types to override bus types.
> 
> OK
> 
> > But I'm not so sure about the priority we should give to classes.  On the
> > other hand, if no classes define a dev_pm_ops then of course it doesn't
> > matter.
> 
> The change will also affect classes that provide "legacy" suspend-resume
> (if there are any, which I'm totally unsure of).
> 
> Anyway, I think we need to choose one ordering. :-)
> 
> What about type / bus / class , then?

I really don't know.  Somebody who has more experience with device 
class implementations should answer.

Greg, any ideas?

To recap: The issue is how to handle multiple PM callbacks.  Since the
bus type, device type, and device class may all have their own
callbacks, Rafael has decided the best approach is to prioritize them
and invoke only the highest-priority callback.  But what priority order
should we use?

Alan Stern
