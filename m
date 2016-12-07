From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v8 8/8] cpufreq: intel_pstate: Use CPPC to get max
 performance
Date: Wed, 7 Dec 2016 20:06:08 +0100
Message-ID: <20161207190608.boi7svavwrkx3epm@breakpoint.cc>
References: <cover.1479844244.git.tim.c.chen@linux.intel.com>
 <0998b98943bcdec7d1ddd4ff27358da555ea8e92.1479844244.git.tim.c.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:48876 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752160AbcLGTGX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2016 14:06:23 -0500
Content-Disposition: inline
In-Reply-To: <0998b98943bcdec7d1ddd4ff27358da555ea8e92.1479844244.git.tim.c.chen@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 2016-11-22 12:24:00 [-0800], Tim Chen wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> This change uses acpi cppc_lib interface to get CPPC performance limits
> and calls scheduler interface to update per cpu highest priority. If
> there is a difference in highest performance of each CPUs, call scheduler
> interface to enable ITMT feature for only one time.
> 
> Here sched_set_itmt_core_prio() is called to set priorities and
> sched_set_itmt_support() is called to enable ITMT feature.

First I had crashed what I bisected down to de966cf4a4fa ("sched/x86: Change
CONFIG_SCHED_ITMT to CONFIG_SCHED_MC_PRIO") because it made SCHED_ITMT the
default.
Then I run another bisect round and got here with the same backtrace:
|BUG: unable to handle kernel NULL pointer dereference at           (null)
|IP: [<ffffffff812aab6e>] acpi_cppc_processor_exit+0x40/0x60
|PGD 0 [    0.577616]
|Oops: 0000 [#1] SMP
|Modules linked in:
|CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.9.0-rc6-00146-g17669006adf6 #51
|task: ffff88003f878000 task.stack: ffffc90000008000
|RIP: 0010:[<ffffffff812aab6e>]  [<ffffffff812aab6e>] acpi_cppc_processor_exit+0x40/0x60
|RSP: 0000:ffffc9000000bd48  EFLAGS: 00010296
|RAX: 00000000000137e0 RBX: 0000000000000000 RCX: 0000000000000001
|RDX: ffff88003fc00000 RSI: 0000000000000000 RDI: ffff88003fbca130
|RBP: ffffc9000000bd60 R08: 0000000000000514 R09: 0000000000000000
|R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000002
|R13: 0000000000000020 R14: ffffffff8167cb00 R15: 0000000000000000
|FS:  0000000000000000(0000) GS:ffff88003fcc0000(0000) knlGS:0000000000000000
|CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
|CR2: 0000000000000000 CR3: 0000000001618000 CR4: 00000000000406e0
|Stack:
| ffff88003f939848 ffff88003fbca130 0000000000000001 ffffc9000000bd80
| ffffffff812a4ccb ffff88003fc0cee8 0000000000000000 ffffc9000000bdb8
| ffffffff812dc20d ffff88003fc0cee8 ffffffff8167cb00 ffff88003fc0cf48
|Call Trace:
| [<ffffffff812a4ccb>] acpi_processor_stop+0xb2/0xc5
| [<ffffffff812dc20d>] driver_probe_device+0x14d/0x2f0
| [<ffffffff812dc41e>] __driver_attach+0x6e/0x90
| [<ffffffff812da234>] bus_for_each_dev+0x54/0x90
| [<ffffffff812dbbf9>] driver_attach+0x19/0x20
| [<ffffffff812db6a6>] bus_add_driver+0xe6/0x200
| [<ffffffff812dcb23>] driver_register+0x83/0xc0
| [<ffffffff816f050a>] acpi_processor_driver_init+0x20/0x94
| [<ffffffff81000487>] do_one_initcall+0x97/0x180
| [<ffffffff816ccf5c>] kernel_init_freeable+0x112/0x1a6
| [<ffffffff813a0fc9>] kernel_init+0x9/0xf0
| [<ffffffff813acf35>] ret_from_fork+0x25/0x30
|Code: 02 00 00 00 48 8b 14 d5 e0 c3 55 81 48 8b 1c 02 4c 8d 6b 20 eb 15 49 8b 7d 00 48 85 ff 74 05 e8 39 8c d9 ff 41 ff c4 49 83 c5 20 <44> 3b 23 72 e6 48 8d bb a0 02 00 00 e8 b1 6f f9 ff 48 89 df e8
|RIP  [<ffffffff812aab6e>] acpi_cppc_processor_exit+0x40/0x60
| RSP <ffffc9000000bd48>
|CR2: 0000000000000000
|---[ end trace 917a625107b09711 ]---

The patch attached fixes it. Could someone who looked longer at the code
than I actually confirm that this fine or fix it differently? This makes
the crash on boot on a "default" kvm setup go away.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/acpi/cppc_acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index d0d0504b7c89..93252e5374c5 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -803,6 +803,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 		if (addr)
 			iounmap(addr);
 	}
+	per_cpu(cpc_desc_ptr, pr->id) = NULL;
 	kfree(cpc_ptr);
 
 out_buf_free:
@@ -824,6 +825,8 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
 	void __iomem *addr;
 
 	cpc_ptr = per_cpu(cpc_desc_ptr, pr->id);
+	if (!cpc_ptr)
+		return;
 
 	/* Free all the mapped sys mem areas for this CPU */
 	for (i = 2; i < cpc_ptr->num_entries; i++) {
-- 
2.11.0
