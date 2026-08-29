Received: from tabos.org (krueger-it.net [145.239.1.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8434E3515D6;
	Sat, 29 Aug 2026 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.1.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787982353; cv=none; b=WRTrj7jYSGoXh4UFMGYqmV7UyavlkEox7VHkAhvPdw8LdpClEG19WgD+f7eDOWvApn7tqqBwEj0Zo7WFHNFy70QTNWG+Xk3xnPHnL7M/Lgni5vmiNt+XVklM9NnrO2Hil8dA44GPAM6WojeSzTgz+dgHdgalGvGFMoaTxVSJsC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787982353; c=relaxed/simple;
	bh=jQvxuaBUGEhm8QKeQrjTq6n7ep1RIm+6JIa1tIlq+gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSXivQSv9BhACsFgA4iEp0dBMT+UdARocCIuZiIO5mgzF4vleMldZyFCHo4R3htTF5VklhWxkq+t8YQ1Cexj97vg89BRAB3kPk02vxud7aalOd6neQGzhdhvHS0wML68YUcWThSF2VF5jhIzSnIm4wKHufmuv1KHMM83PO+wJ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org; spf=pass smtp.mailfrom=tabos.org; dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b=WiLHcZwq; arc=none smtp.client-ip=145.239.1.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tabos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b="WiLHcZwq"
Received: from c0d1ngstat1on.fritz.box (unknown [94.31.74.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by dserver.krueger-it.net (Postfix) with ESMTPSA id 8BFB362E0A1D;
	Sat, 29 Aug 2026 07:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tabos.org;
	s=default; t=1787982350;
	bh=DEMWeQXE4wR41WENBWo04eG+CfXiZmvF+kwvZ+fBE80=; h=From:To:Subject;
	b=WiLHcZwqPaj8ctnVI1amWP9nBo36+oPhIFLfgNmMzc+2r0ArfmEQtI+H2V7BSDf5U
	 xrtRBse/TjTARbUQKbXdoY2T9vjUxAr2L1plJxBsFgqGYrp5DNhzaGSX+Up3/QmEi+
	 ANfCkvICBGpx9xUDs+zoIqrfe2p4v33n+2q4DoXkBKtw5nzxArHN7Zt/n6vBNAwN0f
	 dyeJJKlqk24cv1MFA2pn9gDUogD8bdhlj7Jtv05Zvl55teZ0xCPnDoCPeOdRcSJeEJ
	 2BN9wJAkR/uNQcyyzEqeaezOh0uP+0uEheyr5dxJ1mmPTohdRJ74yoW26ItkxNeZoK
	 JREQ7Cza8P1Ng==
Authentication-Results: dserver.krueger-it.net;
	spf=pass (sender IP is 94.31.74.100) smtp.mailfrom=jan.brummer@tabos.org smtp.helo=c0d1ngstat1on.fritz.box
Received-SPF: pass (dserver.krueger-it.net: connection is authenticated)
From: Jan-Michael Brummer <jan.brummer@tabos.org>
To: sre@kernel.org
Cc: andersson@kernel.org,
	neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan-Michael Brummer <jan.brummer@tabos.org>
Subject: [PATCH 1/2] power: supply: qcom_battmgr: fix CHARGE_FULL* on SM8350-class firmware
Date: Sat, 29 Aug 2026 07:45:45 +0200
Message-ID: <20260829054546.86210-2-jan.brummer@tabos.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829054546.86210-1-jan.brummer@tabos.org>
References: <20260829054546.86210-1-jan.brummer@tabos.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

battmgr->unit is only ever assigned in the BATTMGR_BAT_INFO handler of
the SC8280XP callback. The SM8350-class firmware does not implement that
request - every property is fetched individually via
BATTMGR_BAT_PROPERTY_GET - so unit keeps its zero-initialised value,
QCOM_BATTMGR_UNIT_mWh.

POWER_SUPPLY_PROP_CHARGE_FULL and POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN
are guarded by 'if (unit != QCOM_BATTMGR_UNIT_mAh) return -ENODATA;',
hence both properties always fail on these platforms, even though the
values are requested from the firmware and stored in
info.last_full_capacity and info.design_capacity on every access:

  $ cat /sys/class/power_supply/qcom-battmgr-bat/charge_full
  cat: read error: No data available

Without a full charge value userspace cannot derive an absolute energy
level, so UPower reports a zero energy level and never computes a
time-to-empty/time-to-full estimate:

    energy:              0 Wh
    energy-full:         0 Wh
    energy-rate:         12.4713 W
    percentage:          59%

The firmware of this class reports charge domain values, so set the unit
statically when registering the SM8350/SM8550 power supplies. With this
patch the properties read back consistently on a Fairphone 5:

  charge_full         4116000
  charge_full_design  4260000
  capacity            85

Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Signed-off-by: Jan-Michael Brummer <jan.brummer@tabos.org>
---
 drivers/power/supply/qcom_battmgr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 490137a..98a70e1 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1690,6 +1690,14 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
 					     "failed to register wireless charing power supply\n");
 	} else {
+		/*
+		 * The SM8350-class firmware has no BATTMGR_BAT_INFO request, so
+		 * @unit is never populated from the firmware. It reports charge
+		 * domain values, so set it statically here - otherwise the
+		 * CHARGE_* properties are rejected with -ENODATA.
+		 */
+		battmgr->unit = QCOM_BATTMGR_UNIT_mAh;
+
 		if (battmgr->variant == QCOM_BATTMGR_SM8550)
 			psy_desc = &sm8550_bat_psy_desc;
 		else
