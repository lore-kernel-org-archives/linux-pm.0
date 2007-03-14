From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: Alternative Concept
Date: Wed, 14 Mar 2007 20:12:08 +0200
Message-ID: <1173895928.3283.91.camel@Dogbert.NOE.nokia.com>
References: <44ECFF94.3030506@gmail.com>
	<484380240703131930n5e64a8fu9b935b0b513f0731@mail.gmail.com>
	<45F7D1BC.2000700@gmail.com> <200703141019.06641.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200703141019.06641.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 2007-03-14 at 10:19 -0700, ext David Brownell wrote:
> This alternative "concept" would seem to be missing a few essential
> aspects.  Like proposed interfaces, for starters ...
> =

> =

> On Wednesday 14 March 2007 3:43 am, Eugeny S. Mints wrote:
> > > =

> > > Would this involve replacing the clock framework, or are they going t=
o coexist?
> > =

> > parameter framework would eventually replace clock framework.
> =

> That seems to be the wrong answer.  Especially since nothing has
> been shown to be wrong with the clock interface; much less to be
> unfixably wrong (hence justifying replacement).
I think the rationale for choosing to abstract a clock/voltage should be
clarified more.

> > Separate clock and  =

> > voltage frameworks lead to code and functionality duplication and do no=
t address =

> > such things as relationship between clocks and voltages, clock/voltage/=
power =

> > domains, etc needed for aggressive power management.
> =

> Most clocks don't have those issues.  Why penalize all clocks for
> issues which only relate to a few?  Better to only do that for the
> few cocks which have such additional constraints.
Those that have such constraints tend to be very architecture dependant,
so that not much can be generalised or ported easily without having to add
too many levels of indirection.

> Plus, remember that the clock framework is an interface ... so by
> definition, it has no code associated with it.  Hence no duplication
> of code is possible... at least at this hand-wavey "concept" level.
> Possibly a given implementation has scope for code sharing; but I
> doubt it.  Code behind a given implementation of the clock interface
> is invariably quite slim.
> =

> If a clock being enabled implies a power or voltage domain being active,
> there's no reason that constraint shouldn't be enforced by whatever
> implementation a given platform uses.
And that implementation could be highly optimised since it wouldn't care
too much about being portable.

> And having a generic -- basically untyped -- notion of "parameter"
> seems significantly less good than having a typed notion, with
> type-specific operations.  Typed notions are easier to understand,
> read, and maintain.
That sounds like being on the same lines of C vs C++ comments :) or why
not to use typedef struct foo {...} bar

> =

> > Basically a good way of thinking about parameter framework is that para=
meter =

> > framework would start from existed clock framework and gradually evolve=
 by =

> > addressing voltages, relationship between clocks and voltages, domains. =

> > Eventually clock framework functionality would be a part of power param=
eter =

> > framework.
> =

> A better way would be to say that implementions of the clock interface
> on a given platform can build on whatever they need to build.  That might
> include a "parameter" framework, if such a thing were defined in such
> a way that it became useful to such implementations.
> =

But shouldn't it be useful on every platform? As a sort of resource
manager (because that's what it would become if it would start adressing
interdependencies between clocks and voltages).
-- =

Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
