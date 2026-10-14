Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C234E73D8;
	Wed, 14 Oct 2026 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980465; cv=none; b=hl8dbf+UlpNklczSgnrlrg1nOKsSv/KPUANGVIo9FzMJbIKoMRH0maIEO9QGUHG7zLor5ewyfCOFgp63/JHY0SFX3gFvYDhfvjdbGTTsezQaswF4srH3oEikNhHNzXrFFTOlhhADC+bFV7bast0euopj/e1Flaq6hPAvXWymyvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980465; c=relaxed/simple;
	bh=YlMtUctVJRp5GWqkAP011pWd77/1pd6AA7HYF/hZixo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LXymQyT//L5A7jY6QJeYmGMk76MMPVzTVPQzpchlP1+5voyFeXchSVqIxhktgsXlOv6xWNefpQaAO3xR+pOdxhyvimCJ1sfF/DGK+j3J/NnPMOkAPhK+R4/+PAX6aHtljkmkoDJL61yHzaLepcjUVHziDNAdUoe/rWXgBNK74IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UM8WZiWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM8WZiWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24C71F00893;
	Wed, 14 Oct 2026 12:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980463;
	bh=zLCybkrOGqOxtOyXL/E7onAq2N3aGYMHDzjL8g5IC4k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UM8WZiWp197ST4u2RMvPDgDLviKNmeqbalHFyzZ5rO2BgqyP9sbdbMuemrM8SH4Gv
	 8VFytL+oVMwU7LWhO/P8ZiRgGPcFYx55iVlFG12FJjHFoHmvRzhETwzCnLjHQEVaze
	 YjUNZ7dpKgxQw2h/Fw5K5dtirKxjEfi25tZDvhX9ImNeyYmggz2iV6DYk6+wRdx4hg
	 kiqL6jwpyNdGtNU6kDqyWaQefk/V//2xIN1sHQEunOYkBMetcPDzuc/p8xjFUp3w3F
	 R6HksX5Gxi4+L0KiIE/2x5QUOXDxgfceK0fyUvXRBg5LPFrXmmX9LJHX0zCB+TGkZF
	 sR/1Xsqj8idOg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 Oct 2026 14:19:03 +0200
Subject: [PATCH RFC 03/16] OPP: Retry failed default single-clock
 transitions
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-topic-qc_clk_dvfs-v1-3-3041b788e9f7@oss.qualcomm.com>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
In-Reply-To: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mike Tipton <mike.tipton@oss.qualcomm.com>, 
 Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791980431; l=6611;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=dC9bPdU4yRibTue+RleczVjyqvIQKVcqEfNHe0XK/QY=;
 b=oyB2N862jB1I6q3v1b8oq5/VaMtzH5flhclgrLztDKQppeVZw/SeZcDrNS037jkR7UufBNmnL
 wSDjN4ZEmaCDdcvkzszlPrvWN4LjsJTnOjzmEvhNoP3sFAePBseRNdW
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A failed OPP transition need not leave the clock at the last successful
OPP's frequency. If hardware changed before the error, the default
single-clock path can subsequently skip a necessary retry because its
cached OPP matches the request. It can also choose voltage and dependency
ordering relative to the wrong operating point.

Treat an incomplete transition as dirty and use the observed clock rate
to establish retry direction. Do not trust same-OPP or same-rate
shortcuts, or allow table disable, until the state has been reconciled.

Limit this to the default single-clock path: custom callbacks can have
additional state which cannot be recovered from a clock-rate readback.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/opp/core.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++-------
 drivers/opp/opp.h  |  2 ++
 2 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4ccce7b6afcb..340911d2971e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1073,11 +1073,11 @@ _opp_config_clk_single(struct device *dev, struct opp_table *opp_table,
 	}
 
 	ret = clk_set_rate(opp_table->clk, freq);
+	opp_table->current_rate_single_clk = clk_get_rate(opp_table->clk);
 	if (ret) {
+		opp_table->config_dirty_single_clk = true;
 		dev_err(dev, "%s: failed to set clock rate: %d\n", __func__,
 			ret);
-	} else {
-		opp_table->current_rate_single_clk = freq;
 	}
 
 	return ret;
@@ -1261,6 +1261,28 @@ static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
 	opp_table->current_opp = opp;
 }
 
