Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30C640DFAE
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 04:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774931564; cv=none; b=sXqweD9HOKjXXFQfXAqYKaayqchFfxUMLJhdMFiZPbrCSPUMRUFNHJCi2klphAaacTSiQuzzebXvzGe3Z9zb+b/OcAwsp6SFjKkCM+05LfQMiwmI/wAP1UWu0ZKsGGW8TPj1dKgV/3xFTprze/cffCzOsO3/s1UIUGGN7Y50EkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774931564; c=relaxed/simple;
	bh=44FAWQf4T5G2z3kDccPQZP3fp/27F/L/ul2g9pqnNsU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tx8xfxpIm7zeZOP+4MPf9tWu1D2jiXBKr4qXEl/yXEOc/usPk4CxuSQH1QfpcUWYu4+l8y55xr6BtyXSrYKIzlith6XNTZtmQPbqv5pO+wNufWNiShPB04nmgO96jSbEsGaDh9OnJ35cbRiOeW+5rWadrlfEeB1RS6MGl6l61Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sz1plgoR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sz1plgoR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774931562; x=1806467562;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=44FAWQf4T5G2z3kDccPQZP3fp/27F/L/ul2g9pqnNsU=;
  b=Sz1plgoRjpzv2kaB5vDLtH0wqpxGRiULUK6S+lKvIXXjJjviFbkwH039
   oCipD+F99tjPQUE3iFVcCgn+6/8MiAyvgmRPHHJPoDjjYeKCXVsQ7u85I
   oefeO0+UoAR0oLkCxiUzNv1qDdfzK5kl83DY5ipO3jx4aYAVjNYqhLKzp
   ZHQ9DPbZfxOgWfsswAFJpQBUTzPYDRPNfWh3SgygW0lFhmovVivySg3dj
   tuaVh0/NSdb3AvunyrV/PMfNS3DlD1CmsCajKRvgBX/vYvH10/pXEPqlS
   S68ZCWDTeoBCe7rn2U1dtDL+UADn00bEjo9EnCPXLNPrfkIZG9mUCyoue
   A==;
X-CSE-ConnectionGUID: sLGRRsuaQyOovsp/V9SREQ==
X-CSE-MsgGUID: ebMux73dTfCdpHQQBPMmIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="79794453"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="79794453"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 21:32:41 -0700
X-CSE-ConnectionGUID: R29E3ap0Rr+8hXbW+E4SsQ==
X-CSE-MsgGUID: pckNgrHbQveGVfQXtHOFGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="219596885"
Received: from baandr0id001.iind.intel.com ([10.49.109.195])
  by fmviesa009.fm.intel.com with ESMTP; 30 Mar 2026 21:32:39 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] cpupower: replace atoi() with validated parse_int_range() helper
Date: Tue, 31 Mar 2026 09:58:59 +0530
Message-Id: <20260331042859.1920369-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atoi() provides no error detection for invalid input or out-of-range
values. Introduce parse_int_range(), which uses strtol() with full
errno and end-pointer checking, returning -EINVAL on parse failure
and -ERANGE when the value falls outside the caller-supplied [min,
max] bounds.

Switch --perf-bias and --turbo-boost option parsing to use this
helper. Also move error messages from printf() to fprintf(stderr)
to follow standard CLI conventions for diagnostic output.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/cpupower/utils/cpupower-set.c | 29 +++++++++++++++++------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index 550a942e72ce..dcbdff5c9ae5 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -31,6 +31,24 @@ static void print_wrong_arg_exit(void)
 	exit(EXIT_FAILURE);
 }
 
+/* Safe integer parsing with range validation. Returns 0 on success,
+ * -EINVAL on parse error, -ERANGE if value is outside [min, max].
+ */
+static int parse_int_range(const char *arg, int min, int max, int *out)
+{
+	char *end = NULL;
+	long val;
+
+	errno = 0;
+	val = strtol(arg, &end, 10);
+	if (errno || end == arg || *end != '\0')
+		return -EINVAL;
+	if (val < min || val > max)
+		return -ERANGE;
+	*out = (int)val;
+	return 0;
+}
+
 int cmd_set(int argc, char **argv)
 {
 	extern char *optarg;
@@ -69,10 +87,8 @@ int cmd_set(int argc, char **argv)
 		case 'b':
 			if (params.perf_bias)
 				print_wrong_arg_exit();
-			perf_bias = atoi(optarg);
-			if (perf_bias < 0 || perf_bias > 15) {
-				printf(_("--perf-bias param out "
-					 "of range [0-%d]\n"), 15);
+			if (parse_int_range(optarg, 0, 15, &perf_bias)) {
+				fprintf(stderr, _("--perf-bias param out of range [0-%d]\n"), 15);
 				print_wrong_arg_exit();
 			}
 			params.perf_bias = 1;
@@ -100,9 +116,8 @@ int cmd_set(int argc, char **argv)
 		case 't':
 			if (params.turbo_boost)
 				print_wrong_arg_exit();
-			turbo_boost = atoi(optarg);
-			if (turbo_boost < 0 || turbo_boost > 1) {
-				printf("--turbo-boost param out of range [0-1]\n");
+			if (parse_int_range(optarg, 0, 1, &turbo_boost)) {
+				fprintf(stderr, "--turbo-boost param out of range [0-1]\n");
 				print_wrong_arg_exit();
 			}
 			params.turbo_boost = 1;
-- 
2.34.1

