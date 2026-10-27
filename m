Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104948;
	b=uLkZohXGfNei13VHsETe848pgwebCcBKbKopazLTa6R1GrGZOAY283v7AGgDZLLJYlzm
	 CIouIdOJeFZIpB9/WOaomEwYuEaCUZ4pwxlt8vSvc/5+QRcKxIilbrbfvJFY6RkG9qGN9
	 GwSQffcqR7ymRK0ODVEPKlQG9NlPVoGEYf4KNZP7d4T4jEnqnRk+1Jy6bXl46Xk5brEUn
	 khWilUqDpvPp+zc4ZyCINGhCgk+1wocbmFxKuqfDKo6C6NsAAeaOCa9g1ti27BNecR5hw
	 t/dFFXeUrLvq7dOoxpa6cAnMRrYSI+vykqP3kZrPyaMenBYL6HAPtk+po+9sNccV8AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104948;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:References:
	 X-Developer-Key:X-Developer-Signature:X-Mailer:From:To:Cc:Subject:
	 Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:
	 Feedback-ID:X-SES-Outgoing;
	bh=OQD8PoN29znFP5HDBazL7ADQt0rvLZ/vHBmzaVUQrIQ=;
	b=XlqQC85VAqoMdTWz9+XrJXGCzMVwOfT8QSPHLyfPhb1DH5M76/oMjNxk7rg9jv/RzlRg
	 GfYSfNnFaK1uVs/SiBW4NpbhnrTl+VEVDzxHc1cn7E1l7PiGTABcbYOdhyx7pCmk/TaBH
	 OdbwlOQunURhy0aq6YlXmkBDoV8t7icIw29JbnU/7mIXlbaVTtvvsCLDtk1Iiie6DfGry
	 18bqWkoxDuxqa4jV1buGDHw03VI4yBegSPRTFa/cSYTKerTqBQa1xSz2Hlc7tgW1pg7GT
	 sZvcVe4lW08vXKoyYDsoZUM8D96tFThPHrQ9DzzroHu01QzeYWDKrxcUX34QsWejGeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=brar.si;
	spf=pass smtp.mailfrom=rsend.brar.si;
	dkim=pass header.d=brar.si header.i=@brar.si header.a=rsa-sha256 header.s=resend header.b="M2lnXnZ/";
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=anwiTBvZ;
	arc=none smtp.remote-ip=23.251.234.53
