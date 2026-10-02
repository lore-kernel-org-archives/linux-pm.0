Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005812165EA
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942585; cv=none; b=Jpt2MHKdymXJppBEFbQ8QS7ER6BqBII7I1ba14gJVJ+NFoRqi9UaZvXwMUFTO7/E7Kj97nDR00gm05t88ldh6L72vjjMtlQlliFxMkn3fj/LmKWIO72YdtWtoaJz/9+17PIOdk58+EmjTEtNy+QWetS0ovwa1qDhv+A3uE8ODto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942585; c=relaxed/simple;
	bh=E3bFiL7YI5UMcoOM0utDxMNg5sAh4VkSM2tXjlG6tK0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j0NOfdNkBI8sxxOyJPCJjEQX3fbrEWTEFz9VSTCMXUHn8kF9QcTJY4JKbi9R1oBEZ08hOzQCz/MnWkHUAd52BE/pIbWzeJ+UBkZ88RbfJu26ZeM6ygFnsXczNqNEsXz9hj577RwZWyr/kPJGm6MbmHqliQGfpQhnpPRBQ73TpFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=QsGbilie; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="QsGbilie"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so51305785e9.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 05:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790942582; x=1791547382; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IYtYYZuAQMFfttbDXhmpcbK3WXYMY+yBwZAMhK11zKA=;
        b=QsGbilieinsXZfyBUxi5BdqBz7EmekQaLI3KaCJb7FSjxl1YTq8hdVc10by+i+NTaX
         cuYiryx2lFOXUhClKtVZdEfRg4WHknzXNlzNvdg7BlLjCzkuDqiiTr5jD1wbD23q9IPB
         q4oD8rtpODewsM2Wm5GQ6xp5Q/99ZbUJyz/NvBazOBGkXP3U6pbq5AL3Ylq4xeXIbceq
         OM0bS3F/Pv0J2OoNFhXGFoaUaV64VO/bnsNnBg8Bo3db6KhpAM59KQYvGQ4+L7qf+TeA
         tq2of+NGYuOcM47sBB6FZIv2rJPeCe53LI9Ld6NSKPX+JTyP75VaTqqmJ799P4wNVuQn
         v5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790942582; x=1791547382;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IYtYYZuAQMFfttbDXhmpcbK3WXYMY+yBwZAMhK11zKA=;
        b=MqGNXpKelLvwrwJ12GHHytJB1184BGCdTeOK6jSIunIKN9rL9tm5q9PtR4e1z0QLQe
         qWNbLqD9Zw65INcFzfSdgl01ifU+wwIFrgSEjpuMHwJfJWMfLt7puojTTHcFSGzWwyNy
         NQego6nGroE9NzcX+rlbM+DPRWnJ854qBxhdVPlBmH5uJb/9dRXUyp3eg/WaRNljQ0XB
         9rTbrRoKri4XKqVweVmmHArhf0jTA4NEh7jsgA7cb18Qm2z1F5UrOZ5CYQii3eGvEcw3
         XJ9BmUQHbpccorsI9/Ux1nN4GObwOCOQqUVY9WIRlh+j76ZdsGBfZmmIsM54QH+Ne8Y8
         dbjw==
X-Gm-Message-State: AFq9FYKvBUDGBfBdH5UVTO7cBPJgzYnbXh9RPs+cgFL5FY+evJc8KXWi
	J6HSGw86hthAm1zC2Xi+6L1NA/TsghalDnto7InrHaIjgaOluzWrO49Yx7GkvrxwZE0=
X-Gm-Gg: AYBFou1ibZ4HqRFI0TJ18FzoqGNi8cdHgSszjK3JVieQrf7egG9rJ6IE1B/ZeVxZ7nR
	I0f0OmHfxymuU+qUJYB0hbOjcI9PJfG1+j+bI0QT9I28zqyASBiL8h5dxQjfXlkGIikAmB92p8c
	cuJVBsWXL232w3K8wymo/xaudKb1catEmJQX7suiB+NsTsFINID00fcpXzdTtRDRr8XB6v8/W/b
	4vvzUYubct2qYosgl9xaG9GEvDsn4VAJU1hBsxV59z9PVzkCGc/epZhyWWZIdV7U3x/GTFd+YTt
	pQ7BEdllutyNq7DYi9kXUTVWBxiMNhytvmJaYxbzcPNQbTnFtiHi25W2DA5N5XkifFZfB+JvBN2
	yMuL7x/ipbe7hmfLKMGQjDaWus09LiBv/ighVaOG0I2n2fe+Hk0ZLbH5uOOfISKHNJy0wQM/24T
	NNyhBuj/Ic1od0gaVnp1ITdHPflfJXjg2dVGdokmgLnDR6ZitBXnz2lMhmfay4gnElktJ62Vg56
	YBRyrEE23k6HM8t
X-Received: by 2002:a05:6000:25c3:b0:48b:722:1c6d with SMTP id ffacd0b85a97d-48c440e1b11mr1660612f8f.38.1790942582097;
        Fri, 02 Oct 2026 05:03:02 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380f0613sm5845213f8f.13.2026.10.02.05.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:03:01 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 0/2] power: supply: bq27xxx: Add TI BQ28Z620 battery gauge
Date: Fri, 02 Oct 2026 16:02:53 +0400
Message-Id: <20261002-bq28z620-v1-0-bdcc10d42519@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwMj3aRCI4sqMyMDXVNjEzOLJHMzc4MkMyWg8oKi1LTMCrBR0bEQfnF
 pUlZqcglIv1JtLQArnrFLbAAAAA==
X-Change-ID: 20261002-bq28z620-53468b7670b6
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 "Andrew F. Davis" <afd@ti.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=alchark@flipper.net;
 h=from:subject:message-id; bh=E3bFiL7YI5UMcoOM0utDxMNg5sAh4VkSM2tXjlG6tK0=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTtn1uUbfn02o70kxbxwtE/jkxZfDObs71avHxG37dPz
 NfurPm9rmMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICpnmrD8Iv5316HNxV+C2z/texTtNGfy8+7bN/s7eyfrmdKasrFh9kzMmzd9Xi
 qxpnN29bru5975fivac7tG3dW6G4IE9tz4sq2x8YsAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Add BQ28Z620, which is very similar to the already supported BQ28Z610 but
drops some registers and shifts the data flash layout as a result. This
means they are not strictly compatible, even though the existing Linux
driver for BQ28Z610 can drive the BQ28Z620 with no changes, due to it only
implementing the (unchanged) standard command set.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Alexey Charkov (2):
      dt-bindings: power: supply: bq27xxx: add BQ28Z620
      power: supply: bq27xxx: add support for BQ28Z620

 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 2 ++
 drivers/power/supply/bq27xxx_battery.c                      | 6 ++++++
 drivers/power/supply/bq27xxx_battery_i2c.c                  | 2 ++
 include/linux/power/bq27xxx_battery.h                       | 1 +
 4 files changed, 11 insertions(+)
---
base-commit: 9f24d789f03b22941b905ded43cb5ff8eea9ce62
change-id: 20261002-bq28z620-53468b7670b6

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