+static bool _opp_uses_default_single_clk(struct opp_table *opp_table)
+{
+	return opp_table->config_clks == _opp_config_clk_single &&
+	       opp_table->clk_count == 1;
+}
+
+static struct dev_pm_opp *_find_current_opp_strict(struct opp_table *opp_table)
+{
+	unsigned long freq;
+
+	if (IS_ERR(opp_table->clk))
+		return ERR_CAST(opp_table->clk);
+
+	freq = clk_get_rate(opp_table->clk);
+	if (!freq)
+		return ERR_PTR(-ERANGE);
+
+	opp_table->current_rate_single_clk = freq;
+
+	return _find_freq_ceil(opp_table, &freq);
+}
+
 static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
 {
 	int ret;
@@ -1297,20 +1319,40 @@ static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
 static int _set_opp(struct device *dev, struct opp_table *opp_table,
 		    struct dev_pm_opp *opp, void *clk_data, bool forced)
 {
+	bool default_single = _opp_uses_default_single_clk(opp_table);
+	struct dev_pm_opp *actual_opp __free(put_opp) = NULL;
 	struct dev_pm_opp *old_opp;
 	int scaling_down, ret;
 
-	if (unlikely(!opp))
-		return _disable_opp_table(dev, opp_table);
+	if (unlikely(!opp)) {
+		if (default_single && opp_table->config_dirty_single_clk)
+			return -EBUSY;
+
+		if (default_single)
+			opp_table->config_dirty_single_clk = true;
+
+		ret = _disable_opp_table(dev, opp_table);
+		if (!ret && default_single)
+			opp_table->config_dirty_single_clk = false;
+
+		return ret;
+	}
 
 	/* Find the currently set OPP if we don't know already */
 	if (unlikely(!opp_table->current_opp))
 		_find_current_opp(dev, opp_table);
 
 	old_opp = opp_table->current_opp;
+	if (default_single && opp_table->config_dirty_single_clk) {
+		actual_opp = _find_current_opp_strict(opp_table);
+		if (IS_ERR(actual_opp))
+			return PTR_ERR(actual_opp);
+		old_opp = actual_opp;
+	}
 
 	/* Return early if nothing to do */
-	if (!forced && old_opp == opp && opp_table->enabled) {
+	if (!forced && !opp_table->config_dirty_single_clk &&
+	    old_opp == opp && opp_table->enabled) {
 		dev_dbg_ratelimited(dev, "%s: OPPs are same, nothing to do\n", __func__);
 		return 0;
 	}
@@ -1324,6 +1366,9 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 	if (scaling_down == -1)
 		scaling_down = 0;
 
+	if (default_single)
+		opp_table->config_dirty_single_clk = true;
+
 	/* Scaling up? Configure required OPPs before frequency */
 	if (!scaling_down) {
 		ret = _set_required_opps(dev, opp_table, opp, true);
@@ -1391,10 +1436,12 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 	}
 
 	opp_table->enabled = true;
-	dev_pm_opp_put(old_opp);
+	dev_pm_opp_put(opp_table->current_opp);
 
 	/* Make sure current_opp doesn't get freed */
 	opp_table->current_opp = dev_pm_opp_get(opp);
+	if (default_single)
+		opp_table->config_dirty_single_clk = false;
 
 	return ret;
 }
@@ -1432,8 +1479,14 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		 * equivalent to a clk_set_rate()
 		 */
 		if (!_get_opp_count(opp_table)) {
-			return opp_table->config_clks(dev, opp_table, NULL,
-						      &target_freq, false);
+			int ret;
+
+			ret = opp_table->config_clks(dev, opp_table, NULL,
+						     &target_freq, false);
+			if (!ret && _opp_uses_default_single_clk(opp_table))
+				opp_table->config_dirty_single_clk = false;
+
+			return ret;
 		}
 
 		freq = clk_round_rate(opp_table->clk, target_freq);
@@ -1460,7 +1513,8 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		 * value of the frequency. In such a case, do not abort but
 		 * configure the hardware to the desired frequency forcefully.
 		 */
-		forced = opp_table->current_rate_single_clk != freq;
+		forced = opp_table->config_dirty_single_clk ||
+			 opp_table->current_rate_single_clk != freq;
 	}
 
 	return _set_opp(dev, opp_table, opp, &freq, forced);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 9eba63e01a9e..4f0ec888effa 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -172,6 +172,7 @@ enum opp_table_access {
  * @parsed_static_opps: Count of devices for which OPPs are initialized from DT.
  * @shared_opp: OPP is shared between multiple devices.
  * @current_rate_single_clk: Currently configured frequency for single clk.
+ * @config_dirty_single_clk: Whether the single clk cached state is untrustworthy
  * @current_opp: Currently configured OPP for the table.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
  * @required_opp_tables: List of device OPP tables that are required by OPPs in
@@ -221,6 +222,7 @@ struct opp_table {
 	unsigned int parsed_static_opps;
 	enum opp_table_access shared_opp;
 	unsigned long current_rate_single_clk;
+	bool config_dirty_single_clk;
 	struct dev_pm_opp *current_opp;
 	struct dev_pm_opp *suspend_opp;
 

-- 
2.56.0

