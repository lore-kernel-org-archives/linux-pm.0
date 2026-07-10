Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80D4071EF;
	Fri, 10 Jul 2026 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679266; cv=none; b=WHgKxHYyotT7M5KBlSbjtqqrs6uIhQ7J+H+I2ZmFe1SJqzNAjm+jkJsaaBljq09HpAD8NjkNk5lKYCQmdZii16QZqBhsW8z/eKi/05bd80LXzAPcfbVFeBDbxQjqlCo4AEAIxJ8Okdmnn4I/2T5Ev+/D/SYQ89yqVSezedDaCyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679266; c=relaxed/simple;
	bh=iK3A+pXxHffwBxrMsgSUnMftvOpU370XE/+2mwxUKHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hto1M7JQgR2opV4rct1DdHINN4HWrZ9MRUdRl3WQCajX2pResZVlv/qmdPbDPl2JfMctL8XxUZd8zo38TrmqQ3jmDnVyrzw++do6gSpTtlyhz4kvZQzvn72CO8Z63sWghIhhPHrV/kQctDcFYN5ARJw6qIUaS5lQ8N/e29dAZKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Wiz/oAZB; arc=none smtp.client-ip=188.68.63.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Wiz/oAZB"
Received: from mors-relay8204.netcup.net (localhost [127.0.0.1])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4gxSh73ws7z8hl1;
	Fri, 10 Jul 2026 10:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1783679255;
	bh=iK3A+pXxHffwBxrMsgSUnMftvOpU370XE/+2mwxUKHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wiz/oAZBCxQwnuXiGxqL/444nEKrs3mQKVsZ2Nfgck+sEysAjFIylnHIlLDqfgxPJ
	 /u8/mMLNTu6V0pSlDv5vKW7v6bxgAe3SHh6Dq6BSOs9CElQTU4uyzIrtxsXMp/lqVz
	 hrWlrtnZnj2UmWPfjJZf08HZqku0j7OWOMp9sZcm+0oZLEeinR0pxgsFolk0neac50
	 CTPiIR4zni7JSiqeUUB27tMf7R9UpszS2KBRD32DNGW0BOPEcrpJRnN7odgcKZ+E9R
	 M9pbY7gatAEUiNpCmy7BVEg8NcaNQbS6sUoL8nOmiNQHBe5UcANzQCO9QQcdmjI0Ge
	 BU8QZ/qOmByXw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4gxSh73Cwfz8hky;
	Fri, 10 Jul 2026 10:27:35 +0000 (UTC)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gxSh65Kq3z8sgw;
	Fri, 10 Jul 2026 12:27:34 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 0AAF260320;
	Fri, 10 Jul 2026 12:27:34 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <f7290509-684d-4512-a7ed-74e97bcbb4e9@leemhuis.info>
Date: Fri, 10 Jul 2026 12:27:28 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION?] hibernation soft lockup in migration/0 at
 multi_cpu_stop after image creation
To: Hlib Wondertan <hlibwondertan@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: 
 <CAFdGzA6y6MfGg_aR-+2hV15nNpVzpWfVVBgr08pcKZwSrszmMw@mail.gmail.com>
 <6eeb9cf8-3efe-49f9-a608-05924b9a75bf@leemhuis.info>
 <CAFdGzA6zQd9+1bqgpLgZJxbxh-krLo--J8q4yC_ODN9vdW+Tew@mail.gmail.com>
 <CAFdGzA67J-RBmY_zePXKpVbuJ1nFB1poNouNvP65fYot1k0LZQ@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAFdGzA67J-RBmY_zePXKpVbuJ1nFB1poNouNvP65fYot1k0LZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <178367925444.1888472.18289276614021858312@mxe9fb.netcup.net>
X-NC-CID: 60sjEpCsWhETPSUk74hzmPyE5kUG8G+7jeB1hnwU9WBxRrUdzik=

