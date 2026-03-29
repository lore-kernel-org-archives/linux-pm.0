Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C316274FEB
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774768014; cv=none; b=Z/wlkKyVvpj3shlxS4+GoXZ/WfYwhrE0QFWLwSY/e1gcO/DUlH9Pu0wc56gcGubltb7hdwK/9rSdVfP53EFaZNz+OV4ULTO3BnB75ZgLpCmNG35TGM3Y8j2ZBfoOKHq/8u5BUkJa6m3by7XIIA2B93rES3upAlXAZHPeOsRSZk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774768014; c=relaxed/simple;
	bh=fpi3TBe5OAWUI+7TZuIt8WP2939DZzkzcQT45KTUzC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=seBKAcclcEd7iLGRujTqGYomYdguEID/znybPOTYMiFoUEwRDS+XPDU3vkujUk9YVt7sxvQVj3YMkpIAW/G9eOTJT6b8bwQjCWA8/KyXFAWYfvPAM1mNn/VkBdyCkxKiwZ9/YYmzKqHxfCt5erOt6Flt+vOWVf7uoesMomFO/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiuierZl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiuierZl"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-829ac4670c4so2565749b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 00:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774768012; x=1775372812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8JeyUOZOcf8FIcNLhliCaTo9qh5Kx+NVOnxAfIVv0No=;
        b=ZiuierZl/g3LYPONLmWpIRtLAeubk6jiHlupC9xk6u93xQMPC8ZJKEThRPlYgfDFKa
         PuEMLRoB6VtfZpnqEi7cDHuOI1rD+PsxsBxjpIFcQHEjPY4x8gY7GckrfvsCpbpQXPzI
         HUNLA2F088rjOc78VOJissVsoN3IElXvwumT0FyRDuu8P+3u4yoXq6zZZpei4kO3nSmn
         1OJQoUfevCpMfdVDC+ptORiWMq/1XXeD9SbKalObyvlKVvDHRWNoXraqmNjxpAf42F3F
         1LgPX7vBPvGLWz56mSVSu9lBaQQWqvD+Nr3yYNgUsyq3aeHr2eeCqJaQPZZ1EkWI4gGJ
         BWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774768012; x=1775372812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JeyUOZOcf8FIcNLhliCaTo9qh5Kx+NVOnxAfIVv0No=;
        b=ZwiOAvC6ka17i/KLRuZ/k2/OEGU5PeD02iqZ+aHn6GQqSVUIjEx22cUxxTB7jNFsJu
         8w+ijIyZ9SYCP/6CS1QSBLovfOzucGaoQ8hwjpXHD32gXjLS326uVmccQkcbaU+k+TuB
         vs/g47nNmWaVJzdVQwLVwucBvQ+tb3gZwmwADWFBIgwUoc+Rm9aHgyHZndkUKqA8yzLg
         N4xMc3VakwX+7s407/2pmDyj/myRcsDtmVmYYBmHaWeu0rjhpnoYvgOP9iGHlHcNlGfN
         0GJR5at3Gy0UWrn8jSCdP2lJRg444y3cbA1uWhEpQKuN1446VP3NsQ54C0eiw41OWvcd
         7hpg==
X-Forwarded-Encrypted: i=1; AJvYcCXom62ffBgYkZ94k6/y9i5Zn6esOXvpf7UTRQhLBt852Y6IyGqkWbRTy0LBG5odoJ430wHU7twd0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRZoD5leUAr1KYP7jyPeb3lB6sKOfx7kyOGK5CnwEJVAuSt5uv
	C/YBEzdnewwL99T1p8izbfOrQnrt5Rg3QIM7cMK58kHYN0nt4JnXitDN
X-Gm-Gg: ATEYQzz6Z9M6Zb9qfF2UGkmZYmgOz7Ez772qcT3OFwpXpimVR5bU2GzDDjzrBJ6oFz4
	9qUV/8snZgVYV016NLofrM7pD8H23bHUkEgBD6FEaMUkr8wbCzr/DpkChAW3a2G1Hte7Z06zab8
	rFpza71/z2ha5eAJeM+7EOch6Gqifv8r4SM6b0n7OrC2pXTMJMbqNTm1H1lGhn5wtogBByCQGGG
	YDvKuXQJR3U9evr0sCxyaS/gkQKDrU0nKw5qpE9XB6K3U3yUiWGszbBAANMG31N19nMBnNUq65L
	MJsuTFYc83BPDhgRNqBcuXn4s+fodxmVn9BWUhq4Pe4cyeIhkrG76cvZOC4LJchNQ64PPUfoEVp
	SlS0iNfbq5ModuVOi2fWQCmOqiYKrp40POloeKvlO4vT7DwErYxgI7Aq2PvqdUGg/Z5pojI0g7f
	csgJNE0cJZvJLwZTpofxdnz5ZQO70p/Dos2IR8xsMi70s=
X-Received: by 2002:a05:6a00:aa84:b0:82c:6c90:c77f with SMTP id d2e1a72fcca58-82c96017ae1mr7518219b3a.50.1774768012496;
        Sun, 29 Mar 2026 00:06:52 -0700 (PDT)
Received: from debian.killsync.com ([103.85.207.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8437441sm3911640b3a.3.2026.03.29.00.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 00:06:52 -0700 (PDT)
From: aravindanilraj0702@gmail.com
To: rafael@kernel.org
Cc: daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	srinivas.pandruvada@linux.intel.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aravind Anilraj <aravindanilraj0702@gmail.com>
Subject: [PATCH v2 0/2] thermal: intel: int340x platform temperature
Date: Sun, 29 Mar 2026 03:06:40 -0400
Message-ID: <20260329070642.10721-1-aravindanilraj0702@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aravind Anilraj <aravindanilraj0702@gmail.com>

This series fixes two issues in the Intel int340x platform temperature
control driver.

Patch 1 fixes a potential shift overflow where a u32 value is shifted
into a u64 register without casting, which may lead to incorrect
hardware configuration.

Patch 2 checks the return value of ptc_create_groups() and ensures
proper cleanup of previously created sysfs groups on error.

Changes in v2:
Patch 1: No changes.
Patch 2: Add missing sysfs cleanup loop in error path.

Aravind Anilraj (2):
  thermal: intel: int340x: Fix potential shift overflow in
    ptc_mmio_write
  thermal: intel: int340x: Check return value of ptc_create_groups()

 .../int340x_thermal/platform_temperature_control.c   | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.47.3

