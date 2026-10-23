Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792776739;
	b=ucWXuJBCajvBKuNqJ1hfPXsSACihrcfBnH0pIEkO29GwEIXDmAGSY/JhMeGZVPt6xxjJ
	 fkGfuyw5HskQ388L1koLPr8UEp5axzVvEAl8MK2eNGVs+0iB16lXk6BH0SWkWcLM9YZ8C
	 zBAlAytTlwBETgP/9mvg0Cu/DHerW2QIUypthg0i2ZGP3EcFQe8B17GllVEGrTnLs9kgC
	 1GlsEie6IJBNYNo2golJr2fLc+NgoIeMeX6dd3bIfs0dS7tUWMA/MOWQUL5GN7cUJrwWo
	 +I6y2KWYTjLTNfcP/WIOz9Lltxy71nP+kTSWBKCrU8SsAioN5CokdNKJFKl1raus1wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792776739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2r1x0Dt7yoigexj1LN19Sk2tBE9eYyGPD9hXhp2NAA0=;
	b=orgOFjlGk8udMBXEBZ/y1iwGL9bvDN35G/PdrqLC+ro8X/+EK90YTVFwKBsQOTRE9ZKd
	 xO3mJX/bkBTIko0239irynxWtw8Q0rbihJJIPxchOA+yij/yRgpQnxlOnOYa+so/v+K+G
	 7dvASlZ4GustDWBShe9+WLfU5EpFdjBHjFSqqs/v8TD8sEhgefdF7Q7Kd39tOdCfwC+Ue
	 vALVlOJMWdHALnqe6rxxiVzG+Hq/uQK31wOZCU7JBJMazkB2+Nkt5xcsTucSgFBlVbMc/
	 /2SIUUxIwQqlEa7FyhnBNgwyhlY6p667HVGFxOUZR6qHcwsRqopoNIqpX/4iGzhW7GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PwZ+s2Tb;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C7606A326
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 17:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F00C7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PwZ+s2Tb
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so7388315e9.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 10:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792776736; x=1793381536; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2r1x0Dt7yoigexj1LN19Sk2tBE9eYyGPD9hXhp2NAA0=;
        b=PwZ+s2TbTyIPznOIqdpFwhuFG5Fy19HEa90OazWCvH+cPmycOtmyfWL+SqKTK/HQwQ
         wk2BXXxN+F0tq4OYymMclyAcq88/ZOr5JzCheM7u2rVQTKzcb4ID/ee58qKyN4sqjwHD
         Ugx54IAVQxOGsb1r8AklKuNmySnRUmhwZXpvbPSBLANvjA8V8Cugq7Yy+gjidYZ9ItrX
         zGnEnOp3NisHiCmk15ABB2eYOeiLWJulMU7h3jR79Z2C/SG9+DfFHFxzBUXPkR9WOgNq
         66kwfjKjyW3N0l7YynCUrEhDsESBWh/BvLmU8kwOspfvVX9y0XCJbhtR/wcAcfsvDWHn
         xiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792776736; x=1793381536;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2r1x0Dt7yoigexj1LN19Sk2tBE9eYyGPD9hXhp2NAA0=;
        b=Wjly2XdkeZ9O5yclsfX6QZO9B2z1ZVWWOtF/mnbEbGiO9mI6pArsfJZU+NsST5TFVr
         uWG8lGQNKK4Z5Igj4sm7BNcm/JXHAaxPeFquOSWX2Kk0UCrZ2QAorKTcKaD/X5zns4+u
         aO+SlDiR+RVEOQe3Kghqfcx8EjrlYwAk/EHkd5aW+BHsSmp2K7p2Z54i+5tdY2dMGyGv
         kkbv4wkrNHokEgH2/QW9jnjBoC3tC8P8+XobLK8DvTsu4wKucXAPqcITMXOHobehA7wK
         Ng/oIlitYMR9ljCWkYZwxCpC3jO+Q8TywgliXStTffyzdmDUEMdRvegvXVVhi6+5I1pU
         3wbA==
X-Gm-Message-State: AFq9FYI7AM4pOVNsV06ZsqPM/dASLpO6NcGMKBh8STB94f0WF8mUjsUE
	HPTspU9phMo6i+44bInm5cB1fDvnCCqn+/o7WXjV/vr+zpfnYGcdBtNB
