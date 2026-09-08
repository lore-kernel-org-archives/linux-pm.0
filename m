Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2228453D0A1
	for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2026 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871059; cv=none; b=GR0Z/Segj5axtH8saiDN8f9onZ3/EyddZJHK/7UI8kHgBNW4i9MiMxy2iS9U7sjZsXWHCmTFGzzn92g+XZ7zNK/BHfGwQPmw9mglhBCEivhuNizqBC/6Aqz77tQm02BoEEhijNVynvurnQ0Ixw/EhD/CoVlMGIe8wy9RkrQdY2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871059; c=relaxed/simple;
	bh=dy9Ewq/CCAs6X076BbDVqr9zqeeUDWMtH8Rg+kR+9Fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U09/9o1iY567hiOa45ZQogz7+7+kWkMS2DLXCnDpy0g3qCrO91DrBWozUz9K4cHUOwmJGbvjZOH8cQ3mDPaC44zN6kf8U+DKaBRyi9uFSyPmJx7fdtTUcAUxSCi4dvZ2FlejLnIyEH+LTqgK+6xhtAkj9vkIM+nPXr/MNd5h3YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xs6F/yoD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xs6F/yoD"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c197e7e4e94so738547666b.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2026 05:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788871056; x=1789475856; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jXDH8QZoI3ckH+lQsjWcXyDggsWx+AqwtOXNe3U0sBE=;
        b=xs6F/yoDVqpUWcOaoLvAXrQvh1pkuISC8QDJzTDOz/3i9XinJkfJAnTCsFGZ/LEywc
         t5DsVJYFmmhNwVlLQQgMcCBXKzo8+NyOaZjvBaOiw5ckyPlazTShMBNDOi5LwXoRxYPF
         zbmSvsaoT4NCqpXT13XqFw7OdUF+anQQKrXI//Q91670oqzRft+JGK1IT/pLjYTvXP3B
         wn2W3pJlbqMu2aWfI3LNV59shxzyRpEKbHYIMcjLtjTi3ks0lrVWW87FFnRWAhPr5WKd
         CaewtD4LjUR5VpkTfu6uhHR1IGyc6gGsbs13jmmc+IkuHxUzcGWzPqLDx3x2JYgj83Ay
         b1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788871056; x=1789475856;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jXDH8QZoI3ckH+lQsjWcXyDggsWx+AqwtOXNe3U0sBE=;
        b=mu4cwGKb2fvG+vRO6f5oWqfyXjEPFXIhlxeK1SJxauQFvDkiKsdvalnmNXy6BgsZho
         ZXQrK0wurC3oS0QeZ4U6e77+EZhOUzlt3y0uMWBKPwNlopbsbjIzA3ZGBdqzPE97NZxT
         fzvG1XUi8Zn6PcDMk7ixpzruBkxloT+7R3wR7f0Lm4IvGS0ooWhYijldLyiZUkOW2h1D
         wfu+304cesFE2QuCkvgf43S+bmH6BBRzCWAGc01UHTWZfAuxpDlGUwAmTzjzokzx4xpT
         tl8H6EhzmDr9+amLIPjBtAGcRgYg4dq/+EKc1Nyh0sQG4ORRlWUhbeWi4mSazFRQLgAE
         7Ebw==
X-Gm-Message-State: AFuF++lrw5eXb5N6HcYvcnK0MxtZoiltG5VKjCy7wDqNfHvZIGFLcGjN
	q77mFcXGCVn1cP6JFpx7Rdeu8p3xD9iR3J9AM62xgzBn+Z4QFrhPV1+02ZjXk3npeBY=
X-Gm-Gg: AYBFou3CYOcR7hWB4NUv5NWyz64bJS7Onh0iOHTHRvepdGYRZk0Zxsd+jMnncXWrjY+
	uKUFvGdqHheU1J80x3ADik+WLRzKerE4VJvUlme4bQT8eUfJ3j+0TH17hLJroe1+27jJ7muEnXr
	FexSUjGIa4fJHrDmRQI43vZWQgZF/9/FDghzRd1wjXUgR3qLJSTC6NYtEG+HzhsAZXcaiRxVAUo
	zbcUmhYKUWscpnySgfewD1RKkh25k9WdB1ItWBh8cRJkhyfaPLwVpmIZ3Rb1c+v/3d+by1wCIQr
	IfAGBLeTfUuuH2LhDXd54JYm5O4WtT8jsxqTCHctNoBcm5Pn4/S2KFS0zZwPsGnQnsR1OvuWO8C
	VW8ov051wKi0ZHyzt83jPfg+5FYkaMTRxxVgY/A9tQsnuH1CYVylE8OQOOhRKfMhIWsTKbuax3C
	5fnNs3OMZ2N5oxbTMQj7ucihAMGAjgMNLEeMvBWGyvfBQST+EOcdGJnYP63rYSHaqbI0WZi5MKv
	QOwOIwgWIcX8gqIBcoIEh0qj4o+dtzOk05yD09MYLD/aQyMuPLyZcc=
X-Received: by 2002:a17:906:730e:b0:c20:af9d:4533 with SMTP id a640c23a62f3a-c260c9f74d6mr1126754866b.19.1788871056023;
        Tue, 08 Sep 2026 05:37:36 -0700 (PDT)
