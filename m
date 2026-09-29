Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66C95581F9
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707663; cv=none; b=UTkSTB/JFmpNWOTggQS4vJG8gBEjXPWRbmuGS+o/qj5owE4BXsUwC2eaV+ltTU/nhnsAgsXTed+vbGUUsyAoaP0+sF4zorRzosqc7Q4gavdekZksutHyp4AYMd+TvUozPlYsUct2xNXuIxt/Ywa1VnJCicFC0GbvPP0bSMFJ0/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707663; c=relaxed/simple;
	bh=JioQNAbaO2zxScrtYnq2W3JQL6Zeg8GcsqgswEq1TRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EbOztArQXMeH2a3QfMV913qJqr6c9E/7CFjkXFTFKoWpdsOzY7Nr3v2xBn3FLdueVzOFejdY2iQc8sCJB7Ru4r84N/eDPFy/4Heqyim6lbkkEwpFNJrDSl2uGLo/4ZuLjTPpYH/8m2G3ZNbdz0Mu1sL6kr2AzJmd0yRRCfaM+N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lzYt0s8v; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lzYt0s8v"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f47a9b57so4040175c88.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 11:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790707660; x=1791312460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mwRGPSmzjoMGKC7mXVXKyxtr8TeKLQ+FOQu33IyOJr4=;
        b=lzYt0s8v7+TAzg1WonAmU/oCzOu2XGF5mr7sSdW0/2FRF2oO89wkpdro+e4Ao3qJxx
         88dprw106yudQNIIgVY9J3JALVW3Ma/nJdEzeYc+vwhT0N0rIjMFQEShVB0Om40htv/J
         /fHQUqe/QCY2vpenfRyqtB+qQQS4pU9a2UC1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790707660; x=1791312460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mwRGPSmzjoMGKC7mXVXKyxtr8TeKLQ+FOQu33IyOJr4=;
        b=az+LgBV+bLIPCzIX3VLWPaKm2LdCGxqZTrWVir0SEJvj6tZ871qAOebigqDQzKWR8I
         DAy+zhx5JGLoNT9Lf+VC6sCY2/cKGfCzZxCLmcReIiPtVurXWJsSwJLNwzpErBrlVOE8
         VqqMBXyGonZLeWOal113skqfjmmK6IuBTCH+NVsXU0aHxkdb462w2A0D7IzyMDP+UqtN
         01EwiyhCy0BdFbV8zM9ggpw5IPrfBrpHkckpm+egKu2bs7l9usAz0NmyJLXGQfJxQJrv
         m8D+9SElekqeWFZH/TuIe24z2hX8gZZlFXd1Zoj3GXG2GWGNySEfTUP6oGlVeuAnum7C
         dpxg==
X-Forwarded-Encrypted: i=1; AKwUvBx+MoEXpHfQB57UFioOu0tNBIBmgwo0gTCI30etyt3B+YkWY0OFUAvKnIObWQ4CvZsnz59mvP7TIw==@vger.kernel.org
X-Gm-Message-State: AFuF++kxU4yKxfEVZeXKZGAglKaQ5gh3afpGY7/gUsQFuVscRfl15hAu
	hRvEg58FahLxmppgfWT5RxePnc5pAvvmR9IwR9sCrY/2jgwPKrllgkwFLuiCCAk0kQ==
X-Gm-Gg: AYBFou2czMIQjTAHbC2FtCcPyepK7IP2LJlP990uC5Z2xmzZ0h9XBwSTnMlJFxnyaPc
	/qyCFeBh3APhxHzKq5CEETxsOTkc997puPpjlRWNyUJOE2kGnzrDemvoO/1xGSzd4dfw9uyqplC
	pZkdiaWXe/ZXjRV4ZrDFotNdau3N+o0XcPiGXCSgVjLH+zG8Wb2R3NdoRv6W1xrjRVs8M5D8Cq+
	JO9SdYDTr5s8rYJBEpGj2h765L6+FAtzPgEVVJec2PTiNn7wmd5hvqe+7IJMSGFK03D7wMGYIGX
	WtikjhWvqq62u06CFVCtjpt9+qJdTnjkj4weZCme2LsNczOlAEzlvbZA0GYIBP4R/5jj+PdqE++
	8xdxnNC9SNHSf7JmbRfpSPpFRz00AGdiQ8R76EjCibCi+g3+Bs/0MmtCWMIZvnJ9Tnpev9MLqGo
	pa9AxXHtRa6mCrO+aMLmdwLxOVLNDojS9NH6xBC/xRmKZbr+jyru/3HCPvF9K+OtfN5O18NsI+E
	wkA26MlBRxtNqKUkeM05exfkevbezCKkzAD
X-Received: by 2002:a05:701b:4513:20b0:143:57c1:6242 with SMTP id a92af1059eb24-14c9ef3250dmr56017c88.26.1790707660315;
        Tue, 29 Sep 2026 11:47:40 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5f5a:aa9:d06d:b4a7])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-14c640bc413sm946319c88.11.2026.09.29.11.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 11:47:39 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-pm@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/5] PM: runtime: Autosuspend race condition fixes + tests
Date: Tue, 29 Sep 2026 11:47:10 -0700
Message-ID: <20260929184729.2346769-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes a few semi-related bugfixes for race conditions
around autosuspend and asynchronous suspend, as well as KUnit tests.
They don't all have to go together, but because their tests are added to
the same file, it helps to group them to avoid conflicts.

- Brian


Brian Norris (5):
  PM: runtime: Cancel pending only during non-transient suspend failure
  PM: runtime: Avoid racy clock checks for autosuspend-retry
  PM: runtime: Add test for autosuspend-rearm
  PM: runtime: Synchronous suspend when updating autosuspend
  PM: runtime: Add test for pending-autosuspend + teardown

 drivers/base/power/runtime-test.c | 97 +++++++++++++++++++++++++++++++
 drivers/base/power/runtime.c      | 52 +++++++++++------
 include/linux/pm_runtime.h        |  7 ++-
 3 files changed, 138 insertions(+), 18 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

