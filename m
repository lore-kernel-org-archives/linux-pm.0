Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1535140D588
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223927; cv=none; b=cUk5q6W3GKqYehxOv5Z8UQcV3cHd7KWCTtzcLdiizyYQBRhU5pFmUVu85x8N99lL+pe0x2n/lyDmSMgyJDyZ5qGg52hvpAXda1F0ADAnM+Fb2fHMUdcoMOd11IAFubc+r5y9b5Qp43lk6LfmsjFkURCUlGUsoBQtL38f3Ht2MbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223927; c=relaxed/simple;
	bh=7qBIsb7cZtls+1Q4n80+8yqOlu8lXYGX8HbJOH3oTEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbjMDaG3mvZSE1mAjTkcrHuW5VEsxdxypx61j2lCyk8ZkOzNqble0F59MsFQ1Ep7+MfeZPar8DZM3326AguOYRqfql1zVFkZOsYpbnn7dQUB1ukidci4RFoMp/ijLWUvK4C+af1tr5VIBerHVmT4aMa3rssKhJPbkWdsgbeGwDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=manifault.com; dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b=HfEeOXjQ; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manifault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b="HfEeOXjQ"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6aae5eb0ee0so1214574eaf.3
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manifault-com.20251104.gappssmtp.com; s=20251104; t=1785223925; x=1785828725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TBPFV7mE/o+ifYMGJXqsFhj2vvcUzVogsfKmm2PsKxY=;
        b=HfEeOXjQrpSdcTFonnG3MqgGNEbpqBLRIel01E4cfu6T2a4I/+I3d6V45qwuq/GfaM
         +xt4kKR5eo3tpe0BFGA0of5yu18GhD88l2nJQh593he7LKBmeOR4y3rq2sKet4B6VCXe
         pLYna2WWYzWLe+YEtOPhOmsHZPsBKYiPhXbWiofaWbqNwsNNYVejEM7IbdhswUUCF2nJ
         qp+mpZXu4rN/gdvdJFpe4RE9TKUBfsxgRnZUYQhl/QLcLubzQdl20DiZwQ9UUOcX+Luc
         t8AT6ZuN7Ir6sD+BRyEmJalJk5vnWe6WNauE/z+lvclFapAR+1AlSKqel8dVwmaVbw+m
         usiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785223925; x=1785828725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TBPFV7mE/o+ifYMGJXqsFhj2vvcUzVogsfKmm2PsKxY=;
        b=AsIxbxwr7LYmdAgxLl0ngRFcUDPzbfjrhtk8XXDGmQCsRga9yLwCqBLIDFZ0zHXzxe
         Rcxw5DL1NA/7vcWMvQaM0leofxtYow0lKd7RNKflBr8mth72mYqfs5++gzrgEY1lS+ad
         NNBCq+3GIXwEB2vULvRZiuQpWEVreRDNM/f0bWeBBEkBI0ZYM5zJf8dnTJt8sompafWy
         LS0zANi+LDyK5HxjuySJ+sHay3cCfQhbbK43UZZo2/xcVtSu15/Kcnl6iAZCTqExLirm
         2GC3RpbdXu+QwvvqW/GyOC/FbcYpGr+U2Ok8XM9Vg/kZkEmiKsd3394GoYXSc5r1k72n
         YDlQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTVrS/l8vxhzvOyuj52BQ7Fu4mUOxdjzG7tV0v7/p9oF9bvk70azp3JHTU04MnJKmRQ5zS4eGnZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxduWL+0GUoNHTw2DE02pnpwiR1sdxNQR2Veuq0zySbMDIw2+/5
	urcOIhnd9uKbG2niIDfoXKlTqXynk2VORqxAv8YYO7OIkRBspOsjCVc/+5+vW6sStCEB
X-Gm-Gg: AR+sD119qfTlEPoarDQQslYi4A6oy/GE1sVopEsEHrbqDyHc4XVaXgnlM4NGN7WRLC5
	U8qL2mOHvEJ+9cJyEaODP9EAU61RkCN6xgFwCdXrmoBWg8dJOKvYnjzH7Z3LJnSLApMeXvRiBEs
	DC1nHgHZol1Q2bBkFCyFTD0np1IolLiDgW6fDCmHFGxjswBFS2dDL9pPKBYGxvxUxdrBvwTvRPH
	Aq7AQCq6Mr9eMvnRPmSlVMISrnLGL5pAzi18UzQPotDIi2Dac/7AQETjebzyel0u0iJnSUBkn89
	L2qOI6JRcPXRQAQAHXoR6nkuo9gglJtVch4Ja4arvnbm86w/XGYR/RF7LTtxFSrSrsfqufI/gE5
	8zWwy3GxyDIS2BZbOa2fJTCaKMEEh6CL5AtPdFGK/xhNR0CzwBtiRT0y3I4TWjOtpyjSAD/51+l
	ESpNaJ5j6btzbD0FtEpmCIW/TMs34H8rTlUHUevQ==
X-Received: by 2002:a05:6820:3397:20b0:6ac:9779:ce07 with SMTP id 006d021491bc7-6ac9779d811mr461472eaf.59.1785223920141;
        Tue, 28 Jul 2026 00:32:00 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aaf9385b35sm6699039eaf.7.2026.07.28.00.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 00:31:59 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Changwoo Min <changwoo@igalia.com>
Subject: [RFC PATCH 4/4] Documentation: amd-pstate: Document the epp_boost parameter
Date: Tue, 28 Jul 2026 02:31:50 -0500
Message-ID: <20260728073150.54964-5-void@manifault.com>
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

Document the per-core EPP boost mechanism and its epp_boost module
parameter added by the previous patch.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index a95e2ebce005..004b79ff925c 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -372,6 +372,22 @@ based on the power source and will not react to user desired power state.
 Attempting to manually write to the ``energy_performance_preference`` sysfs
 file will fail when ``dynamic_epp`` is enabled.
 
+Energy performance preference boosting
+======================================
+On MSR-based systems running in the ``active mode``, the driver can optionally
+bias the energy performance preference of a recently-busy CPU toward
+performance while leaving all other CPUs at the policy value.  C0 residency is
+sampled at most every 10 ms; while a CPU has been at least 50% busy within the
+last 300 ms, the EPP field of its CPPC request is set to ``performance`` (0).
+The policy value is restored once 300 ms pass without a busy sample.
+
+This behavior is disabled by default.  It can be enabled with the module
+parameter ``amd_pstate.epp_boost=1`` on the kernel command line, or at runtime
+by writing ``1`` to ``/sys/module/amd_pstate/parameters/epp_boost``.  The
+mechanism only runs while the parameter is enabled and has no overhead when
+disabled.  It has no effect in the ``passive`` and ``guided`` modes or on
+shared-memory (non-MSR) systems.
+
 ``amd-pstate`` vs ``acpi-cpufreq``
 ======================================
 
-- 
2.53.0

