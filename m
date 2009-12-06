From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform
	to	specify exact irq flags
Date: Sun, 6 Dec 2009 09:46:52 +0100
Message-ID: <20091206084652.GB2766__3809.11631878025$1260131235$gmane$org@ucw.cz>
References: <87tywlcbyr.fsf@tac.ki.iif.hu>
	<20091124063711.GL17675@esdhcp04058.research.nokia.com>
	<87my2cp4h6.fsf@tac.ki.iif.hu>
	<20091124170249.GQ17675@esdhcp04058.research.nokia.com>
	<87k4xfojhb.fsf@tac.ki.iif.hu>
	<20091126063506.GM23244@core.coreip.homeip.net>
	<20091127105408.GV17675@esdhcp04058.research.nokia.com>
	<87tywe4zf3.fsf@tac.ki.iif.hu>
	<20091128132742.GC27249@gw.healthdatacare.com>
	<87skbx34ba.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87skbx34ba.fsf@tac.ki.iif.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-pm@lists.linux-foundation.org, ext Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Yeah, that would be nice. But it won't work for us :(
> >
> > This is because the actual input device might be open for several
> > applications. Then we have single process which controls state of
> > the device. Now if, for example the device is locked by user, this
> > process just disables those buttons which are not allowed to wake
> > up the device and blanks the screen.
> >
> > So the input device is still open but we just prevent GPIO lines
> > from generating any interrupts while the device is locked. There
> > are other use-cases also where different buttons are
> > disabled/enabled.
> 
> Hi,
> 
> I thought we'd better ask our friends over at linux-pm, if they've got
> some interface for this task.  To summarize: an embedded application
> wants to go into a "locked" state, where some input devices (gpio keys
> in this case) are "muted", ie. they don't even generate interrupts to
> minimize power consumption.  This could be solved by adding a new
> interface to gpio-keys, but the problem seems more general, so I wonder

Is it so bright idea? How much power does it save?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
