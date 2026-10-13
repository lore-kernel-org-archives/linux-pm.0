Received: from morty.yoxcu.de (morty.yoxcu.de [194.36.144.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126A549399;
	Tue, 13 Oct 2026 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.36.144.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923761; cv=none; b=jRVHb0qn6nLxEhQ1T6CXPXp+cUTfwb+CR4WPorHCxn/sqshn9v75tiZvvqkXlNVQB8xvYiKPrR/4l7DpxuGQhapeejLzrI+hhjysCPuHqIIShqIBoQ181JrytfAMzrdYw536t2xaMsGA49aWBbd3Nbe6VER93oGoPCv0BBqGQ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923761; c=relaxed/simple;
	bh=BwnohV5YbbgeD3mMhsgPkAe55Q6E4kppmGjVLCMt3Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lvmsoslp/Q0uGr610xXv5cc1rUsK6BA7g2It34LoIdAzHQsR809WpYCdZfaG8GTv1pfRbLM1Q9YG0JGQxBrPbKvIMNaRWqPlBJextuSXZoheKYPTJIeDw5AYcj5bhqq8GYLgbY1/Rk1v+1gCTY9MHGOrNyt9N02Uek+AXtkcfAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de; spf=pass smtp.mailfrom=yoxcu.de; dkim=pass (2048-bit key) header.d=yoxcu.de header.i=@yoxcu.de header.b=yBkSNXrE; arc=none smtp.client-ip=194.36.144.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoxcu.de header.i=@yoxcu.de header.b="yBkSNXrE"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E64431D87E06;
	Tue, 13 Oct 2026 22:26:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoxcu.de; s=dkim;
	t=1791923175; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=cGf4AkF1A4jbQVZ+l0QHPS+EEt8Q/xCsQi3ebhYNmMs=;
	b=yBkSNXrEsYMtluveU2z0CQW9riyztKrkDQhEbHwytqhkU3v6v1aT6/HM0/2qiSwZ2vi7UR
	JVqAHQwa7TJ6HttZJi8i1qCnm41uT4/6MsnZI7dth9KOKE4nbWupe/4tnZ10ckXDKBb+cI
	xqoZzavvPYJaQK4NBrdchdlLFgp2/OJ9rIqKZgxM7D/aREEsjGYh5muUHCgg00JiG3bBgN
	cYmTMxxyU1aS0Y1PdH4mq5fp5A1iGbhBGvcRrMGnmrlSgGW6OlKWrcz1UMt0bNQHGKwJf0
	IEUvkFOG3vza6B1GCBI/8CsBIGHCiJrXMf2e5meX4kwoEb1ILvAvbfPsNFFytA==
From: yoxcu <mick@yoxcu.de>
To: Georgi Djakov <djakov@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Auer <mick@yoxcu.de>
Subject: [PATCH RFC 0/2] interconnect: qcom: sdm845: Drop the bootloader vote on ALC
Date: Tue, 13 Oct 2026 22:26:09 +0200
Message-ID: <20261013202611.3070778-1-mick@yoxcu.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Michael Auer <mick@yoxcu.de>

On sdm845 the bootloader can leave a vote on the ALC BCM. No icc node
uses this BCM, so Linux never writes it and the vote stays in force
through sleep: the SoC never reaches CX collapse or AOSS sleep. Found
on a OnePlus 6 (rpmh_read() of ALC on the APPS DRV returns 0x2000000f).

This RFC adds a node without consumers on mem_noc that owns the ALC
BCM, so the provider drops the vote at sync_state like for any other
BCM. The node needs a new ID in the dt-bindings header. Android's
sdm845 bus DT has ALC as a node on mc_virt. Mainline has no mc_virt,
so the node goes on mem_noc next to ACV and MC0.

On icc-next the provider reads the boot vote back
(qcom_icc_bcm_get_bw()). The vote seen here has y = 0xf, so with
enable_mask BIT(0) the node keeps an initial vote until sync_state and
then votes 0. A boot vote with bit 0 clear would not be seen and would
stay. GENMASK(3, 0) would match the vote seen here; I do not know
which value ALC expects.

Questions:
- Is a node without consumers and a new binding ID acceptable for
  this? No other qcom icc driver models ALC.
- Or should the node use a driver-local index past the binding IDs,
  so the header is not touched?
- Or should the bcm-voter clear bootloader votes on BCMs that no node
  owns? It has no list of such BCMs, and cmd-db has no API to list
  them.

Tested on a OnePlus 6 with an sdm845-mainline 7.1-rc1 based kernel.
That kernel has no vote read-back, so the node started at INT_MAX:
ALC was voted with y = 1 until sync_state and 0 after it. ALC reads 0
after boot and suspend reaches CX collapse (qcom_stats cxsd counts).
The average current in an idle push standby test (Wi-Fi on) was
35.6 mA, against 43.7 mA with the ALC vote kept in the sleep set. With
ALC off in all sets the phone has been in daily use for two weeks with
no side effects seen. On icc-next both patches were only build tested
(W=1).

This is my first kernel submission, feedback on the process is welcome.

Michael Auer (2):
  dt-bindings: interconnect: qcom,sdm845: Add MASTER_ALC
  interconnect: qcom: sdm845: Own the ALC BCM to drop its boot vote

 drivers/interconnect/qcom/sdm845.c             | 17 +++++++++++++++++
 include/dt-bindings/interconnect/qcom,sdm845.h |  1 +
 2 files changed, 18 insertions(+)


base-commit: 3fd56a2833c22f62eb84297d0dbd47739632f1a0
-- 
2.43.0

