Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422183;
	b=CNh1ofRwsYk/x5XE+I019Xrz6cc6lCE7rp/g4+pQoSW1Z5/L2s9cSgzuaQFayEr+xPLX
	 DbCxiD4aPrLXVDAy9XScLw5wVVZN0FLfxcla7h+FAswrC/ln3SnZY5JYoXwSdhMJOd72w
	 n1RMjmt3EkMb08fVY3tjah/8nc0zQEHcXnzc2w64cRU8dw+PoKHaCAkrPJEIkDBIx1MAK
	 CTMF48I844O5utBFAV96JuwelHiUrkOqxyMZ/DOphzQ9RRV4uFfBBKaBgcjleRgezUYuv
	 L7Js8mniX2HiMmLEWp/8dcDN+opVxwkC+xN46w150dSF3Y3VKyD/p6HbV9n7gXd2J+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422183;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=a3lwkt1ZohAGOrSqwAYzmQWTtjwFrpyeZEK1Hc5Oasc=;
	b=U0b5b2MgB+lYGsWF/3xt174krr0kJvbE77t2eaQGik8a/Zy3n2W07+XpV8kBbWBD1VPX
	 kuRTKQe9UBLIvqij50rNCEgYi13RKSxlU+camfjXNcL/O78TsB5vdRtRkxDiw0Dzx82Es
	 CWeb103hvXOaX4PFTaVko5qdAZWq4KwsbNZO5ibBn0uGEjY0NzLBb9BhTdpejyUtrohoF
	 viYiW1U7MCSfzwZWfLF1IRSd9CiO4yM7XmOj8lC4Wn9jhqr1RIa1h+hX7Oiy+v3w8Tg68
	 QmGWI6ZSb8B7ioTca5sQCOAqDZf1sXoivpUhZRsPZySpDPY82LRLlRob2j0qaZRRpXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dglvHI59;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C911607BF3E
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dglvHI59
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750246513E4
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422183; cv=none; b=iMw7vXJRlqy85LgVR6FUCdA5qwPQyCv9t9IR3o51+SgspaAs5iSaEGcW5xU58as6ChgOaoyCHa3jnLk7t+R0B6kHx/IgOGQvRe5hGysdtzXQQM9AEQXaX3XUmRj4es3qvA+/f/0apNsCHf5eNOHpPpzMputMjCcaQ6nvu4vtlFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422183; c=relaxed/simple;
	bh=qFkUrCbvxzxjQfNec1sJhbiDhIPgsOrSs2G9kbqtinE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHbYSRMPgFztamq5ymHTskK5cxbswne/eDP0y5ZsXu6MDg6BO+mdtN3O7dq5EPRJBRYE1JsfzOKxs0WL2XLzxbWuKxCEcIbyz6VvvuETnHMipGkfzFVnbbCN5+J62Hs3bXCZRDlJdjF+ija+9wKgqev8FPt3x/1E/bty4bI9zNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dglvHI59; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E941F000C7;
	Mon, 19 Oct 2026 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422182;
	bh=a3lwkt1ZohAGOrSqwAYzmQWTtjwFrpyeZEK1Hc5Oasc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=dglvHI59T8pQRPm/jp32ev29pjOP0os/b5K9RMW8vZ+QvWUDywwZE4cQAivRJfAgu
	 MmvSC6iWRou4duW+mry5UfBlEm2oJfsZJHTd7sbEoLPAUqDoBEi7mXDuYPZJ6B/YMP
	 Vwq4GkwRiqRTVD2ZXaUJVUCRT4kCJwOb9wuaznLFsekSsLObPpBGX5rkyAN1ATH8Sf
	 3EIlypRuqdGXtezhg3EqkoeYtkpmBgnMHR3yLi4w82JjXj+/uWdeeRZPLO8ViBbL1Z
	 mAbAzbWnpJ7e2EF0f/2eyeJ0cNsNamdbyjz5/VimzV/WocWs0wHUO7470cq3q/1s1O
	 OuTNP00uljioQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 11/23] tools/power turbostat: Fix typo: MHz, not Mhz
Date: Mon, 19 Oct 2026 10:38:44 -0400
Message-ID: <501c340739775ae01139b02ff50d392d0ca20e6f.1792420722.git.len.brown@intel.com>
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

The SI symbol for megahertz capitalizes
both the SI prefix ('M') and the unit symbol ('Hz').

Assisted-by: Claude:claude-sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 4 ++--
 tools/power/x86/turbostat/turbostat.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 344ede2f8546..830c9f094765 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -269,7 +269,7 @@ Periodic output goes to stdout, by default, unless --out is used to specify an o
 The 5-second interval can be changed with the "-i sec" option.
 .nf
 sudo turbostat --quiet --show CPU,frequency
-	Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	CPU%c7	UncMhz
+	Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	CPU%c7	UncMHz
 	-	-	524	12.48	4198	3096	74.53	3800
 	0	0	4	0.09	4081	3096	98.88	3800
 	0	4	1	0.02	4063	3096
@@ -279,7 +279,7 @@ sudo turbostat --quiet --show CPU,frequency
 	2	6	3	0.08	4159	3096
 	3	3	1	0.04	4046	3096	99.66
 	3	7	0	0.01	3989	3096
-	Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	CPU%c7	UncMhz
+	Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	CPU%c7	UncMHz
 	-	-	525	12.52	4198	3096	74.54	3800
 	0	0	4	0.10	4051	3096	99.49	3800
 	0	4	2	0.04	3993	3096
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index cab144d1d5ec..3248a6a60732 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -658,7 +658,7 @@ double slm_bclk(void)
 	freq = slm_freq_table[i];
 
 	if (!quiet)
-		fprintf(outf, "SLM BCLK: %.1f Mhz\n", freq);
+		fprintf(outf, "SLM BCLK: %.1f MHz\n", freq);
 
 	return freq;
 }
-- 
2.45.2

