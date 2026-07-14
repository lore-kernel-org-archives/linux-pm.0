Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11B63009D6
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049490; cv=none; b=h71xM8WhMoHJo0D1V13oGo4W9/+Ol2DsN/7yvJGKV4w+bQttbDk3Id2lnHATlsWs+TFWgNoKUragn3/ydhttbiWLJB+X1+KkN8L6ThoZxgDH82zuAxBDZQCBbUd1zXcApMPvK/i3Ngd7V6AmQA1EOtvuzrJ3yEtUzO1Y/ww52hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049490; c=relaxed/simple;
	bh=xpBz08jTmXyusCjePfq1hVafxvJ109djGJUNB0orD+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gVHjdyLnAEam6xMKVzcTsQ7CRWLU9qhnz4H8CLVCXhE70MV70blaLBnRvAHrUeKwutOydGuRxEOJzm9NGukbN1UzdGWY9PlnP1aXea6j1evIn/5srbAggBpz8MAq1rLsI2E0DPXXLBF1TdXdR+93MMoyxwwlHMHpnQfsixsnPbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MwdR8/Xz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RJC700j8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MwdR8/Xz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RJC700j8"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EHAiwd1177098
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8s7l/m7UGxkZIIDkB6Sh24bMViJas+fhJLKeQf2TBPU=; b=MwdR8/XzC7jmZcmC
	T62ytHmTWUJFu8YBB7JXFSNibli9m1pMFh0YKAV/hkv/PrBhi9ZP9PaGmJe5Oogv
	bqBQuAG0tx5XqSW30+Pjmk+oHl41zBOhxoL5EPH8QF2mhMlM6+qqLT48Ei17fCX+
	I3hmssAVq/R3aqwNx6/Yd5jMCC6tU5ZxHxe3cIcoriAXqtROLSDDS87F2/xZO1GV
	ZaUzc1HWd6blOoEFpCn3M/Jyhe2nrJ8xjYMJaZKPaBd4wf/lgvknGLqLi5yHJDhQ
	gNrwYALaUa6KJVEsvUogQi9DFwMq+PcJq56xIoKwFSLrcBsg00P6yp/crTTfnF9T
	PO+BUA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9kr0ye-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:18:07 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848551b54f5so8790284b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784049487; x=1784654287; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8s7l/m7UGxkZIIDkB6Sh24bMViJas+fhJLKeQf2TBPU=;
        b=RJC700j8ohao+QW3sfU0OyKi7WlrUSS+XIfc4iIDLMhN6CCBj7Ah7KT73YYfnBrVNf
         BRvYjaEh61W+kncjt0hiUC0zN7X7DqNAgv/inNazSpRyzm6YQGuxpkcdysR57YV52uDN
         vrfDzGR/KkRlYhYOUWd/2szgG2UqK/utd2BiRUX9wRQpB+3bxtapCxvBIMrCT008vwnJ
         F5u/D1iarNeJxzJMABSN/bx0HNiAoMYrAVXv77WlqkmAZ3Tk0Yuk8mRx6zpdwKCdy4gz
         XJTXI/tBhZkL91oVtmdmwdJAtXJkZp+Nv/fgpaBGcv+0NP/sgU/DyE1ukzrZWYybsZ+k
         LajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784049487; x=1784654287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8s7l/m7UGxkZIIDkB6Sh24bMViJas+fhJLKeQf2TBPU=;
        b=LqrhXZhZHBxE7ix3itXq0+L9hiXJ+GJ3g7PhpfAHrX81uXReNgmc6Bt79hx7j1urMp
         Zpo0Of2v48uUgKLiUanSyafEzPTeJ5bTRhjdc1ak2sTx01yvBvV0JH5YSomwXSrJddoY
         uwomf9sWZiqLDVFs2nV2lB4LC1QXI+91Pu0xJCeBXVnost+oTVpu4ASNm3AGlqgmPqfQ
         nWsKbPxcy2pinUeOwDUXi8eyYdFYYFBWK1M55b/Hq7ioIvmdzzmfuYvhILR/kK32LjqZ
         nyeyDYuJJoPAD43pkTCepxVrJPv6yPlo6kg69W2BDDKY1oofJbPucQrt1HHAbCWFH4cA
         urAA==
