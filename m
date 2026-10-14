Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F884E06CF;
	Wed, 14 Oct 2026 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980488; cv=none; b=J3AiFc7fvD3FTTZCdcfdW84DPKmeWmVDojoRDpuO29WHiDC2PE4DPVIOCnBARzIDMO2irZav6W2SRbv3ruXh0s/Y68XIW+UUN2aY9WiTKPzJH1V9q143184q6GiqpGrIqqXeVS0/5ZasTvtg9JUGpz09NXaM3bb23/jHOuX1+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980488; c=relaxed/simple;
	bh=eiNwYZ7DOFYz3AQwYcMsSob3GKgtEV0IN0VL3ZAjzWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DekFj3rcj46sU10dCxV5OxQCoKiCHZZazSU23J+GJggLP3Azh4poz02zUqR7eeN9YxdKJ96ncC3NSD5+FHhhHngZtd+kBcWdh5H+Jhzomdnc6UKXIe5FuaiihlXn5hIDXvy8CVZ/PL53AX/KJq9qX8zrKkQ4VCISARc5QY+nZX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JotajdHa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JotajdHa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164D91F000FF;
	Wed, 14 Oct 2026 12:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980486;
	bh=KIHm1yTXRciQaF/4NUVnaqeKiQ+BfThlseQUpXLObw8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JotajdHanhSOfE0efZYkx0sSZp8zl+hy2iJ1w0FV6qwT1NdJa+4pGTNK0wjSOhMob
	 EyzHdkv4mYsx4E3tDB+eNlZeW254kYimQhKnoV4M1rA173KlhYwrU8K5vVsmrbPbI2
	 MVdcatjXNtEaOYljuhEhka++xpCeuWhf0vb+Icke6dBxEjV1mTkPF+SOXv3Ycu249a
	 ul27LXqrT2j7EeXc79XgnDW7BZHkolRzK1ppgG4Zsum4BTd9ujOa4kPgdQGIR5qFr0
	 P40Zi6BJ/Q7KUQRILjZEouhKHtreRirMZ3rTFu/zTtEoZb05a8HPCPW/fTgASzsfdw
	 UZpZ1TJoOMRPg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 Oct 2026 14:19:06 +0200
Subject: [PATCH RFC 06/16] pmdomain: core: Support indexed power-domain
 attachment lists
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-topic-qc_clk_dvfs-v1-6-3041b788e9f7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791980431; l=3569;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=+zrmwbRm1lRyjdyVcYV76KG9HFfwAwPJRbhm/3do0I0=;
 b=J/2tiyXwubrGiuL9VF0P7bRHwXMibSujZ2+L3DskOI+3d+WDWsM3FMbF0IzMo3E+UK30B3+Xz
 Tzp6X6Nrq9dDsfHTYhJ+NSL2I4EDyXhcPOqObS8HhULc5mwSxSQrxXX
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

dev_pm_domain_attach_list() can attach domains selected by name or attach
all domains listed for a device. Allow callers to select an explicit list
of power-domain indices as well, retaining the original DT indices for
the virtual attachments.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/base/power/common.c | 24 +++++++++++++++++-------
 include/linux/pm_domain.h   |  8 +++++---
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 8beedde6dba7..6a2d8ee473cd 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -179,9 +179,9 @@ EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_name);
  *
  * This function helps to attach a device to its multiple PM domains. The
  * caller, which is typically a driver's probe function, may provide a list of
- * names for the PM domains that we should try to attach the device to, but it
- * may also provide an empty list, in case the attach should be done for all of
- * the available PM domains.
+ * names or indices for the PM domains that we should try to attach the device
+ * to, but it may also provide an empty list, in case the attach should be done
+ * for all of the available PM domains.
  *
  * Callers must ensure proper synchronization of this function with power
  * management callbacks.
@@ -211,9 +211,14 @@ int dev_pm_domain_attach_list(struct device *dev,
 	if (!np)
 		return 0;
 
+	if (data && data->pd_names && data->pd_indices)
+		return -EINVAL;
+
 	if (data && data->pd_names) {
 		num_pds = data->num_pd_names;
 		by_id = false;
+	} else if (data && data->pd_indices) {
+		num_pds = data->num_pd_indices;
 	} else {
 		num_pds = of_count_phandle_with_args(np, "power-domains",
 						     "#power-domain-cells");
@@ -240,13 +245,18 @@ int dev_pm_domain_attach_list(struct device *dev,
 		link_flags |= DL_FLAG_RPM_ACTIVE;
 
 	for (i = 0; i < num_pds; i++) {
-		if (by_id)
+		if (by_id) {
+			unsigned int pd_index = data && data->pd_indices ?
+				data->pd_indices[i] : i;
+
 			pd_dev = data && data->pd_suffix ?
-				genpd_dev_pm_attach_by_id_suffix(dev, i, data->pd_suffix) :
-				dev_pm_domain_attach_by_id(dev, i);
-		else
+				genpd_dev_pm_attach_by_id_suffix(dev, pd_index,
+							    data->pd_suffix) :
+				dev_pm_domain_attach_by_id(dev, pd_index);
+		} else {
 			pd_dev = dev_pm_domain_attach_by_name(dev,
 							data->pd_names[i]);
+		}
 		if (IS_ERR_OR_NULL(pd_dev)) {
 			ret = pd_dev ? PTR_ERR(pd_dev) : -ENODEV;
 			goto err_attach;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 322453da7fae..f5e340e32f48 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -32,9 +32,9 @@
  *
  * PD_FLAG_REQUIRED_OPP:	Assign required_devs for the required OPPs. The
  *				index of the required OPP must correspond to the
- *				index in the array of the pd_names. If pd_names
- *				isn't specified, the index just follows the
- *				index for the attached PM domain.
+ *				index in the pd_names or pd_indices array. If neither
+ *				is specified, the index just follows the index for the
+ *				attached PM domain.
  *
  * PD_FLAG_ATTACH_POWER_ON:	Power on the domain during attach.
  *
@@ -50,6 +50,8 @@
 struct dev_pm_domain_attach_data {
 	const char * const *pd_names;
 	u32 num_pd_names;
+	const unsigned int *pd_indices;
+	u32 num_pd_indices;
 	const char *pd_suffix;
 	u32 pd_flags;
 };

-- 
2.56.0

