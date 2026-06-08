Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8653016E0
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898744; cv=none; b=qHdnZtnwBV3bWhdr44WqTBz7Cj+ok+mWsLCoKiPSFan1Fsf+MCX2vuBIM8YWEZxgF1DdOLJEQBg05+M5oqqMBCke40PY07rrMTxhWEwqQiZ0J2vFbHE5GIBglYopA+nt/mEOj6MkyQwfiCZBwvBHAcD58GHTG80wSztVKqBtCNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898744; c=relaxed/simple;
	bh=zOxVTYUZ4E9b4xRSqHuOj4FuwDBVa6e4xQnUOTnue0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lDS0ncGQI7PmOPxGmyt+BjqLIe4C9xhSCfQZ8t76lsNMG5BhLGr/N4ncmgYIzkFpUCjBxoScZqHlQ7VADtRtn+g/G2r/OAJRmdQSH1Rp7WCizDn8n1PTUAh+iYE1lMKrbSXhwb8qSzYClto+XR1CCNdOvlgeBRIIOW7bT9Yuo+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PsTW7XQM; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PsTW7XQM"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36bdda53d99so1602343a91.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Jun 2026 23:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780898743; x=1781503543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Wgr+PUjS6KK21R2fddoLp3+kzRYzjQ/vkYM4fzcgbQ=;
        b=PsTW7XQMYVNaPP7GiCoJ8Zbo/h9EC8QlOJ+G8Qw/BGx0GIodhXm7ZTx3K9ziu5zj2u
         irDNB8kimSc908oFkrBo+vZ6KeKm3rS8YvWozIAly52vcmwjp5g6EqWd10DmaLPXmdsy
         aWIomtbfqoA4KbJMv5V8zgO+gDjZIYHD86pDABT9Hcxjq0knbeDwvP0/ImgsxJMHajrp
         c/PU+XMg9/bP6G2GPV0sM4opgsoNFdMJCJMBHaFIezxZxnggu6LxDia30VwfZxYAxQCb
         LlDyIkRo9eusqBtdxX/6OsydEU2B1loBegcmAs6v4Fjrxe8xJFFfFZ4twi7YkS8Umd/i
         3f+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780898743; x=1781503543;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Wgr+PUjS6KK21R2fddoLp3+kzRYzjQ/vkYM4fzcgbQ=;
        b=WRHgHwptkDxEdnB9WV7FFaXy57EK8fiH46BTmrKL5AnJO4BL1gg0y2KfnduNGLWlFs
         unOE37alD37KT2xLj82EzLu4pkSIVg7fsQtRhZ5acWQ+jQB0JqiQtJZRDV3sjHBC9NEz
         Jby2T/wL0oPq6WNMYHQDUArctFBUEGtYacuEnWE69IeVvtxyheYAbXO0KiJpECBwDzFr
         zmP2BlxOY9FEjLD6jJZw+D/xT4XyUjtVxdL3iJsSyo77yo43+27lRbEzrjnEUyYfKe7/
         Hg4vrab6CUtw59gtSIiqqo9xcCXjuD1wPqt8cE99wh0q87uh6ZSmQMlTo/YUkBJO9reb
         TwGw==
X-Gm-Message-State: AOJu0Yx/p+as63oJxXQtOxxJyKZqnmiPulvgsrOqD8zx3e966zPVi9zw
	CS2My8c/r2QcDXPwTSsrON9WSXhscqPtHdeLjVT6+A6EY8Ock+bBkia4uL5HRou7zbdrv55V6rj
	EYtY9
X-Gm-Gg: Acq92OHYk5U/BZpPu//aOmz8c2aE/K6XmFK9BY8qQJRxPuFbP9O7xo1o7ZIDnIqeTwE
	6qwb60pR2QhfhJHz2QuCS5U17BG9kz+JC3TIrYwwe3ru02br+umNX91dGYV/0xoKn4qU0Nzc8p6
	oLo6z6VgfgjyNYBt3phbnIWQVa1zLWwK135i26vxCNaJJwqZbwB0E+XsITVJTTwCz/F0EsYgzXf
	7ddk2oxTXpD1z/9mhl7wVg2zcgBbSAPsTMfkDoKxRwwLkN8L4MR01xbjBxkKt60X4WyoQO7XSan
	Zu863tXCaudRmx9pED6A22DOXK/GDCx0rD/dLls5ZZ/uvEvU8eHd5IRqu+QIRb/K40HF9/dwWUd
	RwZ0Z3rUOU7ScZmJU9wLRYpRmD0nKxKM7hbhM2o2DkDdXM5g3OCxHZbQhpjE1cvWCxNiRN9qzOH
	tbS0xJnf+5FmgF8HSWwFQbOOGFLNo9s+dCYZxHQz1otZDU
X-Received: by 2002:a17:90b:3d8c:b0:368:d839:28d5 with SMTP id 98e67ed59e1d1-370f0d4ca17mr14890092a91.18.1780898742451;
        Sun, 07 Jun 2026 23:05:42 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a285a1sm14621014a91.9.2026.06.07.23.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:05:41 -0700 (PDT)
Date: Mon, 8 Jun 2026 11:35:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates 7.2
Message-ID: <if5efe4wlmbgls5ylj67jdfgqjwzpfmk536lar2v3djo5o7gux@6sbnyfo2c3kq>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-7.2

for you to fetch changes up to b59020834b2d8718fe37a4e77367f554cbf95982:

  opp: rust: mark OPP methods as inline (2026-05-25 09:40:52 +0530)

----------------------------------------------------------------
OPP updates for 7.2

- Fix memory leak and a potential race in the OPP core (Abdun Nihaal,
  and Di Shen).

- Mark Rust OPP methods as inline (Nicolás Antinori)

----------------------------------------------------------------
Abdun Nihaal (1):
      OPP: of: Fix potential memory leak in opp_parse_supplies()

Di Shen (1):
      OPP: Fix race between OPP addition and lookup

Nicolás Antinori (1):
      opp: rust: mark OPP methods as inline

 drivers/opp/core.c | 5 ++---
 drivers/opp/of.c   | 3 ++-
 rust/kernel/opp.rs | 3 +++
 3 files changed, 7 insertions(+), 4 deletions(-)

-- 
viresh
