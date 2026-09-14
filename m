Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D75422541
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379220; cv=none; b=uh3orUzqCF+vnRNF3oebxEt2txqPDoUIVKV01OY9OQyyPK5iM/R1DtQH78mN6ybbsLX5HkZFT+LIyiMmEX+546TEKsnicOIEg0gSItsGs9CU+r9x2RhkbM8EtPVK/sobUqyHPwRgH5m6butzofl6pml8WrLpLCSkPkbtspLCECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379220; c=relaxed/simple;
	bh=DzgWUJuiNQ6WuYHH3oo31SmlYZ7/cR4pcxcWhooAFj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nf0Yvrg6t1xqxwmWVFPBK1Ncvf8PeU+gTIwxbOD7qWPbyFLNv0t2ktTcyZuAcveYYVpJuzlH3b+OJWp2xyyPIzqd4rpD9e5qWRqJR6PljN3dAkK0qCkfh33rB4nqB8BvOqTyRxInilu7FlYFqMhkCQiYsCa2ay0Wfb/SETfp9ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhsQIvhf; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhsQIvhf"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccf3ca94bso8293055e9.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 02:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789379217; x=1789984017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vkw7JGyPZhE+fsyhZVYt1uhb9l0aiaOQEEvbh4klHbs=;
        b=MhsQIvhfd6YobZCbGa07QSbRUaE85/92WJ/T35bUh9LfZXyXGDl0+g1SHoWyfji52E
         5Gp5jn8aaG373HpigteInFPEtVZFYdoayFN3dGdT/3SFqz4XWGUGL9MkQCPEh1qJN+N+
         BhyCLMPbCQswUlwWQj4LCYkhSB5KJPQ+eBh/dKmTdPZ38AffFYaB1hvEHX4p1sIvcLjr
         zXw+Fa5IXtKFbfUbKDEzYT0xNEKkJTitLSc+zcnDd7qUVp303KW/o3uVAE84CTfjMU3o
         Cozc4Pm6RRdOaJNuxT6gu27SUhxWnOGZWdoITBm3Mpicc1n8e/daXi9ncni1ZhbhdGZ/
         4Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789379217; x=1789984017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vkw7JGyPZhE+fsyhZVYt1uhb9l0aiaOQEEvbh4klHbs=;
        b=iNSyTaVNmGXZQFLWwIbL0MdMFDwYyS66dUNbcgyWsNFLy2XpJxTwkh4EWU0Kgjxj5F
         0FLZNNPKahZ8ev6VGIdd/GgRkX8CPr0mwpZcK2JjOtxHntpSMsmvn8sUCSNTRNG1v15w
         eeoFGenlw1h9d2icfdlB3bp3g3u0fkyQzXdvqLyYntmLRJchDJpk0oIyincytRidE3Vx
         22TVdTIYy76zyPg8MWwOurwhWU7ZClZyf9nTlpg4+EcrSqCYqNYyTrDNhAVy4dSDmXmM
         3NnfGj/8LSlhrMRClUy5aDCrq/U9JEcXeNxz+71g4CP46rWe3i75aQ6ZgyTVkxH8hS+f
         7uJA==
X-Forwarded-Encrypted: i=1; AKwUvBzZKJ2R8m5aMR6gy1kxtLlD4fPqNuZrY/9ZPd3DgY6scmUkGgqGEeu8sjGyrzGJbL/x0Fitg1RZiA==@vger.kernel.org
X-Gm-Message-State: AFuF++l3C4aox6/+lhh+MtFY4XhuS8YiRTznTM1C2mB9iksy6dnt3vwS
	ndo/krFsagafOknVuhy9ruD34cCqHj8h1JhONnXwrWMn7QzgxmGH9TWz
X-Gm-Gg: AYBFou0Tfay3jJtvL3xGjRtD33xr6Stt04GojHLuYob4Ta2/43mvgdDfzGWweKpQDCx
	a1PTnFYjO3Gn4BZUXBDgfjrUcLgxJE9R4JmHle4t4uBtLEdLUPL6z+so/Q0Y+js9GwypT28pPCg
	AyP8fxHSlFxLTkt1QGbKX8wV9sAlN+JdFnVTEj1lbrNWDpgM4OsGvUoZfaw8k/fmf8WqWm65e0i
	wemuFyumkNDPhEnamAq2BW0IHzE0vIbzBUtiCI9RK9YyeApgUIFh0Oc9aUZ0h9SqUAkLDVN3Fn5
	vfxMegAUXa5DpYGjzzOb0hNLqftSfECodKAKERE3sMdi5kPoVFozXay8VB6CJ+2dvwj/w6i9VL6
	k/iMYY0s9Ym5aoIT6Ivt286ejjivZSRhb1iAxDY4llFY7dsZQ8/G8zYBJmUY9FZ606oAkXVI/vC
	apTFCQpYESt+ivJDnrXXVRzHuN//LaGdDKE3xOGnJItzecZwpXuHU/tgcZpk5bnayr63VZPs2lC
	GyhBl9o
