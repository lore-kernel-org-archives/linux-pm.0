Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF65371868
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316166; cv=none; b=iufRTzrFWiud5AN2e8A6XKh6bV/3gqNefOAdr+NRfG3qFJluQnSB8+5wYyHmO/uie2S2dHFrA5xv+cR2udPKMG2MXX2fuWUPOIsanfT6ENvnKnXVEwoPWA2hU3nOUACJsJtDaLbns8WSQ3bnMvv44+zg9NZoYz9FbYaN+lMDRtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316166; c=relaxed/simple;
	bh=XsHYluA3eC4hPkoZkY0fwWjTh9Y6vFLV8Xc9nI8cUN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SlJQQH1Ahni/no2Mg89vP+MRcLllvSc8BGGH5sQZWZO7PCYYirQpS5UKG2b1M8QKpiDF+SEFYft6C7YFnCLjYXs1gV3tVHll2lUdv43Uk3cTDKlg/YoJ0SpMOLFWXxb4M8TtekctELEi2w6H0raP2TyD2ZB4uIBnU3d3W1/A7eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=K7diILpJ; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="K7diILpJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1774316160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JttJa3HCx93g8zLMo8YQuxwCR21NsARlx5buJLUOFZk=;
	b=K7diILpJoajLKDQ2IpzVcqFGQqqx6xAVBV6QDwZeBWZI63xiT5Yv+4tgk7Yc1muTeDbi/Q
	St+2lCYOFL/m7EL6YOi7Hmp5wmJfthjmB6QVJOmSh+xCbgM421IQ4guysmeNDaZdquO8n6
	ceGWV9umRGw374ApM1kM5QFEZDvhuHMbD4PG37DK8x5TKIyUzEo4V6+CDr+19J9a0yutHc
	jDFDgUci1c7+SPxFPcTH8ktULxtHQrX239CJVkaJSSZVkRgREjcbC7UwUTqDQFb/GGERPp
	zo/tKxmvK7uojvAtMQQpmMv4+FDAcXaonAO6ySx+B4nO4ir2mGP1zzpw4yKTzg==
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Roberto Ricci <io@r-ricci.it>
Subject: [PATCH v4 0/6] cpupower: fix various man pages issues
Date: Tue, 24 Mar 2026 02:35:37 +0100
Message-ID: <20260324013543.4776-1-io@r-ricci.it>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch series fixes a few issues with the cpupower manual pages,
such as missing or incorrect options and trailing whitespace.

Signed-off-by: Roberto Ricci <io@r-ricci.it>

---
Changes in v4:
- Remove Fixes tags from commit messages
- Fix issues reported by scripts/checkpatch.pl
- Add patches to trim whitespace from some files
- Add cover letter
  Link to v3: https://lore.kernel.org/linux-pm/20260312102029.14980-1-io@r-ricci.it/

Changes in v3:
- Resend because v2 patches have been incorrectly sent as replies to
  individual v1 messages.
  Links to v2:
  - https://lore.kernel.org/linux-pm/abH7pF9p8KxAsHIE@desktop0a/
  - https://lore.kernel.org/linux-pm/abH9KsKbvyi-iceb@desktop0a/
  - https://lore.kernel.org/linux-pm/abH9rMVuy8wmzgkG@desktop0a/
  - https://lore.kernel.org/linux-pm/abH9_Jk-ckkJvsGb@desktop0a/

Changes in v2:
- More descriptive commit messages
  Links to v1:
  - https://lore.kernel.org/linux-pm/abHAZj9xwfDf5JVZ@desktop0a/
  - https://lore.kernel.org/linux-pm/abHAdH-ggaxUugCy@desktop0a/
  - https://lore.kernel.org/linux-pm/abHAhAg-6gaK0Qn7@desktop0a/
  - https://lore.kernel.org/linux-pm/abHAkgiPg8VDpDoV@desktop0a/
---

Roberto Ricci (6):
  cpupower-frequency-set.1: trim trailing whitespace
  cpupower-idle-info.1: fix short option names
  cpupower-frequency-info.1: trim trailing whitespace
  cpupower-frequency-info.1: use the proper name of the --perf option
  cpupower-frequency-info.1: document --boost and --epp options
  cpupower-info.1: describe the --perf-bias option

 .../cpupower/man/cpupower-frequency-info.1    | 64 ++++++++++---------
 .../cpupower/man/cpupower-frequency-set.1     | 42 ++++++------
 tools/power/cpupower/man/cpupower-idle-info.1 |  4 +-
 tools/power/cpupower/man/cpupower-info.1      |  9 ++-
 4 files changed, 66 insertions(+), 53 deletions(-)

-- 
2.53.0

