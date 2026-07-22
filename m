Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4AF33939C
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784742662; cv=pass; b=EbDzM8G93AR0tW83g4mTvpf5lmtmvHnYPvEY1rqcAZD60dSuDl4NrR2mN6Ljuv4tuo11OyDULq4rUBQWGiGutowQ3e6I9m5LYKg8IVgholjt7xIYMArSN4NYoIKj8hbGR0wr0ZAOjm4HlPcH23hmJ7/jjocCYBPVuA9xdOyfJ1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784742662; c=relaxed/simple;
	bh=+IapzB/cjQFVBZDKL2WRZGFhLGkuPIF3Is9sosJS+uA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oPOs8KTDZuEhuxfH58Hm3Zg7HRCjQMOLeKXRV04DJ/h85iW8HvtlBIqdtOQjUGepYYKmdcmhRU54mKDOLHC2gYj+00X/dwg6BhwuH8cVoWBENaIti7mbzOh5WOhBWQS1ZlOg79Ar7nqxkPbplcnNtWda/e8T6UBEyXqOh0gSDAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Scm/vv+9; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Scm/vv+9"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6a384e29a20so1323842eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 10:51:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784742660; cv=none;
        d=google.com; s=arc-20260327;
        b=g5yKyA/VZFUENrFxKk9nO78GfZ8mEs0tl3bk/8hNOUconeKsgQmrfCIkA7hmGel4+m
         7cPwabmNwiEHyJszfwkOq7r+/yyoGJvfF+pL8w10p2w8HLGTlCqrldk8JpJ4cql67cw1
         DjDgXPQ/BDMDD8lweKWtKyJ0o6cPvuyWpVQ6r9OpdOQk5vihE3RhXWTsCoCF9gGE9WmQ
         +S4C52Hz8QRGv4i0ttKU1sZGwpz5VPozcd1Rxs+yQHbzZ7udK9SXWVbEnsIMnLVNon+L
         XZW1agpNfkXoetAV6U3IaWfv7CcNfHIEQkBqJ4oRpIygQoiU2qADDnGQU2mlufGy57F1
         C6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+IapzB/cjQFVBZDKL2WRZGFhLGkuPIF3Is9sosJS+uA=;
        fh=RbpT+nvZbw5m4MQMNfXw6TbWN9Lz0KqZ5T2VV5TWLmA=;
        b=CV9afF3e7zAqIeFA4gCuEXNrZ7ztUnQmKIXNVL2ySN4ZV87KZ8lk50kS9udGYdRXLi
         ju0FYNRnnUMyebQEq/PpikWyhOJLESNb+fCXcSOTIf84ZUev6yC99e7eGYKRa4udf0vG
         MWk5jEK1jFDhmMeGmyaz9sDOmOe7GZkh842fH+jB7QX3iqy0ZV9pKQGYM2x1FzVhwIpp
         gZ7xOvJCXMWA1Rk6DlV0eFk+z8nfdN7weH2YHdI0f8rox6x60jhKvUQEDBqPCzGte0q1
         QcHomQIrWff5ofAHPMDDIfF+1HOcZ1D6bz7U5g6LtCQu5urDWp0wL7SA5ueSWuLN5zv9
         iB7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784742660; x=1785347460; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+IapzB/cjQFVBZDKL2WRZGFhLGkuPIF3Is9sosJS+uA=;
        b=Scm/vv+9JOzKmFuZC1KOot31vO168yNgV4NCgD6l0NHhPR5Kas8mWImLWDqP9LpWP3
         +BwRvEtTOSpw8NOlsf3Fo6KZWJqZ2tO+IcUiQogVh41vyoRPjE7k+NzePTyGaucnEd1f
         FIJ/ZdMjRWKD42GNuNg94MCWX8amAlsrj/qB2U83PwddrvNEhQwNOAKkb7f7EzWJwwNv
         UTKGm6UIrVviliL37GCB55xWIgVVQBRrpKwCQYjWeLtth7DbYBafhMUBNrS5WNRwDmlx
         Kw9yHehWHI9asnA58d5a84pEowmsC9lKd2AZ6F2F6iqGO+eXWZ9p0VK/1KenINmpkKsl
         52fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784742660; x=1785347460;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+IapzB/cjQFVBZDKL2WRZGFhLGkuPIF3Is9sosJS+uA=;
        b=jigJh15BB/2iIDg+5uDcYdGqrKuqlpLHu65nXNyVSa5DNhgrdhomsDWnP5M3ieb7uh
         GgfLrsrwzvjQOox6rVjgY/lJ6v9ZMZ+d5n29E3cMi/Si+xoqAzh5rrVOb/xAUSiIiaad
         LWLrY8K6i2FWaKF6aH3aVAoLVmLqrlJFclwGkwP41OOxE9IQcrPwa+19Ei29jy4E12VF
         bJQcBhFiZZag/MK3ev6VprtodOBkD8ZS9SRoZO9Jdr2Z3/B3KlFySCgHQPAimXkw0EEg
         GdcKMK9+7ApZRUoae9Qf8XenhGOcq/Hd8NaeiuaJS8W3N6a/wPPqi75PvQ34u6YmjRuK
         uqVA==
