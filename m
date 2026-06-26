Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D153FC5D1
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491595; cv=none; b=FlZoGk0tvlVyK18eG+rWWviezUEOH0bvOm50JlZSd+tLvigyfroQCLoY6jqX+fuwO0YiURo8DolTG/jGR5vp3EGxrRs0/jsxuoCOtydCTz5cZ7BwpFGL5yaVMcc9nxc+IaKMiLCHyL17634VZhhiW/hj6UoHwJbC6jkPplzUw9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491595; c=relaxed/simple;
	bh=bg9znAoidL3T3xPeKitW5n5yYJtb4QN2AQr+a8OWug4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Tcd1kNr/gOZmJV3nbAIxaIjoTUVjgwSJzCDpJyT0EUU0ExziW4ufydobKc2O8IIQLBWooGwWlJZM6N0jDm0wAiYj1z54/w/RUIH+j2dP2WKrgUfyedhWtcNFVkA4eHHUkMuERJQIzHO6IIn5tTv1BgcnX5wJdItmygetBcRFAqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yv6VIaR+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qEeSu9lR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yv6VIaR+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qEeSu9lR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782491592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z6k9bAlUN3GR2gspqeApZc0R2eNHUyrDASVXA4THBoQ=;
	b=Yv6VIaR+PWiqOmUOdFjONj5bYK+YGF9e9a0rCZcpFUM2276YiZkOSiUjriARGuiWkTou9G
	2rzj0Kj1K/hDT+gndgW/+EwYZt1UAj1FIEdL5L3738r19tMw1sIozoGpJEinUptGyuQ0o1
	FFViNMbxNZixIYJE3MTiVfZB8Tou/hc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-dxH3NNDGNy-HIKFd1dPWfA-1; Fri, 26 Jun 2026 12:33:11 -0400
X-MC-Unique: dxH3NNDGNy-HIKFd1dPWfA-1
X-Mimecast-MFC-AGG-ID: dxH3NNDGNy-HIKFd1dPWfA_1782491591
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51768072950so12743221cf.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 09:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782491591; x=1783096391; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z6k9bAlUN3GR2gspqeApZc0R2eNHUyrDASVXA4THBoQ=;
        b=qEeSu9lRysxSg1rEn644VxZ6L0N4CCtozku8kYsYwH9j2GgaC/5t7rrw4STxgpWwul
         gAFVQRPCtdtogRuPcs/4w8rjO1rWebQ8phQCBk8tLhT/dT1FmzluEdtzaxQZ+bf+YWIs
         1CuQ7jkH5KYBGLJtGauI5NVaAfTjUHhMYrFzGyS/lp0dolwk2THhZCrM78gpVdDJR3rE
         ntYfuMQ12NE/mwBVhkx3EAF8yz0/npSCSvsS2OwrApxdW9JyRnVVVwKitR0kwgHwf/fZ
         h2jlPItHMz0GL+wCb9KbUyB75RSQVcSbVe/gk1U+kqv/X/ziN+jNQhRzJRhbhws9Ck8b
         xbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782491591; x=1783096391;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6k9bAlUN3GR2gspqeApZc0R2eNHUyrDASVXA4THBoQ=;
        b=VNFPD5kYeuu+Z6WIBwzukUiV1II+UL+S+OozD4o8UvuFeb4baaAkMnJQ0GBHJENamn
         0J5VI19Kh76Nvf9i1CuvfZGJbSdt6XJ0fRO8mebZCdCTfEaQdMqvzQCbAq8wr1ALp+HC
         jjO7eoyOReKE1nsbf0S3+lir10a04BUmb5sY/4yoybpGDyzsN8WK7QCscmUhBbBIkTCv
         /FK8XpFzCihqEqaMgTbSzI77ldFXepZR4pTZ4g4+oAD4iHYTytnPeQ59On7lOTLsU80q
         yn4Q/lACnWyk+n5W2gqioF6UvK7g2bhPh61C0MNC/otB7wwszxmrgBXbzxAP5t3hT3a+
         1xcQ==
X-Forwarded-Encrypted: i=1; AFNElJ9e4RhlVWBwv2nR98nTToCE1nsDFiEm0oBFN2Ye9+l8+ng0o3Xux/YxXNBTLTAEf3eQTcW/9Ks0QQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPqlm57vLSMzQKEsXnQR93rNd1HQS5Zm4AEawdG2iCutS2ciuX
	zvRVWQ81QfZRbAyjCawMak80UvUMS4h0SPsy3f/4ixs7vBtPzNwZZB8h6KVB+aSVlMpD6oPiO75
	pE3vAeMU8NO3vzrzTcBsxgpsohx8h9B9vyZWwc/ioF8FC9Jt0eE5ozjsWqXbC
