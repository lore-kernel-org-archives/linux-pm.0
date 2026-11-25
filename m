Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795598685;
	b=rO7wn9DCYB0xv6053lxG0LDvbKy55wWqJZA8h2690zktUCB3/T559kVOm8lmbZqJ/yRo
	 /4/QW/dreoVkuT8yhwTy9WIk8Y1DUIntPTBFlMgBGAn8C0faHouRqRsPFdc27jCQfdPPx
	 wwcH5pe6ZczFuCsVqpMacD1vem4qMPvujbO0ARTeHqdHmgkozQtx6wY05tJB+irooCISz
	 YvRtBX8mcLyWqPkTlUBONRQF+9bb0P35L7kPl2ZhAAAi+CGA3yJnK0d+ZYy4qSLIb84Un
	 RaC63dPCVqXLR3p5fhPUMMYuXb8qFV2ZHcpGYjtWtkcKtmPVia527jtbBW8f9sWbwnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=LoUqXSMbdzfiCID2GLThVhw132KJLt9huSg+e/LMgag=;
	b=ka+52CD8pvI4Lc9y1QsZB83Hz88RxJTU4dW3hvMDJonC7SvZNfEdV0JDPwD+bCUfAgKq
	 EJhaODykYL8BcEQb54JYxsf1H+2czU9szfqfzYa7uCoECCSKtbM+EQ4Z5i719sqIQjwZZ
	 lNfWbNwKYeDOhTX+Q74T+wca+FbPIQ/UXiyaP/zhR0yPFmX0b/fTrxNmhVXMJHIoxCBqq
	 j2AKSN+/MSpA25ZqZjrBG5+0a98f7j/ODaBknMiImP/iEsYDVUjtnTYwui+oqCCrbqA6W
	 XgnRZVDhgJCCmAAR+IUSLmw89dqG+ky5KNVhqGYeJyC0hGJ3mBmmlaZU5pIGinPkeqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qCkJlMQj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F283606A33B
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 09:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F283606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qCkJlMQj
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3acef9307c7so43811121fa.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 01:24:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795598683; cv=none;
        d=google.com; s=arc-20260327;
        b=IAPG0H5gt9tlaTrwEre462/9YOALQH0kvHcXIwx0uFpy8bDyPv9NinErEgZQ2/5ZEz
         rLnQdTxjWTnIAlS471FtxA08d56MnL6IsUWjAy+WPLXFQtZHPcpBIKywCEmwr3NSkhfD
         Hx6I890yfT4JvCqMGkdhM/2N7gV9bGQ/ENPt/Ugghp93CdjuNyOgIQ3s8QHzaV/OEIhU
         e29grL3UxjkTtpimeEkSkYbyGrptkqVt3OR33PlabfSU4EJVWlN2vDsNFPqUqtnVhGDM
         9jDJ8Wk8MQ58Vd90FJQfZXzEWpWsFQQp7uQwqc+kuyG+j5PbOYR3//Ua5Sl0bOU2PO1r
         Npag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=LoUqXSMbdzfiCID2GLThVhw132KJLt9huSg+e/LMgag=;
        fh=HUZj+X3gty+cqtD3+runmZz3VOPGWM/JTH3+D/aHQn0=;
        b=ourke5SRlb1YGow5aHPx3tdSoURnWTEDXoxw9QJ1BMZEG2gfFjoRFIQ6RqT/XA2mE+
         4ZRk+mk9hNezVuIuxHGJ+hAxmW0WsYtCtLBmRi7cBQvW2aY6ESFrNtqJWEMBJy4ZFGfQ
         BigXpX0dXrDn/g9WAS2xjiQwC5WpCn9RdOtCqq58rkwfnmrhn07QmeeNJwGBfFPNMZ3F
         lUrGNKglDoPE54jex2ToEF8sRzQC27Hkw1qnspOFY9Ha1F9KDA0TXAWlygcMOr8PEE2e
         lTd3g/ZQDzQEBhJx3rL1oMEhT/i3f/haFdPXCnA+F7NZVQFxR3+tRkHPtS7qAFNHSNir
         K7/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795598683; x=1796203483; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LoUqXSMbdzfiCID2GLThVhw132KJLt9huSg+e/LMgag=;
        b=qCkJlMQjsRmoQ/WWXS+fWVgBpLmg0ubGdxJV/jFJEDLuza/6J4hrKHYJAft6I0IbsZ
         AQHkRfBVY34ST9BBzxuQZ2WBGFoandD4oMZYyZ9fxHnBk3a2GLgxm9P3jU2bi6uCqM1L
         EgO4aWCktsCnI7uEmEWCULgYw+MoY6qIU+tHlq1shyR7IDdDyOBV9G1Qgi02WZVBfZUJ
         UxfRirBjClTslgYuOLmnvVBl0Yn+WFxsjqP81NVtIQtYv/ls4mQ98FeCzTp0o9whxORV
         Mdb0kCFRkUx2bN6tAZhCl5YwPJZeHmaAN+EM3QOwLRvXrdXwbsqwqtS2hlD29oQJvJFB
         lVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795598683; x=1796203483;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LoUqXSMbdzfiCID2GLThVhw132KJLt9huSg+e/LMgag=;
        b=wXI/SZi402Sk21jJORFGPs8dtVomYzZiO+gsFEi6tk8fp/ZBzPonuY65f6eBgR+Ilr
         42QvnG/jQa/wOmyLwoRe2SwyGmPkK6Bq7HI3axdgr5nj9nPwLIS13HbHEXbu87RX/Obj
         s3euisisYWrJCTVSHdLVhPs6PhYuZAnR21Zp8lCRg5/Oy1JBr4vWpZxyExqUMLUI0gAn
         +faagp8a/yeSFEt+AZIIbXYmdWXiLuNTkW/rHfIcBJafyqZYy9Ied6OuZGfS9qAPKgOo
         5Xo7BWhmoLQI0d8Rr+cW2jdJSIXtB6RG6FbaHYAfl7WJ8x1Q+PoZ+g+Z3jpmqe45yDlV
         FVqQ==
