Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.103
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046885;
	b=q3DV3ZgE8QqrvondM6GWx5sBdTy0jPDBjrkz0BNzHn2gPQnErBnBYTRiLRBkebY2wO47
	 6/FgGC6eaYa9GwT3xZfnKofukChMy42ZR5T3CERa2H8JgS0sIQUoh+FrAUs8m4YcDPr6m
	 u4YIxP8yjgbM4kEilXf74MCf8kTC7WuPDe1VoK5h9xW8sYP92s2kUkBm13ridCPjeF9WT
	 e0TJuhsrLG5wLqWg5xZOjjGCE2Ak+/3NtN7N2zRQjuf6uVL9Vj8i/2Cp+KEg8b/O47SIj
	 bl7vrIXhMXbcbdkXUEL958xYpJ8BNkaOQQ1aPT6N/+OeLWoqIGU3FZVqqHmekOHJotA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046885;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pK8qCFZ9v8CLCDquJQQQvUscCxAM6X1Grwl8H6t4NAg=;
	b=z21Wzk+2vFdJvIQjq/OAQOOn3bPj+/DvR9bXxcT+GqYgIXqAbtlTRJmE8GjiXmf7t3rl
	 3Zt8lei/4DOqAaST17iwHr4Zja/To082b7aa2zVp6+iK+0OHXM78qWqOgVATuDkfBx9wv
	 e3CmgP7/tWm16EVZlWEQHq2qhxHrGmQ59kkmSEHu2a/Pa8gSZlBZHRIxo7KrHhH0ajqqb
	 DjjCoVBnx8n2OKn+gvdsZ8t2cN2rQP8poz1U81AtCgGc2E2I25Agy64+naITClFhr52ac
	 AvvOF7xqqOAo9qu33GyVOaIrR76tiqZPewPtJ/MUzrDl0lisXyvlQTmnxNJhuyuWmvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=swwv6yqiifdexemy77bcz5dqp4.protonmail2 header.b=iud8SGEy;
	arc=none smtp.remote-ip=79.135.106.103
Received: from mail-106103.protonmail.ch (mail-106103.protonmail.ch [79.135.106.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB680606A31D
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 20:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB680606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=swwv6yqiifdexemy77bcz5dqp4.protonmail2 header.b=iud8SGEy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=swwv6yqiifdexemy77bcz5dqp4.protonmail2; t=1793046881;
	x=1793306081; bh=pK8qCFZ9v8CLCDquJQQQvUscCxAM6X1Grwl8H6t4NAg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=iud8SGEy+hL0pW8Ysb8FcFmrkeucUIzlGGrNEQJ09/8bQmFMbbTcnfuDtPwt3mGEQ
	 PtZjEGKNXUzjwDDZCTNGjtRL6/c5e9d6+O6HFUx0lQkFm8uq5N9qTj8obqSqCmrCNB
	 rLZCJhlZDwBzge2vlz0qFhC3lXMnxxAkMgDfniwVcgPUPPFqVqEOxGGIcqabenb9Ei
	 8hC2vilZNLl8VMHfgmV8hPKZsfLok9oZJCcupF1p3gWyt+N6lVvOepiq+j2t5g+qlu
	 Husp6aMOzt8CONSCym701z2LhWBVrg/xQhFF2/+RFR5sX4FhMry3x6kHREkxbAQ9hv
	 Nk50dQw32LYNA==
Date: Mon, 26 Oct 2026 20:34:35 +0000
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
From: Guppy <realguppy@proton.me>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Lecoo N155A (Ryzen 7 H 255): spontaneous power-on after poweroff, Windows unaffected
Message-ID: <8TU4lNwHVZxb2wwWzkHCgC_6DYerUYpHLY85OteuSCWhtPAlxJZyJ4pBSWOa9g4U-8SkP26IXuRmh1U_3IT0-7z0Z06Fbnd11b_XCa8e-pQ=@proton.me>
Feedback-ID: 187169849:user:proton
X-Pm-Message-ID: c6a38b8b36ecdbeb7b3f117041bc2dc249f956a1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

On a Lecoo N155A laptop, after Linux completes a poweroff the machine
frequently powers itself back on. Windows 11 (Fast Startup disabled) shut
down cleanly in all 6 tests on the same hardware. I suspect a firmware
issue, but since Linux sometimes carries platform quirks for firmware
behavior, I would appreciate any guidance.

Hardware / firmware
- Lecoo N155A, AMD Ryzen 7 H 255 (CPUID 00A70F52), 32 GB, 1 TB NVMe
- BIOS N155A_00_V2.5_PKID 03/27/2026 (AMI Aptio, AGESA PhoenixPI-FP8-FP7 1.=
2.0.0e)
- EC: ITE, firmware 10.04 (07/08/2025)
- Kernels: Ubuntu 7.0.0-38-generic, Ubuntu 26.10 live 7.3.0-9-generic;
  earlier also Fedora 6.19 and 7.1. BIOS 1.2 and 2.5 both affected.

Symptom
systemctl poweroff completes normally, the power LED goes off, and about
0.5 s later the laptop powers on again and boots. Rate: about 6 of 7 when
shutting down repeatedly; much rarer in daily use (3 of ~55 in the journal)=
.

The kernel message "x86/amd: Previous system reset reason [0x00080800]:
... CF9" appears after intentional reboots, but not after successful
poweroffs nor after the spontaneous power-ons, so this does not look like
a normal reset.

Checked, with no effect or found already disabled
- BIOS: S5 RTC wake, Wake on LAN, Wake on PME disabled; also tried
  AC Loss Control =3D Always Off and Wake On Voice =3D Disabled
- FCH PMx74 =3D 0x1E020017 (PCIE_WAK_MASK, PCIE_WAK_INTR_DIS set);
  PM1_EN.PCIEXP_WAKE_DIS reads back 0 when set
- no AMD GPIO with the S4/S5 wake bit set; EC power-on flags
  (AIPO/LOPO/ATPU) are 0; no ACPI wake devices for S5
- _PTS(5) only writes FCH registers (no EC access); no _TTS
- disabling all /proc/acpi/wakeup entries, DSDT overrides skipping
  MPTS(5) or all of _PTS(5), unbinding network/BT/USB/USB4 before
  poweroff, module_blacklist=3Damdgpu, module_blacklist=3Damd_pmc

Shutdown traces
Using EFI pstore (printk.always_kmsg_dump=3D1, initcall_debug,
dyndbg=3D"file ec.c +p") I captured the kernel log up to "reboot: Power
down" for three consecutive poweroffs: two powered back on, one stayed
off. All three show the same 149 device shutdowns in the same order,
nearly identical timing, the same 0.318 s _PTS(5), and no EC transactions
during shutdown.

One more data point: an EFI application launched from GRUB calling
ResetSystem(EfiResetShutdown) powered off cleanly 9 of 10 times; the one
failure was the first shutdown after Linux had run.

Questions
1. Could the "Improvements to S5 power consumption" series (devices in
   D3 before S5, closer to Windows) be relevant here?
2. Is there a platform quirk or another diagnostic you would suggest?

I am happy to test upstream kernels and patches, and to collect more
traces.

Logs, ACPI tables, register dumps and the three shutdown traces:
https://github.com/xguppy/lecoo-n155a-poweroff

Thank you,
Igor Murzaev