X-Received: by 2002:a05:600c:1547:b0:49c:fc6c:be09 with SMTP id 5b1f17b1804b1-49e7a67cae4mr20839695e9.32.1789379217223;
        Mon, 14 Sep 2026 02:46:57 -0700 (PDT)
Received: from localhost.localdomain ([94.252.75.25])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49d26be3e35sm378964285e9.2.2026.09.14.02.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:46:56 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>,
	ds.heine@posteo.de,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: glymur: hard reset on the first system-domain idle entry (SS3, 0x0200c354) after a heavy load - Lenovo Yoga Slim 7x Gen 11
Date: Mon, 14 Sep 2026 11:46:47 +0200
Message-ID: <20260914094648.14502-1-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Lenovo Yoga Slim 7x Gen 11 (Glymur / Snapdragon X2 Elite), linux-next
next-20260908 with Konrad's board DTS (now in next) [1], OSI mode ("Initialized CPU
PM domain topology using OSI mode"), Ulf's "pmdomain/cpuidle-psci: Fix
behaviours for CPU PM domains" v3 applied.

Symptom: after any full-speed all-core load - a kernel build (~85 s
here), `stress --cpu 18 --timeout 90`, rust-analyzer indexing - the
machine hard-resets once it goes idle: about one second of freeze, then
the firmware splash.  Nothing is logged, the APSS watchdog's bootstatus
reads 0 afterwards, no pstore.  5 out of 5 attempts, 15 s to 3 min after
the load ends.  Steady idle without a preceding load never resets, for
hours.

What isolates it to SS3:

- Deleting domain-idle-states from power-domain-system in the board DTS
  (so 0x0200c354 is never requested; CL5 untouched) survives the same
  trigger 3 out of 3, through tens of thousands of cluster collapses.
- On a quiet machine SS3 is entered hundreds of times right after boot
  and survives every time.  Only the first SS3 entry after a load kills.
  psci_domain_idle_enter filtered on state==0x200c354 shows no earlier
  request in the post-load window; the fatal one is the first.
- The state's latencies are not the variable: it resets with
  glymur.dtsi's entry 2800 / exit 4400 / residency 10150, with the vendor
  DSDT _LPI figures (entry 0 / exit 5000 / residency 9000, a local
  change I carry), and with entry 5000 / exit 5000 / residency 9000.

Ruled out by direct test, each with the same trigger:

- NoC QoS programming (reg removed from all 19 interconnect providers so
  icc-rpmh skips it): still resets.
- cpufreq transitions (all policies pinned with the performance
  governor): still resets.
- NVMe/PCIe I/O: `stress --cpu 18` with no I/O resets too.
- PDC secondary mode: the PDC config register named in the vendor DSDT
  (\_SB_.GIO0.PDCC = 0x0b220110, mask PDCM = 0x35430) reads 0x4, i.e. 0
  under the mask.

So the question: is SS3/CxPC expected to be usable as a runtime idle
state on Glymur?  x1e80100 only got domain_ss3 in DT once the PDC
pass-through configuration landed (95f827ceb21e), while glymur.dtsi has
carried it since the base dtsi.  Is there a firmware or PDC prerequisite
this board does not meet, or should glymur drop domain_ss3 from
power-domain-system the way x1e did until then?

What I run meanwhile: min-residency-us = <4000000000> on domain_ss3.
cpu_power_down_ok() then never admits SS3 at runtime, while the s2idle
path (cpu_system_power_down_ok() checks latency only) still takes it.
Three hours, a rebuild, three suspends and a stress cycle: zero runtime SS3
entries, s2idle entered SS3 every time, no reset, and s2idle draw is
unchanged at ~300 mW.  I am not proposing
that as a patch - a residency value is a hint, not a switch - but it
does say SS3 is fine as a suspend state here and only fatal at runtime.

Happy to test patches or collect anything else; the reproducer takes
three minutes.

Thanks,
Oleg

[1] https://lore.kernel.org/all/20260731-topic-yoga_submission-v2-0-f1887031da4f@oss.qualcomm.com/
