From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Make it possible to avoid wakeup events
	from being lost
Date: Thu, 1 Jul 2010 21:02:27 +0200
Message-ID: <201007012102.27495.rjw__42842.4897291281$1278011222$gmane$org@sisk.pl>
References: <201006261514.13491.rjw@sisk.pl> <20100701133208.GA1285@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100701133208.GA1285@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Florian Mickler <florian@mickler.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, July 01, 2010, Pavel Machek wrote:
> Hi!
> 
> > @@ -114,3 +114,17 @@ Description:
> >  		if this file contains "1", which is the default.  It may be
> >  		disabled by writing "0" to this file, in which case all devices
> >  		will be suspended and resumed synchronously.
> > +
> > +What:		/sys/power/wakeup_count
> > +Date:		July 2010
> > +Contact:	Rafael J. Wysocki <rjw@sisk.pl>
> > +Description:
> > +		The /sys/power/wakeup_count file allows user space to avoid
> > +		losing wakeup events when transitioning the system into a sleep
> > +		state.  Reading from it returns the current number of registered
> > +		wakeup events and it blocks if some wakeup events are being
> > +		processed at the time the file is read from.  Writing to it
> > +		will only succeed if the current number of wakeup events is
> > +		equal to the written value and, if successful, will make the
> > +		kernel abort a subsequent transition to a sleep state if any
> > +		wakeup events are reported after the write has returned.
> 
> I assume that second suspend always succeeds?

The mechanism is one-shot if that's what you're asking for.

> I can't say I quite like the way two sysfs files interact with each
> other, but it is certainly better then wakelocks...
> 
> Maybe we should create sys_suspend()?

Well, one can modify pm-utils to use the new sysfs file quite easily, but it
wouldn't be that easy with sys_suspend() IMO.

Rafael