X-Forwarded-Encrypted: i=1; AL+hErH99+IfCmPkQXbShACzVxsJmIV3JpQu3O0DrfzXQhAOiE2MllHd7EVIh0pJ8jZ55oVoIBgWVtradQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9HjeV5bsnYgFPtG47qKYsTS086NokytOXboN8LmGkOb774vIzp
	O1Jeo3coiAVJt4nlL8rya6GWottDeDD58uYW5+W/a/JmjgCMvCe80OQIcn3TVANF7HC8rj9HVPs
	shAiekXZz2NxztOGLR7eszc3HbHVS6ek=
X-Gm-Gg: AZFdTZePt0GWrKl9rLFwEv2QIsehLBNWyBKxKuYOfLBnbVYx3YZJ6tCvLQ4ONBs+9J2
	Yjy5aTfiHKbF4neLkD+M77BN0OxVqyav6W224QTT0JBEtPEie12ziLst/aUMNOISs2s8/W//Zze
	KKYJsLDYfIZJDItfh9W6EXQCHrASsLZs/TcKBvhf+7ePMAUgIztxhxOjQUClfyugsrx0Gz1Eww8
	5WpnVi6jBeTtnzp9Fj/5KB/7uNDOsuZFv2bzmQdjb1H123voLzsrY8wUDTl4TZlEX7Bl2zN5czU
	uvCgIyRw0rhnOb/jK4uXY703t5Y/lmnXStGZ6PIgMSAVfJcSU52Xt1UR/nysSNGAJ8PaJiVgKFQ
	/Bofo8KomE8rnWUoceNd2ANiIqyOtnsBTfwvO0E57jFMn46bbk5CVngMNEdvyr4FGEmgk
X-Received: by 2002:a05:651c:1585:b0:3ac:ff0a:9d85 with SMTP id
 38308e7fff4ca-3ae7f9b2233mr51182081fa.7.1795598683266; Wed, 25 Nov 2026
 01:24:43 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Jun Cheol Gim <dialogbox@gmail.com>
Date: Wed, 25 Nov 2026 18:24:31 +0900
X-Gm-Features: Aa3M54qT9tnmZcrxybXqvrlGXEWwLRvn7QmQG1FspTFq6CZWWSzhu5tBjdUlIuw
Message-ID: <CANb8v8EGmQf90hRvr8cE3vTKOOY8b6LTxki1uORW_TJ9HadrZw@mail.gmail.com>
Subject: [REGRESSION] Lunar Lake: s2idle randomly misses S0ix when PCH xHCI
 (8086:a87d) is runtime-suspended; much worse since 7.3
To: Mathias Nyman <mathias.nyman@intel.com>, Xi Pardee <xi.pardee@linux.intel.com>
Cc: linux-usb@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

On a Lenovo ThinkPad T14s Gen 6 (Core Ultra 5 228V, Lunar Lake),
s2idle sometimes resumes normally but never reached S0ix: last_hw_sleep
is 0 and the package stays in PC2 for the whole sleep (about 1.7 W
instead of 0.25 W). Since 7.3 this got much more frequent. Full details,
acpidump and logs: https://bugzilla.kernel.org/show_bug.cgi?id=222281

