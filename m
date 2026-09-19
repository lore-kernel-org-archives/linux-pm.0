Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBE635E1BC
	for <linux-pm@vger.kernel.org>; Sat, 19 Sep 2026 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789832059; cv=pass; b=YASGqg5C+m0RgjYybCdjJ/eSclU8vnJdSXeN73EnxsSVZqeBIhYvgtz3R1kK92LvHtwmFGI9FzTzRBWMsduqlCHEqPMkO25XIxzUBgwqJVRnxU3DqMIGquFZVc36HNhB/NfmsymZGkzdSF6E+UqFpNFWBJ+dvJ+sL9vF8zyBW9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789832059; c=relaxed/simple;
	bh=91NsQRTrbKnFngUh38+V938ZCS45Lso1JuyxvfOW/Cs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=E+WjbH0cRNUDrFj6EfnLB4pti7ckDT6dE+OlA6AirsClj0OjLmp4ItoFp+u/hgowa0mNrOiqIQCn6Z+JqtxwXyjOnvrAkf+YCDC4hHbiXhYKKoe/Yd4IvrvJxlYoLN1EYNSMg8ANUVdt+m7BXOQIwVdblyHWvSibJsCWW4JplaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx9D0nuV; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx9D0nuV"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccc02279so1380470a91.1
        for <linux-pm@vger.kernel.org>; Sat, 19 Sep 2026 08:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789832056; cv=none;
        d=google.com; s=arc-20260327;
        b=VGaJrZLPOALZghPE8bDhiSUMheJIAxbsCIjnYalXq/bdS65ZkcqF81NiYHRSPaWgBV
         CHnAaQ5SiqQmvEhjyIS35SgZoqSuK7H00viT0RwqQbvXEcJIQzZ7dMmp3p0kF7noRuRX
         NzFKCG318AdCa/XuHsgDTfu900Q4BoB5jnoobBk9LgfscWjPiAwUjc9xsVJVRmYcxyzt
         y+0OEcbG8DzI2BLPcXjsDlIGR9vS+rBbcF3r5hJELW8P8qJ8oxZ8HPuwnqQomagARIO0
         gTHCIMFdPs20gHGI5FJwHQl5pbY4JMFxRqNrPTAE3is512tWoGThp99MprZZDOZaRRap
         /JTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=8fnPXbhqscJhckqgZvVV1PRMxW13XLBQTfn3jEgW454=;
        fh=s1BWPX/8+GbQMcmeOW8Js2h6ypzJv8oBWp9VU6vpXQY=;
        b=VASWSMiaoKpMG87XNWqYKDuQmhALrvhmhtS/QyoBxC1BfETlqobHKc7vmD/AR3DU3y
         DUOOh9pRWUSdn9v+bTH+QJVJgrYMSYII25hVGcVPfsj/C4sWawrtFS7NMns7hukGNUCF
         HLo6NLL84DIzcuwg662iSpz+FJjhaLjXDttXpp76W7d57xSQBZojnonAedinWJ/tNuBz
         0ljLjXXlafP7AqTqj7NaG/QqqlFH519qnM2Vhy1/2eLLZ2MJRvGhE4Wbxhr6Hiryih/y
         pZMJxs4/w9itL7zVKrv47c8z2UuRjDxfPbdwSLHBuhRYNmGSUrhVplw4f00UITWAQ5O/
         R1hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789832056; x=1790436856; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8fnPXbhqscJhckqgZvVV1PRMxW13XLBQTfn3jEgW454=;
        b=Mx9D0nuVdUG4fEgqBv9O8B7l/N7eYDQNxNgv020pE1Rn/iedKJMnviDnSVOUhFK0hf
         k+2KC9FtQPQ6llA3L2/XMWomiHwQDonR7310hvRtwgYyKwzsCIBu2MTa6hxlJQNVxTrg
         08XRSSbc3SyD956VIxFL36yBiYnJuBlWPe4Ld/T3E9G8Kz9vw+1PSErTxP3IjL4XH1kT
         0DC43zDLH0Wij/9W5gj36lv6c19OFTCza/Y1E+Z64UMjForhpFB6FL2BX/yh0kZlnl5i
         dFWho1eyeRRk2shvXZXUbOcC3xq/2vWm2UePk7xkgnHw0IaOy7e6BwUJw9rBSzuEMl6E
         0Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789832056; x=1790436856;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8fnPXbhqscJhckqgZvVV1PRMxW13XLBQTfn3jEgW454=;
        b=GcLJqOmNBxVzIZVjloAb2rptaK2qtXuNX1vm7b1IfmM5eHPsiafz3ml48dLC5/FX2J
         jUzXSFxubKuIrz4+/Hsv9P0QOVwMhKmrTBaQ1Z0RrEHeAQsIsuTHxwbyBo4qpo2UWjRw
         LKrT9bS89C9wy+1s8ZNRO+fnIY5PQN02Vo+XLpUZ9IkgUF9k1q57lxK6hMC6TQKTz2yl
         Y/iosWOrYYKUhQjMmwdx8ENHZLRInQADhnOmlQG9QkAq946d1xDtBt/8HDG4h3m2JNt4
         nrSJc43OQvfGy2b5B9qewYezVrAWqiZr1jHQJY35IHfmD2IdKUy1uYAGpvEUIz40y6i5
         6CbQ==
