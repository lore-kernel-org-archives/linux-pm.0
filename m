Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792690359;
	b=VXKzZc70QUzO/9fYQwjMH8jgwbW/SFdh2P4Tdnev2pq0C667V9ZqyGwznPjuGAioCUC0
	 qcyMV1uzPPNjWFOEu7Dfk5zvCZnqcqxtJmxQvoHcyFrUFhwUblkbPTx2fRtk07Rl4/OR1
	 BHHDAqkvr7bLqby/tN1BgI9ejABpfE1yTDCf1mqDdlZrZU+JXmyi+6j6kPSx7uKISoOuF
	 JFaOPN3YGY9h9+uPnMnGllDLA9wukX+FNdjQbpruH/DN1OOMqEbkRSs7AvexQikLS00xu
	 T+VrJtro5R90As0OBBsZnoeVbeYZp9D2+KiUbQXBdvxu/mq1APHvi6rUdlWYsPF2UUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792690359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5TTK5L3C72RVXuyCfPoL1KiCUuBlYM9fSsQ+OoWqJh0=;
	b=CxI81j4BEyhJFocvlYCkG5hwucSR+04pb6JVZsC5YUSIa+4+onLOJ4fyN0hE5mYdl7oT
	 3AiIMLUBu7H3+iCwO7MBhf8K0TMGHkvQsJSO8ttjk9E0v7eCW/rZwuXcN7IoknAqOPHB9
	 8g7dffrfrAl6u+4l+Kfk4NWkjh63AWUqtM5u71b0SZ8GIojcxSy90iSBwge1zs4Sjg3WL
	 pEn2UDLuMs5JDyJyZNt4uUA5EWKQPTqLVEP+G1xocFf6NADfdXyxdP58ToPp59NQjS+kW
	 vtkcjG7G0cqUMcyGUGaqPGYfgpeyYGvxT3wLMow3DgGgHgrb3JmU0FEqz8zbGfZH9aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eeCmVCgM;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7744606A31D
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 17:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7744606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eeCmVCgM
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1fe9efc0eso279095e9.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 10:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792690357; x=1793295157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5TTK5L3C72RVXuyCfPoL1KiCUuBlYM9fSsQ+OoWqJh0=;
        b=eeCmVCgMegRCMD7vOlGg+I+VL7pQWFbhxv3PU5KxF6XDa0o7ajmM/7XY1L43p9HS5+
         itOL5APh7mnHzuXNFok96uju1BIDvogoYxKs+LNEoP0KzZqKpZB2h4aJiZfAoVBC9rXI
         OXBa64Ghjhyr3+zpRWSioZQBJ0F4UnFDPvOW8xL1I0c88FZETbuvhll6WKwGvxuDYd/q
         NjLKXl/YgtmD82fvvGg/sJb4Rb4nlhHaEawHymhU3n5L5dc4+7NXPF/gaQzxtJS1htSz
         38lzO8YmLXH2ksX3fpjcSb2gD+VyGT3rVqk4P5zdk3C8pUXkvGTDCmhsvkyUpHkOLD95
         0LGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792690357; x=1793295157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5TTK5L3C72RVXuyCfPoL1KiCUuBlYM9fSsQ+OoWqJh0=;
        b=RqCd8aMUV2opZDK/snekr3nWptRMOricng+E9TjFaJG1Yv8BK4vAUSlJ4+xYG/bCwq
         lu1zCHF1jVu4AfBkz0C6skdrCiWghrZDGUSU5Okb5BKf8VNEdRfSztPErYtExVEUPk9J
         qVS0tRqmhixheK9Rg2TpLBinXqsBJZM1mhTG9lwpvJwlzgHGO37y6odpP20NmukdvzB4
         Q4bLEe7lHU64Zwhx+ixBBMDKVUI+6tOJowWNKoOpOU+7G3oU8lwwtwiIqTeaWuq6/vZQ
         RnS/of6UOaIU+ImZmykUdH30KX1RhLIxRm3WyKgiHi5v0jxIKfGJKIHWf4vGrW9n5rdP
         svKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxUO6PHhd5tekRdeIr+tYDSCcpUBS5jyUE+UeULBdhaMjDcml4OrO48WmZzNdIQ/OHKoIYiMnvs6Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYLUb3vr0hIJYR4Byc0/C0l2BLw9ieuMATLx4MPSIqDyKoHtsA0D
	Wuowl9nQJhAH2LdNT5Ivx2NtHS9xkCFeUKLpAqn2NLh4p6EpIOjxrfAcPmkH0dA3YCc=
