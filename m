From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFT][PATCH v7 5/8] cpuidle: Return nohz hint from cpuidle_select()
Date: Wed, 21 Mar 2018 23:24:44 -0700
Message-ID: <002d01d3c1a6$7a06bc30$6e143490$@net>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <1635957.yuHkCe9oyz@aspire.rjw.lan> <CAJZ5v0j-CnEms-Wm0Op=386ceuG2GfAouVLXO48rbD_pUPJhMg@mail.gmail.com> <b05c00e7-b5d8-0bcb-0b38-a91324ec597a@tu-dresden.de> ym0ceyYVT1Konym0eegfln
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: ym0ceyYVT1Konym0eegfln
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>
Cc: 'Linux PM' <linux-pm@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, 'Frederic Weisbecker' <fweisbec@gmail.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Rik van Riel' <riel@surriel.com>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'LKML' <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.03.21 15:15 Rafael J. Wysocki wrote:
> On Wed, Mar 21, 2018 at 6:59 PM, Thomas Ilsche wrote:
>> On 2018-03-21 15:36, Rafael J. Wysocki wrote:
>>>
>>>
>>> So please disregard this one entirely and take the v7.2 replacement
>>> instead of it:https://patchwork.kernel.org/patch/10299429/
>>>
>>> The current versions (including the above) is in the git branch at
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>>>   idle-loop-v7.2
>>
>> With v7.2 (tested on SKL-SP from git) I see similar behavior in idle
>> as with v5: several cores which just keep the sched tick enabled.
>> Worse yet, some go only in C1 (not even C1E!?) despite sleeping the
>> full sched tick.
>> The resulting power consumption is ~105 W instead of ~ 70 W.
>>
>> https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/v7_2_skl_sp_idle.png
>>
>> I have briefly ran v7 and I believe it was also affected.
>
> Then it looks like menu_select() stubbornly thinks that the idle
> duration will be within the tick boundary on those cores.
> 
> That may be because the bumping up of the correction factor in
> menu_reflect() is too conservative or it may be necessary to do
> something radical to measured_us in menu_update() in case of a tick
> wakeup combined with a large next_timer_us value.
>
> For starters, please see if the attached patch (on top of the
> idle-loop-v7.2 git branch) changes this behavior in any way.

O.K. I am seeing some weirdness.
On my system with both V7.2 and V7.2 plus this patch, I observe
A spike in Idle State 1 residency every 34+ minutes. And slightly
higher average idle power than before. (I might not have done V7
idle tests long enough).

It can be seen in the frequency sweep I did earlier today, with V7.2:

http://fast.smythies.com/rjw_freq_sweep_72_combined.png

Despite the note on the graph that says it might be real, I don't think
it is (I forgot to delete the note).

With V7.2+ sometimes the event occurs at 17 minute intervals.
Here is a idle graph (for reference: we have seen idle package power
pretty steady at ~3.7 watts before).

http://fast.smythies.com/rjw_v72p_idle.png

... Doug
 
