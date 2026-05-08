Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC3B3DCD96
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243985; cv=none; b=VPsX5jBjUoMloX6bUiJqLOLEQ0B13fCsdOZRt+I8FriQYLNTe+YlGUGU96QW8c5vyHe91j5c3CLbMxDtKZLo3qvWRElsEbyHGJO4cT/ROZtV55E9ItcchiLbjG4jkKfzarDZ0makTGRbdvfjyn/v6eTQyk5zHgHuT7grre9orbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243985; c=relaxed/simple;
	bh=hwsTYxE8EG28UGJ/9uJBMJiUsrm4KBw9SMV/lotgNm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBnk2JBQKpRSFD6H9cefuLyK+8a4YviEWiPLnD/RM/L+XK9zuqVqt4A4flnJK9xoe1GDA07Q8nTHHTKYlotoEqL/1xXNq/7EhXS1F8++x7WUgsRcegMFLgN6kQSbfgh2jbMc/bNP7OhcccvhT0vXJK5IDYOfLq4qTSM7Qe3ckPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=obEwBRJg; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obEwBRJg"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-393a49d2e5eso16389151fa.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 05:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778243974; x=1778848774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GaxAP6ysJuJBahsu75EBbPBsRu50PTWws4c1kr5c8Q=;
        b=obEwBRJgaxvemHbL7dhIcXUIjOVIjWRDekMEyrG2HSI2H+SQT7V2ZXa2d0hboanVBO
         6BY+13DyqYJ810nl6lCPSpujQB8PFtMle9ByRx+rXczExYcYdkf3LOQfqYnJ4i9rhRkr
         6B8ffltidZk+zQeRvQvYnxJQKXMnONT/xCJxEu1XnRXm24mtFFzA3eGYgdRjCxLBSS6M
         KcXnsiYKe+jN5xbpXCJ+4deqeQZrEQj32wimyTCoLOrY6+POPD9n6uOcslJtyj0Ha/Mw
         I5O8XXJiu7u+qgzsC1b7nMjt8GwQtSPBN2ZICak85U4CEssE6P+KICtfigRnIsx7oVe1
         C7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778243974; x=1778848774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9GaxAP6ysJuJBahsu75EBbPBsRu50PTWws4c1kr5c8Q=;
        b=H6/7KzyMAO3uLqB/wpNEYdA83uShOqPUSkfcm8L6URLjSan6E2Kg45Fpg4C1HVGkAA
         38pz/R6E2ZLUFMlJ/PUg6+qjrKt7zpfXuk0hFTRTx4nj6Tz/NaSCVHRSXgZmUK7bD1/f
         24cT7mrnUc0nrAfvngF8wnkpvyAX6t3GRZmHEUWeAUPEk8+OwNWrQ+ATYH7Bir6GLKco
         3Q+cZMFMrhDsUQwhSA8gFsTrjxD86yYS7VWx0ROcqeJtL6pXnytgs8/5q4SES+Z/IAT9
         h1fJ7+etdQQ0+8gUFCw8DftX5ajGwsjjzSAZvs/jDWnsA0GhL83mNlAtUifmI9kON9AY
         QYEA==
X-Forwarded-Encrypted: i=1; AFNElJ+mCaMqL8EALt2njsoCo10H0rwKTCzQArbxL/wRAqOO0JZodzfXzwhb21Z5yQaey9Zqujk+5NOpxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZIWd9Etwkg4zzwiudzBDlQ9ekWdnaUWHr8PkTQEPmdloGERBM
	expEaueCD4vSVYlB4LqsI+Puljb5GEQefQ4obPGOGO5382iLivk+8OAZaq5qpT5d0z4=
X-Gm-Gg: Acq92OErZ0Y6Xav+vMFBn7YUsf/HjfQnZbGIQvW+pwjLRKYnumPUjj5/qvGjg8KmyR0
	29I66cwTw+y3Xo6cM7I4X3qx07aCzHjH1madee7J71oLnunLmrbPtB+NuaYOW3LZ/Mc/rVbsnTa
	7y/SpwKb6PqvWxnFaFTJTOvss6AIaE8vx/NRU0ID+nuK3fdeTHywPOhrvfpNBl9vfDsN/AP9bUq
	4GhL1H4YNaOx32cbVNvCmFQ5buQgdndirLWzmPJpv/tIFtWb5IyAFGj1vAbhzB6kF5xNVu1UdLF
	WIJXNzCqpaKeZc1XjxbFsCLMVroj27KqKbo3MZKkG2qTObOZzNX4/+0FHTkXjBqEADA8cwneKwg
	2W/XkEmWRql73KsGbp1HxSUdSyEVXPjdPIS4IvHGEzG34slpwyMUy66+F7DCEee9Z2HARDbFxBz
	vb9W5w51Z6kQRSu24ED+Em3Zz4P0YvIXl+ZjM9eHNJmXkA5rclkXpjYCan6Hil4cplu1dC1JMbx
	qrJhLliOQs=
X-Received: by 2002:a2e:9bd5:0:b0:393:bb14:9ae with SMTP id 38308e7fff4ca-393c40ce7a6mr36476961fa.3.1778243974261;
        Fri, 08 May 2026 05:39:34 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f5fcc7sm4569621fa.18.2026.05.08.05.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:39:33 -0700 (PDT)
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
Subject: [PATCH v3 13/13] pmdomain: core: Add a couple of debug prints for sync_state
Date: Fri,  8 May 2026 14:39:02 +0200
Message-ID: <20260508123910.114273-14-ulf.hansson@linaro.org>
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

To inform the developer of what is happening during sync_state transitions
in genpd, let's add a couple of debug prints for it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- New patch.

---
 drivers/pmdomain/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index b5d90ddfd698..3d3e0f38815b 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2756,6 +2756,9 @@ static void genpd_parse_for_consumer(struct device_node *sup,
 			genpd_lock(genpd);
 			genpd->wait_for_consumer = true;
 			genpd_unlock(genpd);
+
+			pr_debug("%s: wait for consumer %pOF\n",
+				 dev_name(&genpd->dev), con);
 		}
 		mutex_unlock(&gpd_list_lock);
 
@@ -2772,6 +2775,9 @@ static void genpd_queue_sync_state(struct device_node *np)
 		if (genpd->provider == of_fwnode_handle(np)) {
 			genpd_lock(genpd);
 			if (genpd->stay_on && !genpd->wait_for_consumer) {
+				pr_debug("%s: queuing sync state\n",
+					 dev_name(&genpd->dev));
+
 				genpd->stay_on = false;
 				genpd_queue_power_off_work(genpd);
 			}
@@ -3637,6 +3643,9 @@ void of_genpd_sync_state(struct device_node *np)
 		if (genpd->provider == of_fwnode_handle(np)) {
 			genpd_lock(genpd);
 			if (genpd->stay_on) {
+				pr_debug("%s: sync state\n",
+					 dev_name(&genpd->dev));
+
 				genpd->stay_on = false;
 				genpd_power_off(genpd, false, 0);
 			}
@@ -3677,6 +3686,8 @@ static void genpd_provider_sync_state(struct device *dev)
 	case GENPD_SYNC_STATE_SIMPLE:
 		genpd_lock(genpd);
 		if (genpd->stay_on) {
+			pr_debug("%s: sync state\n", dev_name(&genpd->dev));
+
 			genpd->stay_on = false;
 			genpd_power_off(genpd, false, 0);
 		}
-- 
2.43.0

