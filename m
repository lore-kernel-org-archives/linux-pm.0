Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422192;
	b=W6iYVoeUlTei0KCgl8RlU9ebFuqrV3oQq+SJYPsNs91hx+GTdsFcU/JjQFcmBhtFg+GV
	 5mbNHtKucsty/pTODv2xoFyi2rrRps8OuTNCwd8i0utk6gC47KZPFPnWK+WKa7XkGogJN
	 RrvEADfRIa5mg+TEdnrlaq11EftL871QPD13LaJw2QBEQwE6txCC5JuJQ7PmZKL0IQvTF
	 ka+gc8vZCETQ/pltBGO7KQj06KGQK6FFmkGoSmi/SagKXEiEDTWeEq583VKsa297hUXAL
	 fFcivBgvWzILQZUnCE/ngkmhLSlaxfhk5k5OsdisOuhRaokJ44o7oIwN0aPSoTwXPNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422192;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=FGk052xffiwy9sBbpNhEau2WZNwxu8ZcoJfwABqFFHw=;
	b=QDc7V/0vSvPtsSYgggf712HLdWcepZ43MYzQ1qlqNKwuuhXAhOgt1ClL06wK6QzFwbfi
	 68O+WtZMitDR/ZFxUdqm73/mdgdjiamoq0AoT9JN82KWcgVxsCjrxev4dOSzQIxUsoBSn
	 j7z3lpgTYLH6mSjfFEND035dwxLCI4BaONiUz2mhNBumbIbkMsOEkuv2UOdfpXTjLpYM1
	 v6dIQdqMHSsnlxeWa4yIy1CBgRKg2p9pCBtxNhNzKqrYg4zh40qn+KJQZMgxRGEbT3qEx
	 Ief6sXyV5bUPI0YsmoeHeqKykOGwRrAGIA71BssSqOd0NN4w8tTU4Qfd++n8BIGZdfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C9VWpHDG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4A6607D369
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C9VWpHDG
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DFF6513D6
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422192; cv=none; b=V6D/Suhk5d85gX5tZ3NBwYHJJfd72EAx1qzCyufCnCbqHzzak6cwp3yZO+ry5Vp1KGlW/8Mt8Jl1r4PPtC7Y9NoU/SBQffFzyqfHykk35Jt9OZr1zdFePfP4+lcqjHRI/L6O5ImR9Kd2UilZ7T5U2gfaWFwzblf6q57eAJXkLt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422192; c=relaxed/simple;
	bh=OdX03N9WprE2Po34e/zjHS5/5/B5Cdin1TaSaspnRUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X48zgd6pKb0dPl60jlWjp7V6TjIsOsfDcSKXSBsrGNBsjvAnnoEEw1JY8j23vNwS09imR3kIKMascs4i6Spku+8tE7mByOONgV1hXTVTxx9X6Eix31MQVirDbGEjukur+/ZHzmIpzYM59PLLZjMEVN6Hg9fRxxDkiHjA6gxvTRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9VWpHDG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0ECE1F000C4;
	Mon, 19 Oct 2026 15:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422191;
	bh=FGk052xffiwy9sBbpNhEau2WZNwxu8ZcoJfwABqFFHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=C9VWpHDGXoQaMwAGCxQT/1dGXYaN/aIwrGjKTnRjoVlhq3K+AYPPE6J5M+S/SW1Dc
	 j5Bv99mm16j5voMSJaAFn+ntJnDarDkNtr8sZ4Dn1gkh5+zWxlMJ5vKA4H/bFpGGMm
	 bzyD+jiYagHfK+fMFbyyJRFmgh2Q3eLr+94/UKb93oV937/KXg8iml6HUV8Gg/Y6+o
	 ZuGwWCihqRXebpNPYaG0XHUlL2MYxFv/iN3Fl+STbkSc3buHCTtGyzh+7OI6Bk+3Op
	 JjA8NYh8vBml6hcHJYKM94NorDQRq6QWuV7VcfbmmT9v+DuOh7GHEdcSrK3VkXKFDV
	 7/fWdrBVDfByg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 18/23] tools/power turbostat: Allow multiple --cpu on cmdline
Date: Mon, 19 Oct 2026 10:38:51 -0400
Message-ID: <dd632f4ed40c0ee34e0190962f2ab80c4812effe.1792420722.git.len.brown@intel.com>
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

If --cpu is on the cmdline more than once,
previous invocations are forgotten (and their
cpu_set is leaked).

Allow multiple invocations of --cpu on the cmdline.
OR them together, reusing the same cpu_set.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 |  2 +-
 tools/power/x86/turbostat/turbostat.c | 12 +++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 830c9f094765..c905198d0501 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -92,7 +92,7 @@ name as necessary to disambiguate it from others is necessary.  Note that option
 		'%x' hex identifier of the PMT MMIO region.
 .fi
 .PP
-\fB--cpu cpu-set\fP limit output to system summary plus the specified cpu-set.  If cpu-set is the string "core", then the system summary plus the first CPU in each core are printed -- eg. subsequent HT siblings are not printed.  Or if cpu-set is the string "package", then the system summary plus the first CPU in each package is printed.  Otherwise, the system summary plus the specified set of CPUs are printed.  The cpu-set is ordered from low to high, comma delimited with ".." and "-" permitted to denote a range. eg. 1,2,8,14..17,21-44
+\fB--cpu cpu-set\fP limit output to system summary plus the specified cpu-set.  If cpu-set is the string "core", then the system summary plus the first CPU in each core are printed -- eg. subsequent HT siblings are not printed.  Or if cpu-set is the string "package", then the system summary plus the first CPU in each package is printed.  Otherwise, the system summary plus the specified set of CPUs are printed.  The cpu-set is ordered from low to high, comma delimited with ".." and "-" permitted to denote a range. eg. 1,2,8,14..17,21-44  Multiple invocations of --cpu are OR'd together.
 .PP
 \fB--hide column\fP do not show the specified built-in columns.  May be invoked multiple times, or with a comma-separated list of column names.
 .PP
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 3dd312931d1a..eb76e337267a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -11552,16 +11552,18 @@ void parse_cpu_command(char *optarg)
 	if (show_core_only || show_pkg_only)
 		goto error;
 
-	cpu_subset = CPU_ALLOC(topo.max_cpu_num + 1);
-	if (cpu_subset == NULL)
-		err(3, "CPU_ALLOC");
+	if (!cpu_subset) {
+		cpu_subset = CPU_ALLOC(topo.max_cpu_num + 1);
+		if (cpu_subset == NULL)
+			err(3, "CPU_ALLOC");
 
-	CPU_ZERO_S(cpu_setsize, cpu_subset);
+		CPU_ZERO_S(cpu_setsize, cpu_subset);
+	}
 
 	if (parse_cpu_str(optarg, cpu_subset, cpu_setsize))
 		goto error;
 	if (debug)
-		print_cpu_set("cpu subsetset", cpu_subset);
+		print_cpu_set("--cpu", cpu_subset);
 
 	return;
 
-- 
2.45.2

