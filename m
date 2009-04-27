From: Matteo Carnevali <rekstorm@gmail.com>
Subject: Re: Adding PM QoS parameters
Date: Mon, 27 Apr 2009 14:50:22 +0200
Message-ID: <50855c020904270550m3fc3d2aanc2a150715937667f@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CC66C7DE@dbde02.ent.ti.com>
	<20090406211237.GA25173@linux.intel.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC7972A5@dbde02.ent.ti.com>
	<20090409185738.GA26224@linux.intel.com>
	<loom.20090414T111905-377@post.gmane.org>
	<20090415183545.GA3679@linux.intel.com>
	<aa8983610904210108v6490ee58hfa47ef126dca0f7d@mail.gmail.com>
	<20090421234320.GA13911@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1660212367981945705=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090421234320.GA13911@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mgross@linux.intel.com
Cc: Patrick Bellasi <derkling@gmail.com>, David Siorpaes <david.siorpaes@st.com>, linux-pm@lists.osdl.org, Premi Sanjeev <premi@ti.com>, Stefano Bosisio <stebosisio@gmail.com>
List-Id: linux-pm@vger.kernel.org

--===============1660212367981945705==
Content-Type: multipart/alternative; boundary=001636c5b18421df49046888ca22

--001636c5b18421df49046888ca22
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Wed, Apr 22, 2009 at 1:43 AM, mark gross <mgross@linux.intel.com> wrote:

> On Tue, Apr 21, 2009 at 10:08:18AM +0200, Derkling wrote:
> > On Wed, Apr 15, 2009 at 20:35, mark gross <mgross@linux.intel.com>
> wrote:
> > > > Hi,
> > > >    we are a group that since some months is working on "Constrained
> Power
> > > > Management" in STMicroelectronics.
> > >
>

Hi, I'm Matteo Carnevali and I'm working in ST with Patrick on the topic of
CPM.


>
> > > I would like to hear what your ideas are around applying constraints to
> > > power management!  The notion of constraint based PM has been rattling
> > > around, in my head and elsewhere, for a while now (a couple of years).
> > > PMQoS is just an early application of it.  I think a lot more could be
> > > done in this area.
> >
> > We are working on the concept of constrained power management since the
> times
> > of DPM.
> > We ported that framework to Nomadik platform and then we started
> reasoning on a
> > different implementation with the aims of overcoming its main drawbacks.
> >
> > In the meantime pm_qos had been released and since then, this topic, i.e.
> > constrained power management (CPM), has officially become the main
> subject of my
> > PhD study; I agree with you that a lot can be done in this area.
>
> cool.
>
> > In the last few months have focused on these tasks:
> > 1. define a formal model to state the CPM problem (based both on linear
> > programming and constraint programming)
> > 2. evaluate pm_qos with respect to this formal model and highlight its
> > potential wekenesses
> > 3. identify an extension/refactoring of pm_qos in order to overcame its
> > limitations and perhaps advance the proposal for a more general
> implementation
> > 4. code a first release of the proposal and submit it to the community
> for a
> > review ... and now we are at THIS fourth step.
> >
>
> also cool.
>
> > > Recently I've been thinking about re-factoring PMQoS in possibly crazy
> > > ways with the goal of somehow supporting a more generic constraint
> > > notion without making the PMQoS ABI into a free for all.
> >
> > Our re-factoring is for sure quite crazy. The proposal inherits many
> ideas and
> > concepts from both DPM and PM_QoS, perhaps only the strenghts of these
> two
> > frameworks:
> > - from DPM the concept of Operating Points (OP) (but don't worry: it has
> been
> >       highly reworked)
> > - from PM_QoS the concept of "aggregation function" for constraint
> management
> >
> > The idea is still to consider the framework to be simply a "constraint
> manager"
> > that supports a "distributed power management model".
> > In such a model each driver usually runs its own local optimization
> policy
> > (e.g. cpufreq), but at the same time exchanges some information with the
> rest of
> > the system in order to either require or provide QoS levels
> > (e.g. admitted latency).
> >
> > In this big picture PM_QoS works quite well, but perhaps we have spotted
> two
> > limitations to be better investigated:
> > 1. it is a "best-effort" framework
>
> this is a hard nut to crack, if you get anywhere on it do let me know!
>
> > 2. it does not handle properly "additive constraints"
>
> this is easier to address.
>
> >
> > * Best-effort: pm_qos cannot grant that a required QoS level can be
> effectively
> > provided, and even worst pm_qos don't provide mechanisms to notify a
> constraint
> > requester that the required qos level cannot be satisfied by other
> components.
> > This can turn into a "misconfiguration" of a device: its local policy
> configure
> > itself expecting the required level even when actually it's impossible to
> get
> > that.
> > No one notifies the device about the effective QoS levels that can be
> > reached; all that other devices can do it is only the best they can in
> order to
> > grant the required level.
> > Can that leads to an only sub-optimal power optimization for the device
> > requesting the constraint? We have this suspect...
>
> There is room to grow here.
>
> >
> > * additive constraints: pm_qos perhaps does not properly aggregate
> constraints
> > requests on shared resources.
> > If multiple applications assert a bandwidth (or throughput) request:
> pm_qos
> > aggregate them considering the MAX (or MIN) of the collected requests:
> > this seems to be not properly correct.
> > We think that in this case (e.g. bandwidth) the driver of the service
> provider
> > should be aware of the "accumulated" requests to properly configure
> itself and
> > satisfy all concurrent requirements.
> > We define "additive constraints" those that refer to shared resources
> > (e.g. bandwidth). They differ from "restrictive constraints" (e.g.
> latency)
> > since the aggregation function cannot be a simple "bound-value" (i.e. max
> > or min) but should be an "sum-value" in order to get the real system-wide
> QoS
> > requirement.
>
> do a thought experiment around network bandwidth, where multiple
> applications ask for max bandwidth from the NIC.  (just like they all
> expect to 100% of the CPU resources)  You quickly get to a point where
> (just like for CPU resources) that aggregating cumulative QoS requests as
> a sum becomes silly.
>

