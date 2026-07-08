Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC01F3B6344;
	Wed,  8 Jul 2026 04:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783485258; cv=none; b=TVXPSmfLWkj6fqtHA0rzdVNHhVWqAP+oJ2+RXQfj0nVq6O0SNs9YqIGEffOVi+F84+PYE+6cCQGUwUms6LVJ++QzzANz1Oeh6A5+l9D6yz3dsH78bBC4Sgo543iXziVkSxE1foFCGsbGChLNIKgSR1TqSzOkspWRi30Tsl3qvlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783485258; c=relaxed/simple;
	bh=Y2F2WNPPOeusbG8YHaTksvhNAfsTYc1/j2eBC0aK9Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+iiH5hDDCPO9pq/QSQge/Pgg8tVocXjNsUcq7s+vOfMBcQFxr65C3g0+0nT0woEvt++L82ys0xRx5dgxiUMPHxuSUes0c5IjbfCq0NPRedCaBKjsNIns/XYxzJGZ020yjp4LCQvfJ6ZCwhUQUMlqgvF0paP53+y8rHDXNazv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkTIduGV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkTIduGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFD31F00A3D;
	Wed,  8 Jul 2026 04:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783485256;
	bh=iEATxF7grHuZI4BOCKw9ZeC1N9IA8weePeEo7J1y/DQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gkTIduGVSwcAGJMOPiDk82dKZHa/AhOI8DmP4zQmVJ4UcyhOfhUWR87qbmPSD0v6n
	 tTj/s1otGN2vjFCik20SPZJao8U0KvAVybbQE+b1P/Fu/uG3/EeuGLMjBmGUBzXk6n
	 Z2xuf1GyRLO1UE4pTpDkicvLZcFcXRWQsQd+E6E7Dsk4KaRlkgMs3XuSNAo5tqsaTq
	 6SxKzERrpvtxp/LiVqOKQCKAag6DoKBNv1ValsiJWYmfq9zl9BhITmrz+DiaLiT27F
	 KokWh5TUgQmKPAvVqo1bJFjEECWdfHOIDDb8PnLpmOGcFqs1nJEx4btWEw5BpgwAFT
	 lLVVg12HBieqg==
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
Subject: [PATCH v6 1/2] PM: sleep: Rename module parameters prefix to "pm"
Date: Wed,  8 Jul 2026 04:33:16 +0000
Message-ID: <20260708043317.2980098-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260708043317.2980098-1-tzungbi@kernel.org>
References: <20260708043317.2980098-1-tzungbi@kernel.org>
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

