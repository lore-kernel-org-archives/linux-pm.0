Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862924;
	b=bL/IJS7r2mTXqOU5TxI18RWVxuasZMd4n56Hlh9byOz9elMbwmSuhpNmVnTqTis2zmzd
	 hxLqZTuUX1F8uwb9fXGra9UPSQB/8gFre3El4mLvz1E7X0P0V5ib50blKuyswoX/Z1Z1w
	 yX5ze03r3nLkVZZ06EMn7UEnye+JjZJDg5FVidVV+vi5BCx4B7TK+08gC8gIrvgIzuwI1
	 2N3wNHeorJEqjv/ifK1cA2f48n1cYEI+G3eYY4cEKqz4DjLoxDwjedRMHgBuvrIFqqvO1
	 l4S0YCOf1F9LHK9p3EdbZPok8AeYsfHus/tMst2DmZ6ur4mGG37sD+o2rYKVzmq3Ccg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RI12gLHnesKv62FPCjs5sC7shOFUJ1v1NeOwQoemoh8=;
	b=DgBovmOVc0FIhrMGSzni6IRoXrfQv3+Eo87B3PtiHAq98MtA9Z+boiu54f2438oBlPW9
	 USaWKtQB5+Q97WERRJJ4E8JwT4zGaBEMAAWiSLa8s8pg27A8DlNhsgHvr2w8KiLQv7p/0
	 NNk9iObu4UPA2+ik9axyb9x38HNtrp2J3tF608dZK8qpi4hD8wit15nMVgTYcJzFW8V92
	 t/fl2gbutZ4KhtS+l0k1OQiwW2Sf72J+oEfBZyfrJ+HtmqW7RMYa6MGA/kzH+bgp4S6TF
	 iEimEZYwF8wX9Y5Qy4ID8ehE86WudDhPk8xnX23uM0uk6t8JMjr3+e4Luh9374lWzFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=brVNnJD7;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E17606A33A
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 07:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2E17606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=brVNnJD7
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc7d2ff0087so1140608a12.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 23:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793862923; x=1794467723; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RI12gLHnesKv62FPCjs5sC7shOFUJ1v1NeOwQoemoh8=;
        b=brVNnJD7pXtFn2O4Us0ktmHWlimJXIFhlrU9YGibCHjbLNiubieX326XKNStjCFntD
         3golXOKmCisIIWmAxV3Xn+sJvBeJoKzQCKhwYsEsG8BqAUYlzACZRB5y+p4j3kwyGybe
         pmN/h8IZQybaABPE5TNCI74ZZ/T0ADfJGN9bt2zN+rgdEl91PDNDQZKddursoR65TR/O
         x1H7OA4pe0xj3PJv8ZVJrmAI3wI+0lrCb0F00Yx/UUxwbLXTINHJ8JuTm7exThzXntfM
         PKxOWvo6wckB1jtN1Sq5QspKQllcWRn4w1RCpt0iRKzfrG0xzSV75UFQlLcyDGws5s3t
         OmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793862923; x=1794467723;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RI12gLHnesKv62FPCjs5sC7shOFUJ1v1NeOwQoemoh8=;
        b=vdLLQ6jmdvXRXSId2bFaIp71rcqVQkS368F2w8aMQJBNV+97+o3jGSBAJgP+bfs7YS
         KTP0+X4YZoBxgqvVWQPBl8qB4ZKhlJcgXBc7mGlV4jv3L+wffDBeq5qewR5b1WpBSpLD
         yEh6ugGj/FoOOpCBhEUgpk9ISDNruxVySBU97Vdl5pdsVyRNX3XrCBat5JJUSpjhl036
         iRCstCRqJa89HnzaU7jckiI78Gsc9J8cY5OtiHrB+eKYdsJNpQQ5S3bgEA3gmI0NlOZI
         1vTxrQZ6pC2Z4sMQtMyWjNY04FoCO2SVoIPonUPreG8yPSqq1cFjUnAcSKvl2eH559zp
         fwkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQI35P+HIGu4KQVsBSKNA7j+/K/ES3zcZ1cvWTy8daQ0oXBCXpt04CnnCt7CgB/AB6D2uFFhHNYQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8FXlGOcwrWkTwUIoCxgrjSZcGtz6Ced7Ng9INwYBlCvDWpMm7i
	QCQpd/H+2QCHcZuWC3gph4krbYyRgHjmGBGmFSzqM+0yw3CR23qN0R+/g5uUAy3kTsCjl+y356W
	Kk5UnT9Um+oVLNMNbw1rOOA==
X-Received: from pglv29.prod.google.com ([2002:a63:151d:0:b0:cc7:492f:3ac1])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:2982:b0:3e2:1787:da07 with SMTP id adf61e73a8af0-3e928dd8de3mr15532220637.56.1793862923106;
 Wed, 04 Nov 2026 23:15:23 -0800 (PST)
