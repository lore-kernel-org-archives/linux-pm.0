Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89125313E2B;
	Sat, 14 Mar 2026 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519333; cv=none; b=enj1Tixx9Bt7onqOgvNqmcuo0ucEjZ0o45gkxxb1ni1fwVhN5AhHX51iJIWUqsJbx8fScphID0aOIfQ/roSrl/Qncf1gP7bZtuMdnuk82SprFTsYgEXJe3FDdQvoTpFxg0qddTJ7fI3dQwOxQ08yWvMRl82MRh9ueJ0AHxrnjl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519333; c=relaxed/simple;
	bh=vudj/l5xuExl5f8ABpPfa2RiaDd2I3cewzJ6xh+luZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XW7u3Y0my5he3OZcMjJFmtyWE7K4TOqe5P5hYfpuhu2AHdbViL2Q2+lU0Ix4F+XiwMg8vQQOTtHVs2gZl2lPA5L37v0by4gsVeyn5npEGh06UMH/R+8vFcaQEpwWFT0qNrCu8sjRTPwQVly+sm3CAvzJ212PQ2kyiHZDxLWIjrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aqvzutax; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqvzutax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9446C116C6;
	Sat, 14 Mar 2026 20:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773519333;
	bh=vudj/l5xuExl5f8ABpPfa2RiaDd2I3cewzJ6xh+luZY=;
	h=From:To:Cc:Subject:Date:From;
	b=AqvzutaxN34WnR6Ds6vVrEwiCxnkkyY2SqN2FjrJoA+G6Yk0N43XJlrH6We2HlaI2
	 9VzBQfGIqWryvb2d0k17gci3+ognK2snkVd+FLHgmY1+3A/pb791Y3G4JtZ4o2fr0t
	 bMfqGMmMRcVGJkWJComSYxrgJWlpsCe4j9izzE5ksRQVVqfzwfyh3Bq1g2JX1O+IhB
	 ua8/onm6p7/qvAj8ebLps9dlD+wpxy2J9hr5sokEGVtfb8Faj9y1Rxx4PKdM+SgkUR
	 HMcb0hNtaOrtdMIVEBYYr9Hl/MiIvLkU1/LlEaBHgpDLwHVKiNDxj9mwUUt2RQlGXu
	 SuToHcQCYo/6g==
From: Eric Biggers <ebiggers@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Pavel Machek <pavel@kernel.org>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] x86, hibernate: Remove inclusion of crypto/hash.h
Date: Sat, 14 Mar 2026 13:12:25 -0700
Message-ID: <20260314201225.38822-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hibernate_64.c does not do any cryptographic hashing, so the header
crypto/hash.h is not needed at all.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 arch/x86/power/hibernate_64.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index a595953f1d6d8..e72d26acae797 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -12,12 +12,10 @@
 #include <linux/suspend.h>
 #include <linux/scatterlist.h>
 #include <linux/kdebug.h>
 #include <linux/pgtable.h>
 
-#include <crypto/hash.h>
-
 #include <asm/e820/api.h>
 #include <asm/init.h>
 #include <asm/proto.h>
 #include <asm/page.h>
 #include <asm/mtrr.h>

base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
-- 
2.53.0

