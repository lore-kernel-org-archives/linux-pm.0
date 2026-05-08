Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CA33DDDB0
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243983; cv=none; b=JdCfOsU+eCsRih8zs3llwsbY6G9FUuUjuRlwGBM/p5hd1o92iIvdC1VlLwJ25DxbolRIxFuo0JZgqLCWRBSZxaSc2RIEz1aDf66SX++U7m8fJmpsp1T/tWZgOAhbzI3qTMN54co97W+t1x7HYMP1u8Jv4iYC8F8cdYL3KyoME48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243983; c=relaxed/simple;
	bh=o6Kkmkal1dRnR/874ZnzDFZ9P4+SWzK1X1LngRUykqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3w/LP9v+dNn4gXf6ZRRCQqsisjkk2Uyulqq0gzAwUI4ubo1LZ5scpg55RAWXs7vQnpZ5DNAofyC6A7LJV0FiLmZgEE2FHc6Ij/fUR2WHNFuIeeYGDyQZqzu5yq/xvcEkX0Mv02E5gx8Iq2vYDf5/1M644locoPH77CFd/t7oos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TbYwjDwx; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TbYwjDwx"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38e84ed22bdso16962541fa.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 05:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778243973; x=1778848773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkBPidrgCBcSCiVi3pEiCePtzlLJIduNWzbjBZQqIoo=;
        b=TbYwjDwx0KJImbrPTxkfmIKLVDU2XXm0gX97dxZxQEYPNS3dxHJM6M9lHf3tMePaWZ
         k87HvmXel2QsSMhvI7xh/ycQ9LXhdkmfq5TICLWbPHaw7sS+4LXNqQ/7SNc2+tQAtKmg
         vAsIrk4Nqak5fpj5vQXr01P8uRv3G4l9Pe6ng3J5+gOnCyTDNiqOJQ7c5YqHvUHcOQaJ
         2DjxIdqZ0TECLdWyYhuD2OKE6oaIgseAdXLoCfW3W9C+mL69JUoINrZNWHAm0QyrCbP9
         iXveJH/ZSNm2RLcGdOk8T6Cy6iI46P0+ZHID7fHIatrD64vJ5POczeG+RIKtV34i8LPh
         2kBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778243973; x=1778848773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AkBPidrgCBcSCiVi3pEiCePtzlLJIduNWzbjBZQqIoo=;
        b=P7/oxxwPbhOhkCOc3Rf00mtE/P967s2pXe6icvnsW9RrK1eqTrVoNZzfOUVa9j/TPo
         cq8/817qsgxWSW8nfgVgo1ppQ5p9kzchIZcNRuEywpJ/JJU4oWTARJcH5YnBed0F2S8c
         Fv8CdYLtVqiAJUK8RHrzadiMjA2yK0SS73dFSuAEAgY/NsG5eRpw9YNHTZWSENmgXnG6
         MlMcgM+4YpIyeQ5snJQ7m7+8KMiWrQp0qgiZKRWqrh8UgGwT3TbwUCb+NYqQLJPGw9Iv
         gE7vZ5WoyNXvQwyxLG82aU/NBCpeQLud/I6XItywJ6RpGlKDDdhxN0VdWbvnY1xZnA3J
         jQ+w==
X-Forwarded-Encrypted: i=1; AFNElJ99stwJqDtguT/nFPGHtCcbIZFV4NBDMgwVll/Yp3ZJ68kIl7IsvLm0VbDNWNDuMfpOm69MsMf9xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwujWxVM9gWeGGJxuDT7oXoOOVD+dmTKUs2CxZsa86hmGPqclCD
	XItGSeIzuoS9gMZ9E74RSwTrD9FrDObBsc38J7GCSOi1EPRTKjOlRedc1qvUaOa8CiM=
X-Gm-Gg: Acq92OG0uz0qnJv479C1Hr+gf9s8BQVATH4FO+YnZuMlriq68qtTViZTWyIrBqMYOf/
	151GYzlHfoB7fbXwvkGEQCvULM36/AKATaRxLAoar8+7K90XPOMz2gS58I21lzZznJh7XBzl7o7
	YpEzaGzL9NUV7u70O0eQ4NZbdelhxTUBvx7rLzAcxD0qU9tD9zkH6ah3e0+WSx7VrfATzHnvQoX
	LnsbPjOGQntH+0gDT+YCcpS8qe3DKbicDJ+6psyRdf7fT1ruNxer62NLJYgrNVw6mFxTI8oeHdI
	m/J/tv98mb/hJC57qBNhpXa6HP8Mvmr34lwxvKP+hueZ5ofS85nSk79x097frWT9fANQNwOuZTt
	5yFxpDS454gYnMmUhQoBUg11IWc0tGV9jQk9VS5ld2QpL2Bl/aKVoUYZjNpAOgM4RGtmUNrOn3Q
	g0w4/tB1CY7lzinmXNSp6rQyTVkXevTK7b3E17wxVyHK9C8kOR8sQpalL8h9LqFpcz3Aso/P7V
X-Received: by 2002:a2e:8952:0:b0:38e:98b0:3a7e with SMTP id 38308e7fff4ca-393c4211654mr36254101fa.22.1778243973092;
        Fri, 08 May 2026 05:39:33 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f5fcc7sm4569621fa.18.2026.05.08.05.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:39:32 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/13] pmdomain: core: Avoid an unnecessary power off at sync_state
Date: Fri,  8 May 2026 14:39:01 +0200
Message-ID: <20260508123910.114273-13-ulf.hansson@linaro.org>
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

If the PM domain was not powered on during initialization, genpd will not
prevent it from being powered off during boot. In these cases there is no
need to call genpd_power_off() at sync_state, hence let's avoid it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- New patch.

---
 drivers/pmdomain/core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index b3ec3dec3f10..b5d90ddfd698 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3636,8 +3636,10 @@ void of_genpd_sync_state(struct device_node *np)
 	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
 		if (genpd->provider == of_fwnode_handle(np)) {
 			genpd_lock(genpd);
-			genpd->stay_on = false;
-			genpd_power_off(genpd, false, 0);
+			if (genpd->stay_on) {
+				genpd->stay_on = false;
+				genpd_power_off(genpd, false, 0);
+			}
 			genpd_unlock(genpd);
 		}
 	}
@@ -3674,8 +3676,10 @@ static void genpd_provider_sync_state(struct device *dev)
 
 	case GENPD_SYNC_STATE_SIMPLE:
 		genpd_lock(genpd);
-		genpd->stay_on = false;
-		genpd_power_off(genpd, false, 0);
+		if (genpd->stay_on) {
+			genpd->stay_on = false;
+			genpd_power_off(genpd, false, 0);
+		}
 		genpd_unlock(genpd);
 		break;
 
-- 
2.43.0

