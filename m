Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824291;
	b=INoqYpebH+VdXQaTH7ECSk/puxn5TkUF1CxqQ+Y4KUfQfw7Hg3dbfJxFrwvEq5X8fNtJ
	 8KkZH2L1wl76tEPNxLNt6D+NFw8mzKu6BOQ/VhWwvKrksV0H2nxLBnVL4/57p0l0gWLPZ
	 rjkiaUiysw7ypi0HyEiPk9qQbl73yPGoDvgVta5bFGqGIRt4Ha6xlJYESLvRmYfWN+LCj
	 Q0xNYn6oApslvVJHhe7YLooQv9d09eGGWfovDMhUweMM2KICeaqChZ6nNgAVkpyxmDqKj
	 s2FT1wFFZ86JcDrVpd66pLAc4B4b+9FQWuk7TbCi3QpzQKFsXdR/iNMwP5pjcfZzUAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824291;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=d8ZOa6Ph/zg8me6HR9Oexa2iZrXd/vZL36FKgzFT1zw=;
	b=P1pVgGip13+gLKbOKvj7EC2OhY3YC0OW+6bp1u67GXDIH+cLwQD4dwhst8GHcTz2CETs
	 NmsY7+WGcRiY13w8urhJiRJ2Z+rT26hdaK35a1KKU1+p8IDfdh2wLYQ5wMIp3SU/PXMWb
	 kFr9UIOi6libjsWc6osN+DMDy7nFSr6vZlkTl5HJGmRlI7uepPKyNfU/E7gaxJiYn5IIz
	 gDpOCSicFxXCpzuomnBolv3ij9o655u+gR7tGlHTUS4atQrzspgVqlG50htqDbOMk5WCj
	 XjqO3fTM4ju0/boTQdLF8WlbUA42f5JejTmvqkSdTJVoViMEsITT38GLh11r1QJrbpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4NN1M6X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A1F606A32A;
	Mon, 16 Nov 2026 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4NN1M6X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD24A1F000C4;
	Mon, 16 Nov 2026 10:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794824290;
	bh=d8ZOa6Ph/zg8me6HR9Oexa2iZrXd/vZL36FKgzFT1zw=;
	h=From:Subject:Date:To:Cc;
	b=a4NN1M6Xry58G6kL3qkJJpj4e2sjuqXIJOAd1GXtXycZ5FbRCjxD8DTtBniF4s32D
	 Ekro778HzYS6UqUMvVk7Q+wCAwDbpiO4soLPdHZ/cg4hdX8Gocfj2hFOXJo+geHSIq
	 PmwPb7FE3BCKv/sjxGm7sjK5tSySluK+JauDtKlN8XC0eI/cR5ea4Yo8d8vWLi71c5
	 HG2gzxZ2GGQ7KZwVXZUb3H9SQrKKpVi05P5M1m9O52ddkNeQlB1Gji1/xgBE7Jatk1
	 s/PYqVL824zTfjUDizeibfzJCCqhcEmyQI8tKhnWVQkrb3JyC4NCzj7l3fq4TH3RiW
	 y5vzGxMlHi6kw==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH 0/3] ARM: dts: ux500: Convert EPOD consumers to power
 domains
Date: Mon, 16 Nov 2026 11:18:06 +0100
Message-Id: <20261116-ux500-powerdomain-dts-v1-0-e0f4459c3ab1@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MQQqDMBAF0KsMf+1AImolV5EuEjPVWTSRpLaCe
 Heh7wDvRJWiUuHoRJGvVs0JjmxDmFefFmGNcITWtIO1duD96I3hLf+kxPz2mjh+Kvf+4bsuRBN
 GQUPYirz0+L/T87puFC2/omcAAAA=
X-Change-ID: 20261116-ux500-powerdomain-dts-5a7a44bd0b8e
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>, 
 linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Rename the Ux500 power-controller node, assign the CPU and peripheral
domains, and remove the legacy DB8500 EPOD regulator nodes and supplies.

The companion genpd, binding and driver conversions are queued in
other trees to distribute this task.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (3):
      ARM: dts: ux500: Rename power domains node
      ARM: dts: ux500: Add power domains
      ARM: dts: ux500: Remove DB8500 EPOD regulators

 arch/arm/boot/dts/st/ste-dbx5x0.dtsi | 156 ++++++++++++-----------------------
 1 file changed, 53 insertions(+), 103 deletions(-)
---
base-commit: 64e2ab0ca7ac63f876e5de06300b6f033baf5e35
change-id: 20261116-ux500-powerdomain-dts-5a7a44bd0b8e

Best regards,
--  
Linus Walleij <linusw@kernel.org>

