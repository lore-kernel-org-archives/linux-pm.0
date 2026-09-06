Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519831F985
	for <linux-pm@vger.kernel.org>; Sun,  6 Sep 2026 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788712669; cv=none; b=RJliCxMaUkBrjvwRmy0o+OtDRHEGEUaFbeGn1KsM/Wq6RRZF2dbwlSNl1U7Nd3W/O8w2TC+LA2wlNgNrNpXaHZeyMzS4iFyS0QT+Oq5PC6KEXriJaW5hqwNP0n2Ov/BaqMKASAIwmNl5y9awMUBH0fe4p+YS8W2Gb8GOKwoyWZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788712669; c=relaxed/simple;
	bh=ya+LlWyHt4+HI4LvLhLTcPHQzAe6hbPkzc8Cc9HoXcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozkCuEDLCqsNRdVpw2DDVnkO0ePu8mtrsHkc9Ze8z6vLvG8CAm9xq7ZRgfxl/YObAjHUMaGe1jAuSjMrn9IlDgn1LK1VrPlcY+uYwWVP5x5PhsFZwaDCNGJz67E9a85dIgWShxGGnHb+QZQDJ6edpxZ8q6FOxDNDzEb4/+PCFoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlecbwRF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlecbwRF"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so37435635e9.3
        for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2026 09:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788712665; x=1789317465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ivyLPO2HZhtqk7cqP+57Dc0UEnfX7FjCnb9LTUCpQ7M=;
        b=AlecbwRFJE5WwIMz3VNFGuaXnszg2YJHMEd6WOCpehmD3MUB4mi2T2XA/34sQPqAX+
         EWf8XHb2u8dPlz7DnHw5kdGx4EaL5m44Se8BS0wd++M/G4ILQJTROCdHb1mOg5LccyHr
         HKXQNGdx33QHJD7H02yxUNSOwkpB4GQNECxvP2XxkGZWHlsCKA/5iCDvdMFwEMEWHyvY
         LPtww+kbDnrJ/m7tnAxVO1eUjynCZTXImIlbcK/QMhoZkKL2P35h3j446LKixEHpyaKh
         Ke5s0g6ZT5YSS1qHWNWUXm5gxz4HqLNHJ6RCRVvFvjJ4vATJvu7OVgstoggciiZNGZHq
         UrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788712665; x=1789317465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ivyLPO2HZhtqk7cqP+57Dc0UEnfX7FjCnb9LTUCpQ7M=;
        b=OdKx0vDC+EfuYMbGjpcIyqwj6nHPUekjZufsXqEWwzsNgMCg9AFcqwpXHeNLqszqoy
         lVNL2fdmhTU/IhCIOS3oM5zPzDo+DW4xpK6AMvZV1yg9fKsQ22IVvDwfbwCRXUZiwcyM
         /Cw/mfF0Emb0LsyRuTzVGF3vQGEUQQ9W3RcR/IT0SFEahjzJ803XRslF763cA3ZWLdO0
         iQ1AenRi3EX2g5Oh35tLIhvMbzyNzBZE26MjLrC/arMc9DCFOQyX8zH5fT4K9svQqjij
         hUFsCFHdWlVMx5d3h7Uo847lLZEhRVUPqGFGp27MbiJ2qhHVcU0bKdUBkH5v6izhfQvc
         lZLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQoMfJaPeVlIkCInB6RG8wiPfWtYesAusZaX4OoaI4Y6sE521fZ8qHAwMjRmKaxxMmlCKT6LFwTg==@vger.kernel.org
X-Gm-Message-State: AFuF++nO4ywmZ8zF/C9SHHLnP21TPQquyHtrXFK7cZBYGKhv8cIVL0cT
	wTRF0jcGEzvCqA+3p+H+w+OGIOc25yU8EcPZ1XA4pcwxFNiTQPcI6H33