Date: Thu,  5 Nov 2026 15:15:17 +0800
In-Reply-To: <20261105071518.1458428-1-stanleyjhu@google.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105071518.1458428-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
Message-ID: <20261105071518.1458428-2-stanleyjhu@google.com>
Subject: [PATCH 1/2] scsi: ufs: core: Skip redundant variant resume after
 error recovery power-up
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>, Brian Norris <briannorris@chromium.org>, 
	Can Guo <can.guo@oss.qualcomm.com>, Peter Wang <peter.wang@mediatek.com>, 
	John Garry <john.garry@linux.dev>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Praveen Talari <praveen.talari@oss.qualcomm.com>, linux-scsi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"

Since commit eef1d74bf88f ("PM: runtime: Only set runtime_error on
suspend callback failures"), a failed W-LUN runtime resume leaves
ufs_device_wlun in RPM_SUSPENDED with power.runtime_error == 0. If
error recovery then powers up the host, ufshcd_vops_resume() is called
twice in a row without an intervening ufshcd_vops_suspend():

1. __ufshcd_wl_suspend() runs ufshcd_vops_suspend() at POST_CHANGE, and
   a failed W-LUN runtime resume rolls back through vendor_suspend: to
   keep the variant suspended while ufs_device_wlun stays RPM_SUSPENDED.
2. ufshcd_err_handling_prepare() sees ufs_device_wlun suspended and
   calls ufshcd_vops_resume(), while ufshcd_recover_pm_error() leaves
   ufs_device_wlun in RPM_SUSPENDED.
3. The next ufs_device_wlun runtime resume calls ufshcd_vops_resume()
   again with no ufshcd_vops_suspend() in between, leaking core_clk and
   iface_clk enable counts in ufs_qcom_resume() via qcom_ice_resume().

Track POST_CHANGE variant suspend state in hba->is_vops_suspended and
skip ufshcd_vops_resume() when already resumed so variant suspend and
resume callbacks remain paired 1:1 across error recovery.

Fixes: eef1d74bf88f ("PM: runtime: Only set runtime_error on suspend callback failures")
Cc: stable@vger.kernel.org # v7.3+
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd-priv.h | 21 ++++++++++++++++-----
 include/ufs/ufshcd.h           |  2 ++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index e55c2a02c1f5..9e4d8174a0f0 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -236,20 +236,31 @@ static inline void ufshcd_vops_fixup_dev_quirks(struct ufs_hba *hba)
 }
 
 static inline int ufshcd_vops_suspend(struct ufs_hba *hba, enum ufs_pm_op op,
-				enum ufs_notify_change_status status)
+				      enum ufs_notify_change_status status)
 {
+	int ret = 0;
+
 	if (hba->vops && hba->vops->suspend)
-		return hba->vops->suspend(hba, op, status);
+		ret = hba->vops->suspend(hba, op, status);
+	if (!ret && status == POST_CHANGE)
+		hba->is_vops_suspended = true;
 
-	return 0;
+	return ret;
 }
 
 static inline int ufshcd_vops_resume(struct ufs_hba *hba, enum ufs_pm_op op)
 {
+	int ret = 0;
+
+	if (!hba->is_vops_suspended)
+		return 0;
+
 	if (hba->vops && hba->vops->resume)
-		return hba->vops->resume(hba, op);
+		ret = hba->vops->resume(hba, op);
+	if (!ret)
+		hba->is_vops_suspended = false;
 
-	return 0;
+	return ret;
 }
 
 static inline void ufshcd_vops_dbg_register_dump(struct ufs_hba *hba)
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index be62165b785e..cdcaccf9201b 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1038,6 +1038,7 @@ enum ufshcd_mcq_opr {
  * @devfreq: frequency scaling information owned by the devfreq core
  * @clk_scaling: frequency scaling information owned by the UFS driver
  * @is_sys_suspended: UFS device has been suspended because of system suspend
+ * @is_vops_suspended: tracks whether variant POST_CHANGE suspend is active
  * @urgent_bkops_lvl: keeps track of urgent bkops level for device
  * @is_urgent_bkops_lvl_checked: keeps track if the urgent bkops level for
  *  device is known or not.
@@ -1226,6 +1227,7 @@ struct ufs_hba {
 	struct devfreq *devfreq;
 	struct ufs_clk_scaling clk_scaling;
 	bool is_sys_suspended;
+	bool is_vops_suspended;
 
 	enum bkops_status urgent_bkops_lvl;
 	bool is_urgent_bkops_lvl_checked;
-- 
2.56.0.385.gac671c819a-goog

