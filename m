From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH] PM: Make it possible to avoid wakeup events
 from being lost
Date: Thu, 1 Jul 2010 17:08:04 +0200
Message-ID: <20100701170804.687d9604__36928.8590307862$1277997539$gmane$org@schatten.dmk.lab>
References: <201006261514.13491.rjw@sisk.pl>
	<20100701133208.GA1285@ucw.cz>
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
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 1 Jul 2010 15:32:08 +0200
Pavel Machek <pavel@ucw.cz> wrote:

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


> I can't say I quite like the way two sysfs files interact with each
> other, but it is certainly better then wakelocks...

What two files? 

Cheers,
Flo 
