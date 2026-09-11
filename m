Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714454BEE38
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 22:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164970; cv=none; b=l5oXj6feEY95VJ0s8BVYS2Yi+cYngLIX8U+zLi+7bJIqWb6pdHNb7ARCBuPnZQCZ/7E/jWdoz5TzAvrZCSf6tM+qlUTNQjfN63ywI6PKjdnw6MJwjlfOpvfV6ebhsQa2n7WVirykuBhP07wvmi11PpZBwJLZLutAviD40NuSJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164970; c=relaxed/simple;
	bh=l8mADb+Y2yJIN8p3uP3JWJwbnT7nygcjOlWwdwR5qNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sb4V0rRE9NeUT31aJR6lCpcukcZcfu26NM6WMi2ApMXBwXdbIJ41uHA3YUQSks7OEQbqQz8oLlzRpAjJvjBQTIk45cApnxlM0rj8/WRmOLymqNWNkB61mf9RpbN+1nDOduGTUs81n3X337+u4lmS0WOJRWkjHn0k4Uj+vRWvz4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XshqTX1u; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XshqTX1u"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so33186f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164963; x=1789769763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t+j0SrUekwQLNDLTVAcq+UzhhLckFM631ivmj+fcOdc=;
        b=XshqTX1u8dPd4HqgausPehEcLSdVr3cVrZaCEQjwQTXK7aKozWon85fpY+YHQXdo1p
         eo+JtdSw+ZdH7fm9l+TMvd5sQEgwoVsUFGmV/eXtfywkBHtrWPZvB8z+79YXUoZIC1TQ
         jUHzsAtLlhZBcqkF8/FEhAzFo4If57LMdKfEEbfxeZJAlTASn3nghr9P/4ATvHoBYjJn
         zX7kQqxi7ln3pP7CfCen7XlY40wTfF0ePyF2eNAqtZZ2u1EaaXdPuGK+j2ZnPcgrrzfH
         D4CMth8QZ+135MrVfOW5oRlRC2oNeReg30d4WvPlN1xPFKWmj+EV8Lamx58iU6hRJrFv
         UpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164963; x=1789769763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t+j0SrUekwQLNDLTVAcq+UzhhLckFM631ivmj+fcOdc=;
        b=i9eSe3mzODB45JAo/WFEa0/vKtK24xAaazUb5UMfibeRfkkYeJw++Dkw78lijLXKAY
         dw+DJHCdVoKY9fWEsLh1LcoH19xy3AzuWMioolFgTYQwniCXvzHQit/gAb1I7KVm1Tok
         BtDB2QWmy6kqQOWyvr4+Sjvdfb7DBTM5DC7I5LY84BxSh2INIjfO8FHodOxCOMxxtHw7
         29MXI5uMxxZ+dUSGC70gmLYaGwsrAPftbO1M4/bHaYqZ9G+DTUyZuSbivOSeErBb9TCs
         QS212VXA19ejCaMszcnbBeTd2C2tj075iQUOkzRKglVeeT1IvAOnQVAjsmU42iJV+8/2
         SUcA==
X-Forwarded-Encrypted: i=1; AKwUvBxl0Ftb0wwRfDBPLrKqDJx1A+tZfg31AWF9Q/g7ALbevM2SUc3kyfDJiIpQ87S+pprbRmh2xJ5Dpw==@vger.kernel.org
X-Gm-Message-State: AFuF++kmZN8J6WBTV53IFh9Erj6mbYIYERFxpQx2p+nq7lX8xi3fNY1z
	yvvxzIZanNUpyuwrNkNmxPb0rqEzgOAk53qsR95cVWXwDknVTkpFEmHi
X-Gm-Gg: AYBFou3dz+Vg5ytOaC4L7w/NassDrI7F3M7KADK1kTHjErDH9LG6J7sTOzpr2WYi9p4
	tsvzjc11fhaMx9vyop7uSHtNksusjHUWTPQLhz8Cw9BDokpS5LlLvo8ipbDSoLfAksukbiHvuKl
	ne0mCD/QrC8WKQjN+1o2oxp16HnRQAMHsVIFdbp3le8CV7symnWD1RZ2um2YYRgdQez3FH3cDNd
	t/NF1262N6RAeWsfNe/lYJv2Y1hAvkeXnYTea3hiPYR8YBCLQxWToBQWccxtlTO2gasdJ/0bAKQ
	OXv0d9sQyMOmiqZlgb9FrNdpLNSWZlk/SYHFejLLuPZCG9+P7faJL2PbRIR16ZRJIi/M/Vnuuco
	qDckhBCbsiOOMZTuT2hqOYBDITxjbLCkKA4BbwZgWbj8WQ+98R+qcJROfZ/PC8syr4INyZ7h9Nh
	wehqg6YieJmbe90OPUkrcciIMq8yeAF2cAekg70GRDBNFkh7nuERKSYTyBGEeyQ3O7BoIYzIJ/F
	4RjSvS2AbXhwKuKFr7/oaW1FOnbNNHBbiqP10CIuDzKDA+8R0u37h/yb0gIfAlcUK0JlJbMTrWI
	IkgQfxtRqih/LYWfR6cmVXc1m+7vHBN7nSWr
X-Received: by 2002:a05:6000:2002:b0:485:8c17:9767 with SMTP id ffacd0b85a97d-486f6c4422amr430995f8f.41.1789164963122;
        Fri, 11 Sep 2026 15:16:03 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf2esm9696719f8f.2.2026.09.11.15.16.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 15:16:02 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
	Jordan Crouse <jordan@cosmicpenguin.net>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: Fix the return value in dev_pm_opp_get_of_node() kernel-doc
Date: Sat, 12 Sep 2026 00:14:43 +0200
Message-Id: <20260911221443.7139-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev_pm_opp_get_of_node() returns NULL when the OPP is invalid, but its
kernel-doc says "else 0 on success", which was never true. Say NULL.

Fixes: e2f4b5f8dc59 ("PM / OPP: Implement dev_pm_opp_get_of_node()")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/opp/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 2f3bbde9a9e1742a2d6b40be91a65d8fa7365bf3..ea93800795783f0595483742c0c10de42b25518a 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1409,7 +1409,7 @@ bool dev_pm_opp_of_has_required_opp(struct device *dev)
  * dev_pm_opp_get_of_node() - Gets the DT node corresponding to an opp
  * @opp:	opp for which DT node has to be returned for
  *
- * Return: DT node corresponding to the opp, else 0 on success.
+ * Return: DT node corresponding to the opp, else NULL.
  *
  * The caller needs to put the node with of_node_put() after using it.
  */
