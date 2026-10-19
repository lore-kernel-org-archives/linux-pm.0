Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428729;
	b=w5ShZ/iuRlpciYA42ZirsC/D3rUrcI7mrtDVxb13+3e4jCIZbvgczSyk2q8+6fvh3SMv
	 J9ooNk5C9QqeSXm2v76tfjW22pnS9SA8w+HOZ9+AiPjP8iMUzXY/qjn5libKvzhysGiAq
	 +XUAEV8eSegnByaJOa4CkRy9xs8AVsPGWqgD8Tkv2NAgXfflYJXBzek/tpSKelaGO4Gzl
	 mqwn6g041kJvYfWFsWY/Wl44c8VYe3jagQ2sPV+8BZZJ/OFtVSI0qROlQRaris34ORPaX
	 MrKqlf8ZCcvIWE8ndGE1F+B1Zq0RrV8RBmNkOaURxzEMz6OwHn7AqddqnvPUStTbznQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428729;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=d9pbLEUNco4cZ8ZPUbUrHgubWgCqCZlxcXcCPnx/xaI=;
	b=4zt5/+d4lEXv4EvCfrcGdclpcHvjrfLhP0EeZJyTSYtqz23bpsn+YI9LU/oK7oDxxaN4
	 r58pfX4zNg9rHXzM1qVPMtNF2SeaiwGq93c4+EbZkj+xelN9zZMrzjVZr7W4DxgHYxfQ+
	 rmaOFIfWq3tN1cF0PnXyGKx+vtdWQ83GV83G95aZiKL4sUFLiHQhxkkgJ7PJRh9L55FSU
	 E6S0t8mgKjwE9ZpqYc5xhkZ/8dYm9LKZhEGqGA6u7WFpCI3sDD9Omm2VENnN4o1n+061W
	 wtYGyq7tsMZERGnrb1WpW2TvopmVmEmcxlAyuWngHfeBh5OL5jCEUq0hBnUv77l8siA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xpn0uXwa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621CC606A329
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xpn0uXwa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E37A1F000CE;
	Mon, 19 Oct 2026 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428729;
	bh=d9pbLEUNco4cZ8ZPUbUrHgubWgCqCZlxcXcCPnx/xaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=Xpn0uXwal6+JJW0kLBzuzjUQBjtDYtOhd8ez4v8+tKOECyI+oVhVZM/FqHZGL0JUY
	 DAkT9/vTwTMlCaNckzexDZEiGPSMLg+fDw+ZAd2UPNJN6NKGgTG3sZBzBPL0o4S8Xx
	 8ugrv8A5Jd0xugsMqt0Q+6aBCCoNbUnTg4L4Au2AubH7B7QC3R1to3FcFAD+ps7dsh
	 SUOU3t6XiBmtCnjN6GaxAajkTHeNe0c5MZ2MdGuG8EzYoh161Jp4BhsAXKGOaTExuF
	 7gxtuuihTrhcJjJpKsisqYsQwCwsQUPagwPQoTEtjoLn9V+AZ5LrhrL/EGYVnD3UAh
	 9zL1DEIOsm4SA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 06/18] x86_energy_perf_policy: Fix optarg keyword matching
Date: Mon, 19 Oct 2026 12:43:27 -0400
Message-ID: <9d79f74ed3e6f247542fed973c6c7ee3d27a9364.1792428130.git.len.brown@intel.com>
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

Replace strncmp() with strcmp() for exact string matching in
parse_optarg_string().  Exact keyword matching is safer and clearer.
This prevents accidental matches with longer strings
like "balance-power-extra".

Fixes: 4beec1d75196 ("tools/power x86_energy_perf_policy: support HWP.EPP")
Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy/x86_energy_perf_policy.c  | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 8ce47d46eedf..5afff02bf9e7 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -337,22 +337,22 @@ int parse_optarg_string(char *s)
 	int i;
 	char *endptr;
 
-	if (!strncmp(s, "default", 7))
+	if (strcmp(s, "default") == 0)
 		return OPTARG_NORMAL;
 
-	if (!strncmp(s, "normal", 6))
+	if (strcmp(s, "normal") == 0)
 		return OPTARG_NORMAL;
 
-	if (!strncmp(s, "power", 9))
+	if (strcmp(s, "power") == 0)
 		return OPTARG_POWER;
 
-	if (!strncmp(s, "balance-power", 17))
+	if (strcmp(s, "balance-power") == 0)
 		return OPTARG_BALANCE_POWER;
 
-	if (!strncmp(s, "balance-performance", 19))
+	if (strcmp(s, "balance-performance") == 0)
 		return OPTARG_BALANCE_PERFORMANCE;
 
-	if (!strncmp(s, "performance", 11))
+	if (strcmp(s, "performance") == 0)
 		return OPTARG_PERFORMANCE;
 
 	errno = 0;
-- 
2.45.2

