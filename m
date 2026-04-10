Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD1F3BED43
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775827723; cv=none; b=OElnI1rru2dJCZEGcTdHDmrbqioFgv++QF3N82/sSnUyuOooSPUgPqeCnBQspUtLEKpNqu2uftt2t7uSHcKLGyRVkg4YsRU9HOR0H3seScr3r6IIDbUXsjnGKOpfpDMg6uNF4H0V5UOzfLo6p5+hmzR6SX/wEQe6hpq55xCGR9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775827723; c=relaxed/simple;
	bh=nbxMIYyVXCC+AfdfH8dvDkuNunmF4yvD6AwHX0TtdAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apV1NX+zy+legYf7JK0kWldlMuUMvZ+FLDHlS2l/DLgU11hGxE0YMVZB/nYLGTb8G4uH9+ep8SVkcHuQQAiqZQiAB9wIbAX8zEc9y7us7msfwoPTLZcMof9OIfj7ysrYBYcs/ZhH5oaHfk/I3qKmOBD4oFwofY3BSPiXQRfvL3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3LbYJ8X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3LbYJ8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CFEC2BC87;
	Fri, 10 Apr 2026 13:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775827722;
	bh=nbxMIYyVXCC+AfdfH8dvDkuNunmF4yvD6AwHX0TtdAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=r3LbYJ8Xu1wlnOfgybhN/oZk5tmL+sx12UoZZO2sBRgwt/YX/Q4muNL4RfXfirS7/
	 G1MKxGHItlMFJ3oUA2EM/K4P0qVXWSBiYUGRwX46JkG0AKqkNm1N/tMlpDpWLQVka2
	 YXRy0Aqxqg2jpQWGlGmIIkGdUQc1ne5f4F4F8G+O5lxtofwuwoILi041JiI33orzp+
	 gB95IxY/t80x0aQuU4MB2aBLI7oc16AuxWQ0i0Qw3T2sdjpbMq4VReV6LPi7/4ER+u
	 BNFe+tU2v8q9mlvwYlM5egXfXpK1FRgEwPNMELqEgdNEWq8d0e35GdndO1tuN54hd0
	 tbtQn6ZeGZGFg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 5/9] tools/power turbostat: Consistently use print_float_value()
Date: Fri, 10 Apr 2026 09:25:10 -0400
Message-ID: <ed532d738a82269dfe490436b9b8def2274cfb6e.1775827309.git.len.brown@intel.com>
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

Fix the PMT thread code to use print_float_value(),
to be consistent with the PMT core and package code.

[lenb: commit message]
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index b985bce69142..9744f9caac9a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3489,12 +3489,12 @@ int format_counters(PER_THREAD_PARAMS)
 
 		case PMT_TYPE_XTAL_TIME:
 			value_converted = pct(value_raw / crystal_hz, interval_float);
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
+			outp += print_float_value(&printed, delim, value_converted);
 			break;
 
 		case PMT_TYPE_TCORE_CLOCK:
 			value_converted = pct(value_raw / tcore_clock_freq_hz, interval_float);
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
+			outp += print_float_value(&printed, delim, value_converted);
 		}
 	}
 
-- 
2.45.2

