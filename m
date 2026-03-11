Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973943C554F
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219661; cv=none; b=K7Qf3lue3G8C1NREZcrlbvpfo7L7c7t49KUv47s4AhOiEJ4tPo2kuFg4/tNNRtkUwKVqo3tRJGlTHLlq0d3lfTsFY5sag1a9H2Im3BUT0HL8CCFjG0FzfiqxqV5cKNWYqdYNR/njtVtuxBBwCVvwzHZGY/hNFjBAUasPDNvHDnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219661; c=relaxed/simple;
	bh=Hef52VyVOWB8OwEfofXa6pHlKWGCVWJLUcplQt10Ca0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEZD0GhZpfzrTwn+i+PmSGPEAN44Zkgc5RgvbBaVZUErIAh5L1qyyh1wSio0pjv37Hj0im2mFjyhO5O1jl4hqUTrWDcaYxK6PGK3AAkO+coUilkuxKYu0iss4DV/oLGAW/E5985Ryisr5GVELvi6wlgb2vzIASTXzvcmT9uhJ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxbIeUZq; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxbIeUZq"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38a5584e31fso6420341fa.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 02:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773219652; x=1773824452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7L4A07yJMBo6NvjRpQ5LXPeoH2JmgtsPlqYfqx+gyE=;
        b=MxbIeUZq0Y87G1X3UI4VWstbKU3NAZYW4hRH4sfryHWQ82kpWTF4YTNRmYdY9szov6
         o77RcLL3PvvEby7Emkk1Uvbze2Bw21WX95hjmNJQ07IOsy2RyKij7a1ZxX/g1EEBWpDe
         aQRACBfl9dxdrcYLNTFl/G5TXdskQiBmvLxYP0ewOGu443I3LccMSR2a6BGJ9j0xr8N8
         swn1pgCmV3t3olKIMv1lJi2xll02+UZJIgmWHxpn/SxGAmYjPzJLrqb8aP2p7vKVuYfC
         WQiI2L7BXmgfAQKMVjMFxB14x4JAKY6g5ZUpC9+9qmuyKqcMSqRxDjD6RDdei8IIbgvn
         LIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773219652; x=1773824452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D7L4A07yJMBo6NvjRpQ5LXPeoH2JmgtsPlqYfqx+gyE=;
        b=O9jn2m4XH91imZiUflq0y+Vzw0oe5UvQiaqZxwGiqOcmgm1RW5M6bHXIzqjDTP4aUZ
         nr5axFRTEJtJlwUF1rYRHOBwkQcLz8OubYVDHt7xKL+UVFIr9auyAlDNFMrjRznqT9rM
         Vm4cJ3h1M4jWU5HaYipro0yVYLJ4usKOxwUpBeJ9N7CO7JJJZxr1r+3FkYHnyv0AxCe5
         6ir1g74OSaLzDAuQ5TrocAKb2OPj3Vhem2VUsS0fZa5IufGHeZKxrfUeyTSAj8cHzKHl
         f7nj6kto9VWjZK3QATwl7n7nzXu3G5Z2avZnH85l9Mv9X7v6KNVsSU8m2dyhEu3Fhq5Y
         3zJg==
X-Gm-Message-State: AOJu0YyFlGFJVuttifS037JR1HrHvyUejmOwe9dVEPqtMXg29C0FtVSe
	XGPvyldinAM28sM+JUv/hD3aLwRdbbL3tq1SpsmOxYvKkr9c7210dY13
