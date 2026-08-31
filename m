Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C94C4749C0
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191674; cv=none; b=f+QojT19JFlRs4RD4ZjydoGMhpyj6oUz36Vk3H67gHsPMf4M2lsALfXVgFBGL61XqsF9b959xTh08Z0QewIXqpJzTibmpGzcCi2f/mVPwqm1DFMebIN8NbcjmTgGm1z8sHWtkqqcn5IL9qz+m5fMQ/Tf9rpcGc6bdpH4bvfH+js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191674; c=relaxed/simple;
	bh=1ACBKGWFnRzB7mIrkry+VhzfZ/1U7/wkPLi5NxEehLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acNXupG1OELevg+1R8/2WZ0Kopvu0JCVKZw57uZAXnQ637T2wSG+zEKqgefn/+voXW3oVKXBMsfjJgwP4qgwqHM6tK6Wbd5hKWjv79yLhbnfEhtRD740Gyq/S5XCT7nia8Dp+1m7vBISowRguwA/dRrf2cNy9igP1p/+psFumwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ga+tp5to; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga+tp5to"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-484415c8bf2so95889f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 08:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788191671; x=1788796471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ASvcEdxyqVgpQZwCMt7dzVrotri8xOjcCj35/ZBDavE=;
        b=Ga+tp5totCQONUdcJWX+4wZUuu++eZRBNXqQAexHGP4dAcD8u3NWwv020ifqzIfDBA
         grZRkrbkgOvTemeKgayV1pqJL2eveZbePFtvBcmX6D4bep27NLaFFGdofpXwg6sQss5i
         QR99IwcSVh/J+0NEr9OuJgecz5Vu/snHN7rGD32bLrG2N+s8aluF9ujm1emGVsOjURZd
         IrF0eN8m+WlJYIYlt2y35yeo/e7ISeYGJDO2Ee9DlO91/CNmlWYj9PVFkdegzKjpUOq0
         vKDHi3HJqKmp9e5GaKTdh46pKQj4izMJZR06d+RcQxi4T+8Dpm4JVgj+7voJSgr9h8rg
         NLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788191671; x=1788796471;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ASvcEdxyqVgpQZwCMt7dzVrotri8xOjcCj35/ZBDavE=;
        b=krW4QruEGYfJA2DVRtC0hlZnuyFKZXRi9qBzlp7ljOE6pJ/iAY5/1EVNvos/h51rLj
         dRLWm/Fb+Vl/Y1t9QqqssxGoN6zvY/kF82ITRzdKPZtkMLAN2zHM9q/uejkEx4gBNHku
         Ql04MZUGENLlvOX02LBmFXh71uf1WUsqVd8zcHZoYXwqBKaAg9DRzmAJv46ekSsMkaUv
         pFq+Ftcjppt4dyig4tHq3JW6zFsSjLSxB21bik5FUVKR/DL/vRPI1OmTRAB3DiS3MPHj
         IJUysdtBF5Wc81CTjWqHBj0qfZ+eqDAGLCcutVVN8GsTKryfNCuIvqXMBBKriL3K9n1e
         W7Gw==
X-Gm-Message-State: AFuF++mR0egPaE1HNzNBPznrS2A9VwtffPWUwJykCVmFN9uDTio8U6hJ
	7uHQoDeB2/bLyI68ci/VARLXbZsrB3y76UWmIQ7hhaFFIJ+wQ5E1bhKYESnrcgRGivs=
X-Gm-Gg: AYBFou3zanaOr9w9sMCQ7xS3ZwMKO+JX8W5IGc+I1Qp27gB27phfeB5IUHhxlAPWMC/
	2QZqOkTSKgIYtnXn7ecNyeKuU9ub782V0/qOP9lNm+DFOp1CWRAb8JoTrU+o7c+nnY53UlMkAtu
	o2wKLhLeqr9r7QGZAuyJVTnXGem/VaWH3RI0OQ8C8WxKw+Egi6Y+6gietpKhGCk87dRc/e/BW9b
	nezYpVmWYc+GpXyCdXBfAgVTTlrutdvZmeL7/faO45biyRWL7OnbRSjbKNoWZ6J+ETC5YCOS1+5
	5tNJz0jDluprQzErjmAwvKRa6yE+jyg5YQgXHNgaUQzQM2Yga8WlumlzI4m0iz1K3ynTX5JHjmy
	19gnU5exMjaSk2ZnrH44aPs8slljiHqUVmEmrlkMKpSSoWKiWrPDvQbEBqEUV4VXnyHZMzBiqT4
	zDIYerjr4GnghUybSUindoS8DPuOFYeTuSEzL7hAcnxTng35tA3jjJd+uRUBTrjDc0JETIxKZjD
	XYNkefxXwJLKCbT4muZuadi