X-Gm-Gg: AYBFou3A/qwUhE+il2u7exvJVoYpcAwEQB7/MvZOpwbXeS2/eDVGDwe1zX8FqDznK9t
	c6O3weebyWHCzaIWI9yciVpOlx++0x6dV5Zehx5d+mfe8NqOaAcy+69Fk4ykGdePZUVxLbYMkhu
	yw8yA/X4Kj4/CAOdlkJLdY7DcnKVbDYUjoI7aNlJIPGzwh6NvOHnSsahyAVFSpcaYy8osxCb9w+
	A8O0UGvOAbb5SGdxY2V8ghtkgD4ssK/DOUS3dW0/SKNj/E8vNGeecob7aATrfjJDHdKz8B9/viY
	Q8Xdg5oD2XE/C76eS2Zfc4HOJiSv3qvQYeb5FcqNJKYy2IDghJveypTJQOHbyel+7RWro8RtL9S
	4Equw8MthFqLkwaM8vv5sqP6sPBn3BOHpGvbZypIjOy4l07poXXdlDd3dK+3+0indhlYilwRbuO
	ymSBIyuGs2HxuzjOvDI6tSVxjtGwuf3Sc29W3DgHbW28XGCioXZWoHZYGnNK3u9XSwrn5IDejjL
	oGBPcp4Qf6b1Y+r8j+/Z6U7UeFIDUsTm84xKAOjxk+gMr+tIMcL4E0Ucew5xLRUg0h9I5kt/X+U
	SJTi0ls=
X-Received: by 2002:a05:600c:8b78:b0:4a2:cbe:bebc with SMTP id 5b1f17b1804b1-4a20cbec0d1mr26844975e9.23.1792690357003;
        Thu, 22 Oct 2026 10:32:37 -0700 (PDT)
Received: from localhost.localdomain ([188.190.249.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581f0d4sm13857279f8f.13.2026.10.22.10.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 10:32:36 -0700 (PDT)
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
Subject: [RFC PATCH 4/4] power: supply: qcom_battmgr: Allow charger changes to wake up the system
Date: Thu, 22 Oct 2026 20:32:24 +0300
Message-ID: <20261022173225.58-1-tvlad744@gmail.com>
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

The battery manager notifies about changes of the battery state, many
of which arrive while the system is asleep, and about changes of the
USB and wireless charger properties, a charger being plugged in or out
for one. Only the latter can be worth a wakeup, to show the new
charging state for example.

Make the device wakeup capable, and set a wakeup filter that lets
pmic_glink report only the charger notifications as wakeup events.
Leave wakeup disabled, so that nothing changes by default: whether a
charger change should wake up the system is up to user space, through
power/wakeup.

Signed-off-by: Vladyslav Tymoshchuk <tvlad744@gmail.com>
---
I used an AI assistant (Claude) for the analysis and to draft this
patch and its description; I reviewed the result. The testing is
described in the cover letter.

 drivers/power/supply/qcom_battmgr.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 636d6f6acecc..7a783a3a320d 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -10,6 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/of_device.h>
+#include <linux/pm_wakeup.h>
 #include <linux/power_supply.h>
 #include <linux/property.h>
 #include <linux/soc/qcom/pdr.h>
@@ -1596,6 +1597,20 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 	complete(&battmgr->ack);
 }
 
+static bool qcom_battmgr_is_charger_notification(const void *data, size_t len, void *priv)
+{
+	const struct qcom_battmgr_message *msg = data;
+	unsigned int notification;
+
+	if (le32_to_cpu(msg->hdr.opcode) != BATTMGR_NOTIFICATION ||
+	    len != sizeof(msg->hdr) + sizeof(msg->notification))
+		return false;
+
+	notification = le32_to_cpu(msg->notification) & 0xff;
+
+	return notification == NOTIF_USB_PROPERTY || notification == NOTIF_WLS_PROPERTY;
+}
+
 static void qcom_battmgr_callback(const void *data, size_t len, void *priv)
 {
 	const struct pmic_glink_hdr *hdr = data;
@@ -1750,6 +1765,10 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	if (IS_ERR(battmgr->client))
 		return PTR_ERR(battmgr->client);
 
+	device_set_wakeup_capable(dev, true);
+	pmic_glink_client_set_wakeup_filter(battmgr->client,
+					    qcom_battmgr_is_charger_notification);
+
 	pmic_glink_client_register(battmgr->client);
 
 	return 0;
-- 
2.43.0

