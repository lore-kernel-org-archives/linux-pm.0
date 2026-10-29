Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257713;
	b=3N4ynoblXprLJ8WE4EaWET+icgl8JJTvMzMoFh8XeqaVmprsoazK/owzYl5T4CXtS3q1
	 J2AAixXZgrI8BnOHc5CXCaJON688NCfClhPDtA5uQx+16yIbMRgYytMMPZNKWeKKkUcOF
	 VBOID7h+uqy1kdAVynpo/t/iWtbp2MTX4NXLuCXB5oGuID2UvJDSSIgvqgl13R2nDzqyC
	 gRxjLLnMZy50NP3ahN3xO36Ts22wKbWh9FKQ99m8OUBgS1DKUg9Urc374cxYqyCZs62Ru
	 D5NoKj5/fo+Ly5dTxY29IK/ilp7RHNUNaEXBNqTNaTIYs49RJ/N4JhmaabSgQX6l2WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=K3AM1SjPaLQrVo38ruBsuLHnWg43JcXaTUMKROby+Fo=;
	b=or6o+ARoBp8/xS/MgDmMlKJ08HxFa/OGXHNFU9YkEjsy2oBM0pCjjXHinnBXhLFrmMTW
	 WVpkRFsx7Gzd4sp2mjFviQB1g1sn7nLtSDrPSpOeXZjOAUaZTlPTktxXaxBQ5Xlx3AwBl
	 qY8GDzdrmGTBOBp+mPgmqxP32FMbrxwyGduVNVyVwnguH5ayw8twj/KcmK4iFaqrKxxB3
	 eorDcfkBdQiJOHevYtyy9lU2U5pPhcuWxN5OO03R6uhbwbjb5plG7wkfcnqVbaoAIMBb0
	 rrAhg9pNm3d069tgr6suOehKUuNR/sq8+axLO/oLeoTrPwhLoX+Qj/GwLf7UVYpXxRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Ay/HXkdc";
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305CC606A31D
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 07:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 305CC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ay/HXkdc
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd8b299b0abso1136060a12.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 00:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793257712; x=1793862512; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K3AM1SjPaLQrVo38ruBsuLHnWg43JcXaTUMKROby+Fo=;
        b=Ay/HXkdc42VKrrrHQ1rh+tKnXsuLOIa1OfJrZUcujGB5FqhWKSmQQZVWMYVPZtXkaK
         MNE2Mtr+Lkie5BhgtYxJe5Y1KyeiU2WMOeL8O6gxNtpa6te3Vbzk65XTKLWWS6r2m9Gk
         EnCkC33NAkCC1ie1dxu7f/FtB9/9jL0OWhkLfG3oJUriVxrRXhh85nLgWLLMkLLMaOcH
         CBK2OG2GrMuJPMfPdZsIastGuZLqFJE10MqhBcfAC9fWTN4Rfn68X0J0g6dr90EJrp5a
         jLGZJmtb+uHL5+lW8JZdyGJ1TRMtZUv4ml/QofdCPJZKtJd7x00ZD3LpGFy1WB/iDWFB
         X5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793257712; x=1793862512;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K3AM1SjPaLQrVo38ruBsuLHnWg43JcXaTUMKROby+Fo=;
        b=AqptFCYd+EelGCIVVEFeZJupyXB8jst9+mC7HUkrN6Yb1zDnwbsej/eRvnBpH5Enu7
         U6kUq5jY8AuMQUslVhIFRhsWyUE/AWVikCae+SLmMYuMbv8A9XVj518N4/9P4ovWKEFJ
         kdSdP6QXdaq1MdngbvrDaXZJLriiMEUeGy2Gb1klLvte027cUH9agKwwoqHLhA0eHvQI
         LMMJNCzIDlodLG+LI+1cD5hvyqIBvEMdv3tLRqjKZzb8T/WXcufncHxRCzVfQdZVVuen
         FUpJ8JdfoDwOXYG6ZI+0T12SI4VSlwOGuJbDR5kifu53yz9IVgN8m4wrrT0E0qhmFjYC
         LFTw==
X-Forwarded-Encrypted: i=1; AKwUvBwa9QEd/VRgkIHvngvOP/6BBCRshw6ejGBDMJPw0BqrWCbceiVdNcD/Fc7Nm7QRP2zGME/0xwP44A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJkEfFggYrAbddxYERWFxo/T4GCZtCUdNI7J2t/rppu6nqJYFBw
	HOxO5PvGp29KOI8OZVW5Qn2CglhY+G3IDX/rxcli72g1ool5Z3+vH3ilJJHSpfi2tmSik/F1zrR
	DRR+CGLDnMUx3FWe3Z808QQ==
X-Received: from pfbbr15.prod.google.com ([2002:a05:6a00:440f:b0:8a0:7c0e:8263])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6372:a810:b0:3dd:a009:3182 with SMTP id adf61e73a8af0-3e9023432c4mr3356622637.42.1793257712327;
 Thu, 29 Oct 2026 00:08:32 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:08:30 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261029040002.2100002-1-stanleyjhu@google.com>
Subject: [PATCH] scsi: ufs: core: Keep clock-gating hold on failed W-LUN
 runtime resume
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Praveen Talari <praveen.talari@oss.qualcomm.com>, 
	Peter Wang <peter.wang@mediatek.com>, Can Guo <can.guo@oss.qualcomm.com>, 
	John Garry <john.garry@linux.dev>, linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stanley Jhu <stanleyjhu@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

1. __ufshcd_wl_suspend() takes one ufshcd_hold() reference and sets
   hba->clk_gating.is_suspended while the UFS device W-LUN enters
   RPM_SUSPENDED.
2. Since commit eef1d74bf88f ("PM: runtime: Only set runtime_error on
   suspend callback failures"), a failed runtime resume (for example
   START STOP UNIT completing with an error) leaves the W-LUN in
   RPM_SUSPENDED with power.runtime_error == 0, while
   __ufshcd_wl_resume() already clears hba->clk_gating.is_suspended and
   calls ufshcd_release().
3. The next W-LUN runtime resume runs __ufshcd_wl_resume() again without
   an intervening suspend and calls ufshcd_release() a second time,
   dropping a reference it does not own and underflowing
   hba->clk_gating.active_reqs on UFSHCD_CAP_CLK_GATING hosts.

Keep hba->clk_gating.is_suspended and the suspend hold across a failed
W-LUN runtime resume, so the hold stays paired with the W-LUN
RPM_SUSPENDED state and the next successful resume releases it.

Fixes: eef1d74bf88f ("PM: runtime: Only set runtime_error on suspend callback failures")
Cc: stable@vger.kernel.org # v7.3+
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index cc75384c6502..9be370cea52a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -10626,8 +10626,14 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 out:
 	if (ret)
 		ufshcd_update_evt_hist(hba, UFS_EVT_WL_RES_ERR, (u32)ret);
-	hba->clk_gating.is_suspended = false;
-	ufshcd_release(hba);
+	/*
+	 * A failed runtime resume leaves the W-LUN RPM_SUSPENDED, so keep
+	 * is_suspended and the suspend hold for the next resume.
+	 */
+	if (!ret || pm_op != UFS_RUNTIME_PM) {
+		hba->clk_gating.is_suspended = false;
+		ufshcd_release(hba);
+	}
 	hba->pm_op_in_progress = false;
 	return ret;
 }
-- 
2.56.0.313.g2479322e68-goog