X-Gm-Message-State: AOJu0YzgapGcCiwJUbCC+Gt9hDCBkoEfGEaPXxFd7sJUF5us36I5pkGn
	IeSY3dav75JiQiMwBU/+MwH/AokEBOEhB4dq/l5lCtdhqU8YiOVB0VgUf05SwxsXsV6DNuA0nz2
	ND3HXKkijRdqAhTam3dekfFzjUhB814JfHg==
X-Gm-Gg: AR+sD12V7Dezay4KrH+VJ/hg7+stwTr4abJ9ShzUOzjBKEnqhRW8ijIrJDzZh8lusYT
	P9Gz5UWZ1qGDuzavKY9ymZb8Pg0q+R4+KK1dzwhRwm2Js1VBD5dhe6wGpDDgobfLST1d6cao2Yo
	yzH2rJKTQ/PvPTnmC1+1z4RmRNpyA8cdf4IP/tKz1oAq3jjyUK3NonvHylzzNd67jUqedlYlyW5
	ogVCUNGNtX8kQVfrDUgHTrxrAdOy9d+RYm857tOmJdJ0LdkYGOjV9shnVAlKQE06es39Dlv
X-Received: by 2002:a05:6820:4d01:b0:6a3:e0fb:6f39 with SMTP id
 006d021491bc7-6a5367fb337mr11292956eaf.23.1784742659748; Wed, 22 Jul 2026
 10:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Javier_Dom=C3=ADnguez?= <javi.dominguez.ib@gmail.com>
Date: Wed, 22 Jul 2026 19:50:47 +0200
X-Gm-Features: AUfX_myZUe5TUERR55mulFcDQ4cMPyrTep9f37vrRB0pBr8nplfubkArDlAeYvY
Message-ID: <CADiKKdJKbak5xQ+0=WFpQpA7=-iRJbbqzi3VnnRbCQ7=P5FogQ@mail.gmail.com>
Subject: [BUG] intel_rapl: PSys registration on LG Gram 17Z90SP (Meteor Lake)
 triggers firmware clamp of all cores to 400 MHz
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On the LG Gram 17Z90SP (Intel Core Ultra 7 155H, Meteor Lake-H), kernels
whose intel_rapl_msr driver registers the PSys platform-power domain wake up
a buggy platform-limit enforcement in the LG EC/firmware: after any boost
episode reaching ~100C package temperature, all cores are clamped to 400 MHz
(min frequency) for ~6 minutes per episode, even while package temperature
falls to ~65-70C and actual power draw is a few watts. The system becomes
essentially unusable during each episode.

Kernel 6.8 (Ubuntu 6.8.0-134-generic), whose intel_rapl_msr does not
register PSys on this SoC, never exhibits the problem. Kernel 6.17 (Ubuntu
HWE 6.17.0-35-generic) registers PSys as intel-rapl:1 and the clamping
episodes begin. Blacklisting intel_rapl_msr + intel_rapl_tpmi on 6.17
greatly reduces episode frequency; an EC reset (power off, unplug, hold
power button 30 s) clears a wedged PSys sensor reading and stops the
remaining episodes.

