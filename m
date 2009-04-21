From: "Premi, Sanjeev" <premi@ti.com>
Subject: Re: Adding PM QoS parameters
Date: Wed, 22 Apr 2009 01:32:58 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D6F6DE69@dbde02.ent.ti.com>
References: <mailman.459.1240339694.10269.linux-pm@lists.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <mailman.459.1240339694.10269.linux-pm@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Sorry, picking-up thread late...

> Date: Tue, 21 Apr 2009 10:08:18 +0200
> From: Derkling <derkling@gmail.com>
> Subject: Re: [linux-pm] Adding PM QoS parameters
> To: linux-pm@lists.osdl.org
> Cc: Matteo Carnevali <rekstorm@gmail.com>,	David Siorpaes
> 	<david.siorpaes@st.com>,	Stefano Bosisio 
> <stebosisio@gmail.com>
> Message-ID:
> 	<aa8983610904210108v6490ee58hfa47ef126dca0f7d@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1
> 
> On Wed, Apr 15, 2009 at 20:35, mark gross 
> <mgross@linux.intel.com> wrote:
> > > Hi,
> > >    we are a group that since some months is working on 
> "Constrained Power
> > > Management" in STMicroelectronics.
> >
> > I would like to hear what your ideas are around applying 
> constraints to
> > power management!  The notion of constraint based PM has 
> been rattling
> > around, in my head and elsewhere, for a while now (a couple 
> of years).
> > PMQoS is just an early application of it.  I think a lot 
> more could be
> > done in this area.
> 
> We are working on the concept of constrained power management 
> since the times
> of DPM.
> We ported that framework to Nomadik platform and then we 
> started reasoning on a
> different implementation with the aims of overcoming its main 
> drawbacks.
> 
> In the meantime pm_qos had been released and since then, this 
> topic, i.e.
> constrained power management (CPM), has officially become the 
> main subject of my
> PhD study; I agree with you that a lot can be done in this area.
> 
> In the last few months have focused on these tasks:
> 1. define a formal model to state the CPM problem (based both 
> on linear
> programming and constraint programming)
> 2. evaluate pm_qos with respect to this formal model and highlight its
> potential wekenesses
> 3. identify an extension/refactoring of pm_qos in order to 
> overcame its
> limitations and perhaps advance the proposal for a more 
> general implementation
> 4. code a first release of the proposal and submit it to the 
> community for a
> review ... and now we are at THIS fourth step.
> 
> > Recently I've been thinking about re-factoring PMQoS in 
> possibly crazy
> > ways with the goal of somehow supporting a more generic constraint
> > notion without making the PMQoS ABI into a free for all.
> 
> Our re-factoring is for sure quite crazy. The proposal 
> inherits many ideas and
> concepts from both DPM and PM_QoS, perhaps only the strenghts 
> of these two
> frameworks:
> - from DPM the concept of Operating Points (OP) (but don't 
> worry: it has been
> 	highly reworked)
> - from PM_QoS the concept of "aggregation function" for 
> constraint management
> 
> The idea is still to consider the framework to be simply a 
> "constraint manager"
> that supports a "distributed power management model".
> In such a model each driver usually runs its own local 
> optimization policy
> (e.g. cpufreq), but at the same time exchanges some 
> information with the rest of
> the system in order to either require or provide QoS levels
> (e.g. admitted latency).

Would like to see more of this before real comment; because I
am trying to see what could happen if 2 drivers sharing a
common parent clock try to change the freq in 2 different
directions.

> 
> In this big picture PM_QoS works quite well, but perhaps we 
> have spotted two
> limitations to be better investigated:
> 1. it is a "best-effort" framework
> 2. it does not handle properly "additive constraints"
> 
> * Best-effort: pm_qos cannot grant that a required QoS level 
> can be effectively
> provided, and even worst pm_qos don't provide mechanisms to 
> notify a constraint
> requester that the required qos level cannot be satisfied by 
> other components.
> This can turn into a "misconfiguration" of a device: its 
> local policy configure
> itself expecting the required level even when actually it's 
> impossible to get
> that.
> No one notifies the device about the effective QoS levels that can be
> reached; all that other devices can do it is only the best 
> they can in order to
> grant the required level.
> Can that leads to an only sub-optimal power optimization for 
> the device
> requesting the constraint? We have this suspect...

