Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202473;
	b=UPZj7hCVjN6zVPnzZ7W4moKqzwRAzHa4QuYZGyfoyDo49LLDBQ14Jgm6ijvnKmEir9X1
	 mJDjN/aWUvhvRwOFIy+8QD+g+Cs1kO2SRAd3cHfzHmLBBjB0zHnnPxS+54cpa5cAdjwi+
	 qjZHII196XC1EQXxc2w6//j7vWJtu6crHO5RQ/P4zZduGe/gAnF3yK2230bReIS3KRUZG
	 aT/Cgg/MPoCiZbDxOUMiBdCAk944Qy6jqAL4776YZtOZwmZ0T5y8n5Xw+31UdX05VEq48
	 zwmTTSXgx8UhrpO31anNFOOQQQAXNeFjpQBZsbiinUR/V4ToOVSwlRuM+cP96Xu8bQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Ba1LZYpNSjXVJ+zOLl8k2Tar0vWRwRjXeVxP97+SFE0=;
	b=tP96J2ciMhVZGPgDs1JunHM9eXxQr+lBE3teJ0dkKICVtkK5N77+d7JSGrVr+Lo/lzsI
	 2QELqlnaOI4aPbTHsPOJvcRuLNsv2P9CtewTYlIxjuqnwjqzI17L26LLnOOyj8HXdUOio
	 ynIo2qi/yAf41k7yYjWMU7YLv+KF8S5nzau49SEGUg7mIqP2XKxpvAgKf5tcpr7oNj/fc
	 OQpNO5oAmckn1aLEw4feL7/wHakQ5LKzpSOanxUD4v4EWoREgL3J8xd4FFczuXnju/o05
	 rG9ETZewYnVc1L8Bhs6X5XFbdul8wsOJxPk7/VnWdLPLSdBrZOJZbXji8aKFviD4big==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iVa9bfr8;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA16B606A6E7
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 19:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA16B606A6E7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iVa9bfr8
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso1128777f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 11:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202466; x=1795807266; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ba1LZYpNSjXVJ+zOLl8k2Tar0vWRwRjXeVxP97+SFE0=;
        b=iVa9bfr8WG30k/MSJdiEdmZdZ4egBy+7f5rc5VMTzKP1F1/pbxM/nmWrWTj4wJEBTd
         tO3ZduowcMfo+P6jvecbjsKTCQS+Lb8ElXNZ36Uj+rvbWT0JvQ/5ItV0ucDe9lm4cJqW
         LITa7FW+S4Va4KD0ngnWVHvWob1H03G4iHy+tzS2UV/Foiwb1YJaYjE2OfQEnRHZtNHn
         OqS6TlHEiRagXYOi/P5Omb/3cCq84Wi/aDSppob7iUYjI6z97kHxCLF/9gWfINuG3Kka
         KdUoevvtkMmJgo0jT6EDaGaUaIg9GL0X4ueAtjoYCA0Wt9oydxWSBM4Pu5+0GfP74zAb
         4ykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202466; x=1795807266;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ba1LZYpNSjXVJ+zOLl8k2Tar0vWRwRjXeVxP97+SFE0=;
        b=dEvU4xxGFj6t9lEA8Z4MM2f6DVwJ5kydQRbtsJe7rwkBmL44YO7NTJedzAIkM3D/DA
         2mHqosq5TyzG5pf8cJLHepUbMej8vm2lWi9xFY6xyQUV+FmTIFIA+8o4+IR/+d3R8ldN
         i547kPdM6MjxL+cp1Y0cPvNkOkEURlUFX49L79rln8gg1/dKJWMP0/2+y6vOGSQP0Aaa
         nHk4Onj6E8NaZbMJzxJd9ZWlcMGfr2a+n1+2+P7Tv5dKnQB9B93jGTPRli3kvL7yc6ai
         qYvQg/wEq+u49gkpBz/0Sb48i4kq4SF39t1vYUZFmrznM+Kpa3n9XTZMa0+f1kBsLfcp
         SPCA==
X-Forwarded-Encrypted: i=1; AL+hErHlZdGH7w4a+RHOfjojDMYNs3CoCgWq8rEvJfevV47RkM/98lLPXJ6z/udtZvLUrnBcY75I+gNMsQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+JysBZnUu5x5FFAR17Fmx2EaKfOS+zljKELKXQ3ClVebN1T+IP
	ZzwHRUTsgCCoB5n8Tkd7yzZ/rvLYNU550EW4GMwqS5QojO5X+hGOmntC
