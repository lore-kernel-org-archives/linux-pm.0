Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC91316197
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 20:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782333118; cv=none; b=iLzjThj8cZuqF+MUbk+DMYVvLHZLcXNPEYT8d99758quVmLswYcPKor7LVa3pAX9PllIDSC5Glmp4RmrHXfq91LeOuTShCO+cLcp8HYhWWxunpe2y8XqvdAKQ/slGZ4WXtr5BwlZnv0k41W0HuuFiR6Lfw74m00Y4LevrjhHbJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782333118; c=relaxed/simple;
	bh=DOAD2CjWSFTRRHDBzlKC4rST39Ld3+cgTNsHdXfxePI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AudOMDjpr9kWjauhp2GlPNQ/yRpk2YC+D7/TNkbAHK9qdvPlzZOYXXRhIB4YSZATRACMdmR3XQa+hafVgugbBPr7UtE6BmXMBQJ1ShQ6ruTPYczBvzy0cTxlzJCZxm6zdCC829+KFg8sQn9ia8T02SEhrHBPLRUDAelHRn2BH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCQl1snI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCQl1snI"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso9685405e9.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 13:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782333115; x=1782937915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDktcxKViRxImw/W6VGUuZ2Igzx47Ciytf/NkxSnUCk=;
        b=FCQl1snIqTriGkvmnMpICHzuxImLNMJljJAbxB6zqKOCQSQxMK0smDDQh/c7iz0uRy
         scISV0HwQQ9QT2fJihsmGwO/0tD1GntndvwKOD9O+rXIKs1r88JoBqMDKNnnoNaEn14s
         c2VVQ31YibsXu4ItXvo54M50Sx7zqDSeCkXMZzGInkFdG2Ys8jorJHpoE44ZHdTsQoDR
         vTh1CBBPRsbxDYG2lxrGrs+Ask3ECYgWNHkFZCPkF3AzlhCdAOZUnbaQ5u+kAVl3Ze+F
         zOFwsd911T5/4yY6/CGFkUsMEs85fYmA4N2JpeV10mV6baRqiIyV+LXdtDiceDfPQr2b
         9xJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782333115; x=1782937915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EDktcxKViRxImw/W6VGUuZ2Igzx47Ciytf/NkxSnUCk=;
        b=eu1pOls0zNn5LTzAEfrLjaK4NWzgtK6bwW88aZgJQVDLHEvhI62ZemhlbfYvwUaX38
         IDl+He1PAp5UeJvRA+Z6QrYYM+pQnlRV0FehFCirIhZIUP+PpWwLbkjTSqwaPGPanATg
         wgn5xXf4YXQEp4ZX3K9+KSr1duv9EGw5Jrrid1PWBPcMoeXFd1LEq/ZvqGWeHcsVrj2J
         Idkdq5YAVeqWTcVlR74ODe6qnRIbXjL494ccugxV0ETcabGSs0F0sngkJXHUi+wkKxDe
         yS9Wg9bVIw/BFUqRCQgPx49IruZNO1oEOz1kDQ4xvQEAvW/GbkcR/29tXX5al34dFnX9
         80Cw==
X-Gm-Message-State: AOJu0YzHrPyf1WLMYla986Si24dlRJSRdfNrhNfN+jOfLr3wR2r55Wp2
	Yh+GHGm3GySXGVDj2p+hZ9PXL/E/zK78rveaYp8iVFV+/Hzn8z7FoKgdgzH2KYoU
