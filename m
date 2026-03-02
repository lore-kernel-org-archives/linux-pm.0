Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D623421884;
	Mon,  2 Mar 2026 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468984; cv=none; b=dnnk3AJU1auQpovsBkamgD910/10HE3rhihbTyNPVufu87e+C+YqKObnhzBwUuzDIwAo/evRLtOKJcXhBFAnu3p/19kgJLBGsGnvF7zP4kwe8GYDGZZyynvwbDumGrqGu0wBrs396hYxXnXjAACj6JN+wXx2ymIQF6honHgXkoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468984; c=relaxed/simple;
	bh=H699tkmcb0/p+AtH2UBRINNfPTDUWZvLZ/ClznhC4k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bm84XURTGCzEPmmH7uQkK2QvT6M0fpqh7QFXw9hBt0PmZFuX7sGc0rMhce1185rBfuh81yvwlrHulJyIDLdG+UJhq8l7TY3aJ0tIa2rP9Z5wFioFAVq8ZG+BMNnQeC+GgnRGou77FAG7TrDvX/5sRyrzbTnMlLqELNwMV55pLnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDA3C2BC9E;
	Mon,  2 Mar 2026 16:29:40 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ilia Lin <ilia.lin@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 7/7] soc: renesas: Convert to of_machine_get_match()
Date: Mon,  2 Mar 2026 17:29:11 +0100
Message-ID: <10876b30a8bdb7d1cfcc2f23fb859f2ffea335fe.1772468323.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772468323.git.geert+renesas@glider.be>
References: <cover.1772468323.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the of_machine_get_match() helper to avoid accessing of_root
directly, which is planned to become private.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is an alternative solution to "[PATCH v2 8/9] soc: renesas: don't
access of_root directly"
https://lore.kernel.org/20260223-soc-of-root-v2-8-b45da45903c8@oss.qualcomm.com
---
 drivers/soc/renesas/renesas-soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index f6c41892fbe549e8..bcba01acf283003d 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -488,7 +488,7 @@ static int __init renesas_soc_init(void)
 	const char *soc_id;
 	int ret;
 
-	match = of_match_node(renesas_socs, of_root);
+	match = of_machine_get_match(renesas_socs);
 	if (!match)
 		return -ENODEV;
 
-- 
2.43.0

