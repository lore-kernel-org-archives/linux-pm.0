Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3163630AF
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781207991; cv=none; b=e9MRiIMvs/pQIAJY8WnO7D4B69Udhav0qK88xbxfunDnGvz/Fl+pwI0UHJIvFgM3aZ1+dumcLWJafyoO53lbe4SkUawxU7zEjKU2t7YayQFuwJeHfhny8iOyPhxLXmDWPokGivHVJ8N1DmBK9crtSHKbCBtC4RmvQq88ZWUgvLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781207991; c=relaxed/simple;
	bh=wW5o6kueGuvhvd3UD/Kt00baGDipOnRqddqrZDFczSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gSvI/3na5A/zssOA6HJrtnlgZ0oGI0v0ivcLq9zh3SIEVDh3AZkjZH+YADHCMc1SUVKYALZfLIN7xZZJkvGI2uVH+GwT7TL+WIGrJt4WrsJjYQ6qgHVn/IT+vAehOQ357azA6ZDrJ6xLZK5GA9Dg+uzIO9lVwWQY6T5mOOzSAzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ohmUNezi; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ohmUNezi"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8424b6792efso159912b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 12:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781207989; x=1781812789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jkOw1xSn/8fTeRN4svessHYNswGeWQKgGSfT5tn/SA=;
        b=ohmUNeziMyB4j/a1BVtnVU68pXQdSCe7y0M6LfsTitAp0GiTPwrOOrl98rbHisGWdk
         2rskG0daykoKhDFsj588S95WM/wGE7UfYxHiso8w6grrCKDDUTdlt4a/CoqrEeHWwFZE
         KfxZflzuFJEO+etqx9QDE5pHEyefatUPg4Wp2DhmQ1kJsve595sUDF6YwyzAAESECFaK
         ZrIPf4+waEdfLOc69noo3hpmrloRoXXzAs8k/p16WVqFxo+xzCgG9rDTcQ4w6KbAWkhd
         Oigb9gFA9k2cRb6CIoTUba3/OcZxxOt9CSyVxZdpaqapqPwzz/pSrl5JMvGqlwXFqz6m
         K7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781207989; x=1781812789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3jkOw1xSn/8fTeRN4svessHYNswGeWQKgGSfT5tn/SA=;
        b=s9bFIzD60umohKLqV4Lu2ndU4ZnFTv5Lu31GUZr66wYWn10BOqko6MzSpXu/1OZsrK
         V9xxPvMUnA5UBq22cEYbuArqr2Os2CYCVcPBrcmAAKIEVuI8m3gMmXmZdwq5yk+T9geH
         w3lGWxboIibbMXrXHXra7tM7mWJ0l5VsYtT4tbgHeTNaC6QYrBuP+pQrF466ZKoYdWuM
         rZniwcXyjOWYOYJWVJvHiUhoEaGgePAnsirZxSPCVHES9din9oL2dD+LfJrCHS7Gp6MY
         HsqC6+OqWQnkhXJUO9ibuql7Ex9uOqnAfbb1raavtxOlLNqmAhQLXtQ9JUr7cEJVcUdS
         9gWw==
X-Forwarded-Encrypted: i=1; AFNElJ863h5/Kkq+11jfCvhIXH3ZCuR2HGIp9JveqViE+9l7rB0j4rVH7ULLjeE29qa8sUIQ3aGeAlvMgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJYgZ9yNflIu9z/reLbW1NCOM0ntftBauZpSDK9X+f1FbefJaa
	woS7AN3cRMG1OkRd24t87/lnryjod0STx9OLgiJDv99a2M1kPoUnkTWbwIVQ2OcqOrY=
