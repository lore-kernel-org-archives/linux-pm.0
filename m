Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8994F38F633
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775817680; cv=none; b=UMq8hS0c1i5WvfUJvtPQ8WVXEkBoApLGCFnamzHCqtw8DN6E3Qr1ZIlGlFFvx5vRDeB89IAHAqeVD5bemvvcOLK/OFQzFYuoSruYSI6ugUkEAu6CULmFryvlzWVYwNOdolBJAnOxyHIj7jGvqLAu9HeP0pg0v3ANBigdHYDBKvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775817680; c=relaxed/simple;
	bh=Ebq9XiwYmmSji4umCyK9W1YK8ARY9lnsvR/XIFGASVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtCnai2Io3ZmEK8YU4FXYvj1XWG3zLXTWvl8D1d8wFYF07P9sJlN6oOkb3J5WIkiWDKQ8Vfzb3NUw/PDTlxzU+pN84YRg+UZMBEdmg6OeTQ2iwqlnDUhi/8oOpd+T53uTF62KXKRdCiyKovAjgF4RxVAxx8TTwiQt17Kle/lTxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iBvJhIqG; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iBvJhIqG"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38cd00b3b12so14960161fa.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 03:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775817676; x=1776422476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFGKXYCuNL9Hzt5KxsbO6n3yPcfxQC/HvpIhLFtUJ04=;
        b=iBvJhIqGAXrPz7oHnTshuYf7tabWcqsw2iMJn91neCrDeo+zfKMPjpCZrg5Dzue2mP
         zK21+nmtnAqKIa9aG21ENuW4HXntSewXav7Q9PgOgtSznBAvwU9XgkZZ99dh/xN9LFKg
         GcK0eLDbF1w+mOtcx3a9uW/Bx5WGwrlrXYcDgnFoGv9gRv2jR+FEHeTloTb03EnUXCUV
         ge6fGl+UKvuyWsO9RRuBf0RWbTTdaYKH6FVwfngECOEs/wl+eLJS1YTBuK+bYIWb2f+K
         uZbHiBb8FCBZhL6CqLd/haWygAxoFNeB05cve9fKcKpQxNzY06UH5deNYk0IA5/pMU0b
         8SqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775817676; x=1776422476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xFGKXYCuNL9Hzt5KxsbO6n3yPcfxQC/HvpIhLFtUJ04=;
        b=oLooHh8frtRWz/ttA3FKWbxH8tjn8Jh0Qjx9cRWwr03c5oWoGwsTZhaOmHNbHvSGNX
         kgqoZOxXhsee0NM5LtH5jnBzbmDbjC/TEMvrh8O4xYTo438IW/8WrAqo/TgzvSO30Amx
         MptyjKP7E4POwV/6BqN6VILvOXZOtnrkHBKM1YzXcsa5up4AEUKkrc8sPRPMHzIPXgoB
         L+euoy7ASR0TYzqY5F3E6DWSSONpdJKcPzzESzFutWIWcVdxS/fIbih3y/ebJv7rZjaC
         +a9UDPkwoQc01xujqV98Cwf8mHW1+hW5i9X8vt/K36c3wCDoxiqGTZvMuTIHIG/aURcU
         zXEg==
X-Forwarded-Encrypted: i=1; AJvYcCUaDq+9AXKMl49ybD7AXqlPEB5AyRRwal7P03K+BXbg3lA2jiJRRHC2UTXjwi5zQ7rumMRtujH65g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJYxpttyMIoEzFhTs5FTTGbgXYbmHYUX4p8N0NBoigGJKVPpYb
	rTeSKTubPkKDRJDbpcy1zymfocu2BGtTiZ6hKWLS9uVFkbmpPiqXR9sdGf81iC/yYdA=
X-Gm-Gg: AeBDieuqFOOL5qynDDf0aGT0tkHTrsasNGDEAp/TT9HGIaF37isvvm58G2UwkjyU/vV
	/SE3h/H37QgFsiTC4V9eYBEGeQ2rBdfTSYCHeupKzZBNFnRpEUKsShFAM0V8oizwUS8+p6LlpyE
	Ikam/caNgwGviTk6yRJiOH6OyKwi6VYg8AFq9avSFzv/6hIoH5wmUy2oIxyR43nyZeuGlqFgdgJ
	EgcZNcEabnhvsz2BfDaxE11XTnkaYWQpMM/UsMvzq7kAnjRME85kfKatqkanCK1leuiRIUGYcEl
	0dryS+irri6D9aIW/LE7aiIm7AFRVILjY9GeJhxYIXLopKdvIC4zl8yWPzu/vKqmSp4hfyQeVfR
	Gs0OqV5CjpLCNZQC8ZIsuNnp8APetldQF4aRfmtYIAE4wbWAlSYOq0txl0GuHyOV4OoI5l2CjfP
	kPPsIxkL6HfxqEAHQ1yCTK776QaPhv0Mnu/yES9jI6Snt8QKJgH6JWI/pZhhBu0TRbHJsGjl+V
X-Received: by 2002:a2e:a54a:0:b0:38e:2093:1993 with SMTP id 38308e7fff4ca-38e4bdcb2a8mr8185631fa.7.1775817675691;
        Fri, 10 Apr 2026 03:41:15 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e495455acsm5588331fa.23.2026.04.10.03.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:41:15 -0700 (PDT)
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
Subject: [PATCH v2 7/9] pmdomain: renesas: rcar-gen4-sysc: Drop GENPD_FLAG_NO_STAY_ON
Date: Fri, 10 Apr 2026 12:40:50 +0200
Message-ID: <20260410104058.83748-8-ulf.hansson@linaro.org>
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

Due to the new fine grained sync_state support for onecell genpd provider
drivers, we should no longer need use the legacy behaviour. Therefore,
let's drop GENPD_FLAG_NO_STAY_ON.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/renesas/rcar-gen4-sysc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pmdomain/renesas/rcar-gen4-sysc.c b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
index 0c6c639a91d0..81b154da725f 100644
--- a/drivers/pmdomain/renesas/rcar-gen4-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
@@ -251,7 +251,6 @@ static int __init rcar_gen4_sysc_pd_setup(struct rcar_gen4_sysc_pd *pd)
 		genpd->detach_dev = cpg_mssr_detach_dev;
 	}
 
-	genpd->flags |= GENPD_FLAG_NO_STAY_ON;
 	genpd->power_off = rcar_gen4_sysc_pd_power_off;
 	genpd->power_on = rcar_gen4_sysc_pd_power_on;
 
-- 
2.43.0

