Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9773C3BFF
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943368; cv=none; b=twY2fwOwL02lQ6uBXz6b5KWIlL8IJlyUp7RTZ0KlKZn72Edcu2OxoCuJFFp9foaycNWjoXU6DEgywjDwSrnUbB1CG6EyLPLpr69XEFazticLwag+xbBFdh70M7nNe0XJ9DS/QY8jTlemIZcFQeDC0I6saN6tOdHFwuHoUQ4QTTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943368; c=relaxed/simple;
	bh=F1pviNn8lynBvPvORMKmIsv/2V7+9VQMRSrR40ekX+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0l8potjklcS9JzH7+u7taem8kDedht5eV7DGhBe+cvBL/fY4cQEMfeGbvKzfaVHo/J2ySfLIlsWjq/dbHkAnfSN8vYMPOUnh6vFxeJPextNkuYztDKAoBtWafJO6CyQ2CEjxrLX0bOvFPgml5eORRwM6sXvb240t/ASuLlBbn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOZCpf3v; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOZCpf3v"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4870206f73bso32862115e9.3
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 00:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774943364; x=1775548164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=P1QJUAi1/64rwInB3eoPUZsspxRVjkU2I35RZxwGISI=;
        b=oOZCpf3v7gP1JdM4QlXb0a9UbPfLqfbWglwsRpYEeDZOnERewi0iHmALM7i4Af+ERc
         L3+Rt2coFavP+ipkZ7QQ//rPxfj7KXGLPDwSbQnBvRhvUpz+jzQmGSTZTNWlM91xhHuy
         uqpG8QXbJ5U1E67twHJTwviH5gyTYEvNOTBf5JqZl+ZVTaLgGyoorv4kL9e3gV2yX7yr
         bb28PShVsSzRWz5g0C+HCqxbnAyxYlsXCi4Ixe7f9ChirnyKv9OpFeEbGWCR2POSU3Pi
         s2Z0Lj8oq+VD3+E0SsvUXqffA6xWOPEGCp2EZasx9hvF53DQmbGtTUB7eKaTu788Y4GR
         Fnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774943364; x=1775548164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1QJUAi1/64rwInB3eoPUZsspxRVjkU2I35RZxwGISI=;
        b=IhQNBcCus0er5uIc7TCO7ivou/Mj8D+WN7t+rlB74Gf9DiDgc5hEziYBYFpMXpwbs3
         FUETgVO8o1X6Ylu9QEB/uyuwoUtNNw1RposcGYxE9+I49yKNJGHqVxvLF8rVs1xsnBfJ
         aE1nbZaV86uNZSbJaBn1/3oebMLYeo8i2Wg59XN4pDhb3iqlju+3BC5c3BvtGlZTNZIJ
         KWhNUbz2b2Z8ZNhE55tYFIfo0bxDVwrQvca+jsAZqCkb8LC1D0kXGWalBSIh0O8RmjLM
         dK6U4xxh+TDLbsUzMBwIw85lhn5GMtPV9YUBLNe4jIQr2Ew7wN3AI7FnVrsvBXQikOnr
         ELQg==
X-Gm-Message-State: AOJu0Yx5M+qfaYHEmds4WqBDZCP/bSX3uP63SidTrqV8AE8IvIWWt8rL
	/xrhqE86vG4UwtLRLlOS8DRXihLEK5SScm89hKJz3wQ0AD/Lw6ChE/4S
