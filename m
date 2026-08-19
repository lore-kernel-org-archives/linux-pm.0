Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CAA3C10BD
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159334; cv=none; b=Qjr331zi04LMNUTmEuj63i4TzKS/EZ35eZt2KVr8yNNPLfeay/mInYpxJyCxHnAvzDaMSnYrV20XCSUamI0MVD5XWvtmuulmygSzQb5Ppe4ZitrOx1TXH1/qvRe0ddS9nQ1szsZpg3nubQHktd5TjldCoiOwttvxYGIyxzWh8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159334; c=relaxed/simple;
	bh=kT7l6yKHSWNEo0ZyKLhkRiOg4K1P7BnLKxXKfx2FbSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aYz4R0LQQzseHzfhL8DmKbcjiJN+LGO0PF9ATMs+zY96AvufSXRAA53AXX9qoHfh8ykBhg9lwHCxBv+JUfC8eATCzLNoQlySRBKG4phijyiZNdFDguFpDrrwc0ZDBomOSTJ+8zgGsj66OMd1ageM5Y5FJRfUN+k+ctNkefTAvAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=gAmintRX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="gAmintRX"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ceb096e675so15294995ad.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 10:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787159332; x=1787764132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dqx7qHH4kG1tVW6pyBEk7S9H/Q9y6a6UvLPHEGfP68U=;
        b=gAmintRX+Ji3FdJuVS47zLg5BkW3IdS+0TEvMpuwLauxHXq5Kg11OW4+pYKJf+m5fE
         RaFvFRcEy86+P0fJrP2UCYEkeQqgz3RdHNEoPzJ9D5KUrvPshOARO8mfr2ad6ZD4LJY9
         BcnQ3kY+zpF4O0thW+YPSzmTtIyegNP94OqUAg/YJx/feluwFBe6kp7qy2Uz7aVMcaGz
         zXTkSzV423f9Tkgfy402fSNSU5y9ghkzGs++sjvCXeMchifQpzkYu/npugwO1VErBtqD
         X5H7FWxR+HlYIyxuTd+JmdQwR/KJMJxzItbm4O8RThosGTSobIv0AJt30NBWAJKYdQxc
         ek+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787159332; x=1787764132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dqx7qHH4kG1tVW6pyBEk7S9H/Q9y6a6UvLPHEGfP68U=;
        b=CuejPfnAPpkyjoII26ijxixnGIBKenxiKrgvfSCya9SLfap/p+y3dLg15WoX0pDBEI
         2cSmpyLMIBhljjUbE5eCj8pLmvNWtZLA5iTIRRggk/yE+z120LgfJVilIbkEL4E51w3Q
         nkwCWYVjGjdLf3lZwS4bjnArbzXfHSF9cHABr4b6mrbjCZyJD8XY+URDQueyhdYubty8
         8u5tiU4DzCuT8YAgMQdmahhQ8ZoeGWfHr1Jv+ZGFU7b56iM+xh62HVt1A6i2uKebW3gw
         IOMp7HRWEuuOqoq8HTwjHYDFZy4ZxrFZ5mGQPIDLFfBCHC1aKgKAOT1WfG/XpsHt0r3g
         h36A==
X-Forwarded-Encrypted: i=1; AHgh+RpSTz5NN3wJVJiUEJr1UjlqR3sZDGRFmK9zdw/1SVKHNYJeP//zC7azEI3RbJkKyFIZZ3BShHxkVg==@vger.kernel.org
X-Gm-Message-State: AFuF++nvBg5KqJUrCbY9tV/Ti4Nnlnl0b0NlcIyJMWB1oUrLSrCereHG
	aq6DcLPWhrMX5ibD7ZQJw77CFOfP2dbZlsCXvG4n19fNlPDbKjmz59mX6E1aA5Le77Ka9dq0dPA
	yyQ22Y3Q=
X-Gm-Gg: AR+sD10pUovfhnpHW68IwOi089ftqZcM1CP46fG+TWsevS88YGhVAe4ivNZXQV5Ojt3
	vAabY7FQfmML/wEL0sOQELT7i6GPvpzi+FF0x4SDbH32tlmChCVSAc0jmn8H1yDev/8+CAorqPP
	M+St8vziKxVw5ffrUyJf148e1rbw7p5FUUwNk4qYt7q/WN/UlbZpLdXe6UeIIXHz0F/8gPE1y9s
	CCYi6kkHbP9ekGfJFjhb3m8TIkt7Gb/qxt4mwJ5g61PALo+GZ60LiOyEc3FIQQ800pthARGmAZw
	TaZ+6Q+JP0sl7on2WR/sC4IqtCyaQrCHn8TjStIs+xg1Oj69mb1k+PrRPbjoNIrXWH9w4EkK/ja
	CZES2IRUOq4LKYXOQ/pNCQ9siG9/SHPx/wYrYLYKYTESdTULr8bn1e9oVzoWKTs2XqtwNbvNwGR
	hrmPkuw3Xj7Oo5kTd7i/wgDw2faqow6R2Tv1tX2MtcAPWNRPOZcWODMtOJNw==
