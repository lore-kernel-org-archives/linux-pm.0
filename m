From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/4] CPUFreq: Implement per policy instances of governors
Date: Mon, 4 Feb 2013 21:07:11 +0530
Message-ID: <CAKohpokt0xtsj1eQDMw6JgvQVp4rgFyU-vUrtuuF+0jjOVNHRQ@mail.gmail.com>
References: <5808458.pvV2iHpBWm@vostro.rjw.lan>
	<CAKohpok7RiJ_HKGi3r0vU26kNEtFKq==pMMoshT6Z2yy9ghemA@mail.gmail.com>
	<20130204123221.GA22340@pd.tnic>
	<CAKohpomcrtV3i9fL4zV6Mt0uDza-9pHTOsqTe2=C1t6mE6cpCQ@mail.gmail.com>
	<20130204130403.GD13909@pd.tnic>
	<CAKohpokuFC5gnTFcD3+RH3p5XaW8vBtyfq+Kej=d2J8tERdmoQ@mail.gmail.com>
	<20130204133648.GE13909@pd.tnic>
	<CAKohpo=aLnhM0Op_32ohWZK5eG5nT7iK0OktBe+8ygOQW7zUqQ@mail.gmail.com>
	<20130204140908.GC15452@pd.tnic>
	<CAKohpokowK6ybYd8aDUdfFYsnzoc5VAKsuPSkfxoDqJ3k+FwGA@mail.gmail.com>
	<20130204150511.GF13909@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130204150511.GF13909@pd.tnic>
Sender: cpufreq-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com
List-Id: linux-pm@vger.kernel.org

On 4 February 2013 20:35, Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Feb 04, 2013 at 07:51:33PM +0530, Viresh Kumar wrote:
>> We correlate things with cpus rather than policies and so the curren=
t
>> directory structure of cpu/cpu*/cpufreq/*** is the best suited ones.
>
> Ok, show me the details of that layout. How is that going to look?

I don't have board right now to take the snapshot, but it would be
like:

$ tree /sys/devices/system/cpu/cpu0/cpufreq/
/sys/devices/system/cpu/cpu0/cpufreq/
=E2=94=9C=E2=94=80=E2=94=80 affected_cpus
=E2=94=9C=E2=94=80=E2=94=80 bios_limit
=E2=94=9C=E2=94=80=E2=94=80 cpb
=E2=94=9C=E2=94=80=E2=94=80 cpuinfo_cur_freq
=E2=94=9C=E2=94=80=E2=94=80 cpuinfo_max_freq
=E2=94=9C=E2=94=80=E2=94=80 cpuinfo_min_freq
=E2=94=9C=E2=94=80=E2=94=80 cpuinfo_transition_latency
=E2=94=9C=E2=94=80=E2=94=80 related_cpus
=E2=94=9C=E2=94=80=E2=94=80 scaling_available_frequencies
=E2=94=9C=E2=94=80=E2=94=80 scaling_available_governors
=E2=94=9C=E2=94=80=E2=94=80 scaling_cur_freq
=E2=94=9C=E2=94=80=E2=94=80 scaling_driver
=E2=94=9C=E2=94=80=E2=94=80 scaling_governor
=E2=94=9C=E2=94=80=E2=94=80 scaling_max_freq
=E2=94=9C=E2=94=80=E2=94=80 scaling_min_freq
=E2=94=9C=E2=94=80=E2=94=80 scaling_setspeed
=E2=94=94=E2=94=80=E2=94=80 stats
    =E2=94=9C=E2=94=80=E2=94=80 time_in_state
    =E2=94=9C=E2=94=80=E2=94=80 total_trans
    =E2=94=94=E2=94=80=E2=94=80 trans_table
=E2=94=94=E2=94=80=E2=94=80 ondemand
    =E2=94=9C=E2=94=80=E2=94=80 sampling_rate
    =E2=94=9C=E2=94=80=E2=94=80 up_threshold
    =E2=94=94=E2=94=80=E2=94=80 ignore_nice
etc..

> One thing I've come to realize with the current interface is that if
> you want to change stuff, you need to iterate over all cpus instead o=
f
> writing to a system-wide node.

Not really. Following is the way by which cpu/cpu*/cpufreq directories
are created:

=46or policy->cpu:
	ret =3D kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
				   &dev->kobj, "cpufreq");

This creates cpufreq directory for policy in policy->cpu...

=46or all other cpus in policy->cpus, we do:
		ret =3D sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
					"cpufreq");

And so whatever gets added in cpu/cpu0/cpufreq directory is reflected i=
n
all other policy->cpus.

> And, in this case, if you can and need to change the policy per
> clock-domain, I wouldn't make it needlessly too-granulary per-cpu.
>
> That's why I'm advocating the cpu/cpufreq/ path.

Its already like this, i.e. per policy or clock-domain. Other cpus just=
 have a
link. And that's why in my code, i just add governor directory in polic=
y->cpu's
cpufreq directory and it gets reflected in other cpus of policy->cpus.

That's why i said P-states as policy tunables.

>> Hmm.. confused..
>> Consider two systems:
>> - A dual core system, with cores sharing clocks.
>> - A dual cluster system (dual core per cluster), with separate clock=
s
>> per cluster.
>>
>> Where will you keep governor directories for both of these configura=
tions?
>
> Easy: as said above, make the policy granularity per clock-domain. On
> systems which have only one set of P-states - like it is the case wit=
h
> the overwhelming majority of systems running linux now - nothing shou=
ld
> change.

Currently its not per policy, but single instance of any governor is su=
pported.
And it is present in cpu/cpufreq . That's why i said earlier, it isn't =
the right
place for governor's directory. It is very much related to a policy or
clock-domain.

>> We need to select only one... cpu/cpufreq doesn't suit the second ca=
se
>> at all as we need to use ondemand governor for both the clusters but
>> with separate tunables. And so a single cpu/cpufreq/ondemand directo=
ry
>> wouldn't solve the issue.
>
> Think of it this way: what is the highest granularity you need per
> clock-domain? If you want to control the policy per clock-domain, the=
n
> cpu/cpufreq/ is what you want. If you want finer-grained control -
> and you need to think hard of what use cases are sensible for that
> finer-grained solution - then you're better off with cpu/cpu*/ layout=
=2E

I want to control it over clock-domain, but can't get that in cpu/cpufr=
eq/.
Policies don't have numbers assigned to them.

> In both cases though, having clear examples of why you've come up wit=
h
> the layout you're advocating would help reviewers a lot. If you simpl=
y
> come and say we need this because there might be systems out there wh=
o
> could use it, then that probably is not going to get you that far.

So, i am working on ARM's big.LITTLE system where we have two clusters.
One of A15s and other of A7s. Because of their different power ratings =
or
performance figures, we need to have separate set of ondemand tunables
for them. And hence this patch. Though this patch is required for any
multi-cluster system.

--
viresh
