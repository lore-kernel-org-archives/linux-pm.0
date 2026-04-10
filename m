Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259BE38D6A2
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775817683; cv=none; b=OIMk6yna+76A516SYAlbqUBABwfDhGMGrmlbONvbmULyPk7+W84qoTKdYQG8lgPCy+ZbRNi5eKgZ247Y61QVw69D6uIsGrhXTZW7ZBYAT6QmnCTD+aarDq6uZ8cj7Vq6e9OJ9tKGJbPZkc2scAxVK3ftFtykDJXBIEc2oofXu28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775817683; c=relaxed/simple;
	bh=9li9y33S4Rq1qZK2KHZaV3W2zJ7DJBiBLki1qODC/AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/CZ2S+uDYqLMs3ORJLzkwReUyB97NRoNkF2WM/YeiZ+TJWyKlb6eAglmslNk11wzDYBoJzvNg62msZmu8egNDd4E5qm27Qa98nJrBB9DLG4HWiZ1T7wh33BDwimS8rRN8btyU3QNW6RxzkvnBMs9TlGT7TXDtC+i/Cz0x9zU2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ptbSKJxN; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ptbSKJxN"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a283c44478so2956414e87.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 03:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775817677; x=1776422477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8wAkh4o7tl/zj3dU8ucWDwim4K0cFPOmp+J3PD9wxo=;
        b=ptbSKJxNBezQyf+JqgF9KlQ3jConYahhgxqSHW9exvxp52PK8gplX7sPF1LmtMJbxV
         LT3rAiziKdYB5qLVd8QCA8o/TBa9gDzbV5YhdLv+oCNVoi044ibXzsn4FgKV55gpdpUx
         hvR7d0a8UFqlnTi2g4wvKMcPSAKhmZHX8TNbvvuOy0N/HK63ABj2sGCDaOI8B+/hFIuX
         jWszQ9Efl3fjLFyN8kM7EBGQ/G3TGsRV1ksKSBGfD86B3gFR1A5wPx96MEqkIKUcIqih
         U53INzsoDWxpTiGUy8rfYs41QKnAjadwz4dDk/kYlSQRXypFuMzvkZCOqzyWj7iqH4J8
         vTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775817677; x=1776422477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q8wAkh4o7tl/zj3dU8ucWDwim4K0cFPOmp+J3PD9wxo=;
        b=WWA8Db5+bUydvK42hVG6qnQMHG5LvRkfgGRbwVvpZgMlwnB7Aib7UQKeWqL3UQ2MMf
         G5NzPzDj70eIXX53uKDGZzh8EkyHhRa6U05+2EBg8NJszDpGnDTSBXCRNGhM10JrEmgU
         dYOZWbemkPCfsqSlZHWjpjvQrZBxfYvXHinv8YfAcsiPp9aJwHsbxG7Y6oI2mg9q81fY
         3ZoP0lfJWSwoNFak3w4MDbGUcLWFwKOU3Iys1/lfK11BeMq4SlAF3pjVSb8QYN7EnRxJ
         i28vmc6VANlIvWX3t+bPwMgQhJ8QfpIFznKrtxP0PCxf5/ts1HZs7nMJrNRljGvkGHXJ
         rhVw==
X-Forwarded-Encrypted: i=1; AJvYcCVvuL0aHzssPqC0h3IOw5AiMLmiyztWy7c7FcPgqnQx/MlIJ6yWLEGQkrkZvo2ZJLDiz1Khl2Hjrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEHhWO+slcLgP5mYXPk+vIp1eGzW8zqIViVgDYwS9xzeVQdsPl
	6VXIvRxZB1wrtFKmR4Rp3OWaKmAhkG+CG7fMO3qNEeqZt3ZGoiLB23HOgBiRWUjCa+s=
X-Gm-Gg: AeBDievDXHcZGx72aKfZEhhtYTYgz5EAWTq8Wu+Ohhx6r2UpIJKofIuCk4I5UFTmOwB
	Ip1cnbP5WZBJQfrqi/nBjsIFaxhDIBPGYkMxDU+KxXATGerdpaal+hQ1+uZBo0ycS5NZdnw1LCT
	5N8sFj9FmP8LC2dgjfmWusrY/T1GdArB1EukAkaF2QIAKm/2mo0xgaFxWiKOSIdetab1quIJ5zj
	cYdh4SQbR30rNS75pvDQct7fvkcsE8Vg37z9aAANasUJRT47e3TqgG+NeukDtRQ71vvXC+WlPvI
	bdrSXrr/Nvsjn6SFMsUZZuVtrvBwzbd4J8ZOcI5iCWphtEo2bvIiFdxoim6mKQ/T/UHwygBWjOr
	iown5jwMZxoQeoZIPToxNPSRhbgLccU9YSzy0Pt2qUMixNr91hzTU20anzWo6+XvDon3QSTBJuP
	08t04WWpqbcNj2rYsyCSiszLS/WfRb9nSLGCW8T9S2Odv6sClUy08kbzSO7dgLnHKbruscN1aS
X-Received: by 2002:a05:6512:12cf:b0:5a3:ef60:f2a2 with SMTP id 2adb3069b0e04-5a3efb5a8a3mr827213e87.43.1775817676897;
        Fri, 10 Apr 2026 03:41:16 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e495455acsm5588331fa.23.2026.04.10.03.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:41:16 -0700 (PDT)
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
Subject: [PATCH v2 8/9] pmdomain: renesas: rcar-sysc: Drop GENPD_FLAG_NO_STAY_ON
Date: Fri, 10 Apr 2026 12:40:51 +0200
Message-ID: <20260410104058.83748-9-ulf.hansson@linaro.org>
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

