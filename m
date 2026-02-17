Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474F6285406
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355301; cv=none; b=dRoWrV9y10HTOlXAX1+Ero/VCnfx52ZeM3TXiLkyTWFVLR/HMLY+gAygWGTTny9RZr2/GjiwXH9fsbToMLpdu180L+41zCo86p/hANIOrrszUplt7D1M65vzNGoJYBe0sc9SuSJd4J6gG6v4cyaVVkkqlDfLZHKsIJbM5t+DjOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355301; c=relaxed/simple;
	bh=iGsc5AKk3wzHDbMRhdhJlgOytSsh4BVOhNFnB0TEz5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDImL3TjbOMupUV7k6TXn7bGMoAa4Q9jWeA3NyCmINE8Ko1Mjx3kCPKDXuLlbz5xRVFmJeiyh4IsxLrrMVUsgNJSBU7h51alJYX/OT99cs2lqeRZU9nG1fhsLSYBw9XQsqPnzI7HlaA1LSFZZl6nrzkjTV+J0ZeDSIHWJFSs2UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+cVx3vs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+cVx3vs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC1DC19421;
	Tue, 17 Feb 2026 19:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355300;
	bh=iGsc5AKk3wzHDbMRhdhJlgOytSsh4BVOhNFnB0TEz5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=R+cVx3vsZAyzweqt0F4O/uTFH5AhJBGuSlI0haXPuPTzI8Gkj05mOyUP+BoJSA8Vm
	 Wz/LnFLd62ACrLc9EW5iiedejGxwC/LJXap3NW1/x694+uISszs8I/tKp0U32mA/s8
	 qO2YrNCB9qnXNroyPOIC+4R8CGRW0gTv6Q4XsDd/hEthAaygofqBnUrnNdffW9rCgO
	 k5EUcsUwc3q8gyPgYJILcpLEQt1YBzD5dwMQJEGYnVzJ1BItyZG1zJyQKDxcgFdqTG
	 a9BLg+uXcQ9DaUEmTLz+HpAnW2fdyQLHrrag8qVRCUXl17BUBQF8MgS2EVupqAGRoY
	 FEKNQQBD9ZPWw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 21/23] tools/power turbostat: Use strtoul() for iteration parsing
Date: Tue, 17 Feb 2026 13:04:12 -0600
Message-ID: <8e5c0cc326f2e95a71bb6e6063e65caa60c8f951.1771354333.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
References: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

Replace strtod() with strtoul() and check errno for -n/-N options, since
num_iterations and header_iterations are unsigned long counters. Reject
zero and conversion errors; negative inputs wrap to large positive values
per standard unsigned semantics.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5239fd971b66..b8cbbff95e84 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -11536,18 +11536,20 @@ void cmdline(int argc, char **argv)
 			/* Parsed earlier */
 			break;
 		case 'n':
-			num_iterations = strtod(optarg, NULL);
+			num_iterations = strtoul(optarg, NULL, 0);
+			errno = 0;
 
-			if (num_iterations <= 0) {
-				fprintf(outf, "iterations %d should be positive number\n", num_iterations);
+			if (errno || num_iterations == 0) {
+				fprintf(outf, "invalid iteration count: %s\n", optarg);
 				exit(2);
 			}
 			break;
 		case 'N':
-			header_iterations = strtod(optarg, NULL);
+			header_iterations = strtoul(optarg, NULL, 0);
+			errno = 0;
 
-			if (header_iterations <= 0) {
-				fprintf(outf, "iterations %d should be positive number\n", header_iterations);
+			if (errno || header_iterations == 0) {
+				fprintf(outf, "invalid header iteration count: %s\n", optarg);
 				exit(2);
 			}
 			break;
-- 
2.45.2

