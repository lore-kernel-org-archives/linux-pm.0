From: Patrick Bellasi <derkling@gmail.com>
Subject: Re: Adding PM QoS parameters
Date: Thu, 30 Apr 2009 14:28:32 +0200
Message-ID: <aa8983610904300528s6f25e41cp5581901a864eefad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2860984230123192217=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============2860984230123192217==
Content-Type: multipart/alternative; boundary=0016367fa3748e55650468c4d5fb

--0016367fa3748e55650468c4d5fb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

mark gross <mgross <at> linux.intel.com> writes:

> I don't want to see PM-QoS or constraint based PM to degenerate into a
> DPM OppPoint type of thing.  This statement reads that you are not
> aggregating the PMQoS requests in a sensible manner.  (i.e. attempting
> to code DPM styled PM using pmqos interfaces)
>
> One thing that is core to PMQoS and Constraint based PM is that there is
> a assumed partial ordering of the PM states.

Is that assumption really feasible?

Of course each device can define a _local_ partial ordering of its own power
states, but what can be assumed about the system-wide power state?
If we consider devices interdependencies, it may be that a _local_
optimization
has indirect impact on some other device performances and thus the
system-wide
state could turn out to be not the overall optimal one.

Let us consider two devices (D1 and D2) which _local_ optimization policies
are both influenced by the same QoS parameter (C1).
Let consider also someone asserting a constraint (C1<c) on that parameter.
It could happen for instance that D1 is able to fulfill this requirement, by
reconfiguring itself on a compatible operating mode, while instead D2 cannot
respect the constraint.
In this case it could happen that, finally, the required QoS level (C1<c)
cannot be granted by the system (i.e. due to the D2 impossibility to satisfy
it), anyway the D1 local policy has configured its device to work according
to
the required service level... at the end, perhaps, we spend "more power for
nothing".

This is just a dummy example, we are still trying to map it on a real
scenario,
but actually we have the feeling that the "composition" of locally optimal
configurations (based on a local partial ordering) cannot be sufficient to
get a global optimal configuration too.

> Absolute or specified performance settings are explicitly not part of
PMQoS.

I agree on your view about what PMQoS should be: definitely it should
support
a distributed control model. In this model each driver has a local
optimization
policy, usually trying to reduce power consumption, and PMQoS just delivers
some informations system-wide about expected QoS, in order to constraint
local
policies.
Therefore, such a framework will not be in charge of directly specify
performance settings in the DPM style.

However, I think that it should provide also some kind of support for the
identification on feasible system-wide optimal configurations.
We have some ideas on how such a support could be effectively implemented
but
in this sense, of course, every contribution that could come from this
discussion is welcome.
Certainly our idea is not to overcame the best-effort approach of pm_qos,
which
actually is also at the base of its simplicity, but at least also to provide

support for a "distributed agreement" approach.
Such an approach, even if generally not necessary, could be eventually
better exploited in some specific embedded application contexts, e.g. on
complex
and multi-functional new generation SoC based multimedia mobile devices.


> > Once a requested level is achieved the requester should be
> > notified for possible reconfiguration. It could be via an
> > optional registration.
>
> performance / power state entry notification?
> I think we should be careful with that idea.

A notification after entering could be difficult, and could also imply
energy
wastage whenever the required state should turn out to be not feasible.
Perhaps it could be simpler to verify whether the required performance level
can
 be granted and _only then_ either:
- to notify affected subsystems to grant the required service level
or
- to notify the service level requester that the required configuration is
not
feasible


> > We could start with a smaller set, e.g.:
> > - Interrupt latency (in lieu of DMA latency)
> > - Sleep lateny (to control sleep in absence of cpuidle)
> > - Cpu frequency
> > - Cpu voltage
>
> These are bottom up performance parameters.  Lets first go top down and
> keep in mind the partial ordering component of the system.  You can only
> constrain a min or max value not both.  Typically you constrain the
> lowest platform power a parameter is allowed to enter.

