From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH v2] cpuidle: poll_state: Add time limit to poll_idle()
Date: Fri, 23 Mar 2018 14:30:03 -0700
Message-ID: <000001d3c2ee$1e45c410$5ad14c30$@net>
References: <4137867.C4jYrWdt8n@aspire.rjw.lan> <20180314120450.GT4043@hirez.programming.kicks-ass.net> <004c01d3c255$c1f146a0$45d3d3e0$@net> <CAJZ5v0iZVVkevY2oJnySoa6uQesMXcj_ZshV97utdXsW2w-aAA@mail.gmail.com> zIfde8JFp1KonzIfeepFUa
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: zIfde8JFp1KonzIfeepFUa
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: 'Rik van Riel' <riel@surriel.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Frederic Weisbecker' <fweisbec@gmail.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'LKML' <linux-kernel@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.03.23 02:08 Rafael J. Wysocki wrote:
> On Fri, Mar 23, 2018 at 9:57 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Fri, Mar 23, 2018 at 4:19 AM, Doug Smythies <dsmythies@telus.net> wrote:
>>> On 2018.03.22 12:12 Doug Smythies wrote:

...[snip]...

>>
>>> I'm not sure how good it is but I made a test. I didn't believe
>>> the results, so I did it 3 times.
>>>
>>> V7.3 is as from the git branch.
>>> V7.3p is plus the patch adding the counter loop to poll_state.c
>>>
>>> The test is a tight loop (about 19600 loops per second) running
>>> on all 8 CPUs. I can not seem to get my system to use Idle State
>>> 0, so I disabled Idle States 1 and 2 to force use of Idle State 0.
>>>
>>> V7.3 uses a processor package power of 62.5 Watts
>>> V7.3p uses a processor package power of 53.4 Watts, or 14.6% less power.
>>>
>>> The loop times do not change.
>>> The Idle state 0 residency per unit time does not change.
>>
>> OK, so this means that the results should improve for Rik with this
>> patch too. :-)

I hope so.

> BTW, can you possibly check how much of a difference it makes to
> reduce POLL_IDLE_COUNT in the patch to, say, 500 or even more?
> 
> The lower it is, the less noise it will introduce AFAICS.

Well, we would expect the curve to be something like a typical 1/x curve:

Power = 53.4 + k1/(k2* POLL_IDLE_COUNT + k3)

I did some runs and did a crude fit:

Power ~= 53.4 + 35/(POLL_IDLE_COUNT + 3)

And then calculate an allowed error from that. A count of 100 gives
back only 0.64% of the power, and so I suggest would be a reasonable
number.

That being said, my test is quite crude and we should first see what
others, including Rik, get.

These two graphs might help explain what I did:

http://fast.smythies.com/v73p_vary_count.png
http://fast.smythies.com/v73p_extra_power.png

It is just my opinion, but I think users with very stringent
idle state 0 exit latency requirements should test with
POLL_IDLE_COUNT set to 1. Then they know the worst case works,
whereas they might not hit it at 1/POLL_IDLE_COUNT probability.
Once happy that the worst case works, use nominal (T.B.D.)
POLL_IDLE_COUNT, for the power savings.

... Doug
