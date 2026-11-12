Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491378;
	b=kfwaZioT2fc9DaRStcrOkz5mBndC8yUR0ZJOrUGhJFjMvAL0d2noaJuGDHa2tqw6olzX
	 R+npUxPOV+BoGdPMjWsoI8arroMs03DK5CUxeDGNm5m7CAUzTmq8qHe/uSFqnvRON+IMG
	 8PInzBP5J9fFI/SVc8+v1SVBOxN8qDB0kETYLJyrUEIAws0QwByK8UtV3HdoiPZJ5apyc
	 nfFjaf2oxV2zkLiKYA6e3g79h5xuk+pNlT8t49CY4yw0QKc1FazZgLWtDdzinNCtXq8G8
	 U4NbE1Nu+J8L0EtZgIOgsMOyhnbAZJZOBB8tnrU9XYJ35WcOputAKuXeX2AnZZTFuUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2vHG4fjXWFVR+UOug7O+NH5YlX7OSBRB9SJwAE/JWnA=;
	b=yhlN63cJWuPEHw7AUQaiSn/liOWICGvIlSZ8WlEYPoJS0hmuIoCGZesbpyQCkRpB1NmG
	 jYO4VWNOMAyvgIphbACt2aY32Dg1vlLMRr0svuK2gV0JZ5lvjfcpuwsc8mbT6BBRaysrZ
	 K6nvdAnXW7TDJBbVcwYm7XEukZEQZIY4C0CQFNZ7m0q0hCvzfYs4SfPiQWMj5zBiwYvBf
	 tIwXBhAyVs1Ky75tTYUyQYr5RZzt2HMAKSxdhX9ZrgItEa8Y2j5aRhIb6SRtC2H5VmKij
	 34ZOoBrB6h435qxscOVXkgCg8A+j1EpMycpaXlo/uBV2ml614DnL6EoFucwBD9hXqtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="b80b3/Xu";
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BA3606A8A9
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 13:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17BA3606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b80b3/Xu
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a0673d9bd2so2797325b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 05:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794491376; x=1795096176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2vHG4fjXWFVR+UOug7O+NH5YlX7OSBRB9SJwAE/JWnA=;
        b=b80b3/XucWAvkorPAcPXrSbu/T5ngQ7xU55B3sEoq0kWuXSr3jk/K95ufVNyALs1mQ
         It/fh4+/vaVtl+3W3nK3Tya3xGeZiyt6oOJlWDUNpsYz06WeERQfu9Fpf0cjH7EdprcO
         yyUvW9lm+MqFn/wp88qecQJXTfuo79RAuskBik7l7DKZm2tsDg4GRCWjJjfvl9kpQUCT
         Yc/MJUJenBluKUBKjJvWg4pUxa/L8YkSAWS9TkpalvUtS1oMNl2WirfmQIkY4YyRtUYc
         3BnAnnPVLjb+Og8rmMGS5AIK7yjpHVAQJXqQA+gs0XzmvuoDHcUfgEFeqMFZ+4L4X8rR
         SFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794491376; x=1795096176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2vHG4fjXWFVR+UOug7O+NH5YlX7OSBRB9SJwAE/JWnA=;
        b=KGqi3+gKmq74kDwyxPn4k3CpmDw8F8AsUbjVdjsYlSgz1gLwmFIGmFLpcQFA6OcQ+g
         zxtRt+xuXX5RdNIR+mRMLkzOtS1LoAyGOIna/80z5+a1gkdNKUk/Z7MbmL6cKlylMSMB
         iBvBnbcGWGwhbxIBYzh9ccBga19biRvVnsmOaukOsGQrJO4mROciEaJ/u/28Isb6zdU3
         Ftgq4OWp4L+b4nqjspe8x53+KFzDtorwD6kTH2xiMz1WtjVKVHWIBq5u1r6uEkGxLXZf
         j7tTQxcdQjlYTiR/0wgCigkLyCTO6crkh85OPwSGtxH+uaH1pLXAafPPp1Ao0lOBybLg
         9xMQ==
X-Forwarded-Encrypted: i=1; AL+hErEIiXoBpB/+eg5UCPHXcV2Eu7IO0OwvMMwU0WhwsA9NKHBY4vZMF5x+5so2hwXP+DR4T1Hpr25O5g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+I9hiMtzJxsbd4TUAlc28riTOkp5R+TXNe5GYWoxm6vq5slOOh
	rlROS3B8R7blgtZBXv8FynDNb0m7th4/M3pNMexGKehGPAzzbdzj9Kf8
