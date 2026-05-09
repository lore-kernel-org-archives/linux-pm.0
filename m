Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B039846A;
	Sat,  9 May 2026 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778319101; cv=none; b=Fm0cJzQb41SHhhIlUD8buZft4IJK8L8IkmfSEmUS/hFDRCUVFGYKzeHtWxbIR4ooTetnw8TT4tcbKZ+/8Pa44UYsphd22wRD+zY6QVkts7T4KBGox4lAnNq60MVcc2iVv+L3soIWF7xXmnLlVD2pdh5MO3vO2CRkmpbjQnUceNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778319101; c=relaxed/simple;
	bh=QPXObyv9770z5QmXD0WlqFmIrH6if9Cjwac6FRRXCkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tjbiywBtBC5rfMqsjkES/k7CUJ5PyMtjOrasG3jdsLoNgLYyOAiYN3SjOX1utua7cfpxqKxMilrNBQdHSk4Re7Mgu/JZ3LKbKsBIs4qD7+7HfnCgWvAIco7Sp/TYQj5uWX2kZN4ItKjmbJQQa5jRD2ZA7VLmH1c5JlbuSkZVRm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACHquHt_v5p9Jx7EA--.41076S2;
	Sat, 09 May 2026 17:31:25 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: xujiakai24@mails.ucas.ac.cn
Cc: ccross@android.com,
	dakr@kernel.org,
	driver-core@lists.linux.dev,
	gregkh@linuxfoundation.org,
	lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	pavel@kernel.org,
	rafael@kernel.org
Subject: Re: [PATCH] PM: sleep: Use complete() instead of complete_all() in device_pm_sleep_init()
Date: Sat,  9 May 2026 09:31:25 +0000
Message-Id: <20260509093125.3442948-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509092707.3426533-1-xujiakai24@mails.ucas.ac.cn>
References: <20260509092707.3426533-1-xujiakai24@mails.ucas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACHquHt_v5p9Jx7EA--.41076S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr17KF45uw18Ww4fXFW8JFb_yoW7Gr4Dpr
	y5XF1UGr40yr47Aw4Utry5GFykGr1UZa43uFyxJrn5K3WUK34UJryIyFy3Gr1DAr15tFy7
	tr4DtFWIgr4DKw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUgeOJUUUUU=
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/

I found this issue through fuzzing.

Here is the full crash report produced by the fuzzer:

WARNING: kernel/sched/completion.c:76 at complete_all+0x1f2/0x264 kernel/sched/completion.c:76, CPU#3: kworker/u16:13/5039
Modules linked in:
CPU: 3 UID: 0 PID: 5039 Comm: kworker/u16:13 Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
Workqueue: netns cleanup_net
epc : complete_all+0x1f2/0x264 kernel/sched/completion.c:76
 ra : complete_all+0x1f2/0x264 kernel/sched/completion.c:76
epc : ffffffff802db0ac ra : ffffffff802db0ac sp : ff20000003c572a0
 gp : ffffffff8a395420 tp : ff6000008c948000 t0 : ff20000003c56e54
 t1 : ffebffff1ff55119 t2 : 6874206e6920746f s0 : ff20000003c572e0
 s1 : ff600000b34ec8e0 a0 : ff6000008c948008 a1 : ffffffff86f7c300
 a2 : 0000000000000002 a3 : ffffffff80154b18 a4 : 0000000000000000
 a5 : 0000000000000000 a6 : 0000000000000003 a7 : ff600000ffaa88cb
 s2 : ff6000008c949000 s3 : ff600000ffa4c4a8 s4 : ffffffff9176ce88
 s5 : 0000000000000000 s6 : 0000000000000000 s7 : 1fe400000078ae6c
 s8 : ff600000866ed8a0 s9 : ff600000b34ecb88 s10: ff600000866ed8b0
 s11: ffffffff87b9a460 t3 : ffffffff8835de50 t4 : ffebffff1ff55119
 t5 : ffebffff1ff5511a t6 : 0000000000000002 ssp : 0000000000000000
