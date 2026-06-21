Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854B01B4223
	for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 02:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782008727; cv=none; b=j6mwav/eBljlIdvcUvR8ToXpnBINWG41ly2m4r7r7YeY26fdgbwukPnNgVFwqicrQDoiiZOXjMUd/IO80ZoQRRSeCOVUtmgP7IZ9zJMJHkKvf30g76Mh9trD0BudnNWEHmQy0zIPuxiZJLcMf+d3RZdQm7MdzQfAPKngEbpMH5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782008727; c=relaxed/simple;
	bh=qiDmpwHvSf0ESSsN4jjuEyK0qPyNBrD4EVAWjiINbno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XjA24XmCnd/bu6W8vgzI+cUUeUZySt0ysfPQo9rnX9OYgB1wh+24tU0GisUCNUyx4sOGKK8QqoK4EzZVbJuvRUQxconwpoNmDNEwqPIqCVeIl2f1nuzGbKFs0w0/EwgTfQNTKK/OoyMNxjkIZ0h3j5N4mlUecwh/7jxs9TViOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAcREkJ8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAcREkJ8"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8424b00710aso2249523b3a.0
        for <linux-pm@vger.kernel.org>; Sat, 20 Jun 2026 19:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782008726; x=1782613526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FdaA/SM11os14S0jUA16RVB04AGKXRXcDaaAOIoqvxs=;
        b=TAcREkJ8ZgvuVMICHbkhJTv59R3Jvu42JPxI9BBL2FMtR9TUJ5pmsY0YwkERi/cMlH
         Q1wLiQb4dMDszOxUj/PIvtsyV1z8F5tpdAJdBB5gJjg0ONYNtyhJB+GKw4Ji/AM65yUD
         JCOLGA4jiANQmyW9vtH6WhJVHysYpuPd8p+uHuDHg3GWKAvATzGZLbrcsYSijZhmK+15
         Ies1uzmyk/EXm5XYeABSx1hXpDmk/C5NrSmPic1j1jZbGxqxPgAPASNPbfE+RK8brVJf
         90dJz1uU4jQZkr4o7AbjFE8YA+wJIDCzhvvog8OyDW0S0XaoBCQX0MYhq+4kYIRCtRoX
         cvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782008726; x=1782613526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdaA/SM11os14S0jUA16RVB04AGKXRXcDaaAOIoqvxs=;
        b=f4nE+RMlLFW2HqtLWFO9hckyQMACS12A5Jth5/mg1odNWoad59NkKup8CgsN+vdrOc
         TjF5c4iSvoEYTGKOplK+del4YJUGy3pbffiTbSqb/jzM52h3zCrXayrCJrUjjIIiLgm7
         NuGF2taVe8OX+etR5DWEq4iS69oqrgV/XNG9MXfIlHX3Qpc9Yj5XTZ9WSrfLUlApHSSw
         1+SIxoc16khvP905lniibxg8qTISgmHayGgRHF3Hi3kpjFxuhknW7Bp5R20z2z/hMSyf
         y5Mv0tWIaxjkDgQ8gIHitg6iBopC63VieEDQjrHrrd0F1ZkeuzBVG7+jID0FyD6xgUQZ
         ajkw==
X-Forwarded-Encrypted: i=1; AFNElJ8DFZGYgk/BP27KWnEQzu28HmuK2RIE89+fkeUy203Unsh10Bg4q36rtrJ8bi+jQFwQddnz6mQK9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyHjNTjYQ+/QPVyM+DLTsVqp7suzT5CMet66QUjjtzNOd6ksO0
	DOO4DmmEYAK9t7ehzgVDgiqyAcq4YqUx1qaJeNpz4D2P4bKqHhYDcYT+ckhqsZ1l1uw=
X-Gm-Gg: AfdE7ckXs5GSOiPApIquWRaqHSrwRMAn1pMshRKJMVh5PBFmj3Hi8rccYwVn5h/USiV
	Po/VKuV2fcU51XsNTi7L/oPLaSJfPoqQibKdxy5y0EVwne2yfX5u8V7SJooEM4D144e6RjaTEA3
	I+y2D+X62HJcaS1qb4jIPCfhTb5hhdcn5MQjXevuHVZZi0RRsPAVsBps3Xc1+U6+OE7vmol/F9p
	dRjcblxZlbtDzlEcV7vEROHtYzVbnlv+EQTDzYmoyvtQskO9IrzrKdfh5czJUGjFXINe8fie/3n
	WGwCSPv+TbLSJ2U5Me00L+smNAQ0UG5iepSM1GNLE5+TJoJY8g24DQ2kcGG9TF9pr5FXlwYsyno
	ST9EK7JWKh8NszmrG3hACGylFuEPJ/bb1sQ/yDfihZgllPPhG30iWrjDbovBUdZva1uUZO0YUhw
	kKEznRDtGT+8HatvkBdpDL2vUAkVsVFu09yOy1UUhtSnE=
X-Received: by 2002:a05:6a00:2d06:b0:83e:f75d:828d with SMTP id d2e1a72fcca58-845507c22camr9640905b3a.16.1782008725714;
        Sat, 20 Jun 2026 19:25:25 -0700 (PDT)
Received: from xiaodong.localdomain ([2409:8a1e:9342:7650:8919:8769:2de0:afea])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ed3bd8sm3262233b3a.56.2026.06.20.19.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 19:25:25 -0700 (PDT)
From: wangxiaodong <wangxiaodong827546786@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangxiaodong <wangxiaodong827546786@gmail.com>
Subject: [PATCH] Documentation: admin-guide: pm: cpufreq: fix sampling_rate example command
Date: Sun, 21 Jun 2026 10:25:03 +0800
Message-ID: <20260621022515.10137-1-wangxiaodong827546786@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The example shell command for setting ondemand's sampling_rate wraps an
arithmetic expansion $((...)) in command-substitution backticks. The
arithmetic result is then executed as a command, which fails and writes
an empty value. Drop the surrounding backticks so the computed value is
passed to echo as intended.

Signed-off-by: wangxiaodong <wangxiaodong827546786@gmail.com>
---
 Documentation/admin-guide/pm/cpufreq.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
index 8831cface585..34baf20cc202 100644
--- a/Documentation/admin-guide/pm/cpufreq.rst
+++ b/Documentation/admin-guide/pm/cpufreq.rst
@@ -497,7 +497,7 @@ This governor exposes the following tunables:
 	represented by it to be 1.5 times as high as the transition latency
 	(the default)::
 
-	# echo `$(($(cat cpuinfo_transition_latency) * 3 / 2))` > ondemand/sampling_rate
+	# echo $(($(cat cpuinfo_transition_latency) * 3 / 2)) > ondemand/sampling_rate
 
 ``up_threshold``
 	If the estimated CPU load is above this value (in percent), the governor
-- 
2.43.0

