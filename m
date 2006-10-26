From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: Alternative Concept [Was: Re: [RFC] CPUFreq
	PowerOPintegration, Intro 0/3]
Date: Thu, 26 Oct 2006 12:36:18 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5084E4681@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


Hi,

> > Depending on your operating point definition you don't always have
to
> > limit yourself here.  An operating point parameter need not directly
be
> > associated with the physical value of the domain it represents.
Meaning
> > you don't need to put 1.05 volts in for the parameter, you can
define it
> > as some other value which needs translating/defining by the core.
> =

> First, thanks for your insightful comments. Second, well, we can of
course
> use some discrete values instead of "real" values -- however, if we
get
> the
> chance, I think it's nicer to put the "real" values there. Unless we
need
> floating point ;)

Yes, floating point funny... really I was hoping for denormalized number
usage, not just '1.05V' instead of 1050mV ;)

For me an operating point ends up being a mix of directly interpretable
physical parameters and a couple more generic ones.  They are all
'fundamental'. The generic ones describe a level for an entire domain.
Upon parameter change I would update the specific domain control
register, then, a secondary (usually symmetric) action may need to be
preformed to members of that domain.

For example I have 3 domains.  I want to put one domain into a higher
latency idle state and leave the other two in a higher responsive state.
I have 3 parameters in my OPP for those domains generic idle state.  I
change the parameter to put that one domain into idle.  This gets
translated into a call out where each member module (peripheral) enables
a local idle feature (perhaps more as necessary).  There may be 2 or 20
or ? modules contained in that domain.  Next, the domains master idle
bit is set, and once all the members reach idle the domain can change
state.

Listing all 20 devices in the OPP isn't necessary when you are looking
to achieve a fundamental domain specific action.  A single parameter to
express this is useful.

There was recently a latency patch I saw on lkml used with a wireless
driver.  I think that patch along with some decision logic would fit
nicely into this kind of scheme.  Before I set a domain idle bit, I can
have available the latency information to say if it will work out.

In our implementation you must track the stack up of latencies.  Each
level of idle from the device, to the interconnect, to the domain, and
to the DPLL will add another additive level of latency.  If you just set
individual ones with out summing them up, you will find your quality of
service will be bad and you get bad playback on mp3 and the like with
certain device state mixes.

If you don't associate the devices in this type of system you end up
limiting the kind of power savings which is achievable.

Regards/Thanks,
Richard W.

> =

> Thanks,
> 	Dominik
