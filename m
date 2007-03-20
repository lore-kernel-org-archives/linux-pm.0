From: David Brownell <david-b@pacbell.net>
Subject: Re: Alternative Concept
Date: Tue, 20 Mar 2007 01:07:16 -0700
Message-ID: <200703200107.17290.david-b@pacbell.net>
References: <44ECFF94.3030506@gmail.com>
	<200703182104.27555.david-b@pacbell.net>
	<45FF24C3.1000203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <45FF24C3.1000203@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Monday 19 March 2007 5:03 pm, Dmitry Krivoschekov wrote:
> David Brownell wrote:
> > On Sunday 18 March 2007 1:25 pm, Dmitry Krivoschekov wrote:
> >>
> >> Sometimes it's quite reasonable to make decisions (or policy)
> >> at the low level, without exposing events to higher layers,
> >
> > Of course.  Any layer can incorporate a degree of policy.
>
> But users should be able to choose to use or do not use the incorporated
> policy, shouldn't they?

Sometimes.  What's a user?  Do you really expect every single
algorithm choice to be packaged as a pluggable policy?  Any
time I've seen systems designed that way, those pluggabilty
hooks have been a major drag on performance and maintainability.

Most components don't actually _need_ a choice of policies.


> > It's only when that's badly done -- or the problem is so complex
> > that multiple policies need to be supported -- that you need to
> > pull out that old "mechanism not policy" chestnut, and support
> > some kind of policy switching mechanism (governors, userspace
> > agents, etc) for different application domains.
> >
> >
> >> e.g. turning a clock off when reference counter gets zero, this is
> >> what OMAP's clock framework currently does.
> >
> > There are no choices to be made in that layer; it's no more "policy"
> > than following the laws of arithmetic is "policy".  Software clock
>
> there is some principle: "turn the clock off when use counter reaches
> zero", so it is a policy, and a choice is to disable or not to disable
> an output clock, it is the simplest case but it's certainly a policy. =


That's not a choice; it's how the API is defined.  It's not "policy".

Arithmetic is defined so that 2 + 2 =3D=3D 4.  Should we have a "policy"
allowing it to =3D=3D 5 instead?  Or should we just accept that as how
things are defined, and move on?

At some point, decisions are just ground rules, and not policy.

- Dave
