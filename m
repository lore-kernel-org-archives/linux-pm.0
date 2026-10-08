Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0729C36F91F;
	Thu,  8 Oct 2026 03:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431093; cv=none; b=LW3xKp/n8Xzx6C0Ez+ftU2y9rWHEcSPteJusi8qNqU1byUleIZ/e8h/WWvPgTFVVJENeMP6soH/rJdQTD2ouDy6O8F503vtnjixOiYPHZnGWpYS21rs0UvGz1kSnNVPkOncidEKj41OLZbsSo2q/7zy+Q6tGpQKbR/+bZwM+nZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431093; c=relaxed/simple;
	bh=l8FGwTF2AqdaoQ0RvXAoKk8wuM5SPe0apwnGvih3fuI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=izx/RCOkbBwc5MRCtxaJYxdFz/ed/GuNsB/aSPtCm8itJW5seSuqgw+SeVzRIwXmegOjfQfFFoMqkmIarQ4gOepMbvy6irhkGFAWSq285ggl5sYKodvmdXyzD5EUivSu10mXHBuwYVf0H6rdEbEp2sYh8LkIM/7OTv89dcdg6kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVYZFyax; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVYZFyax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B7B1F000FF;
	Thu,  8 Oct 2026 03:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791431091;
	bh=aVCywcmTgZV0JLf3OiewVcrZqNd7Lr+G7Z98xka/5po=;
	h=From:Subject:Date:To:Cc;
	b=lVYZFyaxUSQCaabUnuhzn6w4zrpT47hgyOpbVAkXbmNZu+YHoh0ldFHtRgfKCx+EE
	 7hFIQPkmq7xrUzbTBWbJtaqvRoUXF2N1RtZCZoCzQ9+eX75/Zvc2wDRR2E4B/DKerV
	 7/Te1Vl0PYMMuxmF+kb/c2tfoHk4pIdfb1XEoy0vp+kDSxY23++UWZNiN+AKfwa6rw
	 Lg0W6bKZvlP9AU3CUjBfC6Wu47Pe6BqH7YBdAU62Mw5fDiwZzCwcCnayDAZNQ1Ggyg
	 HwwIWmfG+BlAl0qg0kmqUuO8qAgPEwGVxZEu+1spk3MuUKgD9hhI8TLSxE5aZiksN2
	 YgMqAOcdzt/AQ==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH v2 0/2] PM: spacemit: Add power domain support
Date: Thu, 08 Oct 2026 03:44:28 +0000
Message-Id: <20261008-04-k3-pm-support-v2-0-6f778a53dd2d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrB0Yovh3ldKFmkmdFjVktBQkd
 zfa5bd47wDlIKzQZQcE/orKuiSYPINx6pcXo9hkMGQqaqlFKvFToJ9Rd+/XsCEN7Eripna2hpT
 5wE5+9/Lx/Fv34c3jdn0gxhMzQmkYdAAAAA==
X-Change-ID: 20260909-04-k3-pm-support-0bef40e87fd7
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Icenowy Zheng <uwu@icenowy.me>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909; i=dlan@kernel.org;
 h=from:subject:message-id; bh=l8FGwTF2AqdaoQ0RvXAoKk8wuM5SPe0apwnGvih3fuI=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqxxGmCApwz/x2lwt/8Lmrh1k9FSkd+J/kZiLik
 VBNNGSb2kOJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCascRphsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3hpRAAg9q7RKB8tNhnOWOn+sPugundTYNccTp5gk+xKOAs2LD2DWJl91QB+
 2bewwtCnFl288cYCJccAhDi//jXoKoovT8JWiJE93g0OftvXte2vwWxgNgVc2UyYgcKk+c02/ba
 KWyTLhJzvVnxaFLfLsCwbLnTAYXBbjurV+gviPfqauLycq9W7kNFeNcxHJWDsZ9MRSEgofOQTlH
 mhsQ7KusX4vybJ6YNZRzGOukKHEUtBx/badTbMxljWSQpUnNoCbLlgCriC47z9u1CFgaZGhGdXK
 +v6GyaE/OGnx9E6SzBYtXkj5ICLRcEEhaDMa2Y47wjJeADaivNcmyuGWiPe/yxJrLJ4ju0adYrQ
 FLyhgjpVrB2KgklMfmLsibMPJlQPm5y2JHP7QsPIUvqrjj4bHN+CgnxJOugh8DU2wtb7aHsyI1e
 TQ/zTvE/wEg0U8H/peN8pMS06P6VmO1c3oCRYG4Ag1fwsnl+BdgKiDqr/K7dwcAyVcrWzPDUHu9
 9mBueT3klB67dC64mYGRIDbpleccoHR3v/E297nolPBH5KZiemSC7G8FrxzX/futoJtMS+v7qUB
 IfUYIy8NiN99M8kTNi+JGlleIiO7xUP4X9iy0mnM6c6w1L4kgAjaHBgWb0SVyRymRTqIIzlKfEt
 87Tf45/ULix0bM9sKujB7wQXDITIFo=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

In this series, we try to add a Power Domain driver support for SpacemiT
K1/K3 SoCs, the driver implement the power-switch functionaly which support
power on/off, and it's based on Linux Generic PM Domain framework and
similiar to vendor K1's implementation, but unlike the K3's vendor
version which is more complicated.

  The DTS patch is obsolete, so drop it. For devices required PM property,
the DT part can be sent in separate patch.

  In order to test this series, a prerequisite CCU patches are needed,
which can be found here [1].

Link: https://lore.kernel.org/spacemit/20261008-04-k3-clk-pm-aux-v1-0-8372d7307694@kernel.org/ [1]
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Changes in v2:
- convert to auxilary driver
- no need dt-binding doc, drop it
- drop dts patch
- support to build as module
- set always on for K3 audio pm 
- no global variable for struct spacemit_pmu
- no force to do power-off in spacemit_pd_power_on()
- check return value of pm_genpd_init()
- adjust license header format
- Link to v1: https://patch.msgid.link/20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org

---
Yixun Lan (2):
      dt-bindings: power: spacemit: Add power domain controller IDs
      pmdomain: spacemit: Add power domain driver

 drivers/pmdomain/Kconfig                        |   1 +
 drivers/pmdomain/Makefile                       |   1 +
 drivers/pmdomain/spacemit/Kconfig               |  21 ++
 drivers/pmdomain/spacemit/Makefile              |   1 +
 drivers/pmdomain/spacemit/spacemit-pm-domains.c | 413 ++++++++++++++++++++++++
 include/dt-bindings/power/spacemit,k1-power.h   |  14 +
 include/dt-bindings/power/spacemit,k3-power.h   |  12 +
 7 files changed, 463 insertions(+)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260909-04-k3-pm-support-0bef40e87fd7

Best regards,
--  
Yixun Lan <dlan@kernel.org>