X-Gm-Message-State: AFuF++m7yi62xVmBSNPc8LOgzVdqdwt3gmzxI5sCSMLgic8Dwy+9Xy0e
	vID1nvzLT6lfrWSN5Ijml/EdtLZIFDysZFE7F4nrqUcM6RGwblmIPUe5w4Hn1UiamY5eRm4bUDW
	5JfU1VfbiFPhkki6z343PSiW1ucecm9GWWRF4
X-Gm-Gg: AYBFou2tKtBC2HdUsuGxM2iJN5Dd+JwDFRg1mRGvNOWIYd6+7QYcU1JRuMRqPfIBk4Y
	DcUWkEzTywzABF4ADFPNiI2X2DfkXAOHyjeTjl5C3uOrmlAenj4KrGg1ceOLJeIIgvI9txpE2JV
	E0/IwcKfjiUy15puBWg0lfJl7bzwAvOZZaRw87aZ+TpihHjtVC9ChinhR2jxMI+kqJtuGtrH+zs
	6GsT3pB24BYB1FyDmgh4Aobxy7ZOQg6KIqsDOs5hPj5ChZYuSOgu915NUoODDMv8UFpH75lHrTf
	/xJTLNEbFpmnquHX0rAtORw74H3lKgwuWtd8pgeNkPhEtaSqvmILq3c=
X-Received: by 2002:a17:90b:2e0b:b0:39e:6c68:c78a with SMTP id
 98e67ed59e1d1-39e6c68ca60mr4028454a91.64.1789832056468; Sat, 19 Sep 2026
 08:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "H. Haechoc" <h.haechoc+kernel@gmail.com>
Date: Sat, 19 Sep 2026 17:34:04 +0200
X-Gm-Features: AcwNN1Xc53HawroHL7KvJ47RotwUBp0nortVUyRMwOszb2uPMm6GJKFx2dvNcxI
Message-ID: <CAKp=m=AB8r826a2sJVeKVh7n8TUM07eLaLMmEEf=oKo_m1EW8w@mail.gmail.com>
Subject: Hibernation failures after commit "PM: hibernate: call
 preallocate_image() after freeze prepare"
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Matthew Leach <matthew.leach@collabora.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

after upgrading to a 7.2 kernel hibernation started failing on a Dell
Vostro 5568 laptop with 8GB of RAM and 10 GB of swap (zswap enabled).

With older kernels hibernation had worked without issues, either
completing successfully or returning to the desktop if there wasn't
enough space to save the hibernation image, but with the new kernel as
soon as the used memory goes over about 5-6 GB the laptop never
hibernates and it stays turned on indefinitely without giving any
other sign of life. The last console message when the problem occurs
is always "PM: hibernation: Preallocating image memory."

I tracked the issue to commit 783c8109844503bd1c35dab41b6d5fd074a9f131
("PM: hibernate: call preallocate_image() after freeze prepare"):
reverting that single commit makes the problem disappear.

A SysRq backtrace after a couple of minutes shows this:

