Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A237EFFC
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235423; cv=pass; b=p2596Di39BGvjmIi+N2GAvRIRLXE3hpRwNZjzyaJ295C6sE1Bm7vGpVkj4G3Gl6LOQx7Hhm3/ooi8G0F7UK0sXexJE7eHHxSalycaru2UcrWYkihZQ2BMMHIQz0zG6MHtXk3cKvB3pO8KTD31161//cLd5NpSUNgrpL2qwP36Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235423; c=relaxed/simple;
	bh=lKtNfmVxy6PnM08awUrBMfdT2M+Ze5BiielD1CHkFvk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=conSK9PDJO3GQWyFiEKT83BVvN0IeJaQz9hEN+HtoVp6hThSXIY/hhB6SFWS5hE7xmrHddERatZrfn0Vb3HhzCPedqGfiFUwkXHlHeVZ81F8oh3b4jfcGpCn29qAMyG0mrPOKWJAfx+RBw/xEBnT5+r0pvrrTVoPYR6LNpNWUTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnnRnjXN; arc=pass smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnnRnjXN"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-35122ae71e9so998223eec.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 14:23:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791235421; cv=none;
        d=google.com; s=arc-20260327;
        b=NVoTHcrNw/0m0oxU00jDex0rgIBkO2FML93dLnnKYBU1ht6ffHJj1k2UvhPna0d6jg
         4K94Jp5g6dpolO5uQ+iwwfiJelyKRlNlGoajDE5GOU7Qip0/twc6tUgfydluuzqc4QUv
         Ctr1Law7X62um6W6Fc+SahI+kyD97ixLgo9T3J0SSqgeVTsebRfDnS8JBNy/jG+JCk53
         QG+ce9dlxoZ7D8gVfLkTrvmdXTaOPvuUUpRXO8Md1ZQtVuCUjuvf1g/h5H1v332S8k6h
         J3J3LwMUYci/6gsGnkaORrDTUJHZlfbkYU77boEG5FuJR2TET0ZtubJhrPBbsBUnlEIz
         FA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+BMsm8vxGskhN0Hd8cdAfO0SjPkALEVFiwdvrxqaZWI=;
        fh=2Mp7SpNISovM2ex6zJZElJfc1SomXB3tvQGvJ6ReIfY=;
        b=NY/5LyujrmxcvMWci7MgXziULcFzD6zpVAPuZGxmL52Yc9Q03nvRtnLXZYCYDK33kE
         VuMNT2RTO6W8kkT0cvfoOGRISwBjv1hg3e8cCWHAj+4eHsau+E/BKn2QirBZzaMn+69R
         RztfA+244q3EAYShpE/4sLE1c5OhQz8MXUQaMSWkRWsAgmcd4qFLSPrEDmPm9w6YYvGP
         DwWyOh2RmZprRH7m2ItGuX4p3cjfHHXCOFTIGFfoSvjl7D/+l1n0JPosTP7ks/aoWZs7
         b8Uu92wrgf5wca9jzWDOiGc19aUbzZjcQ0idPoc7xLrkKU9E2L1mDkt+CTrfu1YEqRz4
         jbxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791235421; x=1791840221; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+BMsm8vxGskhN0Hd8cdAfO0SjPkALEVFiwdvrxqaZWI=;
        b=FnnRnjXNausk+trqCQkL2dvONA684455VH4RQJ97im0b5ZPv2EhyYxlafi+//+ZS9q
         CiKxz36j/9JTGgO7eIGsXDyqinf6Rf8OV08L55BqUTcRYNpMNzsFP6q7suSmPSLqoMoC
         UlvmBvaIzvN9ql5q4/3HoENUwBLyW3F1PwadtxDoRRmL7A41AcQPVmOK02m9Rs21Rcgb
         N8lYHQqLibgolABawpz2PDprxrqs41URqynKrmr5KibciHKwX4FMSYm5gffshWqYl00H
         neFG9za0aE9F1JOQoj1mz0BXwJvW3tsOKNsnsRAwOTiktvgPkrIWOVTMBpQh/XqH/5ha
         sE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791235421; x=1791840221;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+BMsm8vxGskhN0Hd8cdAfO0SjPkALEVFiwdvrxqaZWI=;
        b=Uz/QcUFcIWoIxCYnKhzsE6heudsSyRWJnQ8GzAaDrC6fYwjuMd0EYEHs6AlF4eEkkZ
         sqDylhaQE1vtVH1NwfBKrGUbjstodyv0+b9D6xSREJZAqi+KtONpnV4RKrXsl58IChD4
         YlOvY5AyROq//EeQE1QRR+eN+/sWvBFBu10ScLkpQ/LMdho7YvOHXo8fkZOdYBv1O6CR
         +aZmNgqdieYE0JDESgCFWeD08GBwSCP+UkGuTxvOUHx9eK6HQfHn4pOjt60lrVFrNhDp
         /0sPIUXvIYpP6cu82yBcHgp7sNuFSqDG783dEyb+IGYcScUDa4/rar74qiurRQtK3ric
         dEuQ==