X-Gm-Message-State: AOJu0YydarWRoK2Y2MrKV5pjM5ibSqM51cr9mx3Gt89djDxCogN2qzM+
	XqfE9EzHz7eyKe2iI8HtJa4uw+1pBGowjPB4RtsVw4+/AFSO+fceVFyegRVTZDJlw480x16/Vdm
	CBwdv59Eb/XE1FulFxruPNwYv1RMQVbhh/TxPinp0TvJg3fBqXLD0yeiETA1SJg==
X-Gm-Gg: AfdE7cmhHOkm4zOklL5F+VBaoqpgnI/jgEkS+eCHHtbdKuwOg7ZtbNSpNPJPZGsZnRG
	JJTe9uCR816kFh6hj3cmHKL9Ne5AFvq3fziqwFuVjXHCyhT13/mxQV7QCn5hOwL+5HeFMFetCqg
	IZVnh3iNyCQXYy8UDdVGlk9sASwI7KwdR6aS7UxJ47rpUHkOlTrTnCgxXvvjN5x+fmNce4drNfm
	gtSdFj9yTH3pM5I6V/acIgb4gCcF/5XaZK0ch0X++3e1yzLhg7BSWdtSrF5W6TO1MCyrtB9v307
	x506BPFZN7av52j9sV9aBgUqywxCaRM0Qm3m/ly+wv4kK6rJHV/6sToA9UGB9CQWG6c3G0bn73j
	5ZJz955LcSZUYefnqP/1RYmCv1O2rM3hyEu6MRjDUvLFVPdo=
X-Received: by 2002:a05:6a00:8d1:b0:847:8704:1c48 with SMTP id d2e1a72fcca58-8488961992emr13510241b3a.20.1784049486324;
        Tue, 14 Jul 2026 10:18:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:8d1:b0:847:8704:1c48 with SMTP id d2e1a72fcca58-8488961992emr13510216b3a.20.1784049485746;
        Tue, 14 Jul 2026 10:18:05 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a5bfcc2e5sm731773b3a.56.2026.07.14.10.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:18:05 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 22:46:36 +0530
Subject: [PATCH v23 08/13] mfd: core: Add firmware-node support to MFD
 cells
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-arm-psci-system_reset2-vendor-reboots-v23-8-e7453c548c21@oss.qualcomm.com>
References: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
In-Reply-To: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784049398; l=8008;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=xpBz08jTmXyusCjePfq1hVafxvJ109djGJUNB0orD+8=;
 b=KXZZ51uhN5KQpmxnw/BcJEipsOj+v1rq8O/+vuB7MR4ZBpdH4zXSPh1vcBBbaGBLatOIJ7tI3
 XDEbJayfgkMDK54Wj3oA6XDxJxXNlYM5G3JYYHiV9uKvkyjsv5yH5Ci
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a566f4f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=2Layw8R8_bQqnRkAqW4A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 5S9N-aTjw1ATuXxuHK4kX5R_Fabot18K
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE3OSBTYWx0ZWRfXwFZ1rg8lUUdT
 LPdUllPa5g0lMTCGG/VoyPpIDbyyI7tfTRTeoQAbeFX1UFBvpytlDHoRn4jsFjROyQp0Nn7pMua
 DguGlsvA50dem0KUmfKFtWcinslFHVo=
X-Proofpoint-GUID: 5S9N-aTjw1ATuXxuHK4kX5R_Fabot18K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE3OSBTYWx0ZWRfX95/QCCq5CSmv
 N5hHUnpI2OO0VSUDKGeq+ity80zfzBFAycKq1BgQWV9XlOzQhsk2JyjqzaMMYv8zWuZcT9BAzeu
 ZGSX6KYiGaxHUmWmvFrIi7cRU6LaMvk91rU/6Y7vzYosITuOQA3zEtyloKyLe6ZQV14SbZ1C6+A
 Lq7EeP2AmJiPi4Fq0i2O/H11YH/uwHBG8VzEQbiU3f61D1p4Xky7ZLlsfMqdkuWiQgvTZ+ebWPq
 Y+1YH6DJoMLgXvpq9UaKmEn4FYhPIVutov4xHaw+SjdmuDqwm9CvEP77fr0DI678nSajSPJdV8V
 V9oSeRm0NLQVgB8Pe5Ujr1WxHAYKj5jHrX5s/AToYJJe92n7Hr9LV7y4mKeZikAOlTyhKVa/Wcq
 1X0CNAh4g9iyG7GQJ90XdRqfUYQn90oLB30vqqeY8yTAQDD4W0qXrbTQS04A6GwoleFSsbpXNVQ
 Ltwg30/A7h97N+xsyoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140179