Yes, if many applications all ask for the MAX bandwith from the NIC it is
not
relevant to aggregrate in an additive manner... and the problem turns into a
resource management one.

On the other hand I think at the case the NIC has multiple operating points,

defined by the local driver configuration, where each point can be
characterized,
 for instance, by a certain amount of power required to work and by a bound
 of bandwidth it can provide,
e.g. :
- 1 watt power consumption -> max 12 Mbit/s
- 2 watts power consumption -> max 24 Mbit/s
- 3 watts power consumption -> max 54 Mbit/s (full bandwidth)
in a dummy scenario like this it may be useful to aggregate bandwidth
requirement with an additive method, instead of max - min.


>
> I know there are applications that need hard real time and "hard QoS"
> from the platform, and the idea of building up an OS around the QoS
> notion is "interesting"(really), but it just didn't see how I could
> apply that to an initial implementation like pmqos.
>

pmqos was one of the starting point of our study and triggered our thoughts
and
our ideas.
We would like to develop an in-kernel framework that aims at optimizing the
trade-off between power-consumption and performances.
We are targeting embedded multimedia mobile devices, but all this work can
be
applied to other kind of devices like netbooks, laptops, desktops and even
servers.


>
> >
> > These considerations made us thinking about a rework on pm_qos in order
> to build
> > a more comprehensive framework able to:
> > - properly handle both restrictive and additive constraints
> > - provide an agreement mechanism that allows to notify constraint
> requester
> > about real system run-time capabilities.
> >
>
> It looks like some useful nuggets may come from your work.
>

we hope so.


