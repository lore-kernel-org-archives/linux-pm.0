Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C102A379C48
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827412; cv=none; b=A228Ub6vAn6GbuEOGZe6hT9y1LrhaRBCnahpKOm3tq+9enHG1ZJsaubp6hIXqqLKRiis+mPGAdOeqiZFOE8E6GNLokPlApt57ukznilvDhPssYI8Caa4ajSBOTRy0wWfKhalgwlRcZzKx2AvXfOH5jFL65huKk++eDLeCDCR6TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827412; c=relaxed/simple;
	bh=Z2Eq6tPQ8IU+EbAZvLPYmcLwjEeENPPS88GFAlG6sKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJ4VnCNWqiitxKEFzo0Zz8ouYW8WgiEYXmpqiGRoBFy37HAUwf3aDC1fq8eWrl7IrVfK1RDdt2bpx536rKKfALhPqqaZIqoLMRt+dLR0EzlHho6gn/R7bP07xru7Iw/ptTTRew89e29SWFFI+NwL4VsY5OFmoRzuQ4drIAK+CjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmOCzdqS; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmOCzdqS"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84864086bfeso906960b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 10:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784827410; x=1785432210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eBG5HEmpJKSGr0OHWB4+9YhE4TrW0R0G3idJnIf77oM=;
        b=hmOCzdqS63l7Ezcz/FGCSHTx5XKohoUpyIhdCr8SCkREmQ1ITJWdMdnZ6Pgc9DNvH0
         99zl9f8pIgLrwI1Id/acFjCLUCU5gHs/b13tRae7RRbeWDA+yOC/+ZsBWEmxH8eEa93t
         Mcw3AzdAk0cC9r4omKlrCiQ4ogweXAW9xtsD1tjERVQYP3xRy1BD/ziBsip4ifWokpRi
         MdvOF4YsNzjvjjnQOJxPSPhzeOYHxQbfJJClX6a/XMnK9387b/4Zz/l562TjVwd6HiLW
         lmAuscj0L9vxxtppzCnhVYqw/WebkH0nmgr0q2kgZX7SMbu90Ge2eQM2fsQhCdMDy8xT
         gBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827410; x=1785432210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eBG5HEmpJKSGr0OHWB4+9YhE4TrW0R0G3idJnIf77oM=;
        b=eWFU6aMWhYW4D2sTm72KWF0o5uNDj7qa7rNo94Sot0kqhZT+c+6mmSxPAfFy8u/eF6
         lhr8OofQK/kOGxqsQnSY7ihUwxhSJ9CD31XGyrkVZvlA7eS+qZEo395iSFCsnTkGxGAs
         tjtWU4kBAD7hrPK7wpcxorSL1/Mrqhls1qqszi7LarbAzIIyIGZlv3xRQoKNmPygY8EU
         bWhRhEwO5fm9aG4xY3AtlrC4OdLCQ8A20wTD4UR88XtGPqzpCTPsbPyaGUHzvzIiWf8M
         CSg4r9rl+VxVjKEyBtwIyPQlXSPhkKfavVitw6lCvA13s+UyVg7g4u/9W63FTu5FZhvh
         0+iw==
X-Forwarded-Encrypted: i=1; AHgh+RoJj3wAa7fIOtUZzWUSnnGuuEUcOi0cZrNVpijsqXYMk+RsCdihtuz0ByHORpJCwzGCmMV/ysadvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUQxHtuGzyxv5krSIDn+/qwl3Iz6c8UWNPpmtpZ6Q0dTd/6pl8
	xS3V7esNzyy0RhgtIjrRGHxA4NjL+Hwy5mZD4szhnsnuNfJ4MRL1jPNsBNTGlA==
X-Gm-Gg: AR+sD13TqA7AByrATLu596kAKjGnAVyElEjmlVONBbGXkG7xkyxERsY3gqG5P0q73Xu
	raMppVFAcmjfpL+nNOe3+Hu3Ps/3RCpPMovEOGak+usIF9c43GCkQbbCYn3VNckR4rf7D60li7F
	g/64H8VDeoX8sLslmSokeh3iW9XJNJ1mFUuLXv8qeKPisaIbsG6RMiLjH1xAyIAT8n0+Nsz3unG
	RqfkrDNlt7QvC4ZOKj9WoEhsbw4PoxRMgkX6AsJFvujyL9SJteSwJrFsYVlEv2ojvNPENMr4DzJ
	yOkkhnF374EQPg8vuI+N113uGwYj5EEvgyBybSxubffDqM6h50O2M1pjahABv5BBig45gKKfLtC
	JElwxxLFmsDIPxis9FUz8yBs5EnqKOJ3/XeKoAj/gdf4NfOAKxz8Y4tu8+LYU8jqpQGOwvNR3VT
	rC
X-Received: by 2002:a05:6a21:1398:b0:3c3:8bab:804 with SMTP id adf61e73a8af0-3c44b18f692mr4493645637.49.1784827409946;
        Thu, 23 Jul 2026 10:23:29 -0700 (PDT)
Received: from gmail.com ([58.84.62.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc6162csm21287676eec.7.2026.07.23.10.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:23:29 -0700 (PDT)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	rui.zhang@intel.com,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH v3] powercap: intel_rapl_tpmi: Handle PMU registration failure during probe
Date: Thu, 23 Jul 2026 22:53:20 +0530
Message-ID: <20260723172321.5960-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_rapl_tpmi_probe() invokes rapl_package_add_pmu() but ignores its
return value, so a PMU registration failure would leave the driver
reporting probe success despite the PMU being absent, with no log
trace.

Since PMU registration is an optional auxiliary feature for perf energy
counters, its failure should not break the primary powercap functionality.
Check the return value and log a warning to ensure graceful degradation.

Fixes: 963a9ad3c589 ("powercap: intel_rapl_tpmi: Enable PMU support")
Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
v2->v3:
  * Fix the format string as per the Sashiko comment:
    https://sashiko.dev/#/patchset/20260719085100.145555-1-sumeet4linux%40gmail.com)

v1->v2:
  * Since PMU registration is an optional auxiliary feature here,
    treat it's failure as a non fatal error and log a warning
    and continue, similar to other RAPL drivers like intel_rapl_msr,
    to ensure graceful degradation (Based on Sashiko feedback:
    https://sashiko.dev/#/patchset/20260515184250.228062-1-sumeet4linux%40gmail.com)
  * Add Fixes tag in changelog.
---
 drivers/powercap/intel_rapl_tpmi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index 7f41491d9cd1..a870199a9272 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -414,7 +414,10 @@ static int intel_rapl_tpmi_probe(struct auxiliary_device *auxdev,
 		goto err;
 	}
 
-	rapl_package_add_pmu(trp->rp);
+	ret = rapl_package_add_pmu(trp->rp);
+	if (ret)
+		dev_warn(&auxdev->dev, "Failed to add RAPL PMU for Package%d, %d\n",
+			info->package_id, ret);
 
 	auxiliary_set_drvdata(auxdev, trp);
 
-- 
2.43.0