X-Received: by 2002:a05:6000:18a1:b0:482:bf78:300a with SMTP id ffacd0b85a97d-482f79c78abmr47604037f8f.17.1788191671171;
        Mon, 31 Aug 2026 08:54:31 -0700 (PDT)
Received: from unix.. (244.red-81-44-253.staticip.rima-tde.net. [81.44.253.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48436e2af3asm12949099f8f.12.2026.08.31.08.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:54:29 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH v1 3/5] docs: power: fix power_supply_class.rst status, health and time_to
Date: Mon, 31 Aug 2026 12:53:37 -0300
Message-ID: <20260831155339.181487-4-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831155339.181487-1-ivanrwcm25@gmail.com>
References: <20260831155339.181487-1-ivanrwcm25@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Correct STATUS/HEALTH references to POWER_SUPPLY_* enums in
include/linux/power_supply.h instead of the nonexistent battery.h
macros. Document TIME_TO_{EMPTY,FULL}_{NOW,AVG}, fix the "operatable"
typo, and note that MODEL_NAME and MANUFACTURER already exist.

Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 Documentation/power/power_supply_class.rst | 26 +++++++++++-----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/power/power_supply_class.rst b/Documentation/power/power_supply_class.rst
index 6d11f8c594a0..c60aa7ce717b 100644
--- a/Documentation/power/power_supply_class.rst
+++ b/Documentation/power/power_supply_class.rst
@@ -82,7 +82,8 @@ _NOW
 STATUS
   this attribute represents operating status (charging, full,
   discharging (i.e., powering a load), etc.). This corresponds to
-  `BATTERY_STATUS_*` values, as defined in battery.h.
+  `POWER_SUPPLY_STATUS_*` values, as defined in
+  include/linux/power_supply.h.
 
 CHARGE_TYPE
   batteries can typically charge at different rates.
@@ -95,8 +96,8 @@ AUTHENTIC
   to the platform is authentic(1) or non-authentic(0).
 
 HEALTH
-  represents health of the battery. Values corresponds to
-  POWER_SUPPLY_HEALTH_*, defined in battery.h.
+  represents health of the battery. Values correspond to
+  POWER_SUPPLY_HEALTH_*, defined in include/linux/power_supply.h.
 
 VOLTAGE_OCV
   open circuit voltage of the battery.
@@ -202,16 +203,17 @@ TEMP_AMBIENT_ALERT_MIN
 TEMP_AMBIENT_ALERT_MAX
   maximum ambient temperature alert.
 TEMP_MIN
-  minimum operatable temperature
+  minimum operable temperature
 TEMP_MAX
-  maximum operatable temperature
+  maximum operable temperature
 
-TIME_TO_EMPTY
+TIME_TO_EMPTY_NOW, TIME_TO_EMPTY_AVG
   seconds left for battery to be considered empty
-  (i.e., while battery powers a load)
-TIME_TO_FULL
+  (i.e., while battery powers a load). *_NOW is a
+  momentary reading; *_AVG is averaged over a fixed period.
+TIME_TO_FULL_NOW, TIME_TO_FULL_AVG
   seconds left for battery to be considered full
-  (i.e., while battery is charging)
+  (i.e., while battery is charging). Same now/avg distinction.
 
 
 Battery <-> external power supply interaction
@@ -251,10 +253,8 @@ A:
    to add it and send a patch along with your driver.
 
    The attributes available currently are the ones currently provided by the
-   drivers written.
-
-   Good candidates to add in future: model/part#, cycle_time, manufacturer,
-   etc.
+   drivers written. MODEL_NAME and MANUFACTURER are already part of the
+   standard attribute set.
 
 
 Q:
-- 
2.43.0

