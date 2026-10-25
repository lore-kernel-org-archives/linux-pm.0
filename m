Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956187;
	b=MInvaRa41MWKHBBhg0LzfPrq9jY8LDrWT4B4FDU0s1hibaDjznPlHbi84yPZBPptZnh9
	 RmIoK/l97QEuyb68O3CZLrEa6n0+VBkjZvx5Wtlg9aOQPS20io7EwdDnhXoCEE/iEHSnO
	 hQlxMVAsIfbefkyElnHHyh1XcL2FhW8/cd1armnwKpU1i6FZk03p6huMhwnqf1tW3T8Di
	 C7dPbwRNTCT1/TkOq2a6+MkpbL/sNqP44k2zbJ7E2zIWFjE/voL4VPiDpa0pfQL2A8r02
	 2W2MZBgn3U9yVYHe4X/eoyMrTjM/FjqW+fJp80BrrCYRiKnXlr7gjuzxmuI/fgLxd+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956187;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=9CpTE3EsuiVeioMoENebfi+wDB7/prDssc24llsmjUs=;
	b=YQ0J3ddEq3r4PdjBkd3NZmLRswMxNDbWL5pQ407pfnUUdxU/y6NnrGMxRCex3txDDHrL
	 8Yosshxb/myBxu5AlWlAUOP6EVbyXQlUyviV9I2IH1gB7WAu/D1omOaibtphEBpkQpvKi
	 GA+gMyEfdqDPaewcjbOwAhRpd7Z7Q3bGqU7naEywA7AUzSgoPM9OkKdrQaPcKibH4Fj1n
	 Pr1mMn1yG8q6b75AlWLHLU380hxUbC8CTcw5VDnyk/BFGQue8hlK+OXW2UNrnOeILxkoV
	 ECuCB3AJ37hUcqaiqf38wQdxJimsP5emct6G3xEXhOW62eZHbXgbIWp+tSAkVUe3Zeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=f2af8oWI;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B660A2600;
	Sun, 25 Oct 2026 19:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E33B660A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=f2af8oWI
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJMjmg517433
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:22:53 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJMjmg517433
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956174;
	bh=9CpTE3EsuiVeioMoENebfi+wDB7/prDssc24llsmjUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f2af8oWI8Bj5yefR0ntGcuiBhw+8M/a4n2a9RQlT6iJsdZwVvmVd7uulWPYjptXdE
	 kdSloqKJSoWUDwEaDuxRHn2RIThbLG7WPivpGeIaPV+ZffQLjAfvxo/yZGby4N44oN
	 nm30Zrp92fmoYSg0JHPSskUHZ3+qgcEoYbCeR2wo=
From: christian.koever-draxl@student.uibk.ac.at
To: glaroque@baylibre.com, rafael@kernel.org, daniel.lezcano@kernel.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 3/3] thermal/drivers/amlogic: do not log the secure monitor deferral as an error
Date: Sun, 25 Oct 2026 20:22:44 +0100
Message-ID: <20261025192244.209256-4-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025192244.209256-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261025192244.209256-1-christian.koever-draxl@student.uibk.ac.at>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: () -13.0 ALL_TRUSTED,RCV_SMTP_AUTH,RCV_SMTP_UIBK,U_H_APTO_LONG,U_RCPTS_11_PLUS
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

The thermal sensor usually probes before the secure monitor, so the
first attempt always defers and logs "Failed to get secure monitor
firmware" as an error on every boot, although the second attempt
succeeds. Use dev_err_probe(), which records the reason for the
deferral instead of logging it.

Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 drivers/thermal/amlogic_thermal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index c58bac633bed..54e59f444d46 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -196,10 +196,9 @@ static int amlogic_thermal_probe_sm(struct platform_device *pdev,
 
 	pdata->sm_fw = meson_sm_get(ph_args.np);
 	of_node_put(ph_args.np);
-	if (!pdata->sm_fw) {
-		dev_err(dev, "Failed to get secure monitor firmware\n");
-		return -EPROBE_DEFER;
-	}
+	if (!pdata->sm_fw)
+		return dev_err_probe(dev, -EPROBE_DEFER,
+				     "Failed to get secure monitor firmware\n");
 
 	pdata->tsensor_id = ph_args.args[0];
 
-- 
2.56.0