X-Gm-Message-State: AFuF++mskvHfrP7ZJZ4Wuhz+T450n+1UHJ1vIsw+LJ769zHVln2l2ZAn
	TWvUaGulL6eGZb57r0U1sghKmQUbpynuQSEZXEPRHD4EUHnYKtVmeIswTg6u+brMjG90VSXEo2j
	ryVgj0CDmWCUGQ/cZNEpcla7j0ddF9Yiavo/q
X-Gm-Gg: AYBFou3e3me0FL0bRPMdr0gRHrQbGt3pWXhn+nij8H8aCHosUrV1/Hy3oqyRp8ru9/h
	L26jbBW8zYxF75Ot+xDEE1IX/Pj2b3d6ngU9pK+gHV1yJ6s21wHbwATAASAel++9SVrxReC2uQp
	6lU/McW12p3zEwMXGBts/Q0lJT7+Qj1cfJrDKnuNHtlRP+vf/DgctLbE9zIDy1ao1m6Eg9agyZz
	4GIAPB8k17nIgzqL4qzadOC4KwUnJmHQ+kttxBgYKe10McLaFw/FNe2xIr+EsEF3I+OnSUMx3Ti
	bf+Qt05heV3HNsNlXaUo5af5Go4eLscdFUrdgkOlXHTsxkfHKb+WV/te2FdTOSlBiqB3oCJMRTF
	0QHqu9vf6xEnSfscxzhSYooIxZvzrZeHrLJfzTOxO
X-Received: by 2002:a05:7301:6192:20b0:351:1f6c:2adc with SMTP id
 5a478bee46e88-3511f6c3fa8mr8573268eec.35.1791235421007; Mon, 05 Oct 2026
 14:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Angel <angellindo@gmail.com>
Date: Mon, 5 Oct 2026 16:23:04 -0500
X-Gm-Features: AclHuK9Z7s602mcUDHL6s_E2f36vm8zCtPPCuSnS67fsZBsYjidhjuOavzFm7LE
Message-ID: <CACiNov445=gavzZY=Yz74HNMUgd2BKoYoazWFDRRsz9uhA_rfA@mail.gmail.com>
Subject: [REPORT] Kaby Lake-H (MacBookPro14,3): package C-state stuck at PC3
 on Linux, macOS reaches PC10
To: linux-pm@vger.kernel.org, rafael@kernel.org, 
	artem.bityutskiy@linux.intel.com
Cc: rajneesh bhardwaj <irenic.rajneesh@gmail.com>, xi.pardee@linux.intel.com, hansg@kernel.org, 
	ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On a MacBookPro14,3 the package never goes deeper than PC3 on Linux,
while macOS on the same unit and the same firmware reaches PC10. I have
ruled out the usual suspects and would like advice on what else can
keep the package out of PC6 on KBL-H / SPT-H.

Hardware and software
---------------------
- MacBookPro14,3, i7-7820HQ (Kaby Lake-H), HD 630 + Radeon Pro 560
- PCH: 100-series PCH-H (SPT-H), PMC 8086:a121
- Apple EFI 529.140.2.0.0, SMC 2.45f5, Thunderbolt NVM 41.5
- Linux 7.2.5 (distro kernel), intel_idle (native tables,
  use_acpi=N), intel_pstate with HWP
- gmux switched to the iGPU; the Radeon is unpowered by the gmux
  (or unbound with its root port in D3hot, see below)

A/B: macOS vs Linux, same machine, same firmware
------------------------------------------------
macOS 13.7.8, idle, display on, "powermetrics --samplers
cpu_power,gpu_power", 6 x 10 s (means):
  PC10 80.8 %, PC6 2.5 %, PC3 0.06 %, i915 DC6 97 %, PSR 99 %,
  package 0.19 W (powermetrics energy-model estimate, not RAPL)

