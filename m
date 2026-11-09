Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217316;
	b=0vgKDcjzwPc0JFUIEd31fBzbYGnQxYpt8ysS1w5x7skLzqIDP/FOqXpGex4QQRHYdytk
	 ZN5WscIBQl8dlwnh7yWLMFhOeBaItcquezselUhBhmT527/rwtpPRT6YeCCotZbPKJvg6
	 3yuLIxds9EDwBw+MgY/DVXH3M8IhuE4Qcve2NOr60D/kjfh0XhdZkqiU42RrKTGZHUfQM
	 PjWMlH8zbiaE5I7H1EQ1wSEhV5d4vRnZnBnh5JbwAAaT0nbOXe5WvjUbrD0uHxjp/L6ls
	 xeaB8sviaqPnuHBVBTU2iLTMBJml5pWPOPHmiA3Rj6akO6LBEh2Iz0xFi8k4IEiW13w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=OxNDojNk4xU4HyXcTA0bs35MHLi3QbYkHxDUvC4/Ink=;
	b=NYkEAy018Gr1gwUtpaZbXlQ+GjENsbayurUjKzv9bSpw6VKn4sWXm8Kx2WXCC8F7RN1H
	 WxKcTwXYsu6tVP0yaveBMn5qUtLoP5n9x9uT+BW+ZMaoJlRPbf4iO8BEpBd/lsedjhQvK
	 OLeFszkqDPZ2lmRkOonILNmWxk8RCuIBFuZxkwhIJ4OQe3NIfI8sfhw9maPfCiTNSAKVp
	 qfMgY1Xcrl1GK7eDv97DI6XaMAkNVvw2CQyj7H5uPS5f/x2oRGreokm9b6PYlX/YgR4iu
	 +DGje4oHbrR81+t3EbxyZ+TCMpytrVSRfuS9kTppQk1viAVVawNiuFTdHbRD1yISL7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=23oAPPjV;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F841606A31C
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 09:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F841606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=23oAPPjV
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-490f38e9688so502064f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 01:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794217314; x=1794822114; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OxNDojNk4xU4HyXcTA0bs35MHLi3QbYkHxDUvC4/Ink=;
        b=23oAPPjVuoyJSsO6zIw9EtgP7YPqi78BBG2FKZBW5WVw95R8MCQ7Vo9HrJkkKGz91+
         4ZpDawTEpE8LE8RhIffrlBr3LRTai/ndQ3YU489ImxInXWjIaitfD60i+qb2iT6fFwt5
         egEi6IemEF8Gr2WxG5z499SZ1s3dkeDWYtU+/qW6FibUwYZc+dRDRH1v1FU5Q5e03LgB
         rm/ycVY+em2qzVbRZB8fk1QkcBOBCbzoxif0PS/uh1BnrEQFZg5izhTgAlVulpSrfhol
         n0qpy6YNCPbHZYmAU29OUWLup1cwBCnZHXjEqUNeToQbY1azt2883uopiTv/qMX1OaTQ
         hxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794217314; x=1794822114;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OxNDojNk4xU4HyXcTA0bs35MHLi3QbYkHxDUvC4/Ink=;
        b=JTNEN/jkxKnFrJA7NTN1+cEOkS7ORNQF2xQRUvFSeUSP2FsOptUow+aB9tej21QXqB
         p3vOd6EICHUnGTQ6v16zQUpok0SlXVvb7OKcbkfoZA43XBfEVRcWPZY4/FXtFjK8tTIz
         zFV/Zq5/jCWOQhAq+vjm5h/q8k3Rn3JD4MfGOQGBlSDasMmldcKOoTv/LVh2RCSm+ekd
         8IqNZMaSHKLDOaznLylTvkVezs3DYCgEoW2JPCe0yw4usY5uKKeaOMJo6BYY2OVyj2Q2
         V63fsKZ9Pgv4Vr3TY+kUdm4Phnk4HkUR7HWWA+TkcjGNKhXfXQvyC6AMNAf5RYfiBJyi
         4vIw==
X-Gm-Message-State: APuU4Z8jasezVPPoCIKnfduWRBOYSKi7yHMd+J5QxfWKty8+JYQdWuWy
	oy0AvMhGZEwIsngIh/ZC4hnrDa3JGbKmmZb91M96mUf1DIlYSUPA4xnuxGoXXzmm6Bs=