I narrowed it down. If the PCH xHCI controller at 00:14.0 (8086:a87d)
is runtime-suspended (D3hot) when the system suspends, the platform
fails to reach S0ix at random. If it is kept in D0 (power/control=on),
the failures almost go away, on both 7.0 and 7.4-rc4. That is why a
live USB system with a USB stick plugged in never failed (280/280).

Test loop: battery, no external USB devices, screen off, then
rtcwake -m mem -s 8 repeatedly. A cycle counts as OK if the S0i2.2
residency increased. "instr" means pm_debug_messages=1 plus an Intel
PMT telemetry dump around every cycle. That changes the success rate
by itself, so runs are only compared at the same instrumentation
setting.

  kernel               xHCI 00:14.0          instr  OK / total
  -------------------  --------------------  -----  ---------------
  7.0.0-44 (Ubuntu)    auto (D3hot, default) no     112 / 130 (86%)
  7.0.0-44 (Ubuntu)    on   (D0)             no      99 / 100
  v7.4-rc4             auto (D3hot, default) no       5 / 30  (17%)
  v7.4-rc4             on   (D0)             no      95 / 100
  7.0.0-44, same boot  auto                  yes     45 / 100
  7.0.0-44, same boot  on                    yes     96 / 100

- on vs auto: Fisher p = 1e-12 (7.0, same boot) and 1e-13 (7.4-rc4).
- With xHCI on, 7.0 and 7.4-rc4 cannot be told apart (99% vs 95%,
  p = 0.21).
- Caveat on the regression range: mainline v7.0 built with my config
  (Ubuntu config plus localmodconfig, checked that all loaded modules
  were built) reached only 15/30 with xHCI at "auto". So the clearly
  good kernel is Ubuntu's 7.0.0-44 (v7.0.14 plus Ubuntu patches), not
  plain v7.0. I have not tested v7.0 with xHCI on.

Failed cycles, according to Intel PMT (LNL aggregators 0x3072105 /
0x3072005, decoded with the public Intel-PMT XML):
- PREVENT_PKGC6_CHIPSET_1 and _2 count for the whole sleep (about 8300
  of 8300 ms). In OK cycles they count 40-75 ms.
- The package sits in PC2 and never enters PC10. GT RC6, media C6,
  core C6 and memory self-refresh look normal.
- In the unnamed regions telem5 (GUID 0x12057328) and telem6
  (0x11646436), most counters do not move at all during a failed sleep.
- The few failures left with xHCI on have the same signature.
- pm_debug_messages shows no "Constraint not met" over several hundred
  cycles. The LPS0 _DSM calls always succeed, and the RTC is the only
  wake source.
- Nothing read before suspend predicts the outcome. I checked every
  32-bit field of all 9 PMT regions and the PMC live status.
  Consecutive cycles are independent.
- Real lid-close sleeps behave the same way. An 82 min failed sleep was
  blocked by CHIPSET_1/2 for about 4960 s; a 105 min good sleep was
  100% PC10.

Workaround in use (one udev rule, split with backslashes):
  ACTION=="add|bind|change", SUBSYSTEM=="pci", \
    ATTR{vendor}=="0x8086", ATTR{device}=="0xa87d", \
    ATTR{power/control}="on"
During suspend I see no cost: OK cycles with on and auto use the same
package and Psys energy. I have not measured the idle cost while the
system is awake.

Questions:
1. Is there a known LNL issue when the PCH xHCI enters system suspend
   while already runtime-suspended (direct_complete or similar), as
   opposed to from D0? Should xhci-pci resume it before s2idle on this
   platform?
2. What do "Chipset 1" and "Chipset 2" in PREVENT_PKGC6_CHIPSET_* cover
   on LNL? Can the telem5 and telem6 data narrow down which IP keeps the
   package out of PC6? Raw per-cycle dumps are attached to the bugzilla
   entry (xhci-pmt-data.tar.gz).
3. I can bisect v7.0..v7.3 with xHCI left at "auto" if that is useful.
   Each step needs about 100 cycles (about 30 minutes) to separate the
   success rates reliably.

System: BIOS N4IET31W 1.17 (latest), EC 1.12, microcode 0x128,
Kubuntu 26.04, KDE Wayland. The cmdline also has no_console_suspend
(removing it at runtime did not help).

#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=222281

Thanks,
Jason Kim
