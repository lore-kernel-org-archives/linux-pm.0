From: "David Singleton" <daviado@gmail.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Mon, 28 Aug 2006 18:29:27 -0700
Message-ID: <b324b5ad0608281829t66bb3060r9fda9fc08841b51@mail.gmail.com>
References: <20060814200735.GC14099@kroah.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com> <20060815010020.GA14251@kroah.com>
	<b324b5ad0608182319y307210a3w6389c83482e43ab8@mail.gmail.com>
	<20060819184843.GB15644@redhat.com>
	<b324b5ad0608192020n6584f749h501e05e141b1f557@mail.gmail.com>
	<20060820033044.GA24928@redhat.com>
	<b324b5ad0608262137y24cfb843kb03476a22e462516@mail.gmail.com>
	<c55240ed0608271354o7224c903l8b9eae6de22ca8c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <c55240ed0608271354o7224c903l8b9eae6de22ca8c6@mail.gmail.com>
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
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On 8/27/06, Eugeny S. Mints <eugeny.mints@gmail.com> wrote:
> 2006/8/26, David Singleton <daviado@gmail.com>:
> > On 8/19/06, Dave Jones <davej@redhat.com> wrote:
> > > On Sat, Aug 19, 2006 at 08:20:45PM -0700, David Singleton wrote:
> > >
> > >  > If I had all the existing cpufreq tables transformed
> > >  > into operating points I could make a patch that would remove
> > >  > the bulk of cpufreq code from the kernel and you'd have
> > >  > pretty much the same functionality without the maintenance
> > >  > issues the added layers and complexity bring.
> > >
> > > If this is going to fly at all, I think thats where we need to be hea=
ded.
> > > Having two parts of the kernel doing the same thing just seems
> > > very wrong to me.
> > >
> > > The other alternative as suggested earlier this week would be archict=
ures
> > > getting to 'opt out' of powerop for their cpufreq drivers where it do=
esn't
> > > necessarily bring anything but the layer of indirection.
> > >
> > > I'm about to disappear for two weeks for a much needed vacation, but
> > > I'll be interested to see other folks comments/opinions on this
> > > when I get back.
> >
> [snip]
> >        1) I believe I now have the right kernel interface for a common
> >        power management infrastructure.
> >
> OpPoint continues to focus on user space interface development for
> power management in contrast to that there seem to be an agreemment in
> the comunity to defer this integration due to in fact quite a lot of
> open/undiscussed and complex questions about this integration and
> instead to focus on getting a consensus on operating point structure
> definition and methods to work with the structure instances.

Actually OpPoint is focusing on all the interfaces, user-kernel,
kernel-architecture
independent - power management interfaces, and power management framework -
architecture/platform specific interfaces.

>
> OpPoint continues to focus on integration with CPUFreq in a manner
> which was outlined as an anacceptable during recent discussions on the
> list - removing the concept of a inkernel governor and most of the
> CPUFreq feature code.

The point of OpPoint is to show that a unified power management infrastruct=
ure
is possible and that bolting on another power management infrastructure to
the kernel is not the right approach.

OpPoint is not trying to replace cpufreq.  It's trying to unify all
the power management
infrastructures into a a single infrastructure.  OpPoint uses the
cpufreq notifier
infrastructure to do both operating opoint transition and driver
scaling notification,
and it performs the same basic functions as cpufreq, without the
policy and governor
code.  It is also performing all the same Dynamic Power Management function=
ality
on the pxa27x mainstone.  The point is one infrastructure can support them.

And with the new oppointd power daemon it is performing all the same functi=
ons
as cpuspeed did on my laptop, just with a lot less code in the kernel.


>
> OpPoint continues to develop userspace interfaces and integration
> based on operating point definition for which Matt and I posted
> issues/questions several time and the posts have been left without a
> reply.

Sorry, I'm having a hard time keeping up with all the email threads.