Linux, idle, turbostat, 10 s samples:
  awake, display on:      PC3 58-71 %, PC6..PC10 0, PkgWatt 4.0-4.2 W
  s2idle (5 min sleeps):  PC3 98.5-98.8 %, PC6..PC10 0

Residencies are comparable; the macOS wattage is only an estimate.
With the display off, macOS still reaches PC7-PC10, and with a USB
disk active on the Thunderbolt xHCI (PEG link up, no ASPM) it still
reaches PC6/PC7. So firmware does not forbid deep package states.

What was ruled out (PC6..PC10 stayed at 0 in every case)
--------------------------------------------------------
- i915: eDP pipe disabled, no display power domain references left
  (i915_power_domain_info). DC5 is entered (~1/s), DC6 never.
  My guess, not verified: DC6 = 0 is a consequence of the package
  veto, not its cause. Also 0 with DPMS off.
- Radeon: unpowered via gmux (iGPU mode), or amdgpu unbound with
  runtime PM so that the PEG0 root port is in D3hot; measured awake
  and in s2idle.
- Thunderbolt: both root ports' devices removed, root ports in D3hot;
  awake and in s2idle. Forcing L1 on the PEG/TB links did nothing.
- LTR: LTR_IGNORE = 0x1fbdf written to PMC PWRM+0x30C (all IPs
  ignored), awake and during s2idle, restored afterwards.
- Combined: Radeon off, TB removed, T1/xHCI idle, DPMS off, rfkill,
  LTR_IGNORE, all at once. SMBus unbound in s2idle: no change.
- IRTL (MSR 0x60B-0x60D, 0x633-0x635): lowering them only removes
  states (with all IRTLs below 61 us even PC3 disappears), so the
  factory values are not the limit.
- MSR 0xE2 = 0x40000008 on all CPUs: package limit C10, lock bit
  clear.
- intel_idle without _CST (use_acpi=N); cpuidle shows C10 (MWAIT
  0x60) taking most of the core idle time.
- acpi_osi=Darwin: no change.
- apple_set_os: the EFI stub already calls it on MacBookPro14,3
  (declares "Mac OS X 10.9"), so that path is already taken.

PMC
---
intel_pmc_core picks the Cannon Point map on SPT-H; I sent a patch
that adds a121 to the Sunrise Point list:
https://lore.kernel.org/r/20261005-intel-pmc-spt-h-v1-1-78c98e4f4620@gmail.com

With it, pch_ip_power_gating_status at idle shows PMC, OPI-DMI,
SPI/eSPI, XHCI, LPSS, LPC, SMB, P2SB and FUSE not power gated; SPA-SPC,
GBE, SATA, HDA, ISH and CSME are gated. Unbinding the Bluetooth UART
gates LPSS, but PC6 and SLP_S0 residency stay at 0. XHCI stays on
because the Apple T1 (internal USB) is kept active. I have not
verified that the SPT-LP PPFEAR layout is correct for SPT-H.

Questions
---------
1. On KBL-H + SPT-H, besides LTR and IRTL, which platform conditions
   make the package stop at PC3 while all cores sit in C10? Is there
   a readable deny reason or status register for this?
2. What should I read next: PMC registers beyond PPFEAR (ModPHY/PLL
   or MPHY power gating status), System Agent / uncore state, or the
   PEG link power state (L1 vs L2/L3)? Any debug tool that works on
   a production part?
3. Is the SPT-LP PPFEAR map valid for SPT-H (bits 13/21 are reserved
   in the SPT map but SPD/SPE in the CNP map; root port 17 is the
   NVMe here)? Which of the IPs above are expected to stay on in
   an S0 idle that reaches PC10?
4. Are there known Apple firmware settings that only macOS undoes
   (or that Linux needs to program) for PC6 on these machines?

I can run tests on this machine and share the raw turbostat and
powermetrics output and register dumps.

I used AI analysis tools to help organize the measurements and draft
this text; all measurements were run and checked by me.

It's my first time collaborating, hopefully this info is of service
for any correction.

Thanks,

--
Ing. Angel Lindo
Director de Operaciones @ Ultratech
+507 6326-1581
LinkedIn
