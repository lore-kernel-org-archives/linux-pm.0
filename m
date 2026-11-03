Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747425;
	b=wFdxHdBPGpyTf6nGJoc1yQiVCiP1pyMHOhMVNkTl7UGEtpHEthkTQQl+InDhDIoD/NTo
	 zkNB7zzaAdm/6miobxjRxGSlzVYZ1CIhkFGudjqi3wfyCjRExh9+g7iA3S4dmZxLABwEc
	 UbW7IP1Ps1L0VnXISDQbMNXalzk2uGnC11nGncmg7RQT5tmju6L8ljYx07UJ85KFZ87cx
	 y1FrxrzCcHOXbgx8xEu/Z9lW0k9L1z0HNArrH35g+KQGRaZ4bfRb77mMRdssVUvw/E71O
	 4QC7r5AD3IvaFb+dwpY3cUxAtk8AvIrRyb5hBzg07s8axH7mtQLLF6LjVZLLtVF67Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747425;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t6vdaU/yxePrUrRWUghg3cmrLMnFFTUJ28tlNRYh1tg=;
	b=TCvz28rxpGLBwc3JLWv0D7FIM3iJyzJVLBsBXFyt729nMQoMPzv5Fl3skbFs3pwJ1Git
	 jaDz2Ml4UZ8+kniuzH01mmPVp9qxpQ/fpacLmfUqmXV+BpR+VZ6ZJdmAGV8yQGDIJwNiQ
	 jluXtfWfbVzVElmlBWPBTxr0X9vE8J69QfCCO9WzuuomjTniD2sKuNpewOxSrExXBhp+o
	 s170xWfDjYYXCzAqVfTKi+HBBiRoa53YCBIug6QstTvbMQtqnMt6EJOChcEILnlyulSxO
	 MiqJxfCDSOiqb9/YXtOE72hrsn6QdfZx4RW0AZpBhc275sGOAOeBJNyVJWxVbd8U6rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=SuPpvCBp;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D112606A32C;
	Tue,  3 Nov 2026 23:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D112606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=SuPpvCBp
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C87D11650;
	Tue,  3 Nov 2026 15:10:20 -0800 (PST)
