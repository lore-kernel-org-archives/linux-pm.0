Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3741535C1AD
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790875799; cv=none; b=b42P0s2bwGz5F6li0lVzi5A5K5p+2uHfM1EoXH0F4lD1xZGsVUMPKX6/Tql78KyZZKAEAgkswg/G4G3DCVift0L8Dm9kq8EVr/vazFP07ztIfdZotLhfcB31Yg9UORN9IelkvVbj/HsQFllXCDsB2gzSVnj7rKkh6bQGqWu0k0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790875799; c=relaxed/simple;
	bh=3M4ImmFcMH7Lc81cniHCjN1eSXjPgHcYy2twp6Ws9DI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MwqiW7bl9s2u17G4moUh/zNaQawXIfBmpAOjs4EERO8cl9be87ytzOTcdYK48X4EkYD0lSlUw8UNlGnLiZcme4w89RBLQ26BivVVNJuZEkVM4KYWWsmd5qxuI3MmLezQTDK21TBXdagaSokYepDk2I98lqk44G8ZOkImkkQZeDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pV/loFoT; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pV/loFoT"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so50240005e9.1
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2026 10:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790875795; x=1791480595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X6XJPaZPMZnZuh9N1OZFgrUTXQxarsGeVKckCZZVV7M=;
        b=pV/loFoT6DSKJs1yMbpXWOcROHdSrtxHPyiHiN/uFK3sZWTBf/KxWdGiSye/yEko3Y
         PP1HaNm+k5+TElVfz8COAac9Mk6y/w1LLaA3MxmOolDtBuy3BPR1IVOYA2PXog5Cpra0
         b14fEP5dIOkY4MHjL231/I7vaULifuW1WMF9t7PYSudCpFdHK7bgqKkV3TGRyH+BzTgU
         BtcdJdLn37BoCwQ29kzQpXVYBt+tD+JcaaIWahoSluKH+XfJgaf3EM/ohhBITWxu0MHL
         iIilyN5fZt834disYSCTexpcWwN/f2u/GZGA5i3sNQ5NkJ15odhddRGYS+WHOZ09ruc9
         1Pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790875795; x=1791480595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X6XJPaZPMZnZuh9N1OZFgrUTXQxarsGeVKckCZZVV7M=;
        b=f3iQW7vVAW1WRZ5G5+FPMkviko+d44yCOArca5JGahkiSGQWACaUThy99h/MhLjhk3
         sh0OXp8OgyD1O4CeLNkOjx7Ebbnk4+X9ZlL0k9MMs7EipMNsa+PU1w+pSIbPg5OyJbwY
         v2jKFJnOAve3/jP4dWDiVqlumthAx8N48gsLXfFshmy/gDGV2OOFtYOyCE9smreDoDsS
         T8BBEp7mgabYX6FC9gFDYYEbSH5YPpoJE3uIzl2mxaXVxwISHC8s5ZdUIOYSKXnlCVcA
         IEhTjoP6a6llNBx43F2+ubhHM1rY6Js3zYyY9nX+ABg2wrNvSQFby1qy9irlCdTCtL51
         n3OA==
X-Forwarded-Encrypted: i=1; AKwUvBzSuKhtaYqzuqU0yc8IwJnrrthPJRSDRAepjxd9OpEzWtTT5VeZFyKqV/uLwXqlS6tEe5+mWGcr+A==@vger.kernel.org
X-Gm-Message-State: AFuF++m776uzmzuHWfxrT1avyUp22XMf1EhVsqS2LP3x73lpiJg/qfj0
	2GFoRkw8S+VoTIGkex5chYYg2Hh2ukHcaDjHPDCa5v+nX8Gij9D5mqBd
