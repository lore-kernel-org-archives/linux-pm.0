Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422186;
	b=oAH8WB6r/eAcWNTI22V03g/CEw2VU8ezJOaGSq6M4mlyLHnf101Mi0pZqLY+1b4UMUHi
	 G/QlTNF1AS6jIVcXzLRft8kD8lhhDXOrWbr8YJoEBO/92zs95SNZEDJCFCpTHJ2f4J0Vk
	 N6mZsJF3p3A1OmFtIzLb/hVxAgOYLAYH8MPUzjP6OfHQ2HpQcHyPozSK4fs+TvMPW5yPz
	 3xWEC6UUcXbkr9XbglOHjSV6l/eBo3UvjvLdtj6sR9xIBNjAf6p9AACWg8+iT8iaXoGaL
	 pS3yMojfFJOpXACr/haY7uoqLxXhMK/pSaJwNTA2xcrBaAQL3gdEyQd0tpZOOhGldYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422186;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=E5AUocmKcd7CC7pQ/6R8vLp3Nnr2RaXhLbfPkbpPsLo=;
	b=j6ga9Prg55Eze+aHs6vY8k1dARhX8GNfM/8QKL54Px6HS5tp2THN6S7vICp1H5RH3H+y
	 AlqU9+/M4JpABNczyZej8BnIKYNkXMnXLkLLtzJc41ZkrUEaPNyvFLXu1Bvxr6W8WHDf1
	 2OqNhiTePosaKSFix7pRoc4dJjbUT4ru5I09NrVFVvrSvdrJNKEYUzrLwJ7qvmbyIkRYn
	 yKcO+GtK2CHbUDq2qCtZ6q0fdiaiTB8tPjRh+cCVWKKVEElLOqFlxa3vE68Bg88uZnwR7
	 IhLAMIFiSBRD6uJN4d5L/1JhfOqTdL3altmL7YNH1DVDfDUYz/t7+8hkqhWl3LEmh0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fh9iQwL7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10743607BF3F
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fh9iQwL7
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAE86513D0
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422186; cv=none; b=VT/POuZ9NKJoBE2ZR3nf53SCHpSZrGsqmRGvT8OpOV8LTbV4QyM++/K9uWhe18Aw2YSIr45E1FP1G+Xu2zi9KcNN0AeHsiT4kiWq1rlQFsmGDo/5yf6l2SymmzwdbGVfIP6GMMV8TvJQmcOCVDctlmxuJUBabto+6NTaOCPEm0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422186; c=relaxed/simple;
	bh=u3Drwmj6GjnTLT0pN/KWSOsV8NtkqjqLzyIGc+kZZEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKXeib+6vRJl0ik5QPrASfuQewMgFtf60pK2KD5q3sZO2UJTzOp9UdFRapSEz1T44hRmqCY2WeE+PZYYU20tvp3FYdoUHBjc6OIWCD0Rkh/cIFXr1mrlI15AKSj1VXSIt/vf5nvJobkiQHjFwdzhhJEqrGI9bWTHiLcnDgwuSTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fh9iQwL7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C27B1F000C6;
	Mon, 19 Oct 2026 15:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422184;
	bh=E5AUocmKcd7CC7pQ/6R8vLp3Nnr2RaXhLbfPkbpPsLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=Fh9iQwL7kCi594g9DgxOHlxIJIozcMjuxK77T6+Id8D0kmt/054xA7tLeqi+1MWVp
	 dxKEb75CEGCF9CWSJm92qPZF84+KHazuSdSMeLJdarcy8Dcz7qCIuRpm1Zya6gBBf3
	 u1J9z/v6TXnBPhXz4MxW8y1rr6RqRoVmxCdQl/nD19+g2UhZj4Tx5SW4c2IYkcGlZS
	 5Ex8zU1vGfzP25be4PyP7CIGvc7h1cOCq7TR8HOMfq5GOsFkuWNcqOLsvxeUGX+Coc
	 u4ow+83l6+N0r7PIPr//19hZa5pcZ8DxKhI7RD7OLSpyprNCPNtQskge5adAtPGm2f
	 XR3klAoPHWpSw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 13/23] tools/power turbostat: pmt: Improve sscanf() hygiene
Date: Mon, 19 Oct 2026 10:38:46 -0400
Message-ID: <e817a533bbc0aef5a9cb6255153941ed968d2fb1.1792420722.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <962d0202306072651ef459abf1f7240c73afaee1.1792420722.git.len.brown@intel.com>
References: <962d0202306072651ef459abf1f7240c73afaee1.1792420722.git.len.brown@intel.com>
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

Explicitly check sscanf() return values for number of matches,
and handle EOF (-1).

Defensive programming -- not an issue actively seen by users.

Fixes: 4265a86582ea ("tools/power turbostat: Add PMT directory iterator helper")
Assisted-by: Claude:claude-sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index dbbaa737342d..cacdf4c9c5d7 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2011,15 +2011,17 @@ int pmt_telemdir_filter(const struct dirent *e)
 {
 	unsigned int dummy;
 
-	return sscanf(e->d_name, "telem%u", &dummy);
+	return (sscanf(e->d_name, "telem%u", &dummy) == 1);
 }
 
 int pmt_telemdir_sort(const struct dirent **a, const struct dirent **b)
 {
 	unsigned int aidx = 0, bidx = 0;
 
-	sscanf((*a)->d_name, "telem%u", &aidx);
-	sscanf((*b)->d_name, "telem%u", &bidx);
+	if (sscanf((*a)->d_name, "telem%u", &aidx) != 1)
+		aidx = 0;
+	if (sscanf((*b)->d_name, "telem%u", &bidx) != 1)
+		bidx = 0;
 
 	return (aidx > bidx) ? 1 : (aidx < bidx) ? -1 : 0;
 }
-- 
2.45.2

