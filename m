From: Stephane Gasparini <stephane.gasparini@linux.intel.com>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to get target pstate
Date: Mon, 14 Dec 2015 17:38:15 +0100
Message-ID: <4C075569-2E99-4826-914D-B015A3AD4903@linux.intel.com>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com> <8633351.YrHIUtRzE5@skinner> <2402797.hEhmBtxRMB@vostro.rjw.lan> <3489712.H9ngXOW7TX@skinner>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42879 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbbLNQik convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2015 11:38:40 -0500
In-Reply-To: <3489712.H9ngXOW7TX@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, Prarit Bhargava <prarit@redhat.com>, viresh.kumar@linaro.org


=E2=80=94
Steph




> On Dec 14, 2015, at 5:22 PM, Thomas Renninger <trenn@suse.de> wrote:
>=20
> On Thursday, December 10, 2015 11:01:18 PM Rafael J. Wysocki wrote:
>> On Thursday, December 10, 2015 02:04:46 PM Thomas Renninger wrote:
>>> On Wednesday, December 09, 2015 12:21:53 PM Srinivas Pandruvada wro=
te:
>>>> On Wed, 2015-12-09 at 15:34 +0100, Thomas Renninger wrote:
>>>>> On Tuesday, December 08, 2015 10:02:23 AM Srinivas Pandruvada wro=
te:
>>>>>> On Tue, 2015-12-08 at 16:27 +0100, Thomas Renninger wrote:
>> [cut]
>>=20
>>>> This is the order I am thinking of in the order of priority high t=
o
>>>> low :
>>>> - User policy (either command line or via cpu-freq scaling_governo=
r)
>>>> - ACPI
>>>> - Pickup defaults based on CPU ID.
>>>=20
>>> Why by CPU ID?
>>=20
>> For a couple of reasons.
>>=20
>> First of all, processors are designed in a specific way and some way=
s of
>> P-states management may not lead to good results on them no matter w=
hat,
>> while others may match them a lot better.
>>=20
>> The processors in question here are designed with energy efficiency =
in mind.
>> For this reason, an approach skewed towards performance (which the o=
riginal
>> algorithm in intel_pstate is) is really suboptimal there as the perf=
ormance
>> is not there in the first place, quite fundamentally.  Even if anyon=
e used
>> any chip based on those cores in a server, that would be a "low-powe=
r
>> server" so to speak, so using an algorithm more oriented towards ene=
rgy
>> efficiency would still make sense for it.
>=20
> Ok, so we have these:
> Desktop processors (Bay Trail-D)
> Server processors (Avoton)
>=20
> Are you sure that your partners may not sell these CPUs clustered on =
servers=20
> due to other features on these CPUs (than powersavings), or possibly =
due to
> simple marketing reasons, because Atom or ARM servers are trendy nowa=
days.
>=20
> And in the end it will show up as an "Enterprise Server" platform whe=
re
> your partners like HP, SAP, Dell,... have to explicitly state to disa=
ble
> specific powersaving features on OS level, because the CPU driver kee=
ps=20
> ignoring any BIOS provided information.
>=20
>> Second, the CPU ID is the most reliable piece of information about t=
he
>> type of the system we can possibly get.
>=20
> This is wrong.
> Differing by battery or not is more reliable than any CPU id matching=
=2E
>=20
> And for the last at least 3 years, I have not seen a system where pm =
profile
> was set wrong. In our server room I can show you a hundred servers th=
at
> all match the "Enterprise Sever" ACPI profile. Laptops as well.
>=20
>> The BIOS may always lie to us and we can't entirely rely on it for f=
iguring
>> out the system profile,
>=20
> We can. Because otherwise the ACPI pm profile is set "unknown".
> BTW: There were rumours that Intel's microcode had some sever bugs as=
 well
> recently. So what, we have to rely on this piece of software as well.=
=2E.
>=20
> IMO we see a bit too much CPU ID matching and it's getting more and m=
ore.
> Perfect would be no CPU ID matching at all.
> We had this with the acpi-cpufreq driver which in the end worked out =
perfectly
> for 99% of all machines out there.
>=20
> Hm, apropos id matching... I thought intel_pstate got introduced beca=
use the
> CPUs it supports can switch to any frequency between min and max. And=
 this
> is not reflected by ACPI which does export a maximum amount of X (10?=
)=20
> frequency states.
> Seeing this:
>        static int silvermont_freq_table[] =3D {
>                83300, 100000, 133300, 116700, 80000};
>=20
>        static int airmont_freq_table[] =3D {
>                83300, 100000, 133300, 116700, 80000,
>                93300, 90000, 88900, 87500};
>=20
> makes me think, whether these shouldn't simply use the acpi_cpufreq d=
river.
> Or in the near future we may have tons of such defines?
> And you are back at "real" governors=E2=80=A6

Those tables are for the bus frequency, not the core frequency.
On ATOM so far there is an constraint because the CPU are not having a=20
separate PLL, thus they is a dependency on the RAM bus speed that cause=
=20
the FSB not to be 100000 compare to core.

The ACPI table usually does not expose all the p-state above max freq (=
turbo).
So relying on ACPI table is not perf/power efficient.

>=20
>> but as I said, if a CPU designed for energy-efficient systems is use=
d in the
>> given one, that is a strong indication on what the system is or it w=
ould
>> have used a different CPU otherwise.
>=20
> Are you sure? And is this statement in line with your sales and produ=
ct=20
> managers. These guys often tend to think differently than the develop=
ers ;)
>=20
>    Thomas
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

