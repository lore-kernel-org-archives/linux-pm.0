Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FAD3FA5F5
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768903; cv=none; b=mqAGwCL/B3YQD6CsLBttMbdTyNx05CVGsSOAew5vnDPQUgrtj7YJfa4QF5W/NdpKBJsGEgTPaVsfdYTe3zSAdtlDfTH3CAx+Y7mJNK5aU+MD5NmiO/fvmp+ybsWPqID3mrcDNpsgu7kKMpEDrDe+XiZ2d5yr+1ZfSqsv/yq94b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768903; c=relaxed/simple;
	bh=vbRU67UVOb7vag0urLTR9CGL8NDqWbK8p17LbDC+cW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3cTaiUfagE0WXA21OD1K4daoBiZdSkcDmMOdz8vCiQoJGaAnQHXFu2Gr1tNU2wON4tmZJv3cRIoabWOInFyttoWgE4DMzB7cd4HIkV6BRkz3XgO47yTZagLbvbMOXQ5oCnW+g/K6uQ/U0KkuTUbvrPhDiFEyWxnYTe7gdKet2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NRpVxQYT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ElwQhzJK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NRpVxQYT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ElwQhzJK"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBeUcJ3048540
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lVT+6+ENhr9QUbosk5DVYlfO2a3L1c21Y2zL0+4Gp+M=; b=NRpVxQYT9bG/uPQF
	IBuTkRhJd6b7AEoCvbiiiah2eseNeMWXBfRh6XkzBc2TkJj0XCvMUuxtSyq79p0W
	x6k2e16XJ6avvZOTM2OdyoPWqX0R/5UbPx5sNOVOHiyLGlN5V/+Y9wLUmp4APtRT
	I/2+Vy8cGkquGwNSAMnCyfqOVXJds3blolbsKx6deGrLmb1xMM49xWJ97iEcNQKe
	64Lu2DznOWviMAl5stx0twPMuMgU033Y+8BvLqCtVDogd0ukPjhJBMjKGyf0j+Q2
	Okl1dqQz6UA6Szci8urtWmGMinZKoTEMCt1+WkJkOseU+WkxcIb+UHq8gZqPquqA
	MXUFjg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5492thf1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:28:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba86e35aa1so124856005ad.1
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778768899; x=1779373699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVT+6+ENhr9QUbosk5DVYlfO2a3L1c21Y2zL0+4Gp+M=;
        b=ElwQhzJKWSCkLCWgp+cpTW0yMZXvvRWPWA1K9TiA/HaBTl1WqK0D3lpDCicx7H3zsp
         1K8tc37cCzxkdiodWo2dOGJeCkxMu3w03gAw8OHP4OzfKYowpHwT+QEcmd+zj+JbD2cd
         fjD7sxh6nkusNjKMxGlysY8d2edyuo2hS0TSmol9fCFLDdDQYRWgg2/x/Rc01Zqrs2Sj
         j9Zlf0y3Jv+LfopyYPDtQSvxl8cr2Qhskn4mKNwiPNee9ADl+f7JljmXAF96Vop/BPc5
         4RjwMi8awmM2GCqqpxObNtwkOpFcpISFBpolZHTZarA+0cfW0TmerodHb9/li7cc6+ki
         bzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778768899; x=1779373699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lVT+6+ENhr9QUbosk5DVYlfO2a3L1c21Y2zL0+4Gp+M=;
        b=Iqpm09ppwX0mzGEa/6aWhVjIyq5C4ugjnficVtzBapVuXt8jaYo8wk7Pj+GZy0z7vX
         C9DGUjL+yjZ/OdNtMuNWyGd7WBctxN8KHrJCkBormWqB+u5OYRTm9PpSpiotuNpRDL84
         YqS/z6MUmLujql5vH0z1pvmawU+MoSMOtxKiNGBFZ8uVU/40ZNiESlPyhGhUVhPWHXax
         YdEVubv2nb4r33Z/FuLaBIPK6iqygbCMWqNTP5qrwBJHk4aWJMtgfIMEWX+rWIL0Z++p
         4XWvT2ZiEezs7dwvLBuSdKFNXv9XCXbb5vCWNKjAH5Qe213ooOXUZHCz/e8awyc8fEkM
         xg+g==