>
> > These are basically the ideas behind our rework. As soon as it will be
> ready we
> > will deliver the code for review. In the meantime we are also producing a
> paper
> > describing in details theoretical foundation of the model we advance and
> its
> > implementation.
>
> very cool.
>
>
> >
> > > > I think that a good trade-off between "LKML control on new
> parameters" and
> > > > "platform extensibility" is hard to identify if we don't refine the
> concept of
> > > > QoS parameters first.
> > > > The QoS params defined by pm_qos should avoid to be not-sufficiently
> general,
> > > > to be really useful to applications, but also avoid to be too much
> abstract to
> > > > support platform-specific capabilities.
> > > > Since anyway the core pm_qos implementation is sufficiently general
> to handle
> > > > both abstract and platform-specific params, maybe we should better
> distinguish
> > > > among "abstract qos parameters" (AQP) and "platform-specific qos
> parameters"
> > > > PQP).
> > > >
> > > > AQP should be intended to be used by applications to assert abstract
> > > > requirements on system behaviors, while PQP can be added by platform
> code in
> > > > order to enable the "constrained power management paradigm" for
> > > > architecture/board specific devices.
> > >
> > > Maybe.
> >
> > In our model platform code can define both platform-specific and
> architecture
> > independent constraints. The formers, since are architecture specific,
> can be
> > exposed read-only to user-space (e.g. just to be used for debugging
> purpose).
> > The latter instead can be exposed read-write and applications can assert
> > requirements on them. These constraints should be sufficiently abstract
> to be
> > platform independent and generally usable to express high-level
> requirements for
> > an application (e.g. the network bandwidth a VoIP application requires).
> >
> > A device drivers is in charge to "maps" abstract parameters on its own
> specific
> > params and eventually on other platform-specific parameters, whenever
> they are
> > platform driver (e.g. a network driver can map a bandwidth request on a
> > platform-specific constraint on dma-latency or amba-bus throughput).
> >
> >
> > > > In this hypothesis the better solution would be to use a dynamic data
> structure
> > > > that will be initialized by the core itself to contain just the set
> of AQP that
> > > > has been reviewed and approved by LKML.
> > > > Platform code will then have the chance to add its own specific
> parameters too.
> > > >
> > > > Moreover we could imagine that AQP will be exported to user-land, in
> order to
> > > > be asserted by application software, while PQP may be hidden within
> the core
> > > > and accessible only by platform drivers.
> > > >
> > >
> > > I don't know if we can keep any PQP interfaces kernel only.  Policy
> > > managers really like to run in user mode, even if its just to set the
> > > constraints.
> >
> > This is not what is actually going on with both cpufreq and cpuidle.
> > Really few clients of pm_qos exist now, but among them the kernel-space
> running
> > policy seems to be the more widely adopted solution... may be because of
> > efficiency? User-space can still be in charge of choosing the
> policy/governor,
> > but then it's up to this piece of code to manage constraints requests.
> > In the case of it needs having a user-space policy, a simple kernel-space
> > wrapper defining a "forwarding policy" will be sufficient to expose the
> required
> > PQP to user-space.
>
>
> I need to think more about this when your code is available.
>

Ok, we are working hard on it!


>
> >
> > > > I agree: user-land accessible params should be platform-independent
> and define
> > > > a portable API for applications.
> > > > This requires also to have sufficiently abstract parameters: e.g.
> network
> > > > bandwidth can be easily asserted by an application while
> cpu-dma-latency is
> > > > perhaps too difficult to identify at application level.
> > >
> > > DMA latency is a somewhat sucky name for constraining CPU Idle /
> > > C-states, but I can't think of a better name.
> >
> > I understand, but: is it so common to have user-space code that needs to
> assert
> > such "real-time" requirements? It seems to us that user-land should be
> given
> > access only to sufficiently abstract constraints that roughly define
> system
> > requirements. While more architecture-specific constraints should come
> from
> > drivers. This should improve solution portability, isn't it?
> >
>
> cpu dma latency was chosen thinking it was a abstract / canonical
> notion across CPU architectures.  I guess idle-cpu-wake-up-latency may be
> slightly better.
>
> Hardware will only get better at being idle, the longer a system can
> do a low power idle the more likely user mode applications (policy
> managers mostly) will need API's to modify constraints.
>

You're right, but in our ideas we would like to exploit different hardware
devices' power states (not only the lowest idle state) and to select the
best
states (mapped to an operating mode of the device) in each instant, in order
to
grant the required performances and to waste as less power as we can.

So, both drivers and applications can set a constraint on an abstract
parameter
(like bandwidth and latency) e.g:
- Applications: ask for more network bandwidth or require a certain latency
on a
 bus, for example to decode a video stream.
- Drivers: if a driver realizes that it can set its controlled device in a
less
consuming operating mode while granting the QoS, it sets a constraint on the

abstract parameter that maps its operating modes on the whole system.

At this point of the game, applications' constraints are pushed down at
drivers'
level and drivers (that have a deep and complete knowledge of their internal

state, operating modes and hardware capabilities) "collaborate" to find an
agreement on the new value of the abstract parameter. In this way the best
(optimal or sub-optimal) system-wide configuration can be found.
Collaboration is achieved through shared knowledge of abstract parameters.


