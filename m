Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E935338939
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789961859; cv=none; b=ujC//stlG3Nfz55AmdBvzuycRh9Qyu5Gm3SuQgLE7JzJy65pxRjynkdYHvqEITD83Nbxgth8tjvWMmwZjo+A7ypzhUfkluCpMbNWEDP2mEmL7GDLjQLUbEp48ZsZbaWELokCVSMv4RLvFdWmtcYz96ho8KkACNqq000J+KzLdQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789961859; c=relaxed/simple;
	bh=AlzIW28Y5xD5eAX4CX9xsq0gjSAmNnpDF69Est26CwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umOL1Ko6Q+NBbcQG23CDsvw5bwYh1HDXbmHHViOj5tfPYcDij1/h0Wf5UszFnPxvVfzUHYMFw9zIU3/3ZXD7UgMnDH/srsSQ2B9xpsgoM+oAmp43h/0ie22PkkmeVXu75L4HyN3PHfdQ6N+7zrzEEeHgs9Tvk1vlQN9i0z9FPpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVLBinbO; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVLBinbO"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2d747f0135fso23994605ad.0
        for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 20:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789961858; x=1790566658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m+un6tjUHLWmwcQGwEsJ9cbCIh8rw9QkbUaL8mBGbKQ=;
        b=rVLBinbOibXyR9Bi+Mo6VHtZZYrkVw4KZ9hFaQUt6yW60lyp4WbW0ammASdMdKEV/+
         ZWW3twnjJ4jXzx4Kk4gWAj1kGPLdpmE4d5y1NJZRpS53/aT8QXSaHWQIM9lFxECN4FIE
         qbKNjYBxU/Ce6Q3iV+q3pA10PUJF836foIaXAT21r1btGRjYL4HV70Bw9AmWYrQzON2Z
         4N9px7Qf9oETk0ncrtLSRI+ZPaAj8kEbDWEhVFlRllI37RQ04gaWRg6pvj/BwObXEqFW
         89Z5uFLsAWyv1AO/6McH/vL6tjOiNV+2wAasV1EGARf8/hyavmJK0m0uhD3vC+5A8Zvj
         hCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789961858; x=1790566658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m+un6tjUHLWmwcQGwEsJ9cbCIh8rw9QkbUaL8mBGbKQ=;
        b=Pwg8Tp8s4kmwSOvWBXlO+qmIPjSvtUf9kepluVO2eZiOz0+CSLI/OCRK4v8r7Gce0x
         RfpGyWo+mKT4kje/M9xsJ+aqsKvXT49WRhfmmuDQEs7qBRbpQAkTW+D4IKAknoG4igch
         lmwHGNRrkrW0mfHe28FEL4oQRuOYi9i8mJ+jLO5V6p7l1rBvMqyi3t/ySsRGfTlyfO8i
         zlOUF8ic7jQNSBnmY4/4trAt2eKLfvePJDgPlW5cjq/lt/UJ2UfnepCHfTCSNvlXKTjY
         1sgTVEWMMbaXPKLhMlClNRBysozi/nffDRK/Cxewh9ElVuj2fTEA7jAqH9Wk+xsSWio0
         d2SQ==
X-Forwarded-Encrypted: i=1; AKwUvByaBF/y6WQI8VRMhwcgHq6KX3jnjSyrK1M10HFHDF5+ixIwj06qVWorA9PwzaD7XFAFKIdJbMT/ng==@vger.kernel.org
X-Gm-Message-State: AFuF++nWtuyvRAcm4GtB3XehW8PmkbdKRU885iG4AEc/dL3CK4WJWhsj
	7r82OopcYPyF0SBka8/6kwg2acEgCH7wgM2UKT8ZR6ObqzETVDMjPDpr
X-Gm-Gg: AYBFou3nXJwYMq0hVY0En6DYWBqh4s3x21Qjt6O6tOpiakwO7GphYwhvtAr/V+ndg2E
	QyP3NmE7zhjXWa2tUS+cUHgTi6FuWgcxmW4sr4bCgsyKyuc2IGYMnMZt5yWaDN0gtmx3lCco/Au
	x6PKPqWNik8b3ee2kWO3wLCyAnFcqpVw9zRpVpEgfhn46RFJJleD3RI//HTsFMGoyZ7JA4UQVWk
	0WebLLSOIax38feBmMU3hnt8GIBkx1Cl/J/msZk1grWCJzRqxxGO2G8iLmrcBx53T6D7wKp2zvN
	ojaxThwRtz2pXGDmCpjEKNo1iMLKfJ/J3waaVl/iowCn7VZpVxtf99XYIuh8o5IrGyKeGtdqny9
	F05tmBEjH5Grd7EEn3ewDZ0tsKUL1Eowh2S2/wdSi0LxBD03WNc20fEmoVEbtJ9jv2z+UbpzKbn
	S+zi0caV9WXLqF6PtTUqQ9t43YO6+9sIalxbEZI3cgQOYbOXc04MliNIvEhinw+jvN+vbM0RrKl
	9/41M5XddJ+O+N3OM6ScuUWK5YHamW9tRJuIQJh3nL0uhyLKeYslWfa03COBYAkvqlr6RAJ16Qy
	gLInxyTMkf4n+g==
X-Received: by 2002:a17:903:324f:b0:2dd:c053:9c6c with SMTP id d9443c01a7336-2ddc0539d9cmr89231915ad.34.1789961858000;
        Sun, 20 Sep 2026 20:37:38 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc18032d5sm25966515ad.83.2026.09.20.20.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 20:37:37 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Ulf Hansson <ulfh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	rafael.j.wysocki@intel.com,
	Jacky Bai <ping.bai@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Ming Qian <ming.qian@oss.nxp.com>,
	u.kleine-koenig@baylibre.com,
	Marco Felsch <m.felsch@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Guoniu Zhou <guoniu.zhou@oss.nxp.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 2/3] pmdomain: imx8m-blk-ctrl: Use pm_runtime_resume_and_get()
Date: Mon, 21 Sep 2026 10:37:07 +0700
Message-ID: <20260921033708.14433-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921033708.14433-1-phucduc.bui@gmail.com>
References: <20260921033708.14433-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Replace the open-coded pm_runtime_get_sync() + pm_runtime_put_noidle()
error handling pattern with pm_runtime_resume_and_get(), which already
does this internally.

No functional change.

Found by manual code inspection.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 479789009c7f..fe083b1e7251 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -99,9 +99,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 	int ret;
 
 	/* make sure bus domain is awake */
-	ret = pm_runtime_get_sync(bc->bus_power_dev);
+	ret = pm_runtime_resume_and_get(bc->bus_power_dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(bc->bus_power_dev);
 		dev_err(bc->dev, "failed to power up bus domain\n");
 		return ret;
 	}
@@ -382,20 +381,16 @@ static int imx8m_blk_ctrl_suspend(struct device *dev)
 	 * in the system suspend/resume paths due to the device parent/child
 	 * hierarchy.
 	 */
-	ret = pm_runtime_get_sync(bc->bus_power_dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bc->bus_power_dev);
+	ret = pm_runtime_resume_and_get(bc->bus_power_dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	for (i = 0; i < bc->onecell_data.num_domains; i++) {
 		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
 
-		ret = pm_runtime_get_sync(domain->power_dev);
-		if (ret < 0) {
-			pm_runtime_put_noidle(domain->power_dev);
+		ret = pm_runtime_resume_and_get(domain->power_dev);
+		if (ret < 0)
 			goto out_fail;
-		}
 	}
 
 	return 0;
-- 
2.43.0

