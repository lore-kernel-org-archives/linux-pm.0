Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D64439D6E9
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301461; cv=none; b=iwUYxTHtSo65J6BYJH/Bk5YyOMWekjpCRSWECEBQT0ZuLoSDcc2mAIAJer7kTwFcKNDjyeuwqyfdwnUEiX8gNYH5c/5pe4ZWVgqG5FK3Q+HSMCMMK3o9jQYZAQ+YPkAE+U120Y/HOBhxJvmFbGA0BKE2SnYLVtXV6DLX+lBgGio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301461; c=relaxed/simple;
	bh=0hjtDmnb0Zis+QIiTDWT6gSJZkrditBrLuVdf0ojKno=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KxsYk8HrsjG+ir2vw6TNiCfiH9g8A8bMisiqnp40zLl5t8bOhtQjtwkcDeKRozupI1lFKhQwA/Zq89Jtv/NPdGbA6ea6Rp4r+cHz3VKwEsnw7ecSTWUEOD+zAv4LsUZvdvOHmGQjJ0WuSLD1DBYcaxiXUA0u2YPj76xb0MdjeQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MBWBUYGL; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MBWBUYGL"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c86487a8ce1so1285964a12.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781301460; x=1781906260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FwfALyYv5iIjDkR2BsHILgEmJb0xzCyjlsaJje8jH74=;
        b=MBWBUYGLzdHu+Le3q9tCl8BHV2LLrlmbwc8K/WYG/JZt0a+L6jfYL8KDIHaJSAcTmI
         CTXYoV8IbAfAe2p4JUN5W9HmCEP4ykmtsKwORfaoaDaD2KXykrc1oAfZZdv4wb253wzV
         Jx6rUuJGPmjS5E23xD70dapgzgU8NkAsJ7lVk5ipyoQcP5DL3Ymb6CZgEYrYo4etn4ST
         1oauO4bJMn55RNPu4Mo7cACZdFivT9gMkJE0J15XZGyYZgLunXs7jsJubEwzf3a6t9I5
         3h+huEcgR8omhHxIgna/xRtVTWp3ez4dDgLVa55E5qf/E9pcI2F7ea0wycnSMQpS6G1U
         TvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781301460; x=1781906260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwfALyYv5iIjDkR2BsHILgEmJb0xzCyjlsaJje8jH74=;
        b=Qwrd4SgWc8e7mLHCuNgPrkTFdJCnK6aO6Zh6bMqeTpBxNBORLB+W2YsgAGaWquL7Dv
         qo8jDPIlTIcIM/SXGRv5l1wg9x7a0OllS43BW/aOTwITlDf5GBlzf+DBdgoOzvQzHtQG
         Oq+5ZNvr59slHMyWh7ZT8prHW+ITipqHtQPOMK3/PuLO7EVunjz94TfE/SAxwgAjIDkw
         WOXu44cWz7scM3uAxeovR39AHXsWbZnO+8FtJdI/g9isyMhB1QmMrpcd1eKzVCjwGABV
         eNo6Bf2zPF5MqJ7FCFIj6Snapgl94fSrSjMoXy2YEVIYq5o418liniTOjzFw5vMmBc8A
         pARw==
X-Forwarded-Encrypted: i=1; AFNElJ9SMNKgHuhcpwj3e8OPA/6lOV9xUoSltO2SW9USzsNY88vefbhNI+PLGPe0n9mJylQEbTsG70ytEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUC3ufQQ01kgFNWMHTjMgjatbOm6zn2PqMEntCUfAjJvjCnOR
	ZgIOj7vU8PkavYi8hB2iUL7UuRldqbbBRmO2XGvMw/vWTX5Vo5Ok56DhZBue2vH3OjOYUUbQz7d
	8cy0ffJcDSXtnFA==
X-Received: from pgbcr2.prod.google.com ([2002:a05:6a02:4102:b0:c86:93b:4965])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4d8d:b0:3b1:cce5:9140 with SMTP id adf61e73a8af0-3b7963dc7d2mr1533879637.33.1781301459758;
 Fri, 12 Jun 2026 14:57:39 -0700 (PDT)
Date: Fri, 12 Jun 2026 14:53:19 -0700
In-Reply-To: <20260612215729.1532175-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612215729.1532175-1-jmattson@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612215729.1532175-4-jmattson@google.com>
Subject: [PATCH v2 3/3] cpufreq: ACPI: Avoid racy updates to MSR_K7_HWCR in boost_set_msr()
From: Jim Mattson <jmattson@google.com>
To: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, yosry@kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

On AMD and Hygon CPUs, use amd_update_hwcr() in boost_set_msr() so that all
runtime updates of MSR_K7_HWCR go through the common interrupt-safe helper.

boost_set_msr() usually runs with interrupts disabled, but the call via
cpufreq_boost_down_prep() on the cpufreq policy teardown path runs in
process context with interrupts enabled. The MCE injector's
toggle_hw_mce_inject() modifies the same MSR via a crosscall that can
target any CPU. If such a crosscall lands between the open-coded read and
write of MSR_K7_HWCR, the injector's McStatusWrEn update is lost.

Suggested-by: Borislav Petkov <bp@alien8.de>
Fixes: 21690934d934 ("EDAC, mce_amd_inj: Enable direct writes to MCE MSRs")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 21639d9ac753..8fc4cfd045c4 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -103,9 +103,10 @@ static int boost_set_msr(bool enable)
 		break;
 	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
-		msr_addr = MSR_K7_HWCR;
-		msr_mask = MSR_K7_HWCR_CPB_DIS;
-		break;
+		if (enable)
+			return amd_update_hwcr(MSR_K7_HWCR_CPB_DIS, 0);
+		else
+			return amd_update_hwcr(0, MSR_K7_HWCR_CPB_DIS);
 	default:
 		return -EINVAL;
 	}
-- 
2.54.0.1136.gdb2ca164c4-goog