X-Gm-Gg: AYBFou0gGkpD0fk+/BpUZkPdYTOww9jduP5F4jvjKijRMGupUnPdmbq0LnNeAaFn7Gb
	29uoRKEq/8mrsOFbuxE9FLZwf63itZMQpLVVZBqHce6FTQxbnQvXXvJJ3S5Slc7qawkZyUjKSp1
	Ih1+W5N5+LvzJOGOg9T0d5ZyTGNa5RnhEMc55N0RthOPVReGnLkU8UwL1xWJojVydERVbS7Ikp6
	mKuC95cJUkEX30N2DAlhrCh1qfe1be3nNZK4hJseZQxLUJgHsevlEH11xP+9SR1e8ppNOJver1H
	XYoE+mv+kX5/VtSkYv+uG8mY8+zwZP0mW8Z1iqOJLhwpLqGUnMg96B0EhztNeI7FNypwlz36ggB
	d/6SzSDDwakLfvP9IZnxoCHFoFbhL3+08M3H1ViLYuDyCnBLTjwiFAWhis5PJa1EwiLmK/WzNNE
	V0wM/6gl+pzfxIqdo2f+BCjs+MhAxtxGHSAMrBVLEJrck9hMimgpRSlw9niFpZ53cx1GePgemIM
	cW4MkfSebUczSWlC7sDF1Ful40=
X-Received: by 2002:a05:600c:4e8f:b0:49d:4ef:bf70 with SMTP id 5b1f17b1804b1-49d04efc043mr96329235e9.10.1788712664882;
        Sun, 06 Sep 2026 09:37:44 -0700 (PDT)
Received: from localhost.localdomain (mob-5-93-26-136.net.vodafone.it. [5.93.26.136])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-485885c5bbdsm20907997f8f.36.2026.09.06.09.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 09:37:44 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 0/2] arm64/cpufreq: report and track frequencies above 4.19 GHz
Date: Sun,  6 Sep 2026 18:37:13 +0200
Message-ID: <cover.1788712186.git.okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Snapdragon X2 Elite (Glymur) is the first arm64 laptop part I have
seen whose boost OPP, 4723200 kHz, sits above 4194304 kHz.  Two
independent problems become visible there, both of which make the
kernel believe a boosted CPU is running slower than it is.

Patch 1 fixes an overflow in arch_freq_get_on_cpu(): the u64 product of
the frequency scale and the reference frequency is truncated to
unsigned int before being shifted back down, which wraps for any
reference frequency above 2^32 / SCHED_CAPACITY_SCALE = 4194304 kHz.

Patch 2 makes capacity_freq_ref follow the boost state.  It is latched
once on CPUFREQ_CREATE_POLICY, and boost frequencies are excluded from
policy->cpuinfo.max_freq while boost is off, so on a machine that boots
with boost disabled it keeps the sustained maximum forever.  On arm64
that saturates the AMU frequency scale at SCHED_CAPACITY_SCALE, so the
scheduler cannot distinguish a boosted CPU from one at the sustained
maximum, and arch_freq_get_on_cpu() cannot report above it.

The order matters: patch 2 is what raises capacity_freq_ref past
4194304 kHz on this machine, so patch 1 has to land with or before it.

Measured on a Lenovo Yoga Slim 7x Gen 11 (Glymur, 4032000 kHz
sustained, 4723200 kHz boost), pinning a policy to a single OPP and
timing a fixed workload on one of its CPUs:

  requested OPP    time     cpuinfo_avg_freq
  ---------------------------------------------------------
  4032000 kHz      2.011s   4031325   (0.02% low)
  4723200 kHz      1.726s    524283   before
  4723200 kHz      1.726s   4032000   with patch 1 only
  4723200 kHz      1.726s   4718587   with both  (0.10% low)

The timings never change: 2.011 / 1.726 = 1.165 against a frequency
ratio of 4723200 / 4032000 = 1.171, so the hardware was running at the
requested frequency throughout.  Only the kernel's view of it was wrong.

Note that cpuinfo_cur_freq still reports 4032000 kHz at the boost OPP
on this machine.  That is a separate path -- scmi_dvfs_freq_get()
asking firmware for the current performance level -- with no clamp in
the kernel, and it is not addressed here.

Oleg Keri (2):
  arm64: topology: fix arch_freq_get_on_cpu() overflow above 4.19 GHz
  cpufreq: update capacity_freq_ref when the boost state changes

 arch/arm/include/asm/topology.h   |  1 +
 arch/arm64/include/asm/topology.h |  1 +
 arch/arm64/kernel/topology.c      |  5 +++--
 arch/riscv/include/asm/topology.h |  1 +
 drivers/base/arch_topology.c      | 19 +++++++++++++------
 drivers/cpufreq/cpufreq.c         |  2 ++
 include/linux/arch_topology.h     |  1 +
 include/linux/cpufreq.h           |  7 +++++++
 8 files changed, 29 insertions(+), 8 deletions(-)

base-commit: 9d80aa4617b32f5054c5aa471d06b66704854935
-- 
2.55.0

