Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1858282F1F
	for <linux-pm@vger.kernel.org>; Sat, 22 Aug 2026 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787392057; cv=none; b=D19xPFC3PplzOmUTe3g8ax9hx7JhpD7nVSsKfYgrTziQqohy4FDv/VI+qtnhHzhsJXV8AhOLio0gh4oNLoTRKosk72mOgnv6/Sr0iT9163rbaD2DgVU0IPAE0lNISnzhlASAhinaXwSCSRDOWB0fipHtyfA5UjZLjvK8FVpXDlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787392057; c=relaxed/simple;
	bh=D9OoENn65w9qMw3OOf6QdpdEmetlxpwv0r8psuzKfro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n1ais9lPhZ0CVp/Q/GKLjlJK85VxqfVENeOAm35984LIGIsCBFrb+EcxDvfMV6FsQkm6Lu1/MS6SRjvu2jFzovjjEsC4UUOKtfal7tX8/kBZTylUseRy+lvT+u44fNxPCgJQr5EBt0iNoyGcOXhWWPzrBZ0lNSE208oRPCOezY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgmIiFv6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgmIiFv6"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbedbaba5fdso1154773a12.0
        for <linux-pm@vger.kernel.org>; Sat, 22 Aug 2026 02:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787392055; x=1787996855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=90ARkRfsM0lZyMNJJUYej5kYseMm7HH5Ptx/Uv/OKT4=;
        b=UgmIiFv6Lb36MZjytwEkTQGjm/dd0JYZwxM5KG7XZoO8a/rxDaUMDPXrSrkrlLy0yy
         nU5ceFLCVP+837uYCRo4XEy+u4uQJ8s9NJlH8cVesh0TGjb5JZTWvxOVigXgQ2pg5kvG
         F2tAVEmjpd2djVFAnk1wGCb1DFq7MRFOAwueAp8HXVOdZhwHOOIxAzmmxDlXBforlIds
         EkcdxblB9Ki8qCRMSpQEnjZhE8NLgAoH2+juE1QsLa98xjXvwXmfTGJNcweJjEMNTCkz
         U+xwNjeacrocG6bv32SBUE/6fBh0+NLrRU18VmwBPbMiXxksq+ggXFTvTbkqAvUdqEDY
         kLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787392055; x=1787996855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=90ARkRfsM0lZyMNJJUYej5kYseMm7HH5Ptx/Uv/OKT4=;
        b=U/8JyymZjxqtf3+SdWQ+mj7MsNgdfW9LkKV/AtjtssJk484yI/Tjpsj1YurPu0zzjf
         5y5Jzof7ojiBqKEIYzujfPGTQLBxtTHAKm9m6pOpyQp1HPEPVs78p4YAMRqXvTCAd0H7
         IbOI18bb0VEQE/m5AAN4lbjUW7Xlgg0J6XCOTYQhfSYbktpD6Ehfv9rnL8DZ8PmdTWQr
         oo6Kbg9zlOKwlQVhZPJtneEBZo+89PatLbK5Wa+MvjMehuY2ri4NoerBx105WxZEaCQc
         FLXDCOFhOkEPy9hsXyfoHER1hviB80vj7YtDfMgG/c/kBijW8HuK79NcYwsuQnPP11SV
         UI7A==
X-Forwarded-Encrypted: i=1; AHgh+RqRuf1SIuMqRWQ2jFcJTjBTwE9SWgL1zzjQrKdAMjbQckdHA9+RfnjQjSR4BER+eJD0yeN6F+xarQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kqwFpcU7EEgJhQmSRpOT+yYMadNS3xFzrWzPxSXcyJl8YvV6g8
	FpFyrPeXw0E9M2UmQg5b3GnGhT7uLRnNbnfpj5qYc0VgTEDk1g22bS1B
X-Gm-Gg: AR+sD104qvcx5Y95spPt1ziqN/XMOvEQ/wPoSNrnawvAAan7G76wWrUUoXq+pSLNNm2
	2uU2Q7DiLNAm9eT0OV5pxpA3AMeS9KXJP/bf121pBEZFk5wTqTTtePlEjpuFT6tfe0d8wr55eci
	XOn7ZKCu8DFa1vyItmztErJW74Sqrqa97TPOMYWGpvJIO6hpAqhBxsuplnbEoX8fBvaX7U1dWW4
	kAuTXFN9UCy1wfssW9adaquoFP+7fdz5fk5ixUGzPY3FvsFthXKxPyL6zccSP9SJVOgmiI8RmHh
	jvqIh99/gVcqeV9wHWrI66cTUbowjyHbJPKTQAYm5eAwcivjDbbizyNhCtAwootkMOezmmCOIZk
	gj35j8WGRdyBWApPaCRpJ/huLvGHeK2/MK3GRaIEZSWPi0t8GYWxADKFwkhssqsIa8FJeVGN84o
	kKqpuVsmhvzICGZOXPv2heWsQjVbxinYJGwtsgfEU57/tlmCEAGpj4Jgks1qw=
X-Received: by 2002:a05:6a20:c91c:b0:3b4:8880:2089 with SMTP id adf61e73a8af0-3cd301784afmr24015511637.16.1787392055029;
        Sat, 22 Aug 2026 02:47:35 -0700 (PDT)
Received: from gmail.com ([58.84.62.206])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860c6e6dsm5527217c88.1.2026.08.22.02.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 02:47:34 -0700 (PDT)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH RESEND] powercap: intel_rapl: Fix kernel panic during PMU unbind
Date: Sat, 22 Aug 2026 15:16:57 +0530
Message-ID: <20260822094657.12489-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sumeet Pawnikar <sumeet4linux@gmail.com>

rapl_package_add_pmu() fails internally at perf_pmu_register(),
and rapl_pmu_update() leaves the global rapl_pmu.pmu structure
zero-initialized via memset and returns an error. But any
previously probed packages retain has_pmu = true.

When the driver is subsequently unbound or removed,
rapl_package_remove_pmu_locked() sees has_pmu == true and
unconditionally calls perf_pmu_unregister(&rapl_pmu.pmu) on the
zeroed-out structure. This attempts a list_del_rcu() on a NULL
list head, immediately causing a kernel panic.

Fix this by checking if the PMU is actually registered before
attempting to unregister it.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/powercap/intel_rapl_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 1006d183d508..22100f1ca222 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1652,7 +1652,8 @@ void rapl_package_remove_pmu_locked(struct rapl_package *rp)
 			return;
 	}
 
-	perf_pmu_unregister(&rapl_pmu.pmu);
+	if (rapl_pmu.registered)
+		perf_pmu_unregister(&rapl_pmu.pmu);
 	memset(&rapl_pmu, 0, sizeof(struct rapl_pmu));
 }
 EXPORT_SYMBOL_NS_GPL(rapl_package_remove_pmu_locked, "INTEL_RAPL");
-- 
2.43.0

