From: Stephane Gasparini <stephane.gasparini@linux.intel.com>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to get target pstate
Date: Tue, 15 Dec 2015 14:06:32 +0100
Message-ID: <6F67531E-0872-492D-8690-37EF597C2A92@linux.intel.com>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com> <1449692513.3240.231.camel@spandruv-desk3.jf.intel.com> <8633351.YrHIUtRzE5@skinner> <2402797.hEhmBtxRMB@vostro.rjw.lan> <48DF4267-671B-40E2-8C95-CCF5795F8B26@linux.intel.com> <001c01d136bc$a4a78a90$edf69fb0$@net> <566FEBB8.5090008@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:29379 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932872AbbLONGo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 08:06:44 -0500
In-Reply-To: <566FEBB8.5090008@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philippe Longepe <philippe.longepe@linux.intel.com>
Cc: Doug Smythies <dsmythies@telus.net>, Thomas Renninger <trenn@suse.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, Prarit Bhargava <prarit@redhat.com>, viresh.kumar@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>


=E2=80=94
Steph




> On Dec 15, 2015, at 11:30 AM, Philippe Longepe <philippe.longepe@linu=
x.intel.com> wrote:
>=20
> Hi Doug,
>=20
> On 14/12/2015 23:13, Doug Smythies wrote:
>> On 2015.12.14 08:15 Stephane Gasparini wrote:
>>=20
>>> Here are the results we have on a android release of WW50
>>> Note that as of today Android is using Interactive Governor.
>> Thanks very much for your test results.
>> By "Intel PState CPU Load" I assume you mean using that V6 3 patch
>> "cpufreq: intel_pstate: account non C0 time" from Dec 4th, which I a=
lso
>> tested and sent an off-list reply to Philippe.
>> Summary: I like the patch set.
> These tests were done on a previous version of my patch done in WW40.
> We'll sent an updated version (WW50 with patch V6 3) soon.

As I said we are redoing a whole sets of measure with this submission a=
nd
it takes times.
The measures I sent are all made without the iowait being taking into a=
ccount
in the load algorithm, but for IOZONE and power data.

>> Myself, I would like to see tests comparing the current
>> "powersave" governor to your "CPU Load" method, although

This what is the comparison I sent.

Intel PState Performance =3D intel pstate =E2=80=9Cpowersave=E2=80=9D
Intel PState CPU Load =E2=89=85 V6 3 patch "cpufreq: intel_pstate: acco=
unt non C0 time" from Dec 4th
 =20

>> I do always like the reference "performance" test. However,
>> I suspect that in your case, there wouldn't be much difference.
>> After you moved the setpoint to 60 from 97, the response becomes
>> pretty much like performance mode.[1]

This is not really true as the load goes down by itself without the nee=
d
to wait for 3 periods lower the requested pstate compare to =E2=88=86AP=
ERF/=E2=88=86MPERF.

The setpoint of 60 was there on =E2=80=9Cpowersave" already for Atom co=
res prior we
modified the algorithm, for performance issue.

On Android we need a very great reactivity (measured by KPI to match co=
mpetition).
This was solved by Google by auto/touch boost feature in Interactive Go=
vernor.
Today with a setpoint of 60 we are on par with Interactive Governor in =
terms
of performance, and we are better in power.

> In the table sent by stephane, "performance" meant "original algorith=
m" based on average pstate (aperf/mperf).
> On Atoms, a setpoint of 60 is not too high. With higher setpoints we'=
ll not be able to reach meet some performance KPIs
> (some frames are dropped mainly for gaming use cases). However, we ar=
e working on a more power conservative algorithm).
>>=20
>> Also, you provide only power information, and no performance / energ=
y
>> trade-off information. Do any of those tests reveal good power use, =
but
>> unbearable performance? What I am saying is that power by itself is =
not
>> a sufficient evaluation criteria, otherwise just lock in the minimum=
 pstate
>> and be done with it, which we know isn't the right solution.

Well you misunderstood the power numbers I guess
e.g. if you watch a movie for 1h30, it will last 1h30 not matter what i=
s the=20
average power, so the lower is the average power the better it is.

This is the same thing for Audio and all the power numbers I shared but=
 the application install.
Here are the detail for Application install

Intel PState    Intel PState   =20
Performance     CPU Load     =20
=E2=89=85 799 mW (28 s)	=E2=89=85 383 mW (34 s)
=E2=89=85 29 mW/s	=E2=89=85 11 mW/s


> Stephane has also some other performance/power figures done with Powe=
r Lab. We'll see if we can share them.
>>  =20
>>> Atom:                              Intel PState   Intel PState     =
Power
>>>                                    Performance    CPU Load      Imp=
rovment
>>> 50% Load 1 thread                     260 mW         25 mW        -=
90%
>> If I understand correctly, the CPU load is 50% regardless of CPU fre=
quency.
>> If yes, then this particular test is grossly unfair and misleading.
>> Why?
>> Because using your default setpoint of 60, the CPU load method will =
hold
>> the pstate at minimum, whereas performance mode will ask for the max=
imum.
>> The result will be drastic differences in the actual amount of work =
done
>> per unit time.
> Yes, you are right, we need to fix that workload or to remove it to t=
he list.
> Also a fixed load does not correspond to a real use case.
> This is why we are not using this test as a KPI.
>=20