X-Gm-Gg: ATEYQzyiNtWX1Gq0+/XXKLh3wWJl8wCf2wmnxTqBOTTLDEF1Sa6LjhMYYJNGSQNNbTu
	iHXNBA1aAjikMArotJdaZEDhpWs3YtGbd5vphjyotq4VjVWIKFMe5MeF7Sxj7/XjCiDOGH1c6Pt
	MAJWsN8BAKANqLpQPUHhb0o4WNnOIbtroXvZ3iAz/dnyDfyTv53dc+C70WXo+JZPg2eyp1O+7jc
	1kRVKPQROu0RihRbxzOO9nRCIq5la3aaEnnvFMkXi4LbbttNy8QCB7zU64yt5yxBr0x6FkcvkVZ
	fNEPjfG3PecrgMKVS5yC2jZ0DRXx2k8DqllH6bmQO9teYkYjfW4iVCCgnQi8aYt42+rEfZMySak
	A9yAL0sxrG4JrgmG+fraJOhqrcDnCJLxle5DABPT2ZIIsTfCdxGaZUdTHfC+dplgKiVRTDfNMHi
	hUJzQTQIsT767zJ6kAfFexxBRyRfhtNA==
X-Received: by 2002:a05:600c:1d1e:b0:486:fc95:1a91 with SMTP id 5b1f17b1804b1-48727f2373dmr258310945e9.12.1774943363474;
        Tue, 31 Mar 2026 00:49:23 -0700 (PDT)
Received: from nixos-office ([2001:8a0:e95c:5e00:f8c1:fa51:743d:7994])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2471ee2sm24974967f8f.29.2026.03.31.00.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:49:23 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: christian.loehle@arm.com,
	daniel.lezcano@kernel.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] cpuidle: cleanup dead dependencies on CPU_IDLE in Kconfig
Date: Tue, 31 Mar 2026 08:49:20 +0100
Message-ID: <20260331074920.41269-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Kconfig in the parent directory already has the first 'if CPU_IDLE'
gating the inclusion of this Kconfig, meaning that the 'depends on CPUIDLE'
statements in these config options are effectively dead code.

I propose leaving the 'if CPU_IDLE...endif' condition, and removing these
individual 'depends on' statements in Kconfig.mips and Kconfig.powerpc

This dead code was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/cpuidle/Kconfig         | 2 +-
 drivers/cpuidle/Kconfig.mips    | 2 +-
 drivers/cpuidle/Kconfig.powerpc | 2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index cac5997dca50..d6d8386d3f02 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -81,7 +81,7 @@ config HALTPOLL_CPUIDLE
 	 before halting in the guest (more efficient than polling in the
 	 host via halt_poll_ns for some scenarios).
 
-endif
+endif # CPU_IDLE
 
 config ARCH_NEEDS_CPU_IDLE_COUPLED
 	def_bool n
diff --git a/drivers/cpuidle/Kconfig.mips b/drivers/cpuidle/Kconfig.mips
index c3c011af4a35..88728b2b4ea0 100644
--- a/drivers/cpuidle/Kconfig.mips
+++ b/drivers/cpuidle/Kconfig.mips
@@ -4,7 +4,7 @@
 #
 config MIPS_CPS_CPUIDLE
 	bool "CPU Idle driver for MIPS CPS platforms"
-	depends on CPU_IDLE && MIPS_CPS
+	depends on MIPS_CPS
 	depends on SYS_SUPPORTS_MIPS_CPS
 	select ARCH_NEEDS_CPU_IDLE_COUPLED if MIPS_MT || CPU_MIPSR6
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
diff --git a/drivers/cpuidle/Kconfig.powerpc b/drivers/cpuidle/Kconfig.powerpc
index a797a02b7b6f..1931ac8faffb 100644
--- a/drivers/cpuidle/Kconfig.powerpc
+++ b/drivers/cpuidle/Kconfig.powerpc
@@ -4,7 +4,6 @@
 #
 config PSERIES_CPUIDLE
 	bool "Cpuidle driver for pSeries platforms"
-	depends on CPU_IDLE
 	depends on PPC_PSERIES
 	default y
 	help
@@ -13,7 +12,6 @@ config PSERIES_CPUIDLE
 
 config POWERNV_CPUIDLE
 	bool "Cpuidle driver for powernv platforms"
-	depends on CPU_IDLE
 	depends on PPC_POWERNV
 	default y
 	help
-- 
2.51.2

