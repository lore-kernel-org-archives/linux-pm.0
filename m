Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D13E123B
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243974; cv=none; b=lEBFdxxlALn7nwPTam1bPgeXmm2C0Nm2JCdXkRVI1xg0YobQ11YA/a+wzv2+VYusXlU2ljZUUg0gSsqgLqIMezb9hL0cI4bmzkwQ6FX/Ajt48m7pdSg5hrfFz86Yh1psb6l1m9jlKoj/yynk1C1aE5UNCjS+XkPSXddOoTtq5WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243974; c=relaxed/simple;
	bh=hwOvGP8Oty93OHqwiALydRwNTRVjRDprCgEXQyQeyAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Os4ntNDPREFKX7UYV7lWZeGOgmh730tLByqmW5A1Qlqp0azGdtD9zEQTqb0xoM0LAAM5al0yUutYFvOUZKJcBLhS3FHrUeQI3sJi9UAoMCGjGYagX4PRaMzLzmGpWiLN2An7EcpAmXWfEgBOiUGVYh9EN3tE0Uq+KgVrxiHzob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=scSDc2Vx; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="scSDc2Vx"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so2092684e87.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 05:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778243971; x=1778848771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSIE7E4h7lWy1SBxFs356ugBkbZI4NVO2rqkoC6AUWs=;
        b=scSDc2VxGrR1jXVtC8ATpP56bBVg4skA85KGSgozheFSNsM8r0of5NREGvCLNNAv0+
         kpuzEkap5Qe8x0So687MguGs426jpjDindfssqcsiRUOQGE/M36ztJIBnxfCdCECdSq9
         g3Vh1BEJHn4Lp+OAWEPvRoVec+ILprt3TA6UqGLzHN8GFy4cypJmv2OLWvBXMlrZtcDB
         Mq7W8ykAr9LlyNoAx/EXWJxJ2lnbplkGlAI5CZlzKMPquiqazeurviv+UH5iAVABDJVS
         APzp3IaJw892NjwIE1hp9JTPDYpJFnrKPHdfHtGwApEM24GUjZTSh0SwHFi/fwsicdhy
         wWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778243971; x=1778848771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OSIE7E4h7lWy1SBxFs356ugBkbZI4NVO2rqkoC6AUWs=;
        b=Qga9Cz05Y9rqXb4EVmzgjubuxHkfLsEP2ddYOO87mzqG3JllNmBgd7JB82ld0ENrIv
         at742P/kYV/ZEUvjhv/DJop3CBqpT8RpwRxQsE1x5osquFZmXxYS7ab7W3SRlh5zV96H
         GpKZEfb4KvgoZzx1ZtKs0RQiC3KxnNdTVdzzglUCf+jGUY40B9t+0+6E8Gt8Ex/5B2d6
         bnM4zSJC1+IsrfeUtSMoT1KGOzTSjVJbrDvwUPeZ/kryg6sq4bxydMzxLo38i8FJoZMV
         lmag87QbTAyEbXFuqUm1ZWokdRGiXnNYqkScHXgLghOoUlkjdyijLFG26HyB9boDsLy5
         74TA==
X-Forwarded-Encrypted: i=1; AFNElJ+0TTriJf/NCanSG+FHcUMd22zAS7IaPxDUyUg0gswOwXmxVmZuNdJ91sqdhDcnCfGSkJf6yC7M2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx81NERogtczYF+HKWlEXYHDaW7iagGvn3wRkcQ1tHnLmOaYnZb
	qrdKtfIL0bPuEF/BlXBElGcFgLgpOUzQtisSTxrcQ4tJ+F5YEhClkld2voEwrpwM/jo=
X-Gm-Gg: Acq92OE7pJ+/t34oqiFy4HecM1ee9BP9pFw533floZp9BSAY3Y0/3rVkMhyoyfH0nAU
	z2xEYVLluBJVNZXiLAlHt6AVXZbmqPK1EJG7PTnpZR/Rwa9SGbJFBOUzMaqSHrtV61tDeZs5HZM
	IK2K02IHULKPr0ywGZmBxenxo9TPTgkJPhrqmXICdyAeEIraiu9fvdhBHurnowBdnbQTahuE9L/
	Vb2cFBvID5AJRM+Zka4EEV2Q6dLja+Dx2mreRAb2qDdi7Q5JFFcECW3dJ+9QtDtL11OnA2HDHMi
	OZ9RCsvD9jko9suQ1slT9W9QWjf8a91v7lTcyZzPMNMTRDEt4xbcc9/jhvSb3yYjTrnOf+tRxtu
	3qakVw7D5xZsesQSlz0beKAYnmylmdZL8CP/dzPUXJQrRD6LcZFXLNqZYkqwZCAW9SbAau0WRoW
	bBuFeQDzRiZgXHoTC1XMlOOT4j+uB1cLEF1iEnIuUcgP6BDmhPqdWZ7Wr6vdRiqGntXlOlf26a
X-Received: by 2002:a05:6512:3d03:b0:5a8:99bd:12dd with SMTP id 2adb3069b0e04-5a899bd13aamr2719864e87.31.1778243970587;
        Fri, 08 May 2026 05:39:30 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f5fcc7sm4569621fa.18.2026.05.08.05.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:39:30 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 10/13] pmdomain: renesas: rcar-sysc: Drop GENPD_FLAG_NO_STAY_ON
Date: Fri,  8 May 2026 14:38:59 +0200
Message-ID: <20260508123910.114273-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508123910.114273-1-ulf.hansson@linaro.org>
References: <20260508123910.114273-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the new fine grained sync_state support for onecell genpd provider
drivers, we should no longer need use the legacy behaviour. Therefore,
let's drop GENPD_FLAG_NO_STAY_ON.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- No changes.

---
 drivers/pmdomain/renesas/rcar-sysc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
index bd7bb9cbd9da..e4608c657629 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -241,7 +241,6 @@ static int __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 		}
 	}
 
-	genpd->flags |= GENPD_FLAG_NO_STAY_ON;
 	genpd->power_off = rcar_sysc_pd_power_off;
 	genpd->power_on = rcar_sysc_pd_power_on;
 
-- 
2.43.0

