Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428731;
	b=hXKhNhhRHZBljgcPpUEPi5XnO/KGLyAU7Hd0rfCSAdhMqprNnUJKSL9fQoQ8nWT5xtB7
	 dm+tn5QFkXrf6FFRmLTV1rs6Vf+oTp9yDgxt48zQWZjnXUegcHEEjbaw2SjUkoB6t8NUD
	 qOb85tO2+ZjLTxDTEEELFhbtibckIKlgclr2T/JNAyBNSbLVDJLPK/nVoQH6YEWJEwhwO
	 DyksmW/tcEr4B5e8oRO1y8ynVAuyfBL//f79MPmwuYSlmR2OgaUSbs6MOiFUV1X9w5kwK
	 2pSpuX5Wbwzqiq44Bzij2gDX7n/jVrLJnJ3XIIpKY4PbFBVuMjylNmkN4kIWGQwK1jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428731;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=4gG4ATiI8YrUNtm0nBP+QpdZKsCt7rsqM2BUjlPvu9c=;
	b=l0TKLrYWVnCwqCNCaBKGOhqeK+Qnjffdrn853kG49xbKOTqxK+/jmDG72EJHRNzcrwAm
	 EdxMPcxqozNW/tZCuj+rYK0xvGHlD+nuTTyLNh0SJMvrH05aRK/k90axV3elvNT8WHTzK
	 BTZ48GHnsHXKf5fZAK9jXjW6vN/Sik9jYbF+VBJZ+lE8rsFrswFfKkhbr688gJG3Qreea
	 5H2x6E2MufFIXpkg5vn/7l4wm0S303a2paRmO2mcs3xOF3jDuK13/FuAWFuL2Gz0FmF2S
	 wi+Nksi8SRNTlPFIVhL/WReiYWVzN0R2BazLg3swoL6HuJg4/xfpfsyPPAiaWg8G2DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TB3ASeNW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C92606A326
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TB3ASeNW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89D11F000C4;
	Mon, 19 Oct 2026 16:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428730;
	bh=4gG4ATiI8YrUNtm0nBP+QpdZKsCt7rsqM2BUjlPvu9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=TB3ASeNWnfpouX0iQsKg6XAh+bDhSJCROy9KVl9QveB+3tVI3wg9UMMfdLJHGSGtC
	 IktKS3UAeUDpcO6ONfH+75cWQqf3W3Po7HOShaJr8SE66Hvg5QUMcDXhktlRbw4hvQ
	 f+A5fS4hwH2kDWigGEuFrGlU2SbEGlhNvk/1GZuLwxjs9AdpO7EL3HLJTda7hqQckx
	 D8Nk+Xr9diXJ6M55Q53PWrddUqrxOx4ipPz1QXJSLJCYcSSGz+AG7f2Cq5sXcliHRb
	 7H6q8IV/kD5TWkAqALKeZllAmfIxWNEoNTK8YHHy9hJGqEWFL7OgJGKfS3mCjLEqhr
	 QMqxWCasKAsqw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 07/18] x86_energy_perf_policy: Cleanup: Fix potential ratio overflow
Date: Mon, 19 Oct 2026 12:43:28 -0400
Message-ID: <48429f39fed0928a54620f2ae830d6395088f853.1792428130.git.len.brown@intel.com>
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

Prevent integer overflow in ratio_2_msr_perf() by using 64-bit
arithmetic for the intermediate multiplication calculation.

Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 5afff02bf9e7..6b0079a0b36c 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -141,11 +141,13 @@ void usage(void)
 int ratio_2_msr_perf(int ratio)
 {
 	int msr_perf;
+	unsigned long long temp;
 
 	if (!bdx_highest_ratio)
 		return ratio;
 
-	msr_perf = ratio * 255 / bdx_highest_ratio;
+	temp = (unsigned long long)ratio * 255;
+	msr_perf = temp / bdx_highest_ratio;
 
 	if (debug)
 		fprintf(stderr, "%d = ratio_to_msr_perf(%d)\n", msr_perf, ratio);
-- 
2.45.2

