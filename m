Received: from mail-oi2-f0.google.com (mail-oi2-f0.google.com [74.125.231.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0CE344D8C
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 03:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219740; cv=none; b=Yh9hWdZOTaLJZRtp8dFT983AS7gv242MrA0KddaWjrNnDFyWOH0kkAMfKxacvW66N5mcWt7rigA34W9YfKq3KE5RfLF281B7yffFAAiykAqz3oPMJd+U2DW4JkOG5eSSlfPTVkVg7xxoiVb5/qOWj8CpwTKPubUEsxENLUWihJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219740; c=relaxed/simple;
	bh=SFCDsL+KLosjLiTfRG/h9sWFqTjT5EdHrRCiuR0pch8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jAvxe7sh2bC2E3X2OUtig28XGu+VpEZoIAldaTd6RAgAaFDOYs39W954Wlf07klsWOSlgI45Oku6etzQXeQjA2rp7IQAyWVhPKDTIxH9iKZ2fg5120okxi0Xf3ks8S8ry8NgRy5v5GmLmAmFhnZzkpXiJePWBNicqqKtuLbJkV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUkoZbLz; arc=none smtp.client-ip=74.125.231.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUkoZbLz"
Received: by mail-oi2-f0.google.com with SMTP id 5614622812f47-4a49b13b745so656755b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 20:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219738; x=1790824538; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v6SgjFofGfUKX1jxaWBbw3Uq6YYLhDmkU5+NgvCiQuE=;
        b=OUkoZbLzguI+ibZYbGRe+gQvQGRs6ace60kOaJ+bJXVsl4zhlOQ1SalqTRHGKd+r/W
         wCvbjKgrtnogwY9JHrbhM1QBkaBmLa1z3ojHYuLfX/MyCLRZVZdtL3OQIrXnBqwq+vmO
         zjsW/hhy8ZmSjbF8Jk240g1DOce7k/vRuTGFrziP6gEDBpccBFez9P7yth6+BWwiBgMb
         HXWzMXUyEEKQ0dTGXM00VQQ8fS9hHO1X4NAKb88+vzpXAx1hDTiaUhtY7J4u5pcJtnKF
         JstYNTM0mME9GNiXMspYEamae2UTVLpAmC+tDTOORCe009WRTNORm6I3babW1LqgBKyi
         /MBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219738; x=1790824538;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=v6SgjFofGfUKX1jxaWBbw3Uq6YYLhDmkU5+NgvCiQuE=;
        b=YTW4lOXZc3whladdrWq64p+QkzEDyp2Z99Psu1zWCLQ63YhmV2cI7Q2Wo5TkVeSz4N
         0vP9MUpBCUgGn3yAmJIoq93O5c4l0uRfTqwqOEWwFjWbx4ejoRDC3/nytugUef0msBqr
         9OGPYdszTf71zlPQXpcsjSNMwD9JVpPUHSdqimJeqRUDF0KDYSdckxRwOI0bqmciteCO
         5H2oXhQU0xrJlN/YZMA6kXP/GofA4vJuv2ODPEkteAFKi6Bh8SwZ8UnIAIjMex/rigqO
         qW9mF5R6yB+PaMR9hMkK+Kl7e5kbqbjD0P92YGC+LjXZWqpI8O/LCXh9KkkmIWw35dd9
         X+uQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+9tAzGXOU3pTKSVRYR+lUClLdQOl1zc7eRIll70WF6TdwiXZy4GSlm/YlWYMhuvafOx2bLot7oQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lOrOYW5450jf+Z4zAycOIHnOZLDQ9o4aozk58VZ2+HbppORs9s
	hDItKySXgtQLbZINqElieB4ehms2H8pPvzxgxi16wE4SdELhrZFQXjia
X-Gm-Gg: AYBFou2Yg3jEmpd/CaGKtMABnHR2HOOWkWheYix47iNR/8vKvaL+9h9131zejSUxa84
	6j/hvQfCoXzAys1QyNF0RETSTNbTt0RTi773bedML1+L6CfOlTYFPfnPxo+8KslKg2WSnprcS7M
	ydcrVhu3tW/vl+qEaM9CSIwtOP1VrWs9xoGtsgQZepycLoPOAcbOKur/1HZ8HeECfYDsBwKKmZT
	FyXjIlT5cQ5pLDY9W8JfNLkAUFB1+CpDmsn9U7oh8aBh5ixO3+1EQc66ncmbT7+IikkmiuVz/hF
	7Tk4r44sB5t1/9gQd8qhm4TQe+Kz9914NvN0auTtFoSf1JbmYCStYWNmtpCY7S4P+ZKTgDmvlNT
	W/cwND+D0eIoj+77WoMYD47PR88a0eabUxuy5MRBV2ZzRFK7Ygss1fHBW6ErEmLEs4D/EVRkpUI
	51XgLt57vv1LDoCYX/SS4rEOqKD1O2GVP6xXVg6n4Wy3TbzoaUHqFzppbSN1IvnhZGHw==
X-Received: by 2002:a05:6808:4f60:b0:4d6:9222:9a1c with SMTP id 5614622812f47-4d730d691bdmr1241821b6e.55.1790219737822;
        Wed, 23 Sep 2026 20:15:37 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::2620])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d5c1b305b8sm3946699b6e.1.2026.09.23.20.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:15:36 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 23 Sep 2026 22:15:35 -0500
