Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BED74508E0;
	Wed, 23 Sep 2026 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148243; cv=none; b=Ua0r4t0Whkaf5nmopEGhh5nIKq2iMGL7AHdT1lECjf1jb55CUfAkX3SS1JSGmczQJUYtsn/I44MQMxF9uRgAWUxIWI1lJX4pBAdWYJGwPEP9sEkkngzccKC55PX2LVhDLfu8ZojZQJV4PbTxX4i9y71M1jdxjf2oqw7hbz2cgro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148243; c=relaxed/simple;
	bh=8qjNV9QZqkvKmCjMRy1A4HY8U9aaXcxKtUE7iWgaDg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WVk5SCev1WOIyY2nxeuF850jJ5vNAzQZm5HWokNyuRKAl+VycKiy4W9N6nN1MURrfFxrD6HQfEksvP1idX1fN8FNPAATkdDcqKCVs3CadsnvCirLX6c9Ef0ZWoCoNyWWO6haI+1nAM5jCnMHhp6VcW5K9vBjcViphHyE/hzleag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qy2f5CW7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qy2f5CW7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D34A1C2BCFA;
	Wed, 23 Sep 2026 07:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790148242;
	bh=8qjNV9QZqkvKmCjMRy1A4HY8U9aaXcxKtUE7iWgaDg4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qy2f5CW7rUNsHtY88qMWoL+eMP1gyYT4bSOqNpLQJ/srgDXyaRW/LcumAq3UIQtAT
	 gDQxgwVZcdC1no7OygDnwyBbOg9cZbAS9pOUZS7/b+0+EWT6dlbLTEsMVg2dYDlqy4
	 qkQtQ6iLA8xKE34eIXSiS8b9E5gyoQmQJV9pXjpS+6jYBvUJv+VqeG6dgHKUr9NkO7
	 jZ5UrRJbPhrYIt1oPHdXDzBu9/LzA6+tAnl8Bmf0jelaxYoUW1yBfbW1KerwJhs5V1
	 HFDuM6VZi3ZaK5wOVxY697Vc3i1fTeeiFWoQRyN7ybPdRtznvTjiXTTL6NhYSbxEco
	 0hz4j4W+vh1ow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC65C982FA;
	Wed, 23 Sep 2026 07:24:02 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Wed, 23 Sep 2026 10:23:36 +0300
Subject: [PATCH 3/3] cpufreq: dt-platdev: block the driver from probing on
 MediaTek mt6572
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-6572-cpufreq-v1-3-41f7af6d6d1a@protonmail.com>
References: <20260923-6572-cpufreq-v1-0-41f7af6d6d1a@protonmail.com>
In-Reply-To: <20260923-6572-cpufreq-v1-0-41f7af6d6d1a@protonmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790148240; l=803;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=pvNavw1TwxmxmNAxfAHmYvDXdUUIz8P51+5XyRZ6nPo=;
 b=YsrJCy5QZyZQ0x8+C3yQqVv16vsP+AsTxbfCOEpZ0WJhlCdxzGXzd1uQ5BVb3/jeTge8q1/k2
 laGs8FQ7FQ8Byo/4hbiF1LPi5WxV62mitZXUae3HxZn9/6QXtWgWCY6
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

MediaTek SoCs use mediatek-cpufreq driver instead of generic one. Add
mt6572 to the blocklist.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index ff1204c666b1..ff7fb61eda74 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -132,6 +132,7 @@ static const struct of_device_id blocklist[] __initconst = {
 
 	{ .compatible = "mediatek,mt2701", },
 	{ .compatible = "mediatek,mt2712", },
+	{ .compatible = "mediatek,mt6572", },
 	{ .compatible = "mediatek,mt7622", },
 	{ .compatible = "mediatek,mt7623", },
 	{ .compatible = "mediatek,mt8167", },

-- 
2.55.0


