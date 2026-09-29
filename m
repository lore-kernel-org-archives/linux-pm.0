Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7C55111AB
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677743; cv=none; b=sZ8rI56xOhtIe+H1MVfXNhKjEF1ZAv4rOscFeBPMl7os4ic+OG53zlc+ArYE6/WsiRy7Sh5wsr0qMcD1AxJ+EMxr2Uqe3ZouHlD/40pCzcDloa5YeEIJeRWBOj1UKTC0WlNQXA+ypJ2cADqExR4vDHXpFjsMpkSKgFKYBHcUr7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677743; c=relaxed/simple;
	bh=QQGLNQvdHfru03RYinWVR9vfNnySQYKGE1jNzOfXc3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y2IKGJ8KQXlcp55sRnX0AUdxgX90hCQmGxB73RAD1P9Wx+uJ085YXYKIyOzRs7/eXZ8n//bj5ek7pEMf/ZeMaReyMtJ352YvU+IanSdjriuGn1WP+NmAf788AfchTYx/VU50+AXUh4R22PZyWfQ2IyF+CY6zwedz/0fJYy/QcWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=va54BRMl; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="va54BRMl"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so21077655e9.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 03:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790677719; x=1791282519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QZTRsHj0KfhwDqKEq7QsxYeKNtzFQI0k4FjiWBg73As=;
        b=va54BRMlUmstMfPhvAkc3qh7l4QbuX9cKewh7ip8Rgy95qOTBtz0mcZmHRfZlBvNLe
         hUd08XSXNhrZGYV1yHUHCeUKS6qO7wWKkmox6xi0bgXBSZtHCydwBxd8sAvX0P97Bg/P
         slwnNB/JiF9aWW1JH6WzrEQsjBHKJ64/ElsM7b8ZA+bTcS4j4H0HEcpm/oPZ+e758Em9
         FZYgN1dssqDeYwgGY83Z46L2e3BSoqiMh9ZqeAn+LlpS78PCQ0K3JuOt+l+M9yyHMUXX
         Q0oUjA+OS8BIHh1J3eydIK1g1viOZNWc2kOXqSzf/iz87WavPxQHW2kvE23bkgZecWzX
         FsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677719; x=1791282519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QZTRsHj0KfhwDqKEq7QsxYeKNtzFQI0k4FjiWBg73As=;
        b=VVOmeozEtUA83JzVW1+s7AE+oWq3o7qbPLBgCGXULVU+u9kQ8SKXxfXnfIgwboPs1Q
         5yuCVD07Yf8c0YY/4z+tHnmyuNADHMfX1pNzBgML5zlUEIwHnZIcUr2NlWhnJzTRdDvK
         hukOFnCvfv/uxqXFFtsG10rcuZPivC3cm/lhuZSuFAG9ZKYZDfYYROeys0qMrRW9MfLx
         jJQROd+V/6VMu9MV0GE3nObs2k3Yj00Py5ryhlgSYvYB1elY82s4DRrEPSo+7kNkebkl
         hFfZ1dfITZ9xZQddj5nigAL6yXeopCUR5XXnR6xEp1LZD0aUskewdJUbUhx208+g3g2L
         LKUg==
X-Forwarded-Encrypted: i=1; AKwUvBx7pfwDusa5ikGumntYZS+gBoLr8sY+vaTAmMppn8CBXhh50fUBMrVmBAxqr3Bfs51CHMq3/SREjg==@vger.kernel.org
X-Gm-Message-State: AFuF++mvGFPuRcWm7J5qPL5IV8QQ6pLZVXmL2WxViBjBFSujm33Grz4G
	drLrCTh6iGkAWxqEK8Me94j1Ya4eBLWUQcmo6Omo0qdp1WjUDQ6UYGbSJ9SPT3OA0bI=
X-Gm-Gg: AYBFou1XvEljZhPkVGmCtMQMKzzQHJMSUiKUlTiFnTNsxkFNn9KHU3YfMYUYSnvB5tJ
	EzOiRf+aWogAthVcFUqLthHXiN+BdnMaNNsvH3UxEgohstCUrNHVR7GUMe4bd2agT+QyOCV8mhi
	v5ZwKOy3y7JBviQamZJxKNbGDKZvU1USh1xUva6QgwesBD/hdJmWNBZC3zEX0oCF7Qeg8/QZ9rM
	3ckFZn14AKQsnUtxBAUOQHF6rSSYPbcTvdgJsEXJuHNQYR5nSi+dxUFleOOGfUZSyNJnqt05dIz
	5KDAvYPGLDbE3V+VTQIKo7Fhs0n94xPbLD8enwmTf6Tr55MRk7mYMuz4Ma7x/secg13qOjW9MRS
	ER5p4DFOp+5u/7SSD/0Lp+aq2BNNByJC0F5uPDwJPVt4ii0PvIHVnM8hfxpAawCHma2sQRY/3md
	OVgf5FbSKvKg1w2nwl8BHRlTLGt5ZmFJ5pAcKbx//kuK3VYdrVGUrwmfqj5ONK7qBI3p8gkaTkV
	Ud6mdAMebMVaM3SUA==
X-Received: by 2002:a05:600c:c16d:b0:49f:cac3:c68a with SMTP id 5b1f17b1804b1-49fe66f9ff1mr251267355e9.31.1790677719072;
        Tue, 29 Sep 2026 03:28:39 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfb479asm66579305e9.15.2026.09.29.03.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:28:38 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 29 Sep 2026 14:28:19 +0400
Subject: [PATCH v2 2/5] dt-bindings: power: reset: syscon-reboot-mode:
 allow supplies
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-rk3576-reboot-mode-v2-2-5a34ca72065a@flipper.net>
References: <20260929-b4-rk3576-reboot-mode-v2-0-5a34ca72065a@flipper.net>
In-Reply-To: <20260929-b4-rk3576-reboot-mode-v2-0-5a34ca72065a@flipper.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Alexey Charkov <alchark@flipper.net>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Shawn Lin <shawn.lin@rock-chips.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1537; i=alchark@flipper.net;
 h=from:subject:message-id; bh=QQGLNQvdHfru03RYinWVR9vfNnySQYKGE1jNzOfXc3U=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTtnnTx1Oz7jZ82Be+vas833B3yclvwKsWj6+zvTJzy7
 ezV75aMGzsmsjCIcTFYiimyzP22xHaqEd+sXR4eX2HmsDKBDJEWaWAAAhYGvtzEvFIjHSM9U21D
 PUMjHWMdIwYuTgGY6p/6DP+UGuJyZT8kqW4WFf796lPHnY0+KwQrdB5kcL7fxqwUEdDE8M/I7Np
 NSdvgt7NEXh1LbsxIXixqctRkZr9Q6hGeo19OCvEBAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Whatever program that acts on a reboot mode runs before a full OS, so it
may lack the capability to enable the regulators it depends on, and a
reset that preserves the mode register generally leaves the regulators as
the previously running system left them.

Allow a reboot mode node to name such supplies, so that they can be
turned on while the mode is being requested.

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
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