X-Gm-Gg: AYBFou2Zovg5X0WZxAPZNVbF2B0T1RvCsyUpRcwFSzLDOXyVa5/glbQUY2SYPWBiz7N
	xfwNnw61EiYFdb15jiYaVLOYnGy/sQL+WKmJlt4ehtwoXkNt4VxPI6ddfKbXod843LcC94MTYWE
	GA0A6PSM/YFxf6zOPlLpwdZZe6hd0UREe1K2toXuYyjfDxAdYJxmHoC3c6uZrvURWCifAYOUZky
	j8RbDPbJdlOrD2Dkh89EKMDeMKPrmOC5W0JdekIVAhpwik7mxeTU75EwYwpLPzaRiLsBsvovL8k
	D1lgDMql6MnA/CMIulsjSvGYXQfCRxsTR9h1Gmrpp5CDLqkw1TboLr/3Q0jy834J+mHJKlhwwxe
	SgH9cbThSAB6EtMcWf0wbKCLu6dDALWCVCU+JUwmUCgYocTxXs91DfPMVv/v4TUt/5ad0bpJly1
	nKUalk7HkpMrwYlCaeD3D9WO99moYtEGe+5JaxihGxZ/qgrFQCkDPuHbri6U+KlwjDgx7+YsNJy
	nGA/6LHz0Qb89Rkic9GVEjK2dRolg9iymETndyadWb+G5730BzCYzH4Erh4K2CT/s8Gg6Qt8RI+
	ZOqO3z2tTBPrTMb7scgI07/viu6Pqo8zrp3HZt+CgSdUq2b0rr78zLW5Q1t60bYlCrKG
X-Received: by 2002:a05:600c:1390:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a211ee53d8mr50695125e9.33.1792776736231;
        Fri, 23 Oct 2026 10:32:16 -0700 (PDT)
Received: from hermes-agent.lan (228.red-80-29-82.staticip.rima-tde.net. [80.29.82.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a312fc7012sm12475755e9.5.2026.10.23.10.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:32:16 -0700 (PDT)
From: =?UTF-8?q?Ram=C3=B3n=20Jes=C3=BAs=20Miranda?= <ramonjesusmiranda@gmail.com>
To: Maximilian Luz <luzmaximilian@gmail.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ram=C3=B3n=20Jes=C3=BAs=20Miranda?= <ramonjesusmiranda@gmail.com>
Subject: [PATCH] power: supply: surface_battery: handle battery event 0x1a
Date: Fri, 23 Oct 2026 17:32:15 +0000
Message-ID: <20261023173215.6233-1-ramonjesusmiranda@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On the Microsoft Surface Pro 11 (Snapdragon X Elite / X1E80100), the
Surface Aggregator Module (SAM) emits battery target category (0x02) event
CID 0x1a alongside standard battery status notifications. Because CID 0x1a
is currently unhandled in spwr_battery_event(), surface_battery logs:

  surface_battery: unhandled battery event (cid = 0x1a)

Add SAM_EVENT_CID_BAT_0x1A (0x1a) and trigger a battery status recheck via
spwr_battery_recheck_full(), matching the existing battery state events.

Assisted-by: Antigravity:gemini-2.5-pro
Signed-off-by: Ramón Jesús Miranda <ramonjesusmiranda@gmail.com>
---
 drivers/power/supply/surface_battery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/supply/surface_battery.c
index c759add..a3fa899 100644
--- a/drivers/power/supply/surface_battery.c
+++ b/drivers/power/supply/surface_battery.c
@@ -26,6 +26,7 @@ enum sam_event_cid_bat {
 	SAM_EVENT_CID_BAT_BST         = 0x16,
 	SAM_EVENT_CID_BAT_ADP         = 0x17,
 	SAM_EVENT_CID_BAT_PROT        = 0x18,
+	SAM_EVENT_CID_BAT_0x1A        = 0x1a,
 	SAM_EVENT_CID_BAT_DPTF        = 0x53,
 };
 
@@ -368,6 +369,7 @@ static u32 spwr_notify_bat(struct ssam_event_notifier *nf, const struct ssam_eve
 		break;
 
 	case SAM_EVENT_CID_BAT_PROT:
+	case SAM_EVENT_CID_BAT_0x1A:
 		/*
 		 * TODO: Implement support for battery protection status change
 		 *       event.
-- 
2.56.0

