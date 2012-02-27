From: "Pihet-XID, Jean" <j-pihet@ti.com>
Subject: Re: [linux-pm] [PATCH 0/2] RFC: CPU frequency max as PM QoS param
Date: Mon, 27 Feb 2012 11:17:26 +0100
Message-ID: <CAN5iSWq8M4OnMMDYKVZYY=M25jw6ru6ODUNmi3wLmnZ5Vxpdrw@mail.gmail.com>
References: <1326976559-4009-1-git-send-email-amiettinen@nvidia.com>
	<87d39fk2n3.fsf@ti.com>
	<20120217030453.GA3266@gs62>
	<CAGF5oy9LC4Ve8u6UqG3EbGkWmWYVMthHatJdaRR_ZMO4UQh3CA@mail.gmail.com>
	<87pqd94yeu.fsf@amiettinen-lnx.nvidia.com>
	<CAGF5oy-64J3vMKvzY=NvdV-m8_wFo=NGZANF_cnVm-iq0s-wZQ@mail.gmail.com>
	<20120221145632.GA2840@envy17>
	<87linw5aod.fsf@ti.com>
	<20120225174449.GA17141@envy17>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20120225174449.GA17141@envy17>
Sender: cpufreq-owner@vger.kernel.org
To: markgross@thegnar.org
Cc: Kevin Hilman <khilman@ti.com>, "Valentin, Eduardo" <eduardo.valentin@ti.com>, Antti P Miettinen <amiettinen@nvidia.com>, len.brown@intel.com, cpufreq@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Re-adding cpufreq and linux-pm MLs in Cc.

Regards,
Jean

On Sat, Feb 25, 2012 at 6:44 PM, mark gross <markgross@thegnar.org> wro=
te:
> On Tue, Feb 21, 2012 at 10:00:18AM -0800, Kevin Hilman wrote:
>> mark gross <markgross@thegnar.org> writes:
>>
>> > On Mon, Feb 20, 2012 at 05:44:23PM +0200, Valentin, Eduardo wrote:
>> >> Hello Antti,
>> >>
>> >> On Mon, Feb 20, 2012 at 12:00 PM, Antti P Miettinen
>> >> <amiettinen@nvidia.com> wrote:
>> >> > The following message is a courtesy copy of an article
>> >> > that has been posted to gmane.linux.kernel.cpufreq,gmane.linux.=
power-management.general as well.
>> >> >
>> >> > Thanks for the comments. I'd like to comment on maximum CPU fre=
quency,
>> >> > sysfs files and per device contraints..
>> >> >
>> >> > Maximum CPU frequency could be useful for thermal. However, it =
is not a
>> >> > complete solution for thermal. Just like minimum CPU frequency =
is not a
>> >> > complete solution for computing throughput (e.g. memory and acc=
elerator
>> >> > control are not directly addressed by a CPU frequency
>> >> > constraint). Maximum CPU frequency can be also useful for energ=
y
>> >> > efficiency even though the constraint is not a complete solutio=
n here
>> >> > either. I guess latency constraints do not completely solve end=
-to-end
>> >> > latency requirements but the mechanism is useful so it is good =
to have
>> >> > it. I'd argue minimum and maximum frequency are simular in this=
 respect.
