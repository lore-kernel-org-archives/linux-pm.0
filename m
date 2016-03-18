From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: use high confidence factors only when considering polling
Date: Fri, 18 Mar 2016 13:59:39 -0700
Message-ID: <004901d18159$18967100$49c35300$@net>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>	<CAJZ5v0iK=vO1HPKfbpMwNx_Tk-kjGEUKrCmehaK7nN+-Up7BoA@mail.gmail.com>	<20160316121400.680a6a46@annuminas.surriel.com>	<10828426.sI6CaBvZhk@vostro.rjw.lan>	<000701d180df$e8a14340$b9e3c9c0$@net>	<CAJZ5v0gLXE=sRxv35hKuX88L4tphSBtPb9Y2oLERuEhjsbTGJQ@mail.gmail.com>	<003301d18144$87bb8df0$9732a9d0$@net> <20160318152957.5c3b91bc@annuminas.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta13.telus.net ([209.171.16.86]:51614 "EHLO cmta13.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbcCRU7n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Mar 2016 16:59:43 -0400
In-Reply-To: <20160318152957.5c3b91bc@annuminas.surriel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Rik van Riel' <riel@redhat.com>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Chen, Yu C'" <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, 'Arto Jantunen' <viiru@iki.fi>, 'Len Brown' <lenb@kernel.org>

On 2106.03.18 12:30 Rik van Riel wrote:
> On Fri, 18 Mar 2016 11:32:28 -0700 Doug Smythies wrote:
>> On 2016.03.18 06:12 Rafael J. Wysocki wrote:

>>> I'm wondering what happens if you replace the expected_interval in the
>>> "expected_interval >
>>> drv->states[CPUIDLE_DRIVER_STATE_START].target_residency" test with
>>> data->next_timer_us (with the Rik's patch applied, of course).  Can
>>> you please try doing that?  
>> 
>> O.K. my reference: rvr6 is the above modification to rvr5
>> It works as well as "reverted"/
>> 
>> State	k45rc7-rjw10-rvr6 (mins)
>> 0.00	0.87
>> 1.00	24.20
>> 2.00	4.05
>> 3.00	1.72
>> 4.00	147.50
>> 
>> total	178.34
>> 
>> Energy:
>> Kernel 4.5-rc7-rjw10-rvr6: 55864 Joules
>> 
>> Trace data (very crude summary):
>> Kernel 4.5-rc7-rjw10-rvr5: ~3049 long durations at high CPU load (idle state 0)
>> Kernel 4.5-rc7-rjw10-rvr5: ~183 long durations at high, but less, CPU load (not all idle state 0)
>
> What does "long duration" mean? 
> Dozens of microseconds?
> Hundreds of microseconds?
> Milliseconds?

On average, 100s of milliseconds, and as much as 4 seconds.

Specifically, for the Kernel 4.5-rc7-rjw10-rvr5 case, of 3049:
The average load was 97.2% and the average "Long" duration was 295.2 mSec.
Example 1: CPU 5 load 99.96% duration 1.96 seconds.
Example 2: CPU 5 load 99.74% duration 2.68 seconds.
Example 3: CPU 7 load 97.86% duration 2.30 seconds.

So, to repeat what I said the other day, but in another way:
The estimate can be correct 99.9% (or even more) of the time,
but when it isn't right, and the CPU gets left in idle state 0,
sometimes it can get left there for a very very long time.

> Either way, it appears there is something wrong with the
> code in get_typical_interval.  One of the problems is
> that calculating in microseconds, when working with a
> threshold of 1-2 microseconds is not going to work well,
> and secondly the code declares success the moment the
> standard deviation is below 20 microseconds, which is
> also not the best idea when dealing with 1-2 microsecond
> thresholds :)
>
> Does the below patch help?

I'll report back later on that part. The test computer is busy
with something else at the moment.

... Doug


