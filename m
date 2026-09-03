Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493134027B;
	Thu,  3 Sep 2026 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401756; cv=none; b=kKakTsl62qG0qlxA5u+hK8obfc0G3+u+01PchVulJ4gZy3q/C6woQN3cIbLMz/RdxItcMMXdWPQlGNTvk7oJxMSN3UHkPr3ASV+V7awntJ8ay4dRayNzy3HasBjIMkIvMGknTwyezNVH297NmqMOldTz/NBAqm7z6kzKBrQmXD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401756; c=relaxed/simple;
	bh=ZwMsuH7eZzcHZb+bxrsak+DWn/K5UXWPROmyoI0n14o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D7l62p/QVOr9a8l7Jhr/5Ph46CKxu8NdPlsuT60pAvWb9GyRI6sfg5DJqUbNBU0R8hmFk9Cfb9Ct7tdMD7HjbRcf3UMdPlaBxXVnGz2q1TkaW2unKcBaX5+DCxxCJjd5EldjAcj5482EDWra/B13+bwO0PLz2bFvUkk+SpFktwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ZZCNCttF; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ZZCNCttF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1788401718;
	bh=veJk2ror+hEi4Ty7W/Sg5U26XPTeLYM4/GoJraBnK7g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ZZCNCttFVNdy+g0mU8gmGsIhJBPdmUZiCAl991LipbEiZZQC4rZmqQpIt1ZvilbbO
	 yBAHkzkT1pBcJEDi6sXeb9AOOQnqYs4s8TnTmMlEFdPbGiBd6vmiP7ZGWsQXERQb3B
	 xDe8NL3O+MQ2RPBtBYPwvDEsb2RECPO8a6WCjOxM=
X-QQ-mid: esmtpgz16t1788401708tcf7d2a19
X-QQ-Originating-IP: AbsfmLogBfzNDC2ZGLAHnKrajWshw7V+7Go3V8q7wlI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Sep 2026 10:15:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8266889136189670214
EX-QQ-RecipientCnt: 15
From: Haowen Tu <tuhaowen@uniontech.com>
To: rafael@kernel.org,
	laurent.pinchart@ideasonboard.com
Cc: tuhaowen@uniontech.com,
	gregkh@linuxfoundation.org,
	hansg@kernel.org,
	huangbibo@uniontech.com,
	lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mchehab@kernel.org,
	oneukum@suse.com,
	pavel@kernel.org,
	stern@rowland.harvard.edu
Subject: [PATCH v5 0/4] PM: hibernate: skip unnecessary THAW resume
Date: Thu,  3 Sep 2026 10:14:55 +0800
Message-Id: <cover.1788399733.git.tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260730153817.GA1555869@killaraus.ideasonboard.com>
References: <20260730153817.GA1555869@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NDxI9psdf3YVUCZYqxoqQ5krZPOuHojO02au3JGODVZLCHla4FJ96JV0
	1UoJ73B5Gso9t/oSP+bwcFsNnVCUjDNMYuSUGtMQKIKFhyKovvjoXEOzJg4vhqMooa3o/w/
	kl2hRTnRA23GOamP8Mwj7ZJpJEutltVABoZf6HbjxbRFlij1/44izXQZxt9hHIW5THP7CqT
	V6aQ8YvwvC1JH25I8NxT6dIA3Mooqhu3/g4cHWfnLH2Y61fxQei0ZtDyBcg2HpgUxyXPL7k
	m/X+VEULRKsm8CP0c6TizoALQfq5HA8vCNA1j/bWXT+ZZFn6eGepH5xoXLAYNMcS5uCd/JI
	iLPKrtklNnvJz5gbRgvK7MWEe1FmNtIgLSa/E/onSJ+a6QkbawQaXnfnHwt72qi1DWmt5oI
	/vXSMcJ0h8ze3peHM5DquIPhwOmmyIaQMf7qLOkBSAhBuymmAOP9Ntlg5LpdfMuyzrcw+w+
	uk7PSyeyeSdAJUPMqOPhDmiWPQlD4LYxsblLhHndLlJgNou+6qW8i8FJhlsLHg/YvCm0kKe
	jcWzF8F/BnCtch/R2NtqSclKcuSRLyYLUgKIlPAVqUzao/OhYpRBvGp+tnk6aUxT71JRkm8
	LYZgpyjD5TJ6YaYh6HEigx0FgGRojCg+yAGwwYCkV85IvCiO8WxsLxcx70C+a+etyAc2gbo
	atnVbX08dbs6TwDfii0JvsQrPB7m+n2cEbahNMwcDbe5nfxSIxy2xV2C79j60zr/l6gZu7N
	ZidGcXGK1EvaOt7wSdX5ctwu5DzOBdk0xv1aL/4AdW3a2/LyN2ccY5aWsxC183bdqcmnMQV
	eSjzA35PV3l/igEtwfpC5wWXuUfNsSfosCzPe+r48NGdiBkyWmB+Osiv4l0sWn0ZnODcjSC
	N1okIa/+XNdZPKioe1F2zvvlEzg2ngQeQInDqVQuT6ozS+x2JOLhfFb/CHs6Qnu6N7lgwyV
	lsNJnbWYITviMMNikVwOd422GRpITTXzsg04Nb7cuM6f9cLXsY/WYOhVAs4bjwYWDV5064Q
	gWRwz/Wh+16lRVK27S1LcD0Z4DyNZ5BHdLjkm7cI/rxcnOrNNzRaMeGz5FrOQ=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

During hibernation, after the memory snapshot has been created, the
kernel resumes devices with PMSG_THAW so that the hibernation image can
be written out.  Devices that are not involved in image writeout may not
need to be resumed during this transient phase.

Earlier versions handled the UVC case in the driver.  Review feedback
pointed out that this does not scale well and that the v4 notifier-based
recovery path does not preserve normal device ordering.  This version
moves the skip/recovery handling into the PM core.

The new DPM_FLAG_SKIP_HIBERNATION_THAW flag lets a driver mark a device
that can remain suspended during the post-snapshot image-write phase.  If
the original kernel continues running instead of powering down, the PM
core resumes devices skipped this way before userspace is thawed.

The first two patches are unchanged PM fixes/helpers from v3/v4 and keep
Rafael's Acked-by tags.  Patch 3 adds the PM core mechanism, and patch 4
marks UVC streaming interfaces with the new flag.

Changes in v5:
- Replace the UVC notifier recovery path with a PM-core-managed skip and
  recovery mechanism.
- Add DPM_FLAG_SKIP_HIBERNATION_THAW.
- Use the flag in UVC streaming interfaces.

Haowen Tu (4):
  PM: hibernate: clear in_suspend before freeing the snapshot
  PM: hibernate: add pm_hibernation_snapshot_done() helper
  PM: hibernate: allow devices to skip post-snapshot THAW
  media: uvcvideo: skip post-snapshot hibernation THAW

 Documentation/driver-api/pm/devices.rst | 17 +++++++
 drivers/base/power/main.c               | 65 +++++++++++++++++++++++++
 drivers/media/usb/uvc/uvc_driver.c      |  1 +
 include/linux/pm.h                      |  4 ++
 include/linux/suspend.h                 |  2 +
 kernel/power/hibernate.c                | 38 ++++++++++++---
 6 files changed, 121 insertions(+), 6 deletions(-)

-- 
2.20.1
