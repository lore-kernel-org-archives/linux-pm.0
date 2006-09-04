From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Mon, 4 Sep 2006 11:09:48 +0200
Message-ID: <20060904090935.GK9991@elf.ucw.cz>
References: <200609032305.k83N5SP9017385@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200609032305.k83N5SP9017385@olwen.urbana.css.mot.com>
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

Hi!

> | > In the implementation we use, the initial OP is set by the boot
> | > loader. Our kernel power management driver is a module. The assumption
> | > is that booting involves a lot of processing and it makes sense to ju=
st
> | > use the highest OP anyway.  That makes sense in our environment, but I
> | > wouldn't recommend our version as a general solution, anyway.
> | =

> | That's actually regression; cpufreq saves power even while booting.
> ---
> =

> Well, the kernel boot phase is relatively brief. The module could be
> loaded and managing the OP before you start bringing up the rest of user
> space. However, I'm not arguing that our approach to that is generally
> applicable - I was just giving an existence proof.

powernow-k8 machines can't even run in highest OP point on battery
power.

> | > Hmm. I need to think about that. I guess the OP abstraction *could* be
> | > entirely inside the user-space policy manager, with the kernel exposi=
ng
> | > individual interfaces for every parameter that the policy manager wou=
ld
> | > need to adjust. However, that means that the whole mess has to be at
> | > user level (kernel just implements simple knobs for individual
> | > parameters), because the dependency management between the parameters =

> | > would only be known at user level, and means a relatively bulky kernel
> | > interface, since it would expose more things at the interface. =

> | =

> | That would work for me.
> | =

> | But my idea was actually opposite: expose individual knobs to
> | userspace, and then select some operating point (inside kernel) that
> | satisfies given knobs.
> ---
> =

> But then the kernel needs to know about the operating points, so aren't
> you back where we were before?

Yes, it will be similar to your solution, but

a) I'll need not use oppoints on PCs where parameters are independend

and

b) I'll still get reasonable user<->kernel interface.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
