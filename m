From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [regression] cross core scheduling frequency drop bisected to 0c313cb20732
Date: Sun, 10 Apr 2016 00:16:49 -0700
Message-ID: <000d01d192f8$f3f8d250$dbea76f0$@net>
References: <1460092854.4051.1.camel@gmail.com>	<20160408064510.GK3448@twins.programming.kicks-ass.net>	<1460098254.5582.17.camel@gmail.com>	<2428384.mEkP3EOpsR@vostro.rjw.lan>	<1460184056.3765.160.camel@gmail.com>	<CAJZ5v0ig1qTTMw5GHO_-vuyETD46tin8bS2deyvtw0OvuDSCng@mail.gmail.com>	<1460214622.3714.8.camel@gmail.com>	<1460219974.3700.39.camel@gmail.com> <CAJZ5v0hDe=pNmWFC6fYADi=vP+WFN+7yvwOZvq_pRMARzUnoiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hDe=pNmWFC6fYADi=vP+WFN+7yvwOZvq_pRMARzUnoiw@mail.gmail.com>
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Mike Galbraith' <umgwanakikbuti@gmail.com>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Peter Zijlstra' <peterz@infradead.org>, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'LKML' <linux-kernel@vger.kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>, 'Rik van Riel' <riel@redhat.com>
List-Id: linux-pm@vger.kernel.org

On 2106.04.09 20:45 Rafael J. Wysocki wrote:
>On Sat, Apr 9, 2016 at 6:39 PM, Mike Galbraith wrote:
>>
>> Hm, setting gov=performance, and taking the average of 3 30 second
>> interval PkgWatt samples as pipe-test runs..
>>
>> 714KHz/28.03Ws = 25.46
>> 877KHz/30.28Ws = 28.96
>>
>> ..for pipe-test, the tradeoff look a bit more like red than green.
>
> Well, fair enough, but that's just pipe-test, and what about the
> people who don't see the performance gain and see the energy loss,
> like Doug?

Some numbers from my computer:

Pipe-test (100 seconds):

Kernel 4.6-rc2 gov=powersave:
Stock: 3.86 uSecs/loop and 3148.05 Joules
Reverted: 3.34 uSecs/loop and 3567.43 Joules

Reverted is 13% faster at a cost of 13% more energy.

Idle stats (done separately and for 20e6 loops)

State	k46rc2-ps (sec)	k46rc2-rev-ps(sec)
0.00	0.01			4.09
1.00	38.68			0.00
2.00	0.46			0.27
3.00	0.01			0.00
4.00	464.23		380.23
		
total	503.38		384.60

Kernel 4.6-rc2 gov=performance:
Stock: 3.89 uSecs/loop and 3154.72 Joules
Reverted: 3.25 uSecs/loop and 3445.90 Joules

Reverted is 16% faster at a cost of 9% more energy.

Idle stats (done separately and for 20e6 loops)

State	k46rc2-pf (sec)	k46rc2-rev-pf (sec)
0.00	0.00			1.43
1.00	38.89			0.04
2.00	2.08			0.03
3.00	0.01			0.01
4.00	463.05		381.54
		
total	504.03		383.05

9 incremental kernel compiles, with no changes:
(the reference test from last cycle):
(2000 seconds turbostat package energy sample time):
There is no detectable consistent change in compile times:

Kernel 4.6-rc2 gov=powersave:
Stock: 48557 Joules
Reverted: 65439 Joules

Reverted costs 34% more energy.
(note: this result is unusually high. There are variations test to test)

Kernel 4.6-rc2 gov=performance:
Stock: 49965 Joules
Reverted: 59232 Joules

Reverted costs 19% more energy.
(note: never tested gov=performance before)

Idle stats not re-done (we had several samples last cycle).

> Essentially, this trades performance gains in somewhat special
> workloads for increased energy consumption in idle.  Those workloads
> need not be run by everybody, but idle is.
>
> That said I applied the patch you're complaining about mostly because
> the commit that introduced the change in question in 4.5 claimed that
> it wouldn't affect idle power on systems with reasonably fast C1, but
> that didn't pass the reality test.  I'm not totally against restoring
> that change, but it would need to be based on very solid evidence.

... Doug
