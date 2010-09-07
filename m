From: Len Brown <lenb@kernel.org>
Subject: Re: Speedstep on Celeron SU2300 - 20% more battery
	lifetime on Windows
Date: Tue, 07 Sep 2010 12:20:44 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009071214360.22515__1002.84434524855$1283879032$gmane$org@localhost.localdomain>
References: <AANLkTiktJ5Xgnsmq2je7T3Yc5Sf53Bu8vWMM1XT1V_vm@mail.gmail.com>
	<201009020152.37466.trenn@suse.de>
	<AANLkTi=WDEA+prG26g5R9oG1uZ7cNgaMrYDtug_LM7bY@mail.gmail.com>
	<201009061035.03727.trenn@suse.de>
	<AANLkTi==7HGa9OKUDq4cpexPpdPMKVgcXqONFL+UqmRe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <AANLkTi==7HGa9OKUDq4cpexPpdPMKVgcXqONFL+UqmRe@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tiago Marques <tiagomnm@gmail.com>
Cc: discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> I'm getting around 75% in C4, the rest almost exclusively in C0.

This 25% in C0 is likely all of your battery life problem.

use top and powertop to find out what is running and why,
and see if it is something you can prevent from running.

If your CPU is more than 1% buys when "profoundly idle",
then it has a significant software or configuration problem.

cheers,
Len Brown, Intel Open Source Technology Center

ps. note for comparisons...  your XP partition should have a
"perfmon" application that can draw a pretty graph of cpu usage,
including adding counters for the various C-states.
