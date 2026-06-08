Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDF13112BD;
	Mon,  8 Jun 2026 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780884965; cv=none; b=UKA0/a6Sappc5nc9hX+izvaCtoSQCcHrb45f+8+dNIW90zyC1JtKgwH0ijzeaXB1As+f2w3/185PfyJHlsuSZ3fjAQ0+fotnviLO75kxTWs9vfxlCP3SD3oW6JYjsJK9r0DtMu5V2WomSe14AmOTE4iflKbdi73vNN6mTcnTrt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780884965; c=relaxed/simple;
	bh=3uPg7kuGlYl//K7/mle3D+ZScqgdV5gSQnAdBSOsruY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZgZfUV82JwtaSlHuTEvKNZIS7q5gI+51Wa1vfMcTgGAzkKDTfD02OwA1l7KzQ7LFv5GjKMS86kVp7LftdCSwH9l/ZOI0tUF2LyGMoCU1yUnN7z/IIKbDZYc34nkMkOCZpJfbkQAGINHEwkflsb8/YwEdAh8hK7CHEXsYWevHpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9E47iuc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9E47iuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C93F1F0089A;
	Mon,  8 Jun 2026 02:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780884963;
	bh=UGCCSBKiUt+mVaP+wnFKzkhoK42LU7NlpwHdye+k2uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g9E47iuc7jEo7zd3hxM/4coT33muIJnAnurfxZYLAvdpLBNLykOk/S40tvaxw2R5t
	 syLlos/mzdsi9hP+DhO2laeJypCBzPSZnK7IcYIMm1FJl8gREm0FHWJLD3Ow0ibhvB
	 M5eMC5OPEmIC6foEwLpyHOUK69buzB7u+5/8RthgdhrDSNrLavN6BADC/z3ysBhwds
	 cLOgJNTLQHss7fI2Zv6n/W7rPAwimprNDa6WVR/HeVHGAxV/sUb0bKddjRDekKvAG7
	 SDsitm3fNVZSumDYoJR10awKunX24FLkKxZ/ItumlQZ6uAWErkuskOeEzrSCdIx/p5
	 gPW8Wqet4YcFQ==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	tzungbi@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	tfiga@chromium.org,
	senozhatsky@chromium.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 1/3] PM: core: Rename module parameters prefix to "power"
Date: Mon,  8 Jun 2026 02:15:24 +0000
Message-ID: <20260608021526.1023248-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <20260608021526.1023248-1-tzungbi@kernel.org>
References: <20260608021526.1023248-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the module parameters defined in drivers/base/power/main.c
use the default prefix "main" (derived from the filename).  The prefix
"main" is too generic and non-descriptive for power management
parameters.

Redefine MODULE_PARAM_PREFIX to "power." at the beginning of the file
to group the module parameters under the "power" namespace instead.
This makes the parameters more descriptive.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v3:
- No changes.

v2: https://lore.kernel.org/all/20260604090756.2884671-2-tzungbi@kernel.org
- New to the series.

v1: Doesn't exist.

 drivers/base/power/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index ed48c292f575..cd864f3a2799 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -40,6 +40,9 @@
 #include "../base.h"
 #include "power.h"
 
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "power."
+
 typedef int (*pm_callback_t)(struct device *);
 
 /*
-- 
2.54.0.1099.g489fc7bff1-goog

