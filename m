Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202071;
	b=0WTNAqsIxXaXpTHD8JB7jk7BHBCsNVNxbneSVpedF7h+1XnG64SGpfNCV29NAEOKK6iy
	 y4hwwCzs8oJJbt30wU9RH5Va45Dfn8QUI+BzJK1eAhT2CgCvnbbyEBxgy9fxQhLQFPqGG
	 LSYXDK+9pNEDlso64oUMxsY760X1pBKsYdcnUZnBhGC5yrgn/+rCmLiWe9qVvUrIhV9O8
	 5WC5YaUCYr/2r6dp1rPDm5Fr2L2qZOLhCBDkZXOVRJkP1OIZv+A7MH9sQlLJMdUnE7rM5
	 bEeklJCGhMGV5HQ/incPRA/i0xkHwEaZRux1ecyjJvdBVU8RyZJZrOGxzEN6NM0F32Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ztnBZ/y073keijktolDnl6HN8rxybUkDPYrPJDmsxCw=;
	b=ksfhQ+Z+RFqsfxT/tMV/KLk+D3iAURrtm5UPg7/WmPLO1+ejwuyNypPzPTjjkVEfmG05
	 oqQ5s0TDrwEocD0Vil0quDLy/BggMuCnhXh5FYUXEyGM9/3KUsO+QIJfiNVKkNMaerqck
	 uNV5HsOmRnnDaHH0qwkH0wO6kpDswY+9IYToa5frKaQGvHLnk7qHVMlaKk2Yi+rU3hTu5
	 S4N+Maf4RvTVmC1EKJL8Od4+64avzcuA6ZkXED4udt3DKpxvWbC/rfe98BBk/JAR+Boxd
	 YHpdnU583O6EyMWkTcIylv63KMM1q+MHhnRMc2Gozm8/znx51cI6hKJ1ojafp1CzbsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="o8/1uZ0C";
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE8F60A2619
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 19:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FE8F60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o8/1uZ0C
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4a68190a2a7so1118530f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 11:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202066; x=1795806866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ztnBZ/y073keijktolDnl6HN8rxybUkDPYrPJDmsxCw=;
        b=o8/1uZ0C8I/bNCYxZD4AJssEj06xELWes2dRnFoo9+U7Rruyq8GCMXcL9QV7mac7iD
         b9lFOVTqTodzZyCKOIE+2k+59ogfxXx4i+IVSM9AaU2vF+FTnE5Yc6zZU06/GA/PYsm2
         8kiBRDmF/L5hHlfOuz9flUU9dJE62f2xYHb+X0R9BR9H2QeT320XqpScqIx1ZqSo2dAc
         wSNO88QY7CmAgBWEWFp9j9ePy6NvBUVWLT9+ASrD296XiqRIqm3XQSH5IRrlRAJBmAai
         SXoMjaw8MtOb97rFJSdYEe3GTORhrxJGVRHhRgJ53fgi6+XCochp0S4Z0kxXKeN8QCLF
         FELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202066; x=1795806866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ztnBZ/y073keijktolDnl6HN8rxybUkDPYrPJDmsxCw=;
        b=Un9gmxoOAfvuaz2hbobwhlN/LgVxamo5CormXS0HaD1ynRex6BFHYJslRqhozgHHXg
         LatGkj70xjOgsMjLm+5OG6sMvjXd44qSlWFTyzS4kDlI8IKHaIOqVOuW+eR0hzJrRzu5
         EHhdigPSpl8YyuKc4341VywLnBVoQmGeeuKvAI04Rohtqhqn+LZ9sJIk1S1tPoNALXiw
         RYibJUlClkkLoxlYUsMZkcx/f7Zw2FBqakCgGdiuEfxS16lLpo8fRA8JnF2wMGSD+sZA
         FV0gMKLREPDnWWcgCdDF1aoTAZ55RklkPqEKPdWBLt3IwHvZSJx5pV7Qscx2ZRAN81Pm
         eR0A==
X-Forwarded-Encrypted: i=1; AL+hErFDsrgVqAL/PqaHA/nYkOkvBvuUU+nJlYAQ+3maeswNAZ1Ej/L45Lhsa/Svs78brmS9N0wk+mrTyA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/+j/yzBFjXyiUprNgNtNvARfGq/hwGOa5/O8KVdJwqjMEwKQLd
	b1QWVxSWVYNyFZ9soDLN5GqskenVLLEov3t22ssLNb3lw/CfKZOwbx4t
X-Gm-Gg: AYBFou1wouoxEe5ee+TCJ/31LE6r8M75HGNhiAu4uNCeV05KH7dzBIPTlMXwOZHGFJX
	2JPHkjwwS6HafrlxXqI7Lugk+/N5hhluu4T1obSxqBewJo1FXYGhbJjxnbh02tvMihthAGo/JCE
	wjm6gbngYzIRcgq1mnjHWYrV0UHtihNGy+/rehtOpBDaKa+McrzbtdiH/JM7C17sYGw6Ldp5ToC
	YCBPt+BbtcoSoCm2SydLt1G8x6iiG167rX7AheF9VkMOLZwzCWlLhz9u4vtjc1ns6AClPBmIOn8
	FonCLgs5wqmMPsU0dNNU+R7fgMNJhouNeJRJU8IM547l9+gD/FwLObj+2hrtCRvOoR+B9bJtEiK
	4uiRGROxKZQABAliPz/rw4MjKdTWoidmZwaZCt4gTzo6blpUYLCni3L1WsHExfj5kRmtJPNZI2+
	NrmmvG1KoFNDTLm0zr02F2ic6gyH5FGx9lh2XR4EL+j7Qgz5Ygxqlq8U1LeKCiRXQ6IXo7y1C2g
	Jb6HfN2YOhda4q70DrJYWMW7NVQ56P6Rpucm3b12UGIWh0gQUjJ6FtZE4J9+cg/9VLtoy1Jecux
	SfW+ZmGw9FUmMUxTm33UDWXAntepAd4Ex3JuyT4de32M0MtT2MGlXEFj2qLetV8LFcFKPkfeWH8
	OUx6KQTDtQ4YoXqil3e2kjEGVqIQVcz01ZOOma8EGuQhEJA==
X-Received: by 2002:a05:600c:1c0f:b0:4a1:f625:2108 with SMTP id 5b1f17b1804b1-4bb8881d4a3mr99065795e9.33.1795202065338;
        Fri, 20 Nov 2026 11:14:25 -0800 (PST)
