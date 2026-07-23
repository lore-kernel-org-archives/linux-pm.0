Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A548EBD2
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 18:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832455; cv=none; b=MaqkPrQnwwlkcjpG7iwN496uzmK/AVrraJWDpRrc4dpC5DraRhv5H/hQ98RXEywss0FgHBBD9+LDmwUW3tXBLzcWRZG/LSUvxaXZgmEqT/2IbwVwiXm1HujjvMPqry0Mw8T2kRn2xDOq6j1kTitnJB3xf77K0nRtov+vFidVwLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832455; c=relaxed/simple;
	bh=8A2S62PZzrC8JPpHbdE/IFoS+mlqyAjg7X22tpKj+Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7JNSuLKqI7C/O1qHzkgmvjSP3qb0XjEyrB8/A1OPMuiVWBKu0LSgBNs1HAjv91lFAbGsl7r3aW9+foqFTdSWsxij/oA6X9ieb04+P9JSkFlUVcxaCXqAF38Hf3ekQ6TGPPYlbep68/SXvriTlZGZwPvB9GCjLwLkczZFJbAkRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLv7KMdK; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLv7KMdK"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e08baf860so1122527a91.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 11:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832443; x=1785437243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y+eSaDxt3Oy3svRwCwnnMubzPU6lsf5Q8Wmnj1h35P0=;
        b=ZLv7KMdKbwdFR79zu/nnXxy3rl4fzgknndDl24jFVOROdLtJnGHusGmd0mbUGV14Vi
         X2hY8EoYIRI1RUVVima9X0/V/lzNEC0E6NfVTjcFt9wfN9j5A6cC56Hfnd3STA2XvTFl
         NS8h8Emkbj++rYbSu3CuhjymZQ1t50zCi3bJdyaqcgmTVvNMLhLQX4sxAnwAQXMobU6A
         ET4sDccUJ32njKrzcgEtIvKOjwDhd1xzwTDe0HBVJiI3yc0CJGrkvdJFYTQ8Mtikofc0
         W/UXneWCd0oNpmlUALy8TLacJohYWozfpTHD+CaQIEgf0xjLDLvns69PqFFW+Pf+hi70
         bdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832443; x=1785437243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y+eSaDxt3Oy3svRwCwnnMubzPU6lsf5Q8Wmnj1h35P0=;
        b=FG7C2x+mkKuX42hItSXQzWpsBejSM4TIbtiFxYzR/8bMZCZAkUk4xN45MCcvD6DQDv
         VFNtSL6lt94F0d0lmCobjGJyG66FL+DibK0XbFS8EDmZ2fZfzsG02qgtbwIrQ5npH5sA
         OF9r/ewH5/kGhQTEp8ySEjlZzFQzPYR/gjQ/kev5TKlDYPkEm5gXWCFwfEx0d89g1FCa
         AW7JSlnW4duvN/G1/g4JfPdGI5WUWKnZSKmp3oGuH3eV93YUaAzLl/xvEelQrw8MAfp6
         yKK6hgDEXdIHan13/P2wa695iHit3ba3AAIk/cwOzgTlx00mHSdS7g12/50uN3y3tIjq
         vh6Q==
X-Forwarded-Encrypted: i=1; AHgh+RqNQfvs4hwweD2uF+rHlS1qCUG8ISfqLyaYCs/xOivA+spPpZ9x/qGd8xgckTeyHaTLdoNx6mn1mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxE75+nMW6Z/uvl22UMT24bgBcuCzj6E4d/vF1CvEuJnwpnJFmY
	vxjqEZ2F0POTS78e8iz97oAB7+VK/YsGgWgYSVhmuZywvnSgCSb5Rh1P
X-Gm-Gg: AR+sD12qhDEkEe/9XWH7wKTLeMPI4FvvocnfXIHCjhx8qiBuCUqVO5/BLljsGgbs2ll
	R/gvjm8Ek5bdmGG6CVyTHYq8PuVtcXKREbrnznEsOqpAU4c1VZCfxSjoy64QIjFZGD6KwX7Ro5z
	DF1VEi/iWiHK0HZA6jPGhE2PVLnWx/R1vKYf7o3QRfRslLiKJYLK0GERob8SjNXOBEOFm73A9nB
	5YkLk8+Ij2URWD3oMozWYlCQk+slTTxxpjI/JcbyGVVRuUXeznqzE3YPr7snXRI2hsWzoPbFyA5
	7LIiX2Q1Df+gwFPE16M2TFjGtZ7T4yJqNxafpYpWnHQ3DtAty+2Df59rTjnsuVyNPBZIqnPeF56
	6+pF6c9XFnII3mtY+NejTnjireiEaNLzVJKBYBxfswiTIpGMoPbopALHeZkecjwsby7CiDJau
X-Received: by 2002:a17:90b:3d43:b0:38d:dc13:6f94 with SMTP id 98e67ed59e1d1-38ec6649d4fmr4940781a91.37.1784832443347;
        Thu, 23 Jul 2026 11:47:23 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:47:22 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 35/36] cpupower: remove conditional return with no effect
Date: Fri, 24 Jul 2026 03:45:37 +0900
Message-ID: <20260723184538.3888637-36-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 tools/power/cpupower/utils/powercap-info.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/power/cpupower/utils/powercap-info.c b/tools/power/cpupower/utils/powercap-info.c
index e53033488218..88a5edb76315 100644
--- a/tools/power/cpupower/utils/powercap-info.c
+++ b/tools/power/cpupower/utils/powercap-info.c
@@ -47,8 +47,6 @@ static int powercap_print_one_zone(struct powercap_zone *zone)
 
 	printf("\n");
 
-	if (ret != 0)
-		return ret;
 	return ret;
 }
 
-- 
2.43.0

