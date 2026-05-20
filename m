Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E483C5538
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264892; cv=none; b=L71rGxIdMRSo/n8AcVUeAIorn7poJiu4p/4hxHLbxG4nymBUBkjiVnFooptYr+Mg6e+WWYDSqTPXZhBB98ucl80rEyRLuRLSnBOpZitFtkwnKjl5BWZOWk51khvu7Ihtu6+ZkmwqhVhPQUGg6AvofKf+sZ6gS1cX+/ut9muoMfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264892; c=relaxed/simple;
	bh=9a3F9YeuQGoz3fiLa/6f6rfSNjsTYItXAy+mDWoPBF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YjYAUCPLpoTPIVDCF39fdEEG/JEIXMXLJaqrKGPgSo28NXjn8ZBN4RHQBCJl5gwm4cO/AmP+MrwHU68GkO1hswTOA8qRrBbBkzprCsChR+qje3zmRhOo8UNi9rXdEKY/gFYi0VcgWT/4ky6MFU9t6Nx5uVlVwogL3D23dAm9jpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+uH5uJL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+uH5uJL"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so22016235e9.1
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 01:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779264890; x=1779869690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ala4V2bNYU4r56FdT6HR3JOVSTpgerWLtAUA7GKYqI=;
        b=g+uH5uJLNH1PS1PMQ7/eiqDsunODJqJ8Y43LClyPMkLDQu2C9MWC2lp8HBhbpcGBbr
         FLQvrarI0uqyBEOiqFlaZAQ1xjQ7pRvz71yzWcWUPMxrkQ3lrV/GYFJfTS1jm0i6G7/T
         krIES6o/WQ3jyjoBj3vK2KUyc8LdvHV5rX23K7AdI9/HDSoPAxJN4InPbbR+UT47EI1S
         VRxnRJNMStYMrPnQQ9S6N8BSvJZRnvNsizMjzOefFujM4J735Uu4GWdUM1n7VDcDX1AI
         0D5402z2uFhqiGZzeAAj5SdSjj75Us6PdLOkmJZQXHgHw8ok66YWlYMjHJ7orFIeig/z
         1OGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264890; x=1779869690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ala4V2bNYU4r56FdT6HR3JOVSTpgerWLtAUA7GKYqI=;
        b=Kl7MXIHJJjuf7PHkaW4iMuQccvr0i87RNgtqe0LfGNZLzP101B08UFfi7Msm8vfCPb
         3qWwcKVbE01fAexzDnSXyIctb6CCcYEyBboMrfUgJ3JU8h1YXRDdWv0j3nKxiyTMN8Rd
         r/6CtxMK1a/oCLHCu+A6a3rqUyzb2tCbRoob3CKQvvvccZ5cQvnWqwuhQXWVdX/KmNlN
         LlVWDtnoXe0X8xvEM/tBbzlsB0MlQIfrlWQUTRmM9wq+o00XOEdwlh2Fv2GekSIWK+44
         wolsEzw7QLK++dpuhPgQqYWZABLKiki0gtg3m5FL5iyjzlNBKH2aaQ6Ye2Az4G+d7YQA
         YfWA==
X-Forwarded-Encrypted: i=1; AFNElJ+lLfdR7bwpdfNRvBRiXMjD3hIiNhe6Vo+OQvYhsL2pwMsY/nDpsa3vD/lmh2aBQpQSbuUbddBiow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8IP+WV6JTdBbtYEzj+JoJsrAavnVAGLJgOp05INk0S5/V2za4
	0Gw3B/9Un4WuouQBmars/+GclKaw85O6cO2wCiQxLb7t4L2Gp9nWuIto
X-Gm-Gg: Acq92OHBtsHbTCvmI26tB1ywKWlFCsBew3p78GzZhS6f3g+MASLXz8a5cgtmfXMFmTS
	at2PjSxx+G/lScJ8myCsZSa6Xem4kluHJ3Pu/QkW8w2ei4/dTiZAwu+ubjYiG+wbdHICUC3x1ey
	807YwaVNbMIhLAEoG6/7e2Y+/9YQKjEy0CrGG4ibsHqPWAac9X89Oidd+NUGGi2unj6YXAPwxZO
	CR6ejln4E/VGk730tpyHX7f+xXgrE+y6JvrB3MAnR5oVLprflgNA794GaKc5djJiKbFgUWLYYCX
	/fIchvmWygstJw74ioGe8YVqTLVn2FAo7tBxoLgTvtro9d5DLVn1cqQn5ecnJqQ7zNuJNdsFqm0
	Npt5qWRFI9n9TIJvuWaSj1XQcDcLY6WaEbfl5lNwRuWks22pqrwAFdXZc0TLRg2R18O4COacxdC
	H2X3XIej487T4vVu1dRLPSNnWjxxtdl5b12FQrH4Bssy7iKFwsLZdAMhlSQ9JroC8gTvQ3q1Yw/
	C1CzH1JzTG1nwGdCA==
X-Received: by 2002:a05:600c:a11c:b0:48f:e230:8cac with SMTP id 5b1f17b1804b1-48fe662a1cbmr261784145e9.32.1779264889502;
        Wed, 20 May 2026 01:14:49 -0700 (PDT)
Received: from victus.fritz.box (p200300c2df294e00003c66d6e108bbde.dip0.t-ipconnect.de. [2003:c2:df29:4e00:3c:66d6:e108:bbde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4900c16c744sm214333515e9.3.2026.05.20.01.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:14:49 -0700 (PDT)
From: l1rox3 <l1rox3.developer@gmail.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	pavel@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	l1rox3 <l1rox3.developer@gmail.com>
Subject: [PATCH] PM: hibernate: make LZ4 available for hibernation compression
Date: Wed, 20 May 2026 10:12:54 +0200
Message-ID: <20260520081254.13493-1-l1rox3.developer@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without this, CRYPTO_LZ4 had to be manually enabled in the config
to use LZ4 for hibernation compression. Add the select so it gets
pulled in automatically when hibernation is enabled, just like
CRYPTO_LZO already does.

Tested-by: l1rox3 <l1rox3.developer@gmail.com>
Signed-off-by: l1rox3 <l1rox3.developer@gmail.com>
---
 kernel/power/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 05337f437cca..530c897311d4 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -42,6 +42,7 @@ config HIBERNATION
 	select CRC32
 	select CRYPTO
 	select CRYPTO_LZO
+	select CRYPTO_LZ4
 	help
 	  Enable the suspend to disk (STD) functionality, which is usually
 	  called "hibernation" in user interfaces.  STD checkpoints the
-- 
2.54.0

