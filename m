Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3613DF002
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243985; cv=none; b=glboAFI0PJiiZQFEo+P3RsIIuAF9LQwdMt9hBMvV4wbkq7PIXtu1cua7xqdrGvcnOCY3IaIW8hsQNTnLLJa8qil+yE1Xunp/hYmTi+f7PtUmv8e37s0wxSBr64RAhjZk6FWhXWF5nIcDCO4P0dne8ynGARGQMcPwSydj5qfN5fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243985; c=relaxed/simple;
	bh=I4pKmmwjevq8dz1UuOr+v5418ApVsdlP3YsqqByAvRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuT7o73GxKCjI/lwSC6UVYwdRaOfwk6FEsz7tkSvcZuEggk4O7H1Zi9eaQCZfgms2VfRXBX+RwrYamvRcRKJrWwZtXxzaOUfo9zGp61Z9QGHB3cKAZDciu6TRNA0v1Crh0hXP+gCN/sF4ELzQ6L5iaN2b+1bP35+33k03j3Xcd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v3uZ51kL; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3uZ51kL"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39380e79936so27215201fa.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 05:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778243972; x=1778848772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rD2aCPCHqZRuH2DBiEm63Gtf8tVlRjph1PzHrc+ZXrk=;
        b=v3uZ51kLEC+lt0euLDw3EPMmlNx6ujnPJfjFKqX8Yo/z/lkQq527j8Skf5/jHNmnye
         OnUxk76q9w3cPbbN7hSE+TtNIr0ifC0AS94LJLAb23nYLsDLeL1eN1/ZVL8Yh873zheS
         iFyoInE8c22Btm+G7xAmbMCEjcdt6ITTZy8g79R4V15k074vumkBFyRWkLxMJpKmzV8C
         3tGDvjl8fSTtfC01Qv62m86U0vwqR4wlFIfC+Ej+3KKfYDLm4s8cFFWcTq+BeDx/Buhm
         ldpGmH+oxrn54KHGkOc2Vm9kxnyNAj5tniddCkxnrXA2z5MD00DLJTN/m11bafds0wWr
         qMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778243972; x=1778848772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rD2aCPCHqZRuH2DBiEm63Gtf8tVlRjph1PzHrc+ZXrk=;
        b=jvO5BQXcTSpNwcN2OSe18rUQa8z+BjK3USx9k7TJ+CHm/3BcDVGLqQ3jFl/YavMGq/
         GaoKHIllVRqneNjru8NfjhXhaoUbVqkf/nx9ryOmRJfflK9uUZp1HsA0qaFfn45tT4+G
         V65U6UejE/EqdHvXxtTkvlqehsemY4NcgKSksIjCDIeT/6dT3KSAUFFRhMb4KrDJ9tPD
         DplRhAEQZsbdHjGEU25SFDg9oG5zHUVDRuv0eTyyfyRE27acUrDfHatKC3AwPx9RMqz3
         Gxj/QqA9yRWHxJkLBGDpNQZ9xBov8rmvJPwZNVfRVpVpN9REu9bYShm0Locok6/C6MhJ
         2a1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+krwva7BPlJFzo0mGgknW1rkxRCO1qFyDa1BFRbupXAAmqzoZ2Ofk7xMUuTmyCDvY/ltbP00rtvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCMi3X+Jqwl461pUEvRR7wR2itSVllPWZ5nqQSutDVcUVMAnBA
	Eg/bsibhpsGXrxv4xZ0W10RPhacvAJ0lrKyxA1N577VG8e59eriZGgFFFv/zh0smPxI=
X-Gm-Gg: Acq92OHT1IylF728+cDXlOuXl0PwGAOMp/f9U5Zlsv3q7v+JTYZ//ZwfmR01gzhOg7Y
	pqHrixXVnFSxA8Pq4vaDjgOZu8y56HRyGzGuyEkBrZdaD/8xsCq3SMzbPbN+D9MQUqh/cUPk36j
	0UGEDIEyfP4b5HjHHMv3kEzWjzXQlFXVmUIQCEarSfTYrhQ5LKfS+oAZ4IoH6BG1IoE/8IQ6e48
	dS4zXaOTtNqGbcXLVtIe66hYxm9FcrJuDQO87KHQWth+DGiz3jVZu8/zXJxmZh+l0Mv8jFGhLIj
	2dG63C/KsiKfk75e/qZ/o20SN43Q2uF5p90p0WMkCq97IIooF8GWFQrg+5zEgQgKyNRrueiKaNJ
	uMP8WAixN9+eFI6AOjrAHiQezID3fAMcXcQVy3sHz5Qh3UREA+cN+GxCspnqCu6AFHL218OClfp
	OOQzi9VyjXqZuJoCRrYhk5e5w9xCRMlvmRaXsBH9RRdd71ihVLzh7dqL1VP0kw5XOFE3I2nJgH
X-Received: by 2002:a2e:9783:0:b0:393:903c:225b with SMTP id 38308e7fff4ca-393c4338719mr34887901fa.31.1778243971807;
        Fri, 08 May 2026 05:39:31 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f5fcc7sm4569621fa.18.2026.05.08.05.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:39:31 -0700 (PDT)
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
Subject: [PATCH v3 11/13] pmdomain: renesas: rmobile-sysc: Drop GENPD_FLAG_NO_STAY_ON
Date: Fri,  8 May 2026 14:39:00 +0200
Message-ID: <20260508123910.114273-12-ulf.hansson@linaro.org>
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

Rmobile-sysc is not a onecell provider and didn't really needed
the GENPD_FLAG_NO_STAY_ON flag in the first place. Let's drop it.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- No changes.

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