>
> >
> > > As I type this reply I'm thinking an ok way could be to re-factor PMQoS
> > > into a constraint framework that exposes platform specific constraint
> > > ABI's (in some TBD sane manner---somehow), and set PMQoS on top of this
> > > keeping same ABI and KABI's stable.
> >
> > Are you thinking to something like an abstract API that each platform
> code
> > should implements in its own way?
>
> no.
>
> But, I would like to make it easier for different architectures to add
> stuff like voltage constraints that don't really fit in a QoS only world
> without making a miss of the ABI.  Basically I'd like to keep those
> sorts of things off to the side and protect the ABI stability.
>
> >
> > > I could use some input on the way folks anticipate a constraint
> > > infrastructure to be used.  How hot could the code paths be?  How
> complex
> > > could the dependencies and inter dependencies become?
> >
> > These are interesting questions! We should deepen those aspects, anyway
> we think
> > that dependencies, e.g. among constraints, can also be an interesting
> concept in
> > order to build modular solutions.
> > In instance the mapping that a driver needs to provide between an
> > (platform-independent) abstract constraint and a platform-specific one
> should
> > allow to write more portable drivers that:
> > 1. tune on platform-independent requirements
> > 2. translate abstract requirements into platform-specific ones
>
> True, with thinking about parameters, I try to think top down.  What
> does application x need to execute "properly".  If you go bottoms up
> from DPM or Op-points you end up with a mess only a mother could love.
>
> Keep in mind pm-qos is about best effort PM while providing what the
> applications need to execute properly.  This is not optimal PM control
> theory.  (yet)  Don't feel bad if there is push back on some ideas, the
> theme of providing an interface for enabling best effort PM will be
> protected.
>
> > > Am I thinking about taking a walk on a slippery slope?
> > >
> > > > > 2) is it the right thing to keep pm-qos-params a compile time array
> and
> > > > > control the growth of the ABI via these mailing lists or make it a
> list
> > > > > and enable driver creation of new parameters as they wish.
> > > >
> > > > In my opinion a mixed approach, using a dynamic data structure, could
> be more
> > > > interesting to target both requirements.
> > > >
> > > > > Both are good things for us to discuss on the list.
> > > >
> > > > We are tuned on this thread and happy to contribute to the
> discussion.
> > >
> > > very cool.
> >
> > It will be interesting even just to have some shared ideas on the table
> before
> > the upcoming LPC.
>
> That would be really cool to be ready to talk and work on this stuff at
> the LPC.  FWIW I've been grounded by cost saving measures and the LPC is
> about the only conference I'll get to this year.  I don't like it but
> thats the way it goes some years.
>

I hope to have the opportunity to join LPC too.


>
> we should keep in touch and bounce some ideas around.
>

sure


>
> --mgross
>
best regards,
Matteo

<-------------------------------------------------------------------->
  Matteo Carnevali < rekstorm at gmail dot com>
  Master student at Politecnico di Milano
<-------------------------------------------------------------------->

--001636c5b18421df49046888ca22
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Apr 22, 2009 at 1:43 AM, mark gr=
oss <span dir=3D"ltr">&lt;<a href=3D"mailto:mgross@linux.intel.com">mgross@=
linux.intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8=
ex; padding-left: 1ex;">
<div class=3D"im">On Tue, Apr 21, 2009 at 10:08:18AM +0200, Derkling wrote:=
<br>
&gt; On Wed, Apr 15, 2009 at 20:35, mark gross &lt;<a href=3D"mailto:mgross=
@linux.intel.com">mgross@linux.intel.com</a>&gt; wrote:<br>
&gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt; =A0 =A0we are a group that since some months is working on &=
quot;Constrained Power<br>
&gt; &gt; &gt; Management&quot; in STMicroelectronics.<br>
&gt; &gt;</div></blockquote><div><br>Hi, I&#39;m Matteo Carnevali and I&#39=
;m working in ST with Patrick on the topic of CPM.<br>=A0<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204=
); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im"><br>
&gt; &gt; I would like to hear what your ideas are around applying constrai=
nts to<br>
&gt; &gt; power management! =A0The notion of constraint based PM has been r=
attling<br>
&gt; &gt; around, in my head and elsewhere, for a while now (a couple of ye=
ars).<br>
&gt; &gt; PMQoS is just an early application of it. =A0I think a lot more c=
ould be<br>
&gt; &gt; done in this area.<br>
&gt;<br>
&gt; We are working on the concept of constrained power management since th=
e times<br>
&gt; of DPM.<br>
&gt; We ported that framework to Nomadik platform and then we started reaso=
ning on a<br>
&gt; different implementation with the aims of overcoming its main drawback=
s.<br>
&gt;<br>
&gt; In the meantime pm_qos had been released and since then, this topic, i=
.e.<br>
&gt; constrained power management (CPM), has officially become the main sub=
ject of my<br>
&gt; PhD study; I agree with you that a lot can be done in this area.<br>
<br>
</div>cool.<br>
<div class=3D"im"><br>
&gt; In the last few months have focused on these tasks:<br>
&gt; 1. define a formal model to state the CPM problem (based both on linea=
r<br>
&gt; programming and constraint programming)<br>
&gt; 2. evaluate pm_qos with respect to this formal model and highlight its=
<br>
&gt; potential wekenesses<br>
&gt; 3. identify an extension/refactoring of pm_qos in order to overcame it=
s<br>
&gt; limitations and perhaps advance the proposal for a more general implem=
entation<br>
&gt; 4. code a first release of the proposal and submit it to the community=
 for a<br>
