Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428749;
	b=ioGsYJvvd/1SHhNdcNvScUcYDkgEdFFjrxUFknF8xgZUJ2SHSMHIiDA3GjxjwuTXraxZ
	 9y5+T1y0S+43lJVnqyid41qRT2jq+klRrvr/VyeOmXUnghLsT2uAIluvf8jMnxTev/LMg
	 /uevKSlRO3phNuEFcooUZQV+FuBhfswXAGLau1h7T0/DjYPB5yR1jlX+/+dnCPKa6eFU8
	 ErxojnPlsQR1LzN62kZ8SEc62y9/8TXcof5EKFVlRaFYMLxa1nqWfDWH0kcy4lg5sWnqa
	 OEt8emvqYRmdcLkkkshEVxHWUJaglGet4rbjw2fwsqnHtWDK4H3qA3HjSnZ0iWXd7qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428749;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=uIWTnre85yzC0kLWAkHKTiF4N8VoFvaQX904t2Yn0R0=;
	b=O9pidWruepK0PQzib6kZLp3iJ6HcCOzcPfoBAblGRepBMHsjytkEvcaaLP8+AJLTIEYf
	 byekG3tIiWBZgqIl1nkQHKHY51/xdCOIaTEbwos7yzJwMuNDDxFTsqGPRHmTbTjX5/s51
	 g8Rr+DgUDMYgXwQmJrEW1rG5/cbh4Lqldp8MdvK30QH5WmYUqEvNXXUAfwjSCIuvJLga6
	 LP9k7sTIXlURRh6jSPgc2jHckUqitlIzp1QsnHUC85ZT04tMw3wL4F9WfVI0ul8rgIZIn
	 +XreSVL0vJYOeW5Cmga+g8mzLjUgHyaEY/K1MHMx9sBVVaXzzjIbq66bvf3+9G098Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCB3Fr5g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AA1606A32E
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCB3Fr5g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BF11F01808;
	Mon, 19 Oct 2026 16:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428748;
	bh=uIWTnre85yzC0kLWAkHKTiF4N8VoFvaQX904t2Yn0R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=QCB3Fr5gANSTtt1RzbmaJboihAvIzG60XgXXCKkaBz/Czp3XwtSBinxnpHKSNs2ky
	 V+y6i1YMm6WJAFBw3ZGknA6jfNwZTTAelZlxtjKehjLdtM1xb3NMb40unNsjDJ7/Yw
	 m9NExXe9bQBM4Yp1WP7EZEUqV9pqvMpK5JhRFh3I546jaz9TAQyKMKGYe5Fzrrsn2g
	 nkDNtVTakcC7sT81trWmTkxohRDkP5lYdsYNhbti+Hdd9pVl5N52LhIMi8PJY7VAnK
	 yfeaSkJzslbPP0B0iPZjNVem/5ZPuW1c0ShN+ib0Pwo8Q4YxeykDTuos6+cfKAiJoC
	 4zNkifaqW/nzQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 18/18] MAINTAINERS: Add x86_energy_perf_policy
Date: Mon, 19 Oct 2026 12:43:39 -0400
Message-ID: <4ff2e5ee8ac95cef4ba20e0971bd87bf9f8b25f6.1792428130.git.len.brown@intel.com>
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

This entry should help direct patches to linux-pm.
(rather than to lkml)

Signed-off-by: Len Brown <len.brown@intel.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 782389bd5cd3..3958e66188ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29577,6 +29577,15 @@ W:	https://x86-cpuid.org
 F:	arch/x86/include/asm/cpuid/leaf_types.h
 F:	tools/arch/x86/kcpuid/
 
+X86 ENERGY PERF POLICY UTILITY
+M:	Len Brown <lenb@kernel.org>
+L:	linux-pm@vger.kernel.org
+S:	Supported
+Q:	https://patchwork.kernel.org/project/linux-pm/list/
+B:	https://bugzilla.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git x86_energy_perf_policy
+F:	tools/power/x86/x86_energy_perf_policy/
+
 X86 ENTRY CODE
 M:	Andy Lutomirski <luto@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.45.2