X-Gm-Gg: Acq92OFeSDN6V8eaLcf+eZWvatXs33MeEHJu0wo8XhnsrWJHXM9ZYXS7QdooF42gIGk
	uv0UWSs2veAActFRRMnpfQ3UrAgNTOeFYi6FUCZTq7OUiDehLKDd7i/5EHrbc512uFew1ACC4z2
	BMjy1KI7BQm/RbWdHQzOn9gu+biUDftteiuSwTxG6h9OK5OIvT0P/ydRzvWbeUE6G9m+QST4Eb5
	glhbc5CO0/yjObNnITtrUoKFQ5iM9do6+OKSnjKDlUL/itjbPRvmU4Eb5jVBgynlOGex7gAkP3c
	uzdB07vvXSb94kCzgyU3O5Pusr1M0zZxZvy4LZosHNlAd3iYnFCVIxOYJxzW9sMN+C/Fy9t5UQ2
	D3ZWHtDQPH2VUUd7ueiWgmzmkxgaABhHGIrXfgw/6GVIIQVKW2M8AynI7B/PImvmW7BIiTWnuWX
	IMmqocmL2P4l8zfhQcDSg9
X-Received: by 2002:a05:6a00:2355:b0:842:678a:a7dc with SMTP id d2e1a72fcca58-843367c7f43mr4662482b3a.2.1781207988524;
        Thu, 11 Jun 2026 12:59:48 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-84337bb6ccasm2925711b3a.16.2026.06.11.12.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 12:59:48 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Thu, 11 Jun 2026 12:59:38 -0700
Subject: [PATCH v3 2/4] PM / QoS: add lockless read for flags
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-topic-lpm-pmdomain-device-constraints-v3-2-75d69438518b@baylibre.com>
References: <20260611-topic-lpm-pmdomain-device-constraints-v3-0-75d69438518b@baylibre.com>
In-Reply-To: <20260611-topic-lpm-pmdomain-device-constraints-v3-0-75d69438518b@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>
Cc: Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1401; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=wW5o6kueGuvhvd3UD/Kt00baGDipOnRqddqrZDFczSc=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBqKxOxTdU2oD6gXzE5TIjHzK0WJp2Y0irGO8n+C
 PbRP94fJyaJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaisTsQAKCRBZNxia0/vG
 Zd+7D/9YFQE7PNh1QpL/O/mA3Hs7Zxac7AlMAwna74cHgZgWW8I8TvNgOs3VFjN5fP4npCDUdTp
 cWgzuiqfyjzj6EF0IftPEaZQwt+D0Neb4CC8AGqQGxLZ0ehvCheImRWuM7oHPVQF73UUACecG+c
 LZqbKLSrzpLE+5f5P/LhUz7NPlI+GL9AloVFnyZ5mYzSztoIv9eAr7nxPzaTJTxxkBNhPVmcUGH
 V715CTayIx4VAE1UmFHnXc1rAgKMA2kevNeX7TLGqmlXd5UIEopsZEIyi6MDxTC2mk/IPub+pzk
 K7fRV0u/LSpLPuKxWGmah4H74Lo8P55z2tS+vsgOwhsk9NiKXcXtY2tM07LJLjCxNMNFakrBh/q
 zoFbxm+QKIGRtjFhgN9aMguzlT6MA75rCPcvVNOpsvCX4kCZnjbOyvBKGXwhTJHF/vgXJSGxJf+
 Cr8OI4AmtJBrt/U5tfZtT1xiK8ma+f9CwbQFteo/sSUb6LIlNTftgpLrCc/US6iXNoPYriyYRVU
 NHlBVcfixacb2o6dcImCUs+iAwLxipEe3d7duC8TxtDNnaAF4R9tDrM2Oi8TgG5hYoHfmo4fBd1
 0D/PsCnRplNJywIJKBlFJYRpu7PqlSSYJswuzPZbD8O8fray1DKHrMb2pz5iBNhxMoOIzzIc9uO
 DQNb3A6uVHtTIgQ==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

Add a lockless read for QoS flags similar to the lockless read for
resume latency (dev_pm_qos_raw_resume_latency) which may be called
from atomic context (e.g. genpd governors running under a raw spinlock
or in the syscore suspend path), where taking that sleeping lock would
be invalid on PREEMPT_RT.

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 include/linux/pm_qos.h | 7 +++++++
 1 file changed, 7 insertions(+)

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

-- 
2.47.3