X-Gm-Gg: AYBFou13kJwuq1NRhlC0P4NhvFU5Jev5BHtXrNusv4NbgOyXLHFczTdtzSVAA8Wvzkt
	gIEFzQ+hpMwASKW11V6LxrWtJ0kuPHKGLOnAaBWCbDI+px/DF/dLiLWEftVmQ2Pu/mRi8AUKjBM
	rm61jpzd/HhjIXgQDSJ3aa0lrSzCgmqpZvr1K2SndPhSNvFZJIcIFQKQEJlzHGSz1DAifKhcumN
	nraCH0vt0r4ljZcH4ch7TFdVnrucKJOEEBclYL5U5giqrw4snpg2aJNS01qiiHgWhK4DslA0GJz
	x7HmAlCIMd7fi+mT/GKGFlyE4LpYZM+sn1NTlxjmGeMINjtG4T7pNHWdfvUH65vjlKqlVYRpuxw
	sJoP+2qTfRgmF/RtcaXVxga++tqrTBhM2unZyNDdFZ8zQol5q4ZFc/vV1iKSuyXQ/2HLT/lwUXU
	Xwr5IGj4ELY+hKMdzsKAK7Cfyd4oJFxBBaAz4z0OMevAhY6VTRzGtqWIE8pW45IiPjrmLz/guF2
	Xgk5luGqYIKHqQ6Aj/6WfjBH4SZSTL+dxprcMusgbwAtWzC3bYMDTDxAwYypNS+PWurkMID11bX
	REyFAaGI8iAwyjo7lHJdT4wuzZ8dm8BPWYTaBXbb6FW0p51H7QVcevP9/zdTeUqNwzl5JLwCSZF
	L/oI7Xp1P
X-Received: by 2002:a05:6000:26c8:b0:48f:bbb5:61c2 with SMTP id ffacd0b85a97d-4958852d3b8mr7998933f8f.4.1794217313738;
        Mon, 09 Nov 2026 01:41:53 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-496150c6e90sm7278409f8f.2.2026.11.09.01.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:41:53 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 0/3] power: supply: battery: Allow separate charging limits
 vs. discharging
Date: Mon, 09 Nov 2026 13:41:47 +0400
Message-Id: <20261109-battery-charge-temp-range-v1-0-a967abd8b80c@flipper.net>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0Q6CMBAEf4XcM00oRYn+CvGhlEWPRCTXSiCEf
 +fEx8nszkYRwoh0zzYSzBz5MyrYPKPw8uMThjtlKovyam1xM61PCbIataI24T0ZOYeu7sOl6io
 470j/k6Dn5Ww3jz/HbzsgpF+Q9v0AQllllH0AAAA=
X-Change-ID: 20261109-battery-charge-temp-range-37fc54d4e3a3
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; i=alchark@flipper.net;
 h=from:subject:message-id; bh=+odnf1TlzZclfLwdtnwN+ooYti1FGicx+mmm5eDR3iI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9nBrfpsZzxLjaVyC47kzHj5OLZBo+2d8zemZWUB3zb
 PkB24nbOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZhqdTNGhusuU2+Zfn3Z/YS3ZtH139My3ltUZgZfv7fmxO+8Hclt9QaMDBM+TWn
 P3Vl4xv5whvveTU+yfH4GTlHLeFH+caH8/+f9b3kA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Some batteries specify different operating temperature ranges when
charging vs. when discharging, e.g. charge at 0C to 45C, but discharge
at up to -20C to 60C. Current DT bindings and power supply core don't
allow that, so extend them with additional properties so that a separate
limit could be programmed for when a charger should cut voltage going into
the battery vs. when the system itself should shut down.

Additionally, allow the DT to specify voltage/current limits to be applied
when the battery is being charged in the "alert" band (either high or low
temperature, which often requires derating especially at the low end).

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Alexey Charkov (3):
      dt-bindings: power: supply: battery: Add a charging temperature range
      power: supply: core: Read the charging temperature range and alert settings
      power: supply: samsung-sdi-battery: Set the charging temperature range

 .../devicetree/bindings/power/supply/battery.yaml  | 45 +++++++++++++++++++++-
 drivers/power/supply/power_supply_core.c           | 16 ++++++++
 drivers/power/supply/samsung-sdi-battery.c         | 12 ++++++
 include/linux/power_supply.h                       | 16 ++++++--
 4 files changed, 83 insertions(+), 6 deletions(-)
---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261109-battery-charge-temp-range-37fc54d4e3a3

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

