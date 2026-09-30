Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21134369D5E
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 02:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736663; cv=none; b=P346SHSsZ6GxTR0II5UcRF+5WrRNAI2VPuUWKXqpIgX4a/1VUI57BqWSwF5KxtFErv9kgjwJA1YcX2APwgmOG9axcUQvjbXStXUBlWMh6Qk4/icrLUOazoAid0NNXre59jkXe4jNGyXuze1QmlxrPz8E0qJHEGzx5IADAQcsyw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736663; c=relaxed/simple;
	bh=gZaO9mEV/Y8SsoqAkB7eeTVb5jhEC2I9/HmBQCPEO6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxp+EbvyxKFdb3l1Ry+LtwoHVwVN9QsRklhvVTgQhTZ/LRUwqRY/fKI9YemWiUr3m4FrIk+n4rCVA5Fo3eksZ98lJQnZZu2OZEGw4eV7lahob8IU1pAdg6YbDfShgzByiVxhT9lBxcnBOA+TXAbjrobTzW8tDJnw54kDNB14iQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OiEQBRkl; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OiEQBRkl"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34cde269e1bso52964eec.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 19:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790736661; x=1791341461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6SN9oSh6pbJF+i0gEecxT72QU0gyfS5+yGpFwKLICvM=;
        b=OiEQBRklilN/yT35l9rgc2fyWb5cDHNVWN96XTjUcwqksBWhKsMS/7q35BE0V73aX+
         s+RWt1J7nIs/ojg1Lk2iwRQmjCgIcorleyA7/GZZQjc44LXTy9mcC5nIc6VURhVirrdf
         RDyVb2l5bWVUayzfr8yZvw1Rflo2/fjIejCks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790736661; x=1791341461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6SN9oSh6pbJF+i0gEecxT72QU0gyfS5+yGpFwKLICvM=;
        b=sB6h/kFXw+oNtTbaXmw547BsFnQiJhyvWdm2oZvH0mV9FA0ziSJqLWK7sR81/jgRiK
         7XixwJx/7p7BPTcPkGBDPXl0l4Q4qQgEJXooQgK6sVlup3T4jbwzTFVgTGYs4hnfpjgL
         MfFcQdM7mKGdkfb1XzPEF1FWupQeWnYBZT6Wg0QFk8O/Or2A7UL29bqTklD+QYJ0eqru
         3i8o5ub3te2rkQgtYhgfF1hraJmDAcID4EAuGzW65grzEUEL0Lo4Na508AGeOapSYX/8
         hLaAhmcsXjKlE0ViM+60plr0iH5sfv9yOxWKcftG84ef/ngn4IrP6we+wS8uKVgDBWS5
         QQvg==
X-Forwarded-Encrypted: i=1; AKwUvBw0uR0VWlIhPSmqZr9d4taoJUWZJneJ68WrOvfPBmIX1rGDdPZtT4fCW4KwXoVaN2pvYsuMnU8OxQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIZrNBgGiYi/YGW6/W+WbgFzzJIY1DQe+ou0+LWf4o8d8lvMKpx
	/jdbW2Zf//eZ+9XSKLxi7AdtZPW5wG4Ff0e2bonGxhLubmzAhQtFgamRSWAwQQOTW+27WR05m7G
	Wh5c=
X-Gm-Gg: AYBFou1HrQnbhZP7q2NqIYrVXjPoIKfzBjwF250v9+yiJyFDk1DgUlyJzp7Br7ZIXH7
	oFG/x0xjoKkhUrLM3vR4qz7BcR6IL0CR+cWWkBi63bfj1ehOFL5Pfj+zpwJmhqC0XcZFiELim3c
	vQsPobAhz+NpMA/eTHGP7mHVOqQWrVc3txM78QEOmZdue/RkW63PJRCEMD6OxQ1ZupgObkI/KN4
	/2V5kNMpIq0fNPJwXbPrlo7GCmLhnn8qLD+9pSWX/xccTrO+Vml8/7v5ZXjxA7X21vwH76K4TGo
	cwTYj67fH/NnTwC0lCeFeONy3m5j290w/KPsJy+nWPiOmK+cy+sk58rgrSoedpsuXZDil5blF1F
	r0de6ZqkQk6j5FgAAR8Wjr6MAvlVgQT1eJLFmpRSyB/FiVTC4+AA8kPLVeQqGP8FJLY0F9FCzaI
	p6Yz8hemDPPsuf37eNj4oh6n+kBA8NtHbgg4JliRE6hD1ORBlp9+vtClmsfkB/q2jB17HZV7294
	6HYEXChr1RBwITtYHHC7Jm4uv5+YdDZZrwF
