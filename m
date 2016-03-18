From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: use high confidence factors only when considering polling
Date: Thu, 17 Mar 2016 23:32:09 -0700
Message-ID: <000701d180df$e8a14340$b9e3c9c0$@net>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com> <CAJZ5v0iK=vO1HPKfbpMwNx_Tk-kjGEUKrCmehaK7nN+-Up7BoA@mail.gmail.com> <20160316121400.680a6a46@annuminas.surriel.com> <10828426.sI6CaBvZhk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta13.telus.net ([209.171.16.86]:34407 "EHLO cmta13.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076AbcCRGcO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Mar 2016 02:32:14 -0400
In-Reply-To: <10828426.sI6CaBvZhk@vostro.rjw.lan>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Rik van Riel' <riel@redhat.com>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Chen, Yu C'" <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, 'Arto Jantunen' <viiru@iki.fi>, 'Len Brown' <lenb@kernel.org>

Sorry for the delay in my reply / test. The patch e-mail went
to my junk folder for some reason.

On 2106.03.17 17:46 Rafael J. Wysocki wrote:
> On Wednesday, March 16, 2016 12:14:00 PM Rik van Riel wrote:
>> The menu governor uses five different factors to pick the
>> idle state:
>> - the user configured latency_req
>> - the time until the next timer (next_timer_us)
>> - the typical sleep interval, as measured recently
>> - an estimate of sleep time by dividing next_timer_us by an observed factor
>> - a load corrected version of the above, divided again by load
>> 
>> Only the first three items are known with enough confidence that
>> we can use them to consider polling, instead of an actual CPU
>> idle state, because the cost of being wrong about polling can be
>> excessive power use.
>> 
>> The latter two are used in the menu governor's main selection
>> loop, and can result in choosing a shallower idle state when
>> the system is expected to be busy again soon.
>> 
>> This pushes a busy system in the "performance" direction of
>> the performance<>power tradeoff, when choosing between idle
>> states, but stays more strictly on the "power" state when
>> deciding between polling and C1.
>> 
>> Signed-off-by: Rik van Riel <riel@redhat.com>

For my part of it, this patch seems to be not O.K.
(reference rvr5 = this patch)

Aggregate idle for the 2000 second test. All in minutes.
(old tests re-stated)

State	k45rc7-rjw10	k45rc7-rjw10-reverted	k45rc7-rjw10-rvr5
0.00	18.07			0.92				18.67
1.00	12.35			19.51				12.82
2.00	3.96			4.28				3.97
3.00	1.55			1.53				1.58
4.00	138.96		141.99			143.80
			
total	174.90		168.24			180.84

Energy:
>> Kernel 4.5-rc7-rjw10: 61983 Joules
>> Kernel 4.5-rc7-rjw10-reverted: 48409 Joules (test 2 was 55040 Joules)
Kernel 4.5-rc7-rjw10-rvr5: 62243 Joules

I did acquire trace data with this test, but haven't post processed it yet.

... Doug


