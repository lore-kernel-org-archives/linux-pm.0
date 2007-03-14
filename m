From: David Brownell <david-b@pacbell.net>
Subject: Re: Alternative Concept
Date: Wed, 14 Mar 2007 10:19:06 -0700
Message-ID: <200703141019.06641.david-b@pacbell.net>
References: <44ECFF94.3030506@gmail.com>
	<484380240703131930n5e64a8fu9b935b0b513f0731@mail.gmail.com>
	<45F7D1BC.2000700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <45F7D1BC.2000700@gmail.com>
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
To: linux-pm@lists.osdl.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

This alternative "concept" would seem to be missing a few essential
aspects.  Like proposed interfaces, for starters ...


On Wednesday 14 March 2007 3:43 am, Eugeny S. Mints wrote:
> > =

> > Would this involve replacing the clock framework, or are they going to =
coexist?
> =

> parameter framework would eventually replace clock framework.

That seems to be the wrong answer.  Especially since nothing has
been shown to be wrong with the clock interface; much less to be
unfixably wrong (hence justifying replacement).


> Separate clock and  =

> voltage frameworks lead to code and functionality duplication and do not =
address =

> such things as relationship between clocks and voltages, clock/voltage/po=
wer =

> domains, etc needed for aggressive power management.

Most clocks don't have those issues.  Why penalize all clocks for
issues which only relate to a few?  Better to only do that for the
few cocks which have such additional constraints.

Plus, remember that the clock framework is an interface ... so by
definition, it has no code associated with it.  Hence no duplication
of code is possible... at least at this hand-wavey "concept" level.
Possibly a given implementation has scope for code sharing; but I
doubt it.  Code behind a given implementation of the clock interface
is invariably quite slim.

If a clock being enabled implies a power or voltage domain being active,
there's no reason that constraint shouldn't be enforced by whatever
implementation a given platform uses.

And having a generic -- basically untyped -- notion of "parameter"
seems significantly less good than having a typed notion, with
type-specific operations.  Typed notions are easier to understand,
read, and maintain.


> Basically a good way of thinking about parameter framework is that parame=
ter =

> framework would start from existed clock framework and gradually evolve b=
y =

> addressing voltages, relationship between clocks and voltages, domains. =

> Eventually clock framework functionality would be a part of power paramet=
er =

> framework.

A better way would be to say that implementions of the clock interface
on a given platform can build on whatever they need to build.  That might
include a "parameter" framework, if such a thing were defined in such
a way that it became useful to such implementations.

- Dave
