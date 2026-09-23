Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A8842122E
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185668; cv=none; b=HHxxdFYC8/chDS4F+IlQBPPP0vzRinbf4c8/WkpuBsJiCQR14iNseN9HOd40rQDmQ+GrJCmtqLeEjqhisSApvwAPClI8t1hh9C3qTBhrZGzs8Eca4Zu7lA4BqU9nsxrIM3OGQ5cGuz1+kK5iqX1Ya2eSn3UzBscKCO6iyvN422M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185668; c=relaxed/simple;
	bh=n6MwkDMMmdyC7Dq+zcQ57KcdXHon0jUo2EcFcUF/B/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7La8+5nbAdqQv4g72n65sD0Ep24AY6+xAjTGRFCiemzMMpYBaKZSvLqGjP6/Oh4ridUD6Zeo+YWwBhVD83Q3awHqhF3Z9FYynBS2qpNGd1ooyduRaFF8xJr1FFNgXvkFxBZD1d6tVoGliqzkjEEVAg8Lr2WedhLwWLmZAkLePo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GgvcH/p5; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GgvcH/p5"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-86b90133ae8so712782b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790185666; x=1790790466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XdnundYlcaGdSnMUNx2jzVtyM7k47JsxnQCk7S9RVjw=;
        b=GgvcH/p5346HEawsy0JGKsAHE70EAhAMYTxamZ9JMrvMarXvx7U5LPAwMT96RMHCRW
         zcL2DC3nk//tbPB+OrZ3wnVAN7oCa8R8qyM6HHn223G7TXTQbxeIj4WBN4mQCJTdatzX
         eDLYKhf12zepHgIYjqKbbRN2Tf7tn9IupLv3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185666; x=1790790466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XdnundYlcaGdSnMUNx2jzVtyM7k47JsxnQCk7S9RVjw=;
        b=1W7p6DX1oAN45Pw5EN81ui0MZXEkAkkYDQtt+fdUeAb9/KqBoCFnLcdPH45tgV5/p4
         HME3BNEjfdCpSHP60aVSvzyoyC5KNuXin/M/WE3Lyj0RDdPPe4bt3+NmkZCax/GdO/7e
         hJw3kEtHRYsW6+I2vY7E/P1wnCT559wrjk0AQV5nK45402/f5cUcf5tqURpqw63YnpUe
         e8jC2f8JPPZREEnpT1RwV3yARJLDIBni68hZB9zKhY6qrjvGeVKukw47tb2vJMHHakRe
         XFex3eUKl7FuU5FtUtLQD5tVpF2cIqA83Gs6ubDNKywaUIgUqkSsE5Mys5NPiY+fJrZ0
         ZD3w==
X-Forwarded-Encrypted: i=1; AKwUvBymsF86ZBC60WlsPGpHTvOZskjNFS18EuXS4aUBa18kDcgqp62TXd22sBBIDiQ9sIx1FOnMosug1A==@vger.kernel.org
X-Gm-Message-State: AFuF++m6LRrS+pR4ZvRKAElObX6XBdJyrEZ0z3sViiKCDNyiqARrG5rL
	dec2tR5DQKyNYV0Dx/vVkT3k4tiJUzZxSRevjDQvkAXHF76OBt57GZ9vk4usH8xHaA==
X-Gm-Gg: AYBFou3BKW7yLcgywQcS1wOAZMu7CAYeFmZTASZ5y8/lThgJkYULNvFq7l+mM3pf3tb
	vBjBg8iQyyMboagSsN+cPoDxDSMiOJZas+sBHICEsE8GW1EsQI7oXksl8GfFqkNijQgUeDlapgX
	9p30gv7T1OaqKeLjgfuufXrropejPYy3/zeQpxuOupwx3YHjDAVFdxnStqEEvngXgmZn4qvGjML
	/8KsSurs7IZRrjy4sNI8pLanPn0O7Rc5MKHIbsRhRKPKACWGw8fv23EEtlKSyFeOyXKh1kJ8Qx4
	pz7GSZIw+a0rKFv2pUbycNRnmS5oJ5Me4wZ5aqv5DdYBSfsOVjZc4/xoL9vaMoQ/WuhHIT/FpRD
	sGcYk1W2NXUt81FpsTExhB9bBS2CZBUkMjoiOpfKs8DrLPwat4JPRFEQyHR8kiYRn9umRRPqxnw
	YPnoLcC0boC3Gmg21Quz209n+HXJCI0+h++XHZzntci2aKYJdxC17Hxrlsl+iGL9c2imeikil2k
	EvT22FDGFxj+uMJ9NbeYGvg8SGUr1Qq/9S8ew==
X-Received: by 2002:a05:6a00:887:b0:87b:b799:370d with SMTP id d2e1a72fcca58-87d1a0b08d8mr2987166b3a.9.1790185666306;
        Wed, 23 Sep 2026 10:47:46 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:642b:a4c2:7ea5:5668])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-87d1cfbf839sm1796040b3a.13.2026.09.23.10.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 10:47:45 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 5/8] PM: runtime: Clarify ->runtime_idle() callback return value handling
Date: Wed, 23 Sep 2026 10:40:29 -0700
Message-ID: <20260923104031.v2.5.If6e26acac7770c65446dd0b81f891948abb38973@changeid>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260923174711.1283986-1-briannorris@chromium.org>
References: <20260923174711.1283986-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This doc says "Negative error return codes are ignored by the PM core"
for ->runtime_idle(). This is misleading: any non-zero return value
(including negative error codes such as -EBUSY or -EAGAIN) tells the PM
core to abort automatic suspension of the device, which is commonly used
by subsystems to prevent immediate runtime suspend.

Clarify that unlike ->runtime_suspend() and ->runtime_resume(), the PM core
does not treat negative return values from ->runtime_idle() as a fatal
device error, and that any non-zero value stops the PM core from
suspending the device.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

 Documentation/power/runtime_pm.rst | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 114c4a872cb1..423287fce34a 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -158,9 +158,14 @@ suspending the device are satisfied) and to queue up a suspend request for the
 device in that case.  If there is no idle callback, or if the callback returns
 0, then the PM core will attempt to carry out a runtime suspend of the device,
 also respecting devices configured for autosuspend.  In essence this means a
-call to pm_runtime_autosuspend(). To prevent this (for example, if the callback
-routine has started a delayed suspend), the routine must return a non-zero
-value.  Negative error return codes are ignored by the PM core.
+call to pm_runtime_autosuspend().
+
+To prevent this suspension (for example, if the callback routine has scheduled
+a delayed suspend or determined the device cannot be idle), the routine must
+return a non-zero value (typically -EBUSY or -EAGAIN).  Unlike
+->runtime_suspend() and ->runtime_resume(), the PM core does not treat negative
+return codes from ->runtime_idle() as a fatal device error; any non-zero value
+simply stops the PM core from suspending the device.
 
 The helper functions provided by the PM core, described in `Section 4`_,
 guarantee that the following constraints are met with respect to runtime PM
-- 
2.56.0.rc1.310.g51773c2048-goog

