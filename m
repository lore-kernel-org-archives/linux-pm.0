Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608269;
	b=I+NcuNQkrKQsBK05muWJ+rJOqgfCNRE/ezI0bpvTffkOAthEmxWT8QuoWTB19uLfhaNP
	 HbdKcQ5Opg9UOx7X3B4XwJG+bgXkFcuyxYGsVPJXCzBmKr9EZJhQDCPnhIdhQQ7EczpXB
	 lt7EwwPNh9wNCRiGRmJA0O8V8VXZ0URCaqDo19lYWpTsPUPDX7lQgf0twZ/GPvmIhWxiz
	 8PFVT5cbs/oDJQAnJwus+sImCwf2Dv2AH7UzUSzAYXS4sf2uIjFwHSdpSHm78alQYBHvP
	 l3HMw3feStAccS1J0ybqVaJcKWhTgIl+olVcuKqg/WEsfNSFYzpW1MNTRQyo/qWDOoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RoOMKJstRsz6kzVltt6LynRLltK4wJnMWDIO5lBxAHs=;
	b=q9Gs6fUHJQZ9YObO6a7wFI7kYM9Ael3rewmnllMVDt04a5/hOqYgh8vmBSoAMia1vZFP
	 2Gi+nKe1rsbySkJ2n7DVRWG4G5L3a3sCHPQa0lyrzlG0RdmVpP+KYWAwCauO8GCGU9pt6
	 GxMY9CeOvDKCzqlmeT5vl9feDhOmLhs3uk4lT6CRUQXBltzHUMXpnBeD4NsP59yam0cyz
	 p+ktOlSyhHh6rf6tmpzZTmr51R2KAIxSWjqlrgaKLPlEXJ9mqz+S+cC9D4RvZzXuUkUiE
	 x3n/2UuGPpKEjH3S84lvVxDBl0p93tOyQddNpxJOSBeCW1qLzcDl9fZCrDQ5L2yrO9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JUm7RyM+;
	arc=none smtp.remote-ip=74.125.229.134
