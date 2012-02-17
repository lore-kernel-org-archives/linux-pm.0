From: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Subject: Re: [linux-pm] [PATCH 0/2] RFC: CPU frequency max as PM QoS param
Date: Fri, 17 Feb 2012 10:12:51 +0200
Message-ID: <CAGF5oy9LC4Ve8u6UqG3EbGkWmWYVMthHatJdaRR_ZMO4UQh3CA@mail.gmail.com>
References: <1326976559-4009-1-git-send-email-amiettinen@nvidia.com>
	<87d39fk2n3.fsf@ti.com>
	<20120217030453.GA3266@gs62>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20120217030453.GA3266@gs62>
Sender: cpufreq-owner@vger.kernel.org
To: markgross@thegnar.org, amit.kachhap@linaro.org
Cc: Kevin Hilman <khilman@ti.com>, len.brown@intel.com, cpufreq@vger.kernel.org, Antti P Miettinen <amiettinen@nvidia.com>, linux-pm@lists.linux-foundation.org, j-pihet@ti.com
List-Id: linux-pm@vger.kernel.org

Hello,

On Fri, Feb 17, 2012 at 5:04 AM, mark gross <markgross@thegnar.org> wro=
te:
> On Wed, Feb 15, 2012 at 05:06:40PM -0800, Kevin Hilman wrote:
>> Hello,
>>
>> Antti P Miettinen <amiettinen@nvidia.com> writes:
>>
>> > This is a continuation to "RFC: CPU frequency min as PM QoS param"
>> > patchset. This patchset adds CPU frequency maximum as a PM QoS
>> > parameter and modifies CPU frequncy core to enforce the limit. CPU
>> > frequency ceiling can be used to improve the energy efficiency of
>> > workloads that would cause the cpufreq governors to enforce an
>> > unnecessarily high operating point. In other words, CPU frequency
>> > maximum can act as an energy efficiency level request.
>> >
>> > Tested on Dell E6420 with the ACPI cpufreq driver against Ubuntu
>> > 3.2. Patches are against linux-next, compile tested.
>>
>> I know there were some earlier discussions about the usefulness of a=
 max
>> frequency QoS parameter, so I wanted to throw in a reason to include=
 max
>> as well as min frequency parameters.
>>
>> IMO, having a max frequency QoS parameter would be very useful from =
a
>> thermal perspective.
>>
>> There are some ongoing projects in the PM working group at Linaro th=
at
>> are exploring plugins to the thermal framework that implment a "cool=
ing
>> device" by capping CPU frequency. =A0Having a QoS parameter do do th=
is
>> would be the logical interface.

I saw the work started by Amit (Cced), but I believe we may need to exp=
and it.

>>
>> I also agree with some earlier requests that these should probably b=
e
>> per-CPU instead of global. =A0That would make it simple to cap frequ=
ency
>> of one cluster while leaving another alone.

I believe we need to consider a broader set of cases, not only cpu.

>>
> Hi,
>
> My problem is that overloading pm_qos with a performance limits is a
> hack that will likely have problems coexisting with the core notion o=
f
> throttling limiting that is pm_qos as thermal limiting enabling expan=
ds
> its scope.
>
> Sure limiting performance governors seem to need the same notificatio=
ns
> and infrastructure as pm_qos but I worry that as its really doing the
> opposite to qos I really don't see the logic of having it in pmqos.
>
> Lets consider thermal throttling a bit maybe I can convince you to th=
at
> maybe we need some new mechanism for energy and thermal limiting. =A0=
(BTW
> I agree something is needed for this).
>
> For thermals the culprit's are:
> cpu -- cpufreq governor currently not-thermal aware
> Display -- brightness not thermal aware
> GFX -- graphics driver not thermal aware
> battery charging -- somewhat thermal aware but needs more than just b=
at
> temp to count.
> Flash -- led flash light =A0not thermal aware.


This is probably what we want to consider, at least to start with. As
Mark mentions above, the cpu domain is just part of the equation.


The work started by Amit is going towards the right direction, but I
believe we need to review the thermal problem for those systems that
don't have ACPI. The generic part of current thermal framework
(drivers/thermal/) is still somewhat bound to ACPI.

>
> Other devices may have other heat sources of course.

Indeed.

>
> Wouldn't it be better to have thermal awareness as part of the driver
> model and then have a pm_qos like thing to do out of band signaling o=
f
> devices and user mode when a temperature is hit?
>


Having things exposed to drivers is maybe one we to go, but we need to
be careful and not leave the decision making to drivers, IMO. Might be
worth considering thermal governors as well, instead of having the
decision making spread all over driver code. The point I am trying to
make here is that sometimes you may want to consider correlation
between these thermal domains.


> Putting it a qos class for limiting the high end of the performance t=
hat
> a governor really doesn't go far enough IMO. =A0It looks like a hack =
just
> for cpufreq that already has sysfs interfaces for limiting the top
> frequency.
>
> ok, maybe my argument is not so strong. but as long as its named pm Q=
OS
> and not pm-constraints I don't like the idea of having the max
> parameter in the pm_qos code.

I also agree that this type of problem goes more like a set of
constraint instead of trying to keep QoS.

>
> It feature creeps the infrastructure and violates the spirit of what
> pm_qos was to solve. =A0i.e. constrain the lower power states not upp=
er
> states.
>
> But, for thermal / energy management I think we need more notificatio=
n
> of thermal or energy events than what is needed for the pm_qos proble=
m.
>
> For pm_qos its mostly a static problem that is tuned in the lab. =A0K=
now
> the workload needs and block too much throttling. =A0For thermal / en=
ergy
> management you isn't any tuning you can do. =A0You don't apply the
> constraint until it gets too hot. =A0You don't know if or when you'll=
 get
> too hot.
>
> Note: its more than just temperature that we need to worry about. =A0=
Peak
> current is also a related issue (that is much more transient)
>
> Shouldn't we do something more forward looking than hack pm_qos with
> max-freq so that cpufreq can check a redundant parameter to what it
> already has exported through sysfs?


Agreed here, we need something to represent the problem in better way.
But, I believe what is currently at the sysfs for cpufreq is a
constraint set by user, and for thermal aspect, sometimes you can not
confuse what the user has set to what the system really needs. The
system may not want to wait for user to say you have to reduce
performance in order to try contain thermal, specially if the
situation is going critical, or as you mentioned, to consider peak
current management as well. So, I believe we need to consider both as
different constraints. Besides having these constraints coming from
different places and not having a good way to show what is going on on
the system (and also good ways to debug it) is something that may need
to be thought as well.


>
>
> --mark
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm


All best,

--=20

Eduardo Valentin
