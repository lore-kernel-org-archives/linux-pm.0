Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030C33FE371;
	Thu,  4 Jun 2026 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564120; cv=none; b=fY7Cj0JJ6LUEWDS6cbhB5RYlxyrhIriTCOcph72Cs0IduaA/YpLEA0xv9MulqAA1XRsvj5mVbqO0Zqx4hzpAJyuyNoDl+IxD09lE7veuu52AcJ5aCK2ZfjkMAKi06tlbRF5TP1ACdPoFwnENr9Hr5pZmxyeKKM1cqHXi8f+9Ho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564120; c=relaxed/simple;
	bh=FCXKfyK3R7amxWftCypNVPwpWp03jMbMSnB/igxBliw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnMIEslcOeR4J/zuyJz1roHmNzQy7lKyjEHeZIUtfJttDyrN1d82zGjhitlPCMq1HESrcv6jWA9iqFFZeqcV1JPKxYfHAHh2v26HrgjoGLSHxu03E3gDLxdPUxkYecSDMB9+hRj3j+s72ex62Jg+M/+FNmrCbDycCmtCwUYatjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7qL07e3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7qL07e3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7723B1F00899;
	Thu,  4 Jun 2026 09:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780564119;
	bh=LpfiuMeakI0p1/O+txo784HcmLdX0vSFzINtraQdAVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l7qL07e3iQ1+gfuH+MVn0bVSjMRq3fXIcrWZISnHpPiAzl0WN5CVKdaj1vtKoTI9H
	 /kMc23h2MR/LIROwCqSS3QL5BmYQ7BGWE0aGxNLaGhlPfNrjlYpdKqBuvHrYls/f3t
	 uV0aan1arHJtw6fsgOxnltASh8rJj2gFJAWOhxToAMfOSGalgYmV7ANaQXKfj2nbj1
	 cMzkSXqle657c0lizK9W3VMN9XKsCiSMztje2WPlBp4GRknZdqIskVZJan6eTISQj/
	 1QfwwnBrleyCDH8pFF/2S9MSbEbJbX5/tlwIIsnmnVBBSu33AaEYoP/zOWiWO3RvfA
	 +ugcqCI/AasxQ==
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
Date: Thu,  4 Jun 2026 09:07:49 +0000
Message-ID: <20260604090756.2884671-2-tzungbi@kernel.org>
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

