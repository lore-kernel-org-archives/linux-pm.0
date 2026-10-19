Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428740;
	b=S5L9tL2eAcEeKRQs24HyU8hqCPKTEy/59NN8cKXCsizy2e4T5wsGUa2YmECtMYbVSCjQ
	 bCGA0ot4FxmIGleJhcsTfFei5k3wn9aftMLSkUE9FxxpuYSpuxYWlnIjouvG4BDgsFUNJ
	 AloEWJxDaYVgZQAHCTKw/6Mc5mm43uVxuMzLjGXuWx8/Sb+TcfuciSB4MjGmh6ku615Dm
	 4KzPn87yRPD238KdqBHY2TbBBKK7b7efwneHYGujKWVZ0Ks5nQa82JLZMzc8HJssZ1mrG
	 1Nn8r2Zfs1erDCCoV0C7iiqlhPdo2KwRfYNVLJxorL87qJXPYd09DYXk1r1GnHVEmhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428740;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=/Rvj5gUzLwxgRY4+sbPr0S7UiQBnlQail/VS+LxxWjA=;
	b=Ooy5dIIPgEZKVeHKCloAB2O38GPpkTG7pTEi+wQCSrBJ34NlTSdKNsxMt1U8uvMfeoIh
	 yv08gyPDHq9C+CCmZgQyZRCMrPGnm3f4DIRL0YJULu5MHDK3q+Zus1WrAGix1zwuejX/r
	 QQUSYEa0WlB2yAv7xBFxZGy7pYIsRXwFR1iqK8eycBzneFQ0n7woZr2xeEyyUvo2FnZ+q
	 GYmbh73nc2lgq784A/z1uiRP9FLECIq/27AZ1Jt7QAg36pYrD8pAv9CVlXAcAkSxrJmNK
	 rfzpQ/0B4zQn9qHxvE+oPprCnXs1lud3zNdt9V4sVpFjvactm3+KpjDIedq9mM72r9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V1TtuhkR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17360A2602
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V1TtuhkR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8381F000CD;
	Mon, 19 Oct 2026 16:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428740;
	bh=/Rvj5gUzLwxgRY4+sbPr0S7UiQBnlQail/VS+LxxWjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=V1TtuhkR2A25omDYUr2MSEbC6HUB4DzYfXbe8u0gQHa4ESg6y60A54yR+KNEouphh
	 Qu5BX5ToxJwyHm427BGs6WP74sTQHmN90ktonI0l44CkCqjVmqls2c5Msj1r3+yoT+
	 Un0c1TcF1kPlJ9IDv5Ef5rujR5GVWp/MtDH0pN4vhCIGAnZtUs31iJpFiVY7xm8d5N
	 9MU4NG+74fzdBdmc7LZa6TTAC8JvwUuZiWQkzHiefT/lD8PTR3qn4tP4dyY188STtJ
	 NmfLWchoNl8CZJmvc95znbZ9EPHVdvRwIrTEsOJCpO4RXXqGiWGYRmrTRh8pSguqFR
	 zSQq5FdTp9gXg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 13/18] x86_energy_perf_policy: Cleanup: Drop unused signal.h
Date: Mon, 19 Oct 2026 12:43:34 -0400
Message-ID: <42318073092d4c428096f0d600a0297060abcf84.1792428130.git.len.brown@intel.com>
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

Remove unused #include <signal.h>

Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index fcfdb0075408..e26a28fc7edd 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -25,7 +25,6 @@
 #include <getopt.h>
 #include <err.h>
 #include <fcntl.h>
-#include <signal.h>
 #include <sys/time.h>
 #include <limits.h>
 #include <stdlib.h>
-- 
2.45.2

