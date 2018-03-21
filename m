From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFT][PATCH v7 5/8] cpuidle: Return nohz hint from cpuidle_select()
Date: Wed, 21 Mar 2018 11:23:22 -0700
Message-ID: <002201d3c141$b3f9bd80$1bed3880$@net>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <1635957.yuHkCe9oyz@aspire.rjw.lan> <CAJZ5v0j-CnEms-Wm0Op=386ceuG2GfAouVLXO48rbD_pUPJhMg@mail.gmail.com> yi2qeYpqCpApsyi2ve5qq1
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: yi2qeYpqCpApsyi2ve5qq1
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>, "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: 'Peter Zijlstra' <peterz@infradead.org>, 'Frederic Weisbecker' <fweisbec@gmail.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Rik van Riel' <riel@surriel.com>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'LKML' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.03.21 11:00 Thomas Ilsche wrote:
> On 2018-03-21 15:36, Rafael J. Wysocki wrote:
>> 
>> So please disregard this one entirely and take the v7.2 replacement
>> instead of it:https://patchwork.kernel.org/patch/10299429/
>> 
>> The current versions (including the above) is in the git branch at
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>>   idle-loop-v7.2
>
> With v7.2 (tested on SKL-SP from git) I see similar behavior in idle
> as with v5: several cores which just keep the sched tick enabled.
> Worse yet, some go only in C1 (not even C1E!?) despite sleeping the
> full sched tick.
> The resulting power consumption is ~105 W instead of ~ 70 W.
>
> https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/v7_2_skl_sp_idle.png
>
> I have briefly ran v7 and I believe it was also affected.

I am not able to repeat your issues anymore.
Idle powers were fine with V7, on my test computer.
I have not done thorough idle tests with V7.2, but they looked O.K.

As for the high frequency loop stuff, I no longer see any issues there
either. I tried several loops frequencies, and did one for a couple of hours.

I'll try again later today, as there is a test running now (frequency sweep)
that takes about 4 hours.

... Doug
