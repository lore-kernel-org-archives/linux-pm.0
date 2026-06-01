Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA6534753F
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299510; cv=none; b=jQ5Bg3GO9mdbp/BS4q8cvo4PQNePjjDDBNNLvWSPnAmlO+CCFiHlkygdwjER2bTtxieWS1iQtStksd9OGPaGKroN/rRjuhUAMSvLGrP22v08ygq2k1Rl+XoHw8pKsORxa7DqiuJaxXZBAJiUniqQMhfXEhHPKb8+CpMFW7oi3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299510; c=relaxed/simple;
	bh=HQtzW+AzPTHtktemBwgJ1/AqdLD9KikDHuB6vjDahhE=;
	h=MIME-Version:From:To:Cc:Subject:Message-ID:Date:Content-Type; b=P+dk2e7/wUr2RPmXSizUCkMSzWN8DEmeNPEK971qhCFoRgsCmSj6aFj1ZS4BzUxSUwzWsbBaoa7g/z21fm2/1EMZeHqEkGzBlkLu+yhvJ67uHVjZ6IzMgSzFExaW1sDjBzCrnNxpEKx13GD+LdK/MdrVpl2GTMvFj0dWwyxSN3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tC4NdUGg; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tC4NdUGg"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso1679739a91.1
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 00:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780299508; x=1780904308; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:to:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Li7NM+/Fc50bd4rV+8seyueGkphlIKWlChj7iNY/Qss=;
        b=tC4NdUGgN1r8l/jTCwambRe1lYG0KaKVrgIg4sqX5prwmN4wdvISm10mfNXLRGihz0
         9XM2+ilICi59opwXEpasePihheWYyGiXb5hRexjp5Il0BJHCNvCcvjLxAyF8TBjP28We
         rUmXDbJfnxsVp0Bphe+0HOqT4wzkBRlLYuxSvsFkbiTrFRNOgF4tR9svKaIPXxWOf6xF
         8o6UTtbeQ/mhG+1TnxnAVtZY6NgqZn4lJ7FLiIvFl3gu+WF7Bf03yJS34CdiP+CU4BQZ
         U0P2agrOlfx96s5BhizSF/B+FMSmfDZVinhLKXCuMrhZLdaxo2B7otegX3jBMVQX9k7B
         qZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780299508; x=1780904308;
        h=content-transfer-encoding:date:message-id:subject:cc:to:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Li7NM+/Fc50bd4rV+8seyueGkphlIKWlChj7iNY/Qss=;
        b=opcvEYkg2qBlUjhvD45YCOA+tmzsWaZRQxtQXs9Hoz7RlN0ZbNwO23j6h9lMdg+LAt
         Fwqy7/LtqR1m6BUi0PAdEZaot/ukqnUnADX4P25euvbXeumll1hdIPTsiGWZyjVT3R7m
         knbDhatdDZK8RtZdxt18y9Hu262+8m0zvcCg/FtU4GfgNXAPkEDowd0Pn0OQ3Ur3JiY+
         0ap6ykaHgZ1lH5jp+wjygP/Aq1p9nO2g9HlXLMgvBCePfUkVuYrxn1RJN6vMrUIEQtdC
         +JUIx1rIixcGJUI5Jnt7UkZsiYwpbwsNG+W6tlHANfYAoCP3gyR3/zeau1hsS3ukBeef
         3e1g==
X-Forwarded-Encrypted: i=1; AFNElJ8jeuTME4e7FTgEm45m+nYOGNYWbMNjTEj07vdDtkbJys2gwt2CkoLd8SafgIslmPxk820dC2aQng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqcACtSpjiEeT1NpO83RnafjSxn9+tHjBeZdPzLxYZSZiz2ukN
	hfRLU3coHUe4Pkkt3UoHIi67FoL71gwNdtGlb56i3s1EjnrSa0T9lMcFztw/SeJr14pbmg==
X-Gm-Gg: Acq92OF8k8CamHIlYMY9CmPhe4iV/esWbdbqrLJeq/l7ITfQeT8VZvh7fGLLwGideSZ
	9HmJdZ9jZOIb7FGY3xjmMDnabtmCK/DNRNV7VyUiON0SfIgOf588qwTZfkveFskFshsp7OTAeyZ
	GxNyt7QrOabnm0oEGUCSJdJIxENlJOFHpft4VqzDqVxQRA2aaXWBMV4fzci6LsJSYJI16gujwoC
	iBkEGo67/5Msx3rv+ACQVzsPG0uxFLTum+/P/f9ILMji+Gff81ThUttXCYEKzQQPC+KHu4JzOAT
	ZnnmK/7XYAReaXSUsUtHpmi6Hh3LXuBOD/OvhsyLC8Kwi0AfxdC5dUS1cbZ6DJS7i+JWcZrZUlh
	F57VqCP++orVwqTOi8X34eKXdSDkBmMG+3Qbs5hkCUnduTCZWeX5e264O0jpP1khV79zaGrUvQn
	fLjHvZDCQKYFGNPn2uezQvF4t/+yVPUAA+LB4rQBt097l4HIg=
X-Received: by 2002:a17:903:2441:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2bf7b62a302mr102041225ad.9.1780299508211;
        Mon, 01 Jun 2026 00:38:28 -0700 (PDT)
