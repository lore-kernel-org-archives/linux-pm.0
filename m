Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.36.144.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293703;
	b=3PW5x0+vYUUrht1fC5Pyds8HwvY4FRewegyyfr4Hjl3ZJCxCo9Mvkkq54EFGP4/QhADb
	 8GXVCNxVNSfCxWYK1B0zAViNnrrZtNULV5CPa0c2sstGSWENNjtbUMYuZbww/PVjHiZG1
	 zi3dvJkmc7UaT6DkOa0QQ9bts/QBvZPfm9aUt2wEiXmznTvW/cLllV2NXu5ghsEUIHHNU
	 Mds145cWaE+zEsNKeUay0HmjK16AITSRmTAvCFFq6px3Y/WVHHR2VhWzHoV7thqqEEqW/
	 QCSH0idi1RVZMbws6xmS/LP5/UULUugzqnN4lZmv8CJYsxYDTCdRaf5ySCF3VLPv4ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293703;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=AcjVc0Nkrb9pyqjq7pD12Xjy1QFAnw5M2h90dx+nTtg=;
	b=M0KgI5jwBqhtoMZZe1F7bWRdI4mUj+3eSLLjgzCYakniwuepVXbQnXzi3Gbw7P6+IXm1
	 dmLDyN2vYe6SBxaomrLRPrLuKegOnGNazGFATeld5ce1z5UGKaAZaM6bbSlBvlytQR/0u
	 h8oNjmNpDLV3O+rA0JpW6CnbNIehG6GnGyBIS3QN+0p7Hx+OEBROxAdd8+wmcYJt6dmFJ
	 TOxaA3HDA+buy1JeF3AjXB3k57G5ZaBND5/nttYp6yWg7WiDLjRjN9hCi3nNS6w8cmhc6
	 eXPb9OB2/8BmLqp1zIWCIzgoJCLMN61h0AbYvLPyR3hZXubu2vieYnl2vVRPveeaofA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yoxcu.de;
	spf=pass smtp.mailfrom=yoxcu.de;
	dkim=pass header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b="UUQ+ImI/";
	arc=none smtp.remote-ip=194.36.144.171
Received: from morty.yoxcu.de (morty.yoxcu.de [194.36.144.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8A4606A32A;
	Sat, 21 Nov 2026 20:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA8A4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=UUQ+ImI/
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 92C261D86D6C;
	Sat, 21 Nov 2026 21:41:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoxcu.de; s=dkim;
	t=1795293700; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=AcjVc0Nkrb9pyqjq7pD12Xjy1QFAnw5M2h90dx+nTtg=;
	b=UUQ+ImI/sdGx3C/I9d9X6ZZne10XF9C1Haixlx4r7sJpOeU7JmYoOh0SIgCSlXs5a97PQX
	njSUtUCcyM/D0LXpQHhSAPaBzDRXR62hAozSIqLmCG1raT7MxSO6t67++XzwSdKN82MoFw
	C/0j0HyCtYki9SFwmt/Gq3empGZjFFt//ajSTcSzPdMH+T8vvYUUT+DKVsX6sQx4GcgXKz
	Z7YFps6nJepYtnd/HA4iiFGtj2gbJXx8or3TvD4Pkm83n2ii8ABoSxzMG9fErJ4F9j6OQp
	K2+yxTKrIeWRsfM8BHe/3/GIY83EIejbkSTNOq8TC5UzpqH9apdotZkow0DsRA==
From: Michael Auer <mick@yoxcu.de>
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Auer <mick@yoxcu.de>
Subject: [PATCH 0/3] power: supply: bq27xxx: fix wrong battery states after resume
Date: Sat, 21 Nov 2026 21:41:34 +0100
Message-ID: <20261121204137.848173-1-mick@yoxcu.de>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On a OnePlus 6 (bq27541 on i2c-qcom-geni) user space sometimes sees a
wrong battery state right after resume.

Patch 1 fixes "Not charging" while on battery, when the current reads 0
after deep sleep. Patches 2 and 3 fix a battery that is reported as
missing at 0 % after a failed read, which made the desktop start its
critical battery action. It happened in about 1 of 350 resumes. Patch 2
covers a single missed transfer, patch 3 a failure that lasts longer.

All three are in daily use on a OnePlus 6 with an sdm845-mainline
7.1-rc1 based kernel, patch 1 since late September, patches 2 and 3
since early October. On power-supply for-next they were only build
tested (W=1, arm64 and x86_64 allmodconfig).

Tool use: the analysis, the code and the commit messages were
written with an LLM coding assistant (Claude Code). I reviewed all
of it and tested it on my phone as described above.

Michael Auer (3):
  power: supply: bq27xxx: report discharging at zero current without a
    charger
  power: supply: bq27xxx: retry a failed register read once
  power: supply: bq27xxx: keep the last values over a short read failure

 drivers/power/supply/bq27xxx_battery.c | 60 ++++++++++++++++++++++++++
 include/linux/power/bq27xxx_battery.h  |  2 +
 2 files changed, 62 insertions(+)


base-commit: abbe0a96bdbadae9e29489a1528fa436c55aca25
-- 
2.43.0

