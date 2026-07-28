Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AA821ABB1;
	Tue, 28 Jul 2026 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242073; cv=none; b=FaYt70iG6TpHYiTqDo+SK6LpKT9PbTGPr9alHiNZ5jmgrDIe2f12VZO+LYHIdpLJtoy9hKzcEEU41qzYori1pJjT0tqZyiimrNenPE3Q1Io3qhuY6Bj+3HeoWK73W/+6n9kHdT4W5tMrgb4NLPtzH8ExlC2KO04h12D3K3SS1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242073; c=relaxed/simple;
	bh=cq8By+onjc7G0sT1xcu6cvx+PeB9M9khoJmS03LO2aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mh8zMj5TwdOspYUqZ4Ch0yXDg0sMtSewSns5avLcVvpTnOeTtDawBxhwMWjo58Q7e9/qa78ylH7vn898WPTxNcqyvJ2QcL3h3mUDeS76kYiQlkTzLDN0MYzWD6Je3kBwMEKviDqnj74znFHonRPJh8j95cmf1NmoYfyRlWfgl/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Q3GgFiOV; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Q3GgFiOV"
Received: from LAPTOP-99KJFSET (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47e10a90c;
	Tue, 28 Jul 2026 20:34:27 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: pali@kernel.org,
	sre@kernel.org
Cc: Hongyan Xu <getshell@seu.edu.cn>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: [PATCH] power: supply: isp1704_charger: cancel work on remove
Date: Tue, 28 Jul 2026 20:33:39 +0800
Message-ID: <20260728123423.781-5-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fa8b823ef03a1kunm4c64fbaeeecf3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHkpMVhpDTEwfSx8eTRoYGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=Q3GgFiOVbNnYMnU2ghe64PLqjE5Rcgzl8b65JhfRJj0xYPhYJ5bawJNTmyvsf2/r4E+8rlkkm5rJXBeUfqIDQ+DypaNkRrtRNvUlT6uhqwzTcPtevbQkVnjKr+5Fz1iir88sV1B1ThyS4RH5VBOtJT6rbSJmZlhzuAgMEKxYDEM=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=T2VZqykQWxRh/ZsXxwlwhW1YJCHgRs7qOasexClzMGY=;
	h=date:mime-version:subject:message-id:from;

The USB notifier and initial VBUS detection can schedule isp->work. The
remove path unregisters the notifier and power supply, but does not wait
for queued or running work before tearing down the power supply state.

Cancel the work after unregistering the notifier. Do this before
unregistering the power supply.

This issue was found by a static analysis tool.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/power/supply/isp1704_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/isp1704_charger.c b/drivers/power/supply/isp1704_charger.c
index 237912a92..e329321d0 100644
--- a/drivers/power/supply/isp1704_charger.c
+++ b/drivers/power/supply/isp1704_charger.c
@@ -482,6 +482,7 @@ static void isp1704_charger_remove(struct platform_device *pdev)
 	struct isp1704_charger *isp = platform_get_drvdata(pdev);
 
 	usb_unregister_notifier(isp->phy, &isp->nb);
+	cancel_work_sync(&isp->work);
 	power_supply_unregister(isp->psy);
 	isp1704_charger_set_power(isp, 0);
 }
-- 
2.50.1.windows.1
