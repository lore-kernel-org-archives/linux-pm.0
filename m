From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: Alternative Concept
Date: Thu, 15 Mar 2007 15:04:49 +0200
Message-ID: <1173963890.12614.27.camel@Dogbert.NOE.nokia.com>
References: <44ECFF94.3030506@gmail.com>
	<484380240703131930n5e64a8fu9b935b0b513f0731@mail.gmail.com>
	<45F7D1BC.2000700@gmail.com> <200703141019.06641.david-b@pacbell.net>
	<45F9179D.2090706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <45F9179D.2090706@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "ext Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

On Thu, 2007-03-15 at 12:53 +0300, ext Eugeny S. Mints wrote:
> David Brownell wrote:
> > This alternative "concept" would seem to be missing a few essential
> > aspects.  Like proposed interfaces, for starters ...
> =

> stay tuned - it follows ;)
> =

> > =

> > =

> > On Wednesday 14 March 2007 3:43 am, Eugeny S. Mints wrote:
> >>> Would this involve replacing the clock framework, or are they going t=
o coexist?
> >> parameter framework would eventually replace clock framework.
> > =

> > That seems to be the wrong answer.  Especially since nothing has
> > been shown to be wrong with the clock interface; much less to be
> > unfixably wrong (hence justifying replacement).
> =

> a cherry-picking on clk fw API:
> =

> - clk_set_rate() sticks to an individual clock - no way to set rates for =
number =

> of clocks at once instead of having series of clk_set_rate() calls. The f=
ormer =

> for example is required for clocks which have required predefined ratio =

> dependency though: two clocks always have to be n:2n and any other ratio =
leads =

> to hardware misbehavior. So, you can't go from 100:200 to 300:600 via ser=
ies of =

> clk_set_rate() for such clocks, i.e. 100:200 -> 300:200 -> 300:600 or 100=
:200 -> =

> 100:600 -> 300:600 (see SH7722 hw for reference)
What's wrong with expanding the clk_fw?
All is needed is:
clk_set_rate_buffered(clk1, 300);
clk_set_rate_buffered(clk2, 600);
clk_rate_flush(); /* can include validation of the set */

Which is, incidentally, what OMAP2 does in hw for all the relevant clk
dividers and it also provides validation for the new set of values.

Furthermore if the original assumption that complex transitions are
allowed only atomically (p1A, p1B) =3D> (p2A, p2B), hw support is
mandatory, otherwise the transition is impossible, no matter what fancy
sw fw is performing it.

> - only a rate can be set up via clk_set_rate() while for a PLL I want to =
set up =

> a desired idle state as well (btw there can be more than one idle state)
Is there any PLL which provide automatic switching between running/idle sta=
te?
Do you have any HW architecture on your mind?

> - current API does not provide support for clock domains
So?

> a cherry-picking on clk fw implementation:
> =

> - clock tree structure and traversing clock tree code are duplicated in e=
very =

> architecture while can be done in arch independent way and just once (hin=
t: what =

> indeed is an arch specific thing it's a clock tree configuration)
that looks more like an optimisation to the clk fw, not a call for a brand =
new one

> > =

> > =

> >> Separate clock and  =

> >> voltage frameworks lead to code and functionality duplication and do n=
ot address =

> >> such things as relationship between clocks and voltages, clock/voltage=
/power =

> >> domains, etc needed for aggressive power management.
relationships are very arch specific so having or not the fw there
wouldn't probably make any real difference.
About power domains ... well, what's the deal?
Aren't they controlled like voltages, in the end?

 =

> > Most clocks don't have those issues.  Why penalize all clocks for
> > issues which only relate to a few?  Better to only do that for the
> > few cocks which have such additional constraints.
> =

> parameter fw would give exactly this behavior: relationship between clock=
s and =

> voltages, clock/voltage/power domains implementation would be just additi=
onal =

> arcs between nodes for clock and voltages. Nowadays clk fw has only one t=
ype of =

> arcs - parent-child type. parameter fw would bring additional types. But =
clock =

> nodes would be linked just with required arcs (of required type; both are=
 arch =

> specific things) so for an arch without any additional dependencies betwe=
en =

> clocks (and voltages) parameter fw would end up with exactly equivalent c=
lock =

> tree as clk fw for the arch has today.

I think what has to be clarified, is wether there is a real need for new
features or not. =


> > =

> > Plus, remember that the clock framework is an interface ... so by
> > definition, it has no code associated with it.  Hence no duplication
> > of code is possible... at least at this hand-wavey "concept" level.
> > Possibly a given implementation has scope for code sharing; but I
> > doubt it.  Code behind a given implementation of the clock interface
> > is invariably quite slim.
> =

> and invariably looks like a hack and still duplicate clock tree building =
and =

> traversing code. Dependencies which exist in modern hw between clocks, cl=
ocks =

> and voltages require a more straight and standard technique to be set up =
for =

> implementing clk/vltg/name_it framework. Moving most of the code to be ar=
ch =

> independent and setting a clear rules on how a clock/vltg tree configurat=
ion =

> would look like while just looking at a hw manual would help.
I think clocks and voltages providers have very different behaviours: for e=
xample
a voltage src can sometimes be put in quiescent state, where the voltage va=
lue is
 preserved, but the max current is significantly reduced, therefore minimiz=
ing the
leakage. I wouldn't welcome such functionality to be merged with clock hand=
ling.


> > =

> > If a clock being enabled implies a power or voltage domain being active,
> > there's no reason that constraint shouldn't be enforced by whatever
> > implementation a given platform uses.
> =

> true. but it's the same functionality required on different arches. and i=
t can =

> be done in arch independent way without penalties for arches which do not =

> require the functionality. What's the rationale to move it down to arch s=
pecific =

> code then?

I'd rather ask: what's the benefit of merging apples and oranges?

> > =

> > And having a generic -- basically untyped -- notion of "parameter"
> > seems significantly less good than having a typed notion, with
> > type-specific operations.  =

> =

> there is no type-specific operations. clk_set_rate() and vltg_set() basic=
ally do =

> the same thing - set a value for a pm resource provided by clock or volta=
ge =

> device (regulator). The difference is that output of clock regulator is m=
easured =

> in Hz and named 'frequesncy' and output of voltage regulator os measured =
in mV =

> and named 'voltage' which actually does not matter from API POV. So, i se=
e more =

> sense in having param_set(), parame_set_state() (set_state primitive for =
idle =

> states) rather than in
See my comment above about different, peculiar, behaviour of voltages.
And that's just an example.

> clk_set_rate(), clk_set_state()
> vltg_set(), vltg_set_state()
> and, our analysis shows that you would end up with a separate type for do=
mains, =

> so it would be at least
> domain_set_state() as well.
> =

> > Typed notions are easier to understand,
> > read, and maintain.
> =

> common, after tricks with spinlocks in [merged!] RT patches? ;)
> =

> Eugeny
> > =

> > =

> >> Basically a good way of thinking about parameter framework is that par=
ameter =

> >> framework would start from existed clock framework and gradually evolv=
e by =

> >> addressing voltages, relationship between clocks and voltages, domains=
. =

> >> Eventually clock framework functionality would be a part of power para=
meter =

> >> framework.
> > =

> > A better way would be to say that implementions of the clock interface
> > on a given platform can build on whatever they need to build.  That mig=
ht
> > include a "parameter" framework, if such a thing were defined in such
> > a way that it became useful to such implementations.
> > =

> > - Dave
> > =

> > =

> =

> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
-- =

Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
