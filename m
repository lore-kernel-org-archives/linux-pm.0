Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656EE3E123A
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243978; cv=none; b=Aa3eXhGyzyd0nxO9ILVWR2pOjeEj55f6WRFbnLfPkXv1787Vfca03qmWsB4Yxu2h8jp9KfWho56P6qeKi2/8hWHrI5G52Y/GTXCCZh1Lgle/4ntxh9hO1cZNyaq/EjIJ5RC3uIMv16KpB9KCKbFYKgelEQomDv2p40vuQUpTKeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243978; c=relaxed/simple;
	bh=H6q4OVKbLdwM5DS1ok0o5JbRxgmDunwRDH7Ew2Jb3pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mE3R1twZ/8BT+K5wNprCoM9JOKmFrPAeV08llk4cZ6wRc5AXXpaaB6PuS75zGkeC+6KL9MQp/a/r+TLWX38kbnvNBUhyGOxFlspQ3TusjgEdtsOggEAt0JNdY/sOy+nC6PgyIrX7AATonk9m0eq8sJOn3wEhrhI9gFOYbPAq8j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CIpDbCXM; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIpDbCXM"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38e97e73234so18109731fa.1
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 05:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778243968; x=1778848768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/3tOYCHKLkB93CvHpDrXeQBRydo0wK6XTWaKDAjWlE=;
        b=CIpDbCXM0XDKrDOp6JXoCZtn2XxJN25uBR1fPe3EmiEqoYwls/aoHo0CNo5PUmIiSW
         A5h0X2NGP3WIRmDHQ3GrmU9Yo0SeqYs8Twrdxp7cFY8ufRlwtQm+VMeHVOFVNU6otcxp
         jXiv0mm0yWdzHu8N3QYER3JR5APCnVqSbTHh9hTqSUDpdIw3XAOKUEBg+6bwz5b9Z10w
         W8K/nxkqBT3p8DG5oyziqNCj5X62qZiYOUUQHFNwu2mYsbgM87JT4HwAI+Xv60WLp8Yg
         ruQchjFL6vcZtpbgVp44/5iidIRGScbCMvRlbJxaqA2VqZy2VxZirbYezXQ2MK6Ai42X
         +/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778243968; x=1778848768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F/3tOYCHKLkB93CvHpDrXeQBRydo0wK6XTWaKDAjWlE=;
        b=SdZ4QV6rVs57UHT5dp80D8lUsTZXX7SEalBgCkigHXImkgbHf/TL4pzWMz/9eQKaVz
         Zn8jLjrjErUTJsCBCWLcLZaJDMarHQIApPgIzNMFPGyviHs5+m2q0au/LzTzhPz8tLxd
         zvy8oSqTnpx9w5+DbvhV9o00Ng03YHZs/gCnVjPG9cGxzdnskuaqimFj8CgSqnDPa4LY
         J274Ekl1difB2Uak1BbOoGGgmziDMCWze5oHGp2PqNKHIIF26f1KLr+3KYQvbiRxqRIj
         ICeyoyTaEFBSk+MKK9TRNYH28BaDPVXusRcGqq8OKthecZZs/G+lnf7HHFJGy0HbYfGW
         5Djw==
X-Forwarded-Encrypted: i=1; AFNElJ8oTKj6YsYyyxi4CeygA39HTMDwQKfDw/bf5OnRzzb5ZMkDaVjl1xMfB8+3G6e2AfK1Q9wZ9zkifQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd9TKsAQN2JCeCo2VV6cxc7gRtikLJYyy0/G41R3ryKk32FJeM
	LcYHxoliI28WBjr9CB1ImsnN+W2Kko6nsSToXk2pIGTyK1d1QOOuPZMegjrH3fKQeUk=
