Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8B36E49B;
	Thu, 23 Apr 2026 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960491; cv=none; b=GpD0GhVq7JD0UkLQXQW7kLDjj2qXjWYqIWPpcmKFlVcqZEvUMvbxD6QAv458Apmq6MS2+QWtEigT83K4EWjQvysBz8WTCvaDSK6nBFU0S2B422qD1QoNOMzAbt7EW3e53BxoCgw7Wz9ijzkeFRgMynykNs4pieUBeh1DpsmRWqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960491; c=relaxed/simple;
	bh=kmxFj256ZqyHHjW0JUrAO7Zmt5qTIX49xsO6Ct108OU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k0MsYb4JtggnJLkxlouBkpI4lJbhYY7NApg1jHJiwUDhuTPRU0zI29HZpKDUX2aKBzMtdIqanGkNZJ+YYjre86joW0AzaZc8stNMISjCYkhMnNlHGTOa6cb/w1RHEVMqGUFuI/ps5srbRgf26CRY/PQSpBVXV90GqD3hVvjjXSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3xMb9Y/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3xMb9Y/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E765DC2BCB7;
	Thu, 23 Apr 2026 16:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776960491;
	bh=kmxFj256ZqyHHjW0JUrAO7Zmt5qTIX49xsO6Ct108OU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L3xMb9Y/ushFC9+3dS23UJfFvPmkTG9sQi//20kGlL2F0CCfXWC5+k1mT7WLjzsvy
	 RvlaKhLDls0BH37Cb7uJzkJf3ck68SPx9hlGp7EN3uMKqkNvMF7c1UyK614FxJf3Y2
	 cT4dMx+uiQOipcQjS+uT0jnjFP/OuuKvfKJWEZ52CM4je3AYoVOvddDLyuUDZmYWsj
	 G1R5MFRt1O95Q7jEHFB4KamBIjaNT/UCfW3nsLEzPf2nHAH/0Kh9X20bQLr8tbVcij
	 6vUlEE+g/U6DlZFUyAdgv93Te3qDuoCOakQip5uPbZD9t7DTNLd91AvkhA5afbG6kD
	 LLQMGx4EJkonw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA764F589D9;
	Thu, 23 Apr 2026 16:08:10 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Thu, 23 Apr 2026 18:07:17 +0200
Subject: [PATCH v4 2/8] firmware: meson: sm: Thermal calibration read via
 secure monitor
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-add-thermal-t7-vim4-v4-2-d4c1528d5044@aliel.fr>
References: <20260423-add-thermal-t7-vim4-v4-0-d4c1528d5044@aliel.fr>
In-Reply-To: <20260423-add-thermal-t7-vim4-v4-0-d4c1528d5044@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=z46M+rsMVvol/Iu/vuO1m+rAUYrJ82iMmifq0EnDoU0=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ+Yr5wd19ruFs27aWU42aw5k55HewVi6/0sc32XtCv4O5
 WO1ZRs6SlkYxLgYZMUUWfrnWp54d/noma971FNg5rAygQxh4OIUgIlktTMyHPfQWLq7ha3QvZPl
 ZtAshjNGEyW09nUqnta2/+7sW6zmx/CHm00zOkon53rbO3H+9GSjI+ahpcZbnlbccH+13fOhwyI
 mAA==
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