&gt; review ... and now we are at THIS fourth step.<br>
&gt;<br>
<br>
</div>also cool.<br>
<div class=3D"im"><br>
&gt; &gt; Recently I&#39;ve been thinking about re-factoring PMQoS in possi=
bly crazy<br>
&gt; &gt; ways with the goal of somehow supporting a more generic constrain=
t<br>
&gt; &gt; notion without making the PMQoS ABI into a free for all.<br>
&gt;<br>
&gt; Our re-factoring is for sure quite crazy. The proposal inherits many i=
deas and<br>
&gt; concepts from both DPM and PM_QoS, perhaps only the strenghts of these=
 two<br>
&gt; frameworks:<br>
&gt; - from DPM the concept of Operating Points (OP) (but don&#39;t worry: =
it has been<br>
&gt; =A0 =A0 =A0 highly reworked)<br>
&gt; - from PM_QoS the concept of &quot;aggregation function&quot; for cons=
traint management<br>
&gt;<br>
&gt; The idea is still to consider the framework to be simply a &quot;const=
raint manager&quot;<br>
&gt; that supports a &quot;distributed power management model&quot;.<br>
&gt; In such a model each driver usually runs its own local optimization po=
licy<br>
&gt; (e.g. cpufreq), but at the same time exchanges some information with t=
he rest of<br>
&gt; the system in order to either require or provide QoS levels<br>
&gt; (e.g. admitted latency).<br>
&gt;<br>
&gt; In this big picture PM_QoS works quite well, but perhaps we have spott=
ed two<br>
&gt; limitations to be better investigated:<br>
&gt; 1. it is a &quot;best-effort&quot; framework<br>
<br>
</div>this is a hard nut to crack, if you get anywhere on it do let me know=
!<br>
<div class=3D"im"><br>
&gt; 2. it does not handle properly &quot;additive constraints&quot;<br>
<br>
</div>this is easier to address.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; * Best-effort: pm_qos cannot grant that a required QoS level can be ef=
fectively<br>
&gt; provided, and even worst pm_qos don&#39;t provide mechanisms to notify=
 a constraint<br>
&gt; requester that the required qos level cannot be satisfied by other com=
ponents.<br>
&gt; This can turn into a &quot;misconfiguration&quot; of a device: its loc=
al policy configure<br>
&gt; itself expecting the required level even when actually it&#39;s imposs=
ible to get<br>
&gt; that.<br>
&gt; No one notifies the device about the effective QoS levels that can be<=
br>
&gt; reached; all that other devices can do it is only the best they can in=
 order to<br>
&gt; grant the required level.<br>
&gt; Can that leads to an only sub-optimal power optimization for the devic=
e<br>
&gt; requesting the constraint? We have this suspect...<br>
<br>
</div>There is room to grow here.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; * additive constraints: pm_qos perhaps does not properly aggregate con=
straints<br>
&gt; requests on shared resources.<br>
&gt; If multiple applications assert a bandwidth (or throughput) request: p=
m_qos<br>
&gt; aggregate them considering the MAX (or MIN) of the collected requests:=
<br>
&gt; this seems to be not properly correct.<br>
&gt; We think that in this case (e.g. bandwidth) the driver of the service =
provider<br>
&gt; should be aware of the &quot;accumulated&quot; requests to properly co=
nfigure itself and<br>
&gt; satisfy all concurrent requirements.<br>
&gt; We define &quot;additive constraints&quot; those that refer to shared =
resources<br>
&gt; (e.g. bandwidth). They differ from &quot;restrictive constraints&quot;=
 (e.g. latency)<br>
&gt; since the aggregation function cannot be a simple &quot;bound-value&qu=
ot; (i.e. max<br>
&gt; or min) but should be an &quot;sum-value&quot; in order to get the rea=
l system-wide QoS<br>
&gt; requirement.<br>
<br>
</div>do a thought experiment around network bandwidth, where multiple<br>
applications ask for max bandwidth from the NIC. =A0(just like they all<br>
expect to 100% of the CPU resources) =A0You quickly get to a point where<br=
>
(just like for CPU resources) that aggregating cumulative QoS requests as<b=
r>
a sum becomes silly.<br></blockquote><div><br>Yes, if many applications all=
 ask for the MAX bandwith from the NIC it is not <br>relevant to aggregrate=
 in an additive manner... and the problem turns into a<br>resource manageme=
