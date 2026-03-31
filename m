Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3153C196A
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942971; cv=none; b=Veoxg3S5hK3ZCX2e8xMeqEsQVVNesUKBC0QRZEY5KjZVpn1BmLGUJfzxIPoLeS++uIP/fUXWaQ2ZG1bw2fCUOGuLLOPC3sr7R2wmLsaSLyo+VbSFFc8+13CjIpe3vj0+t6FxJi36KxkZyaYxhAjHtPnvQA/grfegonTUSiH/A/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942971; c=relaxed/simple;
	bh=L7XPc/53vFUrQZfCcRv3H0GUT/8Py/FOdZhH9DFNfQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PXbEbyobtKFrRR6xf7LdFe3YXBW7cU3MnjS5903dsVgd9amA6i/OlRr/ctHh+hI/eGwdjJbaq6SEOim/VSD3kR4ku+G5u4H8VefUG0EdnEyuel+x1DUDQFsxekIOG9NioBcIP7gtCvJalC9jNdagDHARZvJuGQpWIuP8Q4hTavE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iy+xLJZj; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iy+xLJZj"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b8e8e7432so4399268f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 00:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774942968; x=1775547768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5iOl0Mz285FYoSJuYMKywDcqLaVhSu1lB84eMWBiZpQ=;
        b=Iy+xLJZjXIpcDg5wcfY3TaFpZkRr2CEwpFJUZksBmJ5rme0VXbgF2ocEJM9cdpatkY
         B6kPVArajHiXRK1LB+fW91rFEicNY2AFPbZzlE6C2Kj0QyFa8dh3wYwXwl1tjFkWUJZ8
         bfkBs0xqU5p+7IQybih9NPCGQuJ/xU11VqvBcZHnx155WyMlB6EfaqIFhmMtYDULBuH3
         7AKOgyMB/3UFqKQvus7EN7E6fFJC6qRe/bKcD08pn2JA3WbJeZO5pFoAYWiP2LqVrdGy
         fwJ8kCLKYLROMwE7TQ6pyvjJwgJWzUd5mSEcn3FxRhI9iyXRjZpCVZv5Gr61woftaLMR
         9nTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774942968; x=1775547768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iOl0Mz285FYoSJuYMKywDcqLaVhSu1lB84eMWBiZpQ=;
        b=M9S/KTZhA6yIzp6uXYapmSPpjiMlJzSuD+CEs7fOqLau7m8zWXdbeK3Ct2ckq//3Gm
         XtIKafmTZRPgf1Rt2O7d04tqATL52DyNuC25Rir6WRHf1eczuG1bw3zeR8UBXDGAYzJl
         QQZfo2axTug0ZNRaMBG8GTlT/YKMNx6w9FI5TGOXgOdd/B8bygXNJflpnwPQ27CbUV/P
         kq4KI2xqPzFARfGP/UmAu4yQnGOAXeXTz3f84qn/X/eLILQf8c9273uilkMX+ey8h3QC
         uBz3FPPg0NS9RRUphJsojmX+DLWCPNysnBJdinV3IIcqOyxuTGLISBwLdHoN3qBZVWBU
         oh6A==
X-Gm-Message-State: AOJu0Yz4NdYMPyUzEAejvvcRvyaMCFfTP2bgkjH5cYLO97ehfbl158cH
	DXsmhFCUHmI5ebPRJ0K6pkn/Q+opLeR+nDdaVIwKAPtD2iUVmgElx2zm
X-Gm-Gg: ATEYQzw33YBHLVunlwgZ8KnWi3YHLwvDd9chS9YuM8GVco/i8bGiC25ZJz9RPQ2kdlz
	Rk6WFeZx3U48C/vvB+ALsT0bD3N9wWaJ21dhMk2qOj0+2JbqJ+NqTye+3drh5ZEHzf1xyDvO76F
	44Qho7/SwfzFib+b5yywYM1kDGUybqE+o4L2gTifsCy74j2lp0JGLFD801v40R7r+ZW7abOhiXz
	xj29968JI3/2e1SDaL4//f3oZBCONNtTNlrhfwK9RR8qfuPGLYsSWV3gi34aGs1ybVLztJK7Dd+
	2sVKGdUY1Vq6lNzi70JVB3waPHUgezydxosWKXV8uPk2qnN7YLIfF8vqBxt9773dxccXaJVbKmS
	XuBuM+yWpzezBi6EhPiyi4uXXdPlBgKh2PwYYq7itmJu3px2+4N141WxfiYqngOReT5k/3gz7P5
	Wn9Js4wKhQbZ1zO+yh/0pSjpN6DsjYiQ==
X-Received: by 2002:a5d:5d0f:0:b0:439:bd70:6114 with SMTP id ffacd0b85a97d-43b9ea0885bmr26201095f8f.38.1774942968402;
        Tue, 31 Mar 2026 00:42:48 -0700 (PDT)
Received: from nixos-office ([2001:8a0:e95c:5e00:f8c1:fa51:743d:7994])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e29b1sm23499630f8f.8.2026.03.31.00.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:42:47 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] cpufreq: cleanup dead code in Kconfig
Date: Tue, 31 Mar 2026 08:42:42 +0100
Message-ID: <20260331074242.39986-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is already an 'if CPU_FREQ' condition wrapping these config
options, making the 'depends on' statement for each a duplicate
dependency (dead code).

I propose leaving the outer 'if CPU_FREQ...endif' and
removing the individual 'depends on' statement from each option.

This dead code was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/cpufreq/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 78702a08364f..db83f3365698 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -163,7 +163,6 @@ config CPU_FREQ_GOV_ONDEMAND
 
 config CPU_FREQ_GOV_CONSERVATIVE
 	tristate "'conservative' cpufreq governor"
-	depends on CPU_FREQ
 	select CPU_FREQ_GOV_COMMON
 	help
 	  'conservative' - this driver is rather similar to the 'ondemand'
@@ -188,7 +187,7 @@ config CPU_FREQ_GOV_CONSERVATIVE
 
 config CPU_FREQ_GOV_SCHEDUTIL
 	bool "'schedutil' cpufreq policy governor"
-	depends on CPU_FREQ && SMP
+	depends on SMP
 	select CPU_FREQ_GOV_ATTR_SET
 	select IRQ_WORK
 	help
@@ -365,6 +364,6 @@ config ACPI_CPPC_CPUFREQ_FIE
 
 	  If in doubt, say N.
 
-endif
+endif # CPU_FREQ
 
 endmenu
-- 
2.51.2