Received: from e234-53.smtp-out.ap-northeast-1.amazonses.com (e234-53.smtp-out.ap-northeast-1.amazonses.com [23.251.234.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFC2606A32C;
	Tue, 27 Oct 2026 12:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EFC2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brar.si
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsend.brar.si
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=brar.si header.i=@brar.si header.a=rsa-sha256 header.s=resend header.b=M2lnXnZ/;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=anwiTBvZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=brar.si; t=1793104945;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=cg31QL5GZSBHg8Ft9/O4vwU1+Rq2UJDKI6XqU5geUMw=;
	b=M2lnXnZ/96MqtsUhaQ4e1obNdk0dgIxHP0rmUfjooXCKI3mHkVuuk9fo8CLno/TV
	YFOHVLy8IZIgAfyUCesnCIcE17XqG8ottRCbDbhkQRBUOn0MDj4rj+HduZE6J7eKrGy
	ga+indDMPtogZnLLQlzCu09V/3Sw/LF2967FZ+g8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1793104945;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=cg31QL5GZSBHg8Ft9/O4vwU1+Rq2UJDKI6XqU5geUMw=;
	b=anwiTBvZNUDcdk8e8o9BJuzo0WTyapx9OSmHDtozSx6JvVRdp7aAeWlxn1ynKIEc
	nXZmBg5D2bLrEmQha+DcOd1wiTIzwbFZP4PJsDQnK0kBkkp/5pXbyUWzBLh97Y5nWm8
	O6WuoU41EoorpSG1LkVmi2iExHoqlbwWA3g4eb5U=
In-Reply-To: <20261027-icc-sm7250-v4-0-f9bdaa3c1c7b@brar.si>
References: <20261027-icc-sm7250-v4-0-f9bdaa3c1c7b@brar.si>
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793104934; l=38722;
 i=patches@brar.si; h=from:subject:message-id;
 bh=JahMqwam/9e667O+erMS78KbnDPlACNC+H/T/hlh/ss=;
 b=TESgwtszDpuhJVItZ5Uj1qU30AQrJcQAN/8oYs8tJRSOvSrZyOigeKqpmek/5gstWN+T8xdlj
 LUcho3/H6/ZBdMBbxAfsXpUdoMsLI/r9xYKdiOBKdL+/wjMryzqwLUP
X-Mailer: b4 0.15.2
From: Ishu Brar <patches@brar.si>
To: djakov@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, patches@brar.si
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	konradybcio@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] interconnect: qcom: Add SM7250 interconnect
 provider driver
Message-ID: <010601a17d62222c-befdb9b3-ce1d-469d-a6d3-00511529579f-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:42:25 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.5YL5VvZ+qZ0e19wo5UdMspzrKjMAjMWs/SlfuwHJq77JVCQWpVGwyETo7FaXf+sztO4bYMxF6WHssrYHSY+K7X2T1EZhOskwm44pQQStdKG0Jdj3d5ybzIXFkMTcPBXllY63oWIrFhJN26LFqLzTuHiXuqj9UCHxIuFhxi7IM0GCfceBHtKocmWdFsR9dK9X:1.ap-northeast-1.TOS0vxEE3Ar6ai29fkp2i/jb+l2iigajCGeLfF7S3sk=:AmazonSES
X-SES-Outgoing: 2026.10.27-23.251.234.53

Add a driver for the Network-On-Chip interconnect providers of the
Qualcomm SM7250 SoC (Snapdragon 765/765G/768G). It follows the layout of
the other RPMh based providers: the nodes and the Bus Clock Managers
come from the downstream interconnect description of the platform.

Tested on a OnePlus Nord: all providers probe, and the UFS, USB,
display, I2C, serial and camera ISP devices get their paths without
errors.

Signed-off-by: Ishu Brar <patches@brar.si>
---
 drivers/interconnect/qcom/=
Kconfig  |   14 +
 drivers/interconnect/qcom/Makefile |    2 +
 drivers/interconnect/qcom/sm7250.c | 1489 ++++++++++++++++++++++++++++++++=
++++
 3 files changed, 1505 insertions(+)

diff --git =
a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 7f3a977e8f10..fc79bd8031c1 100644
--- a/drivers/interconnect/qcom/Kco=
nfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -426,6 +426,20 @@ config =
INTERCONNECT_QCOM_SM7150
 	  This is a driver for the Qualcomm =
Network-on-Chip on sm7150-based
 	  platforms.
=20
+config =
INTERCONNECT_QCOM_SM7250
+	tristate "Qualcomm SM7250 interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || =
COMPILE_TEST
+	select INTERCONNECT_QCOM_RPMH
+	select =
INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on sm7250-based
+	  platforms.
+
+	  To compile this driver as a module, choose M here: the=
 module
+	  will be called qnoc-sm7250.
+
 config INTERCONNECT_QCOM_MILOS
 	tristate "Qualcomm Milos interconnect driver"
 	depends on =
INTERCONNECT_QCOM_RPMH_POSSIBLE
diff --git a/drivers/interconnect/qcom/Make=
file b/drivers/interconnect/qcom/Makefile
index a71478aaf591..87d2f663097b =
100644
--- a/drivers/interconnect/qcom/Makefile
+++ =
b/drivers/interconnect/qcom/Makefile
@@ -43,6 +43,7 @@ qnoc-shikra-objs			=
:=3D shikra.o
 qnoc-sm6115-objs			:=3D sm6115.o
 qnoc-sm6350-objs			:=3D =
sm6350.o
 qnoc-sm7150-objs			:=3D sm7150.o
+qnoc-sm7250-objs			:=3D sm7250.=
o
 qnoc-sm8150-objs			:=3D sm8150.o
 qnoc-sm8250-objs			:=3D sm8250.o
 qnoc-sm8350-objs			:=3D sm8350.o
@@ -93,6 +94,7 @@ =
obj-$(CONFIG_INTERCONNECT_QCOM_SHIKRA) +=3D qnoc-shikra.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM6115) +=3D qnoc-sm6115.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM6350) +=3D qnoc-sm6350.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM7150) +=3D qnoc-sm7150.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SM7250) +=3D qnoc-sm7250.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) +=3D qnoc-sm8150.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) +=3D qnoc-sm8250.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8350) +=3D qnoc-sm8350.o
diff --git a/drivers/interconnect/qcom/sm7250.c b/drivers/interconnect/qcom=
/sm7250.c
new file mode 100644
index 000000000000..844e7cbf3606
--- /dev/null
+++ b/drivers/interconnect/qcom/sm7250.c
@@ -0,0 +1,1489 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020, The =
Linux Foundation. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/interconnect/qcom,sm7250-rpmh.h>
+
+#include "bcm-voter.h"
+#include "icc-rpmh.h"
+
+static struct =
qcom_icc_node srvc_aggre1_noc =3D {
+	.name =3D "srvc_aggre1_noc",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhm_a1noc_cfg =3D {
+	.name =3D =
"qhm_a1noc_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.link_nodes =3D { &srvc_aggre1_noc },
+};
+
+static struct qcom_icc_node =
ebi =3D {
+	.name =3D "ebi",
+	.channels =3D 2,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node llcc_mc =3D {
+	.name =3D "llcc_mc",
+	.channels =3D 2,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.link_nodes =3D { &ebi },
+};
+
+static struct qcom_icc_node qns_llcc =3D {
+	.name =3D "qns_llcc",
+	.channels =3D 2,
+	.buswidth =3D 16,
+	.num_links =3D 1,
+	.link_nodes =3D { &llcc_mc },
+};
+
+static struct qcom_icc_node =
qnm_snoc_sf =3D {
+	.name =3D "qnm_snoc_sf",
+	.channels =3D 1,
+	.buswidth =3D 16,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_llcc },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf =3D {
+	.name =3D "qns_gemnoc_sf",
+	.channels =3D 1,
+	.buswidth =3D 16,
+	.num_links =3D 1,
+	.link_nodes =3D { &qnm_snoc_sf },
+};
+
+static struct qcom_icc_node qxs_pimem =3D {
+	.name =3D "qxs_pimem",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qxs_imem =3D {
+	.name =3D "qxs_imem",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_apss =3D {
+	.name =3D "qhs_apss",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_compute_dsp =3D {
+	.name =3D =
"qhs_compute_dsp",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_tlmm_2 =3D {
+	.name =3D "qhs_tlmm_2",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_camera_cfg =3D {
+	.name =3D "qhs_camera_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_tlmm_0 =3D {
+	.name =3D "qhs_tlmm_0",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_sdc4 =3D {
+	.name =3D "qhs_sdc4",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_sdc2 =3D {
+	.name =3D "qhs_sdc2",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node srvc_mnoc =3D {
+	.name =3D "srvc_mnoc",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhm_mnoc_cfg =3D {
+	.name =3D "qhm_mnoc_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.link_nodes =3D { &srvc_mnoc },
+};
+
+static struct qcom_icc_node qhs_mnoc_cfg =3D {
+	.name =3D "qhs_mnoc_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.link_nodes =3D { &qhm_mnoc_cfg },
+};
+
+static struct qcom_icc_node =
qhs_ufs_mem_cfg =3D {
+	.name =3D "qhs_ufs_mem_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node =
srvc_snoc =3D {
+	.name =3D "srvc_snoc",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node =
qhm_snoc_cfg =3D {
+	.name =3D "qhm_snoc_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.link_nodes =3D { &srvc_snoc },
+};
+
+static struct qcom_icc_node qhs_snoc_cfg =3D {
+	.name =3D "qhs_snoc_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.link_nodes =3D { &qhm_snoc_cfg },
+};
+
+static struct qcom_icc_node qhs_pdm =3D {
+	.name =3D "qhs_pdm",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_cx_rdpm =3D {
+	.name =3D "qhs_cx_rdpm",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_tlmm_1 =3D {
+	.name =3D "qhs_tlmm_1",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node srvc_aggre2_noc =3D {
+	.name =3D =
"srvc_aggre2_noc",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhm_a2noc_cfg =3D {
+	.name =3D "qhm_a2noc_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.link_nodes =3D { &srvc_aggre2_noc },
+};
+
+static struct qcom_icc_node qhs_a2_noc_cfg =3D {
+	.name =3D =
"qhs_a2_noc_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.link_nodes =3D { &qhm_a2noc_cfg },
+};
+
+static struct qcom_icc_node =
qhs_qdss_cfg =3D {
+	.name =3D "qhs_qdss_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node =
qhs_display_cfg =3D {
+	.name =3D "qhs_display_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node =
qhs_tcsr =3D {
+	.name =3D "qhs_tcsr",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node =
qhs_dcc_cfg =3D {
+	.name =3D "qhs_dcc_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node =
qhs_llcc =3D {
+	.name =3D "qhs_llcc",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node =
qhs_mcdma_ms_mpu_cfg =3D {
+	.name =3D "qhs_mcdma_ms_mpu_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node srvc_gemnoc =3D {
+	.name =3D "srvc_gemnoc",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg =3D {
+	.name =3D "qhs_mdsp_ms_mpu_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhm_gemnoc_cfg =3D {
+	.name =3D "qhm_gemnoc_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 3,
+	.link_nodes =3D { &qhs_mcdma_ms_mpu_cfg, &srvc_gemnoc=
, &qhs_mdsp_ms_mpu_cfg },
+};
+
+static struct qcom_icc_node qhs_gemnoc =3D=
 {
+	.name =3D "qhs_gemnoc",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.link_nodes =3D { &qhm_gemnoc_cfg },
+};
+
+static struct qcom_icc_node qhm_cnoc_dc_noc =3D {
+	.name =3D =
"qhm_cnoc_dc_noc",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 2,
+	.link_nodes =3D { &qhs_llcc, &qhs_gemnoc },
+};
+
+static struct qcom_icc_node qhs_ddrss_cfg =3D {
+	.name =3D =
"qhs_ddrss_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.link_nodes =3D { &qhm_cnoc_dc_noc },
+};
+
+static struct qcom_icc_node =
qhs_ipc_router =3D {
+	.name =3D "qhs_ipc_router",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node =
qhs_ahb2phy2 =3D {
+	.name =3D "qhs_ahb2phy2",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node =
srvc_noc =3D {
+	.name =3D "srvc_noc",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node =
qhs_isense =3D {
+	.name =3D "qhs_isense",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node =
qhs_llm =3D {
+	.name =3D "qhs_llm",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_dma_bwmon =3D {
+	.name =3D "qhs_dma_bwmon",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_cp =3D {
+	.name =3D "qhs_cp",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_tcm =3D {
+	.name =3D "qhs_tcm",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_cal_dp0 =3D {
+	.name =3D "qhs_cal_dp0",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_dpm =3D {
+	.name =3D "qhs_dpm",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhm_cfg =3D {
+	.name =3D "qhm_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 8,
+	.link_nodes =3D { &srvc_noc, &qhs_isense, &qhs_llm, =
&qhs_dma_bwmon, &qhs_cp, &qhs_tcm,
+		&qhs_cal_dp0, &qhs_dpm },
+};
+
+static struct qcom_icc_node qhs_npu_cfg =3D {
+	.name =3D "qhs_npu_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.link_nodes =3D { &qhm_cfg },
+};
+
+static struct qcom_icc_node =
qhs_ahb2phy0 =3D {
+	.name =3D "qhs_ahb2phy0",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node =
qhs_gpuss_cfg =3D {
+	.name =3D "qhs_gpuss_cfg",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node =
qhs_venus_cfg =3D {
+	.name =3D "qhs_venus_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node =
qhs_ipa =3D {
+	.name =3D "qhs_ipa",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_imem_cfg =3D {
+	.name =3D "qhs_imem_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node srvc_cnoc =3D {
+	.name =3D "srvc_cnoc",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_usb3_0 =3D {
+	.name =3D "qhs_usb3_0",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_lpass_cfg =3D {
+	.name =3D "qhs_lpass_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_cpr_cx =3D {
+	.name =3D "qhs_cpr_cx",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_a1_noc_cfg =3D {
+	.name =3D "qhs_a1_noc_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.link_nodes =3D { &qhm_a1noc_cfg },
+};
+
+static struct qcom_icc_node qhs_aoss =3D {
+	.name =3D "qhs_aoss",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_prng =3D {
+	.name =3D "qhs_prng",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg =3D {
+	.name =3D "qhs_vsense_ctrl_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg =3D =
{
+	.name =3D "qhs_crypto0_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_pimem_cfg =3D {
+	.name =3D "qhs_pimem_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_cpr_mx =3D {
+	.name =3D "qhs_cpr_mx",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_qup0 =3D {
+	.name =3D "qhs_qup0",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_qup1 =3D {
+	.name =3D "qhs_qup1",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_clk_ctl =3D {
+	.name =3D "qhs_clk_ctl",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qhs_emmc_cfg =3D {
+	.name =3D "qhs_emmc_cfg",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qnm_snoc =3D {
+	.name =3D "qnm_snoc",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 41,
+	.link_nodes =3D { &qhs_compute_dsp, &qhs_tlmm_2, =
&qhs_camera_cfg, &qhs_tlmm_0, &qhs_sdc4,
+		&qhs_sdc2, &qhs_mnoc_cfg, =
&qhs_ufs_mem_cfg, &qhs_snoc_cfg, &qhs_pdm, &qhs_cx_rdpm,
+		&qhs_tlmm_1, &qhs_a2_noc_cfg, &qhs_qdss_cfg, &qhs_display_cfg, &qhs_tcsr=
,
+		&qhs_dcc_cfg, &qhs_ddrss_cfg, &qhs_ipc_router, &qhs_ahb2phy2, =
&qhs_npu_cfg,
+		&qhs_ahb2phy0, &qhs_gpuss_cfg, &qhs_venus_cfg, &qhs_ipa, =
&qhs_imem_cfg, &srvc_cnoc,
+		&qhs_usb3_0, &qhs_lpass_cfg, &qhs_cpr_cx, =
&qhs_a1_noc_cfg, &qhs_aoss, &qhs_prng,
+		&qhs_vsense_ctrl_cfg, =
&qhs_crypto0_cfg, &qhs_pimem_cfg, &qhs_cpr_mx, &qhs_qup0,
+		&qhs_qup1, &qhs_clk_ctl, &qhs_emmc_cfg },
+};
+
+static struct =
qcom_icc_node qns_cnoc =3D {
+	.name =3D "qns_cnoc",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.link_nodes =3D { &qnm_snoc },
+};
+
+static struct qcom_icc_node xs_qdss_stm =3D {
+	.name =3D "xs_qdss_stm",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qnm_aggre1_noc =3D {
+	.name =3D =
"qnm_aggre1_noc",
+	.channels =3D 1,
+	.buswidth =3D 16,
+	.num_links =3D 6,
+	.link_nodes =3D { &qns_gemnoc_sf, &qxs_pimem, =
&qxs_imem, &qhs_apss, &qns_cnoc, &xs_qdss_stm },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc =3D {
+	.name =3D =
"qns_a1noc_snoc",
+	.channels =3D 1,
+	.buswidth =3D 16,
+	.num_links =3D 1,
+	.link_nodes =3D { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_node qhm_qup_1 =3D {
+	.name =3D "qhm_qup_1",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node =
xm_sdc2 =3D {
+	.name =3D "xm_sdc2",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node xm_sdc4 =3D {
+	.name =3D "xm_sdc4",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node =
xm_emmc =3D {
+	.name =3D "xm_emmc",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node xm_ufs_mem =3D {
+	.name =3D "xm_ufs_mem",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node =
xm_usb3_0 =3D {
+	.name =3D "xm_usb3_0",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_a1noc_snoc =
},
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg =3D {
+	.name =3D "xs_sys_tcu_cfg",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qnm_aggre2_noc =3D {
+	.name =3D "qnm_aggre2_noc",
+	.channels =3D 1,
+	.buswidth =3D 16,
+	.num_links =3D 7,
+	.link_nodes =3D { &qns_gemnoc_sf, &qxs_pimem, =
&qxs_imem, &qhs_apss, &qns_cnoc,
+		&xs_sys_tcu_cfg, &xs_qdss_stm },
+};
+
+static struct qcom_icc_node qns_a2noc_snoc =3D {
+	.name =3D =
"qns_a2noc_snoc",
+	.channels =3D 1,
+	.buswidth =3D 16,
+	.num_links =3D 1,
+	.link_nodes =3D { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_node qhm_qdss_bam =3D {
+	.name =3D "qhm_qdss_bam",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node =
qhm_qup_0 =3D {
+	.name =3D "qhm_qup_0",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_a2noc_snoc =
},
+};
+
+static struct qcom_icc_node qxm_crypto =3D {
+	.name =3D "qxm_crypto",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node qxm_ipa =3D {
+	.name =3D "qxm_ipa",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node =
xm_qdss_etr =3D {
+	.name =3D "xm_qdss_etr",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_a2noc_snoc =
},
+};
+
+static struct qcom_icc_node qnm_gemnoc =3D {
+	.name =3D "qnm_gemnoc",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 6,
+	.link_nodes =3D { &qxs_pimem, &qxs_imem, &qhs_apss, =
&qns_cnoc, &xs_sys_tcu_cfg,
+		&xs_qdss_stm },
+};
+
+static struct qcom_icc_node qns_gem_noc_snoc =3D {
+	.name =3D "qns_gem_noc_snoc",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.link_nodes =3D { &qnm_gemnoc },
+};
+
+static struct qcom_icc_node qnm_cmpnoc =3D {
+	.name =3D "qnm_cmpnoc",
+	.channels =3D 2,
+	.buswidth =3D 32,
+	.num_links =3D 2,
+	.link_nodes =3D { &qns_llcc, &qns_gem_noc_snoc },
+};
+
+static struct qcom_icc_node qns_cdsp_gem_noc =3D {
+	.name =3D "qns_cdsp_gem_noc",
+	.channels =3D 2,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.link_nodes =3D { &qnm_cmpnoc },
+};
+
+static struct qcom_icc_node qnm_npu =3D {
+	.name =3D "qnm_npu",
+	.channels =3D 2,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_cdsp_gem_noc },
+};
+
+static struct qcom_icc_node=
 qxm_npu_dsp =3D {
+	.name =3D "qxm_npu_dsp",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.link_nodes =3D { =
&qns_cdsp_gem_noc },
+};
+
+static struct qcom_icc_node xm_qdss_dap =3D {
+	.name =3D "xm_qdss_dap",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 41,
+	.link_nodes =3D { &qhs_compute_dsp, &qhs_tlmm_2, =
&qhs_camera_cfg, &qhs_tlmm_0, &qhs_sdc4,
+		&qhs_sdc2, &qhs_mnoc_cfg, =
&qhs_ufs_mem_cfg, &qhs_snoc_cfg, &qhs_pdm, &qhs_cx_rdpm,
+		&qhs_tlmm_1, &qhs_a2_noc_cfg, &qhs_qdss_cfg, &qhs_display_cfg, &qhs_tcsr=
,
+		&qhs_dcc_cfg, &qhs_ddrss_cfg, &qhs_ipc_router, &qhs_ahb2phy2, =
&qhs_npu_cfg,
+		&qhs_ahb2phy0, &qhs_gpuss_cfg, &qhs_venus_cfg, &qhs_ipa, =
&qhs_imem_cfg, &srvc_cnoc,
+		&qhs_usb3_0, &qhs_lpass_cfg, &qhs_cpr_cx, =
&qhs_a1_noc_cfg, &qhs_aoss, &qhs_prng,
+		&qhs_vsense_ctrl_cfg, =
&qhs_crypto0_cfg, &qhs_pimem_cfg, &qhs_cpr_mx, &qhs_qup0,
+		&qhs_qup1, &qhs_clk_ctl, &qhs_emmc_cfg },
+};
+
+static struct =
qcom_icc_node acm_apps0 =3D {
+	.name =3D "acm_apps0",
+	.channels =3D 1,
+	.buswidth =3D 16,
+	.num_links =3D 2,
+	.link_nodes =3D { &qns_llcc, =
&qns_gem_noc_snoc },
+};
+
+static struct qcom_icc_node acm_sys_tcu =3D {
+	.name =3D "acm_sys_tcu",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 2,
+	.link_nodes =3D { &qns_llcc, &qns_gem_noc_snoc },
+};
+
+static struct qcom_icc_node alm_gpu_tcu =3D {
+	.name =3D "alm_gpu_tcu",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 2,
+	.link_nodes =3D { &qns_llcc, &qns_gem_noc_snoc },
+};
+
+static struct qcom_icc_node qnm_gpu =3D {
+	.name =3D "qnm_gpu",
+	.channels =3D 2,
+	.buswidth =3D 32,
+	.num_links =3D 2,
+	.link_nodes =3D { &qns_llcc, &qns_gem_noc_snoc },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf =3D {
+	.name =3D "qnm_mnoc_hf",
+	.channels =3D 2,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_llcc },
+};
+
+static struct qcom_icc_node =
qnm_mnoc_sf =3D {
+	.name =3D "qnm_mnoc_sf",
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 2,
+	.link_nodes =3D { &qns_llcc, =
&qns_gem_noc_snoc },
+};
+
+static struct qcom_icc_node qnm_snoc_gc =3D {
+	.name =3D "qnm_snoc_gc",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_llcc },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf =3D {
+	.name =3D =
"qns_mem_noc_sf",
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.link_nodes =3D { &qnm_mnoc_sf },
+};
+
+static struct qcom_icc_node qxm_camnoc_icp =3D {
+	.name =3D =
"qxm_camnoc_icp",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node =
qns_mem_noc_hf =3D {
+	.name =3D "qns_mem_noc_hf",
+	.channels =3D 2,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.link_nodes =3D { &qnm_mnoc_hf },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf0 =3D {
+	.name =3D "qxm_camnoc_hf0",
+	.channels =3D 2,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf1 =3D {
+	.name =3D =
"qxm_camnoc_hf1",
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_node qxm_camnoc_sf =3D {
+	.name =3D =
"qxm_camnoc_sf",
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node =
qxm_mdp0 =3D {
+	.name =3D "qxm_mdp0",
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_mem_noc_hf=
 },
+};
+
+static struct qcom_icc_node qxm_mdp1 =3D {
+	.name =3D "qxm_mdp1",
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_node qxm_rot =3D {
+	.name =3D "qxm_rot",
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node =
qxm_venus0 =3D {
+	.name =3D "qxm_venus0",
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_mem_noc_sf=
 },
+};
+
+static struct qcom_icc_node qxm_venus1 =3D {
+	.name =3D "qxm_venus1",
+	.channels =3D 1,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qxm_venus_arm9 =3D {
+	.name =3D =
"qxm_venus_arm9",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node =
qns_npu_sys =3D {
+	.name =3D "qns_npu_sys",
+	.channels =3D 2,
+	.buswidth =3D 32,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node =
amm_npu_sys =3D {
+	.name =3D "amm_npu_sys",
+	.channels =3D 2,
+	.buswidth =3D 32,
+	.num_links =3D 1,
+	.link_nodes =3D { &qns_npu_sys },
+};
+
+static struct qcom_icc_node qup_core_slave_1 =3D {
+	.name =3D "qup_core_slave_1",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qup_core_master_1 =
=3D {
+	.name =3D "qup_core_master_1",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.link_nodes =3D { =
&qup_core_slave_1 },
+};
+
+static struct qcom_icc_node qup_core_slave_2 =
=3D {
+	.name =3D "qup_core_slave_2",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 0,
+};
+
+static struct qcom_icc_node qup_core_master_2 =
=3D {
+	.name =3D "qup_core_master_2",
+	.channels =3D 1,
+	.buswidth =3D 4,
+	.num_links =3D 1,
+	.link_nodes =3D { =
&qup_core_slave_2 },
+};
+
+static struct qcom_icc_node qns_gemnoc_gc =3D {
+	.name =3D "qns_gemnoc_gc",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 1,
+	.link_nodes =3D { &qnm_snoc_gc },
+};
+
+static struct qcom_icc_node qxm_pimem =3D {
+	.name =3D "qxm_pimem",
+	.channels =3D 1,
+	.buswidth =3D 8,
+	.num_links =3D 2,
+	.link_nodes =3D { &qns_gemnoc_gc, &qxs_imem },
+};
+
+static struct qcom_icc_bcm bcm_cn1 =3D {
+	.name =3D "CN1",
+	.keepalive =3D false,
+	.num_nodes =3D 8,
+	.nodes =3D { &xm_sdc2, =
&xm_sdc4, &xm_emmc, &qhs_ahb2phy2, &qhs_pdm, &qhs_sdc2, &qhs_sdc4,
+		&qhs_emmc_cfg },
+};
+
+static struct qcom_icc_bcm bcm_ce0 =3D {
+	.name =3D "CE0",
+	.keepalive =3D false,
+	.num_nodes =3D 1,
+	.nodes =3D { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_co2 =3D=
 {
+	.name =3D "CO2",
+	.keepalive =3D false,
+	.num_nodes =3D 1,
+	.nodes =3D { &qnm_npu },
+};
+
+static struct qcom_icc_bcm bcm_co3 =3D {
+	.name =3D "CO3",
+	.keepalive =3D false,
+	.num_nodes =3D 1,
+	.nodes =3D { &qxm_npu_dsp },
+};
+
+static struct qcom_icc_bcm bcm_cn0 =
=3D {
+	.name =3D "CN0",
+	.keepalive =3D true,
+	.num_nodes =3D 38,
+	.nodes =3D { &qnm_snoc, &xm_qdss_dap, &qhs_a1_noc_cfg, &qhs_a2_noc_cfg, =
&qhs_ahb2phy0,
+		&qhs_aoss, &qhs_camera_cfg, &qhs_clk_ctl, =
&qhs_compute_dsp, &qhs_cpr_cx,
+		&qhs_cpr_mx, &qhs_crypto0_cfg, =
&qhs_cx_rdpm, &qhs_dcc_cfg, &qhs_ddrss_cfg,
+		&qhs_display_cfg, =
&qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_ipc_router,
+		&qhs_lpass_cfg, &qhs_mnoc_cfg, &qhs_npu_cfg, &qhs_pimem_cfg, &qhs_prng,
+		&qhs_qdss_cfg, &qhs_qup0, &qhs_qup1, &qhs_snoc_cfg, &qhs_tcsr, =
&qhs_tlmm_0,
+		&qhs_tlmm_1, &qhs_tlmm_2, &qhs_ufs_mem_cfg, &qhs_usb3_0, =
&qhs_venus_cfg,
+		&qhs_vsense_ctrl_cfg, &srvc_cnoc },
+};
+
+static struct qcom_icc_bcm bcm_sh4 =3D {
+	.name =3D "SH4",
+	.keepalive =3D false,
+	.num_nodes =3D 1,
+	.nodes =3D { &acm_apps0 },
+};
+
+static struct qcom_icc_bcm bcm_sh2 =3D {
+	.name =3D "SH2",
+	.keepalive =3D false,
+	.num_nodes =3D 2,
+	.nodes =3D { &acm_sys_tcu, =
&alm_gpu_tcu },
+};
+
+static struct qcom_icc_bcm bcm_sh3 =3D {
+	.name =3D "SH3",
+	.keepalive =3D false,
+	.num_nodes =3D 1,
+	.nodes =3D { &qnm_cmpnoc },
+};
+
+static struct qcom_icc_bcm bcm_mm3 =3D=
 {
+	.name =3D "MM3",
+	.keepalive =3D false,
+	.num_nodes =3D 5,
+	.nodes =3D { &qxm_camnoc_icp, &qxm_camnoc_sf, &qxm_venus0, &qxm_venus1, =
&qxm_venus_arm9 },
+};
+
+static struct qcom_icc_bcm bcm_mm1 =3D {
+	.name =3D "MM1",
+	.keepalive =3D true,
+	.num_nodes =3D 4,
+	.nodes =3D { &qxm_camnoc_hf0, &qxm_camnoc_hf1, &qxm_mdp0, &qxm_mdp1 },
+};
+
+static struct qcom_icc_bcm bcm_qup0 =3D {
+	.name =3D "QUP0",
+	.keepalive =3D false,
+	.num_nodes =3D 2,
+	.nodes =3D { =
&qup_core_master_1, &qup_core_master_2 },
+};
+
+static struct qcom_icc_bcm=
 bcm_sn5 =3D {
+	.name =3D "SN5",
+	.keepalive =3D false,
+	.num_nodes =3D 1,
+	.nodes =3D { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn6 =3D {
+	.name =3D "SN6",
+	.keepalive =3D false,
+	.num_nodes =3D 1,
+	.nodes =3D { &qnm_aggre2_noc =
},
+};
+
+static struct qcom_icc_bcm bcm_sn10 =3D {
+	.name =3D "SN10",
+	.keepalive =3D false,
+	.num_nodes =3D 1,
+	.nodes =3D { &qnm_gemnoc },
+};
+
+static struct qcom_icc_bcm bcm_co0 =3D {
+	.name =3D "CO0",
+	.keepalive =3D false,
+	.num_nodes =3D 1,
+	.nodes =3D { =
&qns_cdsp_gem_noc },
+};
+
+static struct qcom_icc_bcm bcm_sh0 =3D {
+	.name =3D "SH0",
+	.keepalive =3D true,
+	.num_nodes =3D 1,
+	.nodes =3D { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_mc0 =3D {
+	.name =3D "MC0",
+	.keepalive =3D true,
+	.num_nodes =3D 1,
+	.nodes =3D { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_acv =3D {
+	.name =3D "ACV",
+	.enable_mask =3D BIT(3),
+	.keepalive =3D false,
+	.num_nodes =3D 1,
+	.nodes =3D { &ebi },
+};
+
+static struct =
qcom_icc_bcm bcm_mm0 =3D {
+	.name =3D "MM0",
+	.keepalive =3D true,
+	.num_nodes =3D 1,
+	.nodes =3D { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_bcm bcm_mm2 =3D {
+	.name =3D "MM2",
+	.keepalive =3D false,
+	.num_nodes =3D 1,
+	.nodes =3D { &qns_mem_noc_sf =
},
+};
+
+static struct qcom_icc_bcm bcm_sn2 =3D {
+	.name =3D "SN2",
+	.keepalive =3D false,
+	.num_nodes =3D 1,
+	.nodes =3D { &qns_gemnoc_gc }=
,
+};
+
+static struct qcom_icc_bcm bcm_sn0 =3D {
+	.name =3D "SN0",
+	.keepalive =3D true,
+	.num_nodes =3D 1,
+	.nodes =3D { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_sn1 =3D {
+	.name =3D "SN1",
+	.keepalive =3D false,
+	.num_nodes =3D 1,
+	.nodes =3D { &qxs_imem },
+};
+
+static struct qcom_icc_bcm bcm_sn3 =3D {
+	.name =3D "SN3",
+	.keepalive =3D false,
+	.num_nodes =3D 1,
+	.nodes =3D { &qxs_pimem },
+};
+
+static struct qcom_icc_bcm bcm_sn4 =3D {
+	.name =3D "SN4",
+	.keepalive =3D false,
+	.num_nodes =3D 1,
+	.nodes =3D { &xs_qdss_stm },
+};
+
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] =3D {
+	&bcm_cn1,
+};
+
+static struct qcom_icc_node * const aggre1_noc_nodes[] =
=3D {
+	[MASTER_A1NOC_CFG] =3D &qhm_a1noc_cfg,
+	[MASTER_QUP_1] =3D =
&qhm_qup_1,
+	[MASTER_SDCC_2] =3D &xm_sdc2,
+	[MASTER_SDCC_4] =3D &xm_sdc4,
+	[MASTER_EMMC] =3D &xm_emmc,
+	[MASTER_UFS_MEM] =3D &xm_ufs_mem,
+	[MASTER_USB3] =3D &xm_usb3_0,
+	[A1NOC_SNOC_SLV] =3D &qns_a1noc_snoc,
+	[SLAVE_SERVICE_A1NOC] =3D &srvc_aggre1_noc,
+};
+
+static const struct qcom_icc_desc sm7250_aggre1_noc =3D {
+	.nodes =3D aggre1_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(aggre1_noc_nodes=
),
+	.bcms =3D aggre1_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(aggre1_noc_bcms)=
,
+};
+
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] =3D {
+	&bcm_ce0,
+};
+
+static struct qcom_icc_node * const aggre2_noc_nodes[] =
=3D {
+	[MASTER_A2NOC_CFG] =3D &qhm_a2noc_cfg,
+	[MASTER_QDSS_BAM] =3D =
&qhm_qdss_bam,
+	[MASTER_QUP_0] =3D &qhm_qup_0,
+	[MASTER_CRYPTO_CORE_0] =
=3D &qxm_crypto,
+	[MASTER_IPA] =3D &qxm_ipa,
+	[MASTER_QDSS_ETR] =3D =
&xm_qdss_etr,
+	[A2NOC_SNOC_SLV] =3D &qns_a2noc_snoc,
+	[SLAVE_SERVICE_A2NOC] =3D &srvc_aggre2_noc,
+};
+
+static const struct qcom_icc_desc sm7250_aggre2_noc =3D {
+	.nodes =3D aggre2_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(aggre2_noc_nodes=
),
+	.bcms =3D aggre2_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(aggre2_noc_bcms)=
,
+};
+
+static struct qcom_icc_bcm * const compute_noc_bcms[] =3D {
+	&bcm_co0,
+	&bcm_co2,
+	&bcm_co3,
+};
+
+static struct qcom_icc_node * =
const compute_noc_nodes[] =3D {
+	[MASTER_NPU] =3D &qnm_npu,
+	[MASTER_NPU_CDP] =3D &qxm_npu_dsp,
+	[SLAVE_CDSP_GEM_NOC] =3D =
&qns_cdsp_gem_noc,
+};
+
+static const struct qcom_icc_desc =
sm7250_compute_noc =3D {
+	.nodes =3D compute_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(compute_noc_nodes),
+	.bcms =3D =
compute_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(compute_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const config_noc_bcms[] =3D {
+	&bcm_cn0,
+	&bcm_cn1,
+};
+
+static struct qcom_icc_node * const config_noc_nodes[] =
=3D {
+	[SNOC_CNOC_MAS] =3D &qnm_snoc,
+	[MASTER_QDSS_DAP] =3D &xm_qdss_dap=
,
+	[SLAVE_A1NOC_CFG] =3D &qhs_a1_noc_cfg,
+	[SLAVE_A2NOC_CFG] =3D =
&qhs_a2_noc_cfg,
+	[SLAVE_AHB2PHY_SOUTH] =3D &qhs_ahb2phy0,
+	[SLAVE_AHB2PHY_CENTER] =3D &qhs_ahb2phy2,
+	[SLAVE_AOSS] =3D &qhs_aoss,
+	[SLAVE_CAMERA_CFG] =3D &qhs_camera_cfg,
+	[SLAVE_CLK_CTL] =3D =
&qhs_clk_ctl,
+	[SLAVE_CDSP_CFG] =3D &qhs_compute_dsp,
+	[SLAVE_RBCPR_CX_CFG] =3D &qhs_cpr_cx,
+	[SLAVE_RBCPR_MX_CFG] =3D =
&qhs_cpr_mx,
+	[SLAVE_CRYPTO_0_CFG] =3D &qhs_crypto0_cfg,
+	[SLAVE_CX_RDPM] =3D &qhs_cx_rdpm,
+	[SLAVE_DCC_CFG] =3D &qhs_dcc_cfg,
+	[SLAVE_CNOC_DDRSS] =3D &qhs_ddrss_cfg,
+	[SLAVE_DISPLAY_CFG] =3D =
&qhs_display_cfg,
+	[SLAVE_GRAPHICS_3D_CFG] =3D &qhs_gpuss_cfg,
+	[SLAVE_IMEM_CFG] =3D &qhs_imem_cfg,
+	[SLAVE_IPA_CFG] =3D &qhs_ipa,
+	[SLAVE_IPC_ROUTER_CFG] =3D &qhs_ipc_router,
+	[SLAVE_LPASS] =3D =
&qhs_lpass_cfg,
+	[SLAVE_CNOC_MNOC_CFG] =3D &qhs_mnoc_cfg,
+	[SLAVE_NPU_CFG] =3D &qhs_npu_cfg,
+	[SLAVE_PDM] =3D &qhs_pdm,
+	[SLAVE_PIMEM_CFG] =3D &qhs_pimem_cfg,
+	[SLAVE_PRNG] =3D &qhs_prng,
+	[SLAVE_QDSS_CFG] =3D &qhs_qdss_cfg,
+	[SLAVE_QUP_0] =3D &qhs_qup0,
+	[SLAVE_QUP_1] =3D &qhs_qup1,
+	[SLAVE_SDCC_2] =3D &qhs_sdc2,
+	[SLAVE_SDCC_4] =3D &qhs_sdc4,
+	[SLAVE_SNOC_CFG] =3D &qhs_snoc_cfg,
+	[SLAVE_TCSR] =3D &qhs_tcsr,
+	[SLAVE_TLMM_NORTH] =3D &qhs_tlmm_0,
+	[SLAVE_TLMM_SOUTH] =3D &qhs_tlmm_1,
+	[SLAVE_TLMM_WEST] =3D &qhs_tlmm_2,
+	[SLAVE_UFS_MEM_CFG] =3D &qhs_ufs_mem_cfg,
+	[SLAVE_EMMC_CFG] =3D =
&qhs_emmc_cfg,
+	[SLAVE_USB3] =3D &qhs_usb3_0,
+	[SLAVE_VENUS_CFG] =3D =
&qhs_venus_cfg,
+	[SLAVE_VSENSE_CTRL_CFG] =3D &qhs_vsense_ctrl_cfg,
+	[SLAVE_SERVICE_CNOC] =3D &srvc_cnoc,
+};
+
+static const struct =
qcom_icc_desc sm7250_config_noc =3D {
+	.nodes =3D config_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(config_noc_nodes),
+	.bcms =3D config_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(config_noc_bcms),
+};
+
+static struct =
qcom_icc_node * const dc_noc_nodes[] =3D {
+	[MASTER_CNOC_DC_NOC] =3D =
&qhm_cnoc_dc_noc,
+	[SLAVE_GEM_NOC_CFG] =3D &qhs_gemnoc,
+	[SLAVE_LLCC_CFG] =3D &qhs_llcc,
+};
+
+static const struct qcom_icc_desc =
sm7250_dc_noc =3D {
+	.nodes =3D dc_noc_nodes,
+	.num_nodes =3D =
ARRAY_SIZE(dc_noc_nodes),
+};
+
+static struct qcom_icc_bcm * const =
gem_noc_bcms[] =3D {
+	&bcm_sh0,
+	&bcm_sh2,
+	&bcm_sh3,
+	&bcm_sh4,
+};
+
+static struct qcom_icc_node * const gem_noc_nodes[] =3D {
+	[MASTER_AMPSS_M0] =3D &acm_apps0,
+	[MASTER_SYS_TCU] =3D &acm_sys_tcu,
+	[MASTER_GPU_TCU] =3D &alm_gpu_tcu,
+	[MASTER_GEM_NOC_CFG] =3D =
&qhm_gemnoc_cfg,
+	[MASTER_COMPUTE_NOC] =3D &qnm_cmpnoc,
+	[MASTER_GRAPHICS_3D] =3D &qnm_gpu,
+	[MASTER_MNOC_HF_MEM_NOC] =3D =
&qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] =3D &qnm_mnoc_sf,
+	[MASTER_SNOC_GC_MEM_NOC] =3D &qnm_snoc_gc,
+	[MASTER_SNOC_SF_MEM_NOC] =3D=
 &qnm_snoc_sf,
+	[SLAVE_MCDMA_MS_MPU_CFG] =3D &qhs_mcdma_ms_mpu_cfg,
+	[SLAVE_MSS_PROC_MS_MPU_CFG] =3D &qhs_mdsp_ms_mpu_cfg,
+	[SLAVE_GEM_NOC_SNOC] =3D &qns_gem_noc_snoc,
+	[SLAVE_LLCC] =3D &qns_llcc,
+	[SLAVE_SERVICE_GEM_NOC] =3D &srvc_gemnoc,
+};
+
+static const struct =
qcom_icc_desc sm7250_gem_noc =3D {
+	.nodes =3D gem_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(gem_noc_nodes),
+	.bcms =3D gem_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(gem_noc_bcms),
+};
+
+static struct qcom_icc_bcm=
 * const mc_virt_bcms[] =3D {
+	&bcm_acv,
+	&bcm_mc0,
+};
+
+static struct qcom_icc_node * const mc_virt_nodes[] =3D {
+	[MASTER_LLCC] =3D &llcc_mc,
+	[SLAVE_EBI_CH0] =3D &ebi,
+};
+
+static const struct qcom_icc_desc sm7250_mc_virt =3D {
+	.nodes =3D mc_virt_nodes,
+	.num_nodes =3D ARRAY_SIZE(mc_virt_nodes),
+	.bcms =3D mc_virt_bcms,
+	.num_bcms =3D ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const mmss_noc_bcms[] =3D {
+	&bcm_mm0,
+	&bcm_mm1,
+	&bcm_mm2,
+	&bcm_mm3,
+};
+
+static struct qcom_icc_node * =
const mmss_noc_nodes[] =3D {
+	[MASTER_CNOC_MNOC_CFG] =3D &qhm_mnoc_cfg,
+	[MASTER_CAMNOC_ICP] =3D &qxm_camnoc_icp,
+	[MASTER_CAMNOC_HF0] =3D =
&qxm_camnoc_hf0,
+	[MASTER_CAMNOC_HF1] =3D &qxm_camnoc_hf1,
+	[MASTER_CAMNOC_SF] =3D &qxm_camnoc_sf,
+	[MASTER_MDP_PORT0] =3D &qxm_mdp0=
,
+	[MASTER_MDP_PORT1] =3D &qxm_mdp1,
+	[MASTER_ROTATOR] =3D &qxm_rot,
+	[MASTER_VIDEO_P0] =3D &qxm_venus0,
+	[MASTER_VIDEO_P1] =3D &qxm_venus1,
+	[MASTER_VIDEO_PROC] =3D &qxm_venus_arm9,
+	[SLAVE_MNOC_HF_MEM_NOC] =3D =
&qns_mem_noc_hf,
+	[SLAVE_MNOC_SF_MEM_NOC] =3D &qns_mem_noc_sf,
+	[SLAVE_SERVICE_MNOC] =3D &srvc_mnoc,
+};
+
+static const struct =
qcom_icc_desc sm7250_mmss_noc =3D {
+	.nodes =3D mmss_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(mmss_noc_nodes),
+	.bcms =3D mmss_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(mmss_noc_bcms),
+};
+
+static struct =
qcom_icc_node * const npu_noc_nodes[] =3D {
+	[MASTER_NPU_SYS] =3D =
&amm_npu_sys,
+	[MASTER_NPU_NOC_CFG] =3D &qhm_cfg,
+	[SLAVE_NPU_CAL_DP0] =
=3D &qhs_cal_dp0,
+	[SLAVE_NPU_CP] =3D &qhs_cp,
+	[SLAVE_NPU_INT_DMA_BWMON_=
CFG] =3D &qhs_dma_bwmon,
+	[SLAVE_NPU_DPM] =3D &qhs_dpm,
+	[SLAVE_ISENSE_CFG] =3D &qhs_isense,
+	[SLAVE_NPU_LLM_CFG] =3D &qhs_llm,
+	[SLAVE_NPU_TCM] =3D &qhs_tcm,
+	[SLAVE_NPU_COMPUTE_NOC] =3D &qns_npu_sys,
+	[SLAVE_SERVICE_NPU_NOC] =3D &srvc_noc,
+};
+
+static const struct =
qcom_icc_desc sm7250_npu_noc =3D {
+	.nodes =3D npu_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(npu_noc_nodes),
+};
+
+static struct =
qcom_icc_bcm * const qup_virt_bcms[] =3D {
+	&bcm_qup0,
+};
+
+static struct qcom_icc_node * const qup_virt_nodes[] =3D {
+	[MASTER_QUP_CORE_0] =3D &qup_core_master_1,
+	[MASTER_QUP_CORE_1] =3D =
&qup_core_master_2,
+	[SLAVE_QUP_CORE_0] =3D &qup_core_slave_1,
+	[SLAVE_QUP_CORE_1] =3D &qup_core_slave_2,
+};
+
+static const struct =
qcom_icc_desc sm7250_qup_virt =3D {
+	.nodes =3D qup_virt_nodes,
+	.num_nodes =3D ARRAY_SIZE(qup_virt_nodes),
+	.bcms =3D qup_virt_bcms,
+	.num_bcms =3D ARRAY_SIZE(qup_virt_bcms),
+};
+
+static struct =
qcom_icc_bcm * const system_noc_bcms[] =3D {
+	&bcm_sn0,
+	&bcm_sn1,
+	&bcm_sn10,
+	&bcm_sn2,
+	&bcm_sn3,
+	&bcm_sn4,
+	&bcm_sn5,
+	&bcm_sn6,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] =3D {
+	[MASTER_SNOC_CFG] =3D &qhm_snoc_cfg,
+	[A1NOC_SNOC_MAS] =3D =
&qnm_aggre1_noc,
+	[A2NOC_SNOC_MAS] =3D &qnm_aggre2_noc,
+	[MASTER_GEM_NOC_SNOC] =3D &qnm_gemnoc,
+	[MASTER_PIMEM] =3D &qxm_pimem,
+	[SLAVE_APPSS] =3D &qhs_apss,
+	[SNOC_CNOC_SLV] =3D &qns_cnoc,
+	[SLAVE_SNOC_GEM_NOC_GC] =3D &qns_gemnoc_gc,
+	[SLAVE_SNOC_GEM_NOC_SF] =3D=
 &qns_gemnoc_sf,
+	[SLAVE_OCIMEM] =3D &qxs_imem,
+	[SLAVE_PIMEM] =3D =
&qxs_pimem,
+	[SLAVE_SERVICE_SNOC] =3D &srvc_snoc,
+	[SLAVE_QDSS_STM] =3D =
&xs_qdss_stm,
+	[SLAVE_TCU] =3D &xs_sys_tcu_cfg,
+};
+
+static const struct qcom_icc_desc sm7250_system_noc =3D {
+	.nodes =3D system_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(system_noc_nodes=
),
+	.bcms =3D system_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(system_noc_bcms)=
,
+};
+
+static const struct of_device_id qnoc_of_match[] =3D {
+	{ .compatible =3D "qcom,sm7250-aggre1-noc", .data =3D &sm7250_aggre1_noc =
},
+	{ .compatible =3D "qcom,sm7250-aggre2-noc", .data =3D =
&sm7250_aggre2_noc },
+	{ .compatible =3D "qcom,sm7250-compute-noc", .data =
=3D &sm7250_compute_noc },
+	{ .compatible =3D "qcom,sm7250-config-noc", .=
data =3D &sm7250_config_noc },
+	{ .compatible =3D "qcom,sm7250-dc-noc", .=
data =3D &sm7250_dc_noc },
+	{ .compatible =3D "qcom,sm7250-gem-noc", .data=
 =3D &sm7250_gem_noc },
+	{ .compatible =3D "qcom,sm7250-mc-virt", .data =
=3D &sm7250_mc_virt },
+	{ .compatible =3D "qcom,sm7250-mmss-noc", .data =
=3D &sm7250_mmss_noc },
+	{ .compatible =3D "qcom,sm7250-npu-noc", .data =
=3D &sm7250_npu_noc },
+	{ .compatible =3D "qcom,sm7250-qup-virt", .data =
=3D &sm7250_qup_virt },
+	{ .compatible =3D "qcom,sm7250-system-noc", .data=
 =3D &sm7250_system_noc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, =
qnoc_of_match);
+
+static struct platform_driver qnoc_driver =3D {
+	.probe =3D qcom_icc_rpmh_probe,
+	.remove =3D qcom_icc_rpmh_remove,
+	.driver =3D {
+		.name =3D "qnoc-sm7250",
+		.of_match_table =3D =
qnoc_of_match,
+		.sync_state =3D icc_sync_state,
+	},
+};
+
+static int __init qnoc_driver_init(void)
+{
+	return =
platform_driver_register(&qnoc_driver);
+}
+core_initcall(qnoc_driver_init)=
;
+
+static void __exit qnoc_driver_exit(void)
+{
+	=
platform_driver_unregister(&qnoc_driver);
+}
+module_exit(qnoc_driver_exit)=
;
+
+MODULE_DESCRIPTION("Qualcomm SM7250 NoC driver");
+MODULE_LICENSE("GPL");

--=20
2.56.0

