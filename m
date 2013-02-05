From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/4] CPUFreq: Implement per policy instances of governors
Date: Tue, 5 Feb 2013 12:50:31 +0530
Message-ID: <CAOh2x==fyfYwz+eXmPhBJTE+_q_fHyx2drXrM789XvCfEqPBUQ@mail.gmail.com>
References: <20130204123221.GA22340@pd.tnic>
	<CAKohpomcrtV3i9fL4zV6Mt0uDza-9pHTOsqTe2=C1t6mE6cpCQ@mail.gmail.com>
	<20130204130403.GD13909@pd.tnic>
	<CAKohpokuFC5gnTFcD3+RH3p5XaW8vBtyfq+Kej=d2J8tERdmoQ@mail.gmail.com>
	<20130204133648.GE13909@pd.tnic>
	<CAKohpo=aLnhM0Op_32ohWZK5eG5nT7iK0OktBe+8ygOQW7zUqQ@mail.gmail.com>
	<20130204140908.GC15452@pd.tnic>
	<CAKohpokowK6ybYd8aDUdfFYsnzoc5VAKsuPSkfxoDqJ3k+FwGA@mail.gmail.com>
	<20130204150511.GF13909@pd.tnic>
	<CAKohpokt0xtsj1eQDMw6JgvQVp4rgFyU-vUrtuuF+0jjOVNHRQ@mail.gmail.com>
	<20130204165057.GH13909@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130204165057.GH13909@pd.tnic>
Sender: cpufreq-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 4, 2013 at 10:20 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Feb 04, 2013 at 09:07:11PM +0530, Viresh Kumar wrote:
>> =E2=94=94=E2=94=80=E2=94=80 ondemand
>>     =E2=94=9C=E2=94=80=E2=94=80 sampling_rate
>>     =E2=94=9C=E2=94=80=E2=94=80 up_threshold
>>     =E2=94=94=E2=94=80=E2=94=80 ignore_nice
>
> So this is adding the current governor as a per-cpu thing.

Its per policy, but yes it is replicated into all cpus as all policy->c=
pus
share the same directory.

>> > One thing I've come to realize with the current interface is that =
if
>> > you want to change stuff, you need to iterate over all cpus instea=
d of
>> > writing to a system-wide node.
>>
>> Not really. Following is the way by which cpu/cpu*/cpufreq directori=
es
>> are created:
>
> That's not what I meant - I meant from userspace:
>
> for $i in $(grep processor /proc/cpuinfo | awk '{ print $3 }');
> do
>         echo "performance" > /sys/devices/system/cpu/cpu$i/cpufreq/sc=
aling_governor;
> done
>
> Instead of
>
> echo "performance" > /sys/devices/system/cpu/cpufreq/scaling_governor
>
> which is hypothetical but sets it for the whole system without fuss.

We actually need to do this only for policy->cpu, but yes the user migh=
t not
be well aware of policy cpu-groups and may do what you wrote.

But that is true even today, when we need to change any policy tunables=
 or
P-states.

>> I want to control it over clock-domain, but can't get that in cpu/cp=
ufreq/.
>> Policies don't have numbers assigned to them.
>
> So, give them names.

IMHO, names doesn't suit policies.

>> So, i am working on ARM's big.LITTLE system where we have two
>> clusters. One of A15s and other of A7s. Because of their different
>> power ratings or performance figures, we need to have separate set o=
f
>> ondemand tunables for them. And hence this patch. Though this patch =
is
>> required for any multi-cluster system.
>
> So you want this (values after "=3D"):
>
> cpu/cpufreq/
> |-> policy0
>     |-> name            =3D A15
>     |-> min_freq        =3D ...
>     |-> max_freq        =3D ...
>     |-> affected_cpus   =3D 0,1,2,...
>     |-> ondemand
>         |-> sampling_rate
>         |-> up_threshold
>         |-> ignore_nice
>     ...
> |-> policy1
>     |-> name            =3D A7
>     |-> min_freq        =3D ...
>     |-> max_freq        =3D ...
>     |-> affected_cpus   =3D n,n+1,n+2,...
>     |-> performance
>         |-> sampling_rate
>         |-> up_threshold
>         |-> ignore_nice
>     ...

We may have two clusters of A7's also, in a non-big little arch. Then
these names become very confusing.

> Other arches create other policies and that's it. If you need another
> policy added to the set, you simply add 'policyN++' and that's it.

=46or me, adding policy->names per arch is increasing complexity withou=
t
much gain. We already have an existing infrastructure where this info
is present inside cpus and that looks good to me.

> I think this is cleaner but whatever - I don't care that much. My
> only strong concern is that this thing should be a Kconfig option and
> optional for arches where it doesn't apply.

Your concern is: we don't want to fix userspace for existing platforms
where we have just a single cluster and so struct policy in the system.

so, a good solution instead of Kconfig stuff is, add another field in p=
olicy
structure that would be filled by platform specific cpufreq drivers ini=
t()
routine. Based on which we can decide to put governor directory in
cpu/cpufreq/gov-name or cpu/cpu*/cpufreq/gov-name.

But i am not sure if keeping both kind of directory locations for separ=
ate
platforms is a good idea. Userspace needs to adapt to these changes as
well for multi-cluster platforms.

@Rafael: you know about any other multi-cluster/multi-clock-domain
platform leaving big.LITTLE, where we have multiple structs policy?
