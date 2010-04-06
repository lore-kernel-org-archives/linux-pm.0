From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: Regulators vis-a-vis Power Domains
Date: Tue, 6 Apr 2010 16:58:13 +0100
Message-ID: <20100406155812.GR31126__6717.81700007177$1270569813$gmane$org@trinity.fluff.org>
References: <33A307AF30D7BF4F811B1568FE7A9B180320EBB6@EXDCVYMBSTM006.EQ1STM.local>
	<20100404131058.GA11705@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100404131058.GA11705@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: linux-pm@vger.kernel.org

On Sun, Apr 04, 2010 at 02:10:58PM +0100, Mark Brown wrote:
> On Sat, Apr 03, 2010 at 08:12:56PM +0200, Sundar R IYER wrote:
> =

> Please fix your mail client to word wrap within paragraphs; not doing
> this makes your messages harder to read and reply to.  I've reflowed belo=
w.
> =

> > 1. The documentation for the regulators mentions "power domains" and
> > "switches" to be modeled as regulators. I am planning to model multiple
> > "switches" for controlling supplies to various peripherals from a main
> > master regulator as multiple regulators, childed from the parent
> > regulator. Is this the right way to proceed ahead? Further the options
> =

> If you want to do this in the regulator framework, yes.
> =

> > for these switches will be only=A0a logical on/off. (BTW, I saw lots of=
 TI
> > stuff which is something related to power domains, but it doesn't model
> > the regulator framework.)
> =

> Nor does the SH stuff.  With the power domains of a CPU it often doesn't
> buy terribly much to use the regulator framework - the power domains are
> often a small part of a much bigger picture for the CPU internal power
> management, often incorporating thing =


I personally think there is merit to having the regulator framework at
least play a part in these, as is possible the powerdomains are being
fed from external regulators and/or power switches. I see it as good
way of using existing support to do useful work.

I've already seen an example of powerdomains hacked into the clock
framework, but this isn't really the place for it to be as it ends
up adding switch-on latencies to the system and hides things from the
driver.
 =

> > 2. In the same example below, should I instead model just the main
> > regulator, and in the driver specific enable/disable, iterate through
> > the list of consumers, and then accordingly enable/disable these
> > switches according to the calling consumer?. In this way,=A0I can choose
> > not to clutter those smaller switches as regulators in my regulator as
> > well as peripheral driver code.?
> =

> I'm not entirely sure what you mean here.  No regulator driver should
> ever have any knowledge of its consumers, this will be handled by the
> regulator core, and regulators should not be making decisions about
> their own power state - this should also be done by the core.  Perhaps
> if you could provide a more concrete example your question might be
> clearer?
> =

> > 3. Extending the same model, I want to use the _set_optimum API.
> > Logically, enabling/disabling the child supply or setting an optimal
> > load on the regulator must propagate the new load to any master
> > regulator ( which can then again be set an optimal load). My
> =

> This isn't entirely clear, actually.  Translating the load on a child
> regulator to that on a parent regulator isn't trivial since the
> performance of both regulators needs to be taken into consideration -
> the child regulator will have its own requirements for the input.  These
> will obviously be influenced by the load it experiences but it's not
> as direct a mapping as is desirable for propagating up the tree in a
> generic fashion.
> =

> > understanding of this function shows me that=A0currently, this is not
> > supported in the function. Am I right in deducing this or=A0have I fail=
ed
> > to overlook some other portions in the regulator code?
> =

> There's no code to do this at the minute - like I say, it's not as easy
> as might be desirable.  The other thing to bear in mind here is that
> hardware is making this less and less relevant.  With modern regulators
> the regulator itself is capable of responding quickly enough to load
> changes to automatically switch between most if not all of the operating
> modes without software intervention.  This means that managing the mode
> in software generally ends up being less efficient than just leaving the
> hardware to it.
> =

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- =

-- =

Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
