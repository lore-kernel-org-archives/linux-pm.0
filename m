From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Mon, 4 Sep 2006 00:41:32 +0200
Message-ID: <20060903224051.GI9991@elf.ucw.cz>
References: <200609032231.k83MV2mX013162@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200609032231.k83MV2mX013162@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Sun 2006-09-03 17:31:02, Scott E. Preece wrote:
> | From: Pavel Machek<pavel@ucw.cz>
> | Cc: <amit.kucheria@nokia.com>, <linux-pm@lists.osdl.org>
> | User-Agent: Mutt/1.5.11+cvs20060126
> | =

> | On Sun 2006-09-03 16:21:34, Scott E. Preece wrote:
> | > | From: Pavel Machek<pavel@ucw.cz>
> | > some reason, in your perception, why definition of operating points
> | > really needs to be in the kernel?  Definition of the operating points,
> | > as opposed to changing from one OP to another, shouldn't have any tim=
ing
> | > issues, so why isn't a privileged user-space manager a reasonable
> | > approach?
> | =

> | For one thing, is not powerop needed for boot? You need to boot in
> | some operating point after all :-).
> ---
> =

> In the implementation we use, the initial OP is set by the boot
> loader. Our kernel power management driver is a module. The assumption
> is that booting involves a lot of processing and it makes sense to just
> use the highest OP anyway.  That makes sense in our environment, but I
> wouldn't recommend our version as a general solution, anyway.

That's actually regression; cpufreq saves power even while booting.

> | > As noted previously, OPs bundle together more than just the
> | > frequency. Those of us supporting the OP model believe that you can't
> | > intelligently change CPU frequency in isolation and you can't change
> | > some of those parameters independently, because only certain
> | > combinations work.
> | =

> | That's okay. User gives you combination he wants, and you select "next
> | higher" working operating point.
> ---
> =

> Hmm. I need to think about that. I guess the OP abstraction *could* be
> entirely inside the user-space policy manager, with the kernel exposing
> individual interfaces for every parameter that the policy manager would
> need to adjust. However, that means that the whole mess has to be at
> user level (kernel just implements simple knobs for individual
> parameters), because the dependency management between the parameters =

> would only be known at user level, and means a relatively bulky kernel
> interface, since it would expose more things at the interface. =


That would work for me.

But my idea was actually opposite: expose individual knobs to
userspace, and then select some operating point (inside kernel) that
satisfies given knobs.

> On the other hand, that complexity has to be somewhere, so maybe that
> would be OK. As I said, I need to think about it...

Looking forward for new interface proposal ;-).

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