Received: from archlinux.fritz.box ([178.197.200.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm11325525e9.2.2026.11.20.11.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:14:24 -0800 (PST)
From: Tobias Predel <tobias.predel@gmail.com>
To: linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>
Subject: [BUG] HP Dragonfly G4: AML deadlock (ECMX vs. Serialized GBAP) between EC _Q08/_Q18 and int3400_notify() -> ODVP
Date: Fri, 20 Nov 2026 20:14:23 +0100
Message-ID: <20261120191423.10876-1-tobias.predel@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On an HP Dragonfly 13.5 G4 (Raptor Lake-U) running 7.2.15-arch1-1, the
kernel hit a deadlock in AML execution after about an hour of uptime. One EC
query worker and one int3400 notify worker each block on an ACPI mutex the
other one holds. From then on, all later EC events, battery notifications,
upowerd and thermald (reading int340x zone temperatures) hang in D state.

About 55 minutes later, i915 lost forcewake on the media engines
(vdbox0/vdbox2/vebox0), failed both the GuC and the full-chip reset, and
declared the GPU wedged, which froze the display. I can't tell whether the
GPU failure is a consequence of the stuck ACPI/DPTF path or a separate
problem. I'm mentioning it because it is the only other anomaly in that boot.

It has happened once in the last ~40 boots. I have no reproducer.

Hardware/firmware
-----------------
  Machine: HP Dragonfly 13.5 inch G4 Notebook PC (board 8B63)
  BIOS:    V90 Ver. 01.13.01, 07/08/2026 (latest published by HP)
  Kernel:  7.2.15-arch1-1 (Arch Linux distro kernel)
  Taint:   OE (out-of-tree vboxdrv, evdi, v4l2loopback loaded; not
           involved in the traces below as far as I can tell)

The deadlock
------------
hung_task fired at 3810 s (so the deadlock started at ~3688 s). The two tasks at the centre of it:

kworker/11:1 (kacpi_notify) is in int3400_notify() -> evaluate_odvp() and
waits to enter a (serialized) control method:

  INFO: task kworker/11:1:127 blocked for more than 122 seconds.
  Workqueue: kacpi_notify acpi_os_execute_deferred
   down_timeout+0x67/0x70
   acpi_os_wait_semaphore+0x76/0x1d0
   acpi_ex_system_wait_mutex+0xb6/0x110
   acpi_ds_begin_method_execution+0xb3/0x420
   acpi_ds_call_control_method+0xae/0x490
   acpi_ps_parse_aml+0x3f2/0x610
   acpi_ps_execute_method+0x185/0x430
   acpi_ns_evaluate+0x196/0x5d0
   acpi_evaluate_object+0x1f4/0x470
   evaluate_odvp.isra.0+0x4c/0x240 [int3400_thermal]
   int3400_notify+0x192/0x1b0 [int3400_thermal]
   acpi_ev_notify_dispatch+0x4e/0x70
   acpi_os_execute_deferred+0x1a/0x30
  INFO: task kworker/11:1:127 blocked on a semaphore likely last held by task kworker/9:2:12040

kworker/9:2 (kec_query) runs an EC query method and waits in Acquire()
on an AML Mutex object:

  INFO: task kworker/9:2:12040 blocked for more than 122 seconds.
  Workqueue: kec_query acpi_ec_event_processor
   down_timeout+0x67/0x70
   acpi_os_wait_semaphore+0x76/0x1d0
   acpi_ex_system_wait_mutex+0xb6/0x110
   acpi_ex_acquire_mutex_object+0x61/0x150
   acpi_ex_acquire_mutex+0x8a/0x2a0
   acpi_ex_opcode_2A_0T_1R+0x163/0x1e0
   acpi_ds_exec_end_op+0x204/0x890
   acpi_ps_parse_loop+0x13d/0xb80
   acpi_ps_parse_aml+0x419/0x610
   acpi_ps_execute_method+0x185/0x430
   acpi_ns_evaluate+0x196/0x5d0
   acpi_evaluate_object+0x1f4/0x470
   acpi_ec_event_processor+0xe5/0x130
  INFO: task kworker/9:2:12040 blocked on a semaphore likely last held by task kworker/11:1:127

The AML explains it. It is an ABBA lock-order inversion in the firmware
between the EC mutex ECMX and the implicit mutex of the Serialized method
\_SB.PC00.LPCB.EC0.GBAP (both at SyncLevel 0, so ACPICA's mutex-order check
doesn't fire).

\_SB.IETM.ODVP (SSDT "DptfTb"/"DptfTabl") takes ECMX, then calls GBAP:

  Method (ODVP, 0, Serialized)
  {
      ...
      Acquire (\_SB.PC00.LPCB.EC0.ECMX, 0xFFFF)
      Local0 = \_SB.PC00.LPCB.EC0.GBAP ()        <- kworker/11:1 waits here
      ...
      Release (\_SB.PC00.LPCB.EC0.ECMX)
      ...
  }

GBAP (DSDT "HPQOEM"/"8B63") is Serialized and takes ECMX itself:

  Method (GBAP, 0, Serialized)
  {
      Acquire (BTMX, 0xFFFF)
      If ((GACP & 0x02))
      {
          GACP &= 0x05
          Release (BTMX)
          Acquire (ECMX, 0xFFFF)                 <- kworker/9:2 waits here
          If (ECRG) { NBAP = BATP }
          Release (ECMX)
      }
      Else { Release (BTMX) }
      Return (NBAP)
  }

The EC query handlers _Q08 and _Q18 call GBAP() without holding ECMX
(GBAP-sync -> ECMX), while ODVP takes ECMX -> GBAP-sync. The battery/AC
query _Q08 also ends with

      ^^^^IETM.ODVP ()
      Notify (IETM, 0x88)

so one battery/AC event queues the 0x88 notify, int3400_notify() runs
evaluate_odvp() -> ODVP on kacpi_notify, and a second battery EC query
(_Q08/_Q18) running in parallel on kec_query is inside GBAP. Result: the
deadlock above.

_Q09 has the same order as ODVP (Acquire(ECMX); GBAP()). So the same
deadlock should also be possible between two EC queries alone (_Q09 vs.
_Q08/_Q18), because ec_max_queries defaults to 16 and the queries run
concurrently.

This is clearly a firmware bug, and I have reported it to HP as well
(their first answer was that Linux is not a supported OS; I've asked them
to escalate it to their BIOS team). I'm raising it here because Linux turns it into a hard hang, whereas I'd guess
the firmware was only ever tested with EC queries and the DPTF notify
effectively serialized.

Also blocked behind kworker/11:1 (all with the same wait_mutex stacks):
  - kworker/9:1   kacpi_notify  acpi_battery_notify -> acpi_bus_get_status
  - kworker/4:2, 6:2, 10:0, 2:0, 8:1  kec_query  acpi_ec_event_processor
  - thermald      int340x_thermal_get_zone_temp (sysfs temp read)
  - upowerd       acpi_battery_get_state

The machine never recovered from this. Full hung-task output is below.

The later i915 failure (same boot)
-----------------------------------
  [7042.97] i915 0000:00:02.0: [drm] *ERROR* GT0: GUC: Engine reset failed on 0:0 (rcs0) because 0x00000000
  [7042.98] i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
           (repeats every ~0.6 s, then vdbox2 and vebox0)
  [7053.86] i915 0000:00:02.0: [drm] GPU HANG: ecode 12:1:87d7bffe, in chrome [4953]
  [7055.66] GT0: Resetting chip for GuC failed to reset engine mask=0x1
  [7055.66] *ERROR* GT0: Failed to reset GuC, ret = -110
  [7056.07] *ERROR* GT0: vcs0/vcs1/vecs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
  [7056.17] *ERROR* GT0: Failed to reset chip
  [7056.59] i915 0000:00:02.0: [drm] device wedged, needs recovery

The GPU error state was lost when I rebooted. If you think the two are
unrelated, I'll file the i915 part separately on the drm/i915 GitLab tracker.

Questions
---------
1. Would you accept a quirk or a change for this, e.g. running EC queries
   and the int3400 ODVP re-evaluation in a serialized way on this machine?
   Or is the answer "firmware bug, HP must fix it"?
2. As a local workaround I've been booting with acpi.ec_max_queries=1
   since 2026-11-14 (no recurrence so far, but it was rare anyway). As far
   as I can see that only removes the EC-only variant (_Q09 vs. _Q08/_Q18),
   not the int3400_notify one. Is there a better knob?
3. Is there anything you'd like me to enable (ACPI debug layers,
   lockdep, etc.) in case it happens again?

The full acpidump is too large for the list (~400 KB compressed); I can
send it on request. The full hung_task output and the i915 messages
around the wedge are included inline below.

Thanks,
Tobias Predel

---8<--- full hung_task output (boot of 2026-11-12, kernel 7.2.15) ---8<---

[ 3810.377193]  INFO: task kworker/9:1:125 blocked for more than 122 seconds.
[ 3810.390421]        Tainted: G           OE       7.2.15-arch1-1 #1
[ 3810.390547]  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3810.390620]  task:kworker/9:1     state:D stack:0     pid:125   tgid:125   ppid:2      task_flags:0x4208060 flags:0x00080000
[ 3810.390733]  Workqueue: kacpi_notify acpi_os_execute_deferred
[ 3810.390831]  Call Trace:
[ 3810.390888]   <TASK>
[ 3810.390973]   __schedule+0x420/0x1770
[ 3810.391050]   ? acpi_ns_search_and_enter+0x40b/0x570
[ 3810.391104]   schedule+0x27/0xa0
[ 3810.391181]   schedule_timeout+0xdc/0x120
[ 3810.391257]   __down_common+0x101/0x330
[ 3810.391321]   ? up+0x6c/0x110
[ 3810.391386]   down_timeout+0x67/0x70
[ 3810.391468]   acpi_os_wait_semaphore+0x76/0x1d0
[ 3810.391533]   acpi_ex_system_wait_mutex+0xb6/0x110
[ 3810.391595]   acpi_ds_begin_method_execution+0xb3/0x420
[ 3810.391650]   acpi_ds_call_control_method+0xae/0x490
[ 3810.391705]   ? acpi_ds_delete_walk_state+0xe8/0x160
[ 3810.391778]   acpi_ps_parse_aml+0x3f2/0x610
[ 3810.391833]   acpi_ps_execute_method+0x185/0x430
[ 3810.391887]   acpi_ns_evaluate+0x196/0x5d0
[ 3810.391948]   acpi_evaluate_object+0x1f4/0x470
[ 3810.392040]   acpi_evaluate_integer+0x6e/0x120
[ 3810.392113]   acpi_bus_get_status+0x87/0x150
[ 3810.392187]   acpi_battery_update+0x17/0x3b0
[ 3810.392251]   acpi_battery_notify+0x47/0xe0
[ 3810.392306]   acpi_ev_notify_dispatch+0x4e/0x70
[ 3810.392361]   acpi_os_execute_deferred+0x1a/0x30
[ 3810.392416]   process_one_work+0x19f/0x370
[ 3810.392472]   worker_thread+0x1b1/0x310
[ 3810.392528]   ? __pfx_worker_thread+0x10/0x10
[ 3810.392586]   kthread+0xe4/0x120
[ 3810.392642]   ? __pfx_kthread+0x10/0x10
[ 3810.392708]   ret_from_fork+0x2a7/0x330
[ 3810.392783]   ? __pfx_kthread+0x10/0x10
[ 3810.392841]   ret_from_fork_asm+0x1a/0x30
[ 3810.392890]   </TASK>
[ 3810.392948]  INFO: task kworker/9:1:125 blocked on a semaphore likely last held by task kworker/9:2:12040
[ 3810.393034]  INFO: task kworker/11:1:127 blocked for more than 122 seconds.
[ 3810.393128]        Tainted: G           OE       7.2.15-arch1-1 #1
[ 3810.393178]  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3810.393219]  task:kworker/11:1    state:D stack:0     pid:127   tgid:127   ppid:2      task_flags:0x4208060 flags:0x00080000
[ 3810.393278]  Workqueue: kacpi_notify acpi_os_execute_deferred
[ 3810.393335]  Call Trace:
[ 3810.393375]   <TASK>
[ 3810.393414]   __schedule+0x420/0x1770
[ 3810.393471]   ? __down_common+0x10c/0x330
[ 3810.393527]   ? acpi_ns_get_type+0x54/0xa0
[ 3810.393566]   schedule+0x27/0xa0
[ 3810.393597]   schedule_timeout+0xdc/0x120
[ 3810.393661]   __down_common+0x101/0x330
[ 3810.393708]   down_timeout+0x67/0x70
[ 3810.393763]   acpi_os_wait_semaphore+0x76/0x1d0
[ 3810.393821]   acpi_ex_system_wait_mutex+0xb6/0x110
[ 3810.393860]   acpi_ds_begin_method_execution+0xb3/0x420
[ 3810.393912]   acpi_ds_call_control_method+0xae/0x490
[ 3810.393959]   ? acpi_ds_delete_walk_state+0xe8/0x160
[ 3810.394032]   acpi_ps_parse_aml+0x3f2/0x610
[ 3810.394112]   acpi_ps_execute_method+0x185/0x430
[ 3810.394146]   acpi_ns_evaluate+0x196/0x5d0
[ 3810.394203]   acpi_evaluate_object+0x1f4/0x470
[ 3810.394252]   evaluate_odvp.isra.0+0x4c/0x240 [int3400_thermal 9d76f249d4d07cccc882f6be5eff3af893e10cbf]
[ 3810.394300]   ? acpi_os_signal_semaphore+0x7e/0xa0
[ 3810.394355]   int3400_notify+0x192/0x1b0 [int3400_thermal 9d76f249d4d07cccc882f6be5eff3af893e10cbf]
[ 3810.394396]   acpi_ev_notify_dispatch+0x4e/0x70
[ 3810.394436]   acpi_os_execute_deferred+0x1a/0x30
[ 3810.394486]   process_one_work+0x19f/0x370
[ 3810.394525]   worker_thread+0x1b1/0x310
[ 3810.394565]   ? __pfx_worker_thread+0x10/0x10
[ 3810.394605]   kthread+0xe4/0x120
[ 3810.394661]   ? __pfx_kthread+0x10/0x10
[ 3810.394701]   ret_from_fork+0x2a7/0x330
[ 3810.394759]   ? __pfx_kthread+0x10/0x10
[ 3810.394791]   ret_from_fork_asm+0x1a/0x30
[ 3810.394840]   </TASK>
[ 3810.394873]  INFO: task kworker/11:1:127 blocked on a semaphore likely last held by task kworker/9:2:12040
[ 3810.394916]  INFO: task kworker/4:2:134 blocked for more than 122 seconds.
[ 3810.394964]        Tainted: G           OE       7.2.15-arch1-1 #1
[ 3810.395021]  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3810.395065]  task:kworker/4:2     state:D stack:0     pid:134   tgid:134   ppid:2      task_flags:0x4208060 flags:0x00080000
[ 3810.395111]  Workqueue: kec_query acpi_ec_event_processor
[ 3810.395168]  Call Trace:
[ 3810.395197]   <TASK>
[ 3810.395232]   __schedule+0x420/0x1770
[ 3810.395275]   ? acpi_ns_get_type+0x54/0xa0
[ 3810.395310]   ? acpi_ns_search_one_scope+0xbb/0x250
[ 3810.395353]   schedule+0x27/0xa0
[ 3810.395390]   schedule_timeout+0xdc/0x120
[ 3810.395425]   __down_common+0x101/0x330
[ 3810.395460]   ? up+0x6c/0x110
[ 3810.395495]   down_timeout+0x67/0x70
[ 3810.395530]   acpi_os_wait_semaphore+0x76/0x1d0
[ 3810.395572]   acpi_ex_system_wait_mutex+0xb6/0x110
[ 3810.395607]   acpi_ex_acquire_mutex_object+0x61/0x150
[ 3810.395656]   acpi_ex_acquire_mutex+0x8a/0x2a0
[ 3810.395698]   acpi_ex_opcode_2A_0T_1R+0x163/0x1e0
[ 3810.395748]   acpi_ds_exec_end_op+0x204/0x890
[ 3810.395791]   acpi_ps_parse_loop+0x13d/0xb80
[ 3810.395832]   acpi_ps_parse_aml+0x419/0x610
[ 3810.395882]   acpi_ps_execute_method+0x185/0x430
[ 3810.395917]   acpi_ns_evaluate+0x196/0x5d0
[ 3810.395957]   acpi_evaluate_object+0x1f4/0x470
[ 3810.396007]   acpi_ec_event_processor+0xe5/0x130
[ 3810.396066]   process_one_work+0x19f/0x370
[ 3810.396092]   worker_thread+0x1b1/0x310
[ 3810.396130]   ? __pfx_worker_thread+0x10/0x10
[ 3810.396155]   kthread+0xe4/0x120
[ 3810.396181]   ? __pfx_kthread+0x10/0x10
[ 3810.396206]   ret_from_fork+0x2a7/0x330
[ 3810.396233]   ? __pfx_kthread+0x10/0x10
[ 3810.396259]   ret_from_fork_asm+0x1a/0x30
[ 3810.396285]   </TASK>
[ 3810.396315]  INFO: task kworker/4:2:134 blocked on a semaphore likely last held by task kworker/11:1:127
[ 3810.396366]  INFO: task kworker/6:2:250 blocked for more than 122 seconds.
[ 3810.396399]        Tainted: G           OE       7.2.15-arch1-1 #1
[ 3810.396425]  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3810.396458]  task:kworker/6:2     state:D stack:0     pid:250   tgid:250   ppid:2      task_flags:0x4208060 flags:0x00080000
[ 3810.396504]  Workqueue: kec_query acpi_ec_event_processor
[ 3810.396544]  Call Trace:
[ 3810.396570]   <TASK>
[ 3810.396609]   __schedule+0x420/0x1770
[ 3810.396642]   ? acpi_ns_get_type+0x54/0xa0
[ 3810.396676]   ? acpi_ns_search_one_scope+0xbb/0x250
[ 3810.396709]   schedule+0x27/0xa0
[ 3810.396746]   schedule_timeout+0xdc/0x120
[ 3810.396777]   __down_common+0x101/0x330
[ 3810.396809]   ? up+0x6c/0x110
[ 3810.396841]   down_timeout+0x67/0x70
[ 3810.396872]   acpi_os_wait_semaphore+0x76/0x1d0
[ 3810.396910]   acpi_ex_system_wait_mutex+0xb6/0x110
[ 3810.396936]   acpi_ex_acquire_mutex_object+0x61/0x150
[ 3810.396957]   acpi_ex_acquire_mutex+0x8a/0x2a0
[ 3810.396992]   acpi_ex_opcode_2A_0T_1R+0x163/0x1e0
[ 3810.397056]   acpi_ds_exec_end_op+0x204/0x890
[ 3810.397084]   acpi_ps_parse_loop+0x13d/0xb80
[ 3810.397115]   acpi_ps_parse_aml+0x419/0x610
[ 3810.397148]   acpi_ps_execute_method+0x185/0x430
[ 3810.397181]   acpi_ns_evaluate+0x196/0x5d0
[ 3810.397208]   acpi_evaluate_object+0x1f4/0x470
[ 3810.397245]   acpi_ec_event_processor+0xe5/0x130
[ 3810.397265]   process_one_work+0x19f/0x370
[ 3810.397290]   worker_thread+0x1b1/0x310
[ 3810.397316]   ? __pfx_worker_thread+0x10/0x10
[ 3810.397355]   kthread+0xe4/0x120
[ 3810.397374]   ? __pfx_kthread+0x10/0x10
[ 3810.397411]   ret_from_fork+0x2a7/0x330
[ 3810.397444]   ? __pfx_kthread+0x10/0x10
[ 3810.397474]   ret_from_fork_asm+0x1a/0x30
[ 3810.397510]   </TASK>
[ 3810.397549]  INFO: task kworker/6:2:250 blocked on a semaphore likely last held by task kworker/11:1:127
[ 3810.397589]  INFO: task thermald:1179 blocked for more than 122 seconds.
[ 3810.397626]        Tainted: G           OE       7.2.15-arch1-1 #1
[ 3810.397653]  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3810.397685]  task:thermald        state:D stack:0     pid:1179  tgid:996   ppid:1      task_flags:0x400040 flags:0x00080000
[ 3810.397718]  Call Trace:
[ 3810.397753]   <TASK>
[ 3810.397791]   __schedule+0x420/0x1770
[ 3810.397823]   ? acpi_ns_get_type+0x54/0xa0
[ 3810.397860]   ? acpi_ns_search_one_scope+0xbb/0x250
[ 3810.397891]   ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 3810.397928]   schedule+0x27/0xa0
[ 3810.397967]   schedule_timeout+0xdc/0x120
[ 3810.397994]   __down_common+0x101/0x330
[ 3810.398033]   down_timeout+0x67/0x70
[ 3810.398073]   acpi_os_wait_semaphore+0x76/0x1d0
[ 3810.398108]   acpi_ex_system_wait_mutex+0xb6/0x110
[ 3810.398151]   acpi_ex_acquire_mutex_object+0x61/0x150
[ 3810.398185]   acpi_ex_acquire_mutex+0x8a/0x2a0
[ 3810.398204]   acpi_ex_opcode_2A_0T_1R+0x163/0x1e0
[ 3810.398236]   acpi_ds_exec_end_op+0x204/0x890
[ 3810.398278]   acpi_ps_parse_loop+0x13d/0xb80
[ 3810.398304]   acpi_ps_parse_aml+0x419/0x610
[ 3810.398341]   acpi_ps_execute_method+0x185/0x430
[ 3810.398371]   acpi_ns_evaluate+0x196/0x5d0
[ 3810.398402]   acpi_evaluate_object+0x1f4/0x470
[ 3810.398433]   acpi_evaluate_integer+0x6e/0x120
[ 3810.398464]   int340x_thermal_get_zone_temp+0x47/0xb0 [int340x_thermal_zone fd2d239b36510ef78061da31066e62a84d12206d]
[ 3810.398501]   __thermal_zone_get_temp+0x1d/0x70
[ 3810.398525]   thermal_zone_get_temp+0x51/0xa0
[ 3810.398559]   ? __memcg_slab_free_hook+0x153/0x1b0
[ 3810.398593]   temp_show+0x34/0x80
[ 3810.398621]   dev_attr_show+0x1f/0x50
[ 3810.398656]   sysfs_kf_seq_show+0xa8/0x110
[ 3810.398690]   seq_read_iter+0x132/0x4b0
[ 3810.398725]   vfs_read+0x34d/0x490
[ 3810.398759]   __x64_sys_pread64+0xaa/0x100
[ 3810.398788]   do_syscall_64+0xaa/0x660
[ 3810.398821]   ? switch_fpu_return+0x5e/0xf0
[ 3810.398864]   ? do_syscall_64+0x252/0x660
[ 3810.398888]   ? do_syscall_64+0xaa/0x660
[ 3810.398921]   ? do_syscall_64+0xaa/0x660
[ 3810.398952]   ? do_syscall_64+0x5f/0x660
[ 3810.398991]   entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 3810.399015]  RIP: 0033:0x7f33f14a08f2
[ 3810.399047]  RSP: 002b:00007f33ec9f9ad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000011
[ 3810.399077]  RAX: ffffffffffffffda RBX: 000055af18a4f8a0 RCX: 00007f33f14a08f2
[ 3810.399106]  RDX: 000000000000000f RSI: 00007f33ec9f9b30 RDI: 00000000000000a0
[ 3810.399145]  RBP: 00007f33ec9f9b00 R08: 0000000000000000 R09: 0000000000000000
[ 3810.399179]  R10: 0000000000000000 R11: 0000000000000246 R12: 000055aedf60ab00
[ 3810.399212]  R13: 000055af18a4f8a0 R14: 00007f33ec9f9bbc R15: 0000000000000000
[ 3810.399252]   </TASK>
[ 3810.399270]  INFO: task thermald:1179 blocked on a semaphore likely last held by task kworker/11:1:127
[ 3810.399311]  INFO: task upowerd:1167 blocked for more than 122 seconds.
[ 3810.399351]        Tainted: G           OE       7.2.15-arch1-1 #1
[ 3810.399375]  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3810.399399]  task:upowerd         state:D stack:0     pid:1167  tgid:1167  ppid:1      task_flags:0x400100 flags:0x00080000
[ 3810.399428]  Call Trace:
[ 3810.399456]   <TASK>
[ 3810.399490]   __schedule+0x420/0x1770
[ 3810.399518]   ? kmem_cache_alloc_noprof+0x310/0x460
[ 3810.399556]   ? acpi_ns_search_and_enter+0x40b/0x570
[ 3810.399578]   ? acpi_ut_allocate_object_desc_dbg+0x5a/0x110
[ 3810.399609]   schedule+0x27/0xa0
[ 3810.399631]   schedule_timeout+0xdc/0x120
[ 3810.399653]   __down_common+0x101/0x330
[ 3810.399673]   down_timeout+0x67/0x70
[ 3810.399698]   acpi_os_wait_semaphore+0x76/0x1d0
[ 3810.399720]   acpi_ex_system_wait_mutex+0xb6/0x110
[ 3810.399751]   acpi_ds_begin_method_execution+0xb3/0x420
[ 3810.399771]   acpi_ds_call_control_method+0xae/0x490
[ 3810.399797]   ? acpi_ds_delete_walk_state+0xe8/0x160
[ 3810.399820]   acpi_ps_parse_aml+0x3f2/0x610
[ 3810.399845]   acpi_ps_execute_method+0x185/0x430
[ 3810.399867]   acpi_ns_evaluate+0x196/0x5d0
[ 3810.399888]   acpi_evaluate_object+0x1f4/0x470
[ 3810.399915]   acpi_battery_get_state+0xa3/0x240
[ 3810.399941]   acpi_battery_get_property+0x7e/0x480
[ 3810.399973]   power_supply_format_property+0x102/0x3c0
[ 3810.400008]   dev_attr_show+0x1f/0x50
[ 3810.400052]   sysfs_kf_seq_show+0xa8/0x110
[ 3810.400084]   seq_read_iter+0x132/0x4b0
[ 3810.400110]   vfs_read+0x34d/0x490
[ 3810.400136]   ksys_read+0x7b/0x110
[ 3810.400183]   do_syscall_64+0xaa/0x660
[ 3810.400209]   ? do_getname+0x62/0x1d0
[ 3810.400236]   ? do_sys_openat2+0x9c/0xe0
[ 3810.400267]   ? __x64_sys_openat+0x61/0xa0
[ 3810.400287]   ? do_syscall_64+0xaa/0x660
[ 3810.400306]   ? __x64_sys_close+0x47/0xa0
[ 3810.400348]   ? __seccomp_filter+0x86/0x6e0
[ 3810.400368]   ? __x64_sys_close+0x47/0xa0
[ 3810.400397]   ? do_syscall_64+0xaa/0x660
[ 3810.400420]   ? do_syscall_64+0x5f/0x660
[ 3810.400436]   entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 3810.400456]  RIP: 0033:0x7f63678a08f2
[ 3810.400494]  RSP: 002b:00007ffda0713688 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[ 3810.400533]  RAX: ffffffffffffffda RBX: 0000562c6ad40751 RCX: 00007f63678a08f2
[ 3810.400557]  RDX: 0000000000001008 RSI: 0000562c79d1e890 RDI: 000000000000000c
[ 3810.400586]  RBP: 00007ffda07136b0 R08: 0000000000000000 R09: 0000000000000000
[ 3810.400610]  R10: 0000000000000000 R11: 0000000000000246 R12: 0000562c79b5bcb0
[ 3810.400638]  R13: 0000562c79d1e890 R14: 000000000000000b R15: 0000000000000000
[ 3810.400658]   </TASK>
[ 3810.400673]  INFO: task upowerd:1167 blocked on a semaphore likely last held by task kworker/9:1:125
[ 3810.400700]  INFO: task kworker/10:0:11324 blocked for more than 122 seconds.
[ 3810.400717]        Tainted: G           OE       7.2.15-arch1-1 #1
[ 3810.400736]  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3810.400760]  task:kworker/10:0    state:D stack:0     pid:11324 tgid:11324 ppid:2      task_flags:0x4208060 flags:0x00080000
[ 3810.400785]  Workqueue: kec_query acpi_ec_event_processor
[ 3810.400811]  Call Trace:
[ 3810.400830]   <TASK>
[ 3810.400854]   __schedule+0x420/0x1770
[ 3810.400879]   ? acpi_ns_get_type+0x54/0xa0
[ 3810.400898]   ? acpi_ns_search_one_scope+0xbb/0x250
[ 3810.400923]   schedule+0x27/0xa0
[ 3810.400942]   schedule_timeout+0xdc/0x120
[ 3810.400965]   __down_common+0x101/0x330
[ 3810.400986]   ? up+0x6c/0x110
[ 3810.401012]   down_timeout+0x67/0x70
[ 3810.401042]   acpi_os_wait_semaphore+0x76/0x1d0
[ 3810.401065]   acpi_ex_system_wait_mutex+0xb6/0x110
[ 3810.401098]   acpi_ex_acquire_mutex_object+0x61/0x150
[ 3810.401124]   acpi_ex_acquire_mutex+0x8a/0x2a0
[ 3810.401143]   acpi_ex_opcode_2A_0T_1R+0x163/0x1e0
[ 3810.401164]   acpi_ds_exec_end_op+0x204/0x890
[ 3810.401183]   acpi_ps_parse_loop+0x13d/0xb80
[ 3810.401202]   acpi_ps_parse_aml+0x419/0x610
[ 3810.401232]   acpi_ps_execute_method+0x185/0x430
[ 3810.401250]   acpi_ns_evaluate+0x196/0x5d0
[ 3810.401276]   acpi_evaluate_object+0x1f4/0x470
[ 3810.401294]   acpi_ec_event_processor+0xe5/0x130
[ 3810.401311]   process_one_work+0x19f/0x370
[ 3810.401333]   worker_thread+0x1b1/0x310
[ 3810.401359]   ? __pfx_worker_thread+0x10/0x10
[ 3810.401372]   kthread+0xe4/0x120
[ 3810.401396]   ? __pfx_kthread+0x10/0x10
[ 3810.401413]   ret_from_fork+0x2a7/0x330
[ 3810.401432]   ? __pfx_kthread+0x10/0x10
[ 3810.401454]   ret_from_fork_asm+0x1a/0x30
[ 3810.401476]   </TASK>
[ 3810.401498]  INFO: task kworker/10:0:11324 blocked on a semaphore likely last held by task kworker/11:1:127
[ 3810.401526]  INFO: task kworker/9:2:12040 blocked for more than 122 seconds.
[ 3810.401550]        Tainted: G           OE       7.2.15-arch1-1 #1
[ 3810.401566]  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3810.401591]  task:kworker/9:2     state:D stack:0     pid:12040 tgid:12040 ppid:2      task_flags:0x4208060 flags:0x00080000
[ 3810.401612]  Workqueue: kec_query acpi_ec_event_processor
[ 3810.401630]  Call Trace:
[ 3810.401650]   <TASK>
[ 3810.401671]   __schedule+0x420/0x1770
[ 3810.401684]   ? acpi_ns_get_type+0x54/0xa0
[ 3810.401701]   ? sched_clock+0x10/0x30
[ 3810.401718]   ? __smp_call_single_queue+0xcf/0x150
[ 3810.401736]   schedule+0x27/0xa0
[ 3810.401754]   schedule_timeout+0xdc/0x120
[ 3810.401770]   __down_common+0x101/0x330
[ 3810.401786]   ? up+0x7c/0x110
[ 3810.401807]   down_timeout+0x67/0x70
[ 3810.401823]   acpi_os_wait_semaphore+0x76/0x1d0
[ 3810.401840]   acpi_ex_system_wait_mutex+0xb6/0x110
[ 3810.401857]   acpi_ex_acquire_mutex_object+0x61/0x150
[ 3810.401874]   acpi_ex_acquire_mutex+0x8a/0x2a0
[ 3810.401895]   acpi_ex_opcode_2A_0T_1R+0x163/0x1e0
[ 3810.401911]   acpi_ds_exec_end_op+0x204/0x890
[ 3810.401924]   acpi_ps_parse_loop+0x13d/0xb80
[ 3810.401936]   acpi_ps_parse_aml+0x419/0x610
[ 3810.401953]   acpi_ps_execute_method+0x185/0x430
[ 3810.401969]   acpi_ns_evaluate+0x196/0x5d0
[ 3810.402006]   acpi_evaluate_object+0x1f4/0x470
[ 3810.402027]   acpi_ec_event_processor+0xe5/0x130
[ 3810.402062]   process_one_work+0x19f/0x370
[ 3810.402079]   worker_thread+0x1b1/0x310
[ 3810.402096]   ? __pfx_worker_thread+0x10/0x10
[ 3810.402110]   kthread+0xe4/0x120
[ 3810.402127]   ? __pfx_kthread+0x10/0x10
[ 3810.402147]   ret_from_fork+0x2a7/0x330
[ 3810.402161]   ? __pfx_kthread+0x10/0x10
[ 3810.402174]   ret_from_fork_asm+0x1a/0x30
[ 3810.402198]   </TASK>
[ 3810.402218]  INFO: task kworker/9:2:12040 blocked on a semaphore likely last held by task kworker/11:1:127
[ 3810.402240]  INFO: task kworker/2:0:13176 blocked for more than 122 seconds.
[ 3810.402258]        Tainted: G           OE       7.2.15-arch1-1 #1
[ 3810.402278]  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3810.402295]  task:kworker/2:0     state:D stack:0     pid:13176 tgid:13176 ppid:2      task_flags:0x4208060 flags:0x00080000
[ 3810.402315]  Workqueue: kec_query acpi_ec_event_processor
[ 3810.402328]  Call Trace:
[ 3810.402351]   <TASK>
[ 3810.402367]   __schedule+0x420/0x1770
[ 3810.402379]   ? psi_task_change+0xf5/0x100
[ 3810.402398]   ? acpi_ns_get_type+0x54/0xa0
[ 3810.402410]   ? acpi_ns_search_one_scope+0xbb/0x250
[ 3810.402433]   schedule+0x27/0xa0
[ 3810.402452]   schedule_timeout+0xdc/0x120
[ 3810.402465]   __down_common+0x101/0x330
[ 3810.402480]   ? up+0x6c/0x110
[ 3810.402492]   down_timeout+0x67/0x70
[ 3810.402504]   acpi_os_wait_semaphore+0x76/0x1d0
[ 3810.402519]   acpi_ex_system_wait_mutex+0xb6/0x110
[ 3810.402531]   acpi_ex_acquire_mutex_object+0x61/0x150
[ 3810.402547]   acpi_ex_acquire_mutex+0x8a/0x2a0
[ 3810.402563]   acpi_ex_opcode_2A_0T_1R+0x163/0x1e0
[ 3810.402582]   acpi_ds_exec_end_op+0x204/0x890
[ 3810.402598]   acpi_ps_parse_loop+0x13d/0xb80
[ 3810.402611]   acpi_ps_parse_aml+0x419/0x610
[ 3810.402627]   acpi_ps_execute_method+0x185/0x430
[ 3810.402646]   acpi_ns_evaluate+0x196/0x5d0
[ 3810.402661]   acpi_evaluate_object+0x1f4/0x470
[ 3810.402677]   acpi_ec_event_processor+0xe5/0x130
[ 3810.402692]   process_one_work+0x19f/0x370
[ 3810.402707]   worker_thread+0x1b1/0x310
[ 3810.402723]   ? __pfx_worker_thread+0x10/0x10
[ 3810.402742]   kthread+0xe4/0x120
[ 3810.402757]   ? __pfx_kthread+0x10/0x10
[ 3810.402779]   ret_from_fork+0x2a7/0x330
[ 3810.402792]   ? __pfx_kthread+0x10/0x10
[ 3810.402807]   ret_from_fork_asm+0x1a/0x30
[ 3810.402822]   </TASK>
[ 3810.402834]  INFO: task kworker/2:0:13176 blocked on a semaphore likely last held by task kworker/11:1:127
[ 3810.402847]  INFO: task kworker/8:1:16836 blocked for more than 122 seconds.
[ 3810.402878]        Tainted: G           OE       7.2.15-arch1-1 #1
[ 3810.402898]  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3810.402910]  task:kworker/8:1     state:D stack:0     pid:16836 tgid:16836 ppid:2      task_flags:0x4208060 flags:0x00080000
[ 3810.402923]  Workqueue: kec_query acpi_ec_event_processor
[ 3810.402939]  Call Trace:
[ 3810.402961]   <TASK>
[ 3810.402980]   __schedule+0x420/0x1770
[ 3810.402992]   ? acpi_ns_get_type+0x54/0xa0
[ 3810.403027]   ? acpi_ns_search_one_scope+0xbb/0x250
[ 3810.403046]   schedule+0x27/0xa0
[ 3810.403062]   schedule_timeout+0xdc/0x120
[ 3810.403076]   __down_common+0x101/0x330
[ 3810.403098]   ? up+0x6c/0x110
[ 3810.403112]   down_timeout+0x67/0x70
[ 3810.403127]   acpi_os_wait_semaphore+0x76/0x1d0
[ 3810.403142]   acpi_ex_system_wait_mutex+0xb6/0x110
[ 3810.403157]   acpi_ex_acquire_mutex_object+0x61/0x150
[ 3810.403175]   acpi_ex_acquire_mutex+0x8a/0x2a0
[ 3810.403190]   acpi_ex_opcode_2A_0T_1R+0x163/0x1e0
[ 3810.403208]   acpi_ds_exec_end_op+0x204/0x890
[ 3810.403229]   acpi_ps_parse_loop+0x13d/0xb80
[ 3810.403247]   acpi_ps_parse_aml+0x419/0x610
[ 3810.403262]   acpi_ps_execute_method+0x185/0x430
[ 3810.403277]   acpi_ns_evaluate+0x196/0x5d0
[ 3810.403295]   acpi_evaluate_object+0x1f4/0x470
[ 3810.403309]   acpi_ec_event_processor+0xe5/0x130
[ 3810.403321]   process_one_work+0x19f/0x370
[ 3810.403335]   worker_thread+0x1b1/0x310
[ 3810.403351]   ? __pfx_worker_thread+0x10/0x10
[ 3810.403361]   kthread+0xe4/0x120
[ 3810.403375]   ? __pfx_kthread+0x10/0x10
[ 3810.403386]   ret_from_fork+0x2a7/0x330
[ 3810.403399]   ? __pfx_kthread+0x10/0x10
[ 3810.403410]   ret_from_fork_asm+0x1a/0x30
[ 3810.403427]   </TASK>
[ 3810.403443]  INFO: task kworker/8:1:16836 blocked on a semaphore likely last held by task kworker/11:1:127
[ 3810.403467]  Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