>
> Below I'm trying to summurize all issues I see with OpPoint approach
> sometimes using terms defined in PowerOP approach (for example layer
> names).
>
> 'struct powerop' definition
> ------------------------------------
> - frequency, voltage fields are arch specific: not to mention any
> complex embedded case but current definition and OpPoint
> implementation does not work even for x86 SMP case.

Actually frequency, voltage and latency fields are architecture independent
and a necessary peice of information that any power manager must have.

You are right, I have not yet put in the additional layer to support SMP
systems.  That is one of the pieces I'm still working on.

>
> - latency is not an attribute of a certain operating point but a function=
 of
> two arguments - current operating point and a point we are goint to
> switch to. Therefor latency just does not belong to 'struct powerop'

I disagree.

>
> - all hooks are redundant: the hooks are the same for all operating points
> untill we come to the integration with suspend/resume. But we believe the
> intagration needs more investigation at the first place and at the second=
 we
> feel like the integration may be handled on PM Core layer instead
> of having per operating point hooks

The hooks are not redundant nor the same for all operating points.  Each
operating point defines it's prepare, transition, and finish functions for =
the
hooks.  And different types of operating points may have completely differe=
nt
functions in those hooks, on the same platform.

>
> - prepare_transition and finish_ransition may be moved even below PM Core=
 to
> clock/voltage framework; needs more carefull investigation though


I disagree.  Both the pm suspend and cpufreq code has them in exactly
the same place.

>
> - md_data has an issue from OO design paradigm perspective.  OpPoint
> requires an entity above PowerOP to know internals of arch md_data (see
> centrino-dynamic-powerop.c implementation) and thus requires an arch
> dependent header file to be included in the code which can be
> impemented in arch independent manner. That would be fine if there was
> no solution to achieve required functionality without such a hack but
> PowerOP provides such approach by dereferencing  power parameters by
> name. File which implements operating points registration in PowerOP
> approach does not include any header file from include/asm-* subtrees.

No, the md_data is the opaque pointer into architecture dependent data.
The power management infrastructure doens't need to know what
data is linked into md_data, just as drivers have driver specific
structs that are opaque to the upper layers of software.

>
> All further pieces porposed by OpPOint base on the above incorrect
> design of the main structure and therefore have issues.

wow.

>
> integration with suspend/resume
> -------------------------------
> - mixing system state and operating point concept (different points
> may correspond to a sleep/standby system state)

The pxa27x code shows that indeed there are more than one suspsend state,
which is why the operating point model works so well on both my
centrino laptop and my pxa27x mainstone running the same oppointd
power daemon.

>
> - legacy PM states are redefined via new OpPOint interface but do not
> use it (explicit 'if' statements in legacy pm code instead of OpPOint
> hooks uilization)

The enter_state code could be merged into the pm_change code, or vice versa,
I haven't had time to make it really unified and pretty.

