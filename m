Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A784E07
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681942; cv=none; b=mCdP6fQRybp/XKeBHdnuhDlERUhk7n73JwqTgmdYK2ILW+2v4fh0dm2dvLOdM+NezxRRD4ynuX718bFN7z5P1kYFhNuQMhSimgz15StRpvyrI+z0aAUAArvYcjGC54PUBG9Q7eFaJ4vBr/20rhVjjb6rwLOqnjnLbWAG54HfToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681942; c=relaxed/simple;
	bh=qnB3kOsJx+LjIBBskfGZuwSC62pWX2rtYfa3mZlPanQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GLheypvRzs+S0ORxvH6TmzAGVd8pS42XDSBXLq699H6sobyO4UiE1vUXrognCtb01LWly2DPAGtHFzx1sre08Kpl91jZSAuLaixiZJcgMDvJNncdPGDL+V367bvsvoZdvjNillHcbuHdU9EbuswHlk4heKHg2cO+gkAmZcRyWHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ABGb3RIN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ef0bT+1H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ABGb3RIN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ef0bT+1H"
Date: Tue, 14 May 2024 10:18:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omQ5tKvXy5VdnnBKSs7Y9GRRFeuXBCa+4Xvcw+0/+DY=;
	b=ABGb3RIN87gGiEibPsVtNxA0X6VCHj9ufwfDYBRNThXJ4eNX+iRl0l3idlvpAv0vp54zvp
	Ye+3fOfs2PTho5lk2jOOpfD/ym8bhz+LjZOpX8a2Eu1c0aumHlHGb4tNkXd9mPbLosx7dl
	+797zB+OxolMoGLzf+nC33NZTd2xIrlM5RnumlYMkdZcpFmAu+A5m80GvSBYlCvxPsdTlX
	V63AfHFbf8xudYI33PqFUB4eC6GonklvNWJfd66mmhGA2MaSMPYjSd3JOsTx7P4IvZq87k
	z4LoFvE7auMVGlysXf/5A+CrCaxFmkNlxQ4TOSVYAprN3JEzPPY1fixaYFDozw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omQ5tKvXy5VdnnBKSs7Y9GRRFeuXBCa+4Xvcw+0/+DY=;
	b=Ef0bT+1H0L9lQGLBeYQEPLJEout393hkrkAePVsvkLlZpG0XxirCAULQPBFwUymXJpf+JQ
	7HsU0jk5U2uU0ACw==
From: "thermal-bot for Nicolas Pitre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject:
 [thermal: thermal/fixes] thermal/drivers/mediatek/lvts_thermal: Move comment
Cc: Nicolas Pitre <npitre@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240402032729.2736685-3-nico@fluxnic.net>
References: <20240402032729.2736685-3-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193434.10875.6225606100873931008.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     62194e637d16ac9b61eec0bfe6d5f662efcddbe7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//62194e637d16ac9b61eec0bfe6d5f662efcddbe7
Author:        Nicolas Pitre <npitre@baylibre.com>
AuthorDate:    Mon, 01 Apr 2024 23:25:36 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:29 +02:00

thermal/drivers/mediatek/lvts_thermal: Move comment

Move efuse data interpretation inside lvts_golden_temp_init() alongside
the actual code retrieving wanted value.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240402032729.2736685-3-nico@fluxnic.net
---
 drivers/thermal/mediatek/lvts_thermal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index d266626..0401162 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -734,11 +734,15 @@ static int lvts_calibration_read(struct device *dev, struct lvts_domain *lvts_td
 	return 0;
 }
 
-static int lvts_golden_temp_init(struct device *dev, u32 *value, int temp_offset)
+static int lvts_golden_temp_init(struct device *dev, u8 *calib, int temp_offset)
 {
 	u32 gt;
 
-	gt = (*value) >> 24;
+	/*
+	 * The golden temp information is contained in the 4th byte (index = 3)
+	 * of efuse data.
+	 */
+	gt = calib[3];
 
 	if (gt && gt < LVTS_GOLDEN_TEMP_MAX)
 		golden_temp = gt;
@@ -762,11 +766,7 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
 	if (ret)
 		return ret;
 
-	/*
-	 * The golden temp information is contained in the first chunk
-	 * of efuse data.
-	 */
-	ret = lvts_golden_temp_init(dev, (u32 *)lvts_td->calib, lvts_data->temp_offset);
+	ret = lvts_golden_temp_init(dev, lvts_td->calib, lvts_data->temp_offset);
 	if (ret)
 		return ret;
 
