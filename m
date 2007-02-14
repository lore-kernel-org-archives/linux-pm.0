From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 02/12] powermac: support G5 CPU hotplug
Date: Wed, 14 Feb 2007 15:45:56 +0100
Message-ID: <20070214144556.GC25910@elf.ucw.cz>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1170940494.4385.51.camel@johannes.berg>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > Except for the in-irq count hack I'm happy with this. I still haven't f=
ound
> > where the in-hard-irq count is set to 1 in the down path during suspend=
 or
> > resume and other platforms do similar things so I'm inclined to leave t=
his.
> =

> Um, ok, so the hack breaks platforms that don't have paca, e.g. chrp32.
> =

> Also, I finally figured out how the in-hard-irq count happens. The thing
> is that when I try to turn off the CPU it actually doesn't really turn
> off of course, so it ends up doing NAP and taking timer interrupts...
> which goes irq_enter() and we happen to kill it afterwards.
> =

> I have two ways of fixing this:
>  - just ignore it as we do now
>  - insert a "if (cpu_dead) return" into the timer interrupt function
> =

> I prefer the latter because then we're guaranteed that whatever the
> timer interrupt does we don't modify any state for/by the CPU that isn't
> supposed to exist.

Can you disable timer interrupt on the interrupt controller, instead?
Provides same functionality, and needs no runtime overhead...
									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
