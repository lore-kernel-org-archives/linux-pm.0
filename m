Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422175;
	b=vxPadXC2G6fv/1LoI7m0KryjQJF5KnMUoatBS//x+W8aIw1TFbz5lii/UVAMvJ8PdO3y
	 pjLZ42L1KhwwnJSWSk6xa4T2w4uWU0NJSPmaveO3i2yPItII2Jbp3SO6S8FJs/mPsWAP+
	 IXBWKgX3Uf+zinvscXnG8TznXHZMCOrMwInL+lSUglPinxWg6rIlQpp3y9h7cpwQijEmo
	 WttXm2r4XnqkVbc/Q+pTeww6B+E/r6+ljws7dndI1W6Mzt8Gn8MVBUO/QgX80r8q8qwBb
	 JRED/Q84ag+QnePIpKofze68B5Uzod9KL37ruolmRklX7ZuiHA1CkG5kVTs9TQbZqbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422175;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=2QbeXcHWXxzKNjbp73zvg+UhahsVhqfiRVmJ9BuJbnE=;
	b=vBjsf/ko7++GGs7r17zPhCyDjd21f+xErypo+DlAk06azbaY5UbOffVupiXB9zREa3BO
	 g+dU+m+du74FF1vFQaXkCjJJqAD28Vt0bvhZOMfqk8PSLP7w3MxQz1TzTAd/pOz+8YIZs
	 1DtOtPvmWZ/434cfdTfwtF/lPNek3VTAXuO4j00IU1Q+eHP0ILAMQRaJ4mgPToeokjxtd
	 6UbYhuiC6gNAuzSMm2YpD2KTDTnuQsDnktCGMhG29kSnuyvBzhcGBYtEFLkNEYrmOe7p7
	 qZNZc0eqe9ObP2pCGery6ciL5n3rWf76mM75IXNrU4rUANxWNIe6zyD6szwEnxrdFdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CYAO4wh2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A0E607BF2F
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CYAO4wh2
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6209D6513D0
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422175; cv=none; b=sZQoTVn0ZXjkwVscsdF6GZ9RWElEkZmtz/nJ6Q6ctA5vhgLrD+0E1A5Wbq0YONbS6PKBybyMzEra7z3tjMWxVGt1GBPP6DMX6UAk7tzrehKTE6Oj7k1ng/AvRecnK8xSmE7R/KxZdHHpLv36waCf7p6LHYJ6LRUVLWr0vviIs8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422175; c=relaxed/simple;
	bh=+fSV5pXqcW4OflvFwAKuqR5DUkpCQbm6aHaZn2z0OkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqkRLUdm9k8y+oSXkiATCqSuGVPpCoxOvtKmhcsCXR3LcCAQMFDd6dPxtBf+461Vg8PIin6XWK2AmxpSMR5LNdv0OtKeENRVdr4u/EurXPILtE96h72QpCjfeN5ic7HVrOSANREXXR0QnhEY5YxEMLcBGaV9Q3NtFuWaH2RHojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYAO4wh2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFD51F000C5;
	Mon, 19 Oct 2026 15:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422174;
	bh=2QbeXcHWXxzKNjbp73zvg+UhahsVhqfiRVmJ9BuJbnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=CYAO4wh25uLE35idnvmRkju20fH4UzyWth2JWRPuADzaLsH09JOQA2ClOKal7xw5C
	 0uKclQ/BxmQ90/mt3B+qz2/vRRulbRl7N0NzWxtzxaW4FXgZtuxAYxkWPeEmDxgNEI
	 miHB8HeE2sVvO5MKDNl8zO5wMwpMMZdNgtBVdZ/zQdxy5kzsDO8MFgnfiLsxM3sB7s
	 r0Zgx9yRbQ2ZaYPzA5Yglpu6mcj82tNUcjzu3aJDyET8d+ojt6SJY3hD+7Bn8gXz7p
	 cL4fYsTqvBweUSqYneuJoZcWDL/P8z/7htQ9DutictTNnRJ0m37WdoEKZmLEYQlM7/
	 O0KG666z457Ig==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 05/23] tools/power turbostat: Cleanup: Delete duplicate table entry
Date: Mon, 19 Oct 2026 10:38:38 -0400
Message-ID: <244cc1e3022b8644693caa47d2f5b9b449c3d056.1792420722.git.len.brown@intel.com>
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

No functional change.

Assisted-by: Claude:claude-haiku-4-5
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 70e272447511..03b72616673b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1312,7 +1312,6 @@ static struct perf_model_support turbostat_perf_model_support[] = {
 	{ INTEL_ATOM_CRESTMONT, { PCE(0x00, 0x00), PCE(0x00, 0x02)}, {}, {} },	/* GRR */
 	{ INTEL_ATOM_DARKMONT_X, { PCE(0x01, 0xFF), PCE(0x01, 0xBF)}, {}, {} },	/* CWF */
 
-	{ INTEL_ALDERLAKE, { PCE(0x00, 0xFF), PCE(0x00, 0xDF)}, { PCE(0x00, 0x00), PCE(0x00, 0x02)}, {} },
 	{ INTEL_ALDERLAKE, { PCE(0x00, 0xFF), PCE(0x00, 0xDF)}, { PCE(0x00, 0x00), PCE(0x00, 0x02)}, {} },
 	{ INTEL_ALDERLAKE_L, { PCE(0x00, 0xFF), PCE(0x00, 0xDF)}, { PCE(0x00, 0x00), PCE(0x00, 0x02)}, {} },
 	{ INTEL_RAPTORLAKE, { PCE(0x00, 0xFF), PCE(0x00, 0xDF)}, { PCE(0x00, 0x00), PCE(0x00, 0x02)}, {} },
-- 
2.45.2