>> >> >
>> >>
>> >> I believe we are aligned that this is not complete solution, but =
the
>> >> constraints does help on both cases.
>> >>
>> >> > There are sysfs files for constraining CPU frequency. However, =
there is
>> >> > no arbitration for several applications trying to place constra=
ints. PM
>> >> > QoS provides a way to consolidate requests from several applica=
tions and
>> >> > cleanup upon application crash. I think the existing sysfs file=
s are not
>> >> > an appropriate inferface for user space applications.
>> >>
>> >> Agreed, the current CPU frequency interfaces were not design to
>> >> achieve lists of constraints at all, but they had very simplistic
>> >> design which you would consider the last constraint applied.
>> >>
>> >> But the point Mark was trying to bring was that PM QoS was not re=
ally
>> >> meant for max- like constraints. As he said, that is not for QoS =
but
>> >> for constraints. We may be abusing a bit the FW by addressing the
>> >> problem with it. That would look like more as a pm-constraint FW.
>> >>
>> >> It just happens to be so that the PM QoS has already the needed i=
nfrastructure.
>> >>
>> >
>> > Aside from the naming and design intents of pm_qos (qos vrs perfor=
ce
>> > constraints) which I acknowledge is arguably not a good reason on =
its
>> > own to block this, the other issue I have is that thermal constrai=
nts
>> > are much more dynamic than pm-qos constraints and I don't think th=
e
>> > existing framework is up to it.
>> >
>> > almost all applications of pm-qos are static.
>>
>> Not true.
>>
>> With the new per-device PM QoS, we are adding/removing constraints
>> dynamically depending on usage. =A0Drivers/subsystems add/remove
>> constraints depending on what is happening and their needs. =A0This =
can
>> happen dynamically and very often.
>
> I have to admit I no experience and limited =A0insight into the per-d=
evice
> pm-qos or how its getting used. =A0However; I think there is a differ=
ence
> between dynamic use cases and ambient environmental effects on the
> system.
>
>> Also, as you know based on changes submitted to PM QoS infrastructur=
e
>> after it's initial addition, lots of work was done so that it can be
>> used in the fast path, so many people care about the ability to chan=
ge
>> constraints dynamically.
>
> true.
>
>> > Some device has a lower bound of performance needed by some other
>> > platform component and uses pm-qos to request tat the lower bound =
not
>> > be violated.
>>
>> And with per-device constraints (I prefer the term constraints too),
>> this can be very dynamic, and very targetted. =A0e.g. the constraint=
 might
>> apply to a single power domain/island and can can be added/removed
>> dynamically and often.
>>
>> > Performance constraints depend on dynamic values (temperature, pea=
k
>> > current, perhaps someday even noise) that are effected by ambient
>> > conditions.
>>
>> And current QoS settings also depend on dynamic values: instantaneou=
s
>> throughput, frequency dependencies between IP blocks, etc. etc.
>> Depending on which devices/subsystems are in use by a given usecase,
>> these are all dynamic conditions.
>
> They are static per use case. =A0Just because the use case can change
> dynamically does not make it dynamic in the same sense as thermal or
> battery power envelopes.
>
> Further the effects of truly dynamic conditions is significant to the
> user.
>
>> > I think adding perf-constraints to the pm-qos without taking the t=
ime to
>> > think through these things to be a quick and dirty hack.
>>
>> I don't see it that way, and to me it's a very logical extention.
>>
>
> I see it as a convenient extension that is very close to being a quic=
k
> hack. =A0That only solves a small part of a more general problem.
>
>> Current QoS settings could be thought of as performance constraints
>> too. =A0It's just that they determine minimum performance. =A0Adding
>> constraints for maxium performance is not a big stretch in my mind.
>
> Its not a big stretch to me either. =A0I just think its a bit of a ha=
ck
> and there is a bigger more interesting issue getting overlooked.
>
> Lastly why not simply make cpufreq thermal aware and talk directly to
> it if you even need too?
>
> --mark
>
>> Kevin
>>
>> > I don't know
>> > if we should be quick and dirty with main line changes like this. =
=A0maybe
>> > pm-qos only needs some dynamic constrain aggregation (for ambiant
>> > conditions) and a few new constraint classes. =A0Maybe there needs=
 to be
>> > more done.
>> >
>> > maybe I'm over thinking it and we should simply add the perf-const=
raint
>> > class.
>>
>> >>
>> >>
>> >> >
>> >> > Currently CPU sleep states are blocked globally for latency
>> >> > contraints. Finer granularity control would be possible with pe=
r CPU
>> >> > contraints. However - are there clients that know or want to co=
ntrain a
>> >> > specific CPU? Same question is applicable also to CPU frequency=
=2E Even
>> >> > though per CPU control is more flexible, what are the clients t=
hat want
>> >> > to constrain a specific CPU?
>> >>
>> >> If I got your point right, I agree with you, we definitely need a=
 way
>> >> to expose who is setting the constraint.
>> >>
>> >> >
>> >> > Another complication for the per device constraints is the user=
 space
>> >> > interface. Dynamic minors run out pretty fast if we have per CP=
U
>> >> > parameters and the system has huge number of CPUs. Does anyone =
have any
>> >> > opinions about the user space interface for device PM QoS?
>> >> >
>> >> > =A0 =A0 =A0 =A0--Antti
>> >>
>> >>
>> >> All best,
>> >>
>> >> --
>> >>
>> >> Eduardo Valentin
