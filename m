Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6463741F5DE;
	Thu,  6 Aug 2026 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006157; cv=none; b=YXiafBJShVxdnkQc1KDMZWOWWwAlUoXWrFjXqT26MoEw746DMYBO9dVi8Pm20LUsU64dVJ90nSLv5guoSwI1HJTpYfvqEHEjbyrV1oJ4zdXfYkLMbjRj7yApMJbON5gcz0eQL3L7Faim1/R49Lx0kphz6MxEfrApgRD5YWx5QHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006157; c=relaxed/simple;
	bh=PSqhwNhgk0w3pRkAn7OksH/I0Bm/DIJZHaLdHbJBmkw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I+H3F4dpmcGz5cmhCaLCx97s3aBtDK5zE8yTAtFcB05Af97tunb1kqXTqFvo7OgJd/5JC1AuVAlJa8QUKWug72z3d2CMdriqnGm04Yc3vfIuvNG+CHWNyi7YyVVjSqFiRd5XeDEXYsAqlI6rXDWPLEEayqjLykbXunfrdCvMKtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=UBuYtiSC; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="UBuYtiSC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786006143;
	bh=bfQFI9UE0BG7PqkJJvCr5MnjWC2ExUuD2Mv5wNUydPI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=UBuYtiSCEfdyEV5oExVkyk/bnSufiOQOO4+YiRxAtZTB5SUq5NDFoxoaaFuC76vtO
	 qT4E4YzcUNK3KuDW11C2w/O5CXoKv9smG7A1akSCJB07vZIUW+EGoKVsYe6hFSX2RQ
	 YMT2q7QdxuXxBWqfJ97T5xqUMG4otdbozC5A9Lf4=
X-QQ-mid: esmtpgz10t1786006138t64a578e1
X-QQ-Originating-IP: ZumO0C5vAZaw+kCchQzXeTEgVEoSMl6W5wDM4tLlYmc=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 16:48:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16807416105596679994
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
Subject: [PATCH v2 0/3] debugfs: make debugfs_create_str() read-only
Date: Thu,  6 Aug 2026 16:48:51 +0800
Message-Id: <20260806084854.1019789-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mutteg8H72qD3kGRBgYJJUWo27iY/7qJGUuzamSUayOLgs8lufDSoFBB
	iwRyjoetvF0Zb8LnZYdBHNeyj4hsbCy/JWWBWMv704urvQRYTPkxiM5VOrPtP+IfBcd6hRy
	oK6n49qJWlSEdeedUXlE3bTfj7Q0EU9/nCRphuQnAzVXzLY44ALOF5EFkxH3hH7GcOQ0a0y
	pc9ig4Ner7XD+73dHCc5J7UFI99wL88zhOL4kaHDKefroPICRHeYYfOWqqpNIa3h5NUIMpS
	MDzT469glMfLFwB1eHsXAOnIg3JrT9L7OYaFu2dhxXdOUwHkZjV5f86KJqVmOrCschVc3d2
	+75qOdnhzvW2EX/KdkUV2U6XZPCPK9yQkoQAoneogUPxDGJkXRbwTAmGB5cyYtz6n/5T+T+
	gUNcFYUimCHHu5o/2NhRdjtkDJsgvb/35rhyBGfWKqE85E34OgWPAvZF/qEWgQ0cVOnLcDF
	uJpEI3lssBNIgElDFxNNwUutvBHC7LAikl8Yptoo5S9kmqg3AzvXoy4N82fX0EIa/d4Rqhz
	5lIVcOsEsMV3rRxhd6Jak5/0g0NDArq4FpbH1A6c3x5W9tQgdo6qMSHt43gWDG0a0VcqFEx
	VYyiMoVS2lhK8iI3wZdL4qKCRWHS+fQOtZWt1hGFeEkZJ0dR4pxEEQIPqXSDKBci4ohPAGJ
	6D89UNRhnOIdJSgtkWRg+repuk2j49Te5iU1xkLqQXosgHuxoEcJUFgBBdFPXStwGz5USj8
	9RmC+lYdmev5kqyxRtS3CPugzLjQSxAFzMc5YgbJsXsmStZyuxjWivriF3AP5u3JCMnC/TH
	EXcQZjULCzlS7ePbtUFmSkEyL0J30r7H9i+pUSwAPfNl+Y5O4wHLh/bl2lTQNu0A5Qcw/s6
	VEymCQ4qVhu167uqc1eBAQmezk7DxbRLlHgxMA68K1h5I4U1zpNIEZLpS6/ffx09dLHDPp1
	IPJCL8qsP4XIRZOBJYOgy/YzRwN7ssLTOLTSUBcBA1Q24I2RUCNZEKwvuJ2uuSu6/XXZX9d
	kHme+C1So2uwvNF4i9gk6tV5rMrjk=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

debugfs_create_str() currently supports writable files through a generic
string replacement helper.  Concurrent writers can race in that helper.

Instead of adding more locking to the generic debugfs string code, convert
the existing writable in-tree users to local file operations first, then make
debugfs_create_str() read-only and refuse modes with write permission bits.

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

 drivers/interconnect/debugfs-client.c | 75 ++++++++++++++++++++-----
 drivers/soundwire/debugfs.c           | 56 ++++++++++++++++--
 fs/debugfs/file.c                     | 81 ++++-----------------------
 3 files changed, 124 insertions(+), 88 deletions(-)

-- 
2.51.0
