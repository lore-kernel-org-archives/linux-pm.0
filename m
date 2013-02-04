From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 0/4] CPUFreq: Implement per policy instances of governors
Date: Mon, 4 Feb 2013 17:50:57 +0100
Message-ID: <20130204165057.GH13909@pd.tnic>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:40912 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755613Ab3BDQvI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 4 Feb 2013 11:51:08 -0500
Content-Disposition: inline
In-Reply-To: <CAKohpokt0xtsj1eQDMw6JgvQVp4rgFyU-vUrtuuF+0jjOVNHRQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com

On Mon, Feb 04, 2013 at 09:07:11PM +0530, Viresh Kumar wrote:
> I don't have board right now to take the snapshot, but it would be
> like:
>=20
> $ tree /sys/devices/system/cpu/cpu0/cpufreq/
> /sys/devices/system/cpu/cpu0/cpufreq/
> =E2=94=9C=E2=94=80=E2=94=80 affected_cpus
> =E2=94=9C=E2=94=80=E2=94=80 bios_limit
> =E2=94=9C=E2=94=80=E2=94=80 cpb
> =E2=94=9C=E2=94=80=E2=94=80 cpuinfo_cur_freq
> =E2=94=9C=E2=94=80=E2=94=80 cpuinfo_max_freq
> =E2=94=9C=E2=94=80=E2=94=80 cpuinfo_min_freq
> =E2=94=9C=E2=94=80=E2=94=80 cpuinfo_transition_latency
> =E2=94=9C=E2=94=80=E2=94=80 related_cpus
> =E2=94=9C=E2=94=80=E2=94=80 scaling_available_frequencies
> =E2=94=9C=E2=94=80=E2=94=80 scaling_available_governors
> =E2=94=9C=E2=94=80=E2=94=80 scaling_cur_freq
> =E2=94=9C=E2=94=80=E2=94=80 scaling_driver
> =E2=94=9C=E2=94=80=E2=94=80 scaling_governor
> =E2=94=9C=E2=94=80=E2=94=80 scaling_max_freq
> =E2=94=9C=E2=94=80=E2=94=80 scaling_min_freq
> =E2=94=9C=E2=94=80=E2=94=80 scaling_setspeed
> =E2=94=94=E2=94=80=E2=94=80 stats
>     =E2=94=9C=E2=94=80=E2=94=80 time_in_state
>     =E2=94=9C=E2=94=80=E2=94=80 total_trans
>     =E2=94=94=E2=94=80=E2=94=80 trans_table
> =E2=94=94=E2=94=80=E2=94=80 ondemand
>     =E2=94=9C=E2=94=80=E2=94=80 sampling_rate
>     =E2=94=9C=E2=94=80=E2=94=80 up_threshold
>     =E2=94=94=E2=94=80=E2=94=80 ignore_nice

So this is adding the current governor as a per-cpu thing.

> > One thing I've come to realize with the current interface is that i=
f
> > you want to change stuff, you need to iterate over all cpus instead=
 of
> > writing to a system-wide node.
>=20
> Not really. Following is the way by which cpu/cpu*/cpufreq directorie=
s
> are created:

That's not what I meant - I meant from userspace:

for $i in $(grep processor /proc/cpuinfo | awk '{ print $3 }');
do
	echo "performance" > /sys/devices/system/cpu/cpu$i/cpufreq/scaling_gov=
ernor;
done

Instead of

echo "performance" > /sys/devices/system/cpu/cpufreq/scaling_governor

which is hypothetical but sets it for the whole system without fuss.

[ =E2=80=A6 ]

> I want to control it over clock-domain, but can't get that in cpu/cpu=
freq/.
> Policies don't have numbers assigned to them.

So, give them names.

> So, i am working on ARM's big.LITTLE system where we have two
> clusters. One of A15s and other of A7s. Because of their different
> power ratings or performance figures, we need to have separate set of
> ondemand tunables for them. And hence this patch. Though this patch i=
s
> required for any multi-cluster system.

So you want this (values after "=3D"):

cpu/cpufreq/
|-> policy0
    |-> name		=3D A15
    |-> min_freq	=3D ...
    |-> max_freq	=3D ...
    |-> affected_cpus	=3D 0,1,2,...
    |-> ondemand
        |-> sampling_rate
	|-> up_threshold
	|-> ignore_nice
    ...
|-> policy1
    |-> name		=3D A7
    |-> min_freq	=3D ...
    |-> max_freq	=3D ...
    |-> affected_cpus	=3D n,n+1,n+2,...
    |-> performance
        |-> sampling_rate
	|-> up_threshold
	|-> ignore_nice
    ...

Other arches create other policies and that's it. If you need another
policy added to the set, you simply add 'policyN++' and that's it.

I think this is cleaner but whatever - I don't care that much. My
only strong concern is that this thing should be a Kconfig option and
optional for arches where it doesn't apply.

Thanks.

--=20
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
