Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A253BF675
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775827724; cv=none; b=IXJej9buINVT+1/f6XTI8xnACkCb5t/Tas/FxIop+naaldbxplSboYFRfz9HPNLlWgWqRX2p8Bq4M/F+encczm4EOLqBXNtq/fn44quzRSh8ThTnC/kjB0DPSHOu91fy82u/rJBC6XBFrpEU124VL5v4OV/nIZDKi2ZrgO8vCDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775827724; c=relaxed/simple;
	bh=UWb+yA6WqbGrO0R5oNdMiwfyvTxD4JjhrXv/f22v69g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMiPHUFs8cJKkCk7reV8rfMJ5V9StHOWbJpMto/f5r7Iv1KUAcR9sekF+4qi7Z83+oiK83+cJ1I4Flp95CpP8tsyjHtFnwofacmF6NnL6Usx1YdyQcHvp03Aoc2UphDhmfXMlRxqUhsurYg09wKMjOEZ5qwaAzxhhdJsA/WTMRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfBy/4Am; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfBy/4Am"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E98C19421;
	Fri, 10 Apr 2026 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775827723;
	bh=UWb+yA6WqbGrO0R5oNdMiwfyvTxD4JjhrXv/f22v69g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=kfBy/4AmnspQzf+q7p3+BLEVhppX522fLGXge3JaVSQ+yoMqv2dud3t8DN8UdNkj6
	 N2RJHXRaCTgXZkQp0H0e4lQIVu/J50a7fIsExkVUKRdl8uyB+0gYpvueLcspL3alBO
	 pX5jYuEEjjgHuHVtWkCMm93aThl54aOeuHj9HkZJg3pCepWBzWxoTwkdvRYAP+VvMa
	 HQVaeIAxieHeZwNF/3Avo/7XZIbWzXVaQw/hfHo/1g46Q5vMTA2WmmSKmb39vgavTr
	 ijXu0kSibpsQHpkFpHYILVkeup0LdJvGLpoy4+njhv1WCVvzr36rsVgmCJReM0fBK4
	 3FuxoVwKoHehg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 6/9] tools/power turbostat: Fix incorrect format variable
Date: Fri, 10 Apr 2026 09:25:11 -0400
Message-ID: <23cb4f5c81766e70e5f32ed0987ee8fb5ab2e00a.1775827309.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <57d2371d52be1d574b33382bfbf8052485b99d8b.1775827309.git.len.brown@intel.com>
References: <57d2371d52be1d574b33382bfbf8052485b99d8b.1775827309.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

In the perf thread, core, and package counter loops, an incorrect
'mp->format' variable is used instead of 'pp->format'.

[lenb: edit commit message]
Fixes: 696d15cbd8c2 ("tools/power turbostat: Refactor floating point printout code")
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9744f9caac9a..4d954533c71d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3468,7 +3468,7 @@ int format_counters(PER_THREAD_PARAMS)
 	for (i = 0, pp = sys.perf_tp; pp; ++i, pp = pp->next) {
 		if (pp->format == FORMAT_RAW)
 			outp += print_hex_value(pp->width, &printed, delim, t->perf_counter[i]);
-		else if (pp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
+		else if (pp->format == FORMAT_DELTA || pp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(pp->width, &printed, delim, t->perf_counter[i]);
 		else if (pp->format == FORMAT_PERCENT) {
 			if (pp->type == COUNTER_USEC)
@@ -3538,7 +3538,7 @@ int format_counters(PER_THREAD_PARAMS)
 	for (i = 0, pp = sys.perf_cp; pp; i++, pp = pp->next) {
 		if (pp->format == FORMAT_RAW)
 			outp += print_hex_value(pp->width, &printed, delim, c->perf_counter[i]);
-		else if (pp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
+		else if (pp->format == FORMAT_DELTA || pp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(pp->width, &printed, delim, c->perf_counter[i]);
 		else if (pp->format == FORMAT_PERCENT)
 			outp += print_float_value(&printed, delim, pct(c->perf_counter[i], tsc));
@@ -3694,7 +3694,7 @@ int format_counters(PER_THREAD_PARAMS)
 			outp += print_hex_value(pp->width, &printed, delim, p->perf_counter[i]);
 		else if (pp->type == COUNTER_K2M)
 			outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), (unsigned int)p->perf_counter[i] / 1000);
-		else if (pp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
+		else if (pp->format == FORMAT_DELTA || pp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(pp->width, &printed, delim, p->perf_counter[i]);
 		else if (pp->format == FORMAT_PERCENT)
 			outp += print_float_value(&printed, delim, pct(p->perf_counter[i], tsc));
-- 
2.45.2