System information
------------------
- Machine: LG Electronics 17Z90SP-E.AD88B (board 17Z90SP), LG Gram 17 (2024)
- CPU: Intel(R) Core(TM) Ultra 7 155H (Meteor Lake-H)
- BIOS: M2ZI0450 X64, 2024-06-10 (latest available from LG as of 2026-07-22)
- EC firmware release: 51.0
- Distro: Linux Mint 22.1 (Ubuntu 24.04 base)
- Good kernel: 6.8.0-134-generic (no PSys registration on this SoC)
- Bad kernel: 6.17.0-35-generic HWE (PSys registered by intel_rapl_msr)

Symptom
-------
Intermittent system-wide freezes: all 22 CPU threads pinned at 400-500 MHz
for ~6 minutes per episode. Episodes always begin immediately after a burst
that reaches >=100C package temp (chassis is thermally weak; brief all-core
load hits 100-104C in seconds, which is handled fine by regular HW thermal
throttling on the good kernel).

Evidence
--------
1. During a clamp episode (package at 65-70C, all knobs sane):
- MSR_CORE_PERF_LIMIT_REASONS (0x64F) = 0x1dc20400 -- active status
bit 10 (Package/Platform PL1) while clamped at 400 MHz.
- IA32_THERM_STATUS (0x19C) = 0x882f2c00, PKG_THERM_STATUS (0x1B1) =
0x882c0c00 -- power-limitation status/log bits set; PROCHOT bits clear.
- Hardware throttle counters (thermal_throttle/package_throttle_count)
stop incrementing during the pinned phase -- not thermal throttling.

2. The clamp ignores all OS-visible controls. Reproduced with:
- thermald stopped;
- MSR RAPL package limits at 200 W / 64 W, MMIO at 24.6 W / 64 W (sane);
- PSys PL1/PL2 raised from firmware defaults 80 W / 0 W to 200/200 W;
- intel-rapl:1/enabled set to 0 during an active episode.
None of these prevent or release the clamp once triggered.

3. The firmware PSys sensor itself misreads. With the machine idle (~5%
load, screen on), intel-rapl:1/energy_uj deltas showed ~48 W "platform
power" -- ~40 W above plausible. After an EC reset (power off, unplug AC,
hold power button 30 s), the same measurement reads 18.6 W -- sane.
With the inflated reading, any sustained boost pushes the firmware's
running average over the 80 W PSys PL1 default, and pcode clamps to min
frequency until the average recovers (~6 min), matching observations.

4. Kernel dependency:
- 6.8.0-134: /sys/class/powercap/ has no psys domain; 90 s all-core
test: healthy thermal throttling, sustained 2.2-2.4 GHz @ 100C,
no clamp.
- 6.17.0-35: psys registered as intel-rapl:1 (parent intel-rapl, MSR
driver); same test clamps to 400 MHz at t~65 s and stays pinned while
temperature falls.
- 6.17.0-35 with blacklist intel_rapl_msr + intel_rapl_tpmi: psys gone;
same test clean (graceful PL1 equilibrium at ~1.4-2 GHz late in the
run, no min-freq pinning). Occasional episodes remained possible until
the EC reset (the EC also reads its sensor autonomously once wedged);
after the EC reset none observed.

5. Reading /sys/class/powercap/intel-rapl:1/constraint_0_max_power_uw hangs
for ~2 minutes on this machine (separate firmware oddity, mentioned for
completeness).

6. Firmware defaults for the PSys domain look bogus: PL1 = 80 W with
PL2 (short_term) = 0 W, enabled = 1.

Workaround in use
-----------------
/etc/modprobe.d/blacklist-rapl-psys.conf:
blacklist intel_rapl_tpmi
install intel_rapl_tpmi /bin/false
blacklist intel_rapl_msr
install intel_rapl_msr /bin/false
Plus a one-time EC reset to clear the wedged sensor state.

Suggested fix
-------------
A DMI-based deny-list entry to skip PSys domain registration on LG 17Z90SP
(and likely sibling 2024 LG Gram models sharing this EC), similar in spirit
to existing PSys quirks. Losing the psys sysfs domain seems a far better
trade than the firmware clamping behavior its registration awakens.

I am happy to test patches, provide further MSR dumps, or run instrumented
kernels on this machine.

Thanks,
Javi
