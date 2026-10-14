Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BA3484246;
	Wed, 14 Oct 2026 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792008094; cv=none; b=WyGtVN7zGb5HsLF01dUQn4Z32yVKNaqQWET0inhtFACVYn/sjP2ntmRwaGAs3Jrvvx4u2pZv5TqCGGmG2e8qXKCz8XYguIzgkK+qLd3bV4QqX14pwHXe/ZQvexor/H/anUH2MGcI5csI0aO66ZXw7QWUXRr6XtgekaxQiq66kDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792008094; c=relaxed/simple;
	bh=bbKB5pLydT8mVBMAJ+1iBWrVSm6WgdUY2bRQ5ZPyjb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQ/reTFWCRCmWtdnFxKOM48S5aSv6wZ00h2/LAghSbNf+E3IZjk5TL1YZBq4Cmyk+kufKzCOUNkvmDYCWNkcs838g5DOX9hW+2hKHhZzZ6tFJI45g2vcrpfzRwVYTEGtllCg5B2bLZ1doKGK8L53jDKwZY0QqOdrAqj3XFG2Lo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxwinNoV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxwinNoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B8F1F000C9;
	Wed, 14 Oct 2026 20:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792008093;
	bh=LIMv34cDJqzlLVhQT11taTszU7soywSUu9ZIVJ/8ciI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oxwinNoV4XFgOGvrDWkmcFnZpsEtVhwE9ew5uAMZDedi6Nzg6RbKJ5L7Oya+xdVpy
	 l1VrhaLN4+OLLbMFt4Mf2N+oRZ4ZV8VYVq5eFLmwE9l1J9M39Y5Sa6EnMSIai16Fbx
	 SMoDMKjywPOGX58VLoNSg7Uu8BhIYtQ85iSLunGeuW0cX6ZJj0iaWaqQ8Ck7Ims91h
	 +8AXUqzIp4WYXv/ATgPTZ/QyglyCR5vGxjMXd2Vc3rlBBPwzKGSJFWGit+KvV+83Cb
	 kHVPBQfTiyQ4+MyPqfgjlXFUMr7xyuzvhDIl1Ly/s6rCO3c9iYbbYDwafsxc5av+HQ
	 zhEbbRoJCCLQg==
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] selftests/thermal: allow cross builds of the Intel tests
Date: Wed, 14 Oct 2026 16:01:25 -0400
Message-ID: <20261014200127.1363472-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014200127.1363472-1-sashal@kernel.org>
References: <20261014200127.1363472-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The power_floor and workload_hint Makefiles build nothing when
CROSS_COMPILE is set, even for an x86 target, and they include lib.mk
only on x86. Other architectures therefore have no install or
emit_tests rules for these suites, and their installation fails with a
missing target.

Select the x86 tests from the target ARCH when it is given and from the
host's SUBARCH otherwise, and include lib.mk unconditionally so that the
suites install and emit an empty runlist on other architectures. Use a
private ARCH_PROCESSED instead of the ARCH override added by
commit 5a1292137e89 ("selftests: fix ARCH normalization to handle
command-line argument"): the override changed the value lib.mk uses to
pick the clang target, whereas leaving ARCH unset lets lib.mk use the
compiler's native triple. A command-line ARCH such as x86_64 is still
normalized for the selection, while an ARCH spelling that lib.mk does
not know, such as i686 with LLVM=1, is rejected as in other selftests.

Fixes: 27801542b2b8 ("selftests/thermel/intel: Add test to read workload hint")
Fixes: d4d27e5a1a88 ("selftests/thermel/intel: Add test to read power floor status")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/thermal/intel/power_floor/Makefile     | 12 +++++-------
 .../selftests/thermal/intel/workload_hint/Makefile   | 12 +++++-------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/thermal/intel/power_floor/Makefile b/tools/testing/selftests/thermal/intel/power_floor/Makefile
index 07463c2160e09..16d26eab55652 100644
--- a/tools/testing/selftests/thermal/intel/power_floor/Makefile
+++ b/tools/testing/selftests/thermal/intel/power_floor/Makefile
@@ -1,12 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef CROSS_COMPILE
-ARCH ?= $(shell uname -m 2>/dev/null || echo not)
-override ARCH := $(shell echo $(ARCH) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+top_srcdir = ../../../../../..
+include $(top_srcdir)/scripts/subarch.include
+ARCH_PROCESSED := $(shell echo $(or $(ARCH),$(SUBARCH)) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
-ifeq ($(ARCH),x86)
+ifeq ($(ARCH_PROCESSED),x86)
 TEST_GEN_PROGS := power_floor_test
+endif
 
 include ../../../lib.mk
-
-endif
-endif
diff --git a/tools/testing/selftests/thermal/intel/workload_hint/Makefile b/tools/testing/selftests/thermal/intel/workload_hint/Makefile
index 49e3bc2b20f9d..e53d6ecd9f8de 100644
--- a/tools/testing/selftests/thermal/intel/workload_hint/Makefile
+++ b/tools/testing/selftests/thermal/intel/workload_hint/Makefile
@@ -1,12 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef CROSS_COMPILE
-ARCH ?= $(shell uname -m 2>/dev/null || echo not)
-override ARCH := $(shell echo $(ARCH) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+top_srcdir = ../../../../../..
+include $(top_srcdir)/scripts/subarch.include
+ARCH_PROCESSED := $(shell echo $(or $(ARCH),$(SUBARCH)) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
-ifeq ($(ARCH),x86)
+ifeq ($(ARCH_PROCESSED),x86)
 TEST_GEN_PROGS := workload_hint_test
+endif
 
 include ../../../lib.mk
-
-endif
-endif
-- 
2.53.0

