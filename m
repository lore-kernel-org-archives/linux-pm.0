Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122DB478865;
	Mon, 20 Jul 2026 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571299; cv=none; b=d74ZoUGJSJof02r9foHwI2itoHRR82TrjiDYxR6JRaq3oZWhSYDyfMV1UNovuJvJujLaAxfDZVhmGEKDpgNE4KDT57hkUmBugsYeLN0+t1HYFD94r2T4jbYpjRxK/G84/6JPNnwvu4eGEV+41oSTJ148dO1L+qhUDPr7ZiBQqas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571299; c=relaxed/simple;
	bh=2OZ2R+EjqlbhmY9adkC3NsZCxBUgRExzuOyNwvLJ0ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B5Z7u3vz8taZKcnXsEuwR/E9s6Hbqop+qU8rSiEZVqtLITb+9OYtpKegmCGZbyNn9IZusM7N/zDmfTg9XBqP3CpLp74Q45tPBDMCi5oQsJJjUDo7oVHFJeX0bJX+5BvVNLF3IjCIZp0oLCRAQ2LJcjuW8+o2Kvu47P2xVRxbwWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XXCnNBc8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XXCnNBc8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D663143D;
	Mon, 20 Jul 2026 11:14:52 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC4BE3F86F;
	Mon, 20 Jul 2026 11:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784571296; bh=2OZ2R+EjqlbhmY9adkC3NsZCxBUgRExzuOyNwvLJ0ig=;
	h=From:To:Cc:Subject:Date:From;
	b=XXCnNBc8mDZXVruwJNfiAz6F+DZGNe3TzD0KY2d5JM32bTeDv+HoJkVS7UQ48mUui
	 5l2iL9VssN7GwjIY/YO7VOkK0DwDsb+XTiLSr083FI+CWhg7foiTZ3kN5A2F24E8ZS
	 qVbEx16jkNiNBiMEcX9Hhan3h4e0ltCcZ+sYAL/o=
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-pm@vger.kernel.org
Cc: trenn@suse.com,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	kaushlendra.kumar@intel.com,
	sashal@kernel.org,
	fj5851bi@fujitsu.com,
	rui.zhang@intel.com,
	linux@leemhuis.info,
	broonie@kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] cpupower: Add libm to cpupower for generic CPPC view
Date: Mon, 20 Jul 2026 13:14:54 -0500
Message-ID: <20260720181454.1232542-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch ("cpupower: Add generic CPPC performance display") uses
roundf() but didn't include libm explicitly. This results in build
breaks in environments where its not automatically inlined.

Add libm to the cpupower makefile to correct this.

Fixes: 68f34fad760b ("cpupower: Add generic CPPC performance display")
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 tools/power/cpupower/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index cd8b7315fe74..ab428e336d87 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -236,9 +236,9 @@ $(OUTPUT)%.o: %.c
 $(OUTPUT)cpupower: $(UTIL_OBJS) $(OUTPUT)$(LIBCPUPOWER)
 	$(ECHO) "  CC      " $@
 ifeq ($(strip $(STATIC)),true)
-	$(QUIET) $(CC) $(CFLAGS) $(LDFLAGS) $(UTIL_OBJS) -lrt -lpci -L$(OUTPUT) -o $@
+	$(QUIET) $(CC) $(CFLAGS) $(LDFLAGS) $(UTIL_OBJS) -lm -lrt -lpci -L$(OUTPUT) -o $@
 else
-	$(QUIET) $(CC) $(CFLAGS) $(LDFLAGS) $(UTIL_OBJS) -lcpupower -lrt -lpci -L$(OUTPUT) -o $@
+	$(QUIET) $(CC) $(CFLAGS) $(LDFLAGS) $(UTIL_OBJS) -lm -lcpupower -lrt -lpci -L$(OUTPUT) -o $@
 endif
 	$(QUIET) $(STRIPCMD) $@
 
-- 
2.55.0

