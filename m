Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF4712F585
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775473238; cv=none; b=pMxHdgXU2IE3vSdUHgh1PphtrY0epoyw99oE0keMfjsjv2wgw8g4KSodCm/QwrfdTfG7viDp/s7g1SN62fwvgPuH/m779E6pGhwxlUNPpmlr191ujtzLEsCjk6gyDd3AqviSy9qzX7uQgOvQCPqU4NN87o4vZl8YcYcn6j1yi08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775473238; c=relaxed/simple;
	bh=hn5f499Or0hNXNrye5vJMVoSUdsvh7C4Y0JQnYKaX40=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LFpeecuKq/qeZQRTSRJoLi+OACTlgtJaeSldIHWF9dcgFxb/pePKTsbTZ5EXghdsPZGkXB3egvxxdILG27GBjGQyE1YeyQUXYXU8+HWRif2u1Hb10mySScVYmKvMckmVh4lNOt4YAosg4LB9B9IKqbR0wze/o0j22rIT9Mr53Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p+OgSXYE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+OgSXYE"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso2352676a91.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 04:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775473236; x=1776078036; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNbdJwkFEbKrBcjf7DQ2cuy9Aznl3c79+BhwMbdynUU=;
        b=p+OgSXYE9pT65Wil5bmfgS2PEbsHka3IwvBEI9pVQqZKAg/kLiE/9qCA04GMLrgaYJ
         5XR/j1kJ+uLZ1fzZvqa+KWU/ES/KZwH1aeah8JERVkInFAZL9lL/JPFiicWHOmNjm4dV
         rD1sfC9P1LGlJnHP4PtBTVvn4Z4og8fM5XLwUVL6JPRBCofN4KZ1INSlhg6SrTO0RSe6
         ESOHQyJ9JRrX1hBGDjI1WCvUKQsPLaWITcZw0bO2qHeMLma+6ncPVsnHg7sv5enS1Se1
         /Ki4z4El6gcRPgOrIvf2+3TQkaG56LIlJS+/Ra5KmPtQN/KFzvWdqr9ewzb1I78UPPea
         aRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775473236; x=1776078036;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNbdJwkFEbKrBcjf7DQ2cuy9Aznl3c79+BhwMbdynUU=;
        b=A8HvOsQxrJ5tMZAqlXLEGfYNm8bmrt7MBB7aXyitDP/FRPkEZF8m+Mk/2PhkD8XORk
         0JH3abimAEEce5m3825W04bfEt8j2P3tPGV1FKb9BUmG1YjiuTKzGvraslo7//xkeg8F
         F6/P3bWlWX4ozHT+hlEzKSlaNxE4hLuDSLtQSLeFEqA67hcdACQlMMVKJHj0BhV2R5wf
         YQUThL/xKLJqQ3ZlSSUHb8PsllI+fN5NrIz2z2IEKZBS1Jzbm+9Q7wkuTUyw6hLgJdSp
         RTrzJYb8n0GOTebCGE6KqnyQ19nsDgsVYpCEQOitFRkS43ZD3wCogo4OACLXUfDUp11a
         4w7w==
X-Gm-Message-State: AOJu0YwfjAVjFRHO4v+4NB8OjG6wc4sf554B8v4+LjNz/x115NmezjQx
	3aK96P+W48MgNr5jm2I2+Ox1/hHt2w3k8zD15s2VIFapGiTO+BVJplEVjyqeIm77vJw=
X-Gm-Gg: AeBDievRxp6TPe8YNq9TQ7R65oSfZaPquBo6gfkKM6scXs6h6ypM9Bwxi3gLSiASabP
	R+eY5Flp5xr3/3UQ64nY6QYQUldgB9B9qH1dHrJTQvVLwKovJWzDPzKgWDatTgwZM0Z7IaazxBh
	JV495JQpId0fqD6KgG8JSRh8X2W+MF1G017otRYUrVf2RAbP6jjtxjTmWkUeMHHre91314mKtSH
	DqwgW7ru2R58MPUC/o1KitCs0vB8yriy2cvvjmum25U9zlnbaxqwS6IvyO34s8ZjD58InNZ4y1A
	+JsUibeVNS3P89eLCiKDf7ZuUNUOvl3Tzv8MYh56vRE62yosnnbmqy4qcVW9J0HnAMQWAawD0KO
	Geimg0y8mV6ulJxo+6hhb/hQxJIwm7Dg9gfkJf/WfRXty5kDpQqMyIzbZZ0TsklfBJvfJb2CvwM
	9HhcUnpnLVD8OBTVMR3xX4nXZ9d7VkEOA8FJ4=
X-Received: by 2002:a17:90b:4c8b:b0:35d:a2d3:5c44 with SMTP id 98e67ed59e1d1-35de69d5567mr11308077a91.28.1775473235970;
        Mon, 06 Apr 2026 04:00:35 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd36a0595sm14027147a91.16.2026.04.06.04.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 04:00:35 -0700 (PDT)
Date: Mon, 6 Apr 2026 16:30:32 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates 7.1
Message-ID: <qgpnmh6sh5abdgrgxv2so6xo3ktn43vhvykv3sn6z3224iioks@qukoxvvz6cis>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-7.1-rc1

for you to fetch changes up to 3d2398f44a2d48fb1c575a6e0bc6b38f3e689e22:

  OPP: Move break out of scoped_guard in dev_pm_opp_xlate_required_opp() (2026-02-23 11:05:59 +0530)

----------------------------------------------------------------
OPP updates for 7.1

- Use performance level if available to distinguish between rates in
  debugfs (Manivannan Sadhasivam).

- Fix scoped_guard in dev_pm_opp_xlate_required_opp() (Viresh Kumar).

----------------------------------------------------------------
Manivannan Sadhasivam (1):
      OPP: debugfs: Use performance level if available to distinguish between rates

Viresh Kumar (1):
      OPP: Move break out of scoped_guard in dev_pm_opp_xlate_required_opp()

 drivers/opp/core.c    |  2 +-
 drivers/opp/debugfs.c | 20 +++++++++++---------
 2 files changed, 12 insertions(+), 10 deletions(-)

-- 
viresh
