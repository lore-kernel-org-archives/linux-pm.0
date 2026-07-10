Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2708C3C8713;
	Fri, 10 Jul 2026 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783667969; cv=none; b=BqwqIZdxXZFzbn3BLNH3OvDh+FMnxB8EPnOsVYN4XtaONsOTcOgu0uBODE+SWEnH3UM+dLTU0YfWozwwscaXl58rAFgzEVMhI+UvIVEDgihSbqGLJjYe3NHAYqCkPFhkaQuU44yh98jiN7ObvJjWiBtr7ILAFLJhOD2z2cjF0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783667969; c=relaxed/simple;
	bh=pa9M4W5q71k2fHsiM4RsNegYVuC+qt0L+G9nYCxwUUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbEhCFQ2OR0iuM4Vqhs/oSyQIWOdUxAaqdEou3gFJDIdhpg1cq/AOfRdo+oSJGb1r42lPg5xcNgGoEWh3kGyW6nI0JmaExm/KkaJabxR9PR1mq6vN3v23NfDneerFTrVe15UesdMG/DQTFyQf3n0kk44p9nhIY2WulUMGY5I85k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=LJLAGcoD; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="LJLAGcoD"
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4gxNTY2jG6z4013;
	Fri, 10 Jul 2026 09:18:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1783667889;
	bh=pa9M4W5q71k2fHsiM4RsNegYVuC+qt0L+G9nYCxwUUE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LJLAGcoDeT4ILNKcvq3dsvjNGUoq0he2GG3NyuJO5GM6er6GXsg615zMA0rzJ5r6T
	 oo/pD01bAJ1UctJQGc1FnyF/+xXQpmFASv9WAQczW62tB2JHZIAYMzNmZbM2xsi/YY
	 gJMgWxNEMZNTbGo9cenuETzKQUu/tx1x865Cr+4TDiRe0VOw1a6T6DUPAUXpP1mTeK
	 TWl17/nzkeSJ9GmurPxlPUM19IauHpqhjpAF2lU7kowj6B6VtnJU41lga9+SkY5vnu
	 7eGvH8GcYAmfct0/LPipJPSzrfC01z7hg+c/M4qTnM5ZB3gIUzxiiLSR2w/TBq7Tnd
	 V8+QUr34MdYtQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4gxNTY2159z3yxy;
	Fri, 10 Jul 2026 09:18:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gxNTW6C6Cz8tcF;
	Fri, 10 Jul 2026 09:18:07 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 4D4CD60320;
	Fri, 10 Jul 2026 09:18:07 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <6eeb9cf8-3efe-49f9-a608-05924b9a75bf@leemhuis.info>
Date: Fri, 10 Jul 2026 09:18:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION?] hibernation soft lockup in migration/0 at
 multi_cpu_stop after image creation
To: Hlib Wondertan <hlibwondertan@gmail.com>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: 
 <CAFdGzA6y6MfGg_aR-+2hV15nNpVzpWfVVBgr08pcKZwSrszmMw@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAFdGzA6y6MfGg_aR-+2hV15nNpVzpWfVVBgr08pcKZwSrszmMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178366788758.1546012.14774408943063781578@mxe9fb.netcup.net>
X-NC-CID: 7JBMZa5zYBC479j/r4pNtQAK3id/r1ONplap9eCQaMUrdYZht9U=

Hi!

On 7/9/26 20:38, Hlib Wondertan wrote:
>
> I am seeing hibernation failures on a Framework Laptop 16 AMD Ryzen
> AI 300 Series. The best capture I have is from EFI pstore: the kernel
> creates the hibernation image, then CPU0 soft-locks in the CPU stopper
> thread and panics.

Thx for the report. You CCed the regression list, which leads to a
questions: what was the last version this was working?

Furthermore: Is mainline (7.2-rc) still affected?

And FWIW, if we are lucky some developer will show up in the next few
days with an idea what's wrong. But I doubt this will happen in this
case. So you most likely will have to bisect this to get this resolved:

https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html
https://docs.kernel.org/admin-guide/bug-bisect.html

Ciao, Thorsten
P.S.: Wild guess, but I wonder if this is related to (also waiting for
somebody to bisect):
https://gitlab.freedesktop.org/drm/amd/-/work_items/5387