[  631.104794] Call Trace:
[  631.104798]  <IRQ>
[  631.104804]  dump_stack_lvl+0x5d/0x80
[  631.104817]  nmi_cpu_backtrace.cold+0x18/0x73
[  631.104824]  ? __pfx_nmi_raise_cpu_backtrace+0x10/0x10
[  631.104834]  nmi_trigger_cpumask_backtrace+0x132/0x160
[  631.104844]  __handle_sysrq.cold+0xba/0x1b9
[  631.104854]  sysrq_handle_keypress+0x207/0x670
[  631.104862]  input_handle_events_filter+0x60/0xc0
[  631.104870]  input_pass_values+0x152/0x180
[  631.104876]  input_event_dispose+0x187/0x190
[  631.104881]  input_handle_event+0x41/0x70
[  631.104890]  input_event+0x59/0x70
[  631.104897]  atkbd_receive_byte+0x683/0x7a0
[  631.104907]  ps2_interrupt+0x8a/0xd0
[  631.104912]  serio_interrupt+0x54/0xa0
[  631.104920]  i8042_handle_data+0x10d/0x2d0
[  631.104927]  ? timekeeping_update_from_shadow+0xf8/0x1f0
[  631.104933]  ? timekeeping_adjust+0x19/0x150
[  631.104939]  i8042_interrupt+0x11/0x40
[  631.104945]  __handle_irq_event_percpu+0x69/0x210
[  631.104955]  handle_irq_event+0x38/0x90
[  631.104962]  handle_edge_irq+0xc8/0x190
[  631.104970]  ? tick_do_update_jiffies64+0x8b/0xd0
[  631.104976]  __common_interrupt+0x4c/0xd0
[  631.104983]  common_interrupt+0x80/0xa0
[  631.104989]  </IRQ>
[  631.104991]  <TASK>
[  631.104994]  asm_common_interrupt+0x26/0x40
[  631.105000] RIP: 0010:cpuidle_enter_state+0xcd/0x650
[  631.105009] Code: 00 00 e8 06 b9 ce fe e8 a1 eb ff ff 49 89 c4 0f
1f 44 00 00 31 ff e8 a2 c3 cb fe 45 84 ff 0f 85 76 01 00 00 fb 0f 1f
44 00 00 <45> 85 f6 0f 88 ed 01 00 00 44 89 f5 41 83 fe 09 0f 87 8e 04
00 00
[  631.105013] RSP: 0018:ffffffffa7603df0 EFLAGS: 00000246
[  631.105019] RAX: ffff89028ee6a000 RBX: ffff89023743dd40 RCX: 0000000000000000
[  631.105023] RDX: 00000092f0c5d56e RSI: 0000000000000000 RDI: 0000000000000000
[  631.105025] RBP: 0000000000000008 R08: 00000058b593bcc0 R09: ffff89028ee6a000
[  631.105029] R10: 0000003a3bb5b73d R11: 0000000000000000 R12: 00000092f0c5d56e
[  631.105031] R13: ffffffffa794ee60 R14: 0000000000000008 R15: 0000000000000000
[  631.105042]  ? finish_task_switch.isra.0+0xc8/0x3d0
[  631.105051]  cpuidle_enter+0x31/0x50
[  631.105058]  cpuidle_idle_call+0x10f/0x200
[  631.105063]  ? tsc_verify_tsc_adjust+0x37/0xd0
[  631.105071]  do_idle+0x9a/0x120
[  631.105076]  cpu_startup_entry+0x29/0x30
[  631.105081]  rest_init+0xe7/0xf0
[  631.105087]  start_kernel+0x4a2/0x4b0
[  631.105096]  x86_64_start_reservations+0x24/0x30
[  631.105104]  x86_64_start_kernel+0x12f/0x130
[  631.105110]  common_startup_64+0x13e/0x151
[  631.105122]  </TASK>
[  631.105124] Sending NMI from CPU 0 to CPUs 1-3:
[  631.105198] NMI backtrace for cpu 2 skipped: idling at
intel_idle_ibrs+0x8f/0x170
[  631.105236] NMI backtrace for cpu 3 skipped: idling at
intel_idle_ibrs+0x8f/0x170
[  631.105249] NMI backtrace for cpu 1 skipped: idling at
intel_idle_ibrs+0x8f/0x170

Please let me know if there's anything else I can do to further debug
the problem.

Best regards.

H.
