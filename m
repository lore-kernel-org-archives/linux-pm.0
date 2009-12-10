From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform
	to	specify exact irq flags
Date: Thu, 10 Dec 2009 11:13:10 +0100
Message-ID: <20091210101310.GE2446__23027.8767216534$1260441749$gmane$org@ucw.cz>
References: <Pine.LNX.4.44L0.0911300956400.4478-100000@iolanthe.rowland.org>
	<87einfltp3.fsf@tac.ki.iif.hu> <20091206084704.GC2766@ucw.cz>
	<20091208042251.GB11147@core.coreip.homeip.net>
	<1260277410.19669.84.camel@localhost>
	<20091208174218.GB14271@core.coreip.homeip.net>
	<1260343860.19669.1189.camel@localhost>
	<20091209180345.GE4456@core.coreip.homeip.net>
	<20091209210816.GD3480@elf.ucw.cz>
	<20091209214841.GE10138@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091209214841.GE10138@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Ferenc Wagner <wferi@niif.hu>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > > Now, there is a issue of waking up userspace task, additional scheduling
> > > > > and keeping CPU running longer than necessary for "uninteresting" keys.
> > > > > This can be solved by implementing a subscription model which allows
> > > > > filtering uninteresing events on a per-client basis at evdev level.
> > > > 
> > > > Right. And for gpio_keys, this would be dine on the driver level.
> > > 
> > > But the semantics are different - if done on driver level you'd be
> > > affecting _all_  consumers of the device; what I want to be done only
> > > affects owner of the file descriptor.
> > 
> > Well, if _all_ consumers decide to ignore some key, we should be able
> > to ignore it at driver level.
> 
> The intesection of drivers allowing shut off individual buttons with
> all consumers agreeing on not using a key would be pretty miniscule.

Well; people want to do that on specialized hw/embedded sw. It could
work there. 

> > And actually it may make some sense -- I do not think disabling irq
> > during runtime is worth the effort, but disabling wakeup source and
> > getting rid of unneccessary wakeup when system is suspended is
> > probably worth it.
> 
> I don't believe Mika's patches touched wakeup in any way. So it has
> been strictly about wakig up processor to service that interrupt so far.

I think it makes sense for wakeups; I doubt it makes sense for runtime
- the power savings are just not big enough.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
