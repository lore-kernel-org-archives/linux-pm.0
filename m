From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [3/3] 2.6.23-rc2: known regressions v2
Date: Mon, 13 Aug 2007 22:56:42 +0200
Message-ID: <20070813205642.GB19688__4506.44037123329$1187038639$gmane$org@uranus.ravnborg.org>
References: <46B9F664.9060600@googlemail.com>
	<6bffcb0e0708130621s74411866mc07446854fb96cd4@mail.gmail.com>
	<20070813183503.GA18722@uranus.ravnborg.org>
	<200708132259.42937.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708132259.42937.rjw@sisk.pl>
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
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Meelis Roos <mroos@linux.ee>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 13, 2007 at 10:59:41PM +0200, Rafael J. Wysocki wrote:
> On Monday, 13 August 2007 20:35, Sam Ravnborg wrote:
> > On Mon, Aug 13, 2007 at 03:21:54PM +0200, Michal Piotrowski wrote:
> > > > >
> > > > > The patch changes the warning to a different warning, it's now
> > > > > kernel/power/Kconfig:79:warning: 'select' used by config symbol 'PM_SLEEP_SMP' refers to undefined symbol 'HOTPLUG_CPU'
> > 
> > So we have something like this for ppc:
> > 
> > config PM_SLEEP_SMP
> > 	bool "bla bla"
> 
> Plus a couple of "depends on ..." here, which cannot be true.
> 
> > 	select HOTPLUG_CPU
> > 
> > As it is not in my -linus tree it has been added by the referanced patch
> > in the text I zapped.
> > 
> > 
> > The warning is generated _independently_ of the actual configuration.
> > All it says is that the symbol PM_SLEEP_SMP has a seelct statement
> > for an unknown symbol - unknown for this architecture at least.
> > 
> > Grepping will reveal that HOTPLUG_CPU is not present for ppc and
> > the easiet fix here seems to just add it like in the following:
> > 
> > diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
> > index 6bdeeb7..e7bcd57 100644
> > --- a/arch/ppc/Kconfig
> > +++ b/arch/ppc/Kconfig
> > @@ -65,6 +65,10 @@ config GENERIC_BUG
> >         default y
> >         depends on BUG
> >  
> > +config HOTPLUG_CPU
> > +       bool
> > +       default n
> > +
> >  source "init/Kconfig"
> >  
> >  menu "Processor"
> > 
> > [cut'n'paste so whitespace damaged...]
> > This will silence the warning...
> > 
> > 
> > Now as PM_SLEEP_SMP requires HOTPLUG_CPU there most be done
> > something else to prevent this config symbol to be selected
> > otherwise we would end up with a kernel that has HOTPLUG_CPU
> > defined even it is not supported.
> 
> Well, the issue at hand is that PM_SLEEP_SMP will never be set on this arch
> and the warning is printed nevertheless.

Yep - because the warnign is correct.
The symbol PM_NEED_SMP refer to an undefined symbol
no matter the case that PM_NEED_SMP can be set or not.

So either provide the symbol or drop the select. It is as simple as that.

	Sam
