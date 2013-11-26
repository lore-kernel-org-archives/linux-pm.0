From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/8] Cure faux idle wreckage
Date: Tue, 26 Nov 2013 16:57:43 +0100
Message-ID: <20131126155743.116756708@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>, lenb@kernel.org, rjw@rjwysocki.net, Eliezer Tamir <eliezer.tamir@linux.intel.com>, David Miller <davem@davemloft.net>, rui.zhang@intel.com, jacob.jun.pan@linux.intel.com, Mike Galbraith <bitbucket@online.de>, Ingo Molnar <mingo@kernel.org>, hpa@zytor.com, paulmck@linux.vnet.ibm.com, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Respin of the earlier series that tries to cure the 2 idle injection drivers
and cleans up some of the preempt_enable_no_resched() mess.

The intel_powerclamp driver is tested by Jacob Pan and needs one more patch to
cpuidle to work as before. I'll let him provide this patch; since he actually
has it and tested it.

Jacob also said he'll try and work with the QoS people to sort out the conflict
of interest between the idle injectors and the QoS framework.

Can someone please test acpi_pad? Rafael, since the original author seems MIA
and you're the over-all ACPI maintainer, can you appoint a person who knows
what he's doing? Alternatively, Jacob would you be willing to have a look at
that thing? Better still rm drivers/acpi/acpi_pad.c ?

Thomas, can you pick this series up and merge it into -tip provided acpi_pad
works?


---
Changes since the earlier version:

 - fixed a few build issues; thanks Jacob for spotting them
 - Added PF_IDLE so that is_idle_task() can work for the faux idle
   tasks, which in turn is require for RCU-idle support.
 - added an rcu_sleep_check() to play_idle() to ensure we don't try
   and play idle while holding rcu_read_lock(), which would counter
   the previous point.
 - changed the net busy_poll over to local_clock().
