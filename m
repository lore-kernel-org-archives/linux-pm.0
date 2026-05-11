Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80870331218
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778481750; cv=none; b=USPDVacINuV+/UptZxM33ihE+KY3YdLt//vOD//k3J6lSAekW9w15v/Nz0Lfbc2uK0GLgGVXx6yvdIm+2XxyDmbotdHw/WvWA/wfUgzyX5l5MlCyyMgkHSp7XubSrbindtmiSphp+Uq7MGcNacBvACa2fHNiZn/u9Az0am8oD+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778481750; c=relaxed/simple;
	bh=aqOreI6fX/uZN/lEw3smALiG7YxaCe62+LvjMxRJqj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7fOhH9D1OXaqEauDcUNZ7BIQWceZdOhHCDrmYoOZ9JnjDnlfDRqY0y3iKIR0ZsA5yDfsCE7tl/qDUngVvPwY9D8B3FMgyw9zcwY0jCAK1xfpCchcu69wce3O3jzB8JhiTyOsUYik+dYgXqWuq6WaVO4zKvMPsxkqwxyPtXkU9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=G23YYp66; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="G23YYp66"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8367df48711so1725101b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2026 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778481746; x=1779086546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6WETen+kRNNiAQvSfnOnKOKODS+5kYfhp3vdgbGUFvE=;
        b=G23YYp66afKKdS1/yKrOpuu7iRiNGvR5H8hQRYpysbYLSad7TZOcUzcOvixDOZvlYD
         pMoexS4VlqDwwm0WegrMRaUydqdR8F3mmLPyOmsXEpUAnxPGBxBBnZkcmffYpGJyGNVt
         y1qdrmAKFvX/hKMGxQB+FAHloHYbIYNLeOzMK9edX5a3GxagB+CmDJ9YsgfAGs9Ss4AS
         XMwjLo/2YsGzzz+1NoDnc98cQoF59DEg3hjQkY6RQ3iqUj+xdOfq1ZLD1BYhxFZ2rUkj
         qZ0hAhBqzHH3m0/tdUd2MRy/zKYCaKd0E7sQJjKOghfCM6vhGXNUYoxZ8fFGAy+0e9+O
         kPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778481746; x=1779086546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WETen+kRNNiAQvSfnOnKOKODS+5kYfhp3vdgbGUFvE=;
        b=lcWbwKCIoc7RFWN12QOaf+c4nHbFvHMrG3Yq141MorROpe/ZoQeYvAxg23gmNHX9mz
         es8HY+BqqOSZwOIQ77b6I0EtzCwmOuJcOLNll6v12ZhZ6BBVJ7DIy2HWM2XsVNOtZ7zY
         cqGdohAgCChUycoMQXUEXp22BYYVDhP5jpi7/wdzDSgCnP3YF58ojK0+PCFfZYCyY2/k
         f0OLAWdGtlG413bBovntlPlgC2Oy9L04hUrbVsrciyUbIgQdTRQwjW9mA3tVyHOTv2S7
         Xg5bkRrs5Faz66yzvQiPO98f7D6cflCbdlB1/Kw7lB4oqsEFkAEIQct/kCXmAJLY5rJN
         n/ZA==
X-Forwarded-Encrypted: i=1; AFNElJ9PExMvPH1j83sJNgPdpcZ7Fy8psV6Px2OVs6FDgj6Y173dXYS8Ou897AJGG6uWjyn62WXKtkXGlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbMIgZOLr4qzhqoMbAdKBrcDnkfY04KdgiF2XEafBLKxgkYPng
	OT3rQ5rmrwwrlc8hWc73jRvTSVAiILNI5PZcWYU2m+SVBhuUsMHv37zBb/g/hpR5pkQ=
X-Gm-Gg: Acq92OElAobtd9lVVwDaSxahnlACZNp1ONtOdPdIMfNqn1ZLo/uG2ttTHslmYlMlwPW
	qCNlu8Et2gNebJEb6XoCB60A1FJKZhOeEsQrlWiICvfgR5Qu0UR+kWVZGC/whuPkR/z2NiLTfDa
	pbkFVo/d9eRjIKEX0ZMOX3/6KDG24R+/+NTZ0vMKwa2H0UEWXlQKc+Slhdle/Za5Ywsr9fhf/Qm
	YEcc0E4xuX/bgSmJJg9C/H59EFyLGHFYJCYBJdY3PLjF9T1GEUM3snYilxSrGoQDp2USQC2qHKf
	RuogAg+oiBPjWQWfGVlaety7DDcLIYeuNeIvuadnUhPCOQC31EwpzRfAgFzJhMMNXQOCNqLw2hH
	r4i7CCYT/tw7ao4BETLSzUD+QU40bm7Woi3ii/d2sEUV4YbrxIV1Pb0EZYdvPqttPR9g9GBr+mp
	kiCaRA2mP3K6gv9MB2VY+FlZY4Ibk9q0uH67cGWZhoYafI/OLsnEf13LfPNEiMGBTu9MId5hYxK
	b7MB+uJFVrxaKbptjp/Q4Ggq/fnv6NUX2qf+7UI/8MkbRVMXqxPoEECcQ==
X-Received: by 2002:a05:6a00:12d2:b0:837:e9cc:d470 with SMTP id d2e1a72fcca58-83a5bfbd016mr22454757b3a.20.1778481745668;
        Sun, 10 May 2026 23:42:25 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-83967dbcf36sm23339343b3a.41.2026.05.10.23.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:42:25 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: vireshk@kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	nm@ti.com,
	sboyd@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jcalligeros99@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] OPP: of: Fix potential memory leak in opp_parse_supplies()
Date: Mon, 11 May 2026 12:12:11 +0530
Message-ID: <20260511064213.33638-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for microvolt, microamp and microwatt is not freed
in one of the paths in opp_parse_supplies() which returns directly.
Fix that by adding a goto to the error unwind ladder.

Fixes: 2eedf62e66c2 ("OPP: decouple dt properties in opp_parse_supplies()")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/opp/of.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index f96adfd5b219..c02e20632fa6 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -673,7 +673,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 	 */
 	if (unlikely(opp_table->regulator_count == -1)) {
 		opp_table->regulator_count = 0;
-		return 0;
+		goto free_microwatt;
 	}
 
 	for (i = 0, j = 0; i < opp_table->regulator_count; i++) {
@@ -696,6 +696,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 			opp->supplies[i].u_watt = microwatt[i];
 	}
 
+free_microwatt:
 	kfree(microwatt);
 free_microamp:
 	kfree(microamp);
-- 
2.43.0