X-Gm-Gg: ATEYQzzGuQGTCRNxnuevU0hxBcB40b6GAurw7Uyj07NxdPRpNpruocPgEr7b1QcwMmg
	fUY+o7PrfKEAPLFpjC3DUxSN8LQ0s3crxr+fmNS6FV5IZeXH1Zs5hA+7XkGHoEJsFAFOMy6mnlx
	Es8IUmOelTee4huzcPN76kaoMcXrfEl0tZxKOrKJ4q4/ZVs4WY/W9qE34tWs+HwiHy2izKhgPXf
	CsEvo9fPa8SgXucSP4p4EvtcmZDwBFCFVuH0Tw2eqe0RRzJfz5CjrpkI78RYW/gLd9Sgdp8aRQb
	TYrru+pkrhA2W6S7GPF2xJ1StlZRohnbOQo5V8HUI6LwcYFeXK2vKM3di+Ax3PgeMMvhP1Z3hwh
	z/QkMLo3NW6OW9yqn+oluwpvVcJNH61FvXFZg2tPC2VkVCxyzVxs96ROSuN8wYgmqTPHz7gIK+K
	pFPfgt2fJjWHeroD7HThoiAKOBH/8ZhEDmtN+BkUeY1QkJSriCtfjMzceZvZ8g
X-Received: by 2002:a2e:a985:0:b0:389:e501:41bd with SMTP id 38308e7fff4ca-38a67f78968mr7218191fa.6.1773219651797;
        Wed, 11 Mar 2026 02:00:51 -0700 (PDT)
Received: from abityuts-desk (176-93-227-108.bb.dnainternet.fi. [176.93.227.108])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e5ed41sm2645041fa.25.2026.03.11.02.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:00:51 -0700 (PDT)
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Len Brown <lenb@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 4/5] tools/power turbostat: fix delimiter bug in print functions
Date: Wed, 11 Mar 2026 11:00:34 +0200
Message-ID: <20260311090035.169539-5-dedekind1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311090035.169539-1-dedekind1@gmail.com>
References: <20260311090035.169539-1-dedekind1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Fix a bug in the following functions:
1. print_name()
2. print_hex_value()
3. print_decimal_value()
4. print_float_value()

The problem is that the 'int *printed' argument, that is intended to be
used as "has any column been printed yet" flag, never changes.

Reason: incorrect assumption about operator precedence in the expression
'(*printed++ ? delim : "")'. This expression increments the pointer,
but not the value it points to.

As a result, a command like 'turbostat --show C1,C1+' produces output
with columns merged together without any delimiter.

Fix this by using (*printed)++ instead.

Fixes: 56dbb878507b ("tools/power turbostat: Refactor added column header printing")
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 3487548841e1d..f5cf12ab84e09 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2837,29 +2837,29 @@ static inline int print_name(int width, int *printed, char *delim, char *name, e
 	UNUSED(type);
 
 	if (format == FORMAT_RAW && width >= 64)
-		return (sprintf(outp, "%s%-8s", (*printed++ ? delim : ""), name));
+		return (sprintf(outp, "%s%-8s", ((*printed)++ ? delim : ""), name));
 	else
-		return (sprintf(outp, "%s%s", (*printed++ ? delim : ""), name));
+		return (sprintf(outp, "%s%s", ((*printed)++ ? delim : ""), name));
 }
 
 static inline int print_hex_value(int width, int *printed, char *delim, unsigned long long value)
 {
 	if (width <= 32)
-		return (sprintf(outp, "%s%08x", (*printed++ ? delim : ""), (unsigned int)value));
+		return (sprintf(outp, "%s%08x", (*(printed)++ ? delim : ""), (unsigned int)value));
 	else
-		return (sprintf(outp, "%s%016llx", (*printed++ ? delim : ""), value));
+		return (sprintf(outp, "%s%016llx", (*(printed)++ ? delim : ""), value));
 }
 
 static inline int print_decimal_value(int width, int *printed, char *delim, unsigned long long value)
 {
 	UNUSED(width);
 
-	return (sprintf(outp, "%s%lld", (*printed++ ? delim : ""), value));
+	return (sprintf(outp, "%s%lld", (*(printed)++ ? delim : ""), value));
 }
 
 static inline int print_float_value(int *printed, char *delim, double value)
 {
-	return (sprintf(outp, "%s%0.2f", (*printed++ ? delim : ""), value));
+	return (sprintf(outp, "%s%0.2f", (*(printed)++ ? delim : ""), value));
 }
 
 void print_header(char *delim)
-- 
2.53.0

