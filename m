Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121396;
	b=SjbIekyZqTIoSRTcbAV7YoPqNH0qoWcrKJdTRYq8IfeJwEgHx87aYfALSjeh1pvjYA7Y
	 n+XIH2WiLm9Er0k9ds3DGtySprJdX+Ly08mjA9drMMc84KhwN6YkSRx7k573vcNpIEjtk
	 zn4XFxVKnRxIuxx71qoWxozNwGuCX5BjEDoGQ/tt66DbapCr36309WkpStketjWSCkSKa
	 akajrCFMBvdgvjpmWGP7Q4EPSYynSvV9N8IUehv/gW6PChiBV2XR20mgBBtNFekGUTuRt
	 A+Y3FKKdp0K+5uL/0ZZVN5yhyHOhD3M8RB55NgoCUkowAukbNtaoTDSGutuGSI5cI8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121396;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=g+huM/NKQcWUPIHptRetUeMwbx85L5S5iTYg0Z/daLI=;
	b=lPbODsycmcYdPoqZPFXfCZxlU3e3mIeqOOLVS+mfy71ijz92g0Qybu9wDQcBf0EBWILe
	 ukOwyYfbi/ivtVa2lrVIJ/k2LNt92fhq9RCuqkT662ubBXXD5M8e9JmV0bM73BHX+JFe5
	 SmmEQpxGvSgMgkkWraSedIa/h1JXY1yIUT/IYPlpu97BDIDPq2BvLQkzqpoiq6xyqm1Ok
	 qLHZt9EVIn7UjA+QB//Zg56cmarj64j/w7mGO7imb1Q96GHMFt+Mw6HSq3BTJMYAF8bkT
	 HLgr1Gp0lngFwG1zLGMPFxYL//FH1euLPIpiDXmIVtaP237adkKdNaPRcRLWig8oIpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=R9B7rd3B;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SUSj9R92;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0758606A31A
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 07:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0758606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=R9B7rd3B;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SUSj9R92
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2FEDA7A00D8
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 02:03:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 08 Nov 2026 02:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794121390; x=
	1794207790; bh=g+huM/NKQcWUPIHptRetUeMwbx85L5S5iTYg0Z/daLI=; b=R
	9B7rd3BNViMdbqCN7hT0qGarpy5PElWmNgzdzFb3oRUQysN0QM+msxh8vpE6q860
	C84iTsUdQJVN2PySbKhRXzzdP4wjLMU76pI6ellidwPqyWW5yKgb3mrpEmZPAik3
	x/CSl9sTGwYW7bnmXeg3X0alHDJjZXAdJuLnDP9MbktXzPWiLCEYYgYr03I13eC+
	Y4CsbTVIinxcabL36dmnoMfwnUEHME6B0nsb81gM8RVEcmHMu4WJ7Pb1JvbuplCI
	FsG1o9cWwPuSJ1++K7w2R4XxRw/1oGR1W5qz9B2U+Bpe1PVZ3Y/mhBAKnX1fxRLD
	ZnzrlPWzQRevdz+HlrH0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794121390; x=1794207790; bh=g
	+huM/NKQcWUPIHptRetUeMwbx85L5S5iTYg0Z/daLI=; b=SUSj9R92P/31qNtCS
	OqosTKcFxMDG1WcjIxvRlG0J++v9Al5G6XNzAAM48s62Y2HMbHdFu5W9kdJbWk0x
	KL3LxfhHxtUzGed5aOrjq0nEeZJ4XcJ9MUmXuSMBNNE3bMDk/lYAvyvYV0a7khss
	+fuHOOO/gbmb4ALw1lxTH2KtPPvkNxylkI2WusIca92PwXCWYAWqiQqrGCjJb4Pr
	+q61Fj29LtaOG3H3MmVs7ep5tjiulbQ6zlKCEll6H7sXSVbC7JHjgHxkUNmOHUhJ
	HpYyU3Dyg4lzi5VUZwXMQHIhEkoHOMF5JttGtSKMPrOhlMEUWsikVattHoTwmZJn
	8Q4NA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794121390; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:hRwUjiTVDOjFxCzROlaHBDZYdVJ0DBFtPQjAsgOucCcKaUW
	h6Mo2jg08PWAjQM2aO2SMWdE//yUgHrqrW9Rsp26mJYbDx15lqtoWai1O98G/wTP
	pebz8RlOR+bJjlxRDFQU3P83DKFEv4Lcezf/xlTIiXIVsmcGxpxUZIeCpgTzn49l
	qzzvJGEEinhbydOOUIIK7jmTmmfZdBnEBOHj3b8f6eIUTqMw/Mp3dk/7d6iVEsSg
	UQH9G5lFNtC+ldTWV1NYmYihcBOCR1FVttAtTuMtADpr7EB9P+fj8LvvG+j6OGP5
	jFx1SjIA7cPAqRVxDfuVKn1QJaFiaqZ8eQ81ktg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:vdaGr8RqO7sU/de1fBqcB5bQ1dSYXkuJ1evB9fZmycQ=:EHpEhZcDNXxevg9L8+GX0gX62PoVMOoLNiKInDNyB3k=;
