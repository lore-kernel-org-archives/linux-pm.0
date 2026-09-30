Received: from mail-dl2-f39.google.com (mail-dl2-f39.google.com [74.125.229.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8345C36B92C
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 02:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736683; cv=none; b=mzcVkeedabDLDA0vfAA1g3JPqzoFoXYpBRP4tnEMYxT3NzYQQQgw5++m8S+AGPYxXN08L0iNB1Ci+wlfWWt12M/2PI4VZkftRH6nHn0Q0yQ6O8zrOOxlo/+Ll5LVWzSWMrKON0/Az8m4IJGcBEoSA1cvP8232InU7oC2cTerOc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736683; c=relaxed/simple;
	bh=vTZx4gCnhDGfJob7Ma4mwhOsNP6hIrB19vRqS8gxLXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkTfYn75PSf6oaCMXTqSIS0DHHT7kB0AJaBK9RuZxLC93vaGT+ddK9LTn3zu3fAEW7inFnwmAgA1SseLYbuyDQKyrzlVu7l4sgxxvtjmWDfEo9fSqR01Jk19hDRn6P2gRjN30ze6DR+2vYSiUeQleCi8FL5pC1alE5b2KQAJzOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j7PzxGVN; arc=none smtp.client-ip=74.125.229.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j7PzxGVN"
Received: by mail-dl2-f39.google.com with SMTP id a92af1059eb24-1438cb9b3a3so3627127c88.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 19:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790736673; x=1791341473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=99ovinxsFoVp0y9um2d4xLdsMEAJmWbWSBDRVa+kv8A=;
        b=j7PzxGVNQ2hGYptcVF58X92d8bA56YpegnUeZSfiF3i/0yzxpv2/GtbCBb44n1WXs/
         oNqpFRTTkiAJl8MLkxCG0WTbGglCHI5vB5iMM+zfH34K25msXb1e1nBkgIN/+MJeCWDe
         EomvacT3lmGLSK6l0avken6ZoSyq8ruHVcKeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790736673; x=1791341473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=99ovinxsFoVp0y9um2d4xLdsMEAJmWbWSBDRVa+kv8A=;
        b=YKokyj3wrWEpNNacUKYxqIxqDh+Dme9GDyHMrcGZ58cFqZ1aTKRdBt0adjKqjLKhoQ
         /5xWYZTVBqr8Enh1GoW+yry+Rt7yRzs2JsI4ZfVKhw9J3AFAYtdKT60xQQpaDMhRbxGq
         ot3UsBNwlYAKYAFW1T8kJAQqu8NXth41NVMEF4uNl5FhjAteWqTRQkQJ8Qz3wR3jR3pk
         moSRMzmSfw2aRh8rZrjNmRWhHRz7jSth3UuWHty0Cn3DW/bAoOCupbrEGrHdTW8TMdQv
         VQ72y7SH8+qnJ4oMjLKe5TdTcdwFW1Kxi++XJyyZwrbLibcvocMrnTJWBuHOQPoV88sT
         qaww==
X-Forwarded-Encrypted: i=1; AKwUvBxqzJOp1eOliilg54DL4j5/d6OrnZRw8byVQFA40AgzjtDG7o3XJGqJFcUzc+PM/Yh8qw1DaVCxOQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kMfGfkkuO9WrleVk19viN8K696qUnNSl/msxDx6aMRCFbrP+ae
	mgaTcD8ZijLXVwST2goiPvh+RxR2L0EPXq1pY6XdH3Unb+6d6chsPoFHpHeQpLok9Q==
X-Gm-Gg: AYBFou35rHnX4u07wMX0Q5EX5AWsjwYwrWlHcNps7TEcQn4X6Ck/Rwwek8JK52KTAd5
	jHdrlPDqZyD5z3uKBuqTL883Ps2+kRLGqnpQXILnEUYLVqpWHNxgNscYz5JixwDM45zI4wCiPNI
	19zP9zXbwtyALXJZmRMNwX7hVXaadQFSm1QhkojWtvlX/tbAlV+Zt4Dk7sWMt1OM6SOZgvfSla+
	5g9dP/k382pGxXs+8siD5LlHAmzLiYwl4zowkYR/wJVEMjxbH+Hr/CneO9lNeq8K88I/Y/4V5W5
	KAxsJ9my4uEZQvoBe+/t9/C4HnkAsMCwHcLiyHqBRqKt4Nt5HtdBT0qU8YsBfc1oDV662mZ3wsP
	sj3GYUw/J16oAlApiC1hsVe6gpkZV6XreXFRedpQc9w7xIHKdTMYsoysdATHUR2ZT71P3TkDvYs
	QMoxrku0qM6YiP8N640wANCom031y9Y0Ksf37OpR0jy3tscPxjJMJZoAGH/MmSIDhShcRZPhwwO
	jB/M/FU4+PN9d0EtMu1we+gcphHP6CDM4BW
X-Received: by 2002:a05:701b:2813:b0:143:8829:5fb9 with SMTP id a92af1059eb24-14c9ed38c49mr1173391c88.16.1790736673424;
        Tue, 29 Sep 2026 19:51:13 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5f5a:aa9:d06d:b4a7])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-14d083fe728sm229335c88.6.2026.09.29.19.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 19:51:12 -0700 (PDT)
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
Subject: [PATCH v3 5/8] PM: runtime: Clarify ->runtime_idle() callback return value handling
Date: Tue, 29 Sep 2026 19:49:53 -0700
Message-ID: <20260929194956.v3.5.If6e26acac7770c65446dd0b81f891948abb38973@changeid>
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
index 8e93766bdf99..6fe20ad8d3d9 100644
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
2.56.0.rc1.315.gc6ed9934b7-goog

