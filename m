Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947D3822AE;
	Wed,  1 Jul 2026 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782881831; cv=none; b=sBi2HSzWO0nrLENhlSHRB5+Tb4XUUj9YMcwoiaU6T4QVMx1uWvx1d0OComqkmeXuXmm/sBz7VBt97ZtmMaqt3laSJIJDhRG0Z7VkcpkVaZVNknQwP4szfRY57lJmob+3kccs1Ux98Q/UF4H3TpSOizgbvENEsoad2TFo9h/TFZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782881831; c=relaxed/simple;
	bh=ezT/kwJ6vuGxOUGBfuM2WhOVfpYHEaa+GiFbpovVI74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N62l+0O/QxXApUo75l/OdPXsloNAqKL2xiXMj60btMyiH1CUbhyfcQpyNLuQj+0BHgEfg+WjPjAeancYq5ET5U74QjKMLRgK9ZqSRz8Xs7YCKKrlLaLZSgOhvMBeUfcg/WeNF35VvSyBu/cgBCzoA4O4fjjSu+yo2kVC3ud+CU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j011erUS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j011erUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8711E1F00A3E;
	Wed,  1 Jul 2026 04:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782881830;
	bh=QQs046isBRl35lQy0d8eS22vntrYBD6IMKEp3I+x8xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j011erUS55Z+JMO6FNqmgdq89swIRGU6aDsGbcZwHWkswD9F9lMcaiBrinMCGt8e2
	 /cxwGwagYPdjNYqbWB2G9vIhyxgEOUyak5Y60A5vEissY4PrHJxYrakA6KmqIVyYR4
	 J3SWuxZII+gg6c6/RMzTkw/VkRn4XFe18igFp7OgzeQHPqR4AkkwkGp7j0+eVNMTns
	 IzNCwAtTnUJoaxDMfOKNGI4KQmxBedUMxr6s6cKzfDfan8eGgm7c8ata7K6qu1m/Pg
	 PRvOpjt9S3xwJTlfauO3A+OE6IDXhGqxgzMAtd/Y5S0rZx9gVW29mBj/3+FmeE370t
	 QEODPQjreQlaQ==
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
Subject: [PATCH v5 1/2] PM: sleep: Rename module parameters prefix to "pm_sleep"
Date: Wed,  1 Jul 2026 04:56:39 +0000
Message-ID: <20260701045640.3130090-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260701045640.3130090-1-tzungbi@kernel.org>
References: <20260701045640.3130090-1-tzungbi@kernel.org>
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

Redefine MODULE_PARAM_PREFIX to "pm_sleep." to group the module
parameters under the namespace instead.  This makes the parameters more
descriptive.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v5:
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
index f71467f6ada4..c6a3300cfb7a 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -41,6 +41,9 @@
 #include "../base.h"
 #include "power.h"
 
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "pm_sleep."
+
 typedef int (*pm_callback_t)(struct device *);
 
 /*
-- 
2.55.0.rc0.799.gd6f94ed593-goog