>
> - names for operating points presented in the original letter below
> implicitly assumed the points are ranged by some order (now it is from
> the highest [power comsumption] to the lowest. However having many
> more power parameters than just one freq and one voltage does not
> allow to range the points in such a way and a string name without
> knowledge of a particular power parameter values is not sufficient

That's not quite correct.  The ordering of names, lowest to highest,
allows the power manager daemon to cover most of the use cases
right out of the box.  It's performing the same functions on both
my centrino laptop and the pxa27x mainstone right now without
any changes to either the power manager or power managenment
config file.

One of the next boards I'm working on has different operating points
at the same frequency, but different voltages.  All that is realy required
to support this a plugin to the power manager that understand the
different operating points so it can best choose when to transition to
each point.

Custom plugins to a power manager that lets the power manager deal
with the unique set of operating points on a particular platform is
one of the really attractive parts of OpPoint.  It won't have to be
woven into the kernel.

> (even in x86 SMP case: not to mention it's hard to me to express SMP
> case in current OpPOint terms but what are names and how to
> distinguish/range 2 CPUs system states corresponded to 'highest point
> for CPU0 + medium for CPU1' against 'low for CPU0 + high for CPU1' ?)

I'm still working on the SMP case.  It's not that I'm ignoring it. Give me
a few more days.

>
> - no example of (at least optional) capability to export information about
> particular power paramenter is presented while it was obviously
> highlighted by embedded community that it is a must


Which parameters besides frequency, voltage and latency are required
to be exported to the power manager?

>
> - direct utilization of PM internal structure 'pm_state' instead of an at=
tempt
> of an API
>
> cpufreq core and a cpufreq driver/OpPOint integration
> -------------------------------
> - integration with legacy cpufreq interface is completely missing in both=
 arch
> (x86 and pxa) examples. If OpOint was a universal approach it would
> allow to build different interfaces on top of it. In this case you can
> porpose more optimized/improved interface if you feel existed
> interface has issues leaving existed interface as a [configurable]
> option and remove it when agreed.

I'm sorry, I don't understand that statement.  I'm still opposed to
dynamic-on-the-fly construction of operating points.  It's really dangerous.
The hardware vendors want it so that new hardware doesn't have to
wait for software before they can sell it.

The cpufreq structure of defining and validating operating points before be=
ing
integrated into the kernel is the correct way to do it, in my opinion.

>
> - while clear desgin and interfaces are outlined for so called PM Core
> layer by PowerOP approach this layer is not addressed by OpPoints in
> any way

correct.  They are a different design.

>
> - a cpufreq driver still should contains code to access arch hardware
> while the functionality of cpufreq driver falls into PM Core layer and
> there is no longer reason to have the functionality related to cpufreq
> concept

Is this a statement about PowerOP?  OpPoint doesn't use the PowerOp
PM Core  layer definition.  OpPoint only has 3 layers:

  1) user space power manager and user-kernel interace.

  2) architecture independent layer between the kernel and the power managm=
ent
      infrastructure.

  3) The architecture dependent layer that does the work and has to touch
      all the hardware.  The architecture dependent layer is the piece where
      where the hardware specific operating points and functions to transit=
ion
      to the operating points are defined.

 This is also why it's so simple to add new architecture and platform suppo=
rt.
All that is needed is the architecture dependent portion to support a new
platform.


>
> - no any integration with clock/voltage framework. Integral solution
> which includes Clock/voltage framework just saves more power [period].

No so.  The mainstone uses the existing <linux/clk.h> clock framework,
and it must
since it supports so many different clocks to transition to a new
operating point.
I'm still open to integrate with any new voltage framework, I just haven't =
seen
it yet.

I also don't believe it will be a problem integrating with voltage
framework. The
voltage framework will be needed by the architecture dependent pieces of
power management and a common voltage framework will just make it
easier.


>
> x86 cpufreq/OpPoint integration
> -------------------------------
> - struct powerop hooks are expected to be arch specific but intialized by=
 some
> cpufreq core routines
>
> - cpufreq driver still shares cpufreq core cpufreq_frequncy_table structu=
re

Correct, the cpu_frq table structure is the piece that gets the gets
the frequency
and voltage right.  I'm not changing operating points definition for
the existing processor line.   I'm just simplifying the transition to
and from the existing system states.

>
> - integration with legacy cpufreq interface is completely missing

Not quite.  Once the operating points are constructed, from the
same validated data, the oppointd daemon can perform the
same legacy cpufreq functionality.  Governor and policy code moves
out of the kernel into the power manager.  It integrates through the same
cpufreq table data, the same cpufreq notifier lists for transitioning and
scaling drivers, and moves policy management code out of
the kernel into the power daemon.

>
> - OpPoint design does not handle SMP case.
>
> PowerOP addresses all the issues mentioned above and works for SMP
> case. Integration with legacy kernel PM code (including constraints
> and standalone driver suspend/resume) and a certain userspace
> interface (basically which can be any having current PowerOP interface
> underneath) are the next steps for PowerOP approach  once the correct
> brick of PowerOP layer is in place.

It does?

David

>
>  Eugeny
>
