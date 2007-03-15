From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: Alternative Concept
Date: Thu, 15 Mar 2007 12:53:33 +0300
Message-ID: <45F9179D.2090706@gmail.com>
References: <44ECFF94.3030506@gmail.com>
	<484380240703131930n5e64a8fu9b935b0b513f0731@mail.gmail.com>
	<45F7D1BC.2000700@gmail.com>
	<200703141019.06641.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Dominik Brodowski <linux@dominikbrodowski.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

David Brownell wrote:
> This alternative "concept" would seem to be missing a few essential
> aspects.  Like proposed interfaces, for starters ...

stay tuned - it follows ;)

> =

> =

> On Wednesday 14 March 2007 3:43 am, Eugeny S. Mints wrote:
>>> Would this involve replacing the clock framework, or are they going to =
coexist?
>> parameter framework would eventually replace clock framework.
> =

> That seems to be the wrong answer.  Especially since nothing has
> been shown to be wrong with the clock interface; much less to be
> unfixably wrong (hence justifying replacement).

a cherry-picking on clk fw API:

- clk_set_rate() sticks to an individual clock - no way to set rates for nu=
mber =

of clocks at once instead of having series of clk_set_rate() calls. The for=
mer =

for example is required for clocks which have required predefined ratio =

dependency though: two clocks always have to be n:2n and any other ratio le=
ads =

to hardware misbehavior. So, you can't go from 100:200 to 300:600 via serie=
s of =

clk_set_rate() for such clocks, i.e. 100:200 -> 300:200 -> 300:600 or 100:2=
00 -> =

100:600 -> 300:600 (see SH7722 hw for reference)

- only a rate can be set up via clk_set_rate() while for a PLL I want to se=
t up =

a desired idle state as well (btw there can be more than one idle state)

- current API does not provide support for clock domains

a cherry-picking on clk fw implementation:

- clock tree structure and traversing clock tree code are duplicated in eve=
ry =

architecture while can be done in arch independent way and just once (hint:=
 what =

indeed is an arch specific thing it's a clock tree configuration)

> =

> =

>> Separate clock and  =

>> voltage frameworks lead to code and functionality duplication and do not=
 address =

>> such things as relationship between clocks and voltages, clock/voltage/p=
ower =

>> domains, etc needed for aggressive power management.
> =

> Most clocks don't have those issues.  Why penalize all clocks for
> issues which only relate to a few?  Better to only do that for the
> few cocks which have such additional constraints.

parameter fw would give exactly this behavior: relationship between clocks =
and =

voltages, clock/voltage/power domains implementation would be just addition=
al =

arcs between nodes for clock and voltages. Nowadays clk fw has only one typ=
e of =

arcs - parent-child type. parameter fw would bring additional types. But cl=
ock =

nodes would be linked just with required arcs (of required type; both are a=
rch =

specific things) so for an arch without any additional dependencies between =

clocks (and voltages) parameter fw would end up with exactly equivalent clo=
ck =

tree as clk fw for the arch has today.

> =

> Plus, remember that the clock framework is an interface ... so by
> definition, it has no code associated with it.  Hence no duplication
> of code is possible... at least at this hand-wavey "concept" level.
> Possibly a given implementation has scope for code sharing; but I
> doubt it.  Code behind a given implementation of the clock interface
> is invariably quite slim.

and invariably looks like a hack and still duplicate clock tree building an=
d =

traversing code. Dependencies which exist in modern hw between clocks, cloc=
ks =

and voltages require a more straight and standard technique to be set up fo=
r =

implementing clk/vltg/name_it framework. Moving most of the code to be arch =

independent and setting a clear rules on how a clock/vltg tree configuratio=
n =

would look like while just looking at a hw manual would help.

> =

> If a clock being enabled implies a power or voltage domain being active,
> there's no reason that constraint shouldn't be enforced by whatever
> implementation a given platform uses.

true. but it's the same functionality required on different arches. and it =
can =

be done in arch independent way without penalties for arches which do not =

require the functionality. What's the rationale to move it down to arch spe=
cific =

code then?

> =

> And having a generic -- basically untyped -- notion of "parameter"
> seems significantly less good than having a typed notion, with
> type-specific operations.  =


there is no type-specific operations. clk_set_rate() and vltg_set() basical=
ly do =

the same thing - set a value for a pm resource provided by clock or voltage =

device (regulator). The difference is that output of clock regulator is mea=
sured =

in Hz and named 'frequesncy' and output of voltage regulator os measured in=
 mV =

and named 'voltage' which actually does not matter from API POV. So, i see =
more =

sense in having param_set(), parame_set_state() (set_state primitive for id=
le =

states) rather than in

clk_set_rate(), clk_set_state()
vltg_set(), vltg_set_state()
and, our analysis shows that you would end up with a separate type for doma=
ins, =

so it would be at least
domain_set_state() as well.

> Typed notions are easier to understand,
> read, and maintain.

common, after tricks with spinlocks in [merged!] RT patches? ;)

Eugeny
> =

> =

>> Basically a good way of thinking about parameter framework is that param=
eter =

>> framework would start from existed clock framework and gradually evolve =
by =

>> addressing voltages, relationship between clocks and voltages, domains. =

>> Eventually clock framework functionality would be a part of power parame=
ter =

>> framework.
> =

> A better way would be to say that implementions of the clock interface
> on a given platform can build on whatever they need to build.  That might
> include a "parameter" framework, if such a thing were defined in such
> a way that it became useful to such implementations.
> =

> - Dave
> =

> =
