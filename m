From: "Ikhwan Lee" <dlrghks@gmail.com>
Subject: Re: Alternative Concept
Date: Fri, 16 Mar 2007 12:56:39 +0900
Message-ID: <484380240703152056w44d14c71tff4457c07c6bdbbc@mail.gmail.com>
References: <44ECFF94.3030506@gmail.com> <45F9179D.2090706@gmail.com>
	<1173963890.12614.27.camel@Dogbert.NOE.nokia.com>
	<200703151921.55310.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200703151921.55310.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi,

Although I agree that the current clock framework can handle power or
voltage domains in many platforms, having something like (struct clk
powerdomain1, powerdomain2;) does not seem like a good implementation,
a struct for clocks representing a power domain.

If a new framework is more straighforward and introduces a negligible
overhead to the current kernel, I think it is worthwhile to have a
look at it. Plus this new framework might be able to take care of
those platforms that are not nicely supported by the current clock
framework.

Ikhwan

On 3/16/07, David Brownell <david-b@pacbell.net> wrote:
> On Thursday 15 March 2007 6:04 am, Igor Stoppa wrote:
> > On Thu, 2007-03-15 at 12:53 +0300, ext Eugeny S. Mints wrote:
> > > > On Wednesday 14 March 2007 3:43 am, Eugeny S. Mints wrote:
> > > >>> Would this involve replacing the clock framework, or are they goi=
ng to coexist?
> > > >> parameter framework would eventually replace clock framework.
> > > >
> > > > That seems to be the wrong answer.  Especially since nothing has
> > > > been shown to be wrong with the clock interface; much less to be
> > > > unfixably wrong (hence justifying replacement).
> > >
> > > a cherry-picking on clk fw API:
> > >
> > > - clk_set_rate() sticks to an individual clock - no way to set rates =
for number
> > >   of clocks at once instead of having series of clk_set_rate() calls.
>
> This isn't "wrong", it's a "lack of feature".  The normal process for
> addressing such things is to improve working/deployed software interfaces,
> not throw them out and try to create and deploy something new.  :)
>
> Plus, that's not actually true.  When you change the rate for a parent
> clock, all its derived clocks necessarily change ... however many they
> may be.  And there's nothing to prevent updating non-derived clocks.
>
> Of course, such a change *does* touch on something I'd agree is a notable
> omission:  requests to change such a clock rate (call it a "base" rate
> for purposes of discussion here) are currently safe only if the related
> clocks have no drivers using them, since there's no way for those driver
> to either veto the change ("I can't support 115200 baud at that base rate=
"),
> or reclock to handle the changed environment ("update clock divisor to
> maintain current serial port baud rate").
>
> Which is why currently most clock rates aren't currently changeable; and
> those which can be changed are mostly leaves on the clock tree.
>
> On some platforms that significantly impacts what cpufreq (or whatever
> DVFS scheme is used) could achieve.
>
>
> > > The former
> > > for example is required for clocks which have required predefined rat=
io
> > > dependency though: two clocks always have to be n:2n and any other ra=
tio leads
> > > to hardware misbehavior.
>
> The programming interface doesn't preclude enforcement of that rule
> though.  In fact, I'd call any *implementation* buggy if the hardware
> has such a rule about base rates, but the software doesn't enforce it.
> (That is:  it's not an interface issue.)
>
>
> > > So, you can't go from 100:200 to 300:600 via series of
> > > clk_set_rate() for such clocks, i.e. 100:200 -> 300:200 -> 300:600 or=
 100:200 ->
> > > 100:600 -> 300:600 (see SH7722 hw for reference)
>
> AT91 (e.g. at91sam9263) processors have MCKR with similar restrictions,
> but the only time this could ever matter seems to be for cpufreq.
>
> Does this matter to you for any other reason than trying to use the
> clock framework to implement cpufreq?  If not, there's no need for
> the clock framework to define how to do this ... since cpufreq is
> so highly platform-specific.
>
> If you want to say that this makes it hard to implement cpufreq in terms
> of the clock API, I'd agree ... but then, the *complete* lack of driver
> clock change notifications is a far bigger issue.  Drivers like MMC/SD,
> UART, SPI, and I2C commonly need to update internal clock settings when
> rates change, and may need to plug their lowlevel I/O queues while those
> base clock rates change.
>
>
> > What's wrong with expanding the clk_fw?
> > All is needed is:
> > clk_set_rate_buffered(clk1, 300);
> > clk_set_rate_buffered(clk2, 600);
> > clk_rate_flush(); /* can include validation of the set */
> >
> > Which is, incidentally, what OMAP2 does in hw for all the relevant clk
> > dividers and it also provides validation for the new set of values.
> >
> > Furthermore if the original assumption that complex transitions are
> > allowed only atomically (p1A, p1B) =3D> (p2A, p2B), hw support is
> > mandatory, otherwise the transition is impossible, no matter what fancy
> > sw fw is performing it.
>
> I think Scott's "power transaction" notion is a bit better, since
> it should among other things provide a way to cope with cases like
> two concurrent tasks trying issue conflicting changes.  An SMP
> system ought to be able to reclock two or more CPU cores at once;
> and maybe even do it with one "power transaction".
>
>
> > > - only a rate can be set up via clk_set_rate() while for a PLL I want=
 to set up
> > > a desired idle state as well (btw there can be more than one idle sta=
te)
> >
> > Is there any PLL which provide automatic switching between running/idle=
 state?
> > Do you have any HW architecture on your mind?
>
> And why should such a hardware-specific mechanism show up in an
> all-platforms API?  There's quite a lot of hardware-specific stuff
> going on, and that seems like just one more instance of it.
>
>
> > > - current API does not provide support for clock domains
> >
> > So?
>
> Exactly.  :)
>
> And again, that's not strictly true either; the clock tree itself
> defines one kind of domain, also known as "subtrees".
>
> A point I'll make below with respect to power domains:  unless
> those domains need to be exposed for some reason to drivers,
> there is no need for these to show up the programming interface
> except as implementation artifacts.  As in:  activate this clock,
> and platform-specific stuff happens.  It always does, of course,
> but in some cases it will be more extensive than in others.
>
> (Activating a PLL normally takes more than setting a bit to
> open a clock gate; activating some clocks might invove kicking
> some clock or power domain logic.)
>
>
> > > a cherry-picking on clk fw implementation:
>
> Which platform's implementation?  I've seen several...
>
>
> > > - clock tree structure and traversing clock tree code are duplicated =
in every
> > > architecture while can be done in arch independent way and just once =
(hint: what
> > > indeed is an arch specific thing it's a clock tree configuration)
> >
> > that looks more like an optimisation to the clk fw, not a call for a br=
and new one
>
> And I'm not even sure calling it an "optimization" is correct.
>
> Given how arch-specific the tree structure is, it's not clear
> that traversing it shouldn't be arch-specific too.  And in any
> case ... the traversal code I've seen is so trivial I'd have a
> hard time worring about sharing it.  Implementation flexibility
> seems to be widely useful in handling arch-specific differences.
>
>
> > > >> Separate clock and voltage frameworks
>
> Not that we _have_ a voltage framework yet, e.g. "turn on that
> that power rail, configured at 3.3V".
>
> Plus rememember that a voltage framework is not synonymous with
> a DVFS kit ... and that a DVFS kit may need to interact with a
> lot more than just voltage and frequency controls.  Example,
> reclocking CPU and memory frequency may need to run out of SRAM
> and without accessing page tables stored in DRAM.
>
>
> > > >> lead to code and functionality duplication
>
> But since a clock is not a voltage, the primitives must differ.
> There's no analogue of "allocate 80 mA" for a clock, as there
> would be with a voltage framework's power budget primitives.
>
>
> > > >> and do not address
> > > >> such things as relationship between clocks and voltages, clock/vol=
tage/power
> > > >> domains, etc needed for aggressive power management.
> >
> > relationships are very arch specific so having or not the fw there
> > wouldn't probably make any real difference.
> > About power domains ... well, what's the deal?
> > Aren't they controlled like voltages, in the end?
>
> The last time I looked at a power domain, it was more like a
> prerequisite to using various device clocks.  It wasn't something
> that needed to be exposed in an API ... it would suffice to
> have it be activated/deactivated as a side effect of accessing
> those clocks.
>
> That is, the existing hooks suffice.  The platform-specific code
> to enable a given clock subtree would just have a few lines of
> code teaching it how to enable the relevant power domain.  They
> already rely on platform-specific logic to sort out which register
> bank to touch, which bits there, and various other things.
>
>
> Although that recent work for memory partitioning is relevant
> here too:  being able to power down banks of DRAM (ensuring they
> hold no data or code that's currently needed) can certainly cut
> down one category of power drain.
>
> In the same vein, some utilities to manage on-chip SRAM would
> likely be helpful.  It's common that certain low power modes
> disable all DRAM, leaving only (say) 16 KB of SRAM available
> for running code ... or that DRAM be unavailable while CPU
> and/or memory are being reclocked (maybe by a DVFS scheme,
> using cpufreq or whatever).
>
>
> > > > Most clocks don't have those issues.  Why penalize all clocks for
> > > > issues which only relate to a few?  Better to only do that for the
> > > > few cocks which have such additional constraints.
> > >
> > > parameter fw would give exactly this behavior: relationship between c=
locks and
> > > voltages, clock/voltage/power domains implementation would be just ad=
ditional
> > > arcs between nodes for clock and voltages. Nowadays clk fw has only o=
ne type of
> > > arcs - parent-child type. parameter fw would bring additional types. =
But clock
> > > nodes would be linked just with required arcs (of required type; both=
 are arch
> > > specific things) so for an arch without any additional dependencies b=
etween
> > > clocks (and voltages) parameter fw would end up with exactly equivale=
nt clock
> > > tree as clk fw for the arch has today.
> >
> > I think what has to be clarified, is wether there is a real need for new
> > features or not.
>
> Not just "new features" but "new cross-platform features".  This PM stuff
> is really down'n'dirty code ... who will be working with such code?  The =
less
> we demand of those people, the more likely it is that such features would
> actually be delivered in working form.  A lot of platform vendors work
> with older kernel releases (2.6.10 etc), which means that new APIs will
> be obstacles to development and deployment.
>
> Going back to clock and power domain examples above:  it's *easy* to see =
how
> those could be delivered using the current clock framework.  There are a =
LOT of
> folk who are familiar with those interfaces -- today.  So unless there re=
ally
> is no way to address the issue with the current APIs, it's best to avoid
> creating new interfaces for those issues.
>
>
> > > > Plus, remember that the clock framework is an interface ... so by
> > > > definition, it has no code associated with it.  Hence no duplication
> > > > of code is possible... at least at this hand-wavey "concept" level.
> > > > Possibly a given implementation has scope for code sharing; but I
> > > > doubt it.  Code behind a given implementation of the clock interface
> > > > is invariably quite slim.
> > >
> > > and invariably looks like a hack and still duplicate clock tree build=
ing and
> > > traversing code.
>
> Most cases I've seen build the clock tree with a bunch of static struct
> declarations, so the building is all at compile time ... and could hardly
> duplicate something on another platform, since it's all platform-specific.
> And as noted above, traversal code is trivial ...
>
>
> > > Dependencies which exist in modern hw between clocks, clocks
> > > and voltages require a more straight and standard technique to be set=
 up for
> > > implementing clk/vltg/name_it framework.
>
> I think Linus has pointed out that cut'n'paste is a very straightforward
> and standard technique.  :)
>
> The clock-to-clock dependencies are handled by the clock framework
> already.  As are at least some cases of power domains.
>
> DVFS -- cpufreq or otherwise -- is the primary example of a case where
> coupling is needed between clocks and voltages.  These PM discussions
> lately seem to dance around DVFS without saying so explicitly ... seeming=
ly,
> to avoid the "so why not just fix cpufreq" discussions that would (should=
!)
> naturally follow.
>
> My own two cents on the cpufreq thing:  (a) it should support the driver
> model better; (b) a generic "run from SRAM" solution would be an aid to
> that and other PM code; (c) without clock framework support for drivers
> being able to reject changes or else re-clock, changing base clocks is
> often impractical; (d) I don't recall seeing anyone really answer the
> "so why not ust fix cpufreq" question.
>
>
> > > Moving most of the code to be arch
> > > independent and setting a clear rules on how a clock/vltg tree config=
uration
> > > would look like while just looking at a hw manual would help.
> >
> > I think clocks and voltages providers have very different behaviours: f=
or example
> > a voltage src can sometimes be put in quiescent state, where the voltag=
e value is
> > preserved, but the max current is significantly reduced, therefore mini=
mizing the
> > leakage. I wouldn't welcome such functionality to be merged with clock =
handling.
>
> Another good example of these APIs being domain-specific ... though
> in a way it's a special case of the one I gave above.  In a similar
> vein, lower current (but not quiescent) modes may be able to use
> alternate schemes for voltage regulation.  The regulation may need
> software inputs to switch schemes.
>
>
> > > > If a clock being enabled implies a power or voltage domain being ac=
tive,
> > > > there's no reason that constraint shouldn't be enforced by whatever
> > > > implementation a given platform uses.
> > >
> > > true. but it's the same functionality required on different arches. a=
nd it can
> > > be done in arch independent way without penalties for arches which do=
 not
> > > require the functionality. What's the rationale to move it down to ar=
ch specific
> > > code then?
> >
> > I'd rather ask: what's the benefit of merging apples and oranges?
>
> Someone may be tiring of a steady diet, and wants to become a chef?  :)
>
> I'll repeat that power and clock domain examples above:  the current
> clock framework is **ALREADY** arch-independant in exactly the way
> Eugeny sketched, for several platforms.
>
>
> > > > And having a generic -- basically untyped -- notion of "parameter"
> > > > seems significantly less good than having a typed notion, with
> > > > type-specific operations.
> > >
> > > there is no type-specific operations. clk_set_rate() and vltg_set() b=
asically do
> > > the same thing - set a value for a pm resource provided by clock or v=
oltage
> > > device (regulator). The difference is that output of clock regulator =
is measured
> > > in Hz and named 'frequesncy' and output of voltage regulator os measu=
red in mV
> > > and named 'voltage' which actually does not matter from API POV. So, =
i see more
> > > sense in having param_set(), parame_set_state() (set_state primitive =
for idle
> > > states) rather than in
> >
> > See my comment above about different, peculiar, behaviour of voltages.
> > And that's just an example.
>
> One of several, I added more ...
>
>
> > > clk_set_rate(), clk_set_state()
> > > vltg_set(), vltg_set_state()
>
> vtg_allocate_budget() would have no clock domain analogue,
> nor would vtg_free_budget() ...
>
>
> > > and, our analysis shows that you would end up with a separate type fo=
r domains,
> > > so it would be at least
> > > domain_set_state() as well.
>
> See my comments above re clock and voltage domains, applicable to
> at least half a dozen platforms.
>
> Until you share your analysis, so we can see what we agree and disagree
> with, it's not helpful for you to claim that it supports your argument.
>
>
> > > > Typed notions are easier to understand,
> > > > read, and maintain.
> > >
> > > common, after tricks with spinlocks in [merged!] RT patches? ;)
>
> I don't follow this comment.  I'm still waiting to see the NO_HZ stuff
> become as stable and fast as the previous NO_IDLE_HZ stuff ... but
> none of that seems to relate to type-unsafe programming interfaces.
>
> - Dave
>
>
> > >
> > > Eugeny
> > >
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
>
