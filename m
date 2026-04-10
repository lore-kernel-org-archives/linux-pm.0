Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FC438C40B
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775817680; cv=none; b=lsRuyj8R6wMXZT9/E3lN4/fC2b9KBs0jBcNPL7/GZeKouRQqxkVX+ZwukebcEuRqCqq5el6tiRakCO3SXIudQFO6FLcfgP+xSIc84hNytHNylGMs2pSRtM4TFcRrANJv8xb4PpX8ICI3678CT/8pMcpUBvDmXRxBocPLYW971p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775817680; c=relaxed/simple;
	bh=MQD/pbns3TGfw5gyIl2vVD5FE7yTWKPDZbqQkGVi5WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onw5HAXQWYf3lH9l63odalPNP3ks0tXrQrw0SzD+wZR9J5reHhnLe0AvWlpL+9PTchsh827HH0lwMKQUHClXkJtMu0a5ALqw+aAnAjcyqISuB0iuaztCIXG/5CBSrIMKgO0F3KivGv0AgqYs5/BazC9F6D4BZrPXKG2pGm5u3ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LHHXBrWF; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHHXBrWF"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a2c7427ad9so1764079e87.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 03:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775817673; x=1776422473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ncq8CIy6j/Z62nAIbhODRfhoacPZ6Dyu9QP51nZww8k=;
        b=LHHXBrWFHoIyNamly81Zo/BId91f5SyqxD0Z+aLe9MCQ03xTXS0M7sIeyQ6COwMzZz
         mqHZ+zIFXxioNPYJ8HLkaRAGpv48rTinbGq49rBCQWu1U10lp7fOt5MvUwRJsYOsqb9h
         9lQHozWCVwQnDGQeeEZkk1ywA6RD4lU2NP8dbfj5FeZq13Xp3MTblGWBasp7Ye4K/PTF
         tLqHmRjqlyID5UcJBdzVP+B7T9IsuANHQj1toZ/oVbWzIj7GZbEZOgENIMT8JrLmRgC4
         eVwsJ0My9+07DEdD/Fx0e5Jlwjt1grqGo1cLoXCsSJU14BesbkkJgGR4z5YIwrHtFIzc
         X1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775817673; x=1776422473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ncq8CIy6j/Z62nAIbhODRfhoacPZ6Dyu9QP51nZww8k=;
        b=Y+gmwb2f8zVvDFfzAsQFJ1t9sF3rvqJlv0E8LS+RH5F2NmVP+Q6mgn73b/DxqDfL/g
         UkABe9dOXhJydpKzKj++aa/jdA/PSdpkHAHh1GHODEM4OM3RHF5WghlEbKqWTk8js/AV
         uFussRIkz4n6Epg4Qqt/Tf8FMDZzUAd+JQbTNsf2a0LPAy8bNdYl7UH+JmSDdEinhghH
         F1av98TJNW2aSXutAMVGPM0NNyOfTiYYyIdiocXEJ9aaWxU/yyQCto1s6eX/iB0cv5je
         QxPB5GO+aGA20rJUHQHUM2OfUTL0/6+7V6K7ycUucuQovoPsCCTveqQg69EuHHn69/Ac
         6Xgg==
X-Forwarded-Encrypted: i=1; AJvYcCXYNbm5RwYssDWCD2BflucznM6FW7RU2HXNACYOomIi2KLIjd67S6URxML4yXPsQVmM27h3SV8+wA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/aBJb1Ohyg0opZS+Mt5cVE5y3YBjbyoO/wBDZjoeoBbMWQj1b
	+Xr/7SslxkXjSSlmVqBSu3B409p8EN2lngUY2vC4DLsEfMucv3LOYSXyutveBcQ0qUY=
X-Gm-Gg: AeBDieulJst4PgI1TWfGhF0ApszQbIuJ01fIgioO91iJrQptoz6v//n51+xnDw3y9V5
	l3UtDNC2US3QfmCPzd5M0bUrEIrEp1UDxEI6Q3dcNW39lCkyRWibPQVYy2IZYvDQc9EYFAvzq9Y
	kuq+bPZuQMxROASaZTSWi+rb8uJcgllnb4Lecr74Gl6XzMr/aUjifNmorR/dFqQrpH2eV1X5sEd
	BNFyH/S2JO5RtUCWADaGDaZLkSJORODUaJwsoq+5Ou1wo+pliJiNyR2H1nnqLsomiRYKpGPTatG
	xsZR+pD0NNobN3jY1BsZ75R0DdnFxqi3QfVjPUzN9G/73GfX33DzIEAAIu7rMD0AyqUu9E9iLq4
	1aXn0nOQEhAzbSgs569uIgzNjoVYDfRQbGtvq/7mSd9nHzDkpylaayUXzGBMTXNXxzCmlkuEaq5
	vEiK1YutV23VNqCqK+0CsPZehlZB2K5VWBOR8EvhSOSjatsN4io9cX4sqV2/e15y4ea8/+f+S16
	Y8X+H9VC3g=
X-Received: by 2002:a05:6512:39c6:b0:5a3:cebc:65ca with SMTP id 2adb3069b0e04-5a3ef6fe0c8mr858352e87.7.1775817672992;
        Fri, 10 Apr 2026 03:41:12 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e495455acsm5588331fa.23.2026.04.10.03.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:41:12 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: [PATCH v2 5/9] pmdomain: core: Extend fine grained sync_state to more onecell providers
Date: Fri, 10 Apr 2026 12:40:48 +0200
Message-ID: <20260410104058.83748-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410104058.83748-1-ulf.hansson@linaro.org>
References: <20260410104058.83748-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A onecell power domain provider driver that we can assign a common
->sync_state() callback for, should be able to benefit from the improved
fine grained sync_state support in genpd. Therefore, let's also assign the
->queue_sync_state() callback for these types of provider drivers.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 783d6f981708..f11dc2110737 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2918,10 +2918,12 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 
 	fwnode = of_fwnode_handle(np);
 	dev = get_dev_from_fwnode(fwnode);
-	if (!dev)
+	if (!dev) {
 		sync_state = true;
-	else
+	} else if (!dev_has_sync_state(dev)) {
 		dev_set_drv_sync_state(dev, genpd_sync_state);
+		dev_set_drv_queue_sync_state(dev, genpd_queue_sync_state);
+	}
 
 	put_device(dev);
 
-- 
2.43.0

