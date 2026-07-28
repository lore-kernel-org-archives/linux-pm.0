Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450583EF650
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223919; cv=none; b=IE+GEnWSP5zKNzpbvLBKmIUtF96750Vn6xJtbX5QihImAJWkqGa0d8qdqM1v6JHA+rJw5ePoXzI364Z6kyyYDkl51MEtqssbbnf4wL2UtDTfAmQ7yEKbMjPOwl5CVEfG/eJhIIHh8h7ab1XR5OwvtHxtPBdX3XqO2t4YOfFIX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223919; c=relaxed/simple;
	bh=nHz26HyX2icLFETYR9Iev6Jeil3DeEl+pOtquaWQhWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pc3/3798Mrp/uA8Ga0b+LVQGvF8ya5EWBUrsMTluBSz/bFYj8RTySux71/2PmY70sFGYXjw4YsOqREaHu5iKZXQiScZO3H6hBkTXa8Zz655bl1hZx8esZwyhDi0SftMv0J8S+EaxlbmLTr/5Ep2iAy+afiFpMtOApWIqkKbrlts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=manifault.com; dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b=eBUiDwtn; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manifault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b="eBUiDwtn"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e9eaf04bfaso1092413a34.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 00:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manifault-com.20251104.gappssmtp.com; s=20251104; t=1785223916; x=1785828716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l5A0TG1ydLAI7SFr9to4UPVUQL8Gvvi1TATrMVTL7lw=;
        b=eBUiDwtnvdrs0NllzmxWMNYrNHjQ1q5ztSZhJ5XmgRyFwFIhEa5B+tGai7ezrw8kc4
         Yt8Tuv62yeCzwb/PFoV8DkPYNHVTZX/PM8X8fInyNYZsZxQKiyU/Hz622zxA+5flmx7Y
         9nkNUr1qZYgbfCAKV5k+WejjFY5tyEh7W7VjcVMOfJnSOQOkHRMJleoft4sbOIIVjfk1
         EEi87pvuEIF4xdah+J6/tOY7U/ksoXKmqmZnM6jsaS+Z7sIffC8Q9Pp7JXr8WWR9FWqZ
         ERD2EdEirfz3kqI0/Ri8VCMJmzEAMpufq1/91yYuGsmgLEKXIGb/ABRp4HoPbU4XlhZy
         M2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785223916; x=1785828716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l5A0TG1ydLAI7SFr9to4UPVUQL8Gvvi1TATrMVTL7lw=;
        b=YB8SG4Z8nCkK8hkc6xHvfBUHNTpSePt4swOY/xHkXTjwqmA4ZlfK0tdHCUGOksJ327
         XNnQcDSRrj7AARr8USosFoznpdfJqzSO0s9BP3avdGIMpAy5O9E7XUt4iD0D7S6aGDoW
         k/3zsB1ZbzPXk5TGFxoPd8DoDJACqNrYhe65m3Y5jD1pnzm3yMAFy3rkqIxKRupyNu3j
         CuSU4I/x/9f0FYbUIYgtcL2ybVaSGWJCCpTKx1wrL/zOXICDiKrsbpiwFnAdGvmL1mOP
         kRMcttpbmsuVTJciLKAMKt4x9Pb4c2Y0YP2xZNnKwIm41HnXgsaLCo+Uc2EzE/aucycQ
         VlJw==
X-Forwarded-Encrypted: i=1; AHgh+Rp7eGOY1lQmek5DprVJlxV2vFp5MzSy8JDXa5GJgDIZk73LQLxBMTufkqYMUsAOe4aSdlIElXXNiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxI+NKNmvTA9tXfLFpWsGYtqWHOPP6jKE8TeHUyRNbZMgn8gY8W
	8qrXo57F98EW08XdHkUGzNQJIb/zymDFctPaRWkiPgNWVv2xAwroyatIu64efGiqRbZ4HJrSr+/
	5BfL3ScYI