X-Gm-Message-State: AOJu0YwcnKrVJI2XBiWNpc6FHm5rjBGBC1Gd+X3DKi8anAS66LiiBQy0
	WEZr5rwAXyBIT/551bubIOusdrg2mqNSjJylrKvoIq8RSt3KeJ55uR5M4RYleQPyj68zAiZS8bC
	eCgKkXWh/HQXKElE0xpnh456es/8XACB5yuqHPLpWXbVZ52DbXVZEYFlncaQzuuPXR9GMlw==
X-Gm-Gg: Acq92OFaERod7E2vfEEC54QbwqnulGYXT+nK+tVopwCDHjfCtLhUNrPbs8hGWnyUHh8
	3rqYNwHXuo6mmoSWtk3j83WoebPeec4NEcwDbPLqLKLcgzb4v7fYuVU2AGqiOk+md4oJANqj71X
	/fodvfAhFcKXqTleOQ6gi23yFzZHlzCLszfPCavsoRkhOushfrz4qap0ShhEYiftKTAFaaJVviM
	EdPj46q8mh8cWXdfYEaVux3obvMnVmwjeE4JV2NOWtenAu9+oOja6A6ftsQPNOJjUh+c6po5CtV
	h6XTZRc/MeKVi+T19kKuSxr5EcAEQvYg3DXkqWb0KmhQlf5AdZ9X+Z3+sh1+ZZdAwyYSU7x/yow
	mSd2gi4Wgq3eXoPOL3OWFiP9pyNxBQPNtNZwmnOjlk6xAu9qEn8/IMAjLqQ==
X-Received: by 2002:a17:903:2910:b0:2bd:2439:25fc with SMTP id d9443c01a7336-2bd27147127mr50114195ad.7.1778768899361;
        Thu, 14 May 2026 07:28:19 -0700 (PDT)
X-Received: by 2002:a17:903:2910:b0:2bd:2439:25fc with SMTP id d9443c01a7336-2bd27147127mr50113845ad.7.1778768898844;
        Thu, 14 May 2026 07:28:18 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05ffbesm28566485ad.27.2026.05.14.07.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:28:18 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 14 May 2026 19:55:49 +0530
Subject: [PATCH v22 08/13] mfd: core: Add firmware-node support to MFD
 cells
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-arm-psci-system_reset2-vendor-reboots-v22-8-28a5bde07483@oss.qualcomm.com>
References: <20260514-arm-psci-system_reset2-vendor-reboots-v22-0-28a5bde07483@oss.qualcomm.com>
In-Reply-To: <20260514-arm-psci-system_reset2-vendor-reboots-v22-0-28a5bde07483@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778768806; l=3848;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=vbRU67UVOb7vag0urLTR9CGL8NDqWbK8p17LbDC+cW4=;
 b=1ujf4JijpapWH/nOjxZ2QgZuRc0mQFRmg1998wEzgTxxWNXW+Wu6uTuV3aIgaDfjFZ74E/z0z
 sUG4/0XD4kBDQ+Rg5DzfQ2CFoovpR4etLcGo6OPdUtObyR6ZlRz/Y1x
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: G4Q0zUvrSkBXg8TjDVbNWX3xdHMiVqY-
X-Authority-Analysis: v=2.4 cv=R74z39RX c=1 sm=1 tr=0 ts=6a05dc04 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=n1cGDs2KZ32Q86TtW5UA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: G4Q0zUvrSkBXg8TjDVbNWX3xdHMiVqY-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0NiBTYWx0ZWRfX7EHE25mACGqo
 DgBcKHxiSD0/QqSWZlUOjC4g8FrHdyEzGlUPl90ZibPhix3DKHNIz7nrAijhTfN4eIB6gck8NvR
 0eFcGLEbb5aVr6N5ukMCsMRGJhiyzSLeTwALLYccI27Sxv7M8I5uC0E7vliI99+IU7oqAPD/Cpb
 /VhGK6gryIAAdBEne4PbwSPKn+owpAoOUerx26247FvYNIPA7hjmaoEUNO3p+2eOcPYEEWaLHUW
 15ef7BLHK+8/+vkZLXyBDo3Qtf+u3+qabMjLHAImeiLI9uF6R+uuM74MscxmzVqfu7BtoLaz8ns
 pc9Tt4n0I1BXZ3SzWyIBOys4SGq1/w+6Q0EavsXsjEkYOqf4PiJnG26pI+UnF7qgXYCVvnzUT+h
 aR7LbOWMp8vdtxrdM2XWS3+WSbHkGjW+uzdAKZB9bh2ZFGBheoSMWEpI1Hm2gbYPOyhUsreVxsp
 B4XamxpEUHJ7SPTBS9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140146

