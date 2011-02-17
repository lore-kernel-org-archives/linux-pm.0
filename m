From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] PM: Make system-wide PM and runtime
	PM handle subsystems consistently
Date: Thu, 17 Feb 2011 23:16:14 +0100
Message-ID: <201102172316.15016.rjw__17248.3052513146$1297981077$gmane$org@sisk.pl>
References: <201102170045.48975.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1102170951330.2153-100000@iolanthe.rowland.org>
	<20110217170441.GA31809@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110217170441.GA31809@kroah.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, February 17, 2011, Greg KH wrote:
> On Thu, Feb 17, 2011 at 09:55:46AM -0500, Alan Stern wrote:
> > On Thu, 17 Feb 2011, Rafael J. Wysocki wrote:
> > 
> > > > > Apart from this I think the order of checks introduced by the $subject patch
> > > > > should be:
> > > > > (1) If dev->class != NULL and dev->class->pm != NULL, use dev->class,
> > > > >     or otherwise
> > > > > (2) if dev->type != NULL and dev->type->pm != NULL, use dev->type,
> > > > >     or otherwise
> > > > > (3) use dev->bus (if present).
> > > > > as that would allow classes and device types to override bus type PM
> > > > > callbacks if they wish to.
> > > > 
> > > > I haven't heard of any device types being present on more than one kind
> > > > of bus, so it makes sense for device types to override bus types.
> > > 
> > > OK
> > > 
> > > > But I'm not so sure about the priority we should give to classes.  On the
> > > > other hand, if no classes define a dev_pm_ops then of course it doesn't
> > > > matter.
> > > 
> > > The change will also affect classes that provide "legacy" suspend-resume
> > > (if there are any, which I'm totally unsure of).
> > > 
> > > Anyway, I think we need to choose one ordering. :-)
> > > 
> > > What about type / bus / class , then?
> > 
> > I really don't know.  Somebody who has more experience with device 
> > class implementations should answer.
> > 
> > Greg, any ideas?
> > 
> > To recap: The issue is how to handle multiple PM callbacks.  Since the
> > bus type, device type, and device class may all have their own
> > callbacks, Rafael has decided the best approach is to prioritize them
> > and invoke only the highest-priority callback.  But what priority order
> > should we use?
> 
> I think we should do it in the following order:
> 	device type
> 	device class
> 	device bus
> 
> for the reasons that a device itself could override the default class
> and bus information if it "knows" it is special.  After that, the class
> of the device holds a lot of information about what is going on with the
> logic involved (i.e. network stuff), and lastly, the bus knows some
> default hardware information.
> 
> Sound reasonable?
> 
> I think that follows the default we have today, right?

No, right now the class goes first during suspend and last during resume (and
of course they all can be called during system suspend/resume now).

That said I'm going to follow your suggestion. :-)

Thanks,
Rafael
