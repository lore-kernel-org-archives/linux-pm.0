Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B1F3BB9E0
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784622764; cv=none; b=C5GaInF2IUPk2U024LDd2uphDdTeNeRzCjGt3jyL0X7DVVr4TZYW0zvufJLuYZ5Rsip2Hl8Kv+jwcFmGRe3pt0vmLSfm8gTI/Po3LO5hu2ie8o1cxiOPqBJznvpin+u5iGFMuUP09+yf3U1KDVnU5K/tFo53hkABsefqRPFEL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784622764; c=relaxed/simple;
	bh=jKbnK5jQJRNRxwNvjRw0RLSi9BVxk18FKKDZGSgAhpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=APF0jAUX6m36+Z83SEl6KhARHymuj1xbWn3ZftSZxF6HvxT8iD8Do6GJK/YOkBkmrAWqsEuz5uNWS8nuUAMaB9C7U2bDXZDZZlMP8sXm3CbHI8gCVEDQjw1AGD2krRQcwTdQtIgxXyJL2KugOCdhifpobM0uBNAEeVxGjptuOpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=haufler.info; spf=pass smtp.mailfrom=h2-ventures.de; dkim=pass (2048-bit key) header.d=haufler.info header.i=@haufler.info header.b=B1BYC5YS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=haufler.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h2-ventures.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haufler.info header.i=@haufler.info header.b="B1BYC5YS"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-495522bc0e2so1724335e9.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 01:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haufler.info; s=google; t=1784622758; x=1785227558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mP8ESsGp3PDnVGRH0j1wFoDB1NTpcMuyoXK5rjNdngQ=;
        b=B1BYC5YSCXxhIi2x5Y1xE/DzshM3owS8E4TnDBEFtTY/DrtI1qDClHPNJtj/ruVpun
         jkF7Jhug7QBoS0begD7k71aNMgecpPgZYnhMUH67yBMQPANcrwjNWX+OmwwMRxtjoA6V
         cVvZx9XCEnwNRfiDTddTgcEjAE0hxQSmlH985dJa8czWtpp1OdY5k/r8UiuUZki/RuWs
         apC3i51mJDfYKw847WS8dwsH+UiqH+OFzEqHGpejJfJ38BxZJqg3GowSBVbc5cINIQBI
         AmlqMICLm01H9y2c9LOcgOZuxMZPyb0MMYZAlegOxj1/OuiGnFCoQ47qSsQ8LJqaCJSw
         k85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784622758; x=1785227558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mP8ESsGp3PDnVGRH0j1wFoDB1NTpcMuyoXK5rjNdngQ=;
        b=U3JqufbtrSqPfcpaz99sAzce5BseCOVogfzhNzgOHbaaTvMVOHTqYWL9yW4NKBmOdr
         UoOG6UAQF6aw7KQha0iC84AtBY4U03sPC/rRrnaQHE6UTX3F9I2fCy339IHdZ0HwDIl1
         JfFbqZ7Ii7JGj7l6OTT/dKbdsJythZ7i8ZETTaRK+coi11F/OrUlK17uTqwuRreJnNXi
         EuOBhopSJ1YY3gXonrmK/ZNFsijpmITudXKv+rDi5FPgXVlBvL/2ELxUbQLSWnjPoIZw
         VK5cPshHmg1S1H1UbPavFThNQ/kOHEX6WdV0EVHm/vVdUYdOUBhtla8sWDd8HWf9J3Iz
         TvLw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4uEmPElHI50RE0VzqusdSfemBPtiBY+xjj5GH9hZKHUBzDnwiwVEaDb/u7IcclRrUJcdB2UQ0Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv4d+3UWqNmMJbkc68Iie+zh74Me/9n6xBlTTulC6nio5OVzBo
	cXkGn0v4j7ZjG7/A2TxUyrXXt3EhLPnq5ARRF/ZZrJGz/BpGXZ06NEBl5FwJUEbfNSg=
X-Gm-Gg: AfdE7ckNeJD+ohIMXkfkvTFgp9nTSf2O2wo+RRVU552UDfCTV4bBOnxUFg6byoaCk7k
	fLK/dAWtE4oOVUvmAgWLFW+phXAdzJU/UiOFXhTgcCsTjXDdJaCLrrqqIfoFjG8UdnqeexukVE8
	+IYBGXfiZ3HJe7G1y6yOhdTTW+lKCLAM+XsPdy9GC2AQEk7Pw8boJYfYQ2R+S8Rkv9youmqnPD5
	pJelBUfl2WiLmzDujMo9VMFAIoU0lxeo1fPBaGvvHfx/ucsnOeP45BFdfyTqX3xo2MT+8bKz/Rp
	BB3AOVoPxpOHMm158a6KLJ5JqXwenYTWBasEICPEcgLp+HRXQaPSqMvqJTnZOgc0OUWT+wlC2RA
	kwuFOO6lievATJ4SJt8Uz88TE1ZUsvJG5zGc5bLsCoup8ml1NNQOaT9jXCkecz2nCUnO5TLtTpQ
	bkcRG4n6RRYf00i8lvuq1E/G7VlKlfe05zlony8qag0c3wZPBd5b6QdDidd/Cd7+H/d+H5Wsz0+
	JtdKg==
X-Received: by 2002:a05:600c:3553:b0:495:4a33:2c34 with SMTP id 5b1f17b1804b1-4954a39955emr114409155e9.0.1784622758339;
        Tue, 21 Jul 2026 01:32:38 -0700 (PDT)
Received: from Mac (p200300c3bf03e04c047ae254e768247a.dip0.t-ipconnect.de. [2003:c3:bf03:e04c:47a:e254:e768:247a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49548e075d4sm250421095e9.1.2026.07.21.01.32.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 01:32:37 -0700 (PDT)
From: Andreas Haufler <andreas@haufler.info>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Haufler <andreas@haufler.info>
Subject: [PATCH] tools/lib/thermal: fix misplaced extern "C" closing brace
Date: Tue, 21 Jul 2026 10:32:13 +0200
Message-ID: <20260721083230.91246-1-andreas@haufler.info>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The public libthermal header opens the C++ 'extern "C" {' block inside
the __LIBTHERMAL_H include guard, but places the closing brace after
the guard has already ended:

	#endif /* __LIBTHERMAL_H */

	#ifdef __cplusplus
	}
	#endif

On a single inclusion the braces still balance, so the problem is
invisible. On the second inclusion of the header in the same C++
translation unit the include guard skips the opening 'extern "C" {',
while the closing '}' lives outside the guard and is emitted anyway.
This leaves a stray '}' and breaks compilation for any C++ consumer
that includes the header more than once.

Move the closing block inside the include guard so both halves of the
'extern "C"' declaration are guarded consistently.

Signed-off-by: Andreas Haufler <andreas@haufler.info>
---
 tools/lib/thermal/include/thermal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/thermal/include/thermal.h b/tools/lib/thermal/include/thermal.h
index 818ecdfb4..d9097271d 100644
--- a/tools/lib/thermal/include/thermal.h
+++ b/tools/lib/thermal/include/thermal.h
@@ -175,8 +175,8 @@ LIBTHERMAL_API thermal_error_t thermal_sampling_handle(struct thermal_handler *t
 
 LIBTHERMAL_API int thermal_sampling_fd(struct thermal_handler *th);
 
-#endif /* __LIBTHERMAL_H */
-
 #ifdef __cplusplus
 }
 #endif
+
+#endif /* __LIBTHERMAL_H */
-- 
2.50.1 (Apple Git-155)