> Impact: the machine powers/reboots instead of resuming the previous
> session. The next boot reported no valid hibernation image.
> 
> System:
> 
> ```text
> Machine: Framework Laptop 16 (AMD Ryzen AI 300 Series)
> DMI board: FRANMHCP09
> BIOS: 03.06, 2026-04-23
> Kernel: 7.1.2-arch3-1
> Arch Linux
> ```
> 
> Kernel config has the debug options requested for this class of issue:
> 
> ```text
> CONFIG_HIBERNATION=y
> CONFIG_PM_DEBUG=y
> CONFIG_PM_SLEEP_DEBUG=y
> CONFIG_SLUB_DEBUG=y
> CONFIG_PAGE_POISONING=y
> CONFIG_STACKTRACE=y
> ```
> 
> Relevant command line, with the root UUID elided:
> 
> ```text
> root=/dev/mapper/root rootfstype=btrfs rootflags=subvol=@ rw
> resume=/dev/mapper/root resume_offset=4728064
> rtc_cmos.use_acpi_alarm=1 drm.debug=0x1df log_buf_len=32M
> ignore_loglevel printk.devkmsg=on slub_debug=UFPZ
> ```
> 
> The hibernate attempt was triggered by upowerd at low battery. A systemd sleep hook ran before hibernation and captured:
> 
> ```text
> phase=pre
> operation=hibernate
> date=2026-07-09T17:45:04+04:00
> uname=Linux Wonderframe 7.1.2-arch3-1 #1 SMP PREEMPT_DYNAMIC Fri, 03 Jul 2026 23:25:36 +0000 x86_64 GNU/Linux
> pm_test=[none] core processors platform devices freezer
> disk=platform [shutdown] reboot suspend test_resume
> panic_on_oops=1
> hardlockup_panic=1
> softlockup_panic=1
> 
> BAT1 status=Discharging
> BAT1 capacity=4
> MemAvailable:   18303436 kB
> SwapTotal:      48212748 kB
> SwapFree:       48212748 kB
> HardwareCorrupted:     0 kB
> ```
> 
> Relevant GPUs:
> 
> ```text
> amdgpu 0000:c4:00.0 PCI_ID=1002:7480
> amdgpu 0000:c5:00.0 PCI_ID=1002:150E
> ```
> 
> pstore excerpt from the failed hibernate:
> 
> ```text
> [17199.818113] PM: hibernation: Creating image
> [17200.075162] PM: hibernation: Need to copy 3578614 pages
> [17200.075167] PM: hibernation: Normal pages needed: 3578614 + 1024, available pages: 4622595
> [17223.501212] PM: hibernation: Image created (2866538 pages copied, 712076 zero pages)
> [17224.160864] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [migration/0:20]
> [17224.160965] CPU: 0 UID: 0 PID: 20 Comm: migration/0 Not tainted 7.1.2-arch3-1 #1 PREEMPT(full)  914ec70c9fc54a99dc91d290948a1dd1bb226c49
> [17224.160969] Hardware name: Framework Laptop 16 (AMD Ryzen AI 300 Series)/FRANMHCP09, BIOS 03.06 04/23/2026
> [17224.160970] Stopper: multi_cpu_stop+0x0/0x140 <- __stop_cpus.constprop.0+0x6d/0xb0
> [17224.160980] RIP: 0010:multi_cpu_stop+0x87/0x140
> [17224.161015] Kernel panic - not syncing: softlockup: hung tasks
> [17224.161017] CPU: 0 UID: 0 PID: 20 Comm: migration/0 Tainted: G             L      7.1.2-arch3-1 #1 PREEMPT(full)  914ec70c9fc54a99dc91d290948a1dd1bb226c49
> [17224.161019] Tainted: [L]=SOFTLOCKUP
> [17224.161020] Hardware name: Framework Laptop 16 (AMD Ryzen AI 300 Series)/FRANMHCP09, BIOS 03.06 04/23/2026
> [17224.161020] Stopper: multi_cpu_stop+0x0/0x140 <- __stop_cpus.constprop.0+0x6d/0xb0
> [17224.161063] RIP: 0010:multi_cpu_stop+0x87/0x140
> ```
> 
> There were no SLUB/page-poison corruption messages in the pstore chunks, despite `slub_debug=UFPZ`.
> 
> An earlier hibernation pstore capture on the same kernel showed the same broad failure class, also in `migration/0`, but with `RIP: stop_machine_yield+0x6/0x10`.
> 
> I have attached:
> 
> ```text
> pstore-20260709-1748.tar.gz
> hibernate-pre-20260709-174504.log
> ```
> 
> Please let me know what additional data would be useful. I can keep the debug boot parameters enabled and retest with a proposed patch or additional PM/debug options.
> 
> 

