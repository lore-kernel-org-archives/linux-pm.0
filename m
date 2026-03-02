Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13B9407566;
	Mon,  2 Mar 2026 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468965; cv=none; b=IYAHytHhosdhTDHvRjyfMwbeBLtgF7wPRlZfieBn5QwmtKnvqyDHPhUkFRLwSu7pdnMjAMrMD7Xp5nlnJRnejS5WTuBE9ISK4Pkec85d3Mdbs1ddAx6C1NOMZoD3hCKUCaOyEVKoJNokGnTQdeGHFlGNt9gAilhJ4+U3pB3aFn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468965; c=relaxed/simple;
	bh=j0nghKavfgGKqIjOQAxB28jB0MbHHOyVxmtOg9K4sAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3t9bSMFZru99eSFIhrYIIwYqf+giUp912t8CcvdmKADQKlvCfmOFDRJibmpr4PDbxEwhPTIlEB5lBwTYN+xmdExnGDDSL0gLLsL4DvhmmQ5tGGxs54pIyTWJJCLEEU8iqOB10XCfPxH6Ubd/U3eXTMxNrtq7sIbfK5A0oemKis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D96C19423;
	Mon,  2 Mar 2026 16:29:22 +0000 (UTC)
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
Subject: [PATCH 2/7] of: Convert to of_machine_get_match()
Date: Mon,  2 Mar 2026 17:29:06 +0100
Message-ID: <83ed49314b94dab7781e1d74236af72dd5c349c6.1772468323.git.geert+renesas@glider.be>
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

Use the of_machine_get_match() helper instead of open-coding the same
operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/of/base.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 3f061f10aff8fca9..39e751df9daf689f 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -504,15 +504,8 @@ EXPORT_SYMBOL(of_machine_get_match);
 const void *of_machine_get_match_data(const struct of_device_id *matches)
 {
 	const struct of_device_id *match;
-	struct device_node *root;
-
-	root = of_find_node_by_path("/");
-	if (!root)
-		return NULL;
-
-	match = of_match_node(matches, root);
-	of_node_put(root);
 
+	match = of_machine_get_match(matches);
 	if (!match)
 		return NULL;
 
-- 
2.43.0

