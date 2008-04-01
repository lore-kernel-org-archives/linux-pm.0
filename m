From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend
	and	hibernation callbacks (rev. 6)
Date: Wed, 02 Apr 2008 08:35:13 +1100
Message-ID: <1207085713.23143.111.camel__12977.2522756413$1207085823$gmane$org@nigel-laptop>
References: <200803292317.50218.rjw@sisk.pl> <200803312329.03455.rjw@sisk.pl>
	<1207037741.23143.81.camel@nigel-laptop>
	<200804012212.48609.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804012212.48609.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi Rafael etc.

On Tue, 2008-04-01 at 22:12 +0200, Rafael J. Wysocki wrote:
> 'ext' means 'extended'.  The idea is that the 'extended' version will be used
> by bus types / driver types that don't need to implement the _noirq callbacks.
> Both the platform and PCI bus types generally allow drivers to use _noirq
> callbacks, so they use 'struct pm_ext_ops', as well as their corresponding
> driver types.

Do you mean to say in the first sentence "...that _do_ need to
implement..."? If not, then extended sounds like a misnomer and the two
sentences seem to contradict one another.

[...]

> > > + *	However, drivers may NOT assume anything about the availability of the
> > > + *	user space at that time and it is not correct to request firmware from
> > > + *	within @prepare() (it's too late to do that).
> > 
> > That doesn't sound good. It would be good to be able to get drivers to
> > request firmware early in the process.
> 
> That will be possible when we drop the freezer.

Yeah, but right now, it seems to me to be a bogus limitation for drivers
to have no way of automatically loading firmware when you're about to
hibernate. (Of course I've since been reminded of the notifier chain -
that should probably be mentioned here as the way of achieving this).

By the way, I'm going to go on record now as saying I think dropping the
freezer is a silly idea. I'm therefore currently considering including
the freezer in TuxOnice from the time it gets dropped from mainline. I
know that will only make it less likely that TuxOnIce gets merged, but
I've given up caring about that anyway - caring about merging is
pointless when the people who decide if it gets merged don't care.

Regards,

Nigel