X-Gm-Gg: AZFdTZfxFuB8oZwLXJzhxuvtIFi/TFYyiWMBQhdIwMlVRzZVy6gkkEw6nlCPOJFWX0N
	5Ezh6BxdSOZzFeM+h+NlWsK3GPQzg4rxN92tUX1cKJZG61s5Wf/xZAeHkGAMM98JESAmFwwTl1n
	CQniOWV10a1SUlcQCZPP5P5vezHroP0FQE4g1rzW8RE9CJ1zjyNqBC0IjAZgEU6Sw7oRYhJe2DY
	nAvKmCpCvhVvIdMBGuerx2S/fgptk2NVU88ws2e0Wip5PlStloNPLcF1Gez7kvvOXEl4DHNW+Qr
	RwHiR/UO9jrXnd68qwAGV/7yp/hu1wPQDfBUA5soZempty/lK8qIJ88rN+YzAbpZ9YLWasdN/nL
	RpOKDjU6wbOTOE+kDUhnuE6sB0EtCoC+HAIv3Sk5X0gfl5e+1by5xg9d9Qpi0FL0Gm9cfrUOCK8
	q/anbq6BHC6xZM1XajfpfT8/ImT1S1l7IaNRS3+F2V1W/siFJVzJJMcKuGPvKZh+OtuuUisa/io
	jECxglIbd36hs0g6eDyL6kMxsPXU+0DC5zeHA7V2Gg7nKWJmqKchUJKS6vxyuE//tYAdcVG23og
	cTmfFzjDtD2O6/4D/nHnVA2mmbEuvqtb42v7S/gD
X-Received: by 2002:a05:6000:4541:b0:48c:4658:602b with SMTP id ffacd0b85a97d-4abb400bbf3mr6410831f8f.10.1795202465920;
        Fri, 20 Nov 2026 11:21:05 -0800 (PST)
Received: from [192.168.0.2] ([197.250.160.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm8405703f8f.21.2026.11.20.11.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:21:05 -0800 (PST)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Subject: [PATCH 0/6] ZTE zx297520v3 USB support
Date: Fri, 20 Nov 2026 22:20:49 +0300
Message-Id: <20261120-zx29usb-v1-0-b0433258e51b@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0WOXQ6CMBAGr9Lss036I2B7FcNDW1atCmhbCJFwd
 yuQ+DjJ7Hw7Q8TgMYImMwQcffR9l4EfCLib6a5IfZMZBBMl57yin0moIVrqpFHM2ELJ4gjZfgW
 8+GktneuN42Dv6NLvfDcCvoc8kTbtv6DJ1mente+eDyotq6RVjRBNqUe+blgTkbq+bX3SpMMp0
 f0tBfWyfAEDtdoxzAAAAA==
X-Change-ID: 20261117-zx29usb-c3a90ab59354
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Lee Jones <lee@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Agustin Santiago Isasmendi <isasmendi.agus@gmail.com>, 
 Navid Ghahremani <ghahramani.navid@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-phy@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3961;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=FWQb+bD4+CzUS89QtQFZvvJ9rtMw5c8LSvVgJ2lgW6o=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBrAJ2WLxQfwJwf3UU2/2ZG/baKj8e+AcifMVpgO
 DzUx5mh4amJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCawCdlhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiIY7BAAjh6uYVRLaiV6bbaXmSFHRPt6/PfvQKT
 vnjZ0TnBwX/y9aoG++Jm4tUH+wbRUU8ehmzojZRpUZ7JXcHDq55bO1AyB5pOaH57BIN4gZIebfh
 r3LdzDmBhjlXwe6Jq1Vh6M1lGMqj7zOnCUkA7KAhKFT5V/i+o/Ho4HkU++cMFmF+uakN5UA65O8
 MrhBnKtCvBafYQgDA0S2Y7hMRfUvWfPlXGTzi94rCBZE9CX6JzvyZW625HI+vhLRchX1cxvm1JK
 J6auyg2Bc6BXE+DlDcGvmmGzfUt+gvNcGVIBTkb+c+AMnkARc/IkZ8o3LgPowZEeXWp8+bYE5Cg
 /zT+Te6JV6qqnCopAErFnF5Wn9Vrobq++ZPlG35Sbp8BJIzVKaE9Wwlzz+hRR5NrFd6B7FpVDVv
 DzHCDbvNOL7+6T9JsExO1mMskdl7JiWSEJyjKcAAG9IZaeNBwRG8yaaKK0Y6eDzLcn6kG5V8EeU
 ic88V1VXgF+UA/OlSAMJ2U/6AfzTjnmDGRbrnkaeGP7CnsW64JDQD1kz1eQMWl7okCNKuDEwSpN
 g7fHe91pG8duQy7BZQvncNoS2Zm2MO3h5UZ02gvAaH+Dn69f6VNM01R4Fxd6lhD7BZ+31sPRrPi
 fs3Dug01rMorlaA8eUHw2y3MjpEiul4iA3bwKz/s9BChfh2WolHk=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

Hi,

This series expands the device tree and drivers for the zx297520v3 board
enough to enable the DWC2 USB controller found on this board. This
series depends on the zx29clk MFD driver that has been accepted into the 
MFD tree, but not yet merged into linux-next.

The individual patches contain a description of what they do and the 
rationale for design decisions. Here is a quick overview:

Patch 1: DT bindings for the node containing the necessary power controls
Patch 2: Add the socsys node to the MFD driver
Patch 3: The power domain driver
Patch 4: A minimal USB PHY driver
Patch 5, 6: Link it together in the DTS

Dependencies: 1-4-5 depend on each other at build / DTS validation time.
2, 3, 4 are build time independent but need their previous patches to be 
enabled at runtime.

The MAINTAINERS additions are going to cause issues though. Once the 
patches have been reviewed I can either take them out or create an 
immutable branch.

The open questions:

1) How much documentation is appropriate in the binding .yaml?

I want to document the identified registers *somewhere*, and since the 
yaml lives in Documentation/ I put it there. I do understand though if 
the Linux kernel doesn't want to be a backup SoC datasheet.

2) Power domain vs reset:

