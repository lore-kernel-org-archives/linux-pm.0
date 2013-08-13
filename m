From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 11/44] cpufreq: at32ap: Use generic cpufreq routines
Date: Tue, 13 Aug 2013 10:24:50 +0530
Message-ID: <CAKohpomcg88NxLqDcb+LqqVVZMwQGNjugHkor_dj4Vzn0yrN2g@mail.gmail.com>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
	<c70729588f2f21d10fa5d53e5189890af4248a93.1376116345.git.viresh.kumar@linaro.org>
	<20130810082333.GA27640@samfundet.no>
	<CAKohpon63d40c8eGKqY9EHZhb18ipKHhvBffo=buLLpP=CP0rA@mail.gmail.com>
	<20130812071042.GA30670@samfundet.no>
	<CAKohpomMmCbSd=H=Jh_dvbSWsv7z_Od_m=UG6-TX91SfXMez9w@mail.gmail.com>
	<20130812073058.GA7776@samfundet.no>
	<CAKohpon=pRK9WX=BqPtN3gSZXBxX62J=PW4sbzUxsoc0fJGhkQ@mail.gmail.com>
	<20130812191121.GA18863@samfundet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130812191121.GA18863@samfundet.no>
Sender: cpufreq-owner@vger.kernel.org
To: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 13 August 2013 00:41, Hans-Christian Egtvedt <egtvedt@samfundet.no> =
wrote:
> Around Mon 12 Aug 2013 13:09:25 +0530 or thereabout, Viresh Kumar wro=
te:
>> On 12 August 2013 13:00, Hans-Christian Egtvedt <egtvedt@samfundet.n=
o> wrote:
>>> I'll add it on my todo-list and have a look at it in the evening (-=
:
>>
>> Thanks.
>>
>>> How hard can it be=99
>>
>> Its not about being hard but about knowing your platform well..
>
> Turned out to be quite easy, but I couldn't get around to test it on
> hardware (excuse: just moved, all HW is still in a box somewhere).

I had a quick look at it and yes it is pretty much hadware specific :)
Thanks.

> I'll submit the patch to cpufreq@vger.kernel.org for a sanity check, =
perhaps
> you'll pull it into your series?

Yes, I will.