nt one.<br>
<br>On the other hand I think at the case the NIC has multiple operating po=
ints, <br>defined by the local driver configuration, where each point can b=
e characterized,<br>=A0for instance, by a certain amount of power required =
to work and by a bound <br>
=A0of bandwidth it can provide, <br>e.g. :<br>- 1 watt power consumption -&=
gt; max 12 Mbit/s<br>- 2 watts power consumption -&gt; max 24 Mbit/s<br>- 3=
 watts power consumption -&gt; max 54 Mbit/s (full bandwidth)<br>in a dummy=
 scenario like this it may be useful to aggregate bandwidth <br>
requirement with an additive method, instead of max - min. <br><br></div><b=
lockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 20=
4, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
I know there are applications that need hard real time and &quot;hard QoS&q=
uot;<br>
from the platform, and the idea of building up an OS around the QoS<br>
notion is &quot;interesting&quot;(really), but it just didn&#39;t see how I=
 could<br>
apply that to an initial implementation like pmqos.<br>
<div class=3D"im"></div></blockquote><div><br>pmqos was one of the starting=
 point of our study and triggered our thoughts and <br>our ideas.<br>We wou=
ld like to develop an in-kernel framework that aims at optimizing the <br>
trade-off between power-consumption and performances.<br>We are targeting e=
mbedded multimedia mobile devices, but all this work can be <br>applied to =
other kind of devices like netbooks, laptops, desktops and even <br>servers=
.<br>
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px so=
lid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div=
 class=3D"im"><br>
&gt;<br>
&gt; These considerations made us thinking about a rework on pm_qos in orde=
r to build<br>
&gt; a more comprehensive framework able to:<br>
&gt; - properly handle both restrictive and additive constraints<br>
&gt; - provide an agreement mechanism that allows to notify constraint requ=
ester<br>
&gt; about real system run-time capabilities.<br>
&gt;<br>
<br>
</div>It looks like some useful nuggets may come from your work.<br>
<div class=3D"im"></div></blockquote><div><br>we hope so.<br>=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, =
204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"><br>
&gt; These are basically the ideas behind our rework. As soon as it will be=
 ready we<br>
&gt; will deliver the code for review. In the meantime we are also producin=
g a paper<br>
&gt; describing in details theoretical foundation of the model we advance a=
nd its<br>
&gt; implementation.<br>
<br>
</div>very cool.<br>
<div><div></div><div class=3D"h5"><br>
<br>
&gt;<br>
&gt; &gt; &gt; I think that a good trade-off between &quot;LKML control on =
new parameters&quot; and<br>
&gt; &gt; &gt; &quot;platform extensibility&quot; is hard to identify if we=
 don&#39;t refine the concept of<br>
&gt; &gt; &gt; QoS parameters first.<br>
&gt; &gt; &gt; The QoS params defined by pm_qos should avoid to be not-suff=
iciently general,<br>
&gt; &gt; &gt; to be really useful to applications, but also avoid to be to=
o much abstract to<br>
&gt; &gt; &gt; support platform-specific capabilities.<br>
&gt; &gt; &gt; Since anyway the core pm_qos implementation is sufficiently =
general to handle<br>
&gt; &gt; &gt; both abstract and platform-specific params, maybe we should =
better distinguish<br>
&gt; &gt; &gt; among &quot;abstract qos parameters&quot; (AQP) and &quot;pl=
atform-specific qos parameters&quot;<br>
&gt; &gt; &gt; PQP).<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; AQP should be intended to be used by applications to assert =
abstract<br>
&gt; &gt; &gt; requirements on system behaviors, while PQP can be added by =
platform code in<br>
&gt; &gt; &gt; order to enable the &quot;constrained power management parad=
igm&quot; for<br>
&gt; &gt; &gt; architecture/board specific devices.<br>
&gt; &gt;<br>
&gt; &gt; Maybe.<br>
&gt;<br>
&gt; In our model platform code can define both platform-specific and archi=
tecture<br>
&gt; independent constraints. The formers, since are architecture specific,=
 can be<br>