The =E2=80=9Cpowersave=E2=80=9D version on intel p-state is misbehaving=
 for our Android device
to duty cycle load. If you have a duty cycle that is below 3 sample sam=
pling period
then the =E2=80=9Cpowersave=E2=80=9D version will request to high frequ=
ency for the job to be done.

Using the load solves this particular situation that is an issue for An=
droid devices.
In the power numbers I provided there is a real case of this the Circul=
ar Progress bar
where the =E2=80=9Cpowersave=E2=80=9D request a too high frequency all =
along.
Using the load allow to run at Lowest Frequency that is sufficient to r=
un this progress
bar. On this point we behave better than the Interactive Governor (Andr=
oid) that is also
requesting necessary high frequencies for this workload due to its auto=
/touch boost features.

>>=20
>> I think that a more comparable test would be a 50% (or whatever) loa=
d
>> calibrated to a nominal CPU frequency (I use the max non-turbo CPU
>> frequency, but it can be anything.) Meaning that the once the fixed
>> packet of work is done, the CPU can go idle sooner or later, dependi=
ng
>> on the CPU frequency.
> Are you using an existing tool for doing that or did you developed yo=
ur own tool ?
>>=20
>> Note also, that the work/sleep frequency used to attain the 50% load
>> can be relevant, particularly at lower sleep/work frequencies where
>> the intel_pstate driver response can have higher and higher
>> magnitude oscillations. By the way, in my tests, your "CPU Load" met=
hod
>> lower sleep/work frequency results were phenomenally good.
> Yes, that's what we observed also. For many use cases very often used=
 in android
> (gaming, circular progress bar, audio playback, video playback, etc .=
=2E.), using the
> load instead of the ratio avg_pstate/current_pstate is a good choice =
and can save
> a lot of power!
>>=20
>> Here are some results from my test computer, albeit with the wrong p=
rocessor:
>>=20
>> Note 1: I have an older i7-2600K.
>> Note 2: Obviously, I forced your code patch to work with my processo=
r ID.
>> Note 3: Power is package power measured with turbostat.
>> Note 4: one thread.
>>=20
>> 1.) 50% load at 3.4GHz 201 hertz work / sleep frequency:
>>=20
>> 4.4-rc5 powersave 11.27 watts*
>> 4.4-rc5 performance 12.83 watts
>> 4.4-rc3 + PL ver 6 3 patch set (default (60)): 10.47 watts
>> 4.4-rc3 + PL ver 6 3 patch set (setpoint 40): 12.55 watts
>> 4.4-rc3 + PL ver 6 3 patch set (setpoint 70): 9.72 watts**
>>=20
>> 2.) 50% load at 3.4GHz 50 hertz work / sleep frequency:
>>=20
>> 4.4-rc5 powersave 12.01 watts
>> 4.4-rc5 performance 11.90 watts
>> 4.4-rc3 + PL ver 6 3 patch set (default (60)): 10.09 watts
>> 4.4-rc3 + PL ver 6 3 patch set (setpoint 40): 12.01 watts
>> 4.4-rc3 + PL ver 6 3 patch set (setpoint 70): 9.65 watts
>>=20
>> *  there were 6 overruns.
>> ** there were 3 overruns, meaning the work packet did not
>> finish in time before the next one was supposed to start.
>> This issue goes to step function load response time. i.e
>> How fast does the scaling driver respond to load and ramp up
>> the CPU frequency. My test program can catch up, but some
>> applications might not like the delay.
>>   An example of a performance / energy trade-off test:
>>=20
>> phoronix ffmpeg test:
>> Shorter time is better.
>> The ffmpeg test is known to be particularly difficult for
>> frequency scaling drivers to handle. The scenario is similar
>> to how some games utilize all the CPUs.
>>=20
>> Your patch set (an older version) on kernel 4.4-rc1:
>> setpoint 60: 17.84 seconds ave. 4324 package Joules. (default)
>> setpoint 40: 12.86 seconds ave. 4822 package Joules. (noisey)
>>=20
>> or ~30% time improvement at a cost of 12% more energy, which some
>> users might think worthwhile.
>>=20
>> For reference:
>> intel_pstate powersave (normal processor, setpoint 97): 12.06 second=
s ave. 4983 package Joules
>> I do not have energy numbers for the below:
>> Performance mode: 11.16 seconds ave.
>> acpi-cpufreq powersave: 24.47 seconds ave.
>> acpi-cpufreq ondemand: 13.35 seconds ave.
>> acpi-cpufreq conservative: 17.60 seconds ave.
>>=20
>> [1] http://marc.info/?l=3Dlinux-pm&m=3D142894256520552&w=3D2
>>=20
>> ... Doug
>>=20
>>=20
> Thx for the data,
>=20
> Philippe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

