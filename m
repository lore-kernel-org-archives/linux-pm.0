Received: from mail-dl2-f33.google.com (mail-dl2-f33.google.com [74.125.229.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7C36B924
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736666; cv=none; b=fYqs4031BzI7SwDtRaQV8nW6Vi5Z4rROWlpTB6l0q4H9+q7M+iNm4cogc8miGixSYhvUyOzyJZrSczQ+XQ57Da+2MCbsqXl3E6Qm27HuzXYewmCfus1kh8Y1ZgDCQ8a18lxP5lAsR2Zi7VHu1RMchPAo6vkK+CWy+dTBhuLOE0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736666; c=relaxed/simple;
	bh=CEvQSVd9fcBWsFlrSUx992wsWzAaElAKnFEAug49VOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loGBPj7dBc77j0D7330IhGqtmpdhgxvDDGRjxWWJ3KGL5lafhpUASBQEU1jt0OwTieXoyNSOmY+YMoFlFOuZsKLJC4Caeepokx1W5OIpBstXWfwZbhBEBd6g2IxbAuLK/OmdpHGEBx5Rx0yNem494sxbth0BswEfiG9ubaTOGS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GNJh7COz; arc=none smtp.client-ip=74.125.229.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GNJh7COz"
Received: by mail-dl2-f33.google.com with SMTP id a92af1059eb24-1438e88300cso4689129c88.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 19:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790736663; x=1791341463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PNuyZkHjXDfl54OwZ1Afy6yUiGFdxCu/3F6vGj9C4zU=;
        b=GNJh7COzmxgVm3qY+r/0zPSnndPN61/aT9TfEwN+/pEgDCvsol9t7lwl8Y709kNyxk
         HZaoM63szGD8salow2uU9iDE/9NXVAil4E6iFW61ZI5fJK95JFy6FbZRlmw9T3SSjJGJ
         bEy9f2pwFU92YC/GRrNkqSELhkEMsGTYWGUe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790736663; x=1791341463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PNuyZkHjXDfl54OwZ1Afy6yUiGFdxCu/3F6vGj9C4zU=;
        b=Xc2566cHyiqYy7RaNuLnushFJ7gVrBZoKrLuZYQVH+t7S/Zm+glbejcRRMkv9sZFSI
         QfFjusKkt2qdc8x4GCv7FRJwPh1upMVF7XuKel8LJXdUrHWtcbZOzbwU4LMcoQSh4hdM
         FQa78BSEk6xuh7a/CzVXPa/LQHdlcWEhmIdiDqCC2cyszuSbThkbGTl4FjxSrq+M3zXh
         TRl8D/pRdT6ygg+lJ3K7k5iSos0S7c65QejxE/NGIr8Ih8QSrAZmFDsnlWvbGoGj/jnp
         Waf2UOieWWdWQzwE9HjMnHoIRZcRBKTGg9SeUcXmBYPX8ObmuUJlJFX+zxGtfL+mhhOF
         o3Gw==
X-Forwarded-Encrypted: i=1; AKwUvBxFMqCV+DAWsJ4zM0/DrdijTSExayCCHW9RdZBEuVy5heLDISIz25acgTdhvfbL7dwFLNkP/sCkig==@vger.kernel.org
X-Gm-Message-State: AFuF++l8zVKcKWjZcPY8xbupI5ST1V0ppoRNyaOaKqUXHCXUrSfBQ/ea
	4XhCi4Yikk+llMaqJUBSjnlsncN2rKYH+hvZn70VElQ1y7FWNAMmbLki9xBIT4MEvQ==
X-Gm-Gg: AYBFou0iisJUx/228TfLFG1itW0YZ8AqQpJ5ohkXsAQLpshy0Dl+drV/FeQ42v2IzN7
	pQSX+WEmJ7jAg5KCMatlBdc1LvXMNmKRNcEaX3jUromde4wJ64XN+8U9sDg0ahq/UnunlIA7HNj
	WO5xQoFO7z3rulI4jw3H/yLkvUPavQspC97REuRgNKd/4dVu2E/qhd71k+0bUaxUU+PQa+E5EP7
	7gslM+D2TdzvW1kMaEzPW6+T2Io8n0V7cZ263rUQ4W9TdTK3sFc1YYYXgEFLpG+Jb6sSSwpNoEh
	QaSJOzgKd0j980Ypga6oace1ujZB9TqcKS097Wi7jjPMIqI7vOkrxOW4oqMFpdIf3cUnj/Ldfax
	iRVXhFw+SkTie5T4FCz0L2sf4iNdo92UmxnfW4cpAW1hG/hG1YzZ5EVLjJnNJFg/pysQ2ZBq9GO
	t84tV3OAVzwb6zwwNNnnxExYJOJL2E75qbXk43gpoCBsydIFLVkkSAJJEr+hseeFk8VWaidyHW8
	yZmsMdkFzF23Xba4e7T8dqqCJJKjAHXMeuj
X-Received: by 2002:a05:7022:28a:b0:145:152:b547 with SMTP id a92af1059eb24-14c9be70a84mr1517330c88.1.1790736663479;
        Tue, 29 Sep 2026 19:51:03 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5f5a:aa9:d06d:b4a7])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-14d08fb4f9fsm197376c88.11.2026.09.29.19.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 19:51:02 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 1/8] PM: runtime: Correct pm_runtime_autosuspend_expiration() doc
Date: Tue, 29 Sep 2026 19:49:49 -0700
Message-ID: <20260929194956.v3.1.Ifc8b2d1742729cc82f46220d85c6382fdee1fc8b@changeid>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930025044.104824-1-briannorris@chromium.org>
References: <20260930025044.104824-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "adjusted to be nonzero" comment may be a relic from when this API
previously used jiffies, although I'm not quite sure about that either.
In any case, it doesn't seem correct today.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v2)

Changes in v2:
* New in v2

 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index bb008dfe85a1..7e75f6d5df07 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -169,7 +169,7 @@ static void pm_runtime_cancel_pending(struct device *dev)
  * Compute the autosuspend-delay expiration time based on the device's
  * power.last_busy time.  If the delay has already expired or is disabled
  * (negative) or the power.use_autosuspend flag isn't set, return 0.
- * Otherwise return the expiration time in nanoseconds (adjusted to be nonzero).
+ * Otherwise return the expiration time in nanoseconds.
  *
  * This function may be called either with or without dev->power.lock held.
  * Either way it can be racy, since power.last_busy may be updated at any time.
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

