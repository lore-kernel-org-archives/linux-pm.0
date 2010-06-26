From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Make it possible to avoid wakeup events
 from being lost
Date: Sat, 26 Jun 2010 15:58:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006261550400.24010-100000__32157.3629430079$1277582373$gmane$org@netrider.rowland.org>
References: <201006262021.42966.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006262021.42966.rjw@sisk.pl>
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
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 26 Jun 2010, Rafael J. Wysocki wrote:

> On Saturday, June 26, 2010, Alan Stern wrote:
> > On Sat, 26 Jun 2010, David Brownell wrote:
> ... 
> > > > +        The
> > > > /sys/power/wakeup_count file allows user space to avoid
> > > > +        losing wakeup events
> > > > when transitioning the system into a sleep
> > > > +        state.  Reading
> > 
> > This could have been phrased better:  The /sys/power/wakeup_count file
> > allows user space to put the system into a sleep state conditionally
> > subject to the arrival of concurrent wakeup events, which will either
> > block the sleep transition or cause it to fail.
> 
> I'll chage this in the final version.  Thanks!

Even this should be simplified, if possible.  Maybe something like: ...  
put the system into a sleep state while taking into account the
concurrent arrival of wakeup events ...

I tried to put the word "reliably" in there, but it didn't seem to fit.  
After all, the current /sys/power/state is already very reliable about 
putting the system to sleep!

Alan Stern
