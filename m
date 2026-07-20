Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311038AC80;
	Mon, 20 Jul 2026 03:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784516918; cv=none; b=cnSjJhQpzlstS+YgXKlPJfrKm8YBxTzEhJH8ekH0nuogfWwjVEEt9vMK2n48SW4eDHE58G32YM8PAeKe8Jg0M4ZjN+MehFX8d2t99uJ3hefgM1cWrgbFK7foJAHPQpvEK+Yo/7MYN9CfLVP414Fn3V0H2E4bvUBk+Dr2Ziuxzgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784516918; c=relaxed/simple;
	bh=Y2F2WNPPOeusbG8YHaTksvhNAfsTYc1/j2eBC0aK9Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2HDNqqSGmh/voe0+P5dT983sPtwYFLe3Sx/NPUJManb4fWbORnalHY8wc0soXQ6vomZ6UjcC3FuQFWFphVdK9B+qUD+5Z7RpxiaSq0EtOVT16UxgRKg6biBmJ9T9+YtxwLnfjFViAAGEiEC7Y0iIrOwF67sEIOA3fJ02odZXVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfLnJOZu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfLnJOZu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42A01F00A3E;
	Mon, 20 Jul 2026 03:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784516917;
	bh=iEATxF7grHuZI4BOCKw9ZeC1N9IA8weePeEo7J1y/DQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DfLnJOZuR9POSQippv79o3J3lvCcQIXEYIcn0Tmbl8B/4SkJH6D3OaLFrd4XGoxGW
	 jgRq19xaPmy1UW/6S8lto1V+jcIE3LVzm1k5Lv/SIqa18tz1XxxEfWVZLsZiZTGggf
	 sjdlqquYMqymOFhmRWRbtxGVaFwb/QKPWLuEs8PvRs+rPnfHYgebhXI52Z9qKWQkYt
	 Tb2/dLXgXSOMVy7+mOYYBS6G25M7sCbJQaZ4Hrei4IoTNQFfGA/gAZosbQ3SfeKYou
	 ff8K89g9NM4l9uvC+fjEzvz0GxQH+n4ggdG7zV5F3TY3Df3q/NSbfzRJJd++uONZP8
	 60Z7DTSMwL3QA==
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
Subject: [PATCH RESEND v6 1/2] PM: sleep: Rename module parameters prefix to "pm"
Date: Mon, 20 Jul 2026 03:08:20 +0000
Message-ID: <20260720030821.2780257-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260720030821.2780257-1-tzungbi@kernel.org>
References: <20260720030821.2780257-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the module parameters defined in drivers/base/power/main.c
use the default prefix "main" (derived from the filename).  The prefix
is too generic and non-descriptive.

Redefine MODULE_PARAM_PREFIX to "pm." to group the module
parameters under the namespace instead.  This makes the parameters more
descriptive.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v6:
- Change the prefix "pm_sleep" -> "pm".

v5: https://lore.kernel.org/all/20260701045640.3130090-2-tzungbi@kernel.org
- No changes.

v4: https://lore.kernel.org/all/20260611021219.2093476-2-tzungbi@kernel.org
- "power" -> "pm_sleep".

v3: https://lore.kernel.org/all/20260608021526.1023248-2-tzungbi@kernel.org
- No changes.

v2: https://lore.kernel.org/all/20260604090756.2884671-2-tzungbi@kernel.org
- New to the series.

v1: Doesn't exist.
---
 drivers/base/power/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index f71467f6ada4..49ea6e2cd735 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -41,6 +41,9 @@
 #include "../base.h"
 #include "power.h"
 
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "pm."
+
 typedef int (*pm_callback_t)(struct device *);
 
 /*
-- 
2.55.0.795.g602f6c329a-goog

