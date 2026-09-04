Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ACF52ED2E
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556838; cv=none; b=LBks9L4CoLRLMDsG4+0ZH5kWgOGMl0WL3xN4CJRZVuiIsREr/Tt1B+ILHjBRnlBxRSC1oC1ryH209M0gZNDWCcReeZOypQAB76Xw/OO2UBjZKk2osV/i4erzqkiEUcpSSHvmH9akXBGvLs0BplzZJYKsF7ZZmCng68kmTirZa4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556838; c=relaxed/simple;
	bh=P0eQcHYcmOWKVxWCx0wymuD9OObSAIkm60t94YUG3AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqJzANfV5YR7C3GhbgvjAivNO85CnLRLFjiYg9U64yyNqHBp74onIlJBARmB26UsvBTwEda46P0rFBqsK+7cQNPO3rnJwfBebQkS56Zlay08kRaFLPVKKIzX4uClw1+bwHW58D5xWwObWf3YqQd8pJKpeUmNzFjYrcdAMJ7v/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gFbb4FyN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gFbb4FyN"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d8fd3b729dso13213475ad.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 14:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788556836; x=1789161636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CgbXePwlXIIaNUXfDEVIwWo//QzJGVGkingWQIsticc=;
        b=gFbb4FyN6xOvtQIsGa8E1N3FXjfhAZ74Wgvx2lqS8rrlRGRFr/nYvtLyaPvnogTzfw
         IHw6v41lruPymauvRZuhuVfSAGD3L9vhgvQxjj45/p5kTSoeRK4kmJTQusWNYVEaVjSv
         vyH1f7xbKWF+piqOwRVTK0y87O33SNRd+hAgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556836; x=1789161636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CgbXePwlXIIaNUXfDEVIwWo//QzJGVGkingWQIsticc=;
        b=sQ80xiH/S7uHt6NTAXZ7q7EwwMh0tN/wuMgyVJfdZAPXotnyHRNquyIyO9RZ8galDT
         Q41IiJGWXaIkTKqUQr8YfxAjnb9vK85UtJYDhx9ln3y0SJ7fcHO6MY6FVyKyGAeUjcPx
         4DALR2l8bqr4E7ac5EsLamN4VLx7asMzHGdXLvugpQkxdgnpqcgWDfyASlSuja+gbp6W
         1B82Oq0t15cAR9e47MRsKdpBfv8O3BmN37tNAJQk/EYLjYaRNqUDNjT9vPOY9uq0BZ0Y
         5JPixUPfsfcrgJVqRP5GVGOgcDd3BIhlJtBZQiVCnze4vv5ziV9fhenamVZ4KOtNeaci
         c6AQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBMkFWRiGOlWCZYlXAQYwcaugGn1Ob65JvmMXMq+tClZanpd1j+ae/a/5eGccwPB/RA5MsQdgE4w==@vger.kernel.org
X-Gm-Message-State: AFuF++liPXE9zS+8JI8RDWpIfTZJPkuhrlP4qovc+K5URZj+qkGW9pMB
	2zka7C0jnNw008dLWuOcnaBELfitjkalbnIxc+LV9JxnQrudBI3TqxkSHmtDgNEoSA==
X-Gm-Gg: AYBFou1yPAJlYMK1g7Fz1WveiC0S+xMvSzjyfZ45BfMjWpaG/oC6OexnhbaQp2n7B+m
	+wiC8hWisIhzJfq+y94bfgGBxwoGp7A05ewdqNPBglJlKdFp1itbtvQsPbo2VuICCYN8ILI4xpL
	O827V53ncmmrit9Xscz5nEkZ4qZxFWK6FOAODe4fqbYroGcqnkQpQUOJH4MCdowtOFi74zheOjs
	fNaOFQky8IXN1FGoUiE8CVahP4ireHoIcHNSQBV/jqOdiNAsBu+21s/Rh76ibpPug61StBaEC3/
	lD9pupVnBKgI9o+LbO1lgnN5OK/5QEeS4lHmLYSHErROuirviPMLJy3n+PfnTUHJtQOQMTWt2U2
	6umjhaQVQCO8W5+7e4gGp67j8TZAmBj3OKTmSDvuOHOtjJZM+PY/66cZTiLSr+/B5Umwq+iFG/C
	MiIRQF+S3MqLcqpagF8cWye8sIF6DjzWGR0/Ug4eTyDsEMEDMnIw05fpOMpQ70JdDqTGN34rosj
	z4y1rFCg0KAjZTDiwdu4BIkzvA=
X-Received: by 2002:a17:90b:56cf:b0:398:dcf6:d40e with SMTP id 98e67ed59e1d1-39b262aa580mr14262560a91.17.1788556836441;
        Fri, 04 Sep 2026 14:20:36 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5597:62ab:c321:4a7f])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-143243bfbe3sm8877936c88.11.2026.09.04.14.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 14:20:35 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 07/11] PM: runtime: Clarify ->runtime_idle() callback return value handling
Date: Fri,  4 Sep 2026 14:12:12 -0700
Message-ID: <20260904141215.7.If6e26acac7770c65446dd0b81f891948abb38973@changeid>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260904212000.4167880-1-briannorris@chromium.org>
References: <20260904212000.4167880-1-briannorris@chromium.org>
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

 Documentation/power/runtime_pm.rst | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 620b6988deca..334fbdcd8fd6 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -203,9 +203,14 @@ suspending the device are satisfied) and to queue up a suspend request for the
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
 
 The helper functions provided by the PM core, described in Section 4, guarantee
 that the following constraints are met with respect to runtime PM callbacks for
-- 
2.55.0.979.g7e5102b832-goog

