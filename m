From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC/RFT][PATCH 0/4] cpufreq / sched: iowait boost in intel_pstate and schedutil
Date: Wed, 7 Sep 2016 08:25:43 -0700
Message-ID: <005301d2091c$1bbfe1e0$533fa5a0$@net>
References: <000401d206c4$ad0db8c0$07292a40$@net> gh9ibmgRBnrRxgh9kbHD9W
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta19.telus.net ([209.171.16.92]:35786 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753099AbcIGPZu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Sep 2016 11:25:50 -0400
In-Reply-To: gh9ibmgRBnrRxgh9kbHD9W
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Linux PM list' <linux-pm@vger.kernel.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Ingo Molnar' <mingo@redhat.com>, 'Vincent Guittot' <vincent.guittot@linaro.org>, 'Morten Rasmussen' <morten.rasmussen@arm.com>, 'Juri Lelli' <Juri.Lelli@arm.com>, 'Dietmar Eggemann' <dietmar.eggemann@arm.com>, 'Steve Muckle' <smuckle@linaro.org>, 'Doug Smythies' <doug.smythies@gmail.com>

On 2016.09.04 16:55 Rafael J. Wysocki wrote:
> On Sunday, September 04, 2016 08:54:49 AM Doug Smythies wrote:
>> On 2016.09.02 17:57 Rafael J. Wysocki wrote:
>> 
>>> This is a new version of the "iowait boost" series I posted a few weeks
>>> ago.  Since the first two patches from that series have been reworked and
>>> are in linux-next now, I've rebased this series on top of my linux-next
>>> branch.
>>>
>>> In addition to that I took the Doug's feedback into account in the
>>> intel_pstate patches [2-3/4].
>> 
>> You got ahead of me a little.
>> Recall the suggestion for the addition of some filtering was based
>> on energy savings. And further that it might make sense to use
>> average pstate as input to the filter (your new patch 3 of 4).
>> In my testing (of the old patch set) I have been finding that some
>> of those energy savings are being given back by the average pstate
>> method, putting its value added into question.
>> 
>> Switching to the new patch set, I made two kernels (based on 4.8-rc4
>> + your pre-requisite 2 patches):
>> rfc4: has all 4 patches.
>> rfc2: has patches 1, 2, 4. (does not have the average pstate change)
>> 
>> Using my SpecPower simulator test at 20% load I get:
>> 
>> Unpatched (reference): ~5905 Joules
19.68 watts
>> rfc4: ~ 6232 Joules (+5.5%)
20.77 watts
>> rfc2: ~ 6075 Joules (+2.9%)
20.25 watts
>> Old rfc, no filter (restated): ~7197 Joules (+21.9%)
>> Old rfc + old iir filter V2: ~5967 Joules (+1%)
>> Old rfc + old ave pstate method: ~6275 Joules (+6.3%)
The above numbers are all an average of 4 runs of 300 seconds each.
See further down for why I added normalized watts.
>> 
>> Srinivas was getting considerably different, but still
>> encouraging, numbers on the real SpecPower test beds.
>> 
>> I would like to suggest/ask that those real SpecPower tests be done
>> first so as to decide a preferred way forward. I'll also re-do my
>> simulator tests over a longer time period and at some other loads
>> (currently 20% is hard coded).
>
> The reason I made patch [3/4] separate was to make it easier to test without
> that change.  That is, apply [1-2/4] and see what difference it makes.
>
> I'd like to see the results from that if poss.

O.K., that is what I was doing anyway.
I have some more data from my SpecPower simulator test:

Note: My calibration was out by quite a bit, so what I called 20%
was actually about 36.4%. While I knew it was out, I didn't know it
was that much, but I didn't care as it wasn't really relevant to
the compare type tests I was doing. I'll just use "X" in the table
below, where X ~= 18.2% on a real SpecPower.

Big numbers are Joules (package Joules from turbostat)
Smaller numbers are watts, 1500 Seconds test run time.

Load:		idle	0.5X	X	2X	3X	4X	5X	100%
Unpatched:	5757	11050	16048	29012	47575	61313	76634	81737
		3.84	7.37	10.70	19.34	31.72	40.88	51.09	54.49

rfc4:		5723	11323	17079	31561	47666	62625	76286	81664
		3.82	7.55	11.39	21.04	31.78	41.75	50.86	54.44
		-0.6%	2.5%	6.4%	8.8%	0.2%	2.1%	-0.5%	-0.1%

rfc2:		5769	11319	17140	30533	45158	61387	75690	81722
		3.85	7.55	11.43	20.36	30.11	40.92	50.46	54.48
		0.2%	2.4%	6.8%	5.2%	-5.1%	0.1%	-1.2%	0.0%

And again, 2nd run:

		idle	0.5X	X	2X	3X	4X	5X	100%
Unpatched:	5708	11037	16075	29147	45913	61165	76650	81695
		3.81	7.36	10.72	19.43	30.61	40.78	51.10	54.46

rfc4:		5770	11303	17023	31508	47653	62520	75798	81725
		3.85	7.54	11.35	21.01	31.77	41.68	50.53	54.48
		1.1%	2.4%	5.9%	8.1%	3.8%	2.2%	-1.1%	0.0%

rfc2:		5793	11242	17044	30258	45178	61526	75631	81669
		3.86	7.49	11.36	20.17	30.12	41.02	50.42	54.45
		1.5%	1.9%	6.0%	3.8%	-1.6%	0.6%	-1.3%	0.0%

Note: Comparing the 2X data to the further above numbers
from the other day shows more run to run variability than
I had expected. (I have very very few services running
on my test server, so background idle is really quite
idle.)

... Doug


