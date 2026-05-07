Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899D53793C1
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778148191; cv=none; b=MWGEsK4ZteiJWlnNJItu2Z/jSGTrwTNhE9DsWEaAz+H/IY1S29/WfsJXyae3maiDTedk1tLmfjEuAiyPWhzX+1Mzal2WjDk3POlPwiXsX+euJrxkE3a6hKDwsuD6ptswW+icHvqnupoKeb8zolD7jTRo35Q+17pI5n8+6nzYmik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778148191; c=relaxed/simple;
	bh=qW9egvQsS3QMkv5KcImTDLT4sI8AVlLS9i2+sX8oTC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Heq26HtPvLb7X7SxCl+cEBT0gAnK6kS2DYLrgyfZnar15Ny4C9DHG8+vnRwrj6qVKkrHG5RDGcnCibPgeLGu2fbsfYt2mHDl857MlI6PnW7ZpC69La24t7dHaVznjtEDYLWm4C2V2F1ifs3iUe1nauMXT6dQPK5W5R8E9afcJPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IWIprLyV; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWIprLyV"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38e7d983f91so5667151fa.2
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 03:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778148186; x=1778752986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n/gFcE0bu0rJve9uKyHSH4ubBqFP+IcaKsA+2O0rr/w=;
        b=IWIprLyVXMD/imEP9AsoaJu0BBpzCiAt5haI40sPK0CKzuUjqmXOQU6mR8lVAHSNap
         Z1gcRdiTZE1hBSS+XNfjom4O/JkGt0jkX6vmPFFjXIHj4bid5IXiILlUfEdERXrE5nx/
         1sHzbiYO8Szvvo2TV+Tdt04goAeS9TCfjuMWJLQEAOkSdBBAHJPI6i/ig1ewZm/2zi8c
         y1F9UHQ/I7yyL+nw95ulNqTUNBS1msNBWGO8jF0Cxmos0dIA2g1kQEVNGw3XQJwwc10Y
         540yWKfMHe/OIasXRXWqNYqiSRWZZOhedGjbZkK00QPQhlbJDBn8IVWVN7TgMLV7GGLw
         54ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778148186; x=1778752986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/gFcE0bu0rJve9uKyHSH4ubBqFP+IcaKsA+2O0rr/w=;
        b=Wf+NU+WDKQv75YB1CNdZQ7iAW2ahCjGgzj8cq1LHdJmFHJ/Lme63Ek2rV01UL9bVnc
         E4p7h3TTdxG+B+jKUTlibLJvRUHnou7ZtkYMjssVDrVamePUwmRPFrz+5+zDJBBGtt1Z
         uaMGyHeZWboHoKYWtnF4X5jCHjzhYlO5c/d2EiwtGc3Qz9q6fJn+lPfCVVuY+FmXbgPl
         sTEpZxHWv8AMHdNf+bYPAt7ecOB6/W37HJrAU9Q0Pr5UnvEK9F0CmTTlMVQOkLVQ8gV8
         yiey9Z5okxKQWp9dxVSa3zr6U/NI5ZQGxfKNzxldGnRP9yJRtOSsEm0o0Q+OrtI18M3C
         a8bw==
X-Forwarded-Encrypted: i=1; AFNElJ/TQ0B9hu0qXGVzh4pzv3l/KllqO8urUd1xknBDlzDl18HvTlJ/osYS4RpUa9rNRLhCk0H3ugP/dQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4jBoPe5mdRQWFhvmoS3z/1g+l/GcO4026pHRNSwkSRk7fZmaY
	S/b1KIRhXWjX8zirfoxo0ZaI9vEv1PMDebgK7oeNk08ueZBKh1M1Jz/PW19tdPEBVCo=
X-Gm-Gg: AeBDievaJR6kcH6mawLpzbFjKM87CguAEKBgYSw10hEl+P8udZJGEfIkDCmN+BUOL83
	g8mQgHykVFHpzWK2B/nTxSc/1ypnz9nbYDZP85g6VCNnSj2COPywNwRUB8eurCKXpGggTKg1O2Z
	ahlof4Gj+vyPWFaRbM2xyQPSqHgOWHzHZw8UEN321YH6M+N0brnRS4nGyMnDNAq+bJjoXsPdfBt
	Z3JiSQdNTlNYtnLXxki4hzPWPtOrGkGxHqagnxCsLoLKZndOYi7Zvb5db+O3OBqTqIpAzj/urFx
	7m7ZlnVoE7W/LDgf3uEd71u/UK1oUJUx+EtKDkSZQZ0LUiA2e86Qv249VPGIlKJdyErqxWoz5gT
	aceY3KQ43i+FOXLpTTRrg5mcuMV259SCdDwwVub1qyF9HPc3pNpJ60Yx4uHQ/A3XylaBYU8LVS1
	LTUOqtlQvmt12u8EOm5SNxOZS/EyqhK1gBd3gJZicYoP/Hnu+0nW/Cd7EmsXJ2EbogBCRaUYKjv
	+ojRZuVr40=
X-Received: by 2002:a05:6512:3046:b0:5a4:1914:bae3 with SMTP id 2adb3069b0e04-5a887ce5f32mr3013919e87.27.1778148186116;
        Thu, 07 May 2026 03:03:06 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8683ff452sm4587537e87.63.2026.05.07.03.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 03:03:05 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulfh@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v7.1-rc3
Date: Thu,  7 May 2026 12:03:04 +0200
Message-ID: <20260507100304.8170-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with a couple of pmdomain fixes intended for v7.1-rc3.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.1-rc1

for you to fetch changes up to ec1fcddb3117d9452210e838fd37389ee61e10e8:

  pmdomain: mediatek: fix use-after-free in scpsys_get_bus_protection_legacy() (2026-04-27 14:53:30 +0200)

----------------------------------------------------------------
pmdomain core:
 - Fix detach procedure for virtual devices in genpd

pmdomain providers:
 - mediatek: Fix use-after-free in scpsys_get_bus_protection_legacy()

----------------------------------------------------------------
Ulf Hansson (1):
      pmdomain: core: Fix detach procedure for virtual devices in genpd

Wentao Liang (1):
      pmdomain: mediatek: fix use-after-free in scpsys_get_bus_protection_legacy()

 drivers/pmdomain/core.c                    | 10 +++++++++-
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 10 +++++++---
 2 files changed, 16 insertions(+), 4 deletions(-)
