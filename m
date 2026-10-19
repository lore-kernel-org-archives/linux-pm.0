Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428728;
	b=xJC7oqhD+41z4RF5tR7YdokkvxY/V3pHPwUQOT5D1EObHeGTIYo54zxQ/1viz+qJ2jgB
	 lpAhGgdFKf1hPJVs23SQMK+cClxVIoxRPnG5f4UKQmvXnWad2wGienOskuE7NREbPg8e9
	 zWR+t19Go4a76PNxFxWh2hEtLGYPXn4KYo1b4IU+hEBkrchLd4sVWA8g2Kuh+AonGMVyN
	 2gleWsuND0Se2vxng4QXGNhdOcZqlx3lTbCIUqA1LcX4DNFswz0JV4176B0tkUj2+PoxG
	 WTQ4uMO2nFtkQMq6DeBeNTpXX5gs4iu2tydC/JGCRKRXI1KNIxk3sS1piiThAmsfuPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428728;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=9aKvFWDN043hpDCFUJfVvWxki5usemyJe63PuWLhIW0=;
	b=BIdfokLVpcXQnkTMgGOFIJ7zRRkmcEjVoVrtLS9aGvHi79dnnn1mJh2I8sCfMlzpgCFr
	 xweZ296o/vlrDtEs3wNkv18brXB0dSQxSxKsQomYeHYKHIyNWglcCfEOi2NXYKRMmDVJy
	 pZrrDSNnHiF2gl03cHPIRp+WIZb97OeuuvobpHLDnhi7VRlf8FOpjEM8AXAj0jfxHuHz/
	 YY5gSsaVQqhlKztLv9TLJfsLfKRFF2Ogxbhqse7zvNaoHTOx7I7sZbFAfWC2xhwasgQE5
	 DvFBfyH23TCaM7n/7GQlX5BMah7j1dHyQe7qIGQdCEQtwf9sIEWMwttVWp1AlbYNm5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TwExDkU+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62176606A322
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TwExDkU+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB0E1F000D0;
	Mon, 19 Oct 2026 16:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428727;
	bh=9aKvFWDN043hpDCFUJfVvWxki5usemyJe63PuWLhIW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=TwExDkU+GXIWdjVM2KWTVEdcaO+sDE3HFNd2iIolct0uJF+CZ/moFnw9QJa9/ZN+d
	 Mg9o1w0IiFXsaEqiZAxjQR41M2VBCpFSF/nOrHXVfWWoUl+SzovaBwC25YsWktSciq
	 CG+pu7w3UcAjU+Qa6bpF8qGnMo7huB+8EKDsrpSF3QZ4/tOQ7axw+em859EFTYvgLC
	 8GtiB6rUnBd+sGOfP7TamCfStrifv6RCIM63XryV03MqyKLsVi1ynbx4hx0fL/Ftzw
	 59zy8Ob2eXDjZtQg3lhWDqLHFdXlXfGwyL61CEzvvPX+FRduq2AsyHAwhdlhHA6MBM
	 T5ZgmJR/+9Iyw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 05/18] x86_energy_perf_policy: Cleanup: Use snprintf() for platform-profile
Date: Mon, 19 Oct 2026 12:43:26 -0400
Message-ID: <8879d2b05a53d7e5b892639bec502b875c690fc2.1792428130.git.len.brown@intel.com>
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

Better hygiene to use snprintf() instead of strcpy().

Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 98e5aa9aec51..8ce47d46eedf 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -675,7 +675,7 @@ void cmdline(int argc, char **argv)
 				errx(1, "--platform-profile: value too long");
 			if (!platform_profile_access(W_OK))
 				errx(1, "Can not update platform-profile in '%s'", PATH_PLATFORM_PROFILE);
-			strcpy(platform_profile, optarg);
+			snprintf(platform_profile, sizeof(platform_profile), "%s", optarg);
 			update_platform_profile = 1;
 			break;
 		case 'm':
-- 
2.45.2

