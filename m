Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687348;
	b=A0nNjuQLRZbdLJy3FsHnSzGkJ5wSYwHu+eVH+D7le9bqr83njaOI94/P/MgThy1xCfaE
	 g7kF+uiQlnL1TuIXiX0Ji/7Axv5Et92kx0ifPPVl1avKLgPx3t26Cam8xQBh1uZIP05AA
	 RIxquhvhpm+7I+zBnXaq45Dsw0WaS1Q/iTWSImCkKh7uIFzRI3VicGs0jJlJ7W5/uhvIy
	 XMpQNE3SBSp86rH3VGKh+ou9cMXs6buLJHRUVIyUwIb0KaZYT9gRAa5Zx77otR1ZLKPf9
	 k8pS5qxxKN65pdEhI22O1+LrqN8Trs76o5mDYVajvoBzjJkm4cOtg2x4NfP0sm8ZKBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zblh9RJVoqtDhwxOvvPdwA42GF2EgXCszh/ysjfgfTI=;
	b=M2LwZHnEDtN28kogRZ1si/wKmvbuvsE7V82YgVqcbMnQYiQg3Pp3YbfMHy0mrS35EOTt
	 bguUHFwUDgCsd5eRpV8NihgH9rIH+QeBYk5ZTbCCOAd84fod9W/YAWc2Ccf2Sg47Ocksu
	 NayKziZlPkcnrBJlrr85NpKyWKPGDw7sfTohlkp1lRaotivXnJkzreB48zC/me/gd/W/C
	 8RQk3rpokvQhIRnAxGD/0WaYhvUNkJDd8ChHxQA6Ud/YXjBm0U8N/DVEdzynYQLaO8uoX
	 f5DUHmOq1XK12iEyuk7G5q0G44lpYD4+oZUQK3objYJePHEQuYq2jyYtfNjJKkpFRoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HVUIURyu;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1AF606A31D
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 16:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F1AF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HVUIURyu
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-487049569b6so4004f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 09:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792687346; x=1793292146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zblh9RJVoqtDhwxOvvPdwA42GF2EgXCszh/ysjfgfTI=;
        b=HVUIURyu90T8GjQn2XXazP7dCqrkiXuYpUxCekjY7600wY09bAmNd4mE46R5Ssogk2
         CFN6+ZBuNhKlfANZH2F9nzhjn71dnyQbdos+w+SU0yfZwElm7P9o1S4gULAkrdjPI7UL
         XTodH5b6q94BoS+3Y98uhDdz7YVJrYmsHiJ7kyb3HN4vfUH8UeiU7tByzCLzy+8ADjRp
         3NZcDrkHTPmVWg7034QG1bqxqVpommIF7hvUmnY9VCBWIPRHvdgdY/cpWD7fMImCMFud
         MnRjBah85GPQEsKA2fKzvsJ9rDigodkvJHh/PImruCVzjkKI9SmsGI1C2TuEdOd/q7oS
         x9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687346; x=1793292146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zblh9RJVoqtDhwxOvvPdwA42GF2EgXCszh/ysjfgfTI=;
        b=WVvShK0IEAAgX40cqpHt3VYIV7W9sDXTTzhgwXoFRY7r7PabxaMU6XuzfwBW0O4fUD
         dsoPvQcrYVpBEf5de+OJonpc4E9T+ELSU5gN4vkf6QvOu8HuCKAA6GZO8GdoBxqKKXnG
         6BqWCkOVaRXGcXGz5/q7KcXqDxtTZGEQOCfzfGLSbAypaeYou0jpFFEV/NqZuiPsqph9
         fwBLAivPly3vHnwYcVlZgJ1SsuWEMt8TcyHaGxDNVzIq/b5z1pCspwSqsm9Eac2TPuWs
         0L2JMeN6Cv0CocTsxyU6tK3sl0BOLK3mvLITZYNir8LuF6f9sBoRZT6966oU8o0WzESA
         3pkw==
X-Forwarded-Encrypted: i=1; AKwUvByWyqa22OVXC5ULDIR99+b2NNmLkAygBJ9gzBb9we6LGMuNV24QwzpeVpfdCj4Cv0y7fbjx3gWt0Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYJoi1Od3oOsmGpneNL/7YY0xjKMTOvIhRXLLnWhePMSjkzzcfl9
	EPDdTixL9vJxM0qmfYASTJYy9J2VQzNftEdOR0whAscyvE5EgPz5naOE
