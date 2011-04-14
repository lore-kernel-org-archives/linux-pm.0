From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Make power domain callbacks take
	precedence over subsystem ones
Date: Fri, 15 Apr 2011 00:45:54 +0200
Message-ID: <201104150045.54904.rjw__26257.2074578658$1302822588$gmane$org@sisk.pl>
References: <201104130205.26988.rjw@sisk.pl>
	<BANLkTimQ6kX41-53Dw2RqEVyYzbT2qbz9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTimQ6kX41-53Dw2RqEVyYzbT2qbz9Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, April 14, 2011, Magnus Damm wrote:
> Hi Rafael,
> 
> On Wed, Apr 13, 2011 at 9:05 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Change the PM core's behavior related to power domains in such a way
> > that, if a power domain is defined for a given device, its callbacks
> > will be executed instead of and not in addition to the device
> > subsystem's PM callbacks.
> 
> Thanks for your work on this! I'm very happy to see a more fine
> grained interface for SoC specific code compared to the weak symbols
> and other coarse grained alternatives for the platform bus.
> 
> My only thought on this is if we really want to limit ourselves to
> only control power domains using these callbacks. I can imagine that
> some SoCs want to do other non-power domain specific operations with
> these callbacks, and if so, perhaps using the term power domain as
> name of the pointer in struct device would be somewhat odd. OTOH, I
> really dislike naming discussions in general and I can't really think
> of any good names. So it all looks more like a set of system specific
> PM override hooks.
> 
> Or is there something that is really power domain specific with these hooks?

Not in principle, but I think there is.  Namely, if there are two groups
of devices belonging to the same bus type (e.g. platform) that each require
different PM handling, it is legitimate to call them "power domains" (where
"domain" means "a set of devices related to each other because of the way
they need to be handled"), even if they don't share power resources.

Of course, if they do share power resources, the term is just right. :-)

Thanks,
Rafael