X-Gm-Gg: AfdE7cmIEEbYCPU8GZPfrRhGESQIEOz96GZs5ciNiOJWZAC/n+uZ8Uev9keq5Fc1pNN
	uXNooIeAclBlZqvdyOe3gaZCpp8M8WmrhKORZr9x041YzcfJql9CMAr47lZHd1NQVSY5Msx+ymm
	V8vMp0UhMJJQY5doweFS/M55XFGqav5/q/4RxjXSWany7r1o/MiQc38EBouLdR3N0BEqvEeGvMP
	SL/o7PH5gVbu5CiYgq8fBotMr5hVxnq+C1hDFDZRV1sYzFMnA0cfVCJm3fr4rFcF2WMBcWSZAsb
	moxfSajLJ8GZImPJpj716FBo5R7eY3E0YH3r7uDKlri8bgWWFYahr12ZMUkdOaXFrbM5jnEmV0o
	DjVaHkQGqDmWN1nf8efXBSEFZD2xzM5PwWMdeDHoPvDd0PNZh2Q==
X-Received: by 2002:ac8:7f4e:0:b0:51a:8c99:1f18 with SMTP id d75a77b69052e-51a8c99223emr11336811cf.71.1782491590888;
        Fri, 26 Jun 2026 09:33:10 -0700 (PDT)
X-Received: by 2002:ac8:7f4e:0:b0:51a:8c99:1f18 with SMTP id d75a77b69052e-51a8c99223emr11335551cf.71.1782491589761;
        Fri, 26 Jun 2026 09:33:09 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f018566sm234540526d6.2.2026.06.26.09.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:33:09 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH 0/4] clk: implement sync_state support
Date: Fri, 26 Jun 2026 12:32:41 -0400
Message-Id: <20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBswF2JdJVqITTUUFo5EId49a
 fkW/2cQikwCQ5Mh0s3CZ6jo2gb85sJKyHM1aKWNMtqgP3aUN3iU5BKhm5WyVvfO2B5qdEVa+Pm
 H41TKBwBFMJpgAAAA
X-Change-ID: 20260626-clk-sync-state-ad008829a689
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Xuyang Dong <dongxuyang@eswincomputing.com>, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
 Hans de Goede <johannes.goede@oss.qualcomm.com>, 
 Maxime Ripard <mripard@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2145; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=bg9znAoidL3T3xPeKitW5n5yYJtb4QN2AQr+a8OWug4=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLLsVu6/yxxZGNTU+anKb0WYEWPKq4NtjJltB6tM1De8c
 b0WaqDTUcrCIMbFICumyLIk16ggInWV7b07miwwc1iZQIYwcHEKwESuTGL4H21R2rlfI/2AfmT9
 1uaZAaufLI771ptpemXTtf0m3HEHjBkZlrppH/+y8Pxd1QULVANm6ta93pfv4WKf26rasPMGu1s
 qAwA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

The existing support for disabling unused clks runs in the late initcall
stage, and it has been known for a long time that this is broken since
it runs too early in the boot up process. It doesn't work for kernel
modules, and it also doesn't work if all of the consumers haven't fully
probed yet. Folks have long recommended to boot certain platforms with
clk_ignore_unused to work around issues with disabling unused clks.

This series fixes this by adding support for sync_state to the clk
subsystem.

Changes in v3:
- Allow multiple sync_state callbacks in the driver core via a new
  helper dev_add_sync_state(). This allows dropping changes to the QC
  drivers that already have a sync_state callback since everything can
  coexist without changes. This also makes it so that this can coexist
  with the pmdomain subsystem.
- Only show "clk: Not disabling unused clocks" message once.
- Add Tested-by from Neil and Xuyang
- Link to v2: https://lore.kernel.org/linux-clk/20260616-clk-sync-state-v2-0-15f82c64d95c@redhat.com/

Changes in v2:
- Split out clk-cbf-8996.c into it's own patch, and don't call
  qcom_cc_sync_state().
- Clarify comment above call to dev_set_drv_sync_state() about
  the -EBUSY.
- Added Tested-by from Jens
- Link to v1: https://lore.kernel.org/r/20260603-clk-sync-state-v1-0-457120eed200@redhat.com

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Brian Masney (4):
      driver: core: introduce dev_add_sync_state()
      pmdomain: core: migrate to dev_add_sync_state()
      driver: core: remove dev_set_drv_sync_state()
      clk: implement sync_state support

 drivers/base/base.h     |  7 +++++
 drivers/base/core.c     | 29 ++++++++++++++++++
 drivers/clk/clk.c       | 78 ++++++++++++++++++++++++++++++++++++++++---------
 drivers/pmdomain/core.c |  4 +--
 include/linux/clk.h     | 14 +++++++++
 include/linux/device.h  | 21 +++++++------
 6 files changed, 127 insertions(+), 26 deletions(-)
---
base-commit: 6c94b38b83a04c43ea49004275f0391404051093
change-id: 20260626-clk-sync-state-ad008829a689

Best regards,
-- 
Brian Masney <bmasney@redhat.com>

