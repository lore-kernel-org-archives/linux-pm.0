From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
 take three
Date: Tue, 17 Aug 2010 15:07:07 +0300
Message-ID: <1282046827.13642.1119.camel@vimes.research.nokia.com>
References: <AANLkTi=RD=eM_gpc7FfRq0923sUbARmZ2+4-m+fLibYC@mail.gmail.com>
	<20100813190801.GB26950@thunk.org>
	<1281746599.16747.11.camel@mulgrave.site>
	<201008162311.27584.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008162311.27584.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "ext Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "david@lang.hm" <david@lang.hm>, "menage@google.com" <menage@google.com>, Ted Ts'o <tytso@mit.edu>, "arjan@infradead.org" <arjan@infradead.org>, "peterz@infradead.org" <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Felipe Contreras <felipe.contreras@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "galibert@pobox.com" <galibert@pobox.com>, "florian@mickler.org" <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "swmike@swm.pp.se" <swmike@swm.pp.se>
List-Id: linux-pm@vger.kernel.org

Hi,
On Mon, 2010-08-16 at 23:11 +0200, ext Rafael J. Wysocki wrote:
> On Saturday, August 14, 2010, James Bottomley wrote:

<snip>

> > > The question, then, is whether a solution which addresses the only
> > > part of the problem which Rafael is interested in dealing with at this
> > > point, is sufficient such that (a) the kernel-level opportunistic
> > > suspend can be done as an out-of-tree patch, while simultaneously (b)
> > > allowing device drivers for Android devices can utilize Rafael's
> > > interfaces to solve the race design bug currently found in our suspend
> > > subsystem, while (c) requiring minimal changes to the Android
> > > userspace, and (d) providing all of the statistics and debugging
> > > functionality required by the Android userspace.
> > > 
> > > If we can engineer a solution which meets (a), (b), (c), and (d)
> > > above, then everyone will be happy.
> > 
> > That's my goal.
> 
> In fact, we (which means basically Alan Stern and me at this point) are working
> with Arve on this right now.

At least for (d) we - Nokia - would be also interested as well to
contribute, see [1].

In general it should help with keeping the solution more generic.

cheers, igor

[1]
https://lists.linux-foundation.org/pipermail/linux-pm/2010-August/028248.html
