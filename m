Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95DC39A806
	for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789932852; cv=none; b=boC4hPA4saOSEe4122K2hl+KuWxLTd+xHHa80pZnkFBDIiRvn6z/pGr8sXlrdapr7DJLhphgGVphfTsSW1BCGhA6wYiPthrReMPAI9lhIN0ESE0RdrL4a3TXT7YxVLqX7jtN8kHV8+Y6YMOzMz2ZgTINK+MNu83WwQW6iMnrSSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789932852; c=relaxed/simple;
	bh=X3rqSikcBZJJ2f84P/B10FJEqed1uxkrii+ko1G+OFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MImimA7bt3+kxFc2BhvEiQNOlI8SfSrnCXGYcO8n+1wnXSQSPnTAPqnBh0RQG8B0KvgyLs6hVPf63edYe3YrO1NSQfzT9hiP7dm47zxQOHt+o1ehhCPjrIm9+nKU8XEETuYj3uuEbt+pqBmzEjyIcD5MxzxPoxJWy8cvkBeODVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thinkoid.org; spf=none smtp.mailfrom=thinkoid.org; dkim=pass (2048-bit key) header.d=thinkoid-org.20251104.gappssmtp.com header.i=@thinkoid-org.20251104.gappssmtp.com header.b=uiodp19m; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thinkoid.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=thinkoid.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thinkoid-org.20251104.gappssmtp.com header.i=@thinkoid-org.20251104.gappssmtp.com header.b="uiodp19m"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93bfd70b08cso86471385a.2
        for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 12:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thinkoid-org.20251104.gappssmtp.com; s=20251104; t=1789932848; x=1790537648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oV+u2mUvdtVEqdjAmArbK2l37Qrm6P7TusAdIx4BPHU=;
        b=uiodp19myxAbDPa3KB+4ZfLcyS/yHTIbc/S8fot91iX+Uc/VV0kg/VohrwtslYbrvE
         fdJqV8qmgC9ut0sK5BVC/AKRLVOhH7wEbbqkrgV8iY3ayK0sv4rdT6ZQD/gzRvsXDIri
         e2e+DMVHYjMf/d9tRcLwZtKYo5q2Wk/2lF4IMzBBzAPe2YxN+GPG8fX7s4xqcm2OYhQ0
         Bj1/MrWDHtoIA9xmlW8jTPsw56aE56/DaPIVBK+KFe3iqWhGQqUWdL1+UEC4lG9dn32N
         DVSU5bSWullVlJJ+DxFRoN8K2j/h0HS1NmA45ZGKl6DfmXtcHI5j4WiWX3YgaqKSsIwv
         eoog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789932848; x=1790537648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oV+u2mUvdtVEqdjAmArbK2l37Qrm6P7TusAdIx4BPHU=;
        b=uxKLepyGdKNE4suGlBkyjUQvANHKplMVgfxs1KcgVYaPajChTnQrX6v9LZDqZ4kOi/
         OorK3/lVUrSmso9GK1AnqpFOudqqwhCvk8dlB24lva9tBUSyaYpWdBnkAa8kk9eAC2M7
         1KO5sFyyAMbPx6cShWLN4eTHMWRlFZRbLu6EX6IgRLDZVMnaXnwgx86aaIk4/VRzzrSM
         q13U02xuPLDao5Fht3TrG/jv2xQzZAdsyZp326UUNwb1UtdKn1sQcqdNwUqh/otQH5vJ
         fyjx0gopFVRk8ORC0Mqy7yB07hK6fb9kIKDB2b5mkmborhAfCa9a9n7bW9qHwcAnMrmX
         kDag==
X-Gm-Message-State: AFuF++k8yxnc8bTG361OIJ/Zs5QYccpyRHh35FTrED71EanYm+p9jk73
	uKCW5nsoGFTTjkOldnfufFg9rG1bli2ci/FCWxy7d21fEJyDPrAQNvd1qGx+TQaKo5c=
X-Gm-Gg: AYBFou1TgmMb3av2f2ONpx2ElO5Dh5pgS7Eg0vAX6HIgFK5KCEKbrGJElZijCd+B+tm
	wZeKBM/QVe1W1kePioA3kephNoixrcBsJV2P85yEbLa/RjEwwDhF/rYhVC/OWuYjm9OOEtcs2+S
	a9dkxUYhr7U+M+V1DV82YS1ubJvazLTGtPUtzKyc92lnQYqA/7CMPvk6Y96JgDmzBdxSBju4Rf4
	pVmr/2dKo7vr/qNHWuewG0UO/XqP4CeuqylL6srIfsgEAwWGDLMd5J9bIJx2u5FMkYrrPtz7+lD
	D4BVXJKxDbTA1AXZiIafgFregWxuW6OtQhdh8EQpmMpGzjhdULsVOBpNPSPYRAaZG4Rt2SGJ0At
	e2mTTTgeG17mfLuynd6ASPK6VdcPZdNOZFFz6+EhmgOeybx3X85hFDeDz5H3BCkiHiQgGYKlWxu
	bssJLKpQfPjeY3yCehgkOtS/teRjBy2Lt2iNTMg+SjonPe5QrQKMqWlohlmyPaNlZPV9+W98cOJ
	IPDs24=
X-Received: by 2002:a05:620a:4623:b0:939:6de8:43de with SMTP id af79cd13be357-93bf573f833mr703804685a.50.1789932848310;
        Sun, 20 Sep 2026 12:34:08 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:a61d:7a00::2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93bedb05a2esm464413685a.33.2026.09.20.12.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:34:08 -0700 (PDT)
From: Liviu Nicoara <lnicoara@thinkoid.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liviu Nicoara <lnicoara@thinkoid.org>
Subject: [PATCH] power: supply: qcom_battmgr: Report capacity on X1E80100
Date: Sun, 20 Sep 2026 15:34:02 -0400
Message-ID: <20260920193402.2402-1-lnicoara@thinkoid.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3f87baacea4d ("power: supply: qcom_battmgr: Report battery
capacity") added POWER_SUPPLY_PROP_CAPACITY to the SC8280XP battery
properties, computed from the firmware's charge and last-full values.
When commit cc3e883a0625 ("power: supply: qcom_battmgr: Add charge
control support") later gave X1E80100 a property table of its own, the
table was copied without the capacity property, so X1E80100 machines
expose energy_now and energy_full but no capacity.

The percentage is already computed for this variant in the shared
SC8280XP callback; only the property list is missing it. Add it, in the
same place it sits in the SC8280XP table.

Tested on a Dell XPS 13 9345: capacity reads 94 with energy_now
52640000 and energy_full 55540000.

Fixes: cc3e883a0625 ("power: supply: qcom_battmgr: Add charge control support")
Signed-off-by: Liviu Nicoara <lnicoara@thinkoid.org>
---
 drivers/power/supply/qcom_battmgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 7716eb9e1..a7237ba09 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -830,6 +830,7 @@ static const enum power_supply_property x1e80100_bat_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-- 
2.55.0

