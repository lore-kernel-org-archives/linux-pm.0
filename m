From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Sun, 3 Sep 2006 23:43:40 +0200
Message-ID: <20060903214340.GC9991@elf.ucw.cz>
References: <200609032134.k83LYk3G006249@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200609032134.k83LYk3G006249@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
Cc: scott.preece@motorola.com, matthew.a.locke@comcast.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> | > > That depends on the definition, but I think of suspend states as th=
e ones
> | > > that require processes to be frozen before they can be entered.  IM=
HO it is
> | > > quite clear that such states cannot be handled in the same way as t=
hose
> | > > that do not require the freezing of processes, so they are not the =
same.
> | > =

> | > You are correct, processes do need to be frozen before a suspend.
> | > That's the prepare to suspend part of the suspend process, and
> | > the transtition is the suspending and finish is the un-freezing
> | > of the processes to resume execution.
> | > =

> | > And those same steps are the same steps required to transition the
> | > system to a new operating point, whether it's suspend or change
> | > from 1.4GHz to 600MHz.
> | =

> | There are only a few states that require the processes to be frozen and=
 I
> | think that's a good enough reason to handle them separately.
> =

> ---
> =

> But, surely that distinction can be handled in the implementation behind
> the interface, rather than exsposed in the interface.  Does that
> distinction matter to the policy manager?  I would argue that it
> increases the latency, which would be important to the policy manager,
> but that the nature of the latency isn't important to making a policy
> decision,  and the proposed interface already exposes the latency as
> something that can be used in making transition decisions.

Are we talking about the same thing?

If policy manager decides to suspend-to-RAM, it will freeze
itself. Puff, it is not running any more.

Yes, it is important that interfaces are different. Would you argue
for using same interface for slowing down machine and for turning
machine off?

And suspend-to-disk *is* turning machine off.

Of course, we could use same interface for both. No, it is not good
idea. We want reasonably clean interface. If it means rewriting
powerop two or three times... we'll need to do it.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
