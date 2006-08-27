From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Sun, 27 Aug 2006 13:54:31 -0700
Message-ID: <c55240ed0608271354o7224c903l8b9eae6de22ca8c6@mail.gmail.com>
References: <20060814200735.GC14099@kroah.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com> <20060815010020.GA14251@kroah.com>
	<b324b5ad0608182319y307210a3w6389c83482e43ab8@mail.gmail.com>
	<20060819184843.GB15644@redhat.com>
	<b324b5ad0608192020n6584f749h501e05e141b1f557@mail.gmail.com>
	<20060820033044.GA24928@redhat.com>
	<b324b5ad0608262137y24cfb843kb03476a22e462516@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <b324b5ad0608262137y24cfb843kb03476a22e462516@mail.gmail.com>
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
To: David Singleton <daviado@gmail.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

2006/8/26, David Singleton <daviado@gmail.com>:
> On 8/19/06, Dave Jones <davej@redhat.com> wrote:
> > On Sat, Aug 19, 2006 at 08:20:45PM -0700, David Singleton wrote:
> >
> >  > If I had all the existing cpufreq tables transformed
> >  > into operating points I could make a patch that would remove
> >  > the bulk of cpufreq code from the kernel and you'd have
> >  > pretty much the same functionality without the maintenance
> >  > issues the added layers and complexity bring.
> >
> > If this is going to fly at all, I think thats where we need to be heade=
d.
> > Having two parts of the kernel doing the same thing just seems
> > very wrong to me.
> >
> > The other alternative as suggested earlier this week would be archictur=
es
> > getting to 'opt out' of powerop for their cpufreq drivers where it does=
n't
> > necessarily bring anything but the layer of indirection.
> >
> > I'm about to disappear for two weeks for a much needed vacation, but
> > I'll be interested to see other folks comments/opinions on this
> > when I get back.
>
[snip]
>        1) I believe I now have the right kernel interface for a common
>        power management infrastructure.
>
OpPoint continues to focus on user space interface development for
power management in contrast to that there seem to be an agreemment in
the comunity to defer this integration due to in fact quite a lot of
open/undiscussed and complex questions about this integration and
instead to focus on getting a consensus on operating point structure
definition and methods to work with the structure instances.

OpPoint continues to focus on integration with CPUFreq in a manner
which was outlined as an anacceptable during recent discussions on the
list - removing the concept of a inkernel governor and most of the
CPUFreq feature code.

OpPoint continues to develop userspace interfaces and integration
based on operating point definition for which Matt and I posted
issues/questions several time and the posts have been left without a
reply.

Below I'm trying to summurize all issues I see with OpPoint approach
sometimes using terms defined in PowerOP approach (for example layer
names).

'struct powerop' definition
------------------------------------
- frequency, voltage fields are arch specific: not to mention any
complex embedded case but current definition and OpPoint
implementation does not work even for x86 SMP case.

- latency is not an attribute of a certain operating point but a function of
two arguments - current operating point and a point we are goint to
switch to. Therefor latency just does not belong to 'struct powerop'

- all hooks are redundant: the hooks are the same for all operating points
untill we come to the integration with suspend/resume. But we believe the
intagration needs more investigation at the first place and at the second we
feel like the integration may be handled on PM Core layer instead
of having per operating point hooks

- prepare_transition and finish_ransition may be moved even below PM Core to
clock/voltage framework; needs more carefull investigation though

- md_data has an issue from OO design paradigm perspective.  OpPoint
requires an entity above PowerOP to know internals of arch md_data (see
centrino-dynamic-powerop.c implementation) and thus requires an arch
dependent header file to be included in the code which can be
impemented in arch independent manner. That would be fine if there was
no solution to achieve required functionality without such a hack but
PowerOP provides such approach by dereferencing  power parameters by
name. File which implements operating points registration in PowerOP
approach does not include any header file from include/asm-* subtrees.

All further pieces porposed by OpPOint base on the above incorrect
design of the main structure and therefore have issues.

integration with suspend/resume
-------------------------------
- mixing system state and operating point concept (different points
may correspond to a sleep/standby system state)

- legacy PM states are redefined via new OpPOint interface but do not
use it (explicit 'if' statements in legacy pm code instead of OpPOint
hooks uilization)

- names for operating points presented in the original letter below
implicitly assumed the points are ranged by some order (now it is from
the highest [power comsumption] to the lowest. However having many
more power parameters than just one freq and one voltage does not
allow to range the points in such a way and a string name without
knowledge of a particular power parameter values is not sufficient
(even in x86 SMP case: not to mention it's hard to me to express SMP
case in current OpPOint terms but what are names and how to
distinguish/range 2 CPUs system states corresponded to 'highest point
for CPU0 + medium for CPU1' against 'low for CPU0 + high for CPU1' ?)

- no example of (at least optional) capability to export information about
particular power paramenter is presented while it was obviously
highlighted by embedded community that it is a must

- direct utilization of PM internal structure 'pm_state' instead of an atte=
mpt
of an API

cpufreq core and a cpufreq driver/OpPOint integration
-------------------------------
- integration with legacy cpufreq interface is completely missing in both a=
rch
(x86 and pxa) examples. If OpOint was a universal approach it would
allow to build different interfaces on top of it. In this case you can
porpose more optimized/improved interface if you feel existed
interface has issues leaving existed interface as a [configurable]
option and remove it when agreed.

- while clear desgin and interfaces are outlined for so called PM Core
layer by PowerOP approach this layer is not addressed by OpPoints in
any way

- a cpufreq driver still should contains code to access arch hardware
while the functionality of cpufreq driver falls into PM Core layer and
there is no longer reason to have the functionality related to cpufreq
concept

- no any integration with clock/voltage framework. Integral solution
which includes Clock/voltage framework just saves more power [period].

x86 cpufreq/OpPoint integration
-------------------------------
- struct powerop hooks are expected to be arch specific but intialized by s=
ome
cpufreq core routines

- cpufreq driver still shares cpufreq core cpufreq_frequncy_table structure

- integration with legacy cpufreq interface is completely missing

- OpPoint design does not handle SMP case.

PowerOP addresses all the issues mentioned above and works for SMP
case. Integration with legacy kernel PM code (including constraints
and standalone driver suspend/resume) and a certain userspace
interface (basically which can be any having current PowerOP interface
underneath) are the next steps for PowerOP approach  once the correct
brick of PowerOP layer is in place.

 Eugeny