Received: from GordonMsi ([240e:39e:4b6:6d00:7d23:c974:a73d:af3c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a21f0bsm90285415ad.34.2026.06.01.00.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 00:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Gordon Chen" <chengordon326@gmail.com>
To: "Mario Limonciello" <mario.limonciello@amd.com>, 
	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>, 
	"Mathias Nyman" <mathias.nyman@intel.com>
Cc: <linux-usb@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, 
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: USB-audio isochronous Missed Service Errors on AMD Zen5 client (Fire
	 Range) -- Data Fabric idle C-state? No OS-level knob found
Message-ID: <18b4e4f7089aa4f1.da8dbe994ae3bb77.445e21b98b0b205b@GordonMsi>
Date: Mon, 1 Jun 2026 07:38:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Mario, Shyam, Mathias,

I'm reporting what looks like an interaction between AMD client SoC idle
power management (Data Fabric / SOCCLK) and low-latency isochronous USB
DMA, on a Ryzen 9 9955HX3D (Fire Range, Zen5) laptop. It reproduces on any
AMD Zen4/5 client I or others have tried, with any USB audio interface;
there is an open community bug with several different-vendor devices [1].

I have a strong differential pointing below the OS, but no way to read DF
C-state residency on this platform to confirm -- hence this mail. Questions
are at the end.

Symptom
-------
USB audio playback has frequent audible clicks, and after ~10-30 min of
continuous playback an occasional full stall. Each click maps 1:1 (time-
aligned) to a short isochronous OUT URB; at the packet level these are
iso_frame_desc[i].status = -EXDEV (COMP_MISSED_SERVICE_ERROR) -- the xHCI
controller missed servicing a 125 us microframe. urb->error_count stays 0
and nothing reaches dmesg; you have to look at per-packet status or count
short OUT URBs. The stall is the same fault at its extreme: on an implicit-
feedback device, a whole errored capture URB starves the OUT ring until
re-plug.

What I tried (all ineffective except the last)
----------------------------------------------
  cpu_dma_latency = 0 (PM QoS, verified locked)        no change
  cpuidle: all C-states disabled                       no change
  cpufreq governor = performance                       no change
  amdgpu power_dpm_force_performance_level = high       no change
  stress-ng --cpu 16 (pure compute, little mem traffic) no change
  stress-ng --stream  (sustained memory bandwidth)     misses -> 0

So CPU residency/frequency is not the lever; sustained memory-controller
traffic is. Reading SoC clock DPM (amdgpu pp_dpm_socclk / pp_dpm_mclk):
idle and under --cpu it sits at socclk 400 MHz / mclk 1600 MHz; under
--stream it jumps to socclk 1200 / mclk 2800.

This points away from clock frequency as the lever: a single --stream
worker already pins socclk=1200 / mclk=2800, yet the misses persist; it
takes several workers of continuous traffic before they drop to zero. So
what tracks the fix is not the clock the SoC reaches, but the amount of
sustained memory-controller traffic. My working hypothesis is that the
Data Fabric idles into a low-power state between the sparse isochronous
transactions, and that the wake/traversal latency on the next microframe
can then exceed the 125 us deadline -- with only traffic dense enough to
keep the fabric out of that state avoiding it. I cannot confirm that from
the OS (I have no way to read DF C-state residency here), so I would
welcome a sanity check on the mechanism; the measurements above are what
I am confident of.

I could not reach this from the OS: profile_peak / force=high do not raise
socclk (ignored for an otherwise-idle iGPU), and a manual pp_dpm_socclk /
pp_dpm_mclk write is rejected with -EINVAL. The BIOS on this laptop exposes
no "DF C-States" / "Power Supply Idle Control" option.

Reproducer
----------
Any AMD Zen4/5 client + any USB audio interface, playing continuously:

  # count short OUT URBs (= missed-service events); nominal is the device's
  # full OUT packet size (768 bytes for the Flow 8 at 48 kHz / 4 ch)
  bpftrace -e 'kprobe:snd_complete_urb {
    $u = (struct urb *)arg0;
    if ((($u->pipe >> 7) & 1) == 0 && $u->actual_length < 768) { @miss++; }
  }'

  # while watching: cat /sys/class/drm/cardN/device/pp_dpm_socclk
  # baseline:           misses > 0,  socclk pinned at 400 MHz
  # with stress-ng --stream 4 running:  misses 0,  socclk 1200 MHz

Questions
---------
 1. Is this a known interaction between DF idle power state (DF C-states /
    SOCCLK gating) and latency-sensitive isochronous DMA on client SoCs --
    an erratum or documented behaviour?

 2. Is there a supported way to hold the Data Fabric out of its deep idle
    state (or set a fabric-active floor) while a latency-sensitive iso USB
    endpoint is streaming -- a kernel interface (amd_pmc / amd_node?), or a
    firmware/PMFW setting -- short of burning memory bandwidth?

 3. If not, what telemetry would help characterize this (amd_pmc STB dump?
    specific SMN / DF P-state or C-state registers? a debugfs)? I'm happy
    to build an instrumented kernel and test patches.

Related: the extreme stall case (whole-URB error on the implicitly-fed OUT
ring) is separately handled in snd-usb-audio by a Flow 8 quirk that emits
silence instead of hanging (commit a23812004228). That only papers over the
hang and does nothing about the clicks, which are the subject here.

System: Ryzen 9 9955HX3D (Fire Range, Zen5, 16C/32T), AMD xHCI, iGPU
smu_v13_0_0 (0x13c0); kernel 7.0.10 (CachyOS, close to mainline for
usb / xhci / amd power-management).

Thanks,
Gordon Chen

[1] https://github.com/CachyOS/linux-cachyos/issues/665
