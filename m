From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Make power domain callbacks take
 precedence over subsystem ones
Date: Fri, 15 Apr 2011 10:39:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104151038510.2051-100000__12285.6310605586$1302878467$gmane$org@iolanthe.rowland.org>
References: <201104150112.24722.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104150112.24722.rjw@sisk.pl>
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
Cc: linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 15 Apr 2011, Rafael J. Wysocki wrote:

> On Wednesday, April 13, 2011, Grant Likely wrote:
> > On Wed, Apr 13, 2011 at 8:17 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > On Wed, 13 Apr 2011, Rafael J. Wysocki wrote:
> > >
> > >> From: Rafael J. Wysocki <rjw@sisk.pl>
> > >>
> > >> Change the PM core's behavior related to power domains in such a way
> > >> that, if a power domain is defined for a given device, its callbacks
> > >> will be executed instead of and not in addition to the device
> > >> subsystem's PM callbacks.
> > >>
> > >> The idea behind the initial implementation of power domains handling
> > >> by the PM core was that power domain callbacks would be executed in
> > >> addition to subsystem callbacks, so that it would be possible to
> > >> extend the subsystem callbacks by using power domains.  It turns out,
> > >> however, that this wouldn't be really convenient in some important
> > >> situations.
> > >>
> > >> For example, there are systems in which power can only be removed
> > >> from entire power domains.  On those systems it is not desirable to
> > >> execute device drivers' PM callbacks until it is known that power is
> > >> going to be removed from the devices in question, which means that
> > >> they should be executed by power domain callbacks rather then by
> > >> subsystem (e.g. bus type) PM callbacks, because subsystems generally
> > >> have no information about what devices belong to which power domain.
> > >> Thus, for instance, if the bus type in question is the platform bus
> > >> type, its PM callbacks generally should not be called in addition to
> > >> power domain callbacks, because they run device drivers' callbacks
> > >> unconditionally if defined.
> > >
> > > What about systems where it makes sense to execute the subsystem
> > > callbacks even if power isn't going to be removed from the device?
> > > It's quite possible that the subsystem could reduce the device's power
> > > consumption even when the device isn't powered down completely.
> > 
> > The understanding Rafael and I came to was that if a power domain is
> > attached to a device, then the power domain becomes the responsible
> > party.  Normally this means it will turn around and immediately call
> > the bus_type pm ops, but it has the option to not call them if for a
> > particular system it knows better, or to defer calling them.
> > 
> > Basically, if you're using a power domain, it is assumed that the
> > power domain has particular knowledge about the system, and it should
> > have the option to override the default behaviour.
> > 
> > >
> > > Is the extra overhead of invoking the subsystem callback really all
> > > that troublesome?
> > 
> > It isn't an overhead problem.  It's a control & complexity problem.
> > We could try to implement a heuristic or api to control when the bus
> > type PM ops should be overridden, but I think it is cleaner to make it
> > a rule that if you implement a power domain, then that power domain
> > becomes responsible for all PM operations.
> 
> Well said. :-)
> 
> I'm taking that as an ACK for my patch if you don't mind.

Grant presented a convincing explanation.  I have no objections.

Alan Stern