Received: from petegriffin.c.googlers.com (116.118.90.34.bc.googleusercontent.com. [34.90.118.116])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4aa01dsm620301466b.15.2026.09.08.05.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 05:37:35 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 08 Sep 2026 12:37:27 +0000
Subject: [PATCH] opp: fix use after free in _update_opp_table_clk()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-opp-core-uaf-update-opp-table-v1-1-93d3fc928c5c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIYBoGoC/x3MQQqDMBBG4avIrDuQxNJqr1JcjOa3DhQTEhVBv
 LvB5fcW76CMpMj0qQ5K2DRrmAvso6JhkvkHVl9MzriXaU3DIUYeQgKvMvIavSy42yL9H2x8C6n
 fT+tqS+URE0bd7/+3O88LHutCoG8AAAA=
X-Change-ID: 20260908-opp-core-uaf-update-opp-table-0d9ea3741231
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 andre.draszik@linaro.org, tudor.ambarus@linaro.org, alim.akhtar@samsung.com, 
 krzk@kernel.org, kernel-team@android.com, jyescas@google.com, 
 Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2239;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=dy9Ewq/CCAs6X076BbDVqr9zqeeUDWMtH8Rg+kR+9Fg=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBqoAGP0Ra3Z3Gt9ya7IDfBGoPtgjNPxBPQu/+H3
 /zUFBvO5l+JAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaqABjwAKCRDO6LjWAjRy
 uq3tEACDxDprQa3RAcU9D7xZT7Mr1xl10hohSgz+2R84eC071OuqSk0rcIq4iFhSOanTGy2lvpW
 /sbmhAOfcH/Q+4xgxu5DzDRzFFS5X4vvOlPjl61nw7VQU3f0OGcnMUuR/xUeGe1oUzQQ8ZvhlnH
 MDYSPTJz8tHlXslyCPBo3w4LRc+Af5mdC1+I16bv1mywrtR6IhgOHUE7VszioFDe6WxwNaPYwn0
 +X54sUUh04MrToo0P+799k+2T8DsEgtSIuyzJT7YDG918drS+48MdGqUrPSU5LyutugR5a7ltkf
 VAfYn/6YyLGFV2BHFuJptdoRNinPVgWQDAYgA0jSSxaQF/PIk8clwPoMGbVxKoHBSTmj4WG3a8Y
 mjOIjLaFVXh3eHGkGtbGNEx46Wq80sv/EScRVraDvxKNlrmdCcOnHIcClqC6AcC8rDnG8T4v115
 Od815dnxzVNmjfq7e7lnxrN3CFNpOX5H/NVXusF5yjJrK5c46WoqyuNmYU6KiqUv2M6D+9qJHVL
 rYmsZu/F769baNtgXHCzaYe6CD2Qbl4M3nyPN1xOmC2xeyncTdSnIsEbI8XBZu0hp3XnsUoypKX
 bGcDbsbqHiTtgch2FO4SOgcTeDACZMXsFZwFx1IDKlG7/UUdB/CcN98f8NY2AYZjhnI4djMK+LM
 pIA53gI3b4o6ozA==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

dev_pm_opp_put_opp_table() frees the opp_table which is subsquently used
by dev_err_probe(). This causes an Oops during boot on gs101-oriole.

cpu cpu0: error 000000006b6b6b6b: Couldn't find clock
Unable to handle kernel paging request at virtual address 006b6b6b6b6b6cd3
...
Hardware name: Oriole (DT)
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : _of_add_table_indexed+0x80/0xbb0
lr : _of_add_table_indexed+0x6c/0xbb0
...
Call trace:
 _of_add_table_indexed+0x80/0xbb0 (P)
 dev_pm_opp_of_cpumask_add_table+0x70/0x120
 dt_cpufreq_probe+0x23c/0x480
 platform_probe+0x64/0xb8

Fixes: 84f05af0975c9 ("opp: Use clk_get_optional() to avoid leaving opp_table->clk as an error pointer")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
This UAF regression was introduced in v7.3-rc1, and causes an Oops on
boot for gs101-oriole (in part due to our default upstream kernel dev
config having memory poisoning enabled, hence the 0x6b6b6b6b
pattern). It is intended that this patch should get picked for the
next -rc.

Peter
---
---
 drivers/opp/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2fafd983de8f5..c8b941cb81b44 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1581,6 +1581,7 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
 					       struct opp_table *opp_table,
 					       bool getclk)
 {
+	int ret;
 	/*
 	 * Return early if we don't need to get clk or we have already done it
 	 * earlier.
@@ -1607,9 +1608,10 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
 	opp_table->clk = clk_get_optional(dev, NULL);
 
 	if (IS_ERR(opp_table->clk)) {
-		dev_pm_opp_put_opp_table(opp_table);
 		dev_err_probe(dev, PTR_ERR(opp_table->clk), "Couldn't find clock\n");
-		return ERR_CAST(opp_table->clk);
+		ret = PTR_ERR(opp_table->clk);
+		dev_pm_opp_put_opp_table(opp_table);
+		return ERR_PTR(ret);
 	}
 
 	if (opp_table->clk)

---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260908-opp-core-uaf-update-opp-table-0d9ea3741231

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>