---8<--- i915 messages 7040-7057 s ---8<---

[ 7042.967558]  i915 0000:00:02.0: [drm] *ERROR* GT0: GUC: Engine reset failed on 0:0 (rcs0) because 0x00000000
[ 7042.979287]  i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
[ 7042.979535]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7043.568407]  Fence expiration time out i915-0000:00:02.0:chrome[4953]:a390e!
[ 7043.568580]  i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
[ 7043.568776]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7044.244236]  i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
[ 7044.244501]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7044.845013]  i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
[ 7044.845287]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7045.445950]  i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
[ 7045.446253]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7046.046680]  i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
[ 7046.046924]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7046.647664]  i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
[ 7046.648045]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7047.248394]  i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
[ 7047.248790]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7047.849310]  i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
[ 7047.849714]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7048.450061]  i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
[ 7048.450443]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7049.050739]  i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
[ 7049.051175]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7049.651503]  i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
[ 7049.651824]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7050.252365]  i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
[ 7050.252731]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7050.853910]  i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
[ 7050.854422]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7051.454706]  i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
[ 7051.455104]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7052.055683]  i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
[ 7052.056061]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7052.656236]  i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
[ 7052.656653]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7053.857805]  i915 0000:00:02.0: [drm] *ERROR* vdbox2: timed out waiting for forcewake ack request.
[ 7053.858687]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7053.858827]  i915 0000:00:02.0: [drm] *ERROR* vebox0: timed out waiting for forcewake ack request.
[ 7053.858990]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7053.859305]  i915 0000:00:02.0: [drm] GPU HANG: ecode 12:1:87d7bffe, in chrome [4953]
[ 7053.859549]  i915 0000:00:02.0: [drm] GPU error state saved to /sys/class/drm/card1/error
[ 7055.661475]  i915 0000:00:02.0: [drm] GT0: Resetting chip for GuC failed to reset engine mask=0x1
[ 7055.661779]  i915 0000:00:02.0: [drm] *ERROR* vdbox0: timed out waiting for forcewake ack request.
[ 7055.661874]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7055.661965]  i915 0000:00:02.0: [drm] *ERROR* vdbox2: timed out waiting for forcewake ack request.
[ 7055.662432]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7055.662753]  i915 0000:00:02.0: [drm] *ERROR* vebox0: timed out waiting for forcewake ack request.
[ 7055.663054]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by fw_domains_get_with_fallback+0x1ce/0x1e0 [i915]
[ 7055.663326]  Fence expiration time out i915-0000:00:02.0:wfica[9752]:6d5a!
[ 7055.663375]  Fence expiration time out i915-0000:00:02.0:wfica[9752]:6d58!
[ 7055.664059]  i915 0000:00:02.0: [drm] *ERROR* GT0: Failed to reset GuC, ret = -110
[ 7055.758161]  i915 0000:00:02.0: [drm] GPU HANG: ecode 12:1:87d7bffe, in chrome [4953]
[ 7056.073323]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.074055]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.074640]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs1 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.075240]  i915 0000:00:02.0: [drm] *ERROR* GT0: vecs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.081500]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.082521]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs1 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.083144]  i915 0000:00:02.0: [drm] *ERROR* GT0: vecs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.097256]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.098063]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.098545]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs1 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.098947]  i915 0000:00:02.0: [drm] *ERROR* GT0: vecs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.099358]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.099749]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs1 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.100150]  i915 0000:00:02.0: [drm] *ERROR* GT0: vecs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.127166]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.127876]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.128340]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs1 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.128744]  i915 0000:00:02.0: [drm] *ERROR* GT0: vecs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.129146]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.129544]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs1 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.129924]  i915 0000:00:02.0: [drm] *ERROR* GT0: vecs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.167176]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.167877]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.168342]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs1 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.168753]  i915 0000:00:02.0: [drm] *ERROR* GT0: vecs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.169148]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.169536]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs1 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.169915]  i915 0000:00:02.0: [drm] *ERROR* GT0: vecs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.171335]  i915 0000:00:02.0: [drm] *ERROR* GT0: Failed to reset chip
[ 7056.172040]  i915 0000:00:02.0: [drm] CI tainted: 0x9 by intel_gt_reset+0x304/0x320 [i915]
[ 7056.174110]  i915 0000:00:02.0: [drm] *ERROR* GT0: Failed to reset GuC, ret = -110
[ 7056.585144]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.585817]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.586231]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs1 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.586599]  i915 0000:00:02.0: [drm] *ERROR* GT0: vecs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.586954]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.587310]  i915 0000:00:02.0: [drm] *ERROR* GT0: vcs1 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.587645]  i915 0000:00:02.0: [drm] *ERROR* GT0: vecs0 reset request timed out: {request: 00000001, RESET_CTL: 00000000}
[ 7056.590064]  i915 0000:00:02.0: [drm] device wedged, needs recovery
