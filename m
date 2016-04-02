From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Sat, 2 Apr 2016 02:28:13 +0200
Message-ID: <CAJZ5v0jZo_W_jRNWR6V+rV-jwhzPpmPbYF=gKHQmhctqr7fObQ@mail.gmail.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
	<2727017.UmaUvtBLeX@vostro.rjw.lan>
	<CADDKRnCs8vWbqOBbk0T+A5_VSzC5ENfND=NLwb3G0XjTvF9DQA@mail.gmail.com>
	<3623107.tlAuqH4F7s@vostro.rjw.lan>
	<CADDKRnBBuSfU4P2QsJU42_422Ebs_qJxrx7cgBJsa=LFp158mw@mail.gmail.com>
	<1459532674.13525.136.camel@linux.intel.com>
	<003801d18c44$ab9134e0$02b39ea0$@net>
	<CAJZ5v0gVvMg9FRGOkHCPJusCVG3JvEbF6kmnAtFziN+inOGiHA@mail.gmail.com>
	<003901d18c6f$5ec91530$1c5b3f90$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36337 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbcDBA2P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 20:28:15 -0400
In-Reply-To: <003901d18c6f$5ec91530$1c5b3f90$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Sat, Apr 2, 2016 at 1:36 AM, Doug Smythies <dsmythies@telus.net> wro=
te:
> On 2016.04.01 12:54 Rafael J. Wysocki wrote:
>>On Fri, Apr 1, 2016 at 8:31 PM, Doug Smythies <dsmythies@telus.net> w=
rote:
>>> On 2106.034.01 10:45 Srinivas Pandruvada wrote:
>>>> On Fri, 2016-04-01 at 16:06 +0200, J=C3=B6rg Otte wrote:
>>> > > > > >
>>>>> Done. Attached the tracer.
>>>>> For me it looks like the previous one of the failing case.
>>>>
>>>> The traces show that idle task is constantly running without sleep=
=2E
>>>
>>> No, they (at least the first one, I didn't look at the next one yet=
)
>>> show that CPUs 2 and 3 are spending around 99% of their time not in=
 state
>>> C0.
>
>> How do you figure that out if I may ask?  It is not so obvious to me
>> to be honest.
>
> The trace was not in the form for the post processing tools, so I had
> to manually import the trace into a spreadsheet and manually add new =
columns
> calculated from the others.
>
> Load =3D mperf / tsc * 100 % =3D C0 time.
> Duration (mS) =3D tsc / 2.5e9 * 1000
> Note: I do not recall seeing an exact tsc for J=C3=B6rg's computer, s=
o I used
> The 2.5 GHz from the device spec from some earlier e-mail.
>
> Example (formatting will likely not send O.K.):
>
>                 CPU#    time            core_busy       scaled  from =
   to      mperf           aperf           tsc             freq        =
    load            duration (ms)
> <idle>-0        [002]   465.879451:     100             96           =
   26      26      1826656 1826710 25062693        2500073 7.288%  10.0=
25
> <idle>-0        [003]   465.879484:     99              96           =
   26      26      305796  305781  25147993        2499877 1.216%  10.0=
59
> <idle>-0        [000]   465.885794:     100             96           =
   26      26      975908  975951  32434672        2500110 3.009%  12.9=
74
> <idle>-0        [001]   465.886898:     100             250          =
   10      31      327356  327364  26673840        2500061 1.227%  10.6=
70
> <idle>-0        [002]   465.889527:     100             96           =
   26      26      205336  205365  25133396        2500353 0.817%  10.0=
53
> <idle>-0        [003]   465.889555:     99              95           =
   26      26      62544           62341           25117916        2491=
885 0.249%  10.047

OK

It could be C1 with relatively short periods spent in it.

>> That the sample rate is ending up at ~10 Milliseconds, indicates som=
e
>> high frequency (>=3D 100Hz) events on those CPUs. Those events, appa=
rently,
>> take very little CPU time to complete, hence a load of about 1% on a=
verage.
>>
>> By the way, I can recreate the high sample rate with virtually no lo=
ad
>> on my system easy, but so far have been unable to get the high CPU
>> frequencies observed by J=C3=B6rg. I can get my system to about a ta=
rget pstate of
>> 20 where it should have remained at 16, but that is about it.
>>
>>> The driver is processing samples for idle task for every 10ms and
>>> aperf/mperf are showing that we are always in turbo mode for idle t=
ask.
>>
>> That column pretty much always says "idle" (or swapper for my way of=
 doing
>> things). I have not found it to very useful as an indicator, and con=
siderably
>> more so since the utilization changes.
>>
>>>
>>> Need to find out why idle task is not sleeping.
>>
>> I contend that is it.
>
> Why?
>
> Unless I misunderstood, because the trace data indicates that the tho=
se CPUs
> are going into some deeper C stsate than C0 for most of their time.

But how long do they stay in those states every time?

Average residencies need to be well below 10 ms for the trace to be
produced every 10 ms, so the question seems to be what kicks the CPUs
out of idle states so often.  On a completely idle system, that's
highly suspicious.
