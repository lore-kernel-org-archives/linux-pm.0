From: Arto Jantunen <viiru@iki.fi>
Subject: Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4
Date: Tue, 01 Mar 2016 21:47:18 +0200
Message-ID: <878u22rneh.fsf@iki.fi>
References: <87egc7ahqn.fsf@iki.fi> <000401d16bfc$21338450$639a8cf0$@net>
	<87a8mv9ujm.fsf@iki.fi>
	<36DF59CE26D8EE47B0655C516E9CE640286C6253@shsmsx102.ccr.corp.intel.com>
	<87egc6zc2q.fsf@iki.fi>
	<36DF59CE26D8EE47B0655C516E9CE640286C6319@shsmsx102.ccr.corp.intel.com>
	<56CA17D4.8080802@linux.intel.com> <87lh6du7lu.fsf@iki.fi>
	<20160222061637.GF28226@vireshk-i7> <871t84vgvq.fsf@iki.fi>
	<20160222164114.GU28226@vireshk-i7> <87egbwn8lp.fsf@iki.fi>
	<20160229201946.0bdcc48e@annuminas.surriel.com>
	<87twkqllst.fsf@kirika.int.wmdata.fi>
	<1456860175.25322.59.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from viiru.iki.fi ([185.19.28.114]:34921 "EHLO viiru.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054AbcCATr3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Mar 2016 14:47:29 -0500
In-Reply-To: <1456860175.25322.59.camel@redhat.com> (Rik van Riel's message of
	"Tue, 01 Mar 2016 14:22:55 -0500")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Rik van Riel <riel@redhat.com> writes:

> On Tue, 2016-03-01 at 09:06 +0200, Arto Jantunen wrote:
>> Rik van Riel <riel@redhat.com> writes:
>> > What does the cpufreq table for that CPU look like?
>> > 
>> > Does HLT (or its equivalent) have a really, really high
>> > exit or residency latency?
>> 
>> I don't know the answer to either of these questions. How do I find
>> out?
>
> Could you run this?
>
> #!/bin/sh
> for i in `seq 0 10`; do
> 	if [ -d /sys/devices/system/cpu/cpu0/cpuidle/state$i ]; then
> 		echo -n "state $i latency: "
> 		cat
> /sys/devices/system/cpu/cpu0/cpuidle/state$i/latency
> 	fi
> done

Here is the output:

state 0 latency: 0
state 1 latency: 1
state 2 latency: 151
state 3 latency: 1034

-- 
Arto Jantunen