Subject: [PATCH v2] dt-bindings: power: supply: battery: allow 101
 ocv-capacity points
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-rbrue-suez-upstreaming-battery-ocv-table-128-v2-1-b827406d768d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XNQQ6CMBCF4auYrh1DWyPUlfcwLFqYQhOgZFoak
 XB3K4kHcPm/xfs2FpAcBnY/bYwwueD8lEOcT6zp9dQhuDY3E4W4FYqXQIYWhLDgG5Y5REI9uqk
 Do2NEWsE3CaI2AwIXFSijK2mV5NIYli9nQuteB/esc/cuRE/roSf+XX9Q9R+UOHCw17JEKxXao
 n10o3bDpfEjq/d9/wCjfcFK6AAAAA==
X-Change-ID: 20260917-rbrue-suez-upstreaming-battery-ocv-table-128-9ba83f9313bb
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Henrik Grimler <henrik.grimler@axis.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790219736; l=2094;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=SFCDsL+KLosjLiTfRG/h9sWFqTjT5EdHrRCiuR0pch8=;
 b=qyZ09NfBzrkLduWXKawj7lI0MD0dd8kSQgR5MeZrQxDQrJIqkbmKcf/HJ6ymP/WdEtA9hQeTF
 eR30FVrIn2QDPzZNIt17mC+HJeNZPp0j2CnchW+loJkUh92R1xFpTLv
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

ocv-capacity-table-N is capped at 100 points, while the capacity percent
in each point may be anything from 0 to 100. A table with a point for
every percent, both ends included, needs 101 and does not fit. Raise the
cap to 101.

power_supply_get_battery_info() sizes each table from the property, so
no kernel change is needed.

Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
As discussed with Henrik on v1: rather than a larger cap for one vendor's
tables, which fit in 100 points once resampled, allow the one extra point
that a table at every percent from 0 to 100 needs, and say so in the
binding.
---
Changes in v2:
- Raise the cap to 101 instead of 128, with a comment saying why (Henrik)
- Drop the justification from the vendor's tables; the figures in v1
  were for a different cell, and resampled tables fit in 100 points
- Rebase on v7.3-rc4
- Link to v1: https://patch.msgid.link/20260918-rbrue-suez-upstreaming-battery-ocv-table-128-v1-1-f477ef39ef0d@gmail.com
---
 Documentation/devicetree/bindings/power/supply/battery.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/Documentation/devicetree/bindings/power/supply/battery.yaml
index 8ebf05d9497c..9575ee1491bb 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
@@ -154,7 +154,8 @@ patternProperties:
       of the battery and corresponding battery capacity percent, which is used
       to look up battery capacity according to current OCV value. And the open
       circuit voltage unit is microvolt.
-    maxItems: 100
+    # One point for each capacity percent from 0 to 100
+    maxItems: 101
     items:
       items:
         - description: open circuit voltage (OCV) in microvolts

---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260917-rbrue-suez-upstreaming-battery-ocv-table-128-9ba83f9313bb

Best regards,
--  
Ryan Brue <ryanbrue.dev@gmail.com>

