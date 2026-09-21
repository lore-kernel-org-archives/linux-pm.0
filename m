Received: from mail-m1973196.qiye.163.com (mail-m1973196.qiye.163.com [220.197.31.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FC6495ACA
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994199; cv=none; b=mC37FalV1j6EV0TwM4uH53LX+noD+F+JqjBINZmQgKwtAwWHvgFGZJV1moJaYqF97kTrdSHtRp9ibbL4C5zVfwY7blMy0T70kTE5KClnuM0tvyNfuyS6RnAYWI/zBiiDnS4ANWR1wYPDz6Gn7dg3hj0NbRNSlS/dEGPIJkAYtRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994199; c=relaxed/simple;
	bh=HQZcb+jur+Lwp5NG5XaZ0NPMNawCttD0+BBb/9UouLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mzdSmidXD/3ryhM5Uvt6hdf52JLsjM/hh8tIxBatmAr/wDKqq7nOep8DtbEbbwvspGdR5/OB0wjnRsS2fUWyOsM3PXP8HMfRNRkJD95sY/g4RsMJ9dsiFWrY+jlpLRFuCh/k1nM/vmC7EqW1hol54OL87HSYp6lEDJa2gYcD4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=T7hTaZcQ; arc=none smtp.client-ip=220.197.31.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="T7hTaZcQ"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e889c037;
	Mon, 21 Sep 2026 14:53:30 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 2/4] pmdomain: rockchip: fix clock leak on domain probe failure
Date: Mon, 21 Sep 2026 14:52:51 +0800
Message-Id: <1789973573-151146-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1789973573-151146-1-git-send-email-shawn.lin@rock-chips.com>
References: <1789973573-151146-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0c2bdbe9403a4kunmfcbddeea30c369
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZT0hIVklDSR1MTxpMSh4eTFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=T7hTaZcQBtqY23/gHX8yFy/OD/oSPWLeJvL8A1QyIFfqLNvwbTcHUoOnJD/GHjqAEpmkNvrIEBEoFTHozNINweyXVQnZGWDT5/rnQJ6Kkqy1+nIDMw1fv1D5DcW+p7fbZ2xT9P1K/rAg1aClOSOu4FSUpYBBnpRchG66frn9uVQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=YZBpSxvjQnOmwoOiy0D7uUWIiEP3fUbB+iN1q+GjoLI=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

When of_clk_get() failed in the middle of the loop, the references of
the clocks acquired so far were leaked instead of being released by
the error path.

Fixes: d909072d0521 ("soc: rockchip: power-domain: use clk_bulk APIs")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---

Changes in v3:
- drop the devm_kcalloc() to devm_kzalloc() switch; kcalloc() already
  zeroes the array and takes an element count, while devm_kzalloc()
  does not.

Changes in v2:
- add Sebastian's tag

 drivers/pmdomain/rockchip/pm-domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 068dd4b3..b6b099b 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -842,7 +842,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 			dev_err(pmu->dev,
 				"%pOFn: failed to get clk at index %d: %d\n",
 				node, i, error);
-			return error;
+			goto err_put_clocks;
 		}
 	}
 
-- 
2.7.4

