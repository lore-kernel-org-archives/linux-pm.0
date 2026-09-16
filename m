Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25133EC689
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541379; cv=none; b=XfPDdiAZ6TMS+tioauh7HZmU74PgGIK6hmIfkzWIPu9/Ltat1Cjfh4oAuxlqJlkgTypL26IYsNEYkre8lOIK2xnm6PTfJDZ/CrC8wmhkLXhNUmNOV1sSRJSOTJOQUeqUDbfMaiEFHrgrea8RAgkkzKhdKvZ/5VTlg02kQtTwJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541379; c=relaxed/simple;
	bh=eH6Z0bagtaYXrQdhnMsivIb+LQCMIUWBzL+fCBHKEBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GGlMaxX/D2RvT3H/dCtpV4INvWKnp0SoU2qV66hyURpym/cKo6plKpagBVNe/+CJkJrkkkwKqXgYQqnExdlWVkt5qFyTL3uMpR5ocEQQbw2AUiT6Kxe5cG3vSaBbP1eRGDEns2/3FVn7fBBpGFxrOCubHe7IKnYe2EODxojpfKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZ5Q+o43; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ5Q+o43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0715C1F00893;
	Wed, 16 Sep 2026 06:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541377;
	bh=JYbvpzJEECjSAPbutmx9CcyxvqS1nf3WkHlegTgwsU4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KZ5Q+o43FoU/+iwyxyTiIRx1Bv8mr8Fn7ojGeUuoUdQjigzFK9ICt+SDEuLiLF9i3
	 IOSrwl5OSGN/iinDCM3eSZ0yakVlmeHV1AHcfqHML8nJcHQPSE95sS5ADo97WZ3ltF
	 +3fKO2o1c8i8Zc+cb69mhmgLWZrUQxkxDy8GP0zn83Tr31rLTUJFApKZKLBOqHtVaf
	 6CPSQIM7cEo+8I14CKHB8gUnQ9PIWvTNFrD+yUAGNYLgjmrzJ/cjxzH42qSiNP+4fI
	 fySQ+/Guwee2xiRQ3BPB765a+c0aLGiX5YInvssP+4nbSKjlKY4dmjcy/tif5s7ifX
	 3pJ9LIB3mns5w==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 08:49:32 +0200
Subject: [PATCH 10/15] power: supply: ab8500_charger: Handle detection
 errors
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ab8500-charging-v1-10-e986ed321cc6@kernel.org>
References: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
In-Reply-To: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

ab8500_charger_detect_chargers() returns either a charger bitmask or
a negative register-access error. The probe and component-bind paths
use a negative return value as a bitmask, making failed reads appear
as both AC and USB connections.

Propagate detection errors and release the bind-time workqueue on
failure.

Fixes: 84edbeeab67c ("ab8500-charger: AB8500 charger driver")
Fixes: 1c1f13a006ed ("power: supply: ab8500: Move to componentized binding")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/power/supply/ab8500_charger.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 08042ef222be..938c3923afde 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3462,6 +3462,10 @@ static int ab8500_charger_bind(struct device *dev)
 	}
 
 	ch_stat = ab8500_charger_detect_chargers(di, false);
+	if (ch_stat < 0) {
+		destroy_workqueue(di->charger_wq);
+		return ch_stat;
+	}
 
 	if (ch_stat & AC_PW_CONN) {
 		if (is_ab8500(di->parent))
@@ -3747,6 +3751,10 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 
 	/* Identify the connected charger types during startup */
 	charger_status = ab8500_charger_detect_chargers(di, true);
+	if (charger_status < 0) {
+		ret = charger_status;
+		goto remove_ab8500_bm;
+	}
 	if (charger_status & AC_PW_CONN) {
 		di->ac.charger_connected = 1;
 		di->ac_conn = true;

-- 
2.55.0

