Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE38C396D30
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004729; cv=none; b=kmpxZYxMoMPhrNHeYeLbyOS8r7Anw+r4O7/b029MoxsrLLK7G8VxUubrD5JHepPwKBiu5oFMJPEKdT/CU6Dv0PLo7Pc8kCY0y8iMETKbdw5+RAZS1HrOwHdzRWfA7s8s9PZvZtE0iddTk/43BDIA7Tko1eFRtnLTrNUUOoCEZJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004729; c=relaxed/simple;
	bh=fgy4/QrJ1q2St5WCES0qLBWSWHedyF9fxsHA6HlF3rM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RTXHXfaYC+xZ5tGDs1W3YqnxWlpO0PsElLCv1H/xOnEDDDv3tqEYZh6IExyxtbz5G1oBZLx9w1ZSBjZN3HuZ3XskBv3PHuQCaLZfbq/sEX9fhA+vzBytKxE7hH13xzIH1KwY3W2uLreOiNVIYsKiNpDnbcALDTOd1aZrMXWgVV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MKra7MTt; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKra7MTt"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a278e0f7f6so2499048e87.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774004723; x=1774609523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lO9Lmv98MRpCJZv2Mn3Kteip86atAMewwUBvtPiPUSA=;
        b=MKra7MTt1enxSc/vH3KmqViJwy94X/tQb6nsDVYPdkwwlT7ew5cAWFSA19yU5WV06y
         Ohws77Rge095MgpMXg9zqUHI0KY3i2D+yv9Rz+5aROs9pop3tngl3lyvDQKe6JLH57f+
         DRP8Mr8GV21cSfAWIiLuXk1I3XGdn3a/GgVPPQuC4+QvgpcS/3dsiUdua/EB3C+sHqZX
         DTrBYMXrcWegmw4eaEdeVXVNmQOXMaIgr8mojJh+0DuhUmGQcAUxHrNzpszq84SoSYrH
         yK/CT2cH/AT+GPfYULY7pnWUfqEXMDvHbEWobx6Vo5rKNW4/LSw2jwl8aotnsD/aewBK
         j9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774004723; x=1774609523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lO9Lmv98MRpCJZv2Mn3Kteip86atAMewwUBvtPiPUSA=;
        b=QsGJFnFIkvwjbu8mvYplQx+ti1xVN2LCSWPA5SQflaWTluRjyqqCFg6j+hiS1bThN5
         mb7PAiqaDrZZ9RnezMHdkKwuDiteiNH72JveiNLu/aLTUzw/gCrNZSELQsv1ysEOtBPh
         ckxVTnwI5vCJtlo/QS7Ha43WCI3unCvDUuAiEfIHLODhxq/JnZFMAMQXoq0GAntSKzfF
         PQ4GtGMAI0wC/9QdESGiDzIi7d2a4+y9GQs9ZD/5Fz8v8ZxXAPcOcz6sWh0BH+dWCcSE
         4tPYh7JdHK8RrL52Njbr7z3o7KMVlBChvhrUnG5XjdBanC+3D6ju3g9qrE2OYzmyhAQs
         g97A==
X-Forwarded-Encrypted: i=1; AJvYcCXU4itovL7ACPngxbBHD8mrt0TbHBRwFnBzQkdzDt978K6Zy3kLNsDONlu22Two/C9fwDYyCvI8VA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiAsnuP1tolmBhnLpM/FA/HDt6EgykrvsmIxQVtNDB4Weix/F7
	8Se9xDoDE1OIeqHD/RHWY+nNPTRLhTRNbrd1kqIlRY/cwGue1VEm/1BSSiRoOevvreQWaA2o5sS
	uK3yqSJ4=
X-Gm-Gg: ATEYQzzFWd0f3NispvU08mbTPM8oOhypUtWYq/4YMCWoIf8rqj+4v4UOCOPrPZAasRw
	IqcddFhdwqicli4tZfYpjNZnEzRRVr8btLSN+8Jk8iHyeY23lUebjFnFaUGIJR7YG62u2dTDynB
	e8ZzfLCIq+jmw+UVmvENGLMmJNkd5j0X9uPpP9Sq24hRS3jSZXYykpSA4jTuIQRGJbO87etbEFI
	XHsWszY9JoEZ33W5LFAbX+M0zc+bTYuf0tpQV479BeKYI520JL3Cp/ytZ7KDQIb8xRCgCFquUhM
	9bApgI/roirp9PGYbqZhD94tz9twbBO7IlW12OW06gKms6rvL7pIzou/IM2A1gKoQ7CMNrADbHS
	cQ6EDEgthn9b7XxZED7y8wU5ZmLHdDUbNfKxH2igZT0IvU6UZP2dAGt/e4LgISgmiHT3oMjYh3U
	a90lbPvd1eSMUG7vn6UISt9OJp9GEbd+NqPw7tGkwiyrw0bcpWYIA6ZqBZg65X2rRtAD9VPcFS
X-Received: by 2002:a05:6512:3c86:b0:5a1:4440:2c48 with SMTP id 2adb3069b0e04-5a285af6dbfmr874480e87.12.1774004722396;
        Fri, 20 Mar 2026 04:05:22 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a28510559bsm474295e87.0.2026.03.20.04.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:05:21 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v7.0-rc5
Date: Fri, 20 Mar 2026 12:05:08 +0100
Message-ID: <20260320110521.2044803-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with a couple of pmdomain fixes intended for v7.0-rc5.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 0fb59eaca18f1254ecdce34354eec3cb1b3b5e10:

  pmdomain: rockchip: Fix PD_VCODEC for RK3588 (2026-03-04 11:22:36 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.0-rc1-2

for you to fetch changes up to b826d2c0b0ecb844c84431ba6b502e744f5d919a:

  pmdomain: bcm: bcm2835-power: Increase ASB control timeout (2026-03-18 19:15:34 +0100)

----------------------------------------------------------------
pmdomain providers:
 - bcm: Increase ASB control timeout for bcm2835
 - mediatek: Fix power domain count

----------------------------------------------------------------
Adam Ford (1):
      pmdomain: mediatek: Fix power domain count

Maíra Canal (1):
      pmdomain: bcm: bcm2835-power: Increase ASB control timeout

 drivers/pmdomain/bcm/bcm2835-power.c       | 12 ++++--------
 drivers/pmdomain/mediatek/mtk-pm-domains.c |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)
