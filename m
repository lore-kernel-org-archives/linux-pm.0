From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFT][PATCH v5 7/7] cpuidle: menu: Avoid selecting shallow states with stopped tick
Date: Mon, 19 Mar 2018 11:21:58 -0700
Message-ID: <003301d3bfaf$2d5e4090$881ac1b0$@net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <2148754.TY7qXgFyZy@aspire.rjw.lan> xuDHe5JrTQdbpxuDMeg0da
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: xuDHe5JrTQdbpxuDMeg0da
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Rik van Riel' <riel@surriel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'Frederic Weisbecker' <fweisbec@gmail.com>, 'LKML' <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, 'Linux PM' <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2018.03.19 05:47 Thomas Ilsche wrote:
> On 2018-03-15 23:19, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> 
>> If the scheduler tick has been stopped already and the governor
>> selects a shallow idle state, the CPU can spend a long time in that
>> state if the selection is based on an inaccurate prediction of idle
>> time.  That effect turns out to be noticeable, so it needs to be
>> mitigated.
>
> What are some common causes for that situation?
> How could I trigger this for testing?

It appeared quite readily with my simple 100% load
on one CPU test. Back then (V3) there only 6 patches in the set,
and before the re-spin there ended up being a patch 7 of 6, which
made a significant difference in both package power and the
histograms of times in each idle state.

Reference:
https://marc.info/?l=linux-pm&m=152075419526696&w=2

... Doug
 
