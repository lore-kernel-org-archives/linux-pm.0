Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20503B0585;
	Wed, 14 Oct 2026 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980472; cv=none; b=ddcYj+0+OijWW8Y5GREdByboAjWIm3tuEKH1SNcbD5uK2Ff0Qe/2m0miZb0UPPvxJ+6rlDrCoZDGG0I39tX8ivORoZMNiMxMUyhvCbJpdQwoB2ksnaqm3Db3vi+sjlts5SreuAGhN2zShofdsOiNqAQ4GIg3NwkafJkTXny26rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980472; c=relaxed/simple;
	bh=SPB1n9BBRuyNbnuBUtaMeI4KEpvsRwE4GrMFtFzRESc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hw0271uwLEjmRdk/drr1ASuHI5qCaez6aKOGQS3K1evvsOHrVlb7qtoZHws7U7bx5a6DSnW2Osvoskm5TbQ3W15w9UtYoXX/2ZZZEET0ctNc3lQovxSkrkKOXhNtqZ4q5w+RDJLLV6HPphrp7wXdYMM2EjYtZV8Jqy03o5PiiDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QML0Bk1e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QML0Bk1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489AD1F000FF;
	Wed, 14 Oct 2026 12:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980470;
	bh=mUCKgHP4v69upG5/BCHHcez7QDFXBmWWjs4MjJ5QWGg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QML0Bk1eT7aratz6eBkctMP3gD59d1YPmfwWu1hQwM9h/W+d/4VGHuxXyqAOqWR9D
	 F+ZsrM23GlRU9X/h63OCrEnEIeDx76VRXn80Vgs9siUXjzPPnv2vkZphgjlTgxSuNu
	 kGwu6jeYIEa7REGL+ZWJo6KwMHdz/H7FjlsDtVwBZI0N7Vq9G+00lUCnQPZhFUufli
	 cuw4G5JI8bySlILfehbDuxLj5AQ7e0FD5Pj65y6bpmLw/Vh9SP6M+2ZN8wfQcoBYmn
	 efz/Vv6tHg7SVvtJ42TJtZE96diAMBPZT+mBgtiKgNsvfpI/k1zIOhMQDRhZjjj8rU
	 oVOzTw8CSFTdg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 Oct 2026 14:19:04 +0200
Subject: [PATCH RFC 04/16] pmdomain: core: Support named indexed virtual
 attachments
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-topic-qc_clk_dvfs-v1-4-3041b788e9f7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791980431; l=4556;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=+TsxnG8yHZmmA9GCAKt/06CcLNhucIEhhQ3OAAEosfk=;
 b=WpEC3prD3F34ZyHQHT0QTtzDii+5WqmIQzwe3ztk1ZH7xFusjUDLSTEWo4CYHzVIk91spwcI2
 d26dpClg0K8CjEarTpARORoYM2ls52gp3MUpfWtYUdhQSXEADAJwWiH
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A device may need separate virtual GenPD attachments to the same
power-domain index for distinct purposes. dev_pm_domain_attach_list()
can make indexed attachments, but cannot give the resulting virtual
devices distinct names.

genpd_dev_pm_attach_by_id() derives a virtual-device name from only
the consumer device and power-domain index. Repeating the attachment
therefore collides with the existing virtual device.

Add an optional suffix to indexed virtual attachments and let
dev_pm_domain_attach_list() pass it through.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/base/power/common.c |  4 +++-
 drivers/pmdomain/core.c     | 28 +++++++++++++++++++++++++---
 include/linux/pm_domain.h   | 11 +++++++++++
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 9bef9248a705..8beedde6dba7 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -241,7 +241,9 @@ int dev_pm_domain_attach_list(struct device *dev,
 
 	for (i = 0; i < num_pds; i++) {
 		if (by_id)
-			pd_dev = dev_pm_domain_attach_by_id(dev, i);
+			pd_dev = data && data->pd_suffix ?
+				genpd_dev_pm_attach_by_id_suffix(dev, i, data->pd_suffix) :
+				dev_pm_domain_attach_by_id(dev, i);
 		else
 			pd_dev = dev_pm_domain_attach_by_name(dev,
 							data->pd_names[i]);
diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 964e44c2f78f..76ff0d9a229c 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3596,8 +3596,9 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
  * turned on, then ERR_PTR(-EPROBE_DEFER) is returned to ensure that the device
  * is not probed and to re-try again later.
  */
-struct device *genpd_dev_pm_attach_by_id(struct device *dev,
-					 unsigned int index)
+static struct device *__genpd_dev_pm_attach_by_id(struct device *dev,
+						  unsigned int index,
+						  const char *suffix)
 {
 	struct device *virt_dev;
 	int num_domains;
@@ -3620,7 +3621,11 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	if (!virt_dev)
 		return ERR_PTR(-ENOMEM);
 
-	dev_set_name(virt_dev, "genpd:%u:%s", index, dev_name(dev));
+	if (suffix)
+		dev_set_name(virt_dev, "genpd:%u:%s:%s", index, dev_name(dev),
+			     suffix);
+	else
+		dev_set_name(virt_dev, "genpd:%u:%s", index, dev_name(dev));
 	virt_dev->bus = &genpd_bus_type;
 	virt_dev->release = genpd_release_dev;
 	virt_dev->of_node = of_node_get(dev->of_node);
@@ -3643,8 +3648,25 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 
 	return virt_dev;
 }
+
+struct device *genpd_dev_pm_attach_by_id(struct device *dev,
+					 unsigned int index)
+{
+	return __genpd_dev_pm_attach_by_id(dev, index, NULL);
+}
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
 
+struct device *genpd_dev_pm_attach_by_id_suffix(struct device *dev,
+						unsigned int index,
+						const char *suffix)
+{
+	if (!suffix || !*suffix)
+		return ERR_PTR(-EINVAL);
+
+	return __genpd_dev_pm_attach_by_id(dev, index, suffix);
+}
+EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id_suffix);
+
 /**
  * genpd_dev_pm_attach_by_name - Associate a device with one of its PM domains.
  * @dev: The device used to lookup the PM domain.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 14e0e346c610..98aca4a4aede 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -50,6 +50,7 @@
 struct dev_pm_domain_attach_data {
 	const char * const *pd_names;
 	u32 num_pd_names;
+	const char *pd_suffix;
 	u32 pd_flags;
 };
 
@@ -484,6 +485,9 @@ int of_genpd_remove_child_ids(struct device_node *np,
 int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 					 unsigned int index);
+struct device *genpd_dev_pm_attach_by_id_suffix(struct device *dev,
+						unsigned int index,
+						const char *suffix);
 struct device *genpd_dev_pm_attach_by_name(struct device *dev,
 					   const char *name);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
@@ -538,6 +542,13 @@ static inline struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	return NULL;
 }
 
+static inline struct device *
+genpd_dev_pm_attach_by_id_suffix(struct device *dev, unsigned int index,
+				 const char *suffix)
+{
+	return NULL;
+}
+
 static inline struct device *genpd_dev_pm_attach_by_name(struct device *dev,
 							 const char *name)
 {

-- 
2.56.0

