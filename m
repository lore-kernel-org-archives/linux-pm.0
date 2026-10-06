Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A149EC7C
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302582; cv=none; b=EPWvsbyuywr/AXnpu0cC9Jv3yM9tYMXwvDFOawGAGezbCFhdiURYOVWEXwx6JaDafU2FrzTSW6xmDmWAezTLt0+KtKJ+Y7xvtthjwLWRnwUQKERTktb+f56vSxQSrCn8EHyKgtB/wnOUAb/bphrmypcV0TnHWe89Kl3gdwFuwTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302582; c=relaxed/simple;
	bh=Qk5juJXyHQAA0FzltH0EG8o2EdUhAIQpUus6d2gQKFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CnOOhMSx5Xbzo4uU6J0vNhjBjFfaeIMe7zDvagmDbdvwfZqCcBxBPPXw1khBNoQYpBnMjCEA0dPSSaR87EXWgHlDPoEczz7xK2dp4wC7Xiv9wlGBMp3r8eTLFY6MwtKe6OSqsqR49FWkDFbnJMrOJAUzO0vaZnir8vjkuoItb3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=tfPt7BVO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="tfPt7BVO"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4649b3aaso617620f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 09:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1791302579; x=1791907379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lAKGigWSN+rmthZd67UvTxza7+7ujThB0c4R/68QCpQ=;
        b=tfPt7BVOOgUN3dFO5QifMZqX1tWg8CR4dy5RDH4Di2ywAhcPSGQC4Q7FwelDleLUi4
         v5d4HBU+yJrjgieHmT6z6KMvU2ucobZgraBlhJf3RZ/JOTp5uw8TjsuqrCQA1JdJdY8w
         lQbpogvPyrKmas0lh+Uq1QRYwbGPoG2ZQ4xpvl2kq2f3LiQVgcBG/cyCuD2sD5/D4beb
         3QGQ9VbKdqXO+rf1gTe6ogbNir2rxAUkhJyqq66l4EHCygG6EphofGPiOoU6ceFjXG7F
         tuZiKc3pAROvhFuUhvHGFZsjfIftrbkr/vpXtM9jLX7efkRHlteQJPaA+BWJiKFrtpmx
         KtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791302579; x=1791907379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lAKGigWSN+rmthZd67UvTxza7+7ujThB0c4R/68QCpQ=;
        b=BZsDAsQ8anpJWdX8+ImxXuWN1qaVSTMGPmoy15U25zUWhkEXltNq9FZPPo1OqchPaz
         bMVmFICdDb+u/gDF+zd4qdDIrRjO2PM88NYtCiNhBUWJY7jOa4dK7t6Nm/qFYKJgLuJs
         4B7MTHvTkmOf/nz4RZFhzQ15bZQraL6OTCFs9vfChcAmu9haE00nUpfV64H7xrcE47eK
         L43ppp2v7sxX1q00xoArm8JedhAHmVqvTJ9WFTZeYEe9YmUr4bFz5ltxpyylULVLyAPW
         zVfkNmNfiXyKu54CR+YXR9rglTJmgEXq59Wf1WMcCckwX5cPIkXwLXa3meJwL80oq1Ug
         EtHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLXZ47mu1Efv5JsCCV/hcdY3Pel3APoNwdU3zjzNdBWFG7jygahtXFvhb7QtK2yvgNlAcgF6eP7g==@vger.kernel.org
X-Gm-Message-State: AFq9FYIToM9cebVv6Lwk2IZ5wgZp5Iq81WnnxpJMAL8qR+qfWh4tYr7z
	sB46ocMfXw9uWkNlgRiwOyzz6bGVgV8xQtaD5/eP1OvvX6++mEJozW5hZaxuAWX9Rfw=
X-Gm-Gg: AYBFou2Ec7J42wHrAfC4KQZK6tON2+8FsAGzeVnTaeZoS7Kb5BnNd4lEgkkkF8r9Jes
	cuMiZquXNyAuVOiRj/TOtHwXNsUHr/Pcla8PWiGzSHMB9mu0WXD1l8lnUJmEENOu1fOTjVsMQmo
	EXUzW1r6krCUK/uu/YzlqpS6bMqpWOkL8SBbLwnhKK7zquO9gGNUDzD/63QfYtejCqb41XkhX/H
	AHSXmvXVwWLy6n3+ZKaGWwLfwTN4qcdnkixEU+hCZGGxRcPP7lV8G9bQoP9w3sFBeil9Okk0UPk
	E9hLu19y/KJGCINrmlOZSAfqJtt1PEl/DGPnoovVYwQx2e6Fp3kQgY4CNtJplHNJqaQp2H8prlZ
	BUtV5VnrBYvTh42tBBGyc9KX+21Y9B+EbubiRoyD2fB4nePtG1XMQAWwpghz6glXp8EzrmoFvQ9
	F3GL/L7tDLfTaAW/zg92JiPEuPg4ulfsnG7ShVdV9xBF8vC6J+aRMBXg2wRu9RGFTATd9xKu6Bp
	A0+OKOJd148BU6ayw==
X-Received: by 2002:a05:6000:2c04:b0:48c:55c1:fb50 with SMTP id ffacd0b85a97d-48c6d1cbc24mr3125986f8f.40.1791302579018;
        Tue, 06 Oct 2026 09:02:59 -0700 (PDT)
Received: from alchark-surface.localdomain ([193.85.242.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d2014asm369641f8f.38.2026.10.06.09.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 09:02:58 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 06 Oct 2026 20:02:40 +0400
Subject: [PATCH v3 2/5] dt-bindings: power: reset: syscon-reboot-mode:
 allow supplies
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-rk3576-reboot-mode-v3-2-6edba064693b@flipper.net>
References: <20261006-b4-rk3576-reboot-mode-v3-0-6edba064693b@flipper.net>
In-Reply-To: <20261006-b4-rk3576-reboot-mode-v3-0-6edba064693b@flipper.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Alexey Charkov <alchark@flipper.net>, 
 Shawn Lin <shawn.lin@rock-chips.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1488; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Qk5juJXyHQAA0FzltH0EG8o2EdUhAIQpUus6d2gQKFo=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQdlV69416CV0SY0q2a6g3/lvREXw3JaLVe8uyHhWGR7
 GMBx/nRHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEy14HFGhk4V3ggHMe6XpyPkA48GW/nN6T3hbZU8zyvO5D3b5Ip3cQz/QxiLTU0
 r8xh17WrDPwscuvcndcftWYsZL9Slchi2tJ9gBgA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Whatever program that acts on a reboot mode runs before a full OS, so it
may lack the capability to enable the regulators it depends on, and a
reset that preserves the mode register generally leaves the regulators as
the previously running system left them.

Allow a reboot mode node to name such supplies, so that they can be
turned on while the mode is being requested.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 .../devicetree/bindings/power/reset/syscon-reboot-mode.yaml       | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
index 79ffc78b23ea..5ed70c87269e 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
@@ -36,6 +36,14 @@ patternProperties:
   "^mode-.*$":
     maxItems: 1
 
+  "^[a-z0-9]+(-[a-z0-9]+)*-supply$":
+    description:
+      Supply that has to be powered for whatever program acts on the mode.
+      That could be a boot ROM with no access to regulators, and a warm reset
+      leaves them as the previously running system left them and not necessarily
+      what their expected out-of-reboot state is. Any supply described here is
+      enabled when a mode is requested, and stays enabled.
+
 unevaluatedProperties: false
 
 required:

-- 
2.55.0

