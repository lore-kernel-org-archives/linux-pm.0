From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Alternative Concept [Was: Re: [RFC] CPUFreq PowerOP
	integration, Intro 0/3]
Date: Wed, 25 Oct 2006 23:06:42 -0400
Message-ID: <20061026030642.GB18549@dominikbrodowski.de>
References: <44ECFF94.3030506@gmail.com>
	<20061007023620.GD30380@dominikbrodowski.de>
	<20061009182123.GA1714@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061009182123.GA1714@linux.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Mark Gross <mgross@linux.intel.com>
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Mon, Oct 09, 2006 at 11:21:23AM -0700, Mark Gross wrote:
> > D) Verification
> i.e. constraint checking and enforcement

Exactly.

> > Let's assume that there is an OMAP1 PM module which implements a ->set =
and
> > ->get function for all of them. A yet-to-be-defined interface then tells
> > this PM module
> > =

> > "I want to increase the CPU frequency from C1 MHz to C2 MHz!"
> > =

> > ->set(CPU_VLTG, C2);
> did you mean ->set(CPU, C2) ?

Yes, sorry about the confusion.

> > The core would determine that the latter two states are now allwed, and
> > using some sensible algorithm (e.g. "where do I not have to switch too =
many
> > knobs", or minimize the costs of switching) decide between those two.
> > Basically, it would recignize now that it is OK to proceed from state N=
r. 1
> > to Nr. 3, but that this means that "tc" also needs to be changed. After
> > notifing relevant subsystems using the clock and voltage frameworks, it
> > would then proceed to set the hardware accordingly.
> =

> This adds a sort of tree search defining a power state path from a
> current state to one of the possible target stats with C2.  In this case
> the only way to get to CPU=3D=3DC2 is to change TC to D2 and deal with all
> the ripples that will cause.
> =

> One question is how do we know that changing TC is a better way to go
> than changing CPU_VLTG?  We'll need to figure out an ordering in the
> phase space of power states.  Thinking out loud, I would try to pick the
> target state based on latency if there are more than one targets to
> satisfy the ->set() request.

That sounds like an interesting approach.

> > I think that this might be much easier to implement than your PowerOP /
> > operating points / PM core / PowerOP - cpufreq interaction patches. As a
> > matter of fact, some parts of your operating points table infrastructure
> > may be usable for the concept outlined above. So, what do you think? Wh=
at
> > does everyone else involved think about this alternative approach?
> > =

> =

> I still see a need to take the first step of enabling "lots of knobs".
> This is the primary goal of the PowerOp patch set.  The stuff with the
> sysfs is just an interface to set/get the operating points while a
> more complete solution like what you are talking about evolves.

Unfortunately, PowerOp gets the "lots of knobs" on its head, in my
opinion...

Thanks,
	Dominik