X-Gm-Gg: Acq92OEzM1Wih9Mfi5zzPQvbFYUvhytH8faqw7a6oB/5rJcWAhFtsnXtqbqzMQwqWC0
	TGDlTCZI2eGeShSoam8eAA6vRmE8qdjVWIOKUeVDPJg9ajIkdsN2QY16MXzMOmUmfVuipYMaWqj
	6inaa2qtCrYdTRlUZDgoR9e2jtZSlhvFNjS5g4f1Oo3DNmGbKhpFbCsRpOtfT8rooOnqqUn/SYU
	dWZIpCaDIuO/slfsv9WZZiSHrBCqTJRKpUw6ZIt+xsy38JzCutY96TEDu7NNM7WiKsU96ZqLWLi
	9IrLGZaVxg0OABu7ZcD+O11qcuh3dahSu0X9GlUnQ1hXkqlKu6xweRaeKziE/7dMTXXJAsjiQoS
	/kOLyNGUANsJPoKHAKupHu9XovvsXmBSj5i3uodYgAexWY+PLBOpb0unGXEaMskivic4AA11r0y
	XUi2VZ2Kjaim/IN1ISyG8YFJSqOaJ56d0he39D0Sr1Xwely2WLeEUwDYn1ADedzTchKcqGsv9x
X-Received: by 2002:a2e:9b14:0:b0:38d:ed62:f1d5 with SMTP id 38308e7fff4ca-393c41c6f32mr39109701fa.17.1778243967432;
        Fri, 08 May 2026 05:39:27 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f5fcc7sm4569621fa.18.2026.05.08.05.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:39:27 -0700 (PDT)
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
Subject: [PATCH v3 08/13] pmdomain: core: Export a common function for ->queue_sync_state()
Date: Fri,  8 May 2026 14:38:57 +0200
Message-ID: <20260508123910.114273-9-ulf.hansson@linaro.org>
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

Along with of_genpd_sync_state() that genpd provider drivers may use to
manage sync_state, let's add and export of_genpd_queue_sync_state() for
those that may need it. It's expected that the genpd provider driver
assigns it's own ->queue_sync_state() callback and invoke the new helper
from there.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- No changes.

---
 drivers/pmdomain/core.c   | 14 +++++++++-----
 include/linux/pm_domain.h |  2 ++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index b2b5cc30c7fc..b3ec3dec3f10 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2763,7 +2763,7 @@ static void genpd_parse_for_consumer(struct device_node *sup,
 	}
 }
 
-static void _genpd_queue_sync_state(struct device_node *np)
+static void genpd_queue_sync_state(struct device_node *np)
 {
 	struct generic_pm_domain *genpd;
 
@@ -2781,11 +2781,14 @@ static void _genpd_queue_sync_state(struct device_node *np)
 	mutex_unlock(&gpd_list_lock);
 }
 
-static void genpd_queue_sync_state(struct device *dev)
+void of_genpd_queue_sync_state(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 	struct device_link *link;
 
+	if (!np)
+		return;
+
 	if (!genpd_should_wait_for_consumer(np))
 		return;
 
@@ -2809,8 +2812,9 @@ static void genpd_queue_sync_state(struct device *dev)
 		genpd_parse_for_consumer(np, consumer->of_node);
 	}
 
-	_genpd_queue_sync_state(np);
+	genpd_queue_sync_state(np);
 }
+EXPORT_SYMBOL_GPL(of_genpd_queue_sync_state);
 
 static void genpd_sync_state(struct device *dev)
 {
@@ -2921,7 +2925,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 		sync_state = true;
 	} else if (!dev_has_sync_state(dev)) {
 		dev_set_drv_sync_state(dev, genpd_sync_state);
-		dev_set_drv_queue_sync_state(dev, genpd_queue_sync_state);
+		dev_set_drv_queue_sync_state(dev, of_genpd_queue_sync_state);
 	}
 
 	put_device(dev);
@@ -3653,7 +3657,7 @@ static void genpd_provider_queue_sync_state(struct device *dev)
 	if (genpd->sync_state != GENPD_SYNC_STATE_ONECELL)
 		return;
 
-	genpd_queue_sync_state(dev);
+	of_genpd_queue_sync_state(dev);
 }
 
 static void genpd_provider_sync_state(struct device *dev)
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 7aa49721cde5..d428dd805c46 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -467,6 +467,7 @@ int of_genpd_remove_subdomain(const struct of_phandle_args *parent_spec,
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
+void of_genpd_queue_sync_state(struct device *dev);
 void of_genpd_sync_state(struct device_node *np);
 
 int genpd_dev_pm_attach(struct device *dev);
@@ -513,6 +514,7 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
 	return -ENODEV;
 }
 
+static inline void of_genpd_queue_sync_state(struct device *dev) {}
 static inline void of_genpd_sync_state(struct device_node *np) {}
 
 static inline int genpd_dev_pm_attach(struct device *dev)
-- 
2.43.0