&gt; exposed read-only to user-space (e.g. just to be used for debugging pu=
rpose).<br>
&gt; The latter instead can be exposed read-write and applications can asse=
rt<br>
&gt; requirements on them. These constraints should be sufficiently abstrac=
t to be<br>
&gt; platform independent and generally usable to express high-level requir=
ements for<br>
&gt; an application (e.g. the network bandwidth a VoIP application requires=
).<br>
&gt;<br>
&gt; A device drivers is in charge to &quot;maps&quot; abstract parameters =
on its own specific<br>
&gt; params and eventually on other platform-specific parameters, whenever =
they are<br>
&gt; platform driver (e.g. a network driver can map a bandwidth request on =
a<br>
&gt; platform-specific constraint on dma-latency or amba-bus throughput).<b=
r>
&gt;<br>
&gt;<br>
&gt; &gt; &gt; In this hypothesis the better solution would be to use a dyn=
amic data structure<br>
&gt; &gt; &gt; that will be initialized by the core itself to contain just =
the set of AQP that<br>
&gt; &gt; &gt; has been reviewed and approved by LKML.<br>
&gt; &gt; &gt; Platform code will then have the chance to add its own speci=
fic parameters too.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Moreover we could imagine that AQP will be exported to user-=
land, in order to<br>
&gt; &gt; &gt; be asserted by application software, while PQP may be hidden=
 within the core<br>
&gt; &gt; &gt; and accessible only by platform drivers.<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I don&#39;t know if we can keep any PQP interfaces kernel only. =
=A0Policy<br>
&gt; &gt; managers really like to run in user mode, even if its just to set=
 the<br>
&gt; &gt; constraints.<br>
&gt;<br>
&gt; This is not what is actually going on with both cpufreq and cpuidle.<b=
r>
&gt; Really few clients of pm_qos exist now, but among them the kernel-spac=
e running<br>
&gt; policy seems to be the more widely adopted solution... may be because =
of<br>
&gt; efficiency? User-space can still be in charge of choosing the policy/g=
overnor,<br>
&gt; but then it&#39;s up to this piece of code to manage constraints reque=
sts.<br>
&gt; In the case of it needs having a user-space policy, a simple kernel-sp=
ace<br>
&gt; wrapper defining a &quot;forwarding policy&quot; will be sufficient to=
 expose the required<br>
&gt; PQP to user-space.<br>
<br>
<br>
</div></div>I need to think more about this when your code is available.<br=
>
<div class=3D"im"></div></blockquote><div><br>Ok, we are working hard on it=
!<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px s=
olid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><di=
v class=3D"im">
<br>
&gt;<br>
&gt; &gt; &gt; I agree: user-land accessible params should be platform-inde=
pendent and define<br>
&gt; &gt; &gt; a portable API for applications.<br>
&gt; &gt; &gt; This requires also to have sufficiently abstract parameters:=
 e.g. network<br>
&gt; &gt; &gt; bandwidth can be easily asserted by an application while cpu=
-dma-latency is<br>
&gt; &gt; &gt; perhaps too difficult to identify at application level.<br>
&gt; &gt;<br>
&gt; &gt; DMA latency is a somewhat sucky name for constraining CPU Idle /<=
br>
&gt; &gt; C-states, but I can&#39;t think of a better name.<br>
&gt;<br>
&gt; I understand, but: is it so common to have user-space code that needs =
to assert<br>
&gt; such &quot;real-time&quot; requirements? It seems to us that user-land=
 should be given<br>
&gt; access only to sufficiently abstract constraints that roughly define s=
ystem<br>
&gt; requirements. While more architecture-specific constraints should come=
 from<br>
&gt; drivers. This should improve solution portability, isn&#39;t it?<br>
&gt;<br>
<br>
</div>cpu dma latency was chosen thinking it was a abstract / canonical<br>
notion across CPU architectures. =A0I guess idle-cpu-wake-up-latency may be=
<br>
slightly better.<br>
<br>
Hardware will only get better at being idle, the longer a system can<br>
do a low power idle the more likely user mode applications (policy<br>
managers mostly) will need API&#39;s to modify constraints.<br>
<div class=3D"im"></div></blockquote><div><br>You&#39;re right, but in our =
ideas we would like to exploit different hardware <br>devices&#39; power st=
ates (not only the lowest idle state) and to select the best <br>states (ma=
pped to an operating mode of the device) in each instant, in order to <br>
grant the required performances and to waste as less power as we can. <br><=
br>So, both drivers and applications can set a constraint on an abstract pa=
rameter<br>(like bandwidth and latency) e.g:<br>- Applications: ask for mor=
e network bandwidth or require a certain latency on a<br>
=A0bus, for example to decode a video stream.<br>- Drivers: if a driver rea=
lizes that it can set its controlled device in a less <br>consuming operati=
ng mode while granting the QoS, it sets a constraint on the <br>abstract pa=
rameter that maps its operating modes on the whole system.<br>
<br>At this point of the game, applications&#39; constraints are pushed dow=
n at drivers&#39; <br>level and drivers (that have a deep and complete know=
ledge of their internal <br>state, operating modes and hardware capabilitie=
s) &quot;collaborate&quot; to find an <br>
agreement on the new value of the abstract parameter. In this way the best<=
br>(optimal or sub-optimal) system-wide configuration can be found.<br>Coll=
aboration is achieved through shared knowledge of abstract parameters.<br>
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px so=
lid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div=
 class=3D"im"><br>