Received: from mail-dl2-f6.google.com (mail-dl2-f6.google.com [74.125.229.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8900B606A32D
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 22:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8900B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JUm7RyM+
Received: by mail-dl2-f6.google.com with SMTP id a92af1059eb24-1b3a6a69818so231284c88.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 14:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794608268; x=1795213068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RoOMKJstRsz6kzVltt6LynRLltK4wJnMWDIO5lBxAHs=;
        b=JUm7RyM+AXnjvlrIH2lobJSVH0t/Th2jSkDpo0OPg7nx87/mKmOc4/Y+3HOngLad3B
         O1GBloJGH/x7tNHFVTdP0y+A/2aZxz+nOV+Qy8hdKmVzwcUGBN2stSRPPaqbmvd42lyO
         v8mk3Ku0eL/v/nhnAgp5pucHc9Qk5NkSJCE5jCGtfLCI/poehuw5Z8YD5UfBdwog0rHE
         pQJeQieHsN0wksmeC2iEel4yEuYNnbUdNpAmNfOaQQ/GJ1Fjx4E7SnKu7Ezb9Fg0bS0P
         uqikaNy+J/mIloWXi+sX3FcbCuEjzNl00L3Faaz4FXfxkqQQk+kxq7wSz+XPnioI98uz
         +u1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608268; x=1795213068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RoOMKJstRsz6kzVltt6LynRLltK4wJnMWDIO5lBxAHs=;
        b=2Z8E0ZI9SpgBnXClEzPc7v9s85WS/5zNfB9OIiiEzX/KNXw9smXD0CzctDYSq4kIbu
         Tnhb7u/62Ul0DRXFM3r3x2Vxnlrggwh8bxBuo/bsTghhi1c4sUeHmp4LwVfDLI6xiO/V
         fU/UoOr5xLMhsoZlRcIsu9JSFE5UtsJLMXQor/O36AKEdS+Ebhqkb4EpbMn2QZCZU7Zu
         XZq3WhL0E09ibQMVPmtm2ukDZ7QQJJH9Aw/lfDU+BxxqavjCHwKysBjpuz/0WX/cflEP
         /QH5Zncl63J2urf5Z13pj1Qe69UhFe0jmzChqmOWvF/UKalgipUmQuipo+yOVAttFLul
         mhrA==
X-Forwarded-Encrypted: i=1; AL+hErH7tekXeyXggMauC6Cf1FcM9AiBhUf3uh6kp/cbQcT6KjNo3m/63XlC6+uncteRjeT1Za1CocHd9A==@vger.kernel.org
X-Gm-Message-State: APuU4Z+kU/pCNnmhLP4YwEw8NE7UVV08fygBpA+ijVzKCCMYgUMpKjnM
	/0465H1/kYDwYYneCYCQNmjfSYbugPbE/LRk5GSzJ45L1FUV2N7BFC1i5abXqD+xjEgG9w==
X-Gm-Gg: AYBFou2B+G8CGD2RbsHCU+2EPXu2qVuVvjbK7kEsLbs56WZeW3GI49kqTNjzHOSD+S+
	7UZnL1xfH0HRR363gHqr99bpILNGQ3snWbZLZWCOzk2vsSOvm6lRXSHIADS9KeIRnN6zNE7mvfj
	6BFbYJmU3dbx1DHnTcP+VJeEKyGyqowdL84FWRzGVNYNdvNbzmFXxAwpFgE6arb6l/S1/e6Q6dX
	LxeNkB84pJkt3LCmmtsYe7T5+iZBbeAGgpRvM/0e0gG7oelHrzrGLsbjQzZ9NgGCgdkOpDRh2KN
	1F2nn57EJfMBHxKIR3fGu3YVrRPXmI//8KO4F3LIYTyn2ZuUoEmZNnVj2HmrV9H4+jvCsfePyBk
	t9E3fJ0Arb5v6zkaREUSaKVGs9xTxtTlI9foT/SR9Dd3lh/mtMaB9ep+hAVn47S8zIu1DGWbSip
	NJYthSG5JA8YnV4xbX8eDQOD1fFa86ZEMnvr3uN+0l7YKQlgu2CXExD/+6iUEQDZgLhx44PA4Wv
	Czl7XjEwee9NxjwZStai7cRXCmthaRc2fPlHrbB0cmWAFqd0lJme1VkAmomb9krJ8JHzUF+HEzF
	KRohDwTSxDy2tlZrgBsE9gjD/CQ0NqlQEPWTH28ppyPIY+uPPvXXcpZI06FEDQAdF3GcGTl894B
	i6c8WgAS0tAE3WdGYVyNS9nwq3jshobpiSltYQQ==
X-Received: by 2002:a05:701b:230b:b0:1b5:10cf:c458 with SMTP id a92af1059eb24-1b510cff4a1mr939693c88.23.1794608267442;
        Fri, 13 Nov 2026 14:17:47 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50313d8f5sm16886713c88.3.2026.11.13.14.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 14:17:47 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] power: supply: qcom_battmgr: return charge threshold write errors
Date: Fri, 13 Nov 2026 22:17:32 +0000
Message-ID: <20261113221732.97506-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Both charge threshold setters return success even when
qcom_battmgr_set_charge_control() fails. If the PMIC GLINK transport
returns an error or the firmware does not reply in time, the sysfs write
still reports that it consumed the input while the cached thresholds
retain their previous values.

Return the request status from both setters so userspace can detect the
failed write.

Fixes: cc3e883a0625 ("power: supply: qcom_battmgr: Add charge control support")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/power/supply/qcom_battmgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 636d6f6acecc..f14d731e0283 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -704,7 +704,7 @@ static int qcom_battmgr_set_charge_start_threshold(struct qcom_battmgr *battmgr,
 		battmgr->info.charge_ctrl_end = target_soc;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int qcom_battmgr_set_charge_end_threshold(struct qcom_battmgr *battmgr, int end_soc)
@@ -725,7 +725,7 @@ static int qcom_battmgr_set_charge_end_threshold(struct qcom_battmgr *battmgr, i
 		battmgr->info.charge_ctrl_end = end_soc;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int qcom_battmgr_charge_control_thresholds_init(struct qcom_battmgr *battmgr)

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
