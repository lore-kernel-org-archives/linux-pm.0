Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD11A2545;
	Fri, 24 Apr 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045656; cv=none; b=K4jtna+9SHdgGGnyaLYh9wG9nLQ9xc8ovyKPzEe+k8dMr+NeAMO83ZRt7oLa8hbXN7e/6YejzFYUkAWosjSbhqLupgMjUioPl8IW/QWqo5WuZUMgQJrUAO6pZXr9+b74SDrIAWM4wx9eTuIEdMmjwGjL/GpXHZi7L5/aIs7JmJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045656; c=relaxed/simple;
	bh=cMGDrFg61aGwyz734Xgs5gOHCfTOozPvglCuCWWc0fI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Etv9RNlihrvoXTW73KERuzvtRhveRnjG7Po8nZUZp1GU9oocVyRpQ52Q8D85aRijRLxtNyQfOk28a8vjfOOCHY9s4LtBSbAP7sSGUDXx2XUZaDMQsL1WKp4h1FYe143y2qv9elEUiFMI7CFT6fq+nLCWIOF6wuuczHsvxToZVes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByCrqxx6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByCrqxx6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0129C2BCB8;
	Fri, 24 Apr 2026 15:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777045656;
	bh=cMGDrFg61aGwyz734Xgs5gOHCfTOozPvglCuCWWc0fI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ByCrqxx6kY/Vv/bdtP4v3zMgk4MUmk0DbJYXTkzwTdnnl/jDhWWlWIr4tC0NE3kSY
	 ilqtNJoml0hrWQdTs8TJAhnF0AbjZeWwhhIjq21Owm8/lWb18jKlJdQcS0WL/+wApw
	 38k7rSo+AE7h7bo7BZBN1wMGImsAIOOL0urfqI93McwQMtpKHH3+3jv9Y7/o+GbIzk
	 Fkvp3TpAmOG3xyFpAw4rB8sOmNby8HF8hAsm5hS1Gy1uuGi+VSygcVy1nDfhpB+EAR
	 lbcyobxCAqPvGFanmiugQXU767V1oqHHeHOTzlweMBZPGbwOY8bABtXkvT6D67DzuG
	 rCSzBlr+PqPfw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC20FED3EC;
	Fri, 24 Apr 2026 15:47:35 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 24 Apr 2026 17:45:10 +0200
Subject: [PATCH v5 2/8] firmware: meson: sm: Thermal calibration read via
 secure monitor
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-add-thermal-t7-vim4-v5-2-9040ca36afe2@aliel.fr>
References: <20260424-add-thermal-t7-vim4-v5-0-9040ca36afe2@aliel.fr>
In-Reply-To: <20260424-add-thermal-t7-vim4-v5-0-9040ca36afe2@aliel.fr>
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=X3csRgyz9ieRxPvJL2SoBHgakr7+scAeWEibnYe+kXA=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ+brCd0fZNZwi+q8dzZhOtRy/DJ7qPfOIAen++aXVtccL
 FX+lHy3o5SFQYyLQVZMkaV/ruWJd5ePnvm6Rz0FZg4rE8gQBi5OAZiI12mG/zXpt8/u22VZKr5b
 8rexQyjDv+62Z1U57G06y8QvcBlLsDAyzFIqWfPjzYvw53d/7uSqeHuXb5f1pLotq9muvjFmdJm
 TzAYA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Add SM_THERMAL_CALIB_READ to the secure monitor command enum and
introduce meson_sm_get_thermal_calib() to allow drivers to retrieve
thermal sensor calibration data through the firmware interface.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 include/linux/firmware/meson/meson_sm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
index 8eaf8922ab020..3ebc2bd9a9760 100644
--- a/include/linux/firmware/meson/meson_sm.h
+++ b/include/linux/firmware/meson/meson_sm.h
@@ -12,6 +12,7 @@ enum {
 	SM_EFUSE_WRITE,
 	SM_EFUSE_USER_MAX,
 	SM_GET_CHIP_ID,
+	SM_THERMAL_CALIB_READ,
 	SM_A1_PWRC_SET,
 	SM_A1_PWRC_GET,
 };
@@ -27,5 +28,7 @@ int meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
 		       unsigned int bsize, unsigned int cmd_index, u32 arg0,
 		       u32 arg1, u32 arg2, u32 arg3, u32 arg4);
 struct meson_sm_firmware *meson_sm_get(struct device_node *firmware_node);
+int meson_sm_get_thermal_calib(struct meson_sm_firmware *fw, u32 *trim_info,
+			       u32 tsensor_id);
 
 #endif /* _MESON_SM_FW_H_ */

-- 
2.49.0