MFD core has no way to register a child device using an explicit firmware
node. This prevents drivers from registering child nodes when those nodes
do not define a compatible string. One such example is the PSCI
"reboot-mode" node, which omits a compatible string as it describes
boot-states provided by the underlying firmware.

Extend struct mfd_cell with a named firmware-node field to identify a
child node under the MFD parent. The node is added to the MFD child
device during registration when none is assigned by device tree, ACPI,
or software matching.

Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/mfd/mfd-core.c   | 142 ++++++++++++++++++++++++++++++++++++++++-------
 include/linux/mfd/core.h |  10 ++++
 2 files changed, 131 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 7aa32b90cf1e..ba9682ead2ca 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
+#include <linux/fwnode.h>
 #include <linux/list.h>
 #include <linux/property.h>
 #include <linux/mfd/core.h>
@@ -22,6 +23,7 @@
 #include <linux/regulator/consumer.h>
 
 static LIST_HEAD(mfd_of_node_list);
+static LIST_HEAD(mfd_named_fwnode_list);
 static DEFINE_MUTEX(mfd_of_node_mutex);
 
 struct mfd_of_node_entry {
@@ -30,10 +32,91 @@ struct mfd_of_node_entry {
 	struct device_node *np;
 };
 
+struct mfd_named_fwnode_entry {
+	struct list_head list;
+	struct device *dev;
+	struct fwnode_handle *fwnode;
+};
+
 static const struct device_type mfd_dev_type = {
 	.name	= "mfd_device",
 };
 
+static int mfd_claim_named_fwnode(struct platform_device *pdev,
+				  struct fwnode_handle *fwnode)
+{
+	struct mfd_named_fwnode_entry *entry, *iter;
+
+	entry = kzalloc_obj(*entry, GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->dev = &pdev->dev;
+	entry->fwnode = fwnode_handle_get(fwnode);
+
+	scoped_guard(mutex, &mfd_of_node_mutex) {
+		list_for_each_entry(iter, &mfd_named_fwnode_list, list)
+			if (iter->fwnode == fwnode) {
+				fwnode_handle_put(entry->fwnode);
+				kfree(entry);
+				return -EAGAIN;
+			}
+
+		list_add_tail(&entry->list, &mfd_named_fwnode_list);
+	}
+
+	return 0;
+}
+
+/*
+ * Temporary MFD-local cleanup for named non-OF child fwnodes.
+ * Remove/rework this when platform core starts owning and dropping
+ * dev->fwnode references for these devices.
+ */
+static void mfd_release_named_fwnode(struct platform_device *pdev)
+{
+	struct mfd_named_fwnode_entry *entry, *tmp;
+
+	scoped_guard(mutex, &mfd_of_node_mutex) {
+		list_for_each_entry_safe(entry, tmp, &mfd_named_fwnode_list, list)
+			if (entry->dev == &pdev->dev) {
+				if (dev_fwnode(&pdev->dev) == entry->fwnode)
+					device_set_node(&pdev->dev, NULL);
+				fwnode_handle_put(entry->fwnode);
+				list_del(&entry->list);
+				kfree(entry);
+			}
+	}
+}
+
+static int mfd_claim_of_node_to_dev(struct platform_device *pdev,
+				    struct device_node *np)
+{
+	struct mfd_of_node_entry *of_entry, *iter;
+
+	of_entry = kzalloc_obj(*of_entry, GFP_KERNEL);
+	if (!of_entry)
+		return -ENOMEM;
+
+	of_entry->dev = &pdev->dev;
+	of_entry->np = of_node_get(np);
+
+	/* Skip if OF node has previously been allocated to a device */
+	scoped_guard(mutex, &mfd_of_node_mutex) {
+		list_for_each_entry(iter, &mfd_of_node_list, list)
+			if (iter->np == np) {
+				of_node_put(of_entry->np);
+				kfree(of_entry);
+				return -EAGAIN;
+			}
+
+		list_add_tail(&of_entry->list, &mfd_of_node_list);
+	}
+
+	device_set_node(&pdev->dev, of_fwnode_handle(np));
+	return 0;
+}
+
 #if IS_ENABLED(CONFIG_ACPI)
 struct match_ids_walk_data {
 	struct acpi_device_id *ids;
@@ -111,19 +194,11 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
 				    struct device_node *np,
 				    const struct mfd_cell *cell)
 {
-	struct mfd_of_node_entry *of_entry;
 	u64 of_node_addr;
 
-	/* Skip if OF node has previously been allocated to a device */
-	scoped_guard(mutex, &mfd_of_node_mutex) {
-		list_for_each_entry(of_entry, &mfd_of_node_list, list)
-			if (of_entry->np == np)
-				return -EAGAIN;
-	}
-
 	if (!cell->use_of_reg)
 		/* No of_reg defined - allocate first free compatible match */
-		goto allocate_of_node;
+		return mfd_claim_of_node_to_dev(pdev, np);
 
 	/* We only care about each node's first defined address */
 	if (of_property_read_reg(np, 0, &of_node_addr, NULL))
@@ -134,18 +209,7 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
 		/* No match */
 		return -EAGAIN;
 
-allocate_of_node:
-	of_entry = kzalloc(sizeof(*of_entry), GFP_KERNEL);
-	if (!of_entry)
-		return -ENOMEM;
-
-	of_entry->dev = &pdev->dev;
-	of_entry->np = of_node_get(np);
-	scoped_guard(mutex, &mfd_of_node_mutex)
-		list_add_tail(&of_entry->list, &mfd_of_node_list);
-
-	device_set_node(&pdev->dev, of_fwnode_handle(np));
-	return 0;
+	return mfd_claim_of_node_to_dev(pdev, np);
 }
 
 static int mfd_add_device(struct device *parent, int id,
@@ -156,6 +220,7 @@ static int mfd_add_device(struct device *parent, int id,
 	struct resource *res;
 	struct platform_device *pdev;
 	struct mfd_of_node_entry *of_entry, *tmp;
+	struct fwnode_handle *fwnode;
 	bool disabled = false;
 	int ret = -ENOMEM;
 	int platform_id;
@@ -224,6 +289,37 @@ static int mfd_add_device(struct device *parent, int id,
 
 	mfd_acpi_add_device(cell, pdev);
 
+	/* named_fwnode is a fallback only when no OF/ACPI match and no swnode */
+	if (!pdev->dev.fwnode && !cell->swnode && cell->named_fwnode) {
+		struct device_node *named_np;
+
+		fwnode = device_get_named_child_node(parent, cell->named_fwnode);
+		if (!fwnode) {
+			ret = -ENODEV;
+			goto fail_alias;
+		}
+
+		named_np = to_of_node(fwnode);
+		if (named_np) {
+			ret = mfd_claim_of_node_to_dev(pdev, named_np);
+			fwnode_handle_put(fwnode);
+			if (ret == -EAGAIN)
+				ret = -EBUSY;
+			if (ret)
+				goto fail_alias;
+		} else {
+			ret = mfd_claim_named_fwnode(pdev, fwnode);
+			if (ret) {
+				fwnode_handle_put(fwnode);
+				if (ret == -EAGAIN)
+					ret = -EBUSY;
+				goto fail_alias;
+			}
+			device_set_node(&pdev->dev, fwnode);
+			fwnode_handle_put(fwnode);
+		}
+	}
+
 	if (cell->pdata_size) {
 		ret = platform_device_add_data(pdev,
 					cell->platform_data, cell->pdata_size);
@@ -295,6 +391,7 @@ static int mfd_add_device(struct device *parent, int id,
 	if (cell->swnode)
 		device_remove_software_node(&pdev->dev);
 fail_of_entry:
+	mfd_release_named_fwnode(pdev);
 	scoped_guard(mutex, &mfd_of_node_mutex) {
 		list_for_each_entry_safe(of_entry, tmp, &mfd_of_node_list, list)
 			if (of_entry->dev == &pdev->dev) {
@@ -382,7 +479,10 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
 					       cell->num_parent_supplies);
 
+	get_device(&pdev->dev);
 	platform_device_unregister(pdev);
+	mfd_release_named_fwnode(pdev);
+	put_device(&pdev->dev);
 	return 0;
 }
 
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index faeea7abd688..8daa83dd31ea 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -80,6 +80,16 @@ struct mfd_cell {
 
 	/* Software node for the device. */
 	const struct software_node *swnode;
+	/*
+	 * Name of a child firmware node under the MFD parent device.
+	 *
+	 * Used only as a fallback when no firmware node is assigned to MFD
+	 * child and no software node is provided.
+	 *
+	 * For Device Tree parents, lookup is by base node name only
+	 * (the part before '@'). Unit-addresses are not matched.
+	 */
+	const char *named_fwnode;
 
 	/*
 	 * Device Tree compatible string

-- 
2.34.1