X-Gm-Gg: AfdE7cnmjv5S4qtBWNC+1PdbGo6DQhL9GTHalvLwhurn6/T6wEGHeEWUQ6Zwi2AAYJU
	OFRdYpTAA0tVCYezLqBFF9drc3lSmAIw/CnndtC50dBHLfuwLjIJTeFTN4xi53K/IxbTAC3xoOR
	N1xqOjIuF+SSx/3CeQ4p2u1lBswGOILIeGg/JIlTGAjcvrBTBwfsax0ahwy3mLt7+JO4DmadWLk
	lFDSlsMelu0vbblgpVWd7EjEs1KRFn2rnVdwGvSRbS4syO3c3j/TWQN1Kf5J4Gc3x+VWwuawtfH
	CKbIA25xI8oiTGlknwpgWPTI/uuODBaP0/p+9Etxm+2ypnV59wdCnPcq4myNQevSukT0hQGyoDv
	vohRT37dmz4heOY4RmX9h5LiN/bOu/+eocflBiUu77j108y0TgDHXiwtNSIbTSg26mHIUWUbv+q
	7TygIWbc055bv+HUGgkxKY09zLvTPwl520kFzm6mKQJ3ml08Vg6UCjM6dWk+r07EVj10AU/qawN
	fLNexbXJrCUzgZ81OIroBYpP2U6Lj2YcsKlvTT94TdX
X-Received: by 2002:a05:600c:3f10:b0:492:5bb6:6d4b with SMTP id 5b1f17b1804b1-4926088031cmr69513275e9.34.1782333114396;
        Wed, 24 Jun 2026 13:31:54 -0700 (PDT)
Received: from localhost.localdomain (85-250-93-211.bb.netvision.net.il. [85.250.93.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49264022e7dsm18736795e9.6.2026.06.24.13.31.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Jun 2026 13:31:53 -0700 (PDT)
From: sivany32@gmail.com
To: linux-pm@vger.kernel.org
Cc: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	linux-kernel@vger.kernel.org,
	elazarl@gmail.com,
	Sivan Zohar-Kotzer <sivany32@gmail.com>
Subject: [PATCH v2 1/2] powercap: dtpm_cpu: Guard em_cpu_get() against NULL return in sysfs callbacks
Date: Wed, 24 Jun 2026 23:31:47 +0300
Message-Id: <20260624203147.67528-1-sivany32@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260611204658.47987-1-elazarl@gmail.com>
References: <20260611204658.47987-1-elazarl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sivan Zohar-Kotzer <sivany32@gmail.com>

em_cpu_get() can return NULL when a CPU becomes impossible. Two call
sites miss the NULL test:

1. set_pd_power_limit() — reachable from sysfs via the powercap
   constraint power_limit_uw store path. If the CPU has become
   impossible then pd will be NULL, return the current power limit
   unchanged (no-op) instead of crashing.

2. update_pd_power_uw() — called from CPU hotplug handlers via
   dtpm_update_power(). While reaching this with a NULL em may be
   technically impossible today, the check is kept for defense in
   depth against future refactoring or subtle races.

The other sysfs-reachable path, get_pd_power_uw(), already has a NULL
guard returning 0.

Fixes: 0e8f68d7f048 ("powercap/drivers/dtpm: Add CPU energy model based support")
Signed-off-by: Sivan Zohar-Kotzer <sivany32@gmail.com>
Co-developed-by: Elazar Leibovich <elazarl@gmail.com>
Signed-off-by: Elazar Leibovich <elazarl@gmail.com>
---
 drivers/powercap/dtpm_cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 21355db64..886cbe922 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -47,6 +47,9 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 	u64 power;
 	int i, nr_cpus;
 
+	if (!pd)
+		return dtpm->power_limit;
+
 	nr_cpus = cpumask_weight_and(cpu_online_mask, to_cpumask(pd->cpus));
 
 	rcu_read_lock();
@@ -125,6 +128,9 @@ static int update_pd_power_uw(struct dtpm *dtpm)
 	struct em_perf_state *table;
 	int nr_cpus;
 
+	if (!em)
+		return -EINVAL;
+
 	nr_cpus = cpumask_weight_and(cpu_online_mask, to_cpumask(em->cpus));
 
 	rcu_read_lock();
-- 
2.39.5 (Apple Git-154)