[Sending this with a amdgpu list and maintainers in CC to ensure they
know about this. Note, looks a bit like this is another variant of
https://gitlab.freedesktop.org/drm/amd/-/work_items/5387 ]

On 7/10/26 11:07, Hlib Wondertan wrote:
> Last known actually working: unknown. I do not currently have a kernel version where hibernation was known to work reliably on this machine.
> 
> For this exact `migration/0` soft-lockup signature, however, I only remember seeing it after updating to `7.1.2-arch3-1`. I do not have pstore evidence of this soft-lockup on the earlier 7.0.x kernels and I've logged every failure while staying on 7. Therefore, there is a chance this is a regression.
> 
> What I have locally is:
> 
> 7.0.11-arch1-1: hibernate/image-not-found failure with pstore pointing at amdgpu/ttm, but not this soft-lockup
> 7.0.12/7.0.13/7.0.14: other hibernate/resume failures, not always with useful pstore, and no captured migration/0 soft-lockup
> 7.1.2-arch3-1: current pstore captures show the soft-lockup in migration/0 after image creation
> 
> 
> So yes, this may be related to the drm/amd issue you linked: https://gitlab.freedesktop.org/drm/amd/-/work_items/5387 <https://gitlab.freedesktop.org/drm/amd/-/work_items/5387>
> 
> 
> I have seen the 5387-style TTM/amdgpu issue quite often on this machine before 7.1 and also on 7.1, and I have been reporting those reproductions in that GitLab issue as well. The reason I filed this separately is that the visible pstore signature changed from the TTM/amdgpu oops path to a hibernation `migration/0` soft-lockup after image creation.
> 
> Mainline 7.2-rc: not tested yet. The only currently installed/running kernel here is `7.1.2-arch3-1`.
> 
> I can test a mainline/vanilla 7.2-rc kernel next and report whether it is still affected. If it still reproduces, I can then work on finding a real good/bad range for a bisect; right now I do not have a trustworthy last-good baseline.
> 
> 
> 
> On Fri, 10 Jul 2026 at 12:54, Hlib Wondertan <hlibwondertan@gmail.com
> <mailto:hlibwondertan@gmail.com>> wrote:
> 
> 
>     Last known actually working: unknown. I do not currently have a kernel version where hibernation was known to work reliably on this machine.
> 
>     For this exact `migration/0` soft-lockup signature, however, I only remember seeing it after updating to `7.1.2-arch3-1`. I do not have pstore evidence of this soft-lockup on the earlier 7.0.x kernels and I've logged every failure while staying on 7. Therefore, there is a chance this is a regression.
> 
>     What I have locally is:
> 
>     ```text
>     7.0.11-arch1-1: hibernate/image-not-found failure with pstore pointing at amdgpu/ttm, but not this soft-lockup
>     7.0.12/7.0.13/7.0.14: other hibernate/resume failures, not always with useful pstore, and no captured migration/0 soft-lockup
>     7.1.2-arch3-1: current pstore captures show the soft-lockup in migration/0 after image creation
>     ```
> 
>     So yes, this may be related to the drm/amd issue you linked:
> 
>     ```text
>     https://gitlab.freedesktop.org/drm/amd/-/work_items/5387 <https://gitlab.freedesktop.org/drm/amd/-/work_items/5387>
>     ```
> 
>     I have seen the 5387-style TTM/amdgpu issue quite often on this machine before 7.1 and also on 7.1, and I have been reporting those reproductions in that GitLab issue as well. The reason I filed this separately is that the visible pstore signature changed from the TTM/amdgpu oops path to a hibernation `migration/0` soft-lockup after image creation.
> 
>     Mainline 7.2-rc: not tested yet. The only currently installed/running kernel here is `7.1.2-arch3-1`.
> 
>     I can test a mainline/vanilla 7.2-rc kernel next and report whether it is still affected. If it still reproduces, I can then work on finding a real good/bad range for a bisect; right now I do not have a trustworthy last-good baseline.
> 
> 
> 
>     On Fri, 10 Jul 2026 at 11:19, Thorsten Leemhuis
>     <regressions@leemhuis.info <mailto:regressions@leemhuis.info>> wrote:
> 
>         Hi!
> 
>         On 7/9/26 20:38, Hlib Wondertan wrote:
>         >
>         > I am seeing hibernation failures on a Framework Laptop 16 AMD
>         Ryzen
>         > AI 300 Series. The best capture I have is from EFI pstore: the
>         kernel
>         > creates the hibernation image, then CPU0 soft-locks in the CPU
>         stopper
>         > thread and panics.
> 
>         Thx for the report. You CCed the regression list, which leads to a
>         questions: what was the last version this was working?
> 
>         Furthermore: Is mainline (7.2-rc) still affected?
> 
>         And FWIW, if we are lucky some developer will show up in the
>         next few
>         days with an idea what's wrong. But I doubt this will happen in this
>         case. So you most likely will have to bisect this to get this
>         resolved:
> 
>         https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-
>         regressions.html <https://docs.kernel.org/admin-guide/verify-
>         bugs-and-bisect-regressions.html>
>         https://docs.kernel.org/admin-guide/bug-bisect.html <https://
>         docs.kernel.org/admin-guide/bug-bisect.html>
> 
>         Ciao, Thorsten
>         P.S.: Wild guess, but I wonder if this is related to (also
>         waiting for
>         somebody to bisect):
>         https://gitlab.freedesktop.org/drm/amd/-/work_items/5387
>         <https://gitlab.freedesktop.org/drm/amd/-/work_items/5387>
> 
>         > Impact: the machine powers/reboots instead of resuming the
>         previous
>         > session. The next boot reported no valid hibernation image.
>         >
>         > System:
>         >
>         > ```text
>         > Machine: Framework Laptop 16 (AMD Ryzen AI 300 Series)
>         > DMI board: FRANMHCP09
>         > BIOS: 03.06, 2026-04-23
>         > Kernel: 7.1.2-arch3-1
>         > Arch Linux
>         > ```
>         >
>         > Kernel config has the debug options requested for this class
>         of issue:
>         >
>         > ```text
>         > CONFIG_HIBERNATION=y
>         > CONFIG_PM_DEBUG=y
>         > CONFIG_PM_SLEEP_DEBUG=y
>         > CONFIG_SLUB_DEBUG=y
>         > CONFIG_PAGE_POISONING=y
>         > CONFIG_STACKTRACE=y
>         > ```
>         >
>         > Relevant command line, with the root UUID elided:
>         >
>         > ```text
>         > root=/dev/mapper/root rootfstype=btrfs rootflags=subvol=@ rw
>         > resume=/dev/mapper/root resume_offset=4728064
>         > rtc_cmos.use_acpi_alarm=1 drm.debug=0x1df log_buf_len=32M
>         > ignore_loglevel printk.devkmsg=on slub_debug=UFPZ
>         > ```
>         >
>         > The hibernate attempt was triggered by upowerd at low battery.
>         A systemd sleep hook ran before hibernation and captured:
>         >
>         > ```text
>         > phase=pre
>         > operation=hibernate
>         > date=2026-07-09T17:45:04+04:00
>         > uname=Linux Wonderframe 7.1.2-arch3-1 #1 SMP PREEMPT_DYNAMIC
>         Fri, 03 Jul 2026 23:25:36 +0000 x86_64 GNU/Linux
>         > pm_test=[none] core processors platform devices freezer
>         > disk=platform [shutdown] reboot suspend test_resume
>         > panic_on_oops=1
>         > hardlockup_panic=1
>         > softlockup_panic=1
>         >
>         > BAT1 status=Discharging
>         > BAT1 capacity=4
>         > MemAvailable:   18303436 kB
>         > SwapTotal:      48212748 kB
>         > SwapFree:       48212748 kB
>         > HardwareCorrupted:     0 kB
>         > ```
>         >
>         > Relevant GPUs:
>         >
>         > ```text
>         > amdgpu 0000:c4:00.0 PCI_ID=1002:7480
>         > amdgpu 0000:c5:00.0 PCI_ID=1002:150E
>         > ```
>         >
>         > pstore excerpt from the failed hibernate:
>         >
>         > ```text
>         > [17199.818113] PM: hibernation: Creating image
>         > [17200.075162] PM: hibernation: Need to copy 3578614 pages
>         > [17200.075167] PM: hibernation: Normal pages needed: 3578614 +
>         1024, available pages: 4622595
>         > [17223.501212] PM: hibernation: Image created (2866538 pages
>         copied, 712076 zero pages)
>         > [17224.160864] watchdog: BUG: soft lockup - CPU#0 stuck for
>         26s! [migration/0:20]
>         > [17224.160965] CPU: 0 UID: 0 PID: 20 Comm: migration/0 Not
>         tainted 7.1.2-arch3-1 #1 PREEMPT(full) 
>         914ec70c9fc54a99dc91d290948a1dd1bb226c49
>         > [17224.160969] Hardware name: Framework Laptop 16 (AMD Ryzen
>         AI 300 Series)/FRANMHCP09, BIOS 03.06 04/23/2026
>         > [17224.160970] Stopper: multi_cpu_stop+0x0/0x140 <-
>         __stop_cpus.constprop.0+0x6d/0xb0
>         > [17224.160980] RIP: 0010:multi_cpu_stop+0x87/0x140
>         > [17224.161015] Kernel panic - not syncing: softlockup: hung tasks
>         > [17224.161017] CPU: 0 UID: 0 PID: 20 Comm: migration/0
>         Tainted: G             L      7.1.2-arch3-1 #1 PREEMPT(full) 
>         914ec70c9fc54a99dc91d290948a1dd1bb226c49
>         > [17224.161019] Tainted: [L]=SOFTLOCKUP
>         > [17224.161020] Hardware name: Framework Laptop 16 (AMD Ryzen
>         AI 300 Series)/FRANMHCP09, BIOS 03.06 04/23/2026
>         > [17224.161020] Stopper: multi_cpu_stop+0x0/0x140 <-
>         __stop_cpus.constprop.0+0x6d/0xb0
>         > [17224.161063] RIP: 0010:multi_cpu_stop+0x87/0x140
>         > ```
>         >
>         > There were no SLUB/page-poison corruption messages in the
>         pstore chunks, despite `slub_debug=UFPZ`.
>         >
>         > An earlier hibernation pstore capture on the same kernel
>         showed the same broad failure class, also in `migration/0`, but
>         with `RIP: stop_machine_yield+0x6/0x10`.
>         >
>         > I have attached:
>         >
>         > ```text
>         > pstore-20260709-1748.tar.gz
>         > hibernate-pre-20260709-174504.log
>         > ```
>         >
>         > Please let me know what additional data would be useful. I can
>         keep the debug boot parameters enabled and retest with a
>         proposed patch or additional PM/debug options.
>         >
>         >
> 

