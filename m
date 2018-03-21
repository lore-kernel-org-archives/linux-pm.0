From: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Subject: Re: [RFT][PATCH v7 5/8] cpuidle: Return nohz hint from
 cpuidle_select()
Date: Wed, 21 Mar 2018 18:59:57 +0100
Message-ID: <b05c00e7-b5d8-0bcb-0b38-a91324ec597a@tu-dresden.de>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan>
 <1635957.yuHkCe9oyz@aspire.rjw.lan>
 <CAJZ5v0j-CnEms-Wm0Op=386ceuG2GfAouVLXO48rbD_pUPJhMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0j-CnEms-Wm0Op=386ceuG2GfAouVLXO48rbD_pUPJhMg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2018-03-21 15:36, Rafael J. Wysocki wrote:
> 
> So please disregard this one entirely and take the v7.2 replacement
> instead of it:https://patchwork.kernel.org/patch/10299429/
> 
> The current versions (including the above) is in the git branch at
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>   idle-loop-v7.2

With v7.2 (tested on SKL-SP from git) I see similar behavior in idle
as with v5: several cores which just keep the sched tick enabled.
Worse yet, some go only in C1 (not even C1E!?) despite sleeping the
full sched tick.
The resulting power consumption is ~105 W instead of ~ 70 W.

https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/v7_2_skl_sp_idle.png

I have briefly ran v7 and I believe it was also affected.
