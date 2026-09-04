Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48873D9023
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508627; cv=none; b=k+i9KqrF9oA8Y/NU6hvAaelmoGf1S735PH1hH5ZZWmzj9EWc74+wtGlvAT5Q85A45Xpqngdr6lGM4ZK0Q+m6R2gfJYr33JeHcEmiBbFOibKn0I2+iVTAssOYBnRx5OhwcfFEtg5c3VyA6fjp4fuqGgAvSSu9AjzRnS+XJz4S31g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508627; c=relaxed/simple;
	bh=aVDnSf0y+hMXWr8hLybg6AD3WaQCpewMz60QImDAXo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jS2Do0YvfBe9FwPp6BZFmn9jx+u/qAiQGSwZeJYvegET5FrvUVRZFoVeiySycCgiTJxhX/42RpojY32pNLKlRdFVBWTxShT5P3TpdWaFX1OKVV0arZ1Q+G/TX/OT03JyJAaNzadRkbtSrAv+gKWdSXph7yxQQeJgpBdTLg/hxEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amfyVfZy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amfyVfZy"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d8f2ed7bdcso945855ad.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 00:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788508626; x=1789113426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jWQHmm7FHocENum1rYYpf4ViVc4iq1jYrch0jAvV5fM=;
        b=amfyVfZy/wGOpn8p40yB65QgXV0kAEAn1iPbjWRERHkGEpYVPRxeCzWM4ceL2UbDvN
         K6Y8zgW5xLn1sDMI/GtAgKFT18bTmtutXjL5B48CagAeGpc7qpcUgCgjiPduFAeFTPeU
         hP8cg0kxrDVAOri6YXGGl+aYJoAVRC0OJHlKY+x1i9+wlSM52tORn56n0Ojl7olu135f
         jtzzRN/3HrVfPR99HbfbGl0+l4EVDLvwEvt0YgNovz+pXufqqyxxH6Tubt8EmRD+X1MY
         IvJA7pyFkVJFMkN4di5aPOR7s7yHxMkIOV6nzuU8WFu9z8/8HIZQJTdPHQbB4vYzhZIC
         6tLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788508626; x=1789113426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jWQHmm7FHocENum1rYYpf4ViVc4iq1jYrch0jAvV5fM=;
        b=c3yWNjyXH5I35J8jpPk1uk6uLPPDJ1ioSEj3I7YeJNZnV/8Qmm44aS6Zr/sMyAGDkR
         HAP4VL9Hbxg/Kpft7trC4x/PXosi5PojtrKgFPuTRfJ28kDCyKnYuJRcn2OZYy8D6lDx
         rGUj2k3NkfBOoHC74RIhAQNcQEcsPKqUA9y1igy9ElHyi+JJuqais6wWFZmHu/L0skb+
         XU7UekIRraOyllRml/hQ6v4iLheIpfdq32oE9G9wkfXlxuC9zwY3RFF1T/qAYnz7sKPI
         eH8QPk5yYEiRUScqxaaUfSN0UiK+xuRa/vb7DZ7zvw39XaKSz9SaPoLQizO0cRse21f5
         3Erg==
X-Gm-Message-State: AFuF++laFecVecU7v5a0+W/aejhLwSjI0Ge3MzqRb6s4HlQNJrooTl+S
	jtvxPLs8s6Hd4tqasZ9Sv2LaxFdZhlriwUEs25+H+QThB6OeHFRY2o/4
X-Gm-Gg: AYBFou3E861f/52Aendca7IZEBSu3BFBrC5YbNIR1yo1Z/Kx0AMO+IXrpa7pj11UG9i
	Yq99Kw99QFm/Vi1Xoz/R2fMunomfFrZL+PvB3didgeRv79JKM5Qee4xoyWH7kSXAmB95+CvuTie
	Oe4wRnU8PZrZBiz90FG5q/WdZ591vcnxTqk/DAXUl3/q9f80AsJQP3C0FYyE4extiPb2fyI6MSp
	QovmlM7MUWUu8mcNEonxQX9tsW6psniw2n4xpsJYm1wjqJsHBctdI5Nn2gIeqI646R/nt7ZUFaF
	YdEy3mD/8YAqDvKkhu2a6pjKqLxyec8qfOA2UE6UR9fdQHVW7myJ/ewUW3ph5isciuU/ypR7XKz
	BDUWkWg4l5dlKpXWKw5Y1Okn5HlvyiZcYEukdbtHo82w6ugKydrhvY7Hqa4dJ0DfWSoaOcEcwmf
	EKYuGRlGlruPqEcMN5Wg8w+1hABv+ZExtT0X7hVgVFZVlUHb+u9DytExBfVVj5pVC1BjeiLPgBf
	tsuClIBD3TzTA==
X-Received: by 2002:a17:90a:ec85:b0:398:bad2:c10 with SMTP id 98e67ed59e1d1-39b26301360mr4300158a91.6.1788508625750;
        Fri, 04 Sep 2026 00:57:05 -0700 (PDT)
Received: from fedora (45.62.127.193.16clouds.com. [45.62.127.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b261549f3sm3139517a91.16.2026.09.04.00.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:57:05 -0700 (PDT)
From: Frank Zhang <rmxpzlb@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] rust: rcpufreq_dt: add module alias
Date: Fri,  4 Sep 2026 15:56:35 +0800
Message-ID: <20260904075635.14840-1-rmxpzlb@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing `platform:cpufreq-dt` module alias so that the driver
can be automatically loaded when the platform device is registered.

Fixes: 06149d8f2216 ("cpufreq: Add Rust-based cpufreq-dt driver")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 10106fa13095..32a508d82f68 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -219,4 +219,5 @@ fn probe<'bound>(
     authors: ["Viresh Kumar <viresh.kumar@linaro.org>"],
     description: "Generic CPUFreq DT driver",
     license: "GPL v2",
+    alias: ["platform:cpufreq-dt"],
 }
-- 
2.55.0