Once a requested level is achieved the requester should be
notified for possible reconfiguration. It could be via an
optional registration.

> 
> * additive constraints: pm_qos perhaps does not properly 
> aggregate constraints
> requests on shared resources.
> If multiple applications assert a bandwidth (or throughput) 
> request: pm_qos
> aggregate them considering the MAX (or MIN) of the collected requests:
> this seems to be not properly correct.
> We think that in this case (e.g. bandwidth) the driver of the 
> service provider
> should be aware of the "accumulated" requests to properly 
> configure itself and
> satisfy all concurrent requirements.
> We define "additive constraints" those that refer to shared resources
> (e.g. bandwidth). They differ from "restrictive constraints" 
> (e.g. latency)
> since the aggregation function cannot be a simple 
> "bound-value" (i.e. max
> or min) but should be an "sum-value" in order to get the real 
> system-wide QoS
> requirement.
> These considerations made us thinking about a rework on 
> pm_qos in order to build
> a more comprehensive framework able to:
> - properly handle both restrictive and additive constraints
> - provide an agreement mechanism that allows to notify 
> constraint requester
> about real system run-time capabilities.

So, again we are again looking at means to add more constraints
and also the "kind" of constraint.

> 
> These are basically the ideas behind our rework. As soon as 
> it will be ready we
> will deliver the code for review. In the meantime we are also 
> producing a paper
> describing in details theoretical foundation of the model we 
> advance and its
> implementation.
> 
> > > I think that a good trade-off between "LKML control on 
> new parameters" and
> > > "platform extensibility" is hard to identify if we don't 
> refine the concept of
> > > QoS parameters first.
> > > The QoS params defined by pm_qos should avoid to be 
> not-sufficiently general,
> > > to be really useful to applications, but also avoid to be 
> too much abstract to
> > > support platform-specific capabilities.

We could start with a smaller set, e.g.:
- Interrupt latency (in lieu of DMA latency)  
- Sleep lateny (to control sleep in absence of cpuidle)
- Cpu frequency
- Cpu voltage

Of course, when we extend this to SoCs with multiple
CPUs then we do have (possible) need of multiplicity
if one of these has to act as "master".

e.g. OMAP3 allows ARM and IVA voltages and frequency
to be changed independently.

> > > Since anyway the core pm_qos implementation is 
> sufficiently general to handle
> > > both abstract and platform-specific params, maybe we 
> should better distinguish
> > > among "abstract qos parameters" (AQP) and 
> "platform-specific qos parameters"
> > > PQP).
> > >
> > > AQP should be intended to be used by applications to 
> assert abstract
> > > requirements on system behaviors, while PQP can be added 
> by platform code in
> > > order to enable the "constrained power management paradigm" for
> > > architecture/board specific devices.
> >
> > Maybe.

On the first read, I believe abstract parameter+level combination
can help us achieve the appliation portability across architectures
and allow specific map most suitable for each arch.

> In our model platform code can define both platform-specific 
> and architecture
> independent constraints. The formers, since are architecture 
> specific, can be
> exposed read-only to user-space (e.g. just to be used for 
> debugging purpose).
> The latter instead can be exposed read-write and applications 
> can assert
> requirements on them. These constraints should be 
> sufficiently abstract to be
> platform independent and generally usable to express 
> high-level requirements for
> an application (e.g. the network bandwidth a VoIP application 
> requires).
> 
> A device drivers is in charge to "maps" abstract parameters 
> on its own specific
> params and eventually on other platform-specific parameters, 
> whenever they are
> platform driver (e.g. a network driver can map a bandwidth 
> request on a
> platform-specific constraint on dma-latency or amba-bus throughput).
> 

I am not sure if I understood this completely, but I believe
that abstract -> specific mapping should be done at system level.
Letting drivers define them, may not be portable; and might lead
to more confusion.

