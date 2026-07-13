Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333C348C5C
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957198; cv=none; b=Wik+bMPiPqnVsAYurs/LLWKJt52tAu8PlPWbqhENCv52DWueOW3ZBR/XtkN/77RkObMOcSpjt3x96HCItFIxso3ASSSckF23nhxk2dwxG+mEOW0zUI+FAgr4+da/hAoxgVGhxFObcYlps0tavMNaJ2KjwDniyAr/kDM5Dl/nzmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957198; c=relaxed/simple;
	bh=yTdMyO+i2E2fqL0HAbZQyuFHUHHTDwBD3/WMsL7u6eI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qB3EYrtsJNfjcRFdA0szn/8swQXOiQDf6StIKZyk3n4/JUjD+y+klAyqrDLsZDqVqsbToiP0bcMw8C28mQ37tp66T5ZU2y5PsGc6ItxGwcAHlMS/8OJUh0zgnfslQVRHYKKBDawNFHhzyGdPuBC+WINEYtvGWuBtmWV77ZqvM+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=O4as8Kr9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="O4as8Kr9"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso29739375e9.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 08:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1783957193; x=1784561993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WeDwmwYsyldgwys09XPYSkZKv49CSC/GW7zpDU3Wo8g=;
        b=O4as8Kr95k/89bNhHOHBLNHAaKPevkhVkDHZQl/2kQAanzX4LlSJeXiL4VTTcUH4Z2
         XB4l41yjLrsoyFVaDwC4rdGY7PA3eRmxwprF+P4jPELdgDPocJvfLl4oYfRAafC0EXQq
         6vjsBXhEW2oEiv7FMXD6u0wjj8C+TULFGrkEAyjR6a4Aq49952KGV/8pPf1kaX2jBkp1
         tZ8aRBM3obEz+92QkoGH3Jt2Hn83lw/dws//0tY5NEJ+ccSBkUv6zkhuOq+y7e6/2Hyw
         uwvNuIlHdkzA0PACT7tdNxovcTy+b8Cc11fqOAXENEvfHpl00KIfQQMxyLMi1FrDzuYJ
         jWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957193; x=1784561993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WeDwmwYsyldgwys09XPYSkZKv49CSC/GW7zpDU3Wo8g=;
        b=JOPaZzmVpEjoMT0zeMiOUEk4k82RqUl/vbYgRIDBe86YToZRCsRyFQk+uWBn3C/Dj5
         rjMbxGiBOkPhSbnMg771Dj32/Dv8IR51kigJGmFrbXbnS+HGz9ESfQOUmMyWC3kMZikH
         S5AAHDCXpdsrbR+ucrY5eftlYPNsoq6tqaFwUoYD3A7liOMfUEtlBj22t+J74Ztvty2v
         mE4hbKtmwHwA7yq9p7F2m6UZV9+RQ50WJmHBdaa15adI9M2lL5/8QGyiXTnH5okXCzxN
         XQIYClUI6YDESLhg+Og77EhTt+EL+546ZMzFYJ+8vYxdVlaQkeHcwE+b0Q+CD6Po3Boe
         Mmfw==
X-Forwarded-Encrypted: i=1; AHgh+RqSB8q/eruZHtRmAhpqA4XfB8FYc8gwWP4p+HZAsyIbwSAna5EQgILtT5bI475TPq6QXlCVTgPBTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCNxhwi16PfRdKLvteczn5Qavvzc5xd6u1XjOkvGKDF4qCbVRP
	oHoqONTHqAMQ+c+B5zsVFPfaj1K4ttLJXrQvFeNwm/MCSeVQ+k+3FcbCva8XS7MFsA==
X-Gm-Gg: AfdE7clwFD7Ez7idw7KbHOv+V1amOGIxNqdIcSDbHH9kX8rN7CBaTcED/hQN1kN265m
	1UU19B6+FzNXAB9zHTjDOvETW4rKNNx+HU+U6TwZ9lkOXVHkbtqeoYMjK26qSQXgs7ozXhbp0GQ
	1siHNsvEVaAfe8DtB1zGWS8nrnBM1d72g+bq4oUObl09B+kdu0GSISj/ic5DbkXBBZ5dGb6PWxP
	tj2jM6MRmOERNKxjzO3zNYZk5RbLXwj6bpL4Y+zt0dIbA3aHfxKKoF6XytXN+mCB2IJZwTPaGcV
	i3YpqTOnRK8RevP2EPtXx3ZPDKsTzyB8njNfqnV0YCeE+w4rAvXm1i9TWmvFGYssv8pLc4Dl/JC
	38F3ckm6PQcbWE+B9eBD8g75F+PmGi8f/otMWHOCEuk8aWkNB4ECMh5F0HP8tSOVhd9mDY+WoIH
	aJ/e9GjBTZFg7dD6qvMRftxDh7sU4mo0JRJEKk0udPSrXK0dBBD+4xF2rY4ynDUG1eCVE=
X-Received: by 2002:a05:600c:b99:b0:493:aaa2:f034 with SMTP id 5b1f17b1804b1-493f882ae23mr102205915e9.26.1783957192599;
        Mon, 13 Jul 2026 08:39:52 -0700 (PDT)
Received: from horizon.localdomain ([150.228.38.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32c65asm3135735e9.14.2026.07.13.08.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:52 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Evan Green <evgreen@chromium.org>,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [RFC PATCH 0/3] PM: hibernate: encrypted snapshots under lockdown
Date: Mon, 13 Jul 2026 16:39:47 +0100
Message-ID: <cover.1783956835.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an RFC for allowing hibernate with lockdown enabled.

The kernel still refuses plain hibernate images under lockdown. This adds an
encrypted snapshot path instead. Early userspace gives the kernel a seed, the
kernel locks it, and /dev/snapshot can then create/load encrypted images. If
that seed is not present and locked, lockdown keeps blocking hibernate as it
does today.

This is based on the older encrypted hibernate work, but with the TPM policy
pushed out of the kernel. The kernel side just handles the snapshot encryption
and the seed ABI.

Testing on Star Labs StarFighter: dmesg shows the seed was locked, S4
entry/exit, and no errors.

Sending as RFC because the ABI and early-userspace split need review before
this should be a proper v1.

Evan Green (1):
  PM: hibernate: add seed-wrapped encrypted snapshots

Sean Rhodes (2):
  PM: hibernate: permit encrypted snapshot device under lockdown
  PM: hibernate: document encrypted snapshot seed ABI

 Documentation/ABI/testing/sysfs-power   |  14 +
 Documentation/power/userland-swsusp.rst |  19 +
 include/uapi/linux/suspend_ioctls.h     |  31 +-
 kernel/power/Kconfig                    |  15 +
 kernel/power/Makefile                   |   1 +
 kernel/power/hibernate.c                |  32 +
 kernel/power/power.h                    |   2 +
 kernel/power/snapenc.c                  | 878 ++++++++++++++++++++++++
 kernel/power/snapshot.c                 |   5 +
 kernel/power/user.c                     |  94 ++-
 kernel/power/user.h                     | 133 ++++
 11 files changed, 1204 insertions(+), 20 deletions(-)
 create mode 100644 kernel/power/snapenc.c
 create mode 100644 kernel/power/user.h


base-commit: dd3210c47e8d3ac6b4e9141fc68acc03b38c0ba3
-- 
2.53.0