X-Gm-Gg: AYBFou2XjZHSv7RA2U1u0XJhObDZQbHiNMDOvq3ZL45BEDWFweti7nR/lCsUobe1kJC
	EPWA/NhnWLQ/lBODKN8MWUxGVXCFqky/UWLmqb1T49l8QxjI5YUBIakqjajvsU6S94uTmIGky9+
	BEOwlLRNPCFykBGjrs/7XnTzC05/oP72D5J7vPursHTazXoV8Nn6k4rOJUZAvjvABhX1P9ChXV3
	hk7inNs3QpqdcyZwxIGWmtgSz8kHFcJUoluPag6FpwQ4EsLyNhKLdvtSP5YTtO5m7M4PQ5E7QLb
	6JndrV3il5T441vzqiv6kml8IY63zo2My6cQDv4RzMFVFKibb1RrdHQb/PjVKHg+fuiqDlzCDLf
	wnjOKP+pD9iboJESeaZNkgPgJoxH+SI+Aoa/kf5p2zg7CGJzzyEVZXY2D1ES465vthfvtKg3UZf
	XbEH6eSTv7XnjTC/AZ4CC5hv+0aJTbAJINngdXIocihhH9KIn4FgaIawp95/FN3APcdWb0OdPDK
	DtiS9lYb5M2KEV9scPwzRq34YkGLGDM3th32FpL1tMTXy7EXU8dVZWaxMy1WAU2JIELSE7fy8oq
	BFFaP/ZIqXwvJT7zAnDHNPn9Cqs=
X-Received: by 2002:adf:fc4a:0:b0:48d:fbee:3dec with SMTP id ffacd0b85a97d-48e264c8742mr9406786f8f.29.1792687346264;
        Thu, 22 Oct 2026 09:42:26 -0700 (PDT)
Received: from localhost.localdomain ([188.190.249.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2584c3b0sm15040175f8f.57.2026.10.22.09.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:42:26 -0700 (PDT)
From: Vladyslav Tymoshchuk <tvlad744@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Casey Connolly <casey.connolly@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
	Joonhoe Kim <26rote@gmail.com>,
	Daniel J Blueman <daniel@quora.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladyslav Tymoshchuk <tvlad744@gmail.com>
Subject: [RFC PATCH 3/4] usb: typec: ucsi: glink: Wake up the system on connector changes
Date: Thu, 22 Oct 2026 19:41:50 +0300
Message-ID: <20261022164151.592-4-tvlad744@gmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261022164151.592-1-tvlad744@gmail.com>
References: <20261022164151.592-1-tvlad744@gmail.com>
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

The UCSI notifications from PMIC GLINK report connector changes, a USB
cable being plugged in or out for one, and the completion of UCSI
commands. Enable wakeup on the device, so that pmic_glink reports them
as wakeup events: a cable change brings the system out of
suspend-to-idle and aborts a suspend in progress.

The completion of a command arrives only while the command is in
flight, so it can wake up the system only when a suspend has started
in the middle of one.

The same was proposed in [1], with the wakeup event reported from the
callback. pmic_glink reports it now, also for the notifications that
it holds back over system sleep.

Link: https://lore.kernel.org/all/20260722-ucsi_glink_wakeup-v2-1-b43dee56df24@oss.qualcomm.com/ [1]
Signed-off-by: Vladyslav Tymoshchuk <tvlad744@gmail.com>
---
I used an AI assistant (Claude) for the analysis and to draft this
patch and its description; I reviewed the result. The testing is
described in the cover letter.

 drivers/usb/typec/ucsi/ucsi_glink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 1db0c88d817e..b03320f5a6bb 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
+#include <linux/pm_wakeup.h>
 #include <linux/property.h>
 #include <linux/soc/qcom/pdr.h>
 #include <linux/usb/typec_mux.h>
@@ -455,6 +456,11 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 		ucsi->port_orientation[port] = desc;
 	}
 
+	/* pmic_glink reports the notifications as wakeup events */
+	ret = devm_device_init_wakeup(dev);
+	if (ret)
+		return ret;
+
 	ucsi->client = devm_pmic_glink_client_alloc(dev, PMIC_GLINK_OWNER_USBC,
 						    pmic_glink_ucsi_callback,
 						    pmic_glink_ucsi_pdr_notify,
-- 
2.43.0

