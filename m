Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE5C370AF3;
	Tue,  8 Sep 2026 04:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841185; cv=none; b=MkH6a421pktS/ilM7csOZnfMcPuXLEbdyWyfhr6IWzGPBVasbIF9MmhXHmZSwUCVaGjIhMn/l8r9XbwYMoGwkvF51LYyO1G5gulICnuNDTjFds5k1Og8v8L+c26WhKznCzn4dN7StuedlmrX3tEDmKFV1Dqp0SAefJLkUni8NkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841185; c=relaxed/simple;
	bh=lpZzYy/VdGBhiRlw842ZMFFoGDx1XZvt95G9BzAIUK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7ojI41JhsEvygZ5FaU9C702pU8MbGk6prWTKripaM8jEvglBNxirlbp+DYAkb5hnsgmsRf8TEhZEUqyIBx+p4Zc2359ap6T9N3hph2bNCggJSE+DHHrUgGtn4FrZb4lWEnrzwoyGBrJgeZYoftzUW00O93N5rl9RlPOs/ML3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDFzNtNm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDFzNtNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44731F00A3F;
	Tue,  8 Sep 2026 04:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788841183;
	bh=ltwDh5bKYcNkq1n5dZV/QwH3SJk32AnsNrJAoqNE1us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PDFzNtNmgPDRoa6yUo71gDD5jScfx7bF3JOKXf/irSVlcEq3BZHHeI0WPifA9Dg2k
	 HG5qOo+UVTysLX/w1LrGny4UjvP0OOFDYgNTxB2+DHDl2q9eyc/YbLS3djsMl8LL3M
	 4KW/38AP7KMn+IKmHGTzwd+l8tlKjDYXl4SzKEmP320M0+qLF/3BZANC+2+oirKGLY
	 +8o8p94vg/Ywz3i5GHFCOCoTrMD1BE+EX6d9O7iaOj9w2YF3Pguc0ytyIu5RfUx/FR
	 13unPSPoUGXbPE0VeTxFrani3khW0Qd9EI48v1X5j8NLeNYLu/9hvdUlQBx88w6bPh
	 Mlm1UE5f9EBOA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Vishal Badole <Vishal.Badole@amd.com>,
	Richard Gong <Richard.Gong@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Christian Ludloff <ludloff@gmail.com>
Subject: [PATCH v2 3/3] cpufreq/amd-pstate: Show a warning if missing EPP tunings
Date: Mon,  7 Sep 2026 23:19:35 -0500
Message-ID: <20260908041935.402116-4-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908041935.402116-1-superm1@kernel.org>
References: <20260908041935.402116-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EPP tunings are going to be more important going forward.  Show a warning
if on a heterogenous platform without them.

Suggested-by: Christian Ludloff <ludloff@gmail.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 543ec143efc94..7c1f8ca7b7f72 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -2390,8 +2390,12 @@ static void __init amd_pstate_init_epp_values(void)
 	const struct x86_cpu_id *id = x86_match_cpu(amd_pstate_epp_soc_ids);
 	const struct amd_pstate_epp_soc *soc;
 
-	if (!id || !id->driver_data)
+	if (!id || !id->driver_data) {
+		if (cpu_feature_enabled(X86_FEATURE_ZEN6) &&
+		    cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
+			pr_warn_once("No EPP tunings found for platform\n");
 		return;
+	}
 
 	soc = (const struct amd_pstate_epp_soc *)id->driver_data;
 
-- 
2.43.0