X-Gm-Gg: AYBFou3XAXVUVuHVnsCoNiuNcGoxjE/hEa9zQrouAJgWAy3K4P3L0GWjFDdpth3wXaq
	filUkP8mgpAFlNWKjfzxEZn4crXOUTjijdVq8Dl4/8IKpRSGCtoUd0xDzAXZycAO+3l7OMywufy
	u8x2l/j59QFMICWsHt4KlCPxzeNERl2eJ5QnIJRGq7FnFLSKZloll1JQwhC+aMka8gfyFZeNVzu
	9lyhOH9aS/C2uq/6SWIO5DruhSjR7AG/EMYe4zDuHu3q7IyZf7o45IGLb9RPVlo2+V3ur9JOK9d
	8urr17FSGBN1JCOl3HAexGbGRJGu7Vd4976zHkwGEFEHEdY8J3BUVt08AXE7sphcL8vsxExMUVZ
	TiVPJdI54QzQgKv9iHyHyv+5rH2YfhR5+29i2ky6sWS1474E6QVlU8bQfk7aN3Sh8i6PIZ67P+A
	ZWS8LODoRxc/p6FR+W4hzZxAxfzRZZxuD7x7bDgLQq0y5CoeqnKYPoJW0hvX2baWRC9s8kxkbOr
	hgC0a/z8qdsa/f3kTT8GwuexBRYyT7vDQQzb5TYzD4eJYA2GwuIy4jIQR08NPzYZMTIS3HjHcXI
	fC+yuZcmAwMfZLWkCyhqLCzmYEJQfq/5EDt0bc7qOg==
X-Received: by 2002:a05:6a21:407:b0:3e2:7882:f14d with SMTP id adf61e73a8af0-3f2ffac4031mr5937239637.70.1794491376116;
        Thu, 12 Nov 2026 05:49:36 -0800 (PST)
Received: from DESKTOP-NM9EKIA ([180.67.33.100])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa2a6c51sm3550580b3a.14.2026.11.12.05.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:49:35 -0800 (PST)
From: Joonhoe Kim <26rote@gmail.com>
To: sre@kernel.org
Cc: konrad.dybcio@oss.qualcomm.com,
	jingyi.wang@oss.qualcomm.com,
	kamal.wadhwa@oss.qualcomm.com,
	anjelique.melendez@oss.qualcomm.com,
	dhruvin.rajpura@oss.qualcomm.com,
	andersson@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] power: supply: qcom_battmgr: fix the battery current sign on Kaanapali
Date: Thu, 12 Nov 2026 22:49:26 +0900
Message-ID: <20261112134927.95-2-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261112134927.95-1-26rote@gmail.com>
References: <20261112134927.95-1-26rote@gmail.com>
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

The Kaanapali battery firmware reports the battery current with
discharge positive: on a Lenovo Y700 Gen 5 (TB323FU) current_now reads
-9.1 A while charging and +0.57 A on battery. The power_supply ABI has
charging positive, and upower reports such a charging battery as
discharging.

Other firmware behind the same callback uses the ABI sign [1], so
negate the value only for qcom,kaanapali-pmic-glink.

Fixes: 16a7c32e586e ("power: supply: qcom_battmgr: Add support for Glymur and Kaanapali")
Link: https://lore.kernel.org/all/20260829054546.86210-1-jan.brummer@tabos.org/ [1]
Signed-off-by: Joonhoe Kim <26rote@gmail.com>
---
v2: no code change; reworded the device name.

The sign is checked only on the Y700 Gen 5. On v1 Konrad asked Jingyi
to check QRD/MTP; no reply yet:
https://lore.kernel.org/all/0e5b7d2e-e141-4ce4-a873-b65bd9ef3c4a@oss.qualcomm.com/

 drivers/power/supply/qcom_battmgr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index d6e3edbab..58e103e08 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -316,6 +316,7 @@ struct qcom_battmgr {
 	struct pmic_glink_client *client;
 
 	enum qcom_battmgr_variant variant;
+	bool current_inverted;
 
 	struct power_supply *ac_psy;
 	struct power_supply *bat_psy;
@@ -1574,6 +1575,8 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 			break;
 		case BATT_CURR_NOW:
 			battmgr->status.current_now = le32_to_cpu(resp->intval.value);
+			if (battmgr->current_inverted)
+				battmgr->status.current_now = -battmgr->status.current_now;
 			break;
 		case BATT_TEMP:
 			val = le32_to_cpu(resp->intval.value);
@@ -1804,6 +1807,9 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	else
 		battmgr->variant = QCOM_BATTMGR_SM8350;
 
+	battmgr->current_inverted = device_is_compatible(dev->parent,
+							 "qcom,kaanapali-pmic-glink");
+
 	ret = qcom_battmgr_charge_control_thresholds_init(battmgr);
 	if (ret < 0)
 		return dev_err_probe(dev, ret,
-- 
2.53.0