X-Gm-Gg: AR+sD11CIlBRUEvjclFmm3WM1fUyMHlgeRhriBvGP+KMcFynVXGh90M2YceI2SXyEy0
	mEttqlnqsh03W7WhbVPoCWdRXC7PHy9DmdQy5zLMdD/z2qZDr9dQkZ3J4bpF0UrgWHVB17UlG3Z
	2+dIbDaiD+CxWOOjZNCNdL1LUDwODIqMDcZVKHbY5aFqi8dFgY/ynIpKvQJac/Jrrr5lcBn9cWO
	9U82AitWdySctNe3UwzWZVZno3loLbVvZMfs/QFEdtt3ERZKi1nsVJjdWGJeeyA0TOa7XNqLuGg
	6QEPyCLi3yksg7I/yNoIwXPRDNMnYCEwsFs9Fk81YNODP4XoEMGKNGWZZS2TqkRWdXO+Gmpw5G0
	uT0ZoeSBwb4ZVgjLRilaOJuAD0gjqs13oFeItSjX6/Hn9zd/4xpMiQvYsiO2YWWE4oBU5ju1AQD
	4ISLicNZQPLDxlC9ll7dDfRnht8DitGeAmuox+1Q==
X-Received: by 2002:a05:6830:928:b0:7e9:5022:3639 with SMTP id 46e09a7af769-7efff036be0mr1163450a34.15.1785223916145;
        Tue, 28 Jul 2026 00:31:56 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a108679sm14304390a34.27.2026.07.28.00.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 00:31:55 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Changwoo Min <changwoo@igalia.com>
Subject: [RFC PATCH 2/4] cpufreq/amd-pstate: Update cppc_req_cached before writing the MSR
Date: Tue, 28 Jul 2026 02:31:48 -0500
Message-ID: <20260728073150.54964-3-void@manifault.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728073150.54964-1-void@manifault.com>
References: <20260728073150.54964-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

msr_update_perf() and msr_set_epp() currently write MSR_AMD_CPPC_REQ
first and update cppc_req_cached only after the write succeeds. This
leaves a window in which the MSR holds the new request while the cache
holds the previous one. That's fine right now, but a subsequent patch
will add a per-core EPP boost that runs from scheduling context and
mutates that MSR from the contents of the cached value. If we update the
cache after writing the MSR, the sched callback could run between the
wrmsrq and the cache being updated, and accidentally overwrite the
intended value of the MSR by issuing a wrmsrq on the stale cached value.

To avoid this, let's update the cache prior to the MSR write, as is done
in intel_pstate_set_epp(). This should be a functional no-op.

Signed-off-by: David Vernet <void@manifault.com>
---
 drivers/cpufreq/amd-pstate.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6e255a22a0b8..5d7debb5a35c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -262,17 +262,19 @@ static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
 	if (value == prev)
 		return 0;
 
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
+
 	if (fast_switch) {
 		wrmsrq(MSR_AMD_CPPC_REQ, value);
 	} else {
 		int ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
 
-		if (ret)
+		if (ret) {
+			WRITE_ONCE(cpudata->cppc_req_cached, prev);
 			return ret;
+		}
 	}
 
-	WRITE_ONCE(cpudata->cppc_req_cached, value);
-
 	return 0;
 }
 
@@ -312,16 +314,16 @@ static int msr_set_epp(struct cpufreq_policy *policy, u8 epp)
 	if (value == prev)
 		return 0;
 
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
+
 	ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
 	if (ret) {
+		WRITE_ONCE(cpudata->cppc_req_cached, prev);
 		pr_err("failed to set energy perf value (%d)\n", ret);
 		return ret;
 	}
 
-	/* update both so that msr_update_perf() can effectively check */
-	WRITE_ONCE(cpudata->cppc_req_cached, value);
-
-	return ret;
+	return 0;
 }
 
 DEFINE_STATIC_CALL(amd_pstate_set_epp, msr_set_epp);
-- 
2.53.0

