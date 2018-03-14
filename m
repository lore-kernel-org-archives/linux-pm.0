From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
Date: Wed, 14 Mar 2018 08:00:44 -0700
Message-ID: <000f01d3bba5$3cba5a00$b62f0e00$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: w74pegSSBpApsw74ueHlNx
In-Reply-To: w74pegSSBpApsw74ueHlNx
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Peter Zijlstra' <peterz@infradead.org>, 'Frederic Weisbecker' <fweisbec@gmail.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>, 'Rik van Riel' <riel@surriel.com>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'LKML' <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, 'Linux PM' <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2018.03.14 07:09 Rafael J. Wysocki wrote:

... [snip]...

> v2 -> v3: Use local_clock() for time measurements and drop the
>          counter, since that should be lightweight enough (as
>          suggested by Peter).

I have been testing the latest of everything for a couple of days
now, and everything continues to be great.

Note that I was using a POLL_IDLE_TIME_CHECK_COUNT of 1 anyhow, because
I specifically wanted to test the worst case time through the loop.
i.e. I wanted any potential issue to be 1000 times more likely to find.
My problem is that I don't know of a good test for this specifically.

I'll switch to this V3, along with V4 of the "sched/cpuidle: Idle loop
rework" 7 patch set.

As for energy savings for just this patch only, I would refer readers
to my previous test results from late November, [1], as I haven't
re-done those Phoronix tests yet, but I don't expect the results to
differ much.

[1] https://marc.info/?l=linux-pm&m=151154499710125&w=2

... Doug