X-Received: by 2002:a17:90b:3945:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-39580eafaa7mr12425713a91.6.1787159332037;
        Wed, 19 Aug 2026 10:08:52 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3957fb17eb5sm3927600a91.3.2026.08.19.10.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:08:51 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Wed, 19 Aug 2026 10:08:37 -0700
Subject: [PATCH v4 2/4] PM / QoS: add lockless read for flags
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-topic-lpm-pmdomain-device-constraints-v4-2-7ceb095f5474@baylibre.com>
References: <20260819-topic-lpm-pmdomain-device-constraints-v4-0-7ceb095f5474@baylibre.com>
In-Reply-To: <20260819-topic-lpm-pmdomain-device-constraints-v4-0-7ceb095f5474@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2402; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=kT7l6yKHSWNEo0ZyKLhkRiOg4K1P7BnLKxXKfx2FbSM=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBqheMgeG+05eHPHI3TOsaj5d/rdj85QjgWlBIgh
 /uFGPdvYTGJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaoXjIAAKCRBZNxia0/vG
 Zcr2D/9wbVGbTCW9gHU2mhy6WgNfPOEdSuM6H8rJnHyALn5PSl421NM7pQMVcQNwYECX8o+lMSR
 uIIMuP3g5jGpZ2X+gWpnkYNVrUW08u9KdvZNPiu0LTQ9EilCP2+EIZ8jaamPspUPLwUm3cmvB3r
 rQxR7ebfkvVhwJ64f5cBcEt8zI4XPHctGv3wOn8PXmNKGbElGB7D0fQSRROPWI55hYK7czPIL2z
 5tGDjgOauzE7k1zosGJjbbPKR0WB5oSp1Qz4uNh0x1SE+PsFie9o+GrzMvX8xYiSB4T3llTAWam
 IohRBRwNghMXAS65qWcLNAALARR+g9UbYzSGacKNfgCz7KYvkNfpz+NDZEZm6hpjcp9WsNHSA70
 KcTqBIUeveDxu4alkiQ4+VI+qNJ5PHlb7Df5jKQVAck+xZ5qVkmN2wcNXnBQ5YSqQHKI7HSLQzT
 AVZHxyP4zx/lDGbyMzboAoomfrFjK53OtkQ65106vcqyNONM6MkSATVK24v++TPVSNOgtLjxe4w
 rkuWM3jwyNKMdazCbM98xL/oyPNRaYWxsb97/Jl2X9lSReXXBspXXyvtgIpVq+6Mbw1KQGsZPiy
 mdxU5YLCjMCoLQzeJ3UJPGb+BggUzTjgnq5dnRMYYPWdcbrDS5sRErxgRH3xl8p4xd944EFwH4W
 /+lxIZPyq+dmtBQ==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

Add a lockless read for QoS flags similar to the lockless read for
resume latency (dev_pm_qos_raw_resume_latency) which may be called
from atomic context (e.g. genpd governors running under a raw spinlock
or in the syscore suspend path), where taking that sleeping lock would
be invalid on PREEMPT_RT.

dev_pm_qos_raw_flags() now reads dev->power.qos->flags.effective_flags
with READ_ONCE() so also add corresponding WRITE_ONCE() to the two
effective_flags writes, the same way pm_qos_set_value() already does
for target_value/pm_qos_read_value().

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 include/linux/pm_qos.h | 7 +++++++
 kernel/power/qos.c     | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index aededda52b6b..439a9e779d81 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -219,6 +219,12 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
 		PM_QOS_RESUME_LATENCY_NO_CONSTRAINT :
 		pm_qos_read_value(&dev->power.qos->resume_latency);
 }
+
+static inline s32 dev_pm_qos_raw_flags(struct device *dev)
+{
+	return IS_ERR_OR_NULL(dev->power.qos) ?
+		0 : READ_ONCE(dev->power.qos->flags.effective_flags);
+}
 #else
 static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
 							  s32 mask)
@@ -300,6 +306,7 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
 {
 	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 }
+static inline s32 dev_pm_qos_raw_flags(struct device *dev) { return 0; }
 #endif
 
 static inline int freq_qos_request_active(struct freq_qos_request *req)
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 1944dbeb0d4c..c241da5bccf6 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -159,7 +159,7 @@ static void pm_qos_flags_remove_req(struct pm_qos_flags *pqf,
 	list_for_each_entry(req, &pqf->list, node)
 		val |= req->flags;
 
-	pqf->effective_flags = val;
+	WRITE_ONCE(pqf->effective_flags, val);
 }
 
 /**
@@ -193,7 +193,7 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 		req->flags = val;
 		INIT_LIST_HEAD(&req->node);
 		list_add_tail(&req->node, &pqf->list);
-		pqf->effective_flags |= val;
+		WRITE_ONCE(pqf->effective_flags, pqf->effective_flags | val);
 		break;
 	default:
 		/* no action */

-- 
2.47.3

