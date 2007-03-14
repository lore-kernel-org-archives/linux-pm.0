From: David Brownell <david-b@pacbell.net>
Subject: Re: Alternative Concept
Date: Wed, 14 Mar 2007 11:45:04 -0700
Message-ID: <200703141145.05471.david-b@pacbell.net>
References: <44ECFF94.3030506@gmail.com>
	<200703141019.06641.david-b@pacbell.net>
	<1173895928.3283.91.camel@Dogbert.NOE.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1173895928.3283.91.camel@Dogbert.NOE.nokia.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

On Wednesday 14 March 2007 11:12 am, Igor Stoppa wrote:
> On Wed, 2007-03-14 at 10:19 -0700, ext David Brownell wrote:
> > This alternative "concept" would seem to be missing a few essential
> > aspects.  Like proposed interfaces, for starters ...
> > =

> > =

> > On Wednesday 14 March 2007 3:43 am, Eugeny S. Mints wrote:
> > > > =

> > > > Would this involve replacing the clock framework, or are they going=
 to coexist?
> > > =

> > > parameter framework would eventually replace clock framework.
> > =

> > That seems to be the wrong answer.  Especially since nothing has
> > been shown to be wrong with the clock interface; much less to be
> > unfixably wrong (hence justifying replacement).
>
> I think the rationale for choosing to abstract a clock/voltage should be
> clarified more.

That is, a rationale for abstracting both into "power resource"
so that the difference is not inherent in variable typing?


> > > Separate clock and  =

> > > voltage frameworks lead to code and functionality duplication and do =
not address =

> > > such things as relationship between clocks and voltages, clock/voltag=
e/power =

> > > domains, etc needed for aggressive power management.
> > =

> > Most clocks don't have those issues.  Why penalize all clocks for
> > issues which only relate to a few?  Better to only do that for the
> > few clocks which have such additional constraints.
>
> Those that have such constraints tend to be very architecture dependant,
> so that not much can be generalised or ported easily without having to add
> too many levels of indirection.

Right.

 =

> > Plus, remember that the clock framework is an interface ... so by
> > definition, it has no code associated with it.  Hence no duplication
> > of code is possible... at least at this hand-wavey "concept" level.
> > Possibly a given implementation has scope for code sharing; but I
> > doubt it.  Code behind a given implementation of the clock interface
> > is invariably quite slim.
> > =

> > If a clock being enabled implies a power or voltage domain being active,
> > there's no reason that constraint shouldn't be enforced by whatever
> > implementation a given platform uses.
>
> And that implementation could be highly optimised since it wouldn't care
> too much about being portable.

True, but I'm not sure optimization counts as much here as the
basic fact that these things are highly platform-specific even
in terms of basic structure and concepts.  To me, that means
the difference between a relatively small amount code that's
platform-specific ... or a large quantity of very generic code
trying to be all-things-for-all-platforms.  The former sounds much
more practical.


> > And having a generic -- basically untyped -- notion of "parameter"
> > seems significantly less good than having a typed notion, with
> > type-specific operations.  Typed notions are easier to understand,
> > read, and maintain.
>
> That sounds like being on the same lines of C vs C++ comments :) or why
> not to use typedef struct foo {...} bar

Well, why not "typedef struct {...}" is simple:  that's not
the standard for how Linux does things.

As for comment style ... no, not at all comparable.  In one case
the compiler will report typing errors (passing a voltage where
a clock is needed).  In the other, such errors will show up as
runtime errors; with luck, testing will trigger them before they
cause problems in customer/user hands, and they can be fixed
without rewriting code.

 =

> > > Basically a good way of thinking about parameter framework is that pa=
rameter =

> > > framework would start from existed clock framework and gradually evol=
ve by =

> > > addressing voltages, relationship between clocks and voltages, domain=
s. =

> > > Eventually clock framework functionality would be a part of power par=
ameter =

> > > framework.
> > =

> > A better way would be to say that implementions of the clock interface
> > on a given platform can build on whatever they need to build.  That mig=
ht
> > include a "parameter" framework, if such a thing were defined in such
> > a way that it became useful to such implementations.
> > =

> But shouldn't it be useful on every platform? As a sort of resource
> manager (because that's what it would become if it would start adressing
> interdependencies between clocks and voltages).

I couldn't know.  This "alternative concept" hasn't gotten very far
into the hand-waving stage, much less beyond it into proposed interface
or (gasp!) implementations.  Platforms that don't *have* those particular
interdependencies should not of course incur costs to implement them...

- Dave
