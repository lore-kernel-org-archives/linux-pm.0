Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422197;
	b=ALxeiZosGsLFQU0kmZd6sj5kcYYQjb5awlOMVA3eTn57LSSDCkdbAgCOnIaSygCIStmN
	 MpLYyesfm789+4phzqGT2KoIi/FK5cguVT9r8hP02DseOFQxxN1NhxMHhIA+h4kp9WYgO
	 WjncD3yi977MTA3RitAhNKo335TWcDGBIwHCg19kR6jQnptqHbXd9n1AfEzduv7n6XHRQ
	 fRmrxADGPmNEAAkkJ9kDGzfPxJjGu7vjLKrqHP2dETHn/eGLRu3PtPumTt1s97PFvtcj6
	 kouGliwioi9gfEIXitmtGJjpUpLMqOlg8tdBixvNbkKjFfJzB9e8abd4vV8H14/40wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422197;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=4I3Pxc/iTGzWoeyx6YQ4e7tLw46TYqzKa0lkzB2yq7s=;
	b=ngGqkae1B9JcBrh5lTzDDIFGAi7Grub4K3rcTjeOXVYBEFWuDp+9SI3dncoR7bSLyUot
	 UFOFeok8pnL5un5RyRRgF+vh/RUdoRIS6K1/YLONwHCdw4k7Y1FYCao7wRDmbCuP/T8eo
	 KYpvu9VmDiRhlyljm0KqKyEzybptxX71k15WKfXOGDbu6aC2zguCojK++1UzDnAv+C97N
	 RZUozpfoZW8ZkniiavjQNI0biIhNJcBin77vZGR7bbo/sy0HVoNUibFU4WBKb5gitAQUq
	 sS6ZRmJP0bg96VlrdOUWhAsMuPLxCLBPaachOd/xaoTXaRGnYtgKXZebjIKRQQdmH7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nF5bVqZi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586C8607D378
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nF5bVqZi
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE3A6513CA
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422197; cv=none; b=GHc42Tbrf5wzx1mxvCRI0m0NKpB4AZ3nrv5UUu89llciJkFuFBLz+EuMRkz4rD7m9uqU82tkMb67vmp3aNHyh70OGFNi9h6EBxKWxPfwBjBFJXpOSokSSQ8mdOdm30ROqY9hMUB/2iXs4hhElYvCD5skstSmeIY7B4fO0H+TU98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422197; c=relaxed/simple;
	bh=ofk+NHDAznG++QEUMvGhFz2SwKjQfABNO2faCGIpDaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qw2Wyj5j+W+L9jeiy2PkgrdYzCBGcQ8advnqce77ebHRjEWAKfQTdu3AAJ0SieOBecdTr8vrW0ggdeIPFTbqY+LGsURNy59KQRKhodDF5baD5SY2en0fckE8RHorkoWRBk9er1iNSDDafPQ87ZDktWVlaaD2muZn607EPFGVjvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF5bVqZi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E124D1F000C5;
	Mon, 19 Oct 2026 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422196;
	bh=4I3Pxc/iTGzWoeyx6YQ4e7tLw46TYqzKa0lkzB2yq7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=nF5bVqZibnjfsH5YQ9qXviPtbyL7ynxUf+d820xfm4ZsK3DOb5XjigZK1HEr3WW6A
	 47Uenh40P5vzKmq6ViZ9KauByMBdEKlbm793JuaINZRZuP8TVbTUrNfuDG4CJUA7J+
	 MnMXkfuASAiIhGWWZ26safpzdRwcS4a3TElE/YOpNnkjlLWBW/EDCLJDxF1O3vEjEu
	 6RrHo2aRimRHCGQodyV7ut8Wkd2ZiIgT2pCVUKSRpzFTBqiYjJpDo9SUzNqePoYS5T
	 SSFbQT3NoGXvLKLV0N9A2cLQgCaRCCfoBfPdMTV8kgO566Owou/bYMQJGPOJg0Vkek
	 6zDscVONi+zSA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 21/23] tools/power turbostat: Add rugged Panther Lake support
Date: Mon, 19 Oct 2026 10:38:54 -0400
Message-ID: <b52633e96ce7b5cd3dcbedf938b506db750aa5eb.1792420722.git.len.brown@intel.com>
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

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Add CPU model for rugged Panther Lake to the platform and perf model
tables. It uses the same cores as Panther Lake, so use the same settings.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Co-developed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 6ee32fa15c68..c8215c9fadca 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1247,6 +1247,7 @@ static const struct platform_data turbostat_pdata[] = {
 	{ INTEL_ARROWLAKE, &adl_features },
 	{ INTEL_LUNARLAKE_M, &lnl_features },
 	{ INTEL_PANTHERLAKE_L, &lnl_features },
+	{ INTEL_PANTHERLAKE_R, &lnl_features },
 	{ INTEL_NOVALAKE, &lnl_features },
 	{ INTEL_NOVALAKE_L, &lnl_features },
 	{ INTEL_WILDCATLAKE_L, &lnl_features },
@@ -1344,6 +1345,7 @@ static struct perf_model_support turbostat_perf_model_support[] = {
 	{ INTEL_ARROWLAKE, { PCE(0x00, 0xFF), PCE(0x00, 0x5F)}, { PCE(0x00, 0x07), PCE(0x00, 0x02)}, {} },
 
 	{ INTEL_PANTHERLAKE_L, { PCE(0x00, 0xFF), PCE(0x00, 0x5F)}, { PCE(0x01, 0xFF), PCE(0x01, 0xBF)}, {} },
+	{ INTEL_PANTHERLAKE_R, { PCE(0x00, 0xFF), PCE(0x00, 0x5F)}, { PCE(0x01, 0xFF), PCE(0x01, 0xBF)}, {} },
 	{ INTEL_WILDCATLAKE_L, { PCE(0x00, 0xFF), PCE(0x00, 0x5F)}, { PCE(0x01, 0xFF), PCE(0x01, 0xBF)}, {} },
 
 	{ INTEL_NOVALAKE, { PCE(0x00, 0xFF), PCE(0x00, 0x5F)}, { PCE(0x01, 0xFF), PCE(0x01, 0xBF)}, {} },
-- 
2.45.2

