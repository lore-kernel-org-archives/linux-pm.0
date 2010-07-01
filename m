From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [update] Re: [PATCH] PM: Make it possible to avoid
	wakeup events from being lost
Date: Thu, 1 Jul 2010 23:05:31 +0200
Message-ID: <201007012305.31380.rjw__12675.9507380941$1278018550$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1007011627030.1303-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1007011627030.1303-100000@iolanthe.rowland.org>
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
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, July 01, 2010, Alan Stern wrote:
> On Thu, 1 Jul 2010, Rafael J. Wysocki wrote:
> 
> > > > +	if (msec) {
> > > > +		ktime_t kt;
> > > > +		struct timespec ts;
> > > > +		unsigned long expires;
> > > > +
> > > > +		kt = ktime_get();
> > > > +		kt = ktime_add_ns(kt, msec * NSEC_PER_MSEC);
> > > > +		ts = ktime_to_timespec(kt);
> > > > +		expires = timespec_to_jiffies(&ts);
> > > 
> > > Is this somehow better than jiffies + msecs_to_jiffies(msec)?
> > 
> > I'm not sure about overflows.  That said, the "+" version is used in many
> > places, so there's no problem I think.
> 
> Hmm.  NSEC_PER_MSEC must be one million, right?  So if msec referred to
> anything above 4 seconds (which seems unlikely but not impossible), the
> multiplication would overflow on a 32-bit machine.
> 
> Apart from that, the main difference between the two patches lies in
> when the events are counted, i.e., whether event_count gets incremented
> at the start or when the timer expires.  I can't see that it matters 
> much either way.

Well, your version doesn't require the additional static variable and
generally takes fewer lines of code. :-)

> > Index: linux-2.6/drivers/base/power/wakeup.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/base/power/wakeup.c
> > +++ linux-2.6/drivers/base/power/wakeup.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/device.h>
> >  #include <linux/slab.h>
> >  #include <linux/sched.h>
> > +#include <linux/ktime.h>
> 
> This isn't needed any more.

Right, I've dropped this line.

Rafael
