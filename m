Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956164;
	b=KKVm+e671FzXgOhwKMEOd2De7CRsBFPd5qvK+/WvB8KIBlgplPSzmApw6pOn7lrv7y1i
	 QutAVheIF7/cEUJQp+TVww5gmniDpyQHfPoN0NV0dvQUuS0oXsRaXjOZLL9YA8/XqKZng
	 axO8BjLsHIdy0oDAJuj6YBxKzn0/qNN5h1UGn7wqmnx2XNrdB7cXh+gTokIVUSwbDbaXB
	 fQSNR5la7Eet5QqWHddIHHpTvQdaEiXoJ1zIDzvSZyvRVz3MRoIWoqo0XoB1CYwnpZeYd
	 NB+Zi+8iEUFl/groIylpdqooG6NELNlvjcWIO7je5KT07XrT796G1cJPEnPyq2daJ9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956164;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=67zqypIqeW8ZVZEfVBlJG12FCXsLePvvX660ZE95YLc=;
	b=HNzyVFlADu2DUfwjy6y9gJPu+Omhw8MFGsX753nibX1JxPNqcjq+sLx6Ak+BauVlD1Ft
	 9RwqiRpA+p/BYoa1RBatgBGQxjWhcwcmwaptR+HYYNsy7aR6d9fz0wAjxw3SEplG4amyn
	 PKhJ0wVggesN176pLMSguh6yobuN3bFtTPgY7nVDFpF5jFF0FLacO+jkGREcAD9oAtVBU
	 unaLedqGMTwqSAfrm3iZDoy6O4ZiD5BlhX4Y93Taavu6Nw9yYFRL7LiB4K/w8bwkdjUqz
	 Z/oaxPiwZlVdTgjfiGriSr1JhYWWHNLXQCchmuKpoHaDzUz96GxzZrlexJnytqbHKEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=ITNqoDhO;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F3606A324;
	Sun, 25 Oct 2026 19:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A44F3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=ITNqoDhO
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJMK13517096
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:22:29 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJMK13517096
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956149;
	bh=67zqypIqeW8ZVZEfVBlJG12FCXsLePvvX660ZE95YLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ITNqoDhOUAXftehRFmmWEEKsPEp1AUpYIsRdLzzpVvubibgqbLuLTZs9/q4DrjicR
	 KLCGI5zrd8VOREbmRcQDaiAc2SqsY+gY8nL3zDS3WL/B3D2lkTGQkWawQFmNnzmVBw
	 zsX6rpjfRENOYh824M4G7JeqeYz7YpWAVLuaxSV0=
From: christian.koever-draxl@student.uibk.ac.at
To: neil.armstrong@linaro.org, jbrunet@baylibre.com, sboyd@kernel.org,
        bmasney+clk@redhat.com, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, rafael@kernel.org,
        viresh.kumar@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 3/4] firmware: meson: sm: add the CPU speed bin call
Date: Sun, 25 Oct 2026 20:22:18 +0100
Message-ID: <20261025192219.209137-4-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025192219.209137-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261025192219.209137-1-christian.koever-draxl@student.uibk.ac.at>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: () -13.0 ALL_TRUSTED,RCV_SMTP_AUTH,RCV_SMTP_UIBK,U_H_APTO_LONG,U_RCPTS_11_PLUS
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

Amlogic SoCs are binned at manufacturing time and the bin selects the
CPU voltage curve. On S4 it can only be read through the secure monitor
(SMC 0x82000088, argument: cluster id), which returns the bin index.

Add the command so that a cpufreq driver can pick the right curve.

Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 drivers/firmware/meson/meson_sm.c       | 1 +
 include/linux/firmware/meson/meson_sm.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 5410386603c7..540773887fe5 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -51,6 +51,7 @@ static const struct meson_sm_chip gxbb_chip = {
 		CMD(SM_A1_PWRC_SET,		0x82000093),
 		CMD(SM_A1_PWRC_GET,		0x82000095),
 		CMD(SM_SET_POWEROFF_FLAG,	0x82000042),
+		CMD(SM_GET_CPU_SPEED_BIN,	0x82000088),
 		{ /* sentinel */ },
 	},
 };
diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
index 3f2fa160e32f..9d11832bf638 100644
--- a/include/linux/firmware/meson/meson_sm.h
+++ b/include/linux/firmware/meson/meson_sm.h
@@ -16,6 +16,7 @@ enum {
 	SM_A1_PWRC_SET,
 	SM_A1_PWRC_GET,
 	SM_SET_POWEROFF_FLAG,
+	SM_GET_CPU_SPEED_BIN,
 };
 
 struct meson_sm_firmware;
-- 
2.56.0

