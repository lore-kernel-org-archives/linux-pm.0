Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0405138E5CA
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775817683; cv=none; b=jalkRmVxw6hKuSMRl7zuXPAw15jApcFp5GIMuTbPa1UZfWrI7FA8NPRX3wfmz+7nIPagaYdCPl/jOUkl/pwB5iNuAvBXFo+N/38U4o9jcpecO83navpzz74+QQjaD8Z5XMsG4M9h9s+MVDiaY/+uA3X2VMyoMZBTeQY4xp1a+tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775817683; c=relaxed/simple;
	bh=UwOOlbvCxCnfIIic4VdFsNNaiKn11+ew7MglT8mT9rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRl0RTEhZKata7/aNDZI+8EvG0hkC41SuGvxj+07FdfSpsS+xPISoHgqyzEuwF4boBur9O1IdjcNLFp2aVW8hSZoUxzcTBrbV/qxMvsfOTYbwnkpyhPkdRysDM25NC0JMgTYD5FWrxvhup3XyJwbxMeL1praWXGOUGIcK74BHbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IvyzKrt/; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IvyzKrt/"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38cbb1ad0b6so16990361fa.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 03:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775817678; x=1776422478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIFBMvwRZVJlZTyPyEFR27wpVQvdUbmru6DwxmPBoMI=;
        b=IvyzKrt/K2QmmUNpBSyzgQ52xM0sALxBMsykztJ+zudgPJ1hq4FLeFLX6avZQps2u0
         jZYGcpiG8aNG+yO39MReTOEKd6oT1aV4k70lm/Hnw1mfd6uzeDlZUEuX3BFluMvOyw+P
         s1XNKzNhoGLwdyNx6voeG+p7OuHPF46DGl3bdtSQSU4ft3kQkfO9E0U/aBtZ5kocEEWG
         +eL3E3qvu6E52uBVCCd69PX1z+VML03mNLhUTZTPIxiSBL3joqMhGRHDmfL/hGn6dkJQ
         rVRVsH2g1utdMqcEb4seIfVIu9U46fEj7Vym4UbbWGDl98OFUPrCxzL24TEmZxeaRwvE
         uxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775817678; x=1776422478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BIFBMvwRZVJlZTyPyEFR27wpVQvdUbmru6DwxmPBoMI=;
        b=bTJZj3d1djc2KfEU9EUFOCO/5VNsUxvgKmk5wLUW4Zv1X1k60TJeeJ4ftbBdJkrjup
         xocIRMLtV52Hxd+YYd2v9GWXevU9XL9J13aUacot8IG9UYCyYJBj0b2dJyWFlG2v646g
         jhU+yjtyHMQUSDG6kSYvButWCxheOOjnuBt3EryJon2zkWTSbcb5IiQlWly6DGdpoKvI
         Stfw0OFli2hA9aXHaIQQ5k/27Gb9xv9KUXkQH7s43q9Vqk+DZ9PUkPJJDV20wawl3gaV
         brEQZf9wwryom7PoAS+H7GCc/ZNIrcersTR2BSuOL2HhXnAlk7GfiNKpkW6sskQ4zbNO
         FvUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK38WOcOs+cYPDyQOR9c6CChloIc2a+7fVigleDmvMn6FTkOCjDsblLPqeojsgRFdXshmD93zBVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbdXyX+F39te6O4de9tfPAGhGNBc+xudrcj1OBirgREzqCf4er
	4NpaN8ibbJ6zN4hIvn4xehvmR6t4rTJRld+7WoJD7Ou0C5sTo8/o5L6Jf7nWJMbacEw=
X-Gm-Gg: AeBDievxbBCetyvM00zx1756C90Pu14TKwCfFD/+3miSdclWG292GFZCtcPyl9nh+2F
	qknHa03oHLMnTPkeFP5BjtzTUSEFddirwDpErbcpYoMmkDtEtBY583XIUTK26s1Cic8fPRsXhuV
	AkruS0A4NmZw+9Cso7GDwFZaoTbKtj/JhL3lX/BLu9Fokrt9IvNajsD+141PTokQxPR6igmWTqL
	mBNiHOMjnePfEyx5EVQxgNT41XjxdcRM5pDmgXdzWMbeBf/iTaTju6tR1u28Nb2VbssY4c40LPw
	KrAIEpJIwqzgEUvxRB2QAEafkKnD7k7V/rQ8JZeZ3hn+ydrviAwQR+rtRPRTuY4S411MDXl/WBG
	Wq2XCkhZ94f5GMWZxne+L4EVGfZmXuwWzyS3ZMajlcPsZ8aS2yLMqvLHgTDqa3tICBUjiiTPPFw
	y3wE6Cq2LNiwyErsLr7+brF0GhJCOW5nPZvS9dmaxhDYx90MPnetIlxWZ7u7DEH/bqthjdDszEj
	72nb7F38Hs=
X-Received: by 2002:a2e:bc10:0:b0:38a:44d4:4901 with SMTP id 38308e7fff4ca-38e4bee9c30mr8863961fa.17.1775817678163;
        Fri, 10 Apr 2026 03:41:18 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e495455acsm5588331fa.23.2026.04.10.03.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:41:17 -0700 (PDT)
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
Subject: [PATCH v2 9/9] pmdomain: renesas: rmobile-sysc: Drop GENPD_FLAG_NO_STAY_ON
Date: Fri, 10 Apr 2026 12:40:52 +0200
Message-ID: <20260410104058.83748-10-ulf.hansson@linaro.org>
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

Rmobile-sysc is not a onecell provider and didn't really needed
the GENPD_FLAG_NO_STAY_ON flag in the first place. Let's drop it.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/renesas/rmobile-sysc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pmdomain/renesas/rmobile-sysc.c b/drivers/pmdomain/renesas/rmobile-sysc.c
index 93103ff33d6e..e36f5d763c91 100644
--- a/drivers/pmdomain/renesas/rmobile-sysc.c
+++ b/drivers/pmdomain/renesas/rmobile-sysc.c
@@ -100,8 +100,7 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
 	struct dev_power_governor *gov = rmobile_pd->gov;
 
-	genpd->flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP |
-		GENPD_FLAG_NO_STAY_ON;
+	genpd->flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
 	genpd->attach_dev = cpg_mstp_attach_dev;
 	genpd->detach_dev = cpg_mstp_detach_dev;
 
-- 
2.43.0