X-Gm-Gg: AYBFou2FuL0nwvhxJR5aOnNPGRo5Emitz0S5DhfQQ3VMFB3CjhTGVTupvApmB8qdOMG
	lqw0TvR9hXRC93VaOcrorCbKJDtRDDn86bBNa7RIzUbwBPCHLOn6nwY8NmX0ea3uK3ab1iNQ2cn
	sK9zUiyEnH3CpYgbJ1+NPrAKU/1HphYTJHW7I5tXH/mnZv0aRXcCysqdD+O3Zq71ITcCtTdfc0g
	I7WIAXml3XrTbLRQlsAtJNKubRfZw9blooCjM7eI+RcRTnVWqWyxR3snnWnkSfNIO1L7bW/oveE
	HTTFikd+meNAPhhYU9+xqNpq0/nMrvfhPVWTqK0yi3JBelDO94Y6VYGlT8UpDVOMiysD3zFibY9
	zrYZIx1+tg82/QkiarhLHpyba1FDd6ymTfhQiFRR8tUoymjnQUi4sWxa5aR/81ZjwCwzPq5u56S
	a2g5I0p0cr9CcobD6QAJ8gwuPUuFr2brcNgTAqhUbVL1BALCpZf2nzsoRUJoByrJJ7ePdlddmhE
	BcjAoyfjHKHsvjZy9fihvraARUP8hdGgIvciM9wG0ZkPY+XzQk=
X-Received: by 2002:a05:600c:19c8:b0:49f:bd3c:bc1a with SMTP id 5b1f17b1804b1-4a02759b3b2mr5680435e9.21.1790875795249;
        Thu, 01 Oct 2026 10:29:55 -0700 (PDT)