&gt;<br>
&gt; &gt; As I type this reply I&#39;m thinking an ok way could be to re-fa=
ctor PMQoS<br>
&gt; &gt; into a constraint framework that exposes platform specific constr=
aint<br>
&gt; &gt; ABI&#39;s (in some TBD sane manner---somehow), and set PMQoS on t=
op of this<br>
&gt; &gt; keeping same ABI and KABI&#39;s stable.<br>
&gt;<br>
&gt; Are you thinking to something like an abstract API that each platform =
code<br>
&gt; should implements in its own way?<br>
<br>
</div>no.<br>
<br>
But, I would like to make it easier for different architectures to add<br>
stuff like voltage constraints that don&#39;t really fit in a QoS only worl=
d<br>
without making a miss of the ABI. =A0Basically I&#39;d like to keep those<b=
r>
sorts of things off to the side and protect the ABI stability.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; &gt; I could use some input on the way folks anticipate a constraint<b=
r>
&gt; &gt; infrastructure to be used. =A0How hot could the code paths be? =
=A0How complex<br>
&gt; &gt; could the dependencies and inter dependencies become?<br>
&gt;<br>
&gt; These are interesting questions! We should deepen those aspects, anywa=
y we think<br>
&gt; that dependencies, e.g. among constraints, can also be an interesting =
concept in<br>
&gt; order to build modular solutions.<br>
&gt; In instance the mapping that a driver needs to provide between an<br>
&gt; (platform-independent) abstract constraint and a platform-specific one=
 should<br>
&gt; allow to write more portable drivers that:<br>
&gt; 1. tune on platform-independent requirements<br>
&gt; 2. translate abstract requirements into platform-specific ones<br>
<br>
</div>True, with thinking about parameters, I try to think top down. =A0Wha=
t<br>
does application x need to execute &quot;properly&quot;. =A0If you go botto=
ms up<br>
from DPM or Op-points you end up with a mess only a mother could love.<br>
<br>
Keep in mind pm-qos is about best effort PM while providing what the<br>
applications need to execute properly. =A0This is not optimal PM control<br=
>
theory. =A0(yet) =A0Don&#39;t feel bad if there is push back on some ideas,=
 the<br>
theme of providing an interface for enabling best effort PM will be<br>
protected.<br>
<div class=3D"im"><br>
&gt; &gt; Am I thinking about taking a walk on a slippery slope?<br>
&gt; &gt;<br>
&gt; &gt; &gt; &gt; 2) is it the right thing to keep pm-qos-params a compil=
e time array and<br>
&gt; &gt; &gt; &gt; control the growth of the ABI via these mailing lists o=
r make it a list<br>
&gt; &gt; &gt; &gt; and enable driver creation of new parameters as they wi=
sh.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; In my opinion a mixed approach, using a dynamic data structu=
re, could be more<br>
&gt; &gt; &gt; interesting to target both requirements.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Both are good things for us to discuss on the list.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; We are tuned on this thread and happy to contribute to the d=
iscussion.<br>
&gt; &gt;<br>
&gt; &gt; very cool.<br>
&gt;<br>
&gt; It will be interesting even just to have some shared ideas on the tabl=
e before<br>
&gt; the upcoming LPC.<br>
<br>
</div>That would be really cool to be ready to talk and work on this stuff =
at<br>
the LPC. =A0FWIW I&#39;ve been grounded by cost saving measures and the LPC=
 is<br>
about the only conference I&#39;ll get to this year. =A0I don&#39;t like it=
 but<br>
thats the way it goes some years.<br>
</blockquote><div><br>I hope to have the opportunity to join LPC too.<br>=
=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
we should keep in touch and bounce some ideas around.<br>
</blockquote><div><br>sure<br>=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex=
; padding-left: 1ex;"><br>
--mgross<br>
</blockquote><div>best regards,<br>Matteo<br><br>&lt;----------------------=
----------------------------------------------&gt;<br>=A0 Matteo Carnevali =
&lt; rekstorm at gmail dot com&gt;<br>=A0 Master student at Politecnico di =
Milano<br>
&lt;--------------------------------------------------------------------&gt=
;<br>=A0</div></div><br>

--001636c5b18421df49046888ca22--

--===============1660212367981945705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1660212367981945705==--
