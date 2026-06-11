Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DB1400E12;
	Thu, 11 Jun 2026 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182959; cv=none; b=AshG5rHbHe/bh6cswJV+Z4WUQWEfoCz5b74BKm1WAa+QGtQzn+T1pdGTKC0ctoXO5CrBucYrBAq4FSJoWIwFaQWEHkH7a3G/LXggmQGnYwexgB0AZ0+TeNlRABCJjB3XnHSfAqe48B1qJVGrTFKfYQ8YIEdf+QJExDKMpKkmcBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182959; c=relaxed/simple;
	bh=UnUos+YOTrKY1bgiVNiQVcZhvMosLL2ZAQ3e0SBycBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W16qBWw/kQKS7yDD7qP73iGaNnQMk2Ya0NqIUyhLcTK2Z/q/qJXyWjWNftpVSQteZtrL2YmYrUjE7i5g5miJs8fyiKNNUDNvM0VqujzL0XaXyS8/0FD+WFm9/1lxlWHVhZ9HIkdhQ70/veNEtX+a7rAdKmLFzHyHjEstOy37z7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F951F00893;
	Thu, 11 Jun 2026 13:02:33 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 3/9] pmdomain: arm: scmi: Add always-on support
Date: Thu, 11 Jun 2026 15:02:07 +0200
Message-ID: <7a2539873a80840eb2ebce4479cbc83a1fbf5579.1781171705.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781171705.git.geert+renesas@glider.be>
References: <cover.1781171705.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the PM domain flags with the flags advertized by the SCMI core.
For now this is limited to GENPD_FLAG_ALWAYS_ON.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Questions:
  - Should the power_ops->state_get() call be skipped in case of an
    always-on domain, and state just be force to
    SCMI_POWER_STATE_GENERIC_ON instead?
  - Should the power_ops->state_set() call be skipped in case of an
    always-on domain? Or might this cause issues with some firmware
    implementations?
Skipping these calls may avoid adding quirk code later...
---
 drivers/pmdomain/arm/scmi_pm_domain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
index 965592e828741b11..8e67f971c707e121 100644
--- a/drivers/pmdomain/arm/scmi_pm_domain.c
+++ b/drivers/pmdomain/arm/scmi_pm_domain.c
@@ -104,7 +104,8 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 		scmi_pd->genpd.name = scmi_pd->name;
 		scmi_pd->genpd.power_off = scmi_pd_power_off;
 		scmi_pd->genpd.power_on = scmi_pd_power_on;
-		scmi_pd->genpd.flags = GENPD_FLAG_ACTIVE_WAKEUP;
+		scmi_pd->genpd.flags = GENPD_FLAG_ACTIVE_WAKEUP |
+				       info->genpd_flags;
 
 		pm_genpd_init(&scmi_pd->genpd, NULL,
 			      state == SCMI_POWER_STATE_GENERIC_OFF);
-- 
2.43.0

