From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFT][PATCH v5 0/7] sched/cpuidle: Idle loop rework
Date: Tue, 20 Mar 2018 10:15:30 -0700
Message-ID: <002501d3c06f$0e7cf750$2b76e5f0$@net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <001a01d3be0a$ad3a0ed0$07ae2c70$@net> <2043615.lCdO10SMaB@aspire.rjw.lan> <CAJZ5v0h0wbu_hxCyBKLxFnWRFkK6ObqTmYRHAWgHyXTd57aH9Q@mail.gmail.com> yE6GempwD1KonyE6LeVquN
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: yE6GempwD1KonyE6LeVquN
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>
Cc: 'Linux PM' <linux-pm@vger.kernel.org>, 'Frederic Weisbecker' <fweisbec@gmail.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Rik van Riel' <riel@surriel.com>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'LKML' <linux-kernel@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, "'Rafael J. Wysocki'" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.03.20 03:02 Thomas Ilsche wrote:

...[snip]...

> Consider the Skylake server system which has residencies in C1E of
> 20 us and C6 of 800 us. I use a small while(1) {usleep(300);}
> unsynchronized pinned to each core. While this is an artificial
> case, it is a very innocent one - easy to predict and regular. Between
> vanilla 4.16.0-rc5 and idle-loop/v6, the power consumption increases
> from 149.7 W to 158.1 W. On 4.16.0-rc5, the cores sleep almost
> entirely in C1E. With the patches applied, the cores spend ~75% of
> their sleep time in C6, ~25% in C1E. The average time/usage for C1E is
> also lower with v6 at ~350 us rather than the ~550 us in C6 (and in
> C1E with the baseline). Generally the new menu governor seems to chose
> C1E if the next timer is an enabled sched timer - which occasionally
> interrupts the sleep-interval into two C1E sleeps rather than one C6.
>
> Manually disabling C6, reduces power consumption back to 149.5 W.

...[snip]...

Note that one of the tests that I normally do is a work/sleep
frequency sweep from 100 to 2100 Hz, typically at a lowish
workload. I didn't notice anything odd with this test:

http://fast.smythies.com/rjw_freq_sweep.png

However, your test is at 3333 Hz (well, minus overheads).
I did the same as you. And was surprised to confirm
your power findings. In my case package power goes from
~8.6 watts to ~7.3 watts with idle state 4 (C6) disabled.

I am getting different residency times than you though.
I also observe different overheads between idle state 4
being disabled or not. i.e. my actual loop frequency
drops from ~2801 Hz to ~2754 Hz.

Example residencies over the previous minute:

Idle state 4 (C6) disabled (seconds):

Idle state 0: 0.001119
Idle state 1: 0.056638
Idle state 2: 13.100550
Idle state 3: 446.266744
Idle state 4: 0.000000

Idle state 4 (C6) enabled (seconds):

Idle state 0: 0.034502
Idle state 1: 1.949595
Idle state 2: 78.291793
Idle state 3: 96.467974
Idle state 4: 286.247524

... Doug
