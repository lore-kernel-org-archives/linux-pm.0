Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117916;
	b=5XNVIYt+RueBpLqFyADXXNYGm1pFbLTGhGfDj+033QT/6B4hXHldfTaRU6pFn+YHmS0g
	 MKiU3wPlDVdDk/sBExBMgS59ElmF7e1L7vL7FrxQJjy1wnIRobS0t+GHmgU+FxrLTA0Kh
	 vVCllO8jqoxCaJ4hTmFSxg0Izbc5yolDPwhKfLYh0pWJBl+3l5mQqZzJ9Y5kZK80LGNzc
	 4vioWR3oz7TQqpY9BAUFGobuGnnjX6k0beNqpai4z9HV+ID+53s3Smd8wqdwotU2GtUy/
	 c5fpkudBIK4gtKfedZroGH8qkvFeWTs6tSlrvURat23yiBvEwk6gvdtxAHOx7iJ6Icw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117916;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Rku257EMP0Kw7Zzq4Y1IYeIah4zhlIvCN84RNHMBPhU=;
	b=hFmVsheWZwIl6Q79axXO7Mj9jdfLueEgMWuYc+0dmXWQ7CrOkJVqlBVDg43PvkHHhJBH
	 IsnVfSIDbb9YlesW/ibvrKq30978Hnirq5sG8MHPDWu3D11j5UkRU+42eobCA1DpGThM3
	 ozeF+6uTENom6zJUNOVnZ+g4RE8e9tXvd/ellzC0nB8+y4mcZremGRDSh+unPVMO/VblG
	 9kOMSs85SsQS/ZNQwRPv/RVA+ETxMIWNMd4VPQK9Dm2/gx9bvf/8av/7TsRYhKnFo9J+p
	 MOad1aGn8Z0pO3KAtfaHQTvZA1tUeFivvJyNdoSM5+NLbb7k9Pf219PMkeTyc8f4t2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ymqk3fBW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89345606A326
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ymqk3fBW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F291F000C7
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 19:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117916;
	bh=Rku257EMP0Kw7Zzq4Y1IYeIah4zhlIvCN84RNHMBPhU=;
	h=From:Date:Subject:To:Cc;
	b=Ymqk3fBWdho2V4rJCKy9EPUwfmVwKqBPgww826LWHCaUIZgtHf1I5v6SE55+0Yaf5
	 7918tCD26QcxrFJvROMVQrQpNqa2mhKD1RPUwkApN3/qCUXu1J5AjJd3TbEs828sGS
	 vBubMWvWS0XSBQurHu/nEziYTuDSi5TN0uaDRFmCK2fsvCF9gwhIbzXkCdA6oZmjb8
	 cD4/PNs6zkb9guAvChyG9uXmAf/YyZe9qTsAU1+GaGF4IuaCdwNlLAHu7QF7WKo7rq
	 YUkZq6kvk9r+eB7n1vbTjq1566yF/gQKA4D68rycyNns1Qdwog70WAheZ+kACm4+x8
	 OMOu2tsE0jxKw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3ab4354db11so724491fa.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 11:51:56 -0800 (PST)
X-Gm-Message-State: APuU4Z/1gCN9kTVexKN/nzIXIAG7f+veUovMIGF/TK585l54qwfcnT5y
	cCyN8kvapRN5aOUqPWK6H1cF5zmq+Y6PfX0mOZpv4YcENigebGW1e9o0Zjzd6pjBdcP1EfxS9A5
	u3AUTGdIiC1cFzlBa4Ustgade60amZmI=
X-Received: by 2002:a05:651c:4217:b0:3ac:45df:83d0 with SMTP id
 38308e7fff4ca-3ae7f8d4893mr3155131fa.2.1795117914583; Thu, 19 Nov 2026
 11:51:54 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 19 Nov 2026 20:51:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0izRYXCE-EMaA+Q80q2EitZbQ7BGN383mnXR19cx77CWg@mail.gmail.com>
X-Gm-Features: AclHuK_YH15zGCeRDGFT3855GXj-0XY8BBAk-AQrngHDj6JcZLmYXA848Z1jZfE
Message-ID: <CAJZ5v0izRYXCE-EMaA+Q80q2EitZbQ7BGN383mnXR19cx77CWg@mail.gmail.com>
Subject: [GIT PULL] Power management and ACPI support fixes for 7.4-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.4-rc4

with top-most commit d40cb8a12ed25789f39404c5f7968a65e98d89c3

 Merge branches 'acpi-cppc-fixes' and 'pm-cpufreq-fixes'

on top of commit aebb7274476403040d582c61478df8f4a7bf9cd3

 Linux 7.4-rc3

to receive power management and ACPI support fixes for 7.4-rc1.

These fix two recent regressions related to power management, one in
the ACPI CPPC library (affects the CPPC interface in sysfs and the
intel_pstate driver), and one in the ACPI device PM core code (affects
platforms with shared ACPI power resources assigned to devices reported
as "not present" by firmware), another ACPI CPPC library issue and two
cpufreq issues, one in the core and one in the CPPC cpufreq driver:

 - Avoid initializing power management for absent devices in the core
   ACPI PM code to unbreak power management on platforms where an ACPI
   shared power resource is assigned to a device reported by the
   platform firmware as absent (Rafael Wysocki)

 - Drop compliance checks involving nominal performance from the ACPI
   CPPC library to unbreak the CPPC sysfs interface and the intel_pstate
   driver on some Intel platforms after a recent change that added those
   checks (Rafael Wysocki)

 - Make the ACPI CPPC library reject EPP registers that are too small to
   store all of the possible EPP values (Christian Loehle)

 - Make cpufreq_driver_target() skip inactive policies to avoid a NULL
   pointer dereference on a frequency table access attempt (Zhongqiu Han)

 - Set the CPPC Enable register in cpu_init() in the CPPC cpufreq driver
   to enable CPPC on platforms that wait for the OS to enable it (Sumit
   Gupta)

Thanks!


---------------

Christian Loehle (1):
      ACPI: CPPC: Reject EPP registers narrower than 8 bits

Rafael J. Wysocki (2):
      ACPI: CPPC: Drop compliance checks involving nominal performance
      ACPI: PM: Avoid initializing power management for absent devices

Sumit Gupta (1):
      cpufreq: CPPC: Set CPPC Enable register in cpu_init()

Zhongqiu Han (1):
      cpufreq: Skip inactive policies in cpufreq_driver_target()

---------------

 drivers/acpi/cppc_acpi.c       | 13 +++++++++++--
 drivers/acpi/device_pm.c       | 15 +++++++++++++--
 drivers/acpi/glue.c            |  8 ++------
 drivers/cpufreq/cppc_cpufreq.c | 14 +++++++++++++-
 drivers/cpufreq/cpufreq.c      |  8 ++++++++
 5 files changed, 47 insertions(+), 11 deletions(-)