The pm domain controller has a reset, isolation and power register for 
each of the 5 (maybe more) devices it controls. My binding links them 
together into #power-domain-cells.

To start up the GSM controller, its driver will have to assert and 
deassert the reset. The GSM controller (Derived from an Infineon 
PMB8877) has a self-arming watchdog and after 2.5 ms it stops 
responding. With the power domain it is somewhat awkward:

devm_pm_runtime_set_active_enabled()
pm_runtime_get_noresume()
pm_runtime_put_sync_suspend()
pm_runtime_resume_and_get()

And hope nothing else is holding the device and that runtime PM is 
actually compiled into the kernel.

Life would be easier if I expose the GSM reset bits as #reset-cells. 
Otoh, I'd prefer not to do that for USB, as USB already has 3 different 
reset controls already and adding another is awkward. I could of course 
also hide the USB reset and expose the GSM resets.

For now I postponed the issue and don't add GSM related controls to the 
bindings at all.

---
Stefan Dösinger (6):
      dt-bindings: soc: zte: Document zx297520v3 socsys controller
      mfd: zx297520v3: Add socsys to the mfd host driver
      pmdomain: zte: Add a zx297520v3 power domain driver
      phy: zte: Add a zx29 USB PHY driver.
      ARM: dts: zte: Declare nodes to enable the board's dwc2 controller
      ARM: dts: zte: Declare the HSIC controller node

 .../bindings/soc/zte/zte,zx297520v3-socsys.yaml    | 100 +++++++
 MAINTAINERS                                        |   3 +
 arch/arm/boot/dts/zte/zx297520v3.dtsi              |  42 +++
 drivers/mfd/zte-zx297520v3-crm.c                   |  12 +
 drivers/phy/Kconfig                                |  11 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-zx29-usb.c                         | 183 +++++++++++++
 drivers/pmdomain/Kconfig                           |   1 +
 drivers/pmdomain/Makefile                          |   1 +
 drivers/pmdomain/zte/Kconfig                       |  15 ++
 drivers/pmdomain/zte/Makefile                      |   2 +
 drivers/pmdomain/zte/zx297520v3-pm-domain.c        | 286 +++++++++++++++++++++
 include/dt-bindings/power/zte,zx297520v3-socsys.h  |  11 +
 include/dt-bindings/reset/zte,zx297520v3-reset.h   |   2 +
 14 files changed, 670 insertions(+)
---
base-commit: d785d132202e8e8e93335ebf74ad5b29fca0951f
change-id: 20261117-zx29usb-c3a90ab59354
prerequisite-change-id: 20261108-zx29clk-3b073b9d22d6:v14
prerequisite-patch-id: 3ea4ed11578625d6aadf59c5b542e788882eab2f

Best regards,
--  
Stefan Dösinger <stefandoesinger@gmail.com>