X-Received: by 2002:a05:693c:6392:10b0:332:8b9b:bdc4 with SMTP id 5a478bee46e88-34cdc3caaaamr236693eec.20.1790736661110;
        Tue, 29 Sep 2026 19:51:01 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5f5a:aa9:d06d:b4a7])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-34cf4a63ac9sm605eec.10.2026.09.29.19.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 19:51:00 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 0/8] PM: runtime: Overhaul kerneldoc, runtime_pm.rst docs
Date: Tue, 29 Sep 2026 19:49:48 -0700
Message-ID: <20260930025044.104824-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The runtime PM documentation could use some improvements and additions,
to help guide people less familiar with the main runtime PM concepts and
its internal implementation details.

v1 is here:
https://lore.kernel.org/all/20260904212000.4167880-1-briannorris@chromium.org/

v2 is here:
https://lore.kernel.org/all/20260923174711.1283986-1-briannorris@chromium.org/

The first part of the v1 series has already been applied. For the
remaining work:

 - Formatting and clarity improvements.

 - Clarifying core concepts in the Introduction. (Pretty much all new
   readers I encounter have a hard time with the difference between
   "enabled", "allowed", and "active".)

 - Adding Example driver patterns -- because the API is so large and
   complicated, it can help to try to walk people through standard
   practices, and what everything means in context.

I tried to keep some of the larger changes toward the end, to hopefully
make it easier to rework or reject them while cherry-picking some of the
easier stuff from the first part of the series.

Feel free to add suggestions! Within reason, I'm open to tackling more
here, as I think many people have many valid perspectives on exactly why
and how the docs do or don't serve people well today. Or I can tackle
less, if you think some of my choices are not improvements.

Some possible follow-ups I'm toying with:

 * Slimming down the API might be better than heavily documenting it. A
   smaller API is a more digestible API.

   My only concrete next step: drop __pm_runtime_put_autosuspend(). Its
   last user is nearly gone:
   https://lore.kernel.org/all/20260806-smmu-rpm-v4-1-8183d007331c@oss.qualcomm.com/

   I could also see deprecating one of
   pm_runtime_put_sync{,_suspend,_autosuspend}(). They all do slightly
   different things, but I'm not sure every difference is actually fully
   intentional (or at least, not necessary).

 * Tweaking some of the behavior on pm_runtime_barrier(). Today, it's
   very asymmetric, as it prefers resume. But I believe there may be
   value in making it flush (not just cancel) pending suspend too. That
   may be in a future proposal; for now, I just try to make its
   asymmetry more clear in the docs.

 * Sand down some more rough edges on return codes. For example, it's
   very difficult to get any useful meaning out of pm_runtime_put_sync()
   return codes. There's a high chance that anyone trying to treat
   return codes as errors is inviting bugs. (Is -EAGAIN a failure?)

   Of course, the answer there is not "document it better" -- we can
   make it easier to use.

 * Adjust the way devm_pm_runtime_enable() works, specifically for
   remove()/teardown. Currently, this is very hard to use correctly --
   some common driver patterns may assume that a device will tear down
   while RPM_SUSPENDED; but that's not actually guaranteed. Notably,
   this makes some of the "Examples" section fairly tricky/subtle.

Regards,
Brian

Changes in v3:
 * Misc formatting improvements
 * Rewrite Examples to avoid devm_* at first, to highlight correct
   approaches
 * Include error-handling and remove() in any probe() Examples
 * Advise more caution when using devm_*, as ordering issues are subtle

Changes in v2:
 * Major rework on Introduction section, especially regarding "enabled"
   and "active"
 * Add appropriate teardown to "Probe with Hardware Powered Off"
   Example, as the remove() + power-off behavior is subtle here, and
   easy to get wrong
 * Drop changes that are already applied
 * Add a few new fix patches, noticed while reviewing the rest
 * Move Introduction patch near the end of the series, as it is a likely
   target for further discussion and modification.
 * Correct Ulf's email address
 * CC linux-doc

Brian Norris (8):
  PM: runtime: Correct pm_runtime_autosuspend_expiration() doc
  PM: runtime: More kerneldoc formatting
  PM: runtime: Misc improvements to runtime_pm.rst
  PM: runtime: Add "Section" hyperlinks
  PM: runtime: Clarify ->runtime_idle() callback return value handling
  PM: runtime: Clarify driver callback expectations and structure
    Section 2
  PM: runtime: Expand introduction with core concepts and structure
  PM: runtime: Add Example Driver Patterns section

 Documentation/power/runtime_pm.rst | 676 +++++++++++++++++++++++++++--
 drivers/base/power/runtime.c       |  12 +-
 2 files changed, 633 insertions(+), 55 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

