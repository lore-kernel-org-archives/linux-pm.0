Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459BA34405B
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210824; cv=none; b=oqO/eoxPstLQD4KHvnLO6lX2fqQY2aUJL5zYHf9hL6ipTrdlUolI+rYhwyL8UbfS+FDdecQBQ/TMACJJjcwaYCLBptgFOcemJsyXv4rw2GLUAjnLj0Iqf2mCRpCeoX0LkYTOi2gDJ+gEo2+KIHhXbYIV3CAADmkW2SskM4QhvmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210824; c=relaxed/simple;
	bh=NR2CEXh5xK+e/ztpAa8u9zBNYtPorW9X4Su5E/3Lo/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aD6O3QMToMLRLj6ttaauChK5yNNDKsZegQAEZin7/mUqEqseAIkBYTyQVn2vjB7p2jMDLXDqBrmmkfOwv/WZiitSOwBru2r03Ckcw3GBs6Tcdla3jr6SYcBNKsx+lUjfa8UvDsPCcjGNgIakOWB4MbULF1L+U3BNmCKjBIvtiJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9fHhwcP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9fHhwcP"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so170851f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 13:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781210822; x=1781815622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pW+GxXD2e5Kt5fo5tuNrCY+vGMI61nj1uaki4VCcPjg=;
        b=N9fHhwcPiuXQKoygv3SzCI++j3zSbplXjf6mK8ASw6D7IWA9ndIXVNAVRQICLu4Nbj
         YQdXkFxVVO6HQEK3A+gsAj3cBv1w4H2HtE7rrrgxyq8RJSVo8a3dv09+wVgAKd7RGz/W
         Ok7PQbSaQf1vR1r3LhQ6EW1S2YFBW9Z9RYPBFZR3dvZVwXfFP8tlvpak9uCDZXQFMMLR
         1j5Z58V2ou1Wcuo3/fSxrR5tXExNC6OSB7JULAgnIeXM9iF+jjdpu4ulFaoBy1VqPz3H
         x7Jh4L0LhAoKn9QH3yoPnj3+wnsB1EupH0PAcP2q9gzJNQFb5OISV1JpZL+D5b55lonL
         SXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210822; x=1781815622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW+GxXD2e5Kt5fo5tuNrCY+vGMI61nj1uaki4VCcPjg=;
        b=hOnh7DiYkewPrlLZi3+pYtodwM8VNqG7htgc1YKhwpGnwDdvUU6UZtQG951PrZgmto
         I2G/2RPRiW8m5Kiqkycxr/dEclyTmdO4Xz3RhVwVG2n2mMx5Ml1QFPcURhMgvHd/hHk6
         LZSgwDxtmK6h4uR4f+knSxoCdzTa8zhOzm6KiWqS4l11Nh5M/MU9aKYPkW48gI588uUG
         c6ZxyINBfEm0N0IrJey5VS0SGWpy028Ql0L7yrhB/KnaQxliymUxVDPtNFKwEpAuwhwl
         BdewqXDFU/FJls1T73ljmnb1iX6ng4tKUzkDDhZbUTHZrMBEv+sxu2MzpDJg4U1ddnsM
         3H6Q==
X-Gm-Message-State: AOJu0YwCnmfqP074Zws3/fElMdBN0JmmuN4dlYx4Gzu1h3RGcfcYkBq0
	k8SCjRhC54bbWwoZnthITB64I9N8afDJePTATCdofnf3RsmKOj1/BhLCnFOTdYZU
X-Gm-Gg: Acq92OHmOuoIyLVch6kWxS+zMXAo3dGe4DczaKazT7CgWede4EIysIgl16JVlW8cVjA
	LVsfMvMTIMC9rYk31eRl7JOUgF3YmqjxdbbRr6+z6QXyofGU/cTq3Q0hQAgWB7u2oj2vycW4DX/
	hCqKVm05eBvsoQv5sss8rbj82EmoXAgCBZ1sEbdkfUVhxxctFrIROc/pOcBmmRjbFA/rXPnNMSh
	bcnkt+SPjFeKDGuSTJhHSGlJ8jNmb2JSfxERy6Lh5fY1N1PgXIjXJdwlDLRbLwAiGNxvnMp7vkm
	vexN7uul7RA9k5T5qqTxeTvs3Rlw5psG9AaX0N4nN0UAXf3TCzXoKTaedoiZnqnKe6BAHVxwvtJ
	38KbiVzMcu6cy9uVuUcpdNakevfxnnJBSy14/vAcsS0QzY0r8zjxcAjXkfwKwwFmB20kC6jIv2S
	k1DDQ4YneIUhWWOX3eicAVS2BbWYFEI4AhsSDN/a2seOuh70K0G6EYnhdKbKTypWLRe8vwybF37
	IqbCy+LSA/J7Hpdcnn/PXH8ILq6s4fJ2iUrYRRUPRuRvqWcS95W
X-Received: by 2002:a05:6000:29ca:b0:454:35b9:803 with SMTP id ffacd0b85a97d-4606dba7668mr15811f8f.30.1781210821535;
        Thu, 11 Jun 2026 13:47:01 -0700 (PDT)
Received: from MBP-Elazar-Leibovich.civet-hops.ts.net (bzq-85-130-200-168.static.bezeqint.net. [85.130.200.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606c0d0947sm1727493f8f.16.2026.06.11.13.47.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 13:47:00 -0700 (PDT)
From: Elazar Leibovich <elazarl@gmail.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-kernel@vger.kernel.org,
	Elazar Leibovich <elazarl@gmail.com>
Subject: [PATCH 0/2] powercap: dtpm: Guard against missing energy model in dtpm callbacks
Date: Thu, 11 Jun 2026 23:46:56 +0300
Message-ID: <20260611204658.47987-1-elazarl@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The dtpm_cpu and dtpm_devfreq powercap drivers dereference the perf
domain returned by em_cpu_get()/em_pd_get() without checking it for
NULL. When the energy model is absent - for instance when a CPU becomes
impossible at runtime so get_cpu_device() returns NULL, or when the
device EM was never registered or has already been unregistered - the
dtpm callbacks, several of which are reachable directly from sysfs via
the powercap zone attributes, crash on a NULL pointer dereference.

Add the missing NULL checks, mirroring the guard that already exists in
get_pd_power_uw() since commit 46dc57406887 ("powercap: dtpm_cpu: Fix
NULL pointer dereference in get_pd_power_uw()").

Note these patches only handle a perf domain that is already gone when
the callback starts. A callback racing with
em_dev_unregister_perf_domain() can still observe a non-NULL perf
domain that is freed underneath it, because only the EM perf state
table is RCU-protected, not struct em_perf_domain itself. Closing that
race needs RCU lifetime guarantees from the EM core plus holding
rcu_read_lock() across the perf domain access in the readers; this will
be addressed in future patches.

Sivan Zohar-Kotzer (2):
  powercap: dtpm_cpu: Guard em_cpu_get() against NULL return in sysfs
    callbacks
  powercap: dtpm_devfreq: Guard em_pd_get() against NULL return in
    callbacks

 drivers/powercap/dtpm_cpu.c     | 6 ++++++
 drivers/powercap/dtpm_devfreq.c | 9 +++++++++
 2 files changed, 15 insertions(+)

-- 
2.50.1 (Apple Git-155)

