Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F25F33EAEC;
	Thu,  3 Sep 2026 02:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401770; cv=none; b=YuSs/C6w7mPk0CgcK28X+Ox9rdT2Fft6IHzF8sOUXnmFQLpQRRGsa3aKt5+1M6WDGRadKQAVH51q878JHPUbdHVgm1A1EkOIN8pQpb0jiLN7v0T+33G3vqEO1mlSUTr5IT6XGgPugitRaKtVvCQzRBQOypV2ZTST09BFjyB/Ku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401770; c=relaxed/simple;
	bh=ltGCsPM9g4dL27hzeJYprlsMCLIuGBzrExUAh+1/n8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tig8F+TIyMuQw8NwcwwSPQVol59gtJ0GCKV3/FxrC74LpONaWuz4PO2SrHpNMW3tVTZEuASWzkaqBYlplwm+DaDrjF5VxA7+t/KRbmN7syom/f5UyXm0nL0gkihix3e5qkla39xFRodePhKr5kEhKTdpp6iCrhdZFgq4kd5UnZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Ru7EJkGu; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Ru7EJkGu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1788401730;
	bh=NNBPer/UqmzXtzPtWUFkVQGu/BhnIGA3Q4Ww1JPF9B0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Ru7EJkGuPrPb2cHBDMZxwYoWhdN+k8Un0xTngdnHxsRmi7J+Db+IcIB3CeI1/BphE
	 m8yIhS7D28qaKc0WDUMEGX4OE5+RWeT2YyhAnJI4SWCmYQClrAMUET+6E3a+J4WLKo
	 mz0kjVo6sh73lrBBFFp7lsKUzDYcw68CUbTOCJZw=
X-QQ-mid: esmtpgz16t1788401724t6d55b7c7
X-QQ-Originating-IP: o1bCMaKcd5K4sGAPBG6wOUQ88v1EnArt+Z/BFPA4eFM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Sep 2026 10:15:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7393804203611463141
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
Subject: [PATCH v5 4/4] media: uvcvideo: skip post-snapshot hibernation THAW
Date: Thu,  3 Sep 2026 10:14:59 +0800
Message-Id: <e72835b9abb06dd3a14728b4bb8789567ba3a747.1788399733.git.tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1788399733.git.tuhaowen@uniontech.com>
References: <20260730153817.GA1555869@killaraus.ideasonboard.com> <cover.1788399733.git.tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MhOKvsv6t0fkntv++Gjehay9UI4QGMfsfUEpORlKJ+nHfJUEfbzZtZpY
	v7uqGBUg76v5tpLDRFGagIa0DtfmKDaGhM5rS5d2miW7M43calzzu2YPr1VawU1iJqwjuA+
	rX/s4SfzZevq8TWxbh5HCXyFta+L5PtIM72z1nv4o+OGB/sPmmOX8QrygCg665uRoeM7bY4
	bm4MHT2gJkSrk7LESEMr7bcFdJ8MWRB6g387TRgNEHkzq43b02xYPdZ+xw07gRMavQEt8Qz
	s9tou4U5tH6E3EvqVl4bxiebO4B2rJ24d0/kbR9umVe2CsXEYeiuw9I9dhsaXvRAOqi41DK
	PABdG0KSPW8PUP/ycBFje9AEr4FfCjL5S3giupp33DrgbkSd3B+Q2QykZ+fZyiDT5yB+XcD
	SrnWQ3Vu5Sn8gUFxlg2YtcLab/4A/zNeEVLpPIX+tX3vQihhJx/4pImlwlZqUg2aY27O4zj
	z5a4tUA5OBnmSZI9UhsEPejoHT6t72AgK63JqVWO8DD0D+Oax/o6PkIXyuB40VleZ+qEc0s
	WbHvArREDoti5PcPRsOaF/K/+nZD/W348hrWVhp5n+RKik/FlwVbcZxR7mcr0U7SZUctIfG
	xNfpg25EF8MJcaiscuDT3sNGTc2KiwB86AQWdtSU/OulAeNEBr3+eE+S/lJEZfRJQrOLEOZ
	JcshoJpyIxmsf2p79K0pWe+D4YTGwaNXUlI4Mmw7DEQtRfK8Nm8gPIMpUDqj4pY+zdP1gXi
	/wx+agp4d4GS1LddkYwubuPPu8wVS7WIo/TGKCyDzEqDJ2APG4fqWpmHNt27oMgSuHuwOhS
	y8X1H+wcuApyW6iIxNu9zkZ6EFKpJ7ZuJePKxr/lvX9zZcbwVYUNDQD+WfbWcoyVAu7NA2w
	oR2VBMz2a2YGWLN7ynI8Gfz1R2BadhrhRZRyn37XNtc3K0JTPU+G1xAPjmbGzNGWjMt6cF3
	xODCKHV4Z4WAUQQ7yDoKJS6NPkNavvqWW9mwTzuzPUHyqANP5ioWiC8QzgSDJoCY8Cvt0+T
	nzhtdJ2lztSTZNVuhUJHxN7aCcd5d/XEqLzeTsxrMWKYMJaeHyEEXJwPk4bF63MW40omzw9
	l9enwR1UWMkNiuUSqot5Kg=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

When a UVC camera is streaming and the system enters hibernation, the
streaming interface is frozen before the snapshot is created.  The
original kernel then resumes devices with PMSG_THAW so it can write the
hibernation image.

The UVC streaming interface is not needed for image writeout.  Mark it
with DPM_FLAG_SKIP_HIBERNATION_THAW so the PM core can leave it
suspended during the post-snapshot THAW phase.  This avoids restarting
the streaming hardware and turning the camera indicator LED back on while
the image is being written.

If the original kernel continues running instead of powering down, the PM
core resumes devices skipped this way before userspace is thawed.

Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 31b4ac3b48c1..d44c17c99daf 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -559,6 +559,7 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 			intf->altsetting[0].desc.bInterfaceNumber);
 		return -EINVAL;
 	}
+	dev_pm_set_driver_flags(&intf->dev, DPM_FLAG_SKIP_HIBERNATION_THAW);
 
 	streaming = uvc_stream_new(dev, intf);
 	if (streaming == NULL) {
-- 
2.20.1