status: 0000000200000120 badaddr: ffffffff802db0ac cause: 0000000000000003
[<ffffffff802db0ac>] complete_all+0x1f2/0x264 kernel/sched/completion.c:76
[<ffffffff82d8e1b4>] device_pm_remove+0x92/0x374 drivers/base/power/main.c:172
[<ffffffff82d36452>] device_del+0x32a/0x898 drivers/base/core.c:3896
[<ffffffff85561bac>] netdev_unregister_kobject+0x2da/0x4de net/core/net-sysfs.c:2314
[<ffffffff85458cdc>] unregister_netdevice_many_notify+0x15ea/0x244a net/core/dev.c:12453
[<ffffffff8545cbd6>] unregister_netdevice_many net/core/dev.c:12481 [inline]
[<ffffffff8545cbd6>] default_device_exit_batch+0x678/0x8b0 net/core/dev.c:13073
[<ffffffff853e8cbe>] ops_exit_list net/core/net_namespace.c:205 [inline]
[<ffffffff853e8cbe>] ops_undo_list+0x3e8/0x9dc net/core/net_namespace.c:252
[<ffffffff853ed65e>] cleanup_net+0x43a/0x8dc net/core/net_namespace.c:702
[<ffffffff801d597e>] process_one_work+0x9a6/0x21ba kernel/workqueue.c:3302
[<ffffffff801d91ec>] process_scheduled_works kernel/workqueue.c:3385 [inline]
[<ffffffff801d91ec>] worker_thread+0x5cc/0xde6 kernel/workqueue.c:3466
[<ffffffff801f7d58>] kthread+0x336/0x47e kernel/kthread.c:436
[<ffffffff8006a302>] ret_from_fork_kernel+0x94/0xfce arch/riscv/kernel/process.c:230
[<ffffffff86726926>] ret_from_fork_kernel_asm+0x16/0x18 arch/riscv/kernel/entry.S:363

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

[<ffffffff801d597e>] process_one_work+0x9a6/0x21ba
[<ffffffff801d91ec>] worker_thread+0x5cc/0xde6
[<ffffffff801f7d58>] kthread+0x336/0x47e
[<ffffffff8006a302>] ret_from_fork_kernel+0x94/0xfce
[<ffffffff86726926>] ret_from_fork_kernel_asm+0x16/0x18
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 3 UID: 0 PID: 5039 Comm: kworker/u16:13 Tainted: G        W           7.1.0-rc1-gdb909bd7986c #1 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
Workqueue: netns cleanup_net
Call Trace:
[<ffffffff8007c91c>] dump_backtrace+0x2e/0x3c
[<ffffffff800032ce>] show_stack+0x30/0x3c
[<ffffffff80060fa0>] dump_stack_lvl+0x10c/0x1a2
[<ffffffff80061052>] dump_stack+0x1c/0x24
[<ffffffff80003afc>] vpanic+0x362/0x7b2
[<ffffffff80003fec>] trace_suspend_resume+0x0/0x418
[<ffffffff801555fc>] check_panic_on_warn+0xc0/0xe4
[<ffffffff80155b08>] __warn+0x348/0x694
[<ffffffff8665bd94>] __report_bug+0x1f4/0x322
[<ffffffff8665c2e4>] report_bug+0xee/0x2be
[<ffffffff8007b8e8>] handle_break+0x134/0x32a
[<ffffffff866fa394>] do_trap_break+0x228/0x440
[<ffffffff867267f6>] handle_exception+0x15e/0x16a
[<ffffffff802db0ac>] complete_all+0x1f2/0x264
[<ffffffff82d8e1b4>] device_pm_remove+0x92/0x374
[<ffffffff82d36452>] device_del+0x32a/0x898
[<ffffffff85561bac>] netdev_unregister_kobject+0x2da/0x4de
[<ffffffff85458cdc>] unregister_netdevice_many_notify+0x15ea/0x244a
[<ffffffff8545cbd6>] default_device_exit_batch+0x678/0x8b0
[<ffffffff853e8cbe>] ops_undo_list+0x3e8/0x9dc
[<ffffffff853ed65e>] cleanup_net+0x43a/0x8dc
[<ffffffff801d597e>] process_one_work+0x9a6/0x21ba
[<ffffffff801d91ec>] worker_thread+0x5cc/0xde6
[<ffffffff801f7d58>] kthread+0x336/0x47e
[<ffffffff8006a302>] ret_from_fork_kernel+0x94/0xfce
[<ffffffff86726926>] ret_from_fork_kernel_asm+0x16/0x18
SMP: stopping secondary CPUs

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

