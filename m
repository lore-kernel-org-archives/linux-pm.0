From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4)
Date: Fri, 11 Mar 2016 16:46:53 -0800
Message-ID: <003b01d17bf8$ad214680$0763d380$@net>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>	<87si087tsr.fsf@iki.fi>	<CAJvTdKmg=H2hqFd+fwu0t8Rx4PV8E3vNGc-j8zzVKLFX4nprYg@mail.gmail.com>	<87a8m74mcc.fsf@iki.fi>	<002d01d17a57$ec417030$c4c45090$@net>	<CAJZ5v0i0cx_xYUwFWDX5nE+rNgbX4TY0ATYuD3rEi86Ky5cA5A@mail.gmail.com>	<003701d17a5d$cab287a0$601796e0$@net>	<CAJZ5v0gaO3vB7Bz+URiwdXx2jypqPSJ3Pc_aJ5VGgh4wJyB9Kg@mail.gmail.com>	<20160311090306.1bfe380b@annuminas.surriel.com>	<002401d17bc2$fad32af0$f07980d0$@net>	<20160311153044.1a3be1c6@annuminas.surriel.com> <CAJZ5v0jkH0qQOsGDQTY7RQ_ftFiMMNSw2P8rrE99UB2YrDx4MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta12.telus.net ([209.171.16.85]:43711 "EHLO cmta12.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbcCLAq6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 11 Mar 2016 19:46:58 -0500
In-Reply-To: <CAJZ5v0jkH0qQOsGDQTY7RQ_ftFiMMNSw2P8rrE99UB2YrDx4MA@mail.gmail.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Rik van Riel' <riel@redhat.com>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Chen, Yu C'" <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, 'Arto Jantunen' <viiru@iki.fi>, 'Len Brown' <lenb@kernel.org>

On 2106.03.11 15:55 Rafael J. Wysocki wrote:
> On Fri, Mar 11, 2016 at 9:30 PM, Rik van Riel <riel@redhat.com> wrote:
>> On Fri, 11 Mar 2016 10:22:30 -0800 Doug Smythies wrote:
>>> On 2016.03.11 06:03 Rik van Riel wrote:
>>
>>>> The patch below should fix that.
>>>>
>>>> It didn't for Arto, due to the other issues on his system, but
>>>> it might resolve the issue for Doug, where cstate/pstate is
>>>> otherwise working fine.
>>>>
>>>> Doug, does the patch below solve your issue?
>>>
>>> No.
>>
>> OK, lets try doing this check a little more aggressively, since there
>> almost certainly are good reasons why the main selection loop in
>> menu_select() so aggressively tries to stay with shallower C states.
>>
>> With the patch below, we compare the (not corrected for load) expected
>> sleep time against the target residency of the C1 (hlt) state on the CPU.
>>
>> This might resolve the issue, while still doing the right thing on CPUs
>> that have really high C1 latencies (eg. Atom).
>>
>> Does this resolve the issue for you?

No, but it seems better.

Old data restated with new data added below:
Aggregate times in each idle state for the 2000 second test:

State	k45rc7 (mins)	reverted (mins)	rvr(mins)	rvr2(mins)
0.00	20.18			2.64			19.11		14.09
1.00	13.03			21.81			13.56		12.05
2.00	3.43			3.95			3.70		3.93
3.00	1.45			1.55			1.53		1.52
4.00	134.91		143.55		138.53	142.80
				
total	172.99		173.51		176.42	174.37 

Energy (old restated, plus new added):

Kernel 4.5-rc7 Reverted: 56178 Joules
Kernel 4.5-rc7: 63269 Joules (revert saves 12.6% energy)
Kernel 4.5-rc7 + rvr patch: 62914 Joules
Kernel 4.5-rc7 + rvr patch version 2: 60416 Joules

> If we do this, we probably should check the exit latency
> (against latency_req) too.

I already had the above data before I noticed Rafael's e-mail.

... Doug


