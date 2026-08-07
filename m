Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153C3F787F;
	Fri,  7 Aug 2026 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096943; cv=none; b=BKspGC/CpWM9DDrAtGRwQKO/EZ4NGMtg9HC13nAJ63FWdi4BmochhhEGkpJfPxLgBFQEyPcMohCgj4nIsoPLBLmLPSzA8bbcwstPFE4yek0m8Ti3qwOM+9UNKdQr/Bu7VO2CAo64xlPdbvDqoP66qWx187yg2EuxeLLrBL2jQ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096943; c=relaxed/simple;
	bh=UkB4BkkOuvbkr7MHYB2oA3HYyctuVjhYqz8iZvkLqDU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oH9GTzCQtbRPNcpDRg6/6a3dJgnEMAwTLAcQD+lxIK7P7N9Jph8rBG0P13zCVW7Z3KgeUAfs1RNZIKM60KSNJQplx/4hvvoL5TDH7SeWQ3ndYjTxeF5uIS1wjMjV4pNApYrJ/pZDUyd1FbC1B8y9Ll66WXcs7AE+ih4E04k2BMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=MffxJ2Em; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="MffxJ2Em"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786096926;
	bh=xWuuNdzgsihlts9kq25VLkcDTHVhKO0Q6F11EnxG6To=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=MffxJ2Em4WABWBPn+C0QeD2TYNXo1M3Nyc+zg13wgke43I1Eu94puAGYcJfXKOQ7j
	 NHyk08pKDkPgkQgt2SrhkrZ+KcwEu2zWkhYRulXF7FKEwBA6EKfjQ8jOIF40G4E8eJ
	 REby1XSmhDSC3b0X+/6ks9UzOh8+od9GVAKvslEU=
X-QQ-mid: zesmtpgz1t1786096921td0398ff9
X-QQ-Originating-IP: 8y3xLzEn+39nDhSP/ySEVFNl/hUDlLvDaTOsHkILQKk=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 07 Aug 2026 18:01:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8339967122186954904
EX-QQ-RecipientCnt: 13
From: Yichong Chen <chenyichong@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: rafael@kernel.org,
	dakr@kernel.org,
	djakov@kernel.org,
	quic_mdtipton@quicinc.com,
	vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: [PATCH v3 0/3] debugfs: make debugfs_create_str() read-only
Date: Fri,  7 Aug 2026 18:00:50 +0800
Message-Id: <20260807100053.1089834-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NFQMG86uACrUnB4eqRzK48VGz6aeKacEvROUT4ko35Vrh9ZfjpH8heLI
	wfYeEV6LEStzAKR3hBoV6XbG6FwJxCSUfGXyeCcyfFyqy65CwEON1FKfDxAQEEYqD6UEgx6
	dTQqXSpbbygs1FuTbejATUe5RMbg5ASptjmFPVVcpTvK9E94xk9a9txhuRTAwaIw97yjn+/
	2nTkhxcA7vgQ01QqqbFp3abx/WqfcIBZRrT8HPeqgSeH7BlPiqjRVLMrzJ1uMQ0i/OkJ8Y/
	FWd6UxcVvG/GQQCW7fRPjRrYFdN3Lm1ey3wyGamawNaEKvtokpb2ho8V6ejt8oHZz2fQgm9
	G+xtvqvbHp2QPuwaKFOK/P09gttI41Rzr8lliHLoOO5GBxTdUKOdRoQDf3eGKHhjiw+zfaT
	zRtK7fXNIYXG/ny6BoE8g0gnZJjYBjLjh+X2SuxCZglXoZXCdozv+pGLvAnkETp1FadQ5Ui
	8andDO1pMZaePEnYSYxShYqFzVBhiL0atq2Ln2396tKqRGIMtG2TcVvR3pjQvUcruVpHi87
	vzC3Tw2skJFJbM6SNgGggVhO/FzcMdG93tCKCNHmCkp+LKQ8KkF6VAlcWQAHtMjr2djT0tB
	NyeaV90l5e3eLmU23/IthQwlT5R7eNKdA4QmQVWr4TKxVX5FU65lHHNlB+8xcd74/mJ4+vG
	8i3F3p6ovlyikfkK+XMsZ1KgTL+ALjpYuoCpu5NmMRxnqxOJpSo2AXoUrEHteGbZ/7lqrGI
	viASXi2sAPVP1KsYjpaJw/2F2tlD2byKgt9GBFyUhrsGRMGiZbZh2n4cXidqsfGlx4NaBXZ
	JPR+K3SpgHceM3dWNTcCWlHEAoBxJtivSB+xpKL77G6PgXQbFZrog3s+wy8s4ie10YFu6Fi
	qunEq32QgqRgB1wxLFnr9OnF0v7JoRqNgKJXmaJAFMA62qLPLBYwWbtSjSzf6nLLkXwSmNI
	zEf/iP0+yZpEVgdlbKFdNYcAuVNP82FpuAq/9RO/nI/yr3SEaq3CxOBIVnIi4vHW10uMmit
	XRpJTKPf5qvcJPOeSHz04okxePeyg+S6ho6VAWlwoamD8Q1Nyu
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

debugfs_create_str() has a generic write implementation that replaces the
backing string.  Concurrent writers can race and free the same old string
twice.

Instead of adding more locking to the generic helper, convert the existing
writable in-tree users to local file operations and make
debugfs_create_str() read-only.

Changes since v2:
- Use scoped mutex guards in the interconnect and SoundWire conversions.
- Clarify why GFP_KERNEL is safe in the interconnect conversion after the
  RCU read-side critical section is removed.
- Drop the unnecessary firmware_file = NULL assignment in the SoundWire
  exit path.
- Use WARN() instead of WARN_ONCE() so each writable debugfs_create_str()
  caller can be reported.

Changes since v1:
- Follow Greg's suggestion to avoid adding locking to the generic
  debugfs_create_str() write path.
- Convert the existing writable in-tree users to local file operations.
- Make debugfs_create_str() read-only and refuse writable modes.
- Split the change into a 3-patch series.

Yichong Chen (3):
  interconnect: debugfs: replace writable string helper
  soundwire: debugfs: replace writable string helper
  debugfs: make debugfs_create_str() read-only

 drivers/interconnect/debugfs-client.c | 81 +++++++++++++++++++++------
 drivers/soundwire/debugfs.c           | 63 ++++++++++++++++++---
 fs/debugfs/file.c                     | 81 ++++-----------------------
 3 files changed, 129 insertions(+), 96 deletions(-)

-- 
2.51.0