X-ME-Sender: <xms:rh7wag79_9IQlieKZPN-Z5MjX5MDwd9HiSRFIOuofvnokZkHL6mXCQ>
    <xme:rh7wauXT0CQ4CakUan2X4AWLohuUrZfWDh-M8ogtT3cvPZ3mLMrBWfWPVAgjjAdzi
    o6XFI6UDZR_GhAu_nghI8-qfMZgHutyztrdTN8TG8JA0V0RijjrOTvQ>
X-ME-Received: <xmr:rh7wamtBREOsy380tA9HhQMSURhVkXkIKgRUWb6dpXtsI8XO4ZWjGQ1dlSNrvUAug4Hh8FVq>
X-ME-Proxy-Cause: dmFkZTFKhclCCJN9i5LFQp5fvn9DylL5PDR95+qcmUDEkBDvAaUlhVhO6JW1PTcA0oiilr
    afxU+kS37MwfkRVrV2sLhNS1OkBSH9hrpfUYkvEeAEfTx8oUhC1lvQdEqsrvfO12L2kPDm
    Y90xvEv61R5vWsABT3XVmqKcWsSTBPoQRHs33ySAWpN7mh8mIX7nfmpu6Q5St0DdZLVl6o
    GJpMHUC7TjUVqLMHfqfKk9SHn10f5lL6CdG6YeehrsosttZtbM1aNiFk46XYC+svmJcMBn
    4w1I3sJZaXrv8SSndHCWUOH7cbPZHBY65Sr1oZjnZZRxSV2wTTFO+3xU/Lmvhk4YCMlhJv
    ZSSK/ZaNH8UYgys9cYpUBi0V9VivVdlDRnsl6Hr9yZAEYPUinUlA/9oH0xC3P9C+I18X2q
    1KJ2ZzPpUcgaIXPpZ7avIxu/qr+KgduGQFTh+LzlOQHAASQLngIATaHg+Dp3Sp4YEIR5TU
    u+M5rXYGRNkY4eDT7EOXjaqj9ebW7EF2KUq8wuM4okv4IL/RzZc7V3i5cKG+T2Ncu0bRHZ
    HVzDZ4RL0aiLEDMcmvJ0qFknSKMG2Y6uDDpidBQk274C8JvgDurwlqMIF2LxPWS1XVnfRb
    NbAlsSxA8tTXvFFzBM2So3mQjkx3nDX4xYaTEKfCF+vlS0u8SY2fT070HP8A
X-ME-Proxy: <xmx:rh7waroYz8w3YYMATAw4jVQZkAs3MrQ4UzYSJFgemZiOOOwUb5Swlw>
    <xmx:rh7wakYIwK_eGHVGqk7MXT7gIsfCjUqJbYWqg4-uLmyMkHtMu5qfYg>
    <xmx:rh7wasxgOgcya0OikFGQ7HVp_XIoGtk1WAdDSvFeNxSCha8KCx_yUQ>
    <xmx:rh7waq9zxH_RTRB37HMefNFWAXqKnxaMy9pNpJPWWnsjBZfVlGmkCQ>
    <xmx:rh7wamT0KwdfR-epRs3q3qMRtqdFmql6xuTPEh9oBZPf6rOoFAs4r891>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 02:03:01 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	shawn.lin@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v16 13/16] accel/rocket: add a GET_PARAM ioctl for the hardware version
Date: Sun,  8 Nov 2026 19:59:14 +1300
Message-ID: <20261108065917.135194-14-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108065917.135194-1-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com>
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

Add DRM_IOCTL_ROCKET_GET_PARAM so that userspace can query the NPU
hardware version and pick the matching hardware description, such as the
SRAM configuration and the register layout.

Add DRM_ROCKET_PARAM_HW_VERSION, which returns a hardware version enum
that matches the device tree compatible.

The enum starts at 1 and 0 is not used:

  RK3588: 1
  RK3576: 2

An unknown parameter or a non-zero reserved field returns -EINVAL.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.h |  1 +
 drivers/accel/rocket/rocket_drv.c  | 29 ++++++++++++++++++++++
 include/uapi/drm/rocket_accel.h    | 40 ++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index d5d353cc38e7..13d962467ff0 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -31,6 +31,7 @@ struct rocket_soc_data {
 	unsigned int num_clks;
 	unsigned int num_resets;
 	bool task_con_16bit;
+	u32 hw_version;
 };
 
 struct rocket_core {
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index fff31c1ebe52..c094f6843095 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -5,6 +5,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_ioctl.h>
+#include <drm/drm_print.h>
 #include <drm/rocket_accel.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -129,6 +130,31 @@ rocket_postclose(struct drm_device *dev, struct drm_file *file)
 	module_put(THIS_MODULE);
 }
 
