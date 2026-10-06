Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08063C09F4
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328802; cv=none; b=F+3xKupHKxyV50rbzfk8+oCcfZddav1TcJYm5EvhXHOtgHOiXzr0xVExrN8oE+d0F9IXgO9xCZ1/Z0iPFiDUPlyk7OFvpi7Arr41Jx9lHCG2/nBRbJplCSvc8BxdAXqfSuJA+/W4Ep54hKELK6//+E7Hfmh8QyeUnDx+wbN5utI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328802; c=relaxed/simple;
	bh=jOFIi9j5lb+W4ZgP3d2GOzqpMZpI5gD3eEQ9EXJ3vUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFrhT38s/u+aZddZ2CqbxK2tZvIiEQraJFmtgcJHtTpYzjZlnuBVoP+JX/terMK0r56wAjvHODCp3rHngZRpL+qTUMYBLUcAp1xtPjw6GHOpmURT+wopR8oUTE+s5OUGk2fFyS60xrD0YDxB62O4KhBa0nMkBtQKJkWCTEeikSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z1fgv2Xr; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z1fgv2Xr"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33c2520ad38so2791768eec.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 16:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791328788; x=1791933588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V7WLLRIqhaGAc6KUPG47cH0uIhtma10yNuJoi118PnY=;
        b=Z1fgv2XroizXq9Owz9yQuRq9DVYxToalxPKuqI0ji9JAPJaEksVcoD2hUojOl2Fduo
         2AUxD0GAy9CMbohmGPkbOb5CxNQx9T5NMBlbRX+aWyk01iU7+U8peSJeFFg0A5c23lDS
         k4vjXpegU65YyYiOQFjvCKKpDwJ4fz1nShtdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791328788; x=1791933588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V7WLLRIqhaGAc6KUPG47cH0uIhtma10yNuJoi118PnY=;
        b=H5Mi3onmNjBG9xEmBuyf1BNcLYAsYirfDtinghOMOwXCyuycP0BrYj0lHP0wNPRWK6
         LiiAbrDAjhZmuZ/v8GZ8Q2KU0u2X4GXAXTDf581ihjVKpAsX8VSNf244ibs+ylI28+e8
         7UkiFLODzUlmOATa2DtvC/gWb21fCKfCyFhIRYio0/tlNPB2p1aq3FeXJyYCfAIcywqQ
         ahzceMcKP8MT2N2ffyZVGWp6MNNqqsAQrBTUvegG73Xh2iFf8LEzHiDnkf0XsAj7CfRl
         FATgRSC26Kn45+QFUV5PR/IiTm88fOJUv72V+QJCb96y85zmGFzj20kBmlTyEnDoqe5o
         eacg==
X-Gm-Message-State: AFuF++l9BfLU3E4N3ehmbHLYpdaajo3IdDesQQoLu7h7p3XZOEt6Ay8+
	hWK5OwglDrmqJ28k/mhlq2t+6Jk1h8B5xGNwALvqYFYoUS5jpUG4xLfhS24qo9fLmw==
X-Gm-Gg: AYBFou2fVCujPjVDudljrRz5O7IgGxRMdS4IBRge9DKSzll5waNGmcodGgp4cZv90hS
	61V1Ceti+j0QpwPAvw/VRmVvHLBi6+7JAY1aAWDod67VzgguAx1af2TVKB52m69gSiGeoQghd7l
	J7g+a12sP/pNNzE4b7ElQPR8n1ZEyzzlWRnWxcnRJyVkIXNryBtoTLMDTWxsGo6xQJHUmfsJCx7
	8rBYt6Vcn4ReX2JPVnUkEIgTf5Z2oCUdfn+lEHYN6vvdk5o3Hy8MsFekfK71HVOuWOeR2xtGjX6
	WAdBffqmz8Ny/Qk7aDjW1MP36xAHAO0Uj29uRYji8YZX81hppfoUlI7AjanAAhHdWLQpc9Rsvu1
	8LKAPDf8gWOYLr4frzCYFhW1XVA46JWdLVq8tPjlYf4j5Y5Y7afhLVgp92TzLxQcfyEfkQGptyk
	M0rr64thnilFVlwNLnL8IHReJg8IKfWLG+R2GBtelWoVWB4qGFZkMfbYYwSZsTgT4H9eLz/V9EP
	okE59NGkq7fqpprQOCXEVTEeycTyW3A1rp3qw==
X-Received: by 2002:a05:7022:ed0a:b0:143:2719:566c with SMTP id a92af1059eb24-1620824887emr274449c88.40.1791328787647;
        Tue, 06 Oct 2026 16:19:47 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:63eb:e7f9:1d47:7d47])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-16166121f2asm1806348c88.4.2026.10.06.16.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 16:19:47 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Hadar Gat <hadar.gat@arm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Olivia Mackall <olivia@selenic.com>,
	linux-crypto@vger.kernel.org
Subject: [PATCH 01/13] hwrng: cctrng: Discard pm_runtime_put_autosuspend() return value
Date: Tue,  6 Oct 2026 16:13:29 -0700
Message-ID: <20261006161337.1.I8e0880001b352bc2b0e99c40b78cb57e03c88a12@changeid>
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

Printing an error message on pm_runtime_put_autosuspend() returning a
non-zero value is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

Accordingly, update cc_trng_pm_put_suspend() to simply discard the
return value of pm_runtime_put_autosuspend().

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This patch is independent of the rest of the series, except for the end
(changing the return type). I expect it can be applied by individual
maintainers, and we pick up the end once the dust is settled.

 drivers/char/hw_random/cctrng.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/char/hw_random/cctrng.c b/drivers/char/hw_random/cctrng.c
index a6925211c3b5..7e1e1a7844b0 100644
--- a/drivers/char/hw_random/cctrng.c
+++ b/drivers/char/hw_random/cctrng.c
@@ -96,11 +96,7 @@ static int cc_trng_pm_get(struct device *dev)
 
 static void cc_trng_pm_put_suspend(struct device *dev)
 {
-	int rc = 0;
-
-	rc = pm_runtime_put_autosuspend(dev);
-	if (rc)
-		dev_err(dev, "pm_runtime_put_autosuspend returned %x\n", rc);
+	pm_runtime_put_autosuspend(dev);
 }
 
 static int cc_trng_pm_init(struct cctrng_drvdata *drvdata)
-- 
2.56.0.360.g66cac248cb-goog

