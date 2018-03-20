From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFT][PATCH v5 7/7] cpuidle: menu: Avoid selecting shallow states with stopped tick
Date: Tue, 20 Mar 2018 10:15:02 -0700
Message-ID: <002401d3c06e$fed035b0$fc70a110$@net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <2148754.TY7qXgFyZy@aspire.rjw.lan> xuDHe5JrTQdbpxuDMeg0da xyzzeKNZFlebYxzQ2eVyR7
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: xyzzeKNZFlebYxzQ2eVyR7
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Rik van Riel' <riel@surriel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'Frederic Weisbecker' <fweisbec@gmail.com>, 'LKML' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.03.20 11:22 Doug Smythies wrote:
> On 2018.03.19 05:47 Thomas Ilsche wrote:
>> On 2018-03-15 23:19, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> 
>>> If the scheduler tick has been stopped already and the governor
>>> selects a shallow idle state, the CPU can spend a long time in that
>>> state if the selection is based on an inaccurate prediction of idle
>>> time.  That effect turns out to be noticeable, so it needs to be
>>> mitigated.
>>
>> What are some common causes for that situation?
>> How could I trigger this for testing?
>
> It appeared quite readily with my simple 100% load
> on one CPU test. Back then (V3) there only 6 patches in the set,
> and before the re-spin there ended up being a patch 7 of 6, which
> made a significant difference in both package power and the
> histograms of times in each idle state.
>
> Reference:
> https://marc.info/?l=linux-pm&m=152075419526696&w=2

I made a kernel (4.16-rc5) with only patches 1 to 6 of 7 (V6)
and also with the poll fix.

I took an old graph:
http://fast.smythies.com/rjwv3pp_100.png

and removed an obsolete line and added a line from this
kernel:

http://fast.smythies.com/rjwv6m_100.png

I also acquired a trace during the test and observe:

Report: Summary:

Idle State 0: Total Entries: 699 : PowerNightmares: 0 : Not PN time (seconds): 0.031169 : PN time: 0.000000 : Ratio: 0.000000
Idle State 1: Total Entries: 3855 : PowerNightmares: 106 : Not PN time (seconds): 0.123759 : PN time: 43.511914 : Ratio: 351.585856
Idle State 2: Total Entries: 3688 : PowerNightmares: 181 : Not PN time (seconds): 1.303237 : PN time: 63.241424 : Ratio: 48.526418
Idle State 3: Total Entries: 528 : PowerNightmares: 115 : Not PN time (seconds): 0.276290 : PN time: 44.764111 : Ratio: 162.018571

Where "PowerNightmare" is defined as spending excessive time in an idle state,
and arbitrarily defined for my processor as:

#define THRESHOLD_0 100       /* Idle state 0 PowerNightmare threshold in microseconds */
#define THRESHOLD_1 1000      /* Idle state 1 PowerNightmare threshold in microseconds */
#define THRESHOLD_2 2000      /* Idle state 2 PowerNightmare threshold in microseconds */
#define THRESHOLD_3 4000      /* Idle state 3 PowerNightmare threshold in microseconds */

While this trace file was only about 15 megabytes, I have several 10s of gigabytes of trace data for
V4 + poll fix and never see any excessive time spent in any idle state.

... Doug
 
