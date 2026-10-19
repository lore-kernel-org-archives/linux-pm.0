Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428739;
	b=Vg0dehNV4RWu/i9yAY5G6TquJv1BNKgZ9r9U6hY9jOLoDPyw0iv6HVuE7eRjwheXOUb/
	 vVtiY1u/c/rdA/vwe0btOBmmiSBnT+P35rr8hSO7DSyhbmnRRG+nqp2nKjPL6i7uFcS1O
	 Yw67vPVei/G2Z5tTX+7hBwzd4AYJ9uUPAcBKywFF/XFXhadXAbvczDZ7OVCiLiQdD1Fnr
	 iOMaxwlvu59XVkZSrclrxca6ynoZx1g6lwpaA4fdmSdwH9e12o0l658JIFlo0o6DF7amX
	 Ol6zRUGo/41x1OdNQzRC94QYMwxZbiJfjSYOIyrVlqJPyva79hDIO9bWJ0vw9Uk6cqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428739;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=Xk9FCt3F3t4eUazm+8ugocko5Zf9giAAu+mtF/RP5EQ=;
	b=oIQnUoOU9jUiPHUEPszFVXTkRaqZQAgGWEIJY/q8CDOn3MBlbj5ENA8Y/AmgjgG3hi/L
	 qqXr8l2gta+amlC3xf7gjdwOcBCXnN32CDyRSqWnZA1gNo4YxM9zAoBKI+Bgi7sUAs4ZZ
	 8HSjtXt5rczj1qzR/perKwjrcZWowi30s0a18EbSR8jPoXldMHZAEGZ6SpDr/eJqHcCIr
	 4mODrzSdW0PAsyby24nJfUKHHJTW7Zu70seghzKdIJR6RZM9dQVnhzTsLmBWp00tI3BT4
	 CCWXR9wWLkzXiOGllXibA1XqdwBmB15jcnGqE6yONEZb2Svt5LgrjrG7MEh5V/t2deQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q1TAzJ08;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE84C606A32C
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q1TAzJ08
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A70F1F000C8;
	Mon, 19 Oct 2026 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428738;
	bh=Xk9FCt3F3t4eUazm+8ugocko5Zf9giAAu+mtF/RP5EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=Q1TAzJ08jQM7w/4zzYuhHQs9TOGXi20gV/7/x0CG/Ollk22rtw+QRlUoxYXgSKlRr
	 IgnAgbE3KIzqEmtESsXqiv8Noemt6Um8GgFYu8syvANqsDFInYqLnW62qtlSliplhD
	 HRFdlotnRxtOqhDddYylP/9vEMlkO0BfkK9/GV2Bm/1K02lv+E86jxB2am1ef8T0H/
	 DPQ5YUFD61Oj5WKnm2RD15hY5TlEWjaG+zqtTXM0hTccxJ9cQSnpBRRPpfdYIJsdB/
	 atQVVsMygKVdiu7T0x0GJHfuytcPLeqN1MaKtBuu8G7zumP0smP++Rz6di6mu1y8Y+
	 cFdQbUl9BPDIQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 12/18] x86_energy_perf_policy: Document MSRHEADER
Date: Mon, 19 Oct 2026 12:43:33 -0400
Message-ID: <092ee1bb0e6553dfb7234ef40e0cb82e684f2541.1792428130.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Add comprehensive comments documenting the MSRHEADER macro usage and
expected build system configuration.

The MSRHEADER macro is not defined in the source file and must be
provided by the build system (typically as
-DMSRHEADER=\"msr-index.h\" or similar). This can be confusing for
developers building the code independently.

Adding documentation clarifies:
- That MSRHEADER is a macro expected to be defined externally
- What types of headers are typically used
- Example build flags showing how to define it

This prevents build failures and confusion when compiling without
the proper build system context.

Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86/x86_energy_perf_policy/x86_energy_perf_policy.c    | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 1343966b1f07..fcfdb0075408 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -9,7 +9,12 @@
  */
 
 #define _GNU_SOURCE
-#include MSRHEADER
+/*
+ * MSRHEADER macro should be defined by the build system to include the
+ * appropriate MSR definitions header file. Typical usage:
+ * gcc -DMSRHEADER=\"msr-index.h\" or similar platform-specific MSR header
+ */
+#include MSRHEADER  /* e.g., msr-index.h with MSR_* constant definitions */
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/types.h>
-- 
2.45.2

