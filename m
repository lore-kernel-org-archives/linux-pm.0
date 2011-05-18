From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 1/3] PM: Introduce DEVFREQ: generic DVFS
 framework with device-specific OPPs
Date: Wed, 18 May 2011 22:21:26 +0200
Message-ID: <20110518202126.GC8887__25038.1943923005$1305750137$gmane$org@elf.ucw.cz>
References: <1305100723-29161-1-git-send-email-myungjoo.ham@samsung.com>
	<201105180036.03836.rjw@sisk.pl>
	<BANLkTi=_1DJPS+6goLA-UvdHJXEoPWBF2w@mail.gmail.com>
	<201105182202.46820.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201105182202.46820.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Hi!

> > >> +#define dev_dbg_once(dev, fmt, ...)                          \
> > >> +     if (!once) {                                            \
> > >> +             once = 1;                                       \
> > >> +             dev_dbg(dev, pr_fmt(fmt), ##__VA_ARGS__);       \
> > >> +     }
> > >
> > > Why do you need this?
> > >
> > 
> > This devfreq_do is going to be called periodically; thus, I want to
> > print a message if there is an error, but not too many messages with
> > the repeated calls.
> > 
> > Besides, I'd change the macro like this:
> > 
> > #define dev_dbg_once(dev, fmt, ...)                          \
> >      {                                                                \
> >              static int once;                                   \
> >              if (!once) {                                            \
> >                      once = 1;                                       \
> >                      dev_dbg(dev, pr_fmt(fmt), ##__VA_ARGS__);       \
> >              }                                                 \
> >      }
> > 
> > so that "static int once;" in functions can be removed.
> 
> That's a good change in my opinion, but since there is the dynamic debug
> feature, I don't think you need to worry too much about that (the user
> can always disable output from those dev_dbg() statements if they generate
> too much noise).

Well... we do print-once in other places, too. And that way, we can
maybe enable those prints by default...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
