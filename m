Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428742;
	b=U7rwzNPTAJaakI3UUQrXtgI4G2YdzRpElNAMRKGWNXmjgTN8Y9wMAjod+mSJ5YU4+Ugk
	 dH7gmELbM+XNB3PyKKu1Iznm9Yr0FLbiXviu5ux6XhJj83V9aAthK6pEIPZ9LdzFVTrvZ
	 P/T3wyIu1opl+GI3sxAz5htn02UW18J7fpHzHKSIa935kMLwwkoSw2kf4zXnAXAGVF7Us
	 vwV8sufFtsjPZy+AYh3aD6eBEzavZQI2pNPno5ZGe2oMYx9fOm+hBE8l9q7nrrc0SHWHH
	 CHBfChrtcwfAI40d1bkk+SzfiJO+HgoGUYaO0qEJIay/9L3Dh3JMQnqXaiSFHsFrfig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428742;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=faqLpepnX1YZZAxLFDR21q5J1cGOGI8kQxlrLT1/PgE=;
	b=lBxg65vjXjqtT+c2CQfwhhFRUWG7ezNmJLCQNCN2RgCwJAZzN3eOikmUxGP4P39ud5QP
	 UkaPafvYRRt9QIuQlPuCgZXxjXjPEoBqx/6BsMOZzvw2iTKnZbWjxRcswiVYdJ1Vg8GTb
	 QVz/4hcHTLnouQmGnNC6P6UvNsZ9tMb9gIN6QTrP4PniSIhZ4921UruLVm29ivbDevoin
	 cZ5q0LW7ccHMnjX0qVysAe5IiaQeTe5OPmQN/GDI+52EbbM+6MTs3pzBayLUgGqS38xLE
	 BuD0wXl0E3Tpr9Y4V/QlBcNCj3VoyKz1yu3thtjvJaIH5iD2BYsJyHwkoZF01k3bNCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJz9VeCm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E2B606A321
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJz9VeCm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B401F01574;
	Mon, 19 Oct 2026 16:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428741;
	bh=faqLpepnX1YZZAxLFDR21q5J1cGOGI8kQxlrLT1/PgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=cJz9VeCm80T26nvxPjgLQd+UfStmGtkHB644YGbUlinUtSwjfDH+T+KfhVpySjcqW
	 5UEpogg/6jhB/TPMMUd4dr18p+3ppMnY6BNE5J9fIuvR4V80bKyrMv/BCCymnLINQO
	 b5UPwtoRrekBIWQPkV4XgYbOKfqjV2deNf19AUvPLgzSv2aLqTJ0kCjKTIoKzwOJMW
	 8JRqOb9VkClK3VyQ2+uampXJ+MgvsXA2p3cbiT8bd7WmovhJK0ZFORoyqMz33L65jV
	 4Em28tBdZYB2bHps9l+HCRZKEcoBleeVwBxwY0eK7Jk5A32uWqivBSFUjP8Ycfm3tW
	 VRVMytWJ3r2Ww==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 14/18] x86_energy_perf_policy: Cleanup: Constify profile name arg
Date: Mon, 19 Oct 2026 12:43:35 -0400
Message-ID: <58f841cb19504f9d68057897c87cd2a3f4538264.1792428130.git.len.brown@intel.com>
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

Add const qualifier to the name parameter of
platform_profile_name_is() which is read-only.

Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index e26a28fc7edd..ffdc5df27ef1 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -582,7 +582,7 @@ static int platform_profile_access(int mode)
 	return 1;
 }
 
-static int platform_profile_name_is(char *name)
+static int platform_profile_name_is(const char *name)
 {
 	char buf[64];
 
-- 
2.45.2

