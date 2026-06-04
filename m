Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B241B346;
	Thu,  4 Jun 2026 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564131; cv=none; b=GPY8k6BmAQjaz/5Q0C3817QpRwm5zAtaAHKEDu9Y473fY2uCoM8rvTaLwKNOD+wJT6TDnC6ybWLprAOlV1edl5FuwNd8qMQFLTKxSsVxDex8LOzlVODkpxPrAwAb424m9hH8y3qO3cp6e7EUpaNANtyM05J/oimLwiGmx9bEp3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564131; c=relaxed/simple;
	bh=FCXKfyK3R7amxWftCypNVPwpWp03jMbMSnB/igxBliw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLXoe/IYfU+bSPyek1MHDuSpdMIM7+h5zh6JcBLFu26mpBtEFCMGokOfqSWgwZRQ55Dj0GCQ8VOf2uunzsMn7878uN73BTD0pwHDw6iQh+sHPcDda0c3mKfQjzUp8/fwEGR0Lx59K6irvLYNa/Wrd/tH0X8oVLaSwogEj5bout4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNTjpFTr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNTjpFTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0091F0089A;
	Thu,  4 Jun 2026 09:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780564129;
	bh=LpfiuMeakI0p1/O+txo784HcmLdX0vSFzINtraQdAVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oNTjpFTr3W5Geviv38LQcfRC3tim7YexwUgI+AQw84a/lCubsNEbkF5/iZ7wOqvVI
	 5dhycnqcpS3IUnlsIemnTMEuevlcUkdG8JASkKWCCGDRcuDTZQie8a5FxZf9H5G7U8
	 vhntUwzjqvracFCzfhzZpmkyH53hYWezsr0aaI/d0CYskZcQCCeZgg2qTHHsSkl9dv
	 ZLHM+vHkW99G3itevJw6c9YQNY4bMZdTpVW1Q5n/YS6fKo0w0cZj6tLFtMTLtEzAGf
	 foS4D+Y1/nHa7jvD+L4J3CL/aGFomVyfo/nG+dXXBNzR6IsS04etp0KAC3AtUqxQ9s
	 rIDqq3JP5N7mw==
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
	senozhatsky@chromium.org
Subject: [PATCH v2 1/3] PM: core: Rename module parameters prefix to "power"
Date: Thu,  4 Jun 2026 09:07:53 +0000
Message-ID: <20260604090756.2884671-6-tzungbi@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260604090756.2884671-1-tzungbi@kernel.org>
References: <20260604090756.2884671-1-tzungbi@kernel.org>
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
v2:
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
2.54.0.1032.g2f8565e1d1-goog

