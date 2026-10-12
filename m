Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CC54D598C
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830119; cv=none; b=mdQLpRW00FFVJGxy3Y2xs7ZpEtYNacpxUNcRaPudZZzbOm1by3JiOBMemR1H67k+k52QFTA0Ud6PsrrqSo6nKsZ+qX7WBQ4Vd7437umhSNRbg5kzbb1TmuQ+1QQL6BQLDEq3gofrIw4KU1zPeyYTW3ZLn3azXfnnIa1Otmqkws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830119; c=relaxed/simple;
	bh=pzKJNFb2uR+ZZRzdiJY9nRBqCsYBr061bAUoIwSzuYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZqTRRCazn12q0ZJinQSaTOK0m3JoHV+EKsK4cfLFVNBGB057lwSZAnrnG/zaddOcTesijX4VGcftYi2W8Uq4mImg73wEcXSI6JEfsbB5w52cmgudIuf+KWyL64rcxOLmQwdkQ5BA4/nA8m2nFA72UucnLYuxqbeIibe/Ax0LVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HT4S/G27; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT4S/G27"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93C11F008A1;
	Mon, 12 Oct 2026 18:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830118;
	bh=EaXrXpm9IvSdxnfQpQFjq2/0H4CTfkYNsen+79x03/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=HT4S/G27mYKwHXy3KnsUIYd3YHSXUKeBhy/hAWm5B6wSjAhEwsTFb2ilQCVhFxXPm
	 vkDpShsYqwLrUytc8QRjvlF1PEgAIELXCMqDepQjTex5XErEvuzrW3tGrEK288MDiq
	 4SKTzRXqnz9FXeGulKanhLUhv1cqjUqf95j27ec/GEnbH0ZAExD7BMkACXkfCYxdLC
	 RwnzEbaMHHlL/qBNBi3ytw40DJxiKBObCGH5+6ey2TA7K/LSrhsgugN7wY4In68q6k
	 lAMxfkHvOvCr8K9Wzt7O+RYiQbpU4wbLg8L2AFJ/zU2CRfk2VnsTUTh59mqls3DOsq
	 2V9xl7uPvmnlQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 8/9] tools/power turbostat: Fix add_counter issue if > 24 counters.
Date: Mon, 12 Oct 2026 14:32:33 -0400
Message-ID: <154b96dab83fd953b9b82c8bcfa041cd6a9d74d3.1791829903.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <c24362650f7a8573dc9a9991a034b8500af8eb19.1791829903.git.len.brown@intel.com>
References: <c24362650f7a8573dc9a9991a034b8500af8eb19.1791829903.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

We allocate space for added counters ahead of time,
and we arbitrarily chose 24 added counters of each type.
If a future code flow hits this limit and continues,
and then removes counters, we do a phantom increment
and lose track of the number of added counters.

Increment the count only if there is no error.

Fixes: 388e9c8134be ("tools/power turbostat: Make extensible via the --add parameter")
Assisted-by: Claude: Claude Sonnet 4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bb1e54a23ae8..9a2aa703d9d6 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -10687,10 +10687,11 @@ int add_counter(unsigned int msr_num, char *path, char *name,
 				fprintf(stderr, "%s: %s FOUND\n", __func__, name);
 			break;
 		}
-		if (sys.added_thread_counters++ >= MAX_ADDED_THREAD_COUNTERS) {
+		if (sys.added_thread_counters >= MAX_ADDED_THREAD_COUNTERS) {
 			warnx("ignoring thread counter %s", name);
 			return -1;
 		}
+		sys.added_thread_counters++;
 		break;
 	case SCOPE_CORE:
 		msrp = find_msrp_by_name(sys.cp, name);
@@ -10699,10 +10700,11 @@ int add_counter(unsigned int msr_num, char *path, char *name,
 				fprintf(stderr, "%s: %s FOUND\n", __func__, name);
 			break;
 		}
-		if (sys.added_core_counters++ >= MAX_ADDED_CORE_COUNTERS) {
+		if (sys.added_core_counters >= MAX_ADDED_CORE_COUNTERS) {
 			warnx("ignoring core counter %s", name);
 			return -1;
 		}
+		sys.added_core_counters++;
 		break;
 	case SCOPE_PACKAGE:
 		msrp = find_msrp_by_name(sys.pp, name);
@@ -10711,10 +10713,11 @@ int add_counter(unsigned int msr_num, char *path, char *name,
 				fprintf(stderr, "%s: %s FOUND\n", __func__, name);
 			break;
 		}
-		if (sys.added_package_counters++ >= MAX_ADDED_PACKAGE_COUNTERS) {
+		if (sys.added_package_counters >= MAX_ADDED_PACKAGE_COUNTERS) {
 			warnx("ignoring package counter %s", name);
 			return -1;
 		}
+		sys.added_package_counters++;
 		break;
 	default:
 		warnx("ignoring counter %s with unknown scope", name);
-- 
2.45.2

