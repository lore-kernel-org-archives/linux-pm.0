From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 10:24:36 +1100
Message-ID: <1111620276.16224.107.camel@gaston>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<1111465290.27490.34.camel@gaston>
	<200503231058.54311.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============55270178125286007=="
In-Reply-To: <200503231058.54311.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============55270178125286007==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-03-23 at 10:58 -0800, David Brownell wrote:
> On Monday 21 March 2005 8:21 pm, Benjamin Herrenschmidt wrote:
> > 
> > Yup, the model we are desinging now should allow for arbitrary
> > transitions I suppose as long  as the target state is legal vs. the
> > dependencies.
> 
> Leading to the question:  how are the dependencies identified and
> enforced?

I have proposed something, if you read my other mails, that should deal
with most of the usual cases.

> My current thought is that it's wrong to expect the PM core code to
> do all this.  Discussion on this list strongly suggests to me that
> we'll never achieve a Grand Unified Theory of PM into which every
> device, bus, platform, and board will fit ... unless we give up
> on the notion that _everything_ be centrally controlled.  The key
> will be having good ways to delegate all the important issues.

The problem with your approach is since you have in mind those extremely
weird embedded setups that can't fit in any sane model, you decide to
reject any model that does anything useful at the core. I don't agree
with your logic. Most embedded systems even would fit in the simple
model. In the case of on-chip devices driven by clock nets, it's even
possible to just consider clock domains as "busses" and miracle ! we end
up with a nice discrete list of bus state to apply to drivers and
dependencies that fit the proposed model.

> So for example it would make sense to have device suspend() logic
> verify any dependencies for the target state, and then just fail
> cleanly if they're not satisfied.

How ? It doesn't have the necessary knowledge unless we start moving a
lot of burden into drivers. And every time we'll move some algorithmic
requirements like that to drivers, 99% of them will get it wrong.

> That'll mostly be an issue for bridge drivers ... like PCI
> bridges, host adapters for things like USB, hubs, and so on.

Bridges/busses have no knowledges of device states, they can't verify
dependencies unless the devices expose their state list & dependency
information in a meaningful way, which is exactly what I'm proposing.

> But it also shows a way to handle custom hardware, which may
> not be as regular as the PC and server centric developers want
> the world to be...

Yah, I know those, I have been doing embedded dev too, and in most
cases, they aren't _that_ bad. And if they are ? well, they'll hack
around like they do today.

> I'm happy with per-driver responsibilities.  Less so with the notion
> of conflating power states and performance modes; they seem a bit more
> orthogonal to me.

They tend to be very tied in practice though ...

> On the other hand, I've also described the role of a driver suspend()
> call as just picking one of potentially many device power states that
> are compatible with the target (system) state, and I think there's
> common ground there.  If the "very low" device power state is compatible,
> nobody should care ... because the request to the driver should have been
> "become compatible with this system power state", and only in unusual
> cases (sysfs requests) "go into this device power state".
> 
> So, two types of request to drivers then.  The main one would be to
> become compatible with a given system power state; flexible.  The
> inflexible one would be to go into a specific device power state.

But a device power state has an impact on childs of this device, thus
the dependency issue. I am not talking about system states here. Unless
you want to completely phase out dyamic PM of busses...

> The handful of drivers that deal with dependencies can be responsible
> for that ordering.  They should be able to delegate much of the work
> to PM core code (else why have a PM core?).

No, I don't agree. That would be huge code duplication with different
kinds of bugs in <name all busses in linux, and that is a LOT> 

> I suspect that having all device states in some sort of order like that
> is a problem isomorphic with the Grand Unified Theory of PM, which I
> said we shouldn't try to derive.

Bla bla bla bla... I am NOT proposing a f*king Grand Unified Whatever,
I'm proposing a _model_ which should deal with a vast majority of issues
with a simple driver side API, period. I'm not trying to put in
everything nor all the crazy cases. It seems you are reasoning in an
all-or-nothing way, and since all is not desirable nor even possible in
a sane way, then you say, let's do nothing. I do NOT agree.

> If the drivers that deal with dependencies -- "bridge" drivers, for
> now -- can tell the PM core what to do with a given device (before
> me, after me, skip it) the PM core could just ask those bridge drivers
> to build a list, then walk the list issuing the right calls.  Instead
> of having a single global list, build it on demand.
> 
> - Dave
-- 
Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>


--===============55270178125286007==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============55270178125286007==--