Received: from e121740.manchester.arm.com (e121740.arm.com [10.33.8.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44EDF3F673;
	Tue,  3 Nov 2026 15:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793747423; bh=lSnoEjxkr8+bXgJvQDCUdnuOVMPOKr7qwpgfoczF5wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SuPpvCBpFfk5cYB+bazpJbkD+cL53FvqkjnJGH9Bk2XI/MRjHAERJNu3L2dOtTCyj
	 NPiJo1xNcO7sNDsPWz1FrW0kjZ/1393Nz6RhdJZsgxlVqI1jdi0WyvV5V+rpFadvUo
	 7X964iWl/ezCUZNnfC4/2v3fV2YE9AZCsfk1/uyw=
From: Philip Radford <philip.radford@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	souvik.chakravarty@arm.com,
	Philip Radford <philip.radford@arm.com>
Subject: [PATCH v10 01/13] powercap: Add enable disable control-type
Date: Tue,  3 Nov 2026 23:09:55 +0000
Message-Id: <20261103231007.537082-2-philip.radford@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103231007.537082-1-philip.radford@arm.com>
References: <20261103231007.537082-1-philip.radford@arm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functionality to disable or enable the Powercap control-type by writing
directly into sys/class/powercap/arm-scmi/enabled.

Signed-off-by: Philip Radford <philip.radford@arm.com>
---
V9->V10
- changed control-type enable writes to snapshot per-zone state instead of
  aggregate
- cancel enable/disable writes if a root child zone is not configurable
- roll back changed zones on failure
- changed control-type enable reads to report enabled if any root child zone
  is enabled
---
 drivers/powercap/arm_scmi_powercap.c | 175 ++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index ab66e9a3b1e2..ba398048bf21 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -33,13 +33,171 @@ struct scmi_powercap_zone {
 
 struct scmi_powercap_root {
 	unsigned int num_zones;
+	bool enabled;
+	struct list_head node;
 	struct scmi_powercap_zone *spzones;
 	struct list_head *registered_zones;
 	struct list_head scmi_zones;
 };
 
+static LIST_HEAD(scmi_powercap_roots);
+static DEFINE_MUTEX(scmi_powercap_roots_lock);
+
 static struct powercap_control_type *scmi_top_pcntrl;
 
+static bool scmi_powercap_is_control_type_child(const struct scmi_powercap_zone *spz)
+{
+	return spz->registered && !spz->invalid &&
+	       spz->info->parent_id == SCMI_POWERCAP_ROOT_ZONE_ID;
+}
+
+static int
+scmi_powercap_read_root_children_enable_state(struct scmi_powercap_root *pr, bool *mode)
+{
+	struct scmi_powercap_zone *spz;
+	bool enabled;
+	int i, ret;
+
+	*mode = false;
+
+	for (i = 0; i < pr->num_zones; i++) {
+		spz = &pr->spzones[i];
+
+		if (!scmi_powercap_is_control_type_child(spz))
+			continue;
+
+		ret = powercap_ops->cap_enable_get(spz->ph, spz->info->id, &enabled);
+		if (ret)
+			return ret;
+
+		if (enabled) {
+			*mode = true;
+			return 0;
+		}
+	}
+
+	return 0;
+}
+
+struct scmi_powercap_zone_state {
+	struct scmi_powercap_zone *spz;
+	bool prev_enabled;
+	bool changed;
+};
+
+static int
+scmi_powercap_control_type_set_enable(struct powercap_control_type *pct, bool mode)
+{
+	struct scmi_powercap_zone_state *states;
+	struct scmi_powercap_root *pr;
+	struct scmi_powercap_zone *spz;
+	int num_zones = 0, nr_states = 0;
+	int i, ret = 0;
+
+	mutex_lock(&scmi_powercap_roots_lock);
+	list_for_each_entry(pr, &scmi_powercap_roots, node) {
+		for (i = 0; i < pr->num_zones; i++) {
+			spz = &pr->spzones[i];
+
+			if (scmi_powercap_is_control_type_child(spz))
+				num_zones++;
+		}
+	}
+
+	states = kcalloc(num_zones, sizeof(*states), GFP_KERNEL);
+	if (!states) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	list_for_each_entry(pr, &scmi_powercap_roots, node)	{
+		for (i = 0; i < pr->num_zones; i++) {
+			spz = &pr->spzones[i];
+
+			if (!scmi_powercap_is_control_type_child(spz))
+				continue;
+
+			if (!spz->info->powercap_cap_config) {
+				ret = -EOPNOTSUPP;
+				goto out_free;
+			}
+
+			states[nr_states].spz = spz;
+
+			ret = powercap_ops->cap_enable_get(spz->ph, spz->info->id,
+				&states[nr_states].prev_enabled);
+
+			if (ret)
+				goto out_free;
+
+			nr_states++;
+		}
+	}
+
+	for (i = 0; i < nr_states; i++) {
+		spz = states[i].spz;
+
+		if (states[i].prev_enabled == mode)
+			continue;
+
+		ret = powercap_ops->cap_enable_set(spz->ph, spz->info->id, mode);
+		if (ret)
+			goto revert;
+
+		states[i].changed = true;
+	}
+
+	goto out_free;
+
+revert:
+	while (i--) {
+		spz = states[i].spz;
+
+		if (!states[i].changed)
+			continue;
+
+		powercap_ops->cap_enable_set(spz->ph, spz->info->id,
+			states[i].prev_enabled);
+	}
+
+out_free:
+			kfree(states);
+
+out_unlock:
+			mutex_unlock(&scmi_powercap_roots_lock);
+
+			return ret;
+}
+
+static int
+scmi_powercap_control_type_get_enable(struct powercap_control_type *pct, bool *mode)
+{
+	struct scmi_powercap_root *pr;
+	int ret = 0;
+
+	*mode = false;
+
+	mutex_lock(&scmi_powercap_roots_lock);
+	list_for_each_entry(pr, &scmi_powercap_roots, node) {
+		ret = scmi_powercap_read_root_children_enable_state(pr, &pr->enabled);
+
+		if (ret)
+			break;
+		if (pr->enabled) {
+			*mode = true;
+			break;
+		}
+	}
+	mutex_unlock(&scmi_powercap_roots_lock);
+
+	return ret;
+}
+
+static const struct powercap_control_type_ops scmi_powercap_control_type_ops = {
+	.set_enable = scmi_powercap_control_type_set_enable,
+	.get_enable = scmi_powercap_control_type_get_enable,
+};
+
 static int scmi_powercap_zone_release(struct powercap_zone *pz)
 {
 	return 0;
@@ -495,6 +653,16 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 	if (ret)
 		return ret;
 
+	INIT_LIST_HEAD(&pr->node);
+
+	ret = scmi_powercap_read_root_children_enable_state(pr, &pr->enabled);
+	if (ret)
+		return ret;
+
+	mutex_lock(&scmi_powercap_roots_lock);
+	list_add_tail(&pr->node, &scmi_powercap_roots);
+	mutex_unlock(&scmi_powercap_roots_lock);
+
 	dev_set_drvdata(dev, pr);
 
 	return ret;
@@ -505,6 +673,10 @@ static void scmi_powercap_remove(struct scmi_device *sdev)
 	struct device *dev = &sdev->dev;
 	struct scmi_powercap_root *pr = dev_get_drvdata(dev);
 
+	mutex_lock(&scmi_powercap_roots_lock);
+	list_del(&pr->node);
+	mutex_unlock(&scmi_powercap_roots_lock);
+
 	scmi_powercap_unregister_all_zones(pr);
 }
 
@@ -525,7 +697,8 @@ static int __init scmi_powercap_init(void)
 {
 	int ret;
 
-	scmi_top_pcntrl = powercap_register_control_type(NULL, "arm-scmi", NULL);
+	scmi_top_pcntrl = powercap_register_control_type(NULL, "arm-scmi",
+							 &scmi_powercap_control_type_ops);
 	if (IS_ERR(scmi_top_pcntrl))
 		return PTR_ERR(scmi_top_pcntrl);
 
-- 
2.34.1

