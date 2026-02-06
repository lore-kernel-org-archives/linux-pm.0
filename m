Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375A434EF08;
	Fri,  6 Feb 2026 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368292; cv=none; b=WPhnvrOQcZSf5dXDZY7VPA/QEKT17MnMbcE/2b2yqRmXIlsiORRY1z0HuEQ+8YhOxCFMnlGNAribkLl5Ug8BeIxpiCK9gOPOXPsyH4QpEHZrIxTRdRaDMdtcCwUnNpBbcKLqZ/sBAbkUhugDfceIoFc/hiI7lB50Ogjnf6vZGmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368292; c=relaxed/simple;
	bh=flnjHEoBY3HUtOXQ6dE6yHiBRtjQpdYUNq/y2u3trfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=spWp0Vt84ukdou5tU0NFHgHbiHDb458rN1mwFJsaP8q5kRZiTFzpUdFeTU9whlRwmaWOcsLMzDX8Yg32Ip3FB+IQt3UhONSIxvGGkxxwvfGpMv7rJr0LH+Tgxe7FVXVd5UAcnLBYTRzd6H1Sc6BVyJAXXeqQPNjHxUHRZA7mFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=fjW5yjSU; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="fjW5yjSU"
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 99FBC80671;
	Fri, 06 Feb 2026 11:56:47 +0300 (MSK)
Received: from kniv-nix.yandex.net (unknown [2a02:6bf:8011:f00:53d8:bc95:ff12:7d7b])
	by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id LuJfgZ0AH8c0-2i1O5uKp;
	Fri, 06 Feb 2026 11:56:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1770368207;
	bh=2a8lJpzmv7Jlx5zstJE2Bycr7GHKJKXbdcsHyNx0y+k=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=fjW5yjSU8Rb1axTQF5bdeAe+qcvFomQapqwC5jHPAD4GkLhD0FIB4HLV50OfJIT76
	 ZDXN+9hO/+NMbyLbrjbbVcWHgCkh6I0CveM4Bsoks/YF7o7P0eNfXsxoCEOnairuHF
	 ARjipxML0GuOW9JJIZEuXzgdytfaXw61VxBkWNng=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Todd Brandt <todd.e.brandt@intel.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Len Brown <len.brown@intel.com>,
	Nikolay Kuratov <kniv@yandex-team.ru>
Subject: [PATCH 6.12] tools/power turbostat: fix GCC9 build regression
Date: Fri,  6 Feb 2026 11:55:39 +0300
Message-Id: <20260206085539.1371685-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Todd Brandt <todd.e.brandt@intel.com>

From: Todd Brandt <todd.e.brandt@intel.com>

commit d4a058762f3d931aa1159b64ba94a09a04024f8c upstream.

Fix build regression seen when using old gcc-9 compiler.

Fixes: 640540beb883 ("tools/power turbostat: Add MTL's PMT DC6 builtin counter")
Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
---
 tools/power/x86/turbostat/turbostat.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index b663a76d31f1..86ffe7e06a14 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2798,6 +2798,8 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	}
 
 	for (i = 0, ppmt = sys.pmt_tp; ppmt; i++, ppmt = ppmt->next) {
+		const unsigned long value_raw = t->pmt_counter[i];
+		const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
 			if (pmt_counter_get_width(ppmt) <= 32)
@@ -2809,9 +2811,6 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
-			const unsigned long value_raw = t->pmt_counter[i];
-			const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
-
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 			break;
 		}
@@ -2879,6 +2878,8 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	}
 
 	for (i = 0, ppmt = sys.pmt_cp; ppmt; i++, ppmt = ppmt->next) {
+		const unsigned long value_raw = c->pmt_counter[i];
+		const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
 			if (pmt_counter_get_width(ppmt) <= 32)
@@ -2890,9 +2891,6 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
-			const unsigned long value_raw = c->pmt_counter[i];
-			const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
-
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 			break;
 		}
@@ -3078,6 +3076,8 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	}
 
 	for (i = 0, ppmt = sys.pmt_pp; ppmt; i++, ppmt = ppmt->next) {
+		const unsigned long value_raw = p->pmt_counter[i];
+		const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
 			if (pmt_counter_get_width(ppmt) <= 32)
@@ -3089,9 +3089,6 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
-			const unsigned long value_raw = p->pmt_counter[i];
-			const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
-
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 			break;
 		}
-- 
2.34.1