> > > In this hypothesis the better solution would be to use a 
> dynamic data structure
> > > that will be initialized by the core itself to contain 
> just the set of AQP that
> > > has been reviewed and approved by LKML.
> > > Platform code will then have the chance to add its own 
> specific parameters too.
> > >
> > > Moreover we could imagine that AQP will be exported to 
> user-land, in order to
> > > be asserted by application software, while PQP may be 
> hidden within the core
> > > and accessible only by platform drivers.
> > >
> >
> > I don't know if we can keep any PQP interfaces kernel only.  Policy
> > managers really like to run in user mode, even if its just 
> to set the
> > constraints.
> 
> This is not what is actually going on with both cpufreq and cpuidle.
> Really few clients of pm_qos exist now, but among them the 
> kernel-space running
> policy seems to be the more widely adopted solution... may be 
> because of
> efficiency? User-space can still be in charge of choosing the 
> policy/governor,
> but then it's up to this piece of code to manage constraints requests.
> In the case of it needs having a user-space policy, a simple 
> kernel-space
> wrapper defining a "forwarding policy" will be sufficient to 
> expose the required
> PQP to user-space.
> 
> 
> > > I agree: user-land accessible params should be 
> platform-independent and define
> > > a portable API for applications.
> > > This requires also to have sufficiently abstract 
> parameters: e.g. network
> > > bandwidth can be easily asserted by an application while 
> cpu-dma-latency is
> > > perhaps too difficult to identify at application level.
> >
> > DMA latency is a somewhat sucky name for constraining CPU Idle /
> > C-states, but I can't think of a better name.
> 
> I understand, but: is it so common to have user-space code 
> that needs to assert
> such "real-time" requirements? It seems to us that user-land 
> should be given
> access only to sufficiently abstract constraints that roughly 
> define system
> requirements. While more architecture-specific constraints 
> should come from
> drivers. This should improve solution portability, isn't it?

Or, the drivers should 'map' their constraints onto arch
specific constratints making them portable. e.g. we wouldn't like
an ethernet driver tied to one arch/platform... even with most
of this mapping in a platform specific code. 

> 
> 
> > As I type this reply I'm thinking an ok way could be to 
> re-factor PMQoS
> > into a constraint framework that exposes platform specific 
> constraint
> > ABI's (in some TBD sane manner---somehow), and set PMQoS on 
> top of this
> > keeping same ABI and KABI's stable.

Agree.

> 
> Are you thinking to something like an abstract API that each 
> platform code
> should implements in its own way?
> 
> > I could use some input on the way folks anticipate a constraint
> > infrastructure to be used.  How hot could the code paths 
> be?  How complex
> > could the dependencies and inter dependencies become?
> 
> These are interesting questions! We should deepen those 
> aspects, anyway we think
> that dependencies, e.g. among constraints, can also be an 
> interesting concept in
> order to build modular solutions.
> In instance the mapping that a driver needs to provide between an
> (platform-independent) abstract constraint and a 
> platform-specific one should
> allow to write more portable drivers that:
> 1. tune on platform-independent requirements
> 2. translate abstract requirements into platform-specific ones
> 
> > Am I thinking about taking a walk on a slippery slope?

...if we get rope closer to ground, gravity doesn't harm much!

> >
> > > > 2) is it the right thing to keep pm-qos-params a 
> compile time array and
> > > > control the growth of the ABI via these mailing lists 
> or make it a list
> > > > and enable driver creation of new parameters as they wish.
> > >
> > > In my opinion a mixed approach, using a dynamic data 
> structure, could be more
> > > interesting to target both requirements.
> > >
> > > > Both are good things for us to discuss on the list.
> > >
> > > We are tuned on this thread and happy to contribute to 
> the discussion.

Generic params that impact the apps could/should be an array;
while arch/plat specific ones could be a linked list.

Best regards,
Sanjeev

> >
> > very cool.
> 
> It will be interesting even just to have some shared ideas on 
> the table before
> the upcoming LPC.
> 
> Best regards,
> Patrick
> 
> 
> --
> #include <best/regards.h>
> 
> DERKLING
> LRU 338214 (http://counter.li.org)
> 
