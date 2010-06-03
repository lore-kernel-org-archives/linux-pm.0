From: tytso@mit.edu
Subject: Re: [PATCH] - race-free suspend. Was: Re: [PATCH 0/8]
 Suspend block api (version 8)
Date: Thu, 3 Jun 2010 10:21:50 -0400
Message-ID: <20100603142150.GB13179__34516.9028769762$1275574995$gmane$org@thunk.org>
References: <20100601113309.609349fd@notabene.brown>
	<alpine.LFD.2.00.1006010340160.2933@localhost.localdomain>
	<20100601122012.1edeaf48@notabene.brown>
	<alpine.LFD.2.00.1006011243350.2933@localhost.localdomain>
	<20100602153235.340a7852@notabene.brown>
	<AANLkTikVjAf5nHdMx2bcHRAUSkq99s-b5YZCECXIJJLy@mail.gmail.com>
	<20100602180614.729246ea@notabene.brown>
	<AANLkTikXy__71nBNW0EFbyL_qNf0nQ68pW9KymWlTk7L@mail.gmail.com>
	<20100603163307.721b1c23@notabene.brown>
	<AANLkTikuf6bKVHoGRTjrM_2kPtZqUM6J76Z0hNUQxT_3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikuf6bKVHoGRTjrM_2kPtZqUM6J76Z0hNUQxT_3@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 02, 2010 at 11:43:06PM -0700, Brian Swetland wrote:
> > I guess it becomes an question of economics for you then. =A0Does the c=
ost of
> > whatever user-space changes are required exceed the value of using an u=
pstream
> > kernel? =A0Both the cost and the value would be very hard to estimate in
> > advance. =A0I don't envy you the decision...
> =

> Well, at this point we've invested more engineering hours in the
> various rewrites of this (single) patchset and discussion around it
> than we have spent on rebasing our trees on roughly every other
> mainline release since 2.6.16 or so, across five years of Android
> development.  We think there's some good value to be had (all the
> usual reasons) by heading upstream, so we're still discussing these
> patches and exploring alternatives, but yes, from one way of looking
> at it, it'd certainly be cheaper to just keep maintaining our own
> trees.

And let's be blunt.  If in the future the Android team (which I'm not
a member of) decides that they have invested more engineering time
than they can justify from a business perspective, the next time
someone starts whining on a blog, or on Slashdot, or at a conference,
about how "OMG!  Google is forking the kernel!!!", or "Google is
making the lives of device driver writers for the embedded world
difficult", it will now be possible from a political point of view to
point and the hundreds, if not thousands, of e-mail messages of LKML
developers wanting to redesign this effort and saying "Nyet!  Nyet!
Nyet!" to the original patchset, to point out that Google has a made
an effort, and gone far beyond what is required by the GPL.  Not only
has the source code been made available, but hundreds of engineering
hours have been made trying to accomodate the demands of LKML --- and
LKML has said no to suspend blockers/wakelocks.

Realistically, a company makes decisions about whether to pursue
engineering efforts based on business plans, and this is true whether
the company is Red Hat, or Novell, or IBM, or Google.  One of the
cost/benefits can be things that aren't easily measured such as public
relations.  But past a certain point, it may be that the right answer
is to make a single public appeal to Linus, and if he says no, or if
he ignores the pull request, then the company at hand can say, "We've
done the best that we could, but the Linux developer community, and
Linus specifically, has refused our patch".  And yes, it's all about
PR, but let's not kid ourselves --- the GPL and bad PR can't be used
as blackmail to force a company to invest arbitrarily unlimited
amounts of engineering effort just to satisfy the mandarins of the
LKML and/or Linus.

And if people want to call this a fork, Linus has in the past said
that sometimes forks are healthy, and necessary, and we can see how
things play out in the marketplace.

Disclosure: I work at Google, but I'm not at all involved in the
Android development team, and it's not at all my call when Brian and
his team should make a decision that they've invested more time/energy
than can be justified to their management --- heck, they even roll up
to an completely different VP than I do.  :-)

						- Ted