MFD core has no way to register a child device using an explicit firmware
node. This prevents drivers from registering child nodes when those nodes
do not define a compatible string. One such example is the PSCI
"reboot-mode" node, which omits a compatible string as it describes
boot-states provided by the underlying firmware.

Extend struct mfd_cell with a callback that allows drivers to provide an
explicit firmware node. The node is added to the MFD child device during
registration when none is assigned by device tree, ACPI, or software
matching.

Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/mfd/mfd-core.c   | 30 ++++++++++++++++++++++++++++++
 include/linux/mfd/core.h | 14 ++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 7aa32b90cf1eb7fa0a05bf3dc506e60a262c9850..cc2a2a924d6d3044e29a9f864b536ee325ed797b 100644
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
@@ -148,6 +149,11 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
 	return 0;
 }
 
+static void mfd_child_fwnode_put(void *data)
+{
+	fwnode_handle_put(data);
+}
+
 static int mfd_add_device(struct device *parent, int id,
 			  const struct mfd_cell *cell,
 			  struct resource *mem_base,
@@ -156,6 +162,7 @@ static int mfd_add_device(struct device *parent, int id,
 	struct resource *res;
 	struct platform_device *pdev;
 	struct mfd_of_node_entry *of_entry, *tmp;
+	struct fwnode_handle *fwnode;
 	bool disabled = false;
 	int ret = -ENOMEM;
 	int platform_id;
@@ -224,6 +231,29 @@ static int mfd_add_device(struct device *parent, int id,
 
 	mfd_acpi_add_device(cell, pdev);
 
+	if (!pdev->dev.fwnode && cell->get_child_fwnode) {
+		fwnode = cell->get_child_fwnode(parent);
+		if (fwnode) {
+			device_set_node(&pdev->dev, fwnode);
+
+			/*
+			 * platform_device_release() drops only of_node refs.
+			 * Track non-OF fwnodes explicitly so they are put on
+			 * all teardown paths.
+			 */
+			if (!to_of_node(fwnode)) {
+				ret = devm_add_action(&pdev->dev,
+						      mfd_child_fwnode_put,
+						      fwnode);
+				if (ret) {
+					device_set_node(&pdev->dev, NULL);
+					fwnode_handle_put(fwnode);
+					goto fail_of_entry;
+				}
+			}
+		}
+	}
+
 	if (cell->pdata_size) {
 		ret = platform_device_add_data(pdev,
 					cell->platform_data, cell->pdata_size);
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index faeea7abd688f223fb0b31cde0a9b69dfe2a61ff..abfc26c057d6ee46947ba2b6f2e99f420e74b127 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -50,6 +50,7 @@
 #define MFD_DEP_LEVEL_HIGH 1
 
 struct irq_domain;
+struct fwnode_handle;
 struct software_node;
 
 /* Matches ACPI PNP id, either _HID or _CID, or ACPI _ADR */
@@ -80,6 +81,19 @@ struct mfd_cell {
 
 	/* Software node for the device. */
 	const struct software_node *swnode;
+	/*
+	 * Callback to return an explicit firmware node.
+	 * @parent: MFD parent device passed to mfd_add_devices().
+	 *
+	 * Called only if OF/ACPI matching did not assign a fwnode.
+	 * Ownership of the returned reference is transferred to MFD core.
+	 *
+	 * Return a referenced fwnode or NULL if none is available.
+	 *
+	 * mfd_cell must be zero-initialized or get_child_fwnode must be NULL
+	 * when unused.
+	 */
+	struct fwnode_handle *(*get_child_fwnode)(struct device *parent);
 
 	/*
 	 * Device Tree compatible string

-- 
2.34.1