Received: from sp1der-OptiPlex-7080.epfl.ch (dhcp-122-dist-b-107.epfl.ch. [128.178.122.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027740a2fsm6300045e9.13.2026.10.01.10.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 10:29:54 -0700 (PDT)
From: spidermana <xuyiwen14@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] rust: cpufreq: get_callback() recursively read-locks cpufreq_driver_lock
Date: Thu,  1 Oct 2026 19:29:53 +0200
Message-ID: <20261001172953.4013498-1-xuyiwen14@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The Rust cpufreq abstraction's `get_callback()` takes cpufreq_driver_lock for read a second time on the same CPU when called from `cpufreq_quick_get()`. On qrwlock this can deadlock if a writer comes in between the two read acquisitions. I first reported this at [1] and am re-posting here as suggested.

The C driver won't hit this alone. The re-entry happens with the Rust part.
No in-tree Rust driver can currently hit this. It requires a driver that implements both `->setpolicy()` and `->get()`, e.g., drivers/cpufreq/longrun.c, and rcpufreq_dt only implements `->get()`.

It was introduced by commit 6ebdd7c

Configuraton
-------------------
- Kernel: v7.3-rc4 (should be same for v7.3-rc5 as well)
- Rust toolchain: 1.95.0 (59807616e 2026-04-14)
- Config:

	M=(make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CC=aarch64-linux-gnu-gcc-14)
	"${M[@]}" defconfig
	./scripts/config --enable RUST --enable SAMPLES --enable SAMPLES_RUST \
                 --disable CPUFREQ_DT --enable CPUFREQ_DT_RUST \
                 --enable ARM64_PSEUDO_NMI
	"${M[@]}" olddefconfig


The problem
------------
On qrwlock, the default for x86 and arm64 (CONFIG_QUEUED_RWLOCKS=y), queued_read_lock() fast-paths only while no writer is present; otherwise it drops into queued_read_lock_slowpath().
queued_write_lock_slowpath() holds wait_lock for the whole time it waits for the reader count to reach zero.

In this case, this recursive read acquisition of cpufreq_driver_lock on the same CPU could cause deadlock, especially when triggering `write_lock_irqsave(&cpufreq_driver_lock, flags)` by something like `cpufreq_register_driver`, `cpufreq_policy_free`.

CPU0                              CPU1
----                              ----
read_lock(&lock)
  - ...							  write_lock(&lock)  /* holds wait_lock for reader count to drop */
    - recursive read_lock(&lock)

The writer waits for CPU0's first read lock to be released, and CPU0 waits for the writer. Both spin with interrupts disabled.

The calling chain I understand should be:

  cpufreq_quick_get()
    cpufreq_driver->get(cpu)
      Registration::<T>::get_callback(cpu)
        PolicyCpu::from_cpu(cpu)            <- cpufreq_cpu_get() gets policy
        T::get(&mut policy)                 <- T: Driver, e.g. CPUFreqDTDriver::get()


Here, cpufreq_quick_get() calls ->get() with cpufreq_driver_lock held for
read:

  read_lock_irqsave(&cpufreq_driver_lock, flags);        <- read lock once
  if (cpufreq_driver && cpufreq_driver->setpolicy &&
      cpufreq_driver->get) {
          unsigned int ret_freq = cpufreq_driver->get(cpu);     <- hand over to rust
          ...

For a Rust driver, ->get() is Registration::<T>::get_callback(). Before
calling T::get(), it does:

  PolicyCpu::from_cpu(cpu)
    cpufreq_cpu_get(cpu)
      read_lock_irqsave(&cpufreq_driver_lock, flags)      <- read lock twice

So the same rwlock is read-locked twice on the same CPU, whatever T::get() does.


Reproducer
----------
I used Claude to do this, so this is only for reproducing the results.

1. Apply the rcpufreq_dt change so the driver has both ->setpolicy() and ->get().
2. Load the PoC module. It runs cpufreq_quick_get(0) in one work item and cpufreq_register_driver() on a dummy driver in another. The latter only takes the write lock and returns -EEXIST.
3. Within a few seconds both sides stop making progress.

Please refer to the end of this email for the reproduction code.

LOG:
---
[    0.866625] poc_race: [reader] entered
[    0.867435] poc_race: [writer] entered
[    0.966824] poc_race: t=100ms reads=279 (cpu0) writes=14 (cpu1)
[    1.067389] poc_race: t=200ms reads=279 (cpu0) writes=14 (cpu1)
[    1.067481] poc_race: *** DEADLOCK on cpufreq_driver_lock ***
...
[    1.067724] Sending NMI from CPU 2 to CPUs 0:
[    1.068171] NMI backtrace for cpu 0
[    1.068540] CPU: 0 UID: 0 PID: 12 Comm: kworker/u16:0 Not tainted 7.3.0-rc4-dirty #82 PREEMPT
[    1.068637] Hardware name: linux,dummy-virt (DT)
[    1.068821] Workqueue: events_unbound _RNvXsb_NtCs1EKtwoKEMO2_6kernel9workqueueINtNtCs1peUGmbrgHn_4core3pin3PinINtNtNtB7_5alloc4kbox3BoxINtB5_11ClosureWorkNCNvXCsl5laLrBZjt1_13rust_poc_raceNtB1V_7PocRaceNtNtB7_6module6Module4init0ENtNtB1d_9allocator7KmallocEEINtB5_15WorkItemPointerKy0_E3runB1V_
[    1.069335] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.069471] pc : queued_spin_lock_slowpath+0x34/0x320
[    1.069561] lr : queued_read_lock_slowpath+0x134/0x140
[    1.069630] sp : ffff8000800c3c70
...
[    1.073389] Call trace:
[    1.073552]  queued_spin_lock_slowpath+0x34/0x320 (P)
[    1.073675]  _raw_read_lock_irqsave+0x90/0xa4
[    1.073823]  cpufreq_cpu_get+0x38/0xd0
[    1.073845]  _RNvMs8_NtCs1EKtwoKEMO2_6kernel7cpufreqNtB5_9PolicyCpu8from_cpu+0x18/0x54
[    1.073892]  _RNvMsf_NtCs1EKtwoKEMO2_6kernel7cpufreqINtB5_12RegistrationNtCs9mMwmYWIHpd_11rcpufreq_dt15CPUFreqDTDriverE12get_callbackBW_+0x1c/0x60
[    1.073950]  cpufreq_quick_get+0x54/0xc0
[    1.074077]  _RNvXsb_NtCs1EKtwoKEMO2_6kernel9workqueueINtNtCs1peUGmbrgHn_4core3pin3PinINtNtNtB7_5alloc4kbox3BoxINtB5_11ClosureWorkNCNvXCsl5laLrBZjt1_13rust_poc_raceNtB1V_7PocRaceNtNtB7_6module6Module4init0ENtNtB1d_9allocator7KmallocEEINtB5_15WorkItemPointerKy0_E3runB1V_+0x74/0xb4
[    1.074301]  process_one_work+0x180/0x2e0
[    1.074521]  worker_thread+0x18c/0x300
[    1.074754]  kthread+0x118/0x124
[    1.074975]  ret_from_fork+0x10/0x20
[    1.275778] poc_race: --- [writer] cpu1, expected chain: ---
[    1.275832] poc_race:       cpufreq_register_driver -> write_lock (wedged)
[    1.275849] Sending NMI from CPU 2 to CPUs 1:
[    1.275894] NMI backtrace for cpu 1
[    1.275924] CPU: 1 UID: 0 PID: 39 Comm: kworker/u16:1 Not tainted 7.3.0-rc4-dirty #82 PREEMPT
[    1.275946] Hardware name: linux,dummy-virt (DT)
[    1.275957] Workqueue: events_unbound _RNvXsb_NtCs1EKtwoKEMO2_6kernel9workqueueINtNtCs1peUGmbrgHn_4core3pin3PinINtNtNtB7_5alloc4kbox3BoxINtB5_11ClosureWorkNCNvXCsl5laLrBZjt1_13rust_poc_raceNtB1V_7PocRaceNtNtB7_6module6Module4inits_0ENtNtB1d_9allocator7KmallocEEINtB5_15WorkItemPointerKy0_E3runB1V_
[    1.276012] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.276025] pc : queued_write_lock_slowpath+0x44/0x160
[    1.276043] lr : _raw_write_lock_irqsave+0x7c/0xa8
[    1.276054] sp : ffff8000803d3c30
...
[    1.276261] Call trace:
[    1.276272]  queued_write_lock_slowpath+0x44/0x160 (P)
[    1.276290]  _raw_write_lock_irqsave+0x7c/0xa8
[    1.276302]  cpufreq_register_driver+0xc4/0x280
[    1.276319]  _RNvXsb_NtCs1EKtwoKEMO2_6kernel9workqueueINtNtCs1peUGmbrgHn_4core3pin3PinINtNtNtB7_5alloc4kbox3BoxINtB5_11ClosureWorkNCNvXCsl5laLrBZjt1_13rust_poc_raceNtB1V_7PocRaceNtNtB7_6module6Module4inits_0ENtNtB1d_9allocator7KmallocEEINtB5_15WorkItemPointerKy0_E3runB1V_+0x10c/0x154
[    1.276339]  process_one_work+0x180/0x2e0
[    1.276355]  worker_thread+0x18c/0x300
[    1.276369]  kthread+0x118/0x124
[    1.276382]  ret_from_fork+0x10/0x20
[   11.501034] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   11.501985] rcu: 	0-...0: (4 ticks this GP) idle=0e7c/1/0x4000000000000000 softirq=51/51 fqs=1250
[   11.502361] rcu: 	1-...0: (1 ticks this GP) idle=4e34/1/0x4000000000000000 softirq=27/28 fqs=1250
[   11.502763] rcu: 	(detected by 2, t=2502 jiffies, g=-1063, q=1660 ncpus=4)
...



Possible fixes
--------------
I'm not sure what the right fix is, so I'd appreciate guidance:

1. Use cpufreq_cpu_get_raw()/cpufreq_generic_get() in get_callback(). This avoids the lock, but it does not take a reference on the policy. And I'm not sure it is safe for the other ->get() call paths in the future that don't hold cpufreq_driver_lock.
2. Change the Rust ->get() so it does not look up the policy at all, which matches the C
    callback signature.
3. Something else you'd prefer.

I'm happy to write and test a patch once the direction is clear.

[1] https://github.com/Rust-for-Linux/linux/issues/1260


Thanks,
spidermana

---


A setup script (reproduce.sh):
https://pastebin.com/meUMRC4P

rcpufreq_dt changes used for reproduction (01-enable-rcpufreq_dt-setpolicy.patch):
https://pastebin.com/pJP0fvYJ

PoC module (rust_poc_race.rs):
https://pastebin.com/hWC00xFq

(Please run `TIMEOUT=300 ./reproduce.sh bug` with the files below placed in the Linux root directory)