+static int
+rocket_ioctl_get_param(struct drm_device *dev, void *data, struct drm_file *file)
+{
+	struct rocket_device *rdev = to_rocket_device(dev);
+	struct drm_rocket_get_param *args = data;
+	const struct rocket_soc_data *soc;
+
+	if (args->reserved != 0) {
+		drm_dbg(dev, "Reserved field in drm_rocket_get_param struct should be 0.\n");
+		return -EINVAL;
+	}
+
+	soc = READ_ONCE(rdev->cores[0].soc);
+	if (!soc)
+		return -ENODEV;
+
+	switch (args->param) {
+	case DRM_ROCKET_PARAM_HW_VERSION:
+		args->value = soc->hw_version;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct drm_ioctl_desc rocket_drm_driver_ioctls[] = {
 #define ROCKET_IOCTL(n, func) \
 	DRM_IOCTL_DEF_DRV(ROCKET_##n, rocket_ioctl_##func, 0)
@@ -137,6 +163,7 @@ static const struct drm_ioctl_desc rocket_drm_driver_ioctls[] = {
 	ROCKET_IOCTL(SUBMIT, submit),
 	ROCKET_IOCTL(PREP_BO, prep_bo),
 	ROCKET_IOCTL(FINI_BO, fini_bo),
+	ROCKET_IOCTL(GET_PARAM, get_param),
 };
 
 DEFINE_DRM_ACCEL_FOPS(rocket_accel_driver_fops);
@@ -227,12 +254,14 @@ static const struct rocket_soc_data rk3588_soc_data = {
 	.num_clks = 4,
 	.num_resets = 2,
 	.task_con_16bit = false,
+	.hw_version = DRM_ROCKET_HW_RK3588,
 };
 
 static const struct rocket_soc_data rk3576_soc_data = {
 	.num_clks = 6,
 	.num_resets = 1,
 	.task_con_16bit = true,
+	.hw_version = DRM_ROCKET_HW_RK3576,
 };
 
 const struct of_device_id rocket_dt_match[] = {
diff --git a/include/uapi/drm/rocket_accel.h b/include/uapi/drm/rocket_accel.h
index d0685e372b79..597bf892c96d 100644
--- a/include/uapi/drm/rocket_accel.h
+++ b/include/uapi/drm/rocket_accel.h
@@ -15,11 +15,13 @@ extern "C" {
 #define DRM_ROCKET_SUBMIT			0x01
 #define DRM_ROCKET_PREP_BO			0x02
 #define DRM_ROCKET_FINI_BO			0x03
+#define DRM_ROCKET_GET_PARAM			0x04
 
 #define DRM_IOCTL_ROCKET_CREATE_BO		DRM_IOWR(DRM_COMMAND_BASE + DRM_ROCKET_CREATE_BO, struct drm_rocket_create_bo)
 #define DRM_IOCTL_ROCKET_SUBMIT			DRM_IOW(DRM_COMMAND_BASE + DRM_ROCKET_SUBMIT, struct drm_rocket_submit)
 #define DRM_IOCTL_ROCKET_PREP_BO		DRM_IOW(DRM_COMMAND_BASE + DRM_ROCKET_PREP_BO, struct drm_rocket_prep_bo)
 #define DRM_IOCTL_ROCKET_FINI_BO		DRM_IOW(DRM_COMMAND_BASE + DRM_ROCKET_FINI_BO, struct drm_rocket_fini_bo)
+#define DRM_IOCTL_ROCKET_GET_PARAM		DRM_IOWR(DRM_COMMAND_BASE + DRM_ROCKET_GET_PARAM, struct drm_rocket_get_param)
 
 /**
  * struct drm_rocket_create_bo - ioctl argument for creating Rocket BOs.
@@ -185,6 +187,44 @@ struct drm_rocket_submit {
 	__u64 reserved;
 };
 
+/**
+ * enum drm_rocket_param - parameters for DRM_IOCTL_ROCKET_GET_PARAM
+ * @DRM_ROCKET_PARAM_HW_VERSION: an enum drm_rocket_hw_version value.
+ */
+enum drm_rocket_param {
+	DRM_ROCKET_PARAM_HW_VERSION = 0,
+};
+
+/**
+ * enum drm_rocket_hw_version - the NPU, one value per DT compatible
+ * @DRM_ROCKET_HW_RK3588: "rockchip,rk3588-rknn-core"
+ * @DRM_ROCKET_HW_RK3576: "rockchip,rk3576-rknn-core"
+ */
+enum drm_rocket_hw_version {
+	DRM_ROCKET_HW_RK3588 = 1,
+	DRM_ROCKET_HW_RK3576 = 2,
+};
+
+/**
+ * struct drm_rocket_get_param - ioctl argument for querying a parameter.
+ */
+struct drm_rocket_get_param {
+	/**
+	 * @param: Input: an enum drm_rocket_param value.
+	 */
+	__u32 param;
+
+	/**
+	 * @reserved: Reserved, must be zero.
+	 */
+	__u32 reserved;
+
+	/**
+	 * @value: Output: the value of the parameter.
+	 */
+	__u64 value;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.43.0