If we consider sufficiently abstract parameters (top-down approach) it could
be
difficult to understand "what" maps to lower power consumptions.
Perhaps, we could identify that mapping if we consider just one device.
But if we consider a platform, and the interdependencies among different
devices, then it may be complex to foresee how a local optimization can
impact
on system-wide power consumption.
For instance, the "run-to-idle" approach adopted by the on-demand cpufreq
governor testifies that a local non-optimal policy decision can have
system-wide
benefits (e.g. longer idle times).

> If you are looking to constrain the highest power setting the platform
> can go too, then you are talking PMQoS when really thinking DPM.

I agree.

> > I am not sure if I understood this completely, but I believe
> > that abstract -> specific mapping should be done at system level.
> > Letting drivers define them, may not be portable; and might lead
> > to more confusion.
>
> Parameters need to be defined at the application (solution) level and
> exposed to the drivers to enable them to make the best choice.  Not the
> other way around.  So if by system level you mean "solution" level then
> we agree, but over email I'm not sure if we do.

Along with "solution" level parameters (abstract parameters), it could be
interesting to have also system-level parameters.
These will be defined by drivers and platform code in order to track devices
functional dependencies.

Lets have an example:
- solution param: mems-sample-rate
    which is an abstract parameter used for instance by applications to
    assert a QoS level
    (e.g. how frequently I expect to read mems' accelerations)
- system-level param: i2c-bus-bandwidth
    - mems driver: assert constraint on that param to translate the abstract
        parameter request according to the specific device capabilities
        (e.g. we are I2C bus attached)
    - platform code: specify the platform-specific I2C channel
        corresponding to that device. This can be done for instance
        defining the system-level param as a device resource.

Such a solution should allow to translate abstract "solution" parameters to
platform-specific in a sufficiently general and portable way.

> > Generic params that impact the apps could/should be an array;
> > while arch/plat specific ones could be a linked list.
>
> I'll look at this.

I personally would prefer a common solution: "solution" params could be both
statically defined and pre-loaded into the same dynamic data structure that
will host platform-specific params too.

> Keep in mind I am against the DPM-ification of this design.  At a basic
> level the Linux OS is a best effort OS and although you can always bang
> some CR's to set power states, that isn't useful as platform independent
> or common code.

That's true, but since some time Linux is winking to real-time and embedded
systems. On such resource constrained systems, searching for "as much as
possible granted" system-wide optimal solutions is one of the main
challenges.
If we will be able to extend pm_qos to be suitable not only for general
purpose
systems but also to fit well on these application scenarios I think we will
have
interesting returns from our efforts.

> --mgross
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi <bellasi at elet dot polimi dot it>
PhD student at Politecnico di Milano


GnuPG     0x72ABC1EE (keyserver.linux.it)
    pub      1024D/72ABC1EE 2003-12-04
    Key fingerprint = 3958 7B5F 36EC D1F8 C752
                             9589 C3B7 FD49 72AB C1EE

--0016367fa3748e55650468c4d5fb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

mark gross &lt;mgross &lt;at&gt; <a href=3D"http://linux.intel.com" target=
=3D"_blank">linux.intel.com</a>&gt; writes:<br><br>&gt; I don&#39;t want to=
 see PM-QoS or constraint based PM to degenerate into a<br>&gt; DPM OppPoin=
t type of thing.=A0 This statement reads that you are not<br>

&gt; aggregating the PMQoS requests in a sensible manner.=A0 (i.e. attempti=
ng<br>&gt; to code DPM styled PM using pmqos interfaces)<br>&gt; <br>&gt; O=
ne thing that is core to PMQoS and Constraint based PM is that there is<br>

&gt; a assumed partial ordering of the PM states.<br><br>Is that assumption=
 really feasible?<br><br>Of course each device can define a _local_ partial=
 ordering of its own power<br>states, but what can be assumed about the sys=
tem-wide power state?<br>

If we consider devices interdependencies, it may be that a _local_ optimiza=
tion<br>has indirect impact on some other device performances and thus the =
system-wide<br>state could turn out to be not the overall optimal one.<br>

<br>Let us consider two devices (D1 and D2) which _local_ optimization poli=
cies<br>are both influenced by the same QoS parameter (C1).<br>Let consider=
 also someone asserting a constraint (C1&lt;c) on that parameter.<br>It cou=
ld happen for instance that D1 is able to fulfill this requirement, by<br>

reconfiguring itself on a compatible operating mode, while instead D2 canno=
t<br>respect the constraint.<br>In this case it could happen that, finally,=
 the required QoS level (C1&lt;c)<br>cannot be granted by the system (i.e. =
due to the D2 impossibility to satisfy<br>

it), anyway the D1 local policy has configured its device to work according=
 to<br>the required service level... at the end, perhaps, we spend &quot;mo=
re power for<br>nothing&quot;.<br><br>This is just a dummy example, we are =
still trying to map it on a real scenario,<br>

but actually we have the feeling that the &quot;composition&quot; of locall=
y optimal<br>configurations (based on a local partial ordering) cannot be s=
ufficient to<br>get a global optimal configuration too.<br><br>&gt; Absolut=
e or specified performance settings are explicitly not part of PMQoS.<br>

<br>I agree on your view about what PMQoS should be: definitely it should s=
upport<br>a distributed control model. In this model each driver has a loca=
l optimization<br>policy, usually trying to reduce power consumption, and P=
MQoS just delivers <br>

some informations system-wide about expected QoS, in order to constraint lo=
cal<br>policies.<br>Therefore, such a framework will not be in charge of di=
rectly specify<br>performance settings in the DPM style.<br><br>However, I =
think that it should provide also some kind of support for the<br>

identification on feasible system-wide optimal configurations.<br>We have s=
ome ideas on how such a support could be effectively implemented but<br>in =
this sense, of course, every contribution that could come from this<br>

discussion is welcome.<br>Certainly our idea is not to overcame the best-ef=
fort approach of pm_qos, which<br>actually is also at the base of its simpl=
icity, but at least also to provide <br>support for a &quot;distributed agr=
eement&quot; approach.<br>

Such an approach, even if generally not necessary, could be eventually<br>b=
etter exploited in some specific embedded application contexts, e.g. on com=
plex<br>and multi-functional new generation SoC based multimedia mobile dev=
ices.<br>

<br><br>&gt; &gt; Once a requested level is achieved the requester should b=
e<br>&gt; &gt; notified for possible reconfiguration. It could be via an<br=
>&gt; &gt; optional registration.<br>&gt; <br>&gt; performance / power stat=
e entry notification?<br>

&gt; I think we should be careful with that idea.<br><br>A notification aft=
er entering could be difficult, and could also imply energy<br>wastage when=
ever the required state should turn out to be not feasible.<br>Perhaps it c=
ould be simpler to verify whether the required performance level can<br>

=A0be granted and _only then_ either:<br>- to notify affected subsystems to=
 grant the required service level<br>or<br>- to notify the service level re=
quester that the required configuration is not<br>feasible<br><br><br>&gt; =
&gt; We could start with a smaller set, e.g.:<br>

&gt; &gt; - Interrupt latency (in lieu of DMA latency)=A0 <br>&gt; &gt; - S=
leep lateny (to control sleep in absence of cpuidle)<br>&gt; &gt; - Cpu fre=
quency<br>&gt; &gt; - Cpu voltage<br>&gt; <br>&gt; These are bottom up perf=
ormance parameters.=A0 Lets first go top down and<br>

&gt; keep in mind the partial ordering component of the system.=A0 You can =
only<br>&gt; constrain a min or max value not both.=A0 Typically you constr=
ain the<br>&gt; lowest platform power a parameter is allowed to enter.<br>
<br>
If we consider sufficiently abstract parameters (top-down approach) it coul=
d be<br>difficult to understand &quot;what&quot; maps to lower power consum=
ptions.<br>Perhaps, we could identify that mapping if we consider just one =
device.<br>

But if we consider a platform, and the interdependencies among different<br=
>devices, then it may be complex to foresee how a local optimization can im=
pact<br>on system-wide power consumption.<br>For instance, the &quot;run-to=
-idle&quot; approach adopted by the on-demand cpufreq<br>

governor testifies that a local non-optimal policy decision can have system=
-wide<br>benefits (e.g. longer idle times).<br><br>&gt; If you are looking =
to constrain the highest power setting the platform<br>&gt; can go too, the=
n you are talking PMQoS when really thinking DPM.<br>

<br>I agree.<br><br>&gt; &gt; I am not sure if I understood this completely=
, but I believe<br>&gt; &gt; that abstract -&gt; specific mapping should be=
 done at system level.<br>&gt; &gt; Letting drivers define them, may not be=
 portable; and might lead<br>

&gt; &gt; to more confusion.<br>&gt; <br>&gt; Parameters need to be defined=
 at the application (solution) level and<br>&gt; exposed to the drivers to =
enable them to make the best choice.=A0 Not the<br>&gt; other way around.=
=A0 So if by system level you mean &quot;solution&quot; level then<br>

&gt; we agree, but over email I&#39;m not sure if we do.<br><br>Along with =
&quot;solution&quot; level parameters (abstract parameters), it could be<br=
>interesting to have also system-level parameters.<br>These will be defined=
 by drivers and platform code in order to track devices<br>

functional dependencies.<br><br>Lets have an example:<br>- solution param: =
mems-sample-rate<br>=A0=A0=A0 which is an abstract parameter used for insta=
nce by applications to<br>=A0=A0=A0 assert a QoS level<br>=A0=A0=A0 (e.g. h=
ow frequently I expect to read mems&#39; accelerations)<br>

- system-level param: i2c-bus-bandwidth<br>=A0=A0=A0 - mems driver: assert =
constraint on that param to translate the abstract<br>=A0=A0=A0 =A0=A0=A0 p=
arameter request according to the specific device capabilities<br>=A0=A0=A0=
 =A0=A0=A0 (e.g. we are I2C bus attached)<br>

=A0=A0=A0 - platform code: specify the platform-specific I2C channel<br>=A0=
=A0=A0 =A0=A0=A0 corresponding to that device. This can be done for instanc=
e<br>=A0=A0=A0 =A0=A0=A0 defining the system-level param as a device resour=
ce.<br><br>Such a solution should allow to translate abstract &quot;solutio=
n&quot; parameters to<br>

platform-specific in a sufficiently general and portable way.<br><br>&gt; &=
gt; Generic params that impact the apps could/should be an array;<br>&gt; &=
gt; while arch/plat specific ones could be a linked list.<br>&gt; <br>
&gt; I&#39;ll look at this.<br>
<br>I personally would prefer a common solution: &quot;solution&quot; param=
s could be both<br>statically defined and pre-loaded into the same dynamic =
data structure that<br>will host platform-specific params too.<br><br>
&gt; Keep in mind I am against the DPM-ification of this design.=A0 At a ba=
sic<br>
&gt; level the Linux OS is a best effort OS and although you can always ban=
g<br>&gt; some CR&#39;s to set power states, that isn&#39;t useful as platf=
orm independent<br>&gt; or common code.<br><br>That&#39;s true, but since s=
ome time Linux is winking to real-time and embedded<br>

systems. On such resource constrained systems, searching for &quot;as much =
as<br>possible granted&quot; system-wide optimal solutions is one of the ma=
in challenges.<br>If we will be able to extend pm_qos to be suitable not on=
ly for general purpose<br>

systems but also to fit well on these application scenarios I think we will=
 have<br>interesting returns from our efforts.<br><br>&gt; --mgross<br>Patr=
ick<br><br>-- <br>#include &lt;best/regards.h&gt;<br><br>Patrick Bellasi &l=
t;bellasi at elet dot polimi dot it&gt;<br>

PhD student at Politecnico di Milano<br> =A0 <br> =A0 <br>GnuPG =A0 =A0 0x7=
2ABC1EE (<a href=3D"http://keyserver.linux.it" target=3D"_blank">keyserver.=
linux.it</a>)<br>=A0=A0=A0 pub =A0 =A0 =A01024D/72ABC1EE 2003-12-04<br> =A0=
 =A0 Key fingerprint =3D 3958 7B5F 36EC D1F8 C752<br>

 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 9589 C3B7 FD49 =
72AB C1EE<br><br>

--0016367fa3748e55650468c4d5fb--

--===============2860984230123192217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2860984230123192217==--
