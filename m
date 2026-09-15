Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDD8440A25;
	Tue, 15 Sep 2026 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508822; cv=none; b=EiSSC/Zw9//ZfELiFRuO7vPtQBtgZdjqBfJhA9v0sPDHk37dPtb3O3nN49BBNIdlu/W7ZwxYDzEF94zmyZcYRpfuGY8GJ20swR7n8tvpAaXMN3l/WDNNHktZ8+vpiAPRWVOOL+lm/4xoewq4piaT9iEX1g4f3N573MObIMSDc/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508822; c=relaxed/simple;
	bh=Hv6ojg66OwiHgnnD2qBgHgsdUiiiCy9oBDzblh90vTE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QWF6j+UXgRzhsygP0uAhjn5MzUlaEiAIZc384rf3OzWygm0Y1eKs56MdJ9hZ7MdGadDtIrl7YjCK1MKa+rsgZ5Po1UHXi3J1N2bx1xkrka1KT7jViei8fyeeA0/lIUDvadRd0lTOZjFETdxUsZcCYBCOrpmhmo95DbccetrudEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=au/MnVjb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="au/MnVjb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1512F1F000FF;
	Tue, 15 Sep 2026 21:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789508820;
	bh=reqWTzZzh5f50o4S7TcknAuT+OR9hZ1yDSaNoq4fB2c=;
	h=From:Subject:Date:To:Cc;
	b=au/MnVjb3WmJ6ANk+dW5wYjCAttmEyvJiczayoO0Q6YXdWsRizEBPqHsTbS0F9W3M
	 u0oVZ3Qkr9ux0QzMP9RS6c3v2xwmty+oKA4TKKU2BqsgaCiwbtM2QGfDbOlDjrCzpJ
	 +cehwlQ+cEqCpFYbogOrxWu19Iym0CVG2CRBoTb4ztPUMO4SQmiEwJdzl1sb8CYK7o
	 Ez5+tlShdsNpjcB2w1/PC/K/jp1abHn6JQpVG/yUiJRubc2dxkZWnVu1eA2NfKkrFG
	 VYh8HuHhEHnF3sj+YHXTh6ZnIbc1hG/zNVrGSb++CFzpsHaQCgFJthpDM+Oc9bxnj2
	 qlI+bGuTmo54g==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH 0/2] power: supply: Correct AB8505 charger device tree
Date: Tue, 15 Sep 2026 23:46:53 +0200
Message-Id: <20260915-ab8500-charger-dt-v1-0-10b7b387e6a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAMAzAviI9W6jTifMr4mFuVXtR6UQE8e8Oj
 yEkDyRW4QR98YDyJUn2LUNVFhBWvy2MEjODIdOSqyz6qbNEmKUurBhPdC6Y0LSm9h1B7g7lWe7
 /OYzv+wGrzk9oYwAAAA==
X-Change-ID: 20260915-ab8500-charger-dt-99c2c4623a80
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

AB8505 retains the USB charger from AB8500 but omits the separate main
charger block. Its charger node consequently has nine valid interrupts,
not the fourteen interrupts used by AB8500.

Adjust the binding to describe the variant-specific interrupt sets and
remove the five nonexistent main-charger interrupts from the AB8505
device tree. The binding update also limits the autopower_cfg description
to AB8500, since the corresponding AB8505 register bit is reserved.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (2):
      dt-bindings: power: supply: ab8500: Allow AB8505 interrupts
      ARM: dts: ux500: Drop AB8505 main charger interrupts

 .../power/supply/stericsson,ab8500-charger.yaml    | 44 ++++++++++++++--------
 arch/arm/boot/dts/st/ste-ab8505.dtsi               | 14 +------
 2 files changed, 30 insertions(+), 28 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260915-ab8500-charger-dt-99c2c4623a80

Best regards,
-- 
Linus Walleij <linusw@kernel.org>

