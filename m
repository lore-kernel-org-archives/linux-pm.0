Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEE74FECC3
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328818; cv=none; b=tzhZIOoPo+jxC8e3b0CFxvP43uZ0nbzHt4rbHVxPkrxTeSFgHAzHk4cxCjMsrC/qZTJK7/WbJV3Ft2TWW/lYyyXuwOSW+0JkHVnIDqA1o9BizMIK8oOCx/4OqUt3HOHbmqMuGD5ZHAXwparRXd6Uwsidh4LbZA2fmg5PN3fr9F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328818; c=relaxed/simple;
	bh=yUdy2A8nvym2Ev4BV4bNz7ogIY937aa1By8o58LvKFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdKx5ebRkQx46gRQ/FZDbytnUY/zwwV/Ly2HS5LFf2+sRj2AHj702J1rBU41YVx5t+CtlEvdw9s/qltOAfh8MhpExFA9Tm57dnbmZrAwUjSGdNE4aEZ6TmvYWneHpdnmCFnUz5nJzm3kYQfmHSA3MhF5pcVgY8hAcPsHo+I1Izw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rg7fwMvY; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rg7fwMvY"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15dd124bbe7so216059c88.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 16:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791328797; x=1791933597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KMr+syj9Sj6lk34GvK8oCOH9vKPvZo7PZuO82URtmYE=;
        b=Rg7fwMvYmwqE4+cnCE+MfRqoIyU2KTlqSSmF0xLWdVUh1J3WKK8UTvtgVY3D1icaTX
         LnBowlAGo+oPHrlP/d1tn1OBNyakOl/0jlNqtD9cTe40C2t0WHbwrXrTqHxLhP9SAQXf
         KMSUZ+Zum7zUuYDH0/P2XogLAESFqAY+Vjxss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791328797; x=1791933597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KMr+syj9Sj6lk34GvK8oCOH9vKPvZo7PZuO82URtmYE=;
        b=HKl2AHeWZkL3A0Ax+2jm1ILQeIzmfW4RJAwGTzVcQhrV0QeDsfMj8d+x2EqGg/ZRhZ
         whidUwUCiPAtJevPNBfnWTkBnIT+Uanppxek7jdHqCJQusKMpErvfzJ+fc2cfwlWT50O
         24C4cqUQQv8B6IhRdZJJVB6Z0qHNwEoOYFR3XPwK+MjCZV3d3sdkZgrUxNyB2/6RJ980
         kDDVZKQMNNk2oJzzSqGbrpvYBv/xvh/UUKy0DfUnTUfFm9luxpinKaEimqrvU25Ko4e/
         kNrvotpa465xOIj8lOvEdK5b/3LT8s89QO2FrA9p8/HLabLNWNmu4uIkmc3ahpJ3Cvbt
         hfuA==
X-Gm-Message-State: AFuF++noZSD3sSZ/k9bPTzuqrPP8NiBsaVgGPSlHOIaNQ9DksQoJYQgt
	c1xxZ8V5eNPk/yFzLueTTTdHBxskOVc5DVnx+U3da4RcnzJY7efl+MeuqV+6hibHnw==
X-Gm-Gg: AYBFou0g0O65xGBllLafJtSNV28Rogs1vYx3Mg+V/pE7tPhP0L2kx29XRSJulFaRkrQ
	w3nCrykVtXN1C9lVV760zSpIB465d1Gdbb1C+S5mn1ha6hUQsfYkDGCaGjLz02dUmC3Txw8zw0R
	5nwk3WG9EVVJ+DPpvkfEtGKAqCHLEBFLiB63c9EggdEcislRo+tv8kO6ShWCLGjyBHCaUa5zoI0
	sWc07/0AevLl8lloxkpH8SzHFE5VKb6Y7T7pVyu8KuYstW6Vl3SKCLeuDaZHbMUDrhZA53iaHb8
	YQKCaL9Tuze/lJQVkihisIIbaYyP4xMVjHoRQ30ObU7A0h0R4V8mGrzgCeFHDYp2/MZltwh7VDT
	hiA+0J2x5OhOipSwhExHgvFDsQKNRqlZNA4YZAyz4hNxJjqJgw7HpuLDFct1kxxJFSdfOnr+S2f
	yTtZZgvJEvy2RzwylrBIasUzFCsZURCOGk06ypTB3CR37dcjPl6hmtr+Bp8Mo/vSrpC2jh8t8GK
	TOjVO/AuvSCL+VB2a6ks7MhbcO7Li+4YxjfXA==
X-Received: by 2002:a05:7022:69a5:b0:151:2e62:fe5b with SMTP id a92af1059eb24-16206e105f1mr405998c88.22.1791328796966;
        Tue, 06 Oct 2026 16:19:56 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:63eb:e7f9:1d47:7d47])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-16166121f2asm1806889c88.4.2026.10.06.16.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 16:19:56 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH 05/13] pinctrl: qcom: lpass-lpi: Discard pm_runtime_put_autosuspend() return values
Date: Tue,  6 Oct 2026 16:13:33 -0700
Message-ID: <20261006161337.5.Ica4bfaf179a86c8d77f8f845826602914b81181b@changeid>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261006231900.3230373-1-briannorris@chromium.org>
References: <20261006231900.3230373-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Passing the pm_runtime_put_autosuspend() return value to callers is not
particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

Accordingly, update the LPASS LPI pinctrl driver to simply discard the
return value of pm_runtime_put_autosuspend() and return 0 to the
callers.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This patch is independent of the rest of the series, except for the end
(changing the return type). I expect it can be applied by individual
maintainers, and we pick up the end once the dust is settled.

 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index 5fd4a4eba654..b93f661c36e5 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -76,7 +76,9 @@ static int lpi_gpio_read(struct lpi_pinctrl *state, unsigned int pin,
 
 	lpi_gpio_read_reg(state, pin, addr, val);
 
-	return pm_runtime_put_autosuspend(state->dev);
+	pm_runtime_put_autosuspend(state->dev);
+
+	return 0;
 }
 
 static const struct pinctrl_ops lpi_gpio_pinctrl_ops = {
@@ -164,7 +166,9 @@ static int lpi_gpio_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
 	u32p_replace_bits(&val, i, LPI_GPIO_FUNCTION_MASK);
 	lpi_gpio_write_reg(pctrl, pin, LPI_GPIO_CFG_REG, val);
 
-	return pm_runtime_put_autosuspend(pctrl->dev);
+	pm_runtime_put_autosuspend(pctrl->dev);
+
+	return 0;
 }
 
 static const struct pinmux_ops lpi_gpio_pinmux_ops = {
@@ -261,7 +265,9 @@ static int lpi_config_set_slew_rate(struct lpi_pinctrl *pctrl,
 
 	mutex_unlock(&pctrl->lock);
 
-	return pm_runtime_put_autosuspend(pctrl->dev);
+	pm_runtime_put_autosuspend(pctrl->dev);
+
+	return 0;
 }
 
 static int lpi_config_set(struct pinctrl_dev *pctldev, unsigned int group,
@@ -335,7 +341,9 @@ static int lpi_config_set(struct pinctrl_dev *pctldev, unsigned int group,
 
 	lpi_gpio_write_reg(pctrl, group, LPI_GPIO_CFG_REG, val);
 
-	return pm_runtime_put_autosuspend(pctrl->dev);
+	pm_runtime_put_autosuspend(pctrl->dev);
+
+	return 0;
 }
 
 static const struct pinconf_ops lpi_gpio_pinconf_ops = {
-- 
2.56.0.360.g66cac248cb-goog

