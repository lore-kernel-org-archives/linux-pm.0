Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.19.144.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792532861;
	b=zgp8Gkgkq+6Bw4jU/WOTdEoA0AneQrpkBvQm+ZlKBWzCXev9ucn893GWWyeD5yPSkdal
	 qIQJ31LzfH7nWyl4HEZfgku1Hsp5nA6nnTJjGXfsjmnxjwJ2jrXH2rzkuN3GeCdA65/a+
	 XY2kXc6fyWS9Eh0QkazfnOM0BMNp+evWHiTBHjJKVPhMmPtSOu8NaF5ndF4iai63NnZ9Y
	 HgQy78ynQIxEft3LejFxk4ZQOICJh2pOJ8PiGqPVdL5cN57IG9G/rbaPKn0xjIkVT7xqJ
	 PWG9GwuPdVS/zCPNqPC3NSF+kAhXC5dVlT/h1SqWLR9sXfqbGiY6EZknFf7LJtPvq9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532861;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rfoSLqIiT4kFgec6ndI0CDjYL+cpOO856gNqJUmAdKo=;
	b=w5nkKudRn728wpd6UgN+v6f7H+aBvZAyGcUwLGGuzswmmU+dk0+xbSD8YwHNa/zCO/gk
	 sYeCZckN/B3Kwo9pWRAZVLeLHUpmVd1eHrUOQwe+PXzkLNsQggnX5LLueKIfzyLEMI9GG
	 rChhzQAu+2b/K6IXUjM/pCGS6KvXSoEeflhhNeKAp4pXQDCOHHxMtIH2uushVVMS149He
	 YLxgVJupOk1NlPwUZbpFdHrPG9rVlx3KmuZvKdIAGwDaTyV8qwO/OYEOh1UdIHrZAyq9c
	 o8B58zEWHyNAErav43PJAWAj092I8QwNMdO45EDGyYej5cdTBVp6U5B/at1hTqX5KFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=GFLrtKvl;
	arc=none smtp.remote-ip=192.19.144.205
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp10.broadcom.com [192.19.144.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFB4606A31B;
	Tue, 20 Oct 2026 21:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAFB4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=GFLrtKvl
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 44DF3C0003D1;
	Tue, 20 Oct 2026 14:47:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 44DF3C0003D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1792532854;
	bh=zLLZMZyNyqOHFeBq5IQnm4VZxOl3rtT+oSl5wvCVFO4=;
	h=From:To:Cc:Subject:Date:From;
	b=GFLrtKvlVdDY/JCDlk9dv5whf7qpECFpIb5RdJ8szO76+enl5NkOz5A+j2tawuO+R
	 Z++8g18rDoH4wSo+PhYRB3FkPC/Dy/y+NC4LCB64y7g0QfFr+gBw39ZXmVqTr14SxG
	 N58dPq5WSivL4B86tAh2zaRrpox7KtWw+njNmBao=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 9B778AEA2;
	Tue, 20 Oct 2026 17:47:33 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	linux-pm@vger.kernel.org (open list:CPU POWER MONITORING SUBSYSTEM)
Subject: [PATCH] cpupower: Include stdint.h for int64_t in the CPPC helper
Date: Tue, 20 Oct 2026 14:47:13 -0700
Message-ID: <20261020214721.428420-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cppc_show_perf_and_freq() uses int64_t without including the header that
defines it. Building cpupower against musl fails with "unknown type name
'int64_t'" because the other included headers do not provide the type.

Include stdint.h directly instead of relying on transitive declarations
from other C library headers.

Fixes: 68f34fad760b ("cpupower: Add generic CPPC performance display")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 tools/power/cpupower/utils/helpers/cppc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/cpupower/utils/helpers/cppc.c b/tools/power/cpupower/utils/helpers/cppc.c
index 3493ce8551ea..e0e9784fe589 100644
--- a/tools/power/cpupower/utils/helpers/cppc.c
+++ b/tools/power/cpupower/utils/helpers/cppc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <stdio.h>
+#include <stdint.h>
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.53.0

