Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFC43DDDCE
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243970; cv=none; b=htiipQuxk2gbRBytMKG/3jF+XjbeZfHNtSrTp3Tc2M0QIcXS8zMMybtQvpx45UHAVkyL6V8hfm39ADYIPHcoZGRscgXYRBGlgtVqTUfibWXjr8J5CEXhiyofJy4qYc4Qm7rDCQn76VqSatdsXL/ZpeiH1SIKWG+B6kJTP1sW+cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243970; c=relaxed/simple;
	bh=7gIAiqk0uBq/8qs3H4g0U1Z7c+Lxfh/MrGyhojYR0fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUnM8RR1bBa0rrkcboyUg1I1sJBcr3rt34KJEQSAb/9/bxLIFUNUJutXH7tyVZa75YZJf5qihPfgxOA/mQ0LaWoyWYaQmS7oQz6A3tfyYARmQiLVdfEqjtAGzF+4l8YmP2OMkTcV/wV4XC6Gn4bvj2nqhKDibopwbDJsJzVT+eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kOy3ouUz; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOy3ouUz"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38e800deae4so13834611fa.0
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 05:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778243966; x=1778848766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFYMD9J9S/4UjhCI/3FhGblWRPgd4BSU/A4adAW4pr8=;
        b=kOy3ouUzhNBRWao7uLUyYW9qqzMhnOaKPiLlob19/vRZbG8mc9X3vhT82SjUoz4SxZ
         OaA6ATzroHnHP2n/i8DQhrCFbX+QbTJAkuhhkNJFm+LKH+EuSUQo4nt0SJ5kKITRIJCT
         TPkRWJSqMbAyoUBeo/PzVauUiaO6GYRYlc3FPIT7LQhkKKvo7wBJUJL33fy6dscHcFkA
         uTMxejPctIEQr/wVu/N/e63qwb5mHpCki3NvHmurIf9NXZQZJGntVhsgkLCcY5p6D57I
         aB8HZvtSuHejQ/8e0LTscOxBDw3Z40hoJnQITdtewmLE/6NBbtO/ZtgEXtAIzIVx41FJ
         +mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778243966; x=1778848766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JFYMD9J9S/4UjhCI/3FhGblWRPgd4BSU/A4adAW4pr8=;
        b=ZgBL8h69MTHzEpnCmPZYmtbM0fuskizYT5yMXptNCeH55P0cWodkxkNiU4gPWq1byU
         A4887/uq3wo7efbhphnrESl/wweLmmV/XMCP0KnG6d6d7Yonuf4NQame52KrUsUHYHKb
         qoGcMQc/KUFGuCVfwUU5L+/SVrhc6sEyazCFB+Xv8+0+d3OqoE1Ng1iXrwsVbubZxfHn
         gD7UDpJ4foRKJ+dE4oAiJTCQHigU+FcrZm6eyJn5DzzyHBdUgsAxiiNngXWO9X7ZDrAe
         uR+A/qcVgVq3ogvLADr+hXjHuNgfc2F43iNfi2tNlV6Y86TH89tyWmdd4LIsRaH3Wsej
         dbSQ==
X-Forwarded-Encrypted: i=1; AFNElJ/FVTfRQm6y+i8piJYNfFovKRMZ/2JJ+m84dx7c99ibmUgahD+WNuV5UvKrpYQLyg5Xe3/EAQn38g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7tlLh9ET8ny+UvpqsfJUDLhtQFLOcifYyl8Z1OezicOb7b7+f
	SGe8aHDGoNu5sKFqyxGBPHSRlYzljzbBg/w/UzZCxhKwhb+Dgtckklqe4+w65RYnNnc=
X-Gm-Gg: Acq92OGGcxoOfwN4PDvtT+Llv2JGLUrAkLErYhU1dDZZnE73YPGrECMPR9WdezeMBHM
	OpWW8HjxF3tRxrK1GPCBNozI8jikyV1ZHflUZr2lsMNvf9fX//LnYcWe4Dwrgo6ut5Rro0CumKj
	kZSxdqCe9go7yRyVBsRtwTtXVTSkRuV47ZehLSz6IPQtjMlPr3a78uRgufmHLd62QDULFuerYsL
	gD5OHJwZ5Dl7eSQYwXKr5OTg7LEvZpwKtP9MkefXsxOnyrjpb2rD/aNGR/1bekJrrPYKKbTkEh8
	bTn+VvOju4w98+0TGxtn1ZAf8dD9cV93zVVMdPI5eXnilO2NNaAw0NzhP58mhnIzSFoUDyk9qwV
	CysPJMUCmPkLmRmDgIyfqKh/IBRxRWv8ETrwSqcBNVBTJm9rPg6t8xTy06/IYwFD3vwNGAgTSLA
	y9Njq8FCnEoHdyefnVt7a953CjjbqXh5ge49nN9TB0cbAeKj/GyjcYFbNJSav3fAHKRrLA5QCi
X-Received: by 2002:a2e:b1c4:0:b0:391:a48:a4a2 with SMTP id 38308e7fff4ca-393c41368a5mr39654801fa.10.1778243966200;
        Fri, 08 May 2026 05:39:26 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f5fcc7sm4569621fa.18.2026.05.08.05.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:39:25 -0700 (PDT)
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
Subject: [PATCH v3 07/13] pmdomain: core: Extend fine grained sync_state to more onecell providers
Date: Fri,  8 May 2026 14:38:56 +0200
Message-ID: <20260508123910.114273-8-ulf.hansson@linaro.org>
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

A onecell power domain provider driver that we can assign a common
->sync_state() callback for, should be able to benefit from the improved
fine grained sync_state support in genpd. Therefore, let's also assign the
->queue_sync_state() callback for these types of provider drivers.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- No changes.

---
 drivers/pmdomain/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index c01a9a96e5c2..b2b5cc30c7fc 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2917,10 +2917,12 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 
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

