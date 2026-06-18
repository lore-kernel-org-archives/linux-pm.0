Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC68352014
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781822746; cv=none; b=CXT5/cTJW1yYfhTveNFnXGoJmpBB0ZMRX1fPCxKc/9Hj7K+3z7JAhr0jYP6Qc02Qux5EhhuSp2nt1SVd1855zdK+uIKUB/RC5eb/WQYWHTYc6XxeEHMd9zKkybgHXWjAo6i5A7Jp+SS1MgMMXGSrbSa9NqDkPevBnJM2CxruR6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781822746; c=relaxed/simple;
	bh=p77TveDbpp7HNftGzvjzpX7z4GilKjxHXs0y5CuWHI8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ACObrR6sE27cwKqJuUK/BrZj99Hl0gaPtGt4EawdsVzyGVzPr7jXjz7ic61aaGEGNG0d3NUe0BiNPYavbCQLBusfvYJPX0BeFUGicfezG7Z4Kh9E6HWIWLPagaqtx1jkSed5aLRLGlzM5yfuN/JDPZSu86EWhFg/ijdKFNMW3dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JnCYX2oU; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnCYX2oU"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37c648d3ab9so1025739a91.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 15:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781822744; x=1782427544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yzcC92EHb91544uEP740BS0GbTjYgwTgsbLMNqy+GD0=;
        b=JnCYX2oUh0ter0I8W+s0+pqY8qc0OmYYEWZ7BrMviJtxrA+e8SwMxTbG3VIrx4nzx6
         i1+uhTdUcLbBH4VCm1YkZSObE70ea0FqTZwthVPPtcxmKrMRFE9LOx1oQETns0uS8thv
         pMl9SDU0RKG8Vj6TxC5Vki9rCoawxxssHy7hmTSgwKNneFgyvMmA8AsOluVYuVZTPvC4
         oPqb1ruoeh2pXtHVCkrv78kHso5ofXJ5YdMBS0nGdV+FSNuiweFqllD8Ga3soPPeEziH
         LFJXjuhEGYn7u764vLJ93Du0TtsEDP9dvUN4FykKXicwAbg1Woy1b5UPXLWzj+0MxW20
         0+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781822744; x=1782427544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzcC92EHb91544uEP740BS0GbTjYgwTgsbLMNqy+GD0=;
        b=jz5OBEYx4ZqyiFGWohqHGUgjKEiwj1CyFSbEofYOGgcbzT/J4hJZRXH3w6CfMMBrUN
         dTG1Zv5L+Wu+pDxpPUtEabw5YHpJkojn0tEOK2iEx09V1RFSdJTALYl0bMcgh77zwIV8
         pNI2cfjr45HwaQSS5OyNqxUw1ivls9Hg7mfTbk00jXd3VvFX8OVrDkLb065NvCXzv4jI
         4S6bnatEw4ZcVO87rXZJV1rSQXOvdm9XNhvaY/xNC1TLn/rsXV5lvNwhd5cXJ7fP7ZtW
         vP9lU6mdVQaYKxFZ7hVbVO+sVSHyi+rxG6o2XKhWTm7gpNdwgzwbcugussbonKVXn5U3
         kQFA==
X-Forwarded-Encrypted: i=1; AFNElJ9VL/QUqt6XkZ7CgQ0petjyF4CeYJhFcEXruzE/IUEcBlWLn5zBMmzFCxm/2LhvF9l4c4GLw1qkzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyU8xEPNUq7832NlFOLGViABJyBlpLwdHt9oS5cih7SHGQ3VIl
	9423Au8m3GW6qiT+suU1LLeyiMeWfHZFWxl7sQyQdxGSQfbka1eNx7MIgFYLURC5lK2mjYk7Mf1
	DmGXQC/JIY3WXpw==
X-Received: from pjbpm10.prod.google.com ([2002:a17:90b:3c4a:b0:36b:d4f1:5505])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:f950:b0:36b:79aa:cda4 with SMTP id 98e67ed59e1d1-37d160481fcmr1576750a91.8.1781822744068;
 Thu, 18 Jun 2026 15:45:44 -0700 (PDT)
Date: Thu, 18 Jun 2026 15:45:27 -0700
In-Reply-To: <20260618224527.1506419-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618224527.1506419-1-jmattson@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260618224527.1506419-5-jmattson@google.com>
Subject: [PATCH v3 4/4] cpufreq: ACPI: Use amd_update_hwcr() for MSR_K7_HWCR updates
From: Jim Mattson <jmattson@google.com>
To: bp@alien8.de, tglx@kernel.org, x86@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, yosry@kernel.org, andrew.cooper3@citrix.com, 
	ludloff@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

For consistency and maintainability, update boost_set_msr() to use
the centralized amd_update_hwcr() helper when modifying MSR_K7_HWCR.

Suggested-by: Borislav Petkov <bp@alien8.de>
Assisted-by: Gemini:gemini-3.5-pro
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 48d678812fd6..b3e058dd6b4b 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -103,9 +103,7 @@ static int boost_set_msr(bool enable)
 		break;
 	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
-		msr_addr = MSR_K7_HWCR;
-		msr_mask = MSR_K7_HWCR_CPB_DIS;
-		break;
+		return amd_update_hwcr(MSR_K7_HWCR_CPB_DIS_BIT, !enable);
 	default:
 		return -EINVAL;
 	}
-- 
2.55.0.rc0.799.gd6f94ed593-goog

