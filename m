From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / CPPC: Fix per-CPU pointers management
Date: Sat, 10 Dec 2016 00:52:28 +0100
Message-ID: <296282606.tnoJCKgU2l@aspire.rjw.lan>
References: <cover.1479844244.git.tim.c.chen@linux.intel.com> <20161209144551.jhnbfsxdxsk4ld6s@linutronix.de> <CAJZ5v0jUCHSM90yEoygAbKVY3ySaWQk-Cp6qkd+6ESH74J2_8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jUCHSM90yEoygAbKVY3ySaWQk-Cp6qkd+6ESH74J2_8A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Enabling ACPI CPPC on x86 causes a NULL pointer dereference to occur
(on boot on a "default" KVM setup) in acpi_cppc_processor_exit() due
to a missing check against NULL in there:

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

Fix that and while at it, fix a possible use-after-free scenario in
acpi_cppc_processor_probe() that can happen if the function returns
without cleaning up the per-CPU pointer set by it previously.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Original-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Hi Thomas,

The crash fixed by this is exposed by the ITMT (asymmetric packing) series
(which involves using ACPI CPPC on x86), so IMO it would be good to route it
through tip along with that series.

Thanks,
Rafael

---
 drivers/acpi/cppc_acpi.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/cppc_acpi.c
===================================================================
--- linux-pm.orig/drivers/acpi/cppc_acpi.c
+++ linux-pm/drivers/acpi/cppc_acpi.c
@@ -776,9 +776,6 @@ int acpi_cppc_processor_probe(struct acp
 		init_waitqueue_head(&pcc_data.pcc_write_wait_q);
 	}
 
-	/* Plug PSD data into this CPUs CPC descriptor. */
-	per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
-
 	/* Everything looks okay */
 	pr_debug("Parsed CPC struct for CPU: %d\n", pr->id);
 
@@ -789,10 +786,15 @@ int acpi_cppc_processor_probe(struct acp
 		goto out_free;
 	}
 
+	/* Plug PSD data into this CPUs CPC descriptor. */
+	per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
+
 	ret = kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
 			"acpi_cppc");
-	if (ret)
+	if (ret) {
+		per_cpu(cpc_desc_ptr, pr->id) = NULL;
 		goto out_free;
+	}
 
 	kfree(output.pointer);
 	return 0;
@@ -826,6 +828,8 @@ void acpi_cppc_processor_exit(struct acp
 	void __iomem *addr;
 
 	cpc_ptr = per_cpu(cpc_desc_ptr, pr->id);
+	if (!cpc_ptr)
+		return;
 
 	/* Free all the mapped sys mem areas for this CPU */
 	for (i = 2; i < cpc_ptr->num_entries; i++) {

