From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: Alternative Concept
Date: Mon, 19 Mar 2007 09:12:21 -0500 (CDT)
Message-ID: <200703191412.l2JECLsP021909@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: David Brownell's message of Sun, 18 Mar 2007 23:07:24 -0700
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david-b@pacbell.net
Cc: linux-pm@lists.osdl.org, pavel@ucw.cz, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org


Could you guys present a clear definition of exactly what you mean by
"clock domain" and "power domain"? I can think of several different ways
to interpret the phrases, and I'd like to end up with the same meaning
that you are arguing from...

thanks,
scott

| From: David Brownell<david-b@pacbell.net>
| =

| On Sunday 18 March 2007 7:27 pm, Ikhwan Lee wrote:
| > Hi,
| > =

| > On 3/16/07, David Brownell <david-b@pacbell.net> wrote:
| > > On Thursday 15 March 2007 8:56 pm, Ikhwan Lee wrote:
| > > > Hi,
| > > >
| > > > Although I agree that the current clock framework can handle power =
or
| > > > voltage domains in many platforms, having something like (struct clk
| > > > powerdomain1, powerdomain2;) does not seem like a good implementati=
on,
| > > > a struct for clocks representing a power domain.
| > >
| > > Good thing that's not what I suggested then, right?  :)
| > >
| > > The point was that in the examples I've seen, the power domains
| > > are associated with clock domains, so that each clock is tied
| > > to one power domain.  And since you can't use the power domain
| > > without having a clock ... the implementation can tell if it's
| > > got to activate a power domain by looking at the clock.
| > =

| > True, although sometimes it gets dirty because multiple clock sources
| > are associated with one power domain
| =

| As clearly allowed for in what I wrote.  clock->power_domain.
| =

| > at the same time multiple power =

| > domains are associated with one clock source.
| =

| As also allowed for in what I wrote originally.  clock->power_domains[].
| =

| > Simple parent and child =

| > relationship provided by the clock framework is not always enough.
| =

| Not implied in what I wrote.
| =

| =

| > > There may be other models of power domain, but that's the one
| > > I've had reason to look at (which isn't synonymous with a straight
| > > voltage/current supply).
| > >
| > >
| > > > If a new framework is more straighforward and introduces a negligib=
le
| > > > overhead to the current kernel, I think it is worthwhile to have a
| > > > look at it. Plus this new framework might be able to take care of
| > > > those platforms that are not nicely supported by the current clock
| > > > framework.
| > >
| > > Perhaps when we see one, we could discuss that as somethong other
| > > than pure handwaving.  But that still won't address the basic point
| > > that it's wrong to assume the clock framework should be written out
| > > of the picture.
| > =

| > I think we can reach an agreement. The clock framework does not need
| > to be replaced with a new one since it is serving its purpose well
| > enough. If extra functionalities are needed for clocks, we can extend
| > the existing clock framework. Such extensions will include functions
| > like clk_set_rate_pending() and power_transaction_commit(). However,
| > since clocks and voltages (or power domains) have different
| > characteristics, it is desirable to have a separate framework for
| > power domains and associate that framework with the existing clock
| > framework.
| =

| If the platform needs power domains to be exposed, yes.  But I gave
| examples where it does NOT need to be exposed, since each clock was
| in a single power domain.
| =

| =

| > I am not sure if this is the direction that the original PowerOp
| > people suggested. If we can agree on this, however, I think we can
| > proceed to look at the code.
| =

| I'm not sure why such agreement should be necessary before showing
| interface definitions.
| =

| - Dave
| _______________________________________________
| linux-pm mailing list
| linux-pm@lists.linux-foundation.org
| https://lists.linux-foundation.org/mailman/listinfo/linux-pm
| =


-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
