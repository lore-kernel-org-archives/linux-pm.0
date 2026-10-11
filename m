Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15194657D0;
	Sun, 11 Oct 2026 22:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791758044; cv=none; b=s/2FHaJ8DWas5JsyPcuJ+sNqT+fGaM7dAlDV/7veEAT5aqarAEa1XHF8cTk433uFQ/tH8qDveG1OcYSn8ADboWvxy7nS92fzVRMN9kinAqx9xaRBG4vQyzvIrIk/rIoS+VNbTgWoK2qPPlTx7BxW8vpZVVB+XaQ6vf98OAz7m9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791758044; c=relaxed/simple;
	bh=ilTDsjY3wNtsMuQ5D3FDRYeOOyyKiC4mkkn461Ul6ns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DSiBjRZdb0WHUpJ7dIWH6umTHL7iId7IVy43PHXubZKkW3OorLmX5XO6usRSWxX00//pYctgAg+N2ahsr/beA14P6Tatk0WEY9Yulef5OUwKeCjoUJR3YgMUH7XaKE6+8oS9eU6wt3dy8jRBrXXF8JKhQa62dAwLOI6mB/OZy+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMbPooAf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMbPooAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B501F0089C;
	Sun, 11 Oct 2026 22:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791758043;
	bh=atIILfwLScRUJCYA6cDxbcECYZQF8DJALLaAm0N21v8=;
	h=From:To:Cc:Subject:Date;
	b=OMbPooAffrS9szZxHBy0zVtViG4cX2Kj5IN1dN4HTnmaByVCO/b5OuaPUXatabMbP
	 8rZReyO4J8jnumoreOT5U+q3pRBeAzLe21K3yLczHv6iKAAZ2yDkCJoLUk4VR6D+wX
	 cLVngDUigSHKtZmtmGjJNYOqKRr1/96VL27pBNt+GUKwIaOt5gPt4/BsTUg+kyICqH
	 pNTTwzGv+uhYNneTA1K/eGdqRz7RKHG2bU6b2Ta/Bq84V9mQugNWaPTGL4m1YXw695
	 Z5hfKvzCf/3uOEMzCfdps0IU57IUxQduCz7CHNxJ5FQT/55YOGYmQ37hfLgZfq9s8R
	 SR7lAh456Bctg==
From: Sasha Levin <sashal@kernel.org>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpupower: fix building cpufreq-bench with STATIC=true and O=
Date: Sun, 11 Oct 2026 18:33:30 -0400
Message-ID: <20261011223358.2327625-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With STATIC=true, cpufreq-bench links lib/cpufreq.o and lib/cpupower.o,
which it expects in $(OUTPUT)../lib/. That is where the parent Makefile
builds them when bench's OUTPUT is the bench directory, but with O=,
bench gets the parent's output directory and the objects are in
$(OUTPUT)lib/. bench then tries to build them itself, outside the output
directory, and fails:

  Fatal error: can't create <O>//../lib/cpufreq.o: No such file or directory

Use the objects in lib/ under the parent's output directory, which is
one level up from bench when it is a relative path.

Fixes: e51207f003047 ("cpupower: Provide STATIC variable in Makefile for debug builds")
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/cpupower/bench/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
index 34e5894476eba..ea74ef4d01b64 100644
--- a/tools/power/cpupower/bench/Makefile
+++ b/tools/power/cpupower/bench/Makefile
@@ -10,11 +10,12 @@ ifneq ($(O),)
 	OUTPUT := $(O)/
 endif
 endif
+LIBOUTPUT := $(if $(filter /%,$(OUTPUT)),,../)$(OUTPUT)
 
 ifeq ($(strip $(STATIC)),true)
 LIBS = -L../ -L$(OUTPUT) -lm
 OBJS = $(OUTPUT)main.o $(OUTPUT)parse.o $(OUTPUT)system.o $(OUTPUT)benchmark.o \
-       $(OUTPUT)../lib/cpufreq.o $(OUTPUT)../lib/cpupower.o
+       $(LIBOUTPUT)lib/cpufreq.o $(LIBOUTPUT)lib/cpupower.o
 else
 LIBS = -L../ -L$(OUTPUT) -lm -lcpupower
 OBJS = $(OUTPUT)main.o $(OUTPUT)parse.o $(OUTPUT)system.o $(OUTPUT)benchmark.o
-- 
2.53.0

