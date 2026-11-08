Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794136948;
	b=tXSqDPrLh3TduOCjkg21D5+OsXe/1+D7iauBFKLDg1+Knk0rY8/HylbuY6O6rNmGdSDC
	 Gqudfo13qlav4m5RQRhk7r3iff1Xt5zAvOtRN/5eV8h2yaBlWudvp9dNrvJw2Rd0joznd
	 60ZSO/Eev2aL9jDPWIwizduz/lXFftx1srndYSUbxi5HbeUEPas8BaeXZ7Ms9WOD/sXFl
	 mJSThuVdFFayXc9cUcPgFieD4V9sqXBHh02P8f8Szlrd36yt5zSdRKZ/7lOmGhsUblhe0
	 zhLr6hoUXbgIF2zITsLYL80W4KSuL3ypu0JsP7RChhgirBaTn3zJzUTSWaNj5nn0i4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136948;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=W/58ODSxMLt+iMgV2qP5B56+KOjf7jLiaxB4ZCqjUs8=;
	b=sDiYsQyte1hQ1vR28Bqxe3pqQ7OYxi1p2EBgS8ZvzWmZKiimr26yYBNVNQpK7mfTrFHZ
	 E9yBgCsLksvzyEiCOGJJeVC8d7mP4eLJzaRaLkQF6TfNXQTOeYqPEXw2qIUz6twXs57yh
	 rBJHS8vkHolQCAjdUU+PWiNbgKSXlqZR8SmIr4qGfm5+rbKqd5rPTgktmzjtGlpgg1IGg
	 JK6lQff+BZwC51RdcZozhwjiBV0eIpiLkLW1Pk88LS1rNMzAE98AaHIJ8cbgNzVjRYFQO
	 2bAqAr8bsbQf5Fv4ekb67DRcBAJwYXioDoJn+VNwNB00hzajEUg1TBsZX0zPLu1jzzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJBuJWin;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC3606A326;
	Sun,  8 Nov 2026 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJBuJWin
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794136947;
	b=rD25eM3YFrdn6UqBCPlR3/A/FO5oq8ikT8k9vQkx5zR1Z09pLFOPw2Nb2e/a83kAJwtH
	 BZGtgayJokoY5PWlAO04rkt8ddqwoDZv1Vne5mf/wNms3ArdssZy3F+N/4/GWX9vsTfFS
	 Ie4Ln8Kqji7QZu3Bo8my6yEPj23PT0lCYbovLHzJEoT63vIphXwslVpeVVgmgzSwRdFFH
	 5CBSwOd4KUOmBCI2CofXWLjxga4wN2ZjmOV5MG/18DawG/mY28cwRasFwR6TSmKNO2XE6
	 N/5HN5gEtZZbh6359a6XR7jW2NdVq+pi1mcEK3xE7EaLFpqwA5JcDJc1eY83fAU94Qw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794136947;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=W/58ODSxMLt+iMgV2qP5B56+KOjf7jLiaxB4ZCqjUs8=;
	b=IIYOFJ1SDT7VqbJRjEL6gchT1CsZwYCx9C1wqE0S3qZ55onGg/H/rpW6aZN2SdNQJqu+
	 yBP4fvyYtPhZwbJCxYpMXOCqHGTbakgKKYKiw0DAuS3Dd+DHmEGhhoER/jiIeS50erRMO
	 DRPKasfsHTsD07lWeK+sKhu+CLUnqWVy9WV1ZhW4nJdMLQ0d11Ls7R0MZrM0N107+b1f7
	 wUWRWW2Tx6SdX+RJCYKFCaltzSt5fPkL+ks8kaWkt+GhhHVtLXtxFkqsMt/rTV7ZTyFLH
	 GaZqEZ3ruvHjPhyTt8E3fF1FjElyOq/yWAAks5OjSkfMBw7QfnE3E6AY+CiDIPDWkzA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DCDEF1F0089F;
	Sun,  8 Nov 2026 11:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794136947;
	bh=W/58ODSxMLt+iMgV2qP5B56+KOjf7jLiaxB4ZCqjUs8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=HJBuJWinfAlmCSZWcUeH5DhJFOIs2vshonr3ZYyrWpi7ILudZL8Ta8G2v6pLuHlFc
	 NYem7zRlE48yUPzMcL/EC6K9Sb4y5Qu7VxP5+DjmCZ2OO5xw6hlgVeRyCapWfhud8D
	 UmgXiF2+XkugIkP+LJWgMSecRbZrFOfJtTBOhQRJbK1f938gkhIAQ1+h0Cj1tj6MA3
	 tXnKBc2l1OxQzOvSA+KVTk9jUVWvdS4/8Qa8XwoPmCbXztCUH1wlGzmiooQdZZ2zwB
	 LaZJXJjdb6qRTJI7eMyxnIVT6b0CdQk79zF9jVv4Jknx6JCo4AqMhb3R0ZSgUQRdww
	 sBgCm0L/UGytg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 72F3347EFF;
	Sun,  8 Nov 2026 11:22:26 +0000 (UTC)
From: Nizat Mikayilli via B4 Relay <devnull+nacht.dxdmail.cc@kernel.org>
Subject: [PATCH 0/2] power: supply: Add Silicon Mitus SM5714 fuel gauge
Date: Sun, 08 Nov 2026 12:22:24 +0100
Message-Id: <20261108-b4-sm5714-fuel-gauge-v1-0-c659b6c0884a@dxdmail.cc>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2M2wpAQBBAf0XzbGpHWPyKPDDGmnJrN1Ly7zaPp
 845DwTxKgGa5AEvlwbdtwiUJsBzvzlBHSNDZrKSyFQ45BjWwlKO0ykLuv6MDvMglqkmNgwxPbx
 Mev/btnvfD/4vLNlmAAAA
X-Change-ID: 20261108-b4-sm5714-fuel-gauge-ccbe7c191c0c
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nizat Mikayilli <nacht@dxdmail.cc>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794136945; l=1211;
 i=nacht@dxdmail.cc; s=20261004; h=from:subject:message-id;
 bh=G4eLbQVc7Ut3i550ga26bqAGN7kV6jqBGKLCtmfUKLc=;
 b=DLCmbW5H/qvvM7izdoeqCMWESI+C+PhwFfIouDn7sRaNwibvHzMEW6u7cfLiekx19DKpR0/gR
 J9d0opx947kC8Ha8ouYy5QjlR+HeIG24m4AGgGYHnQ0+/XhvrdcGWKc
X-Developer-Key: i=nacht@dxdmail.cc; a=ed25519;
 pk=Kay3P3pOJq5klUD+0/I8QX8JGOh0CeQXEwRVv7CMm4k=
X-Endpoint-Received: by B4 Relay for nacht@dxdmail.cc/20261004 with
 auth_id=1111
X-Original-From: Nizat Mikayilli <nacht@dxdmail.cc>
Reply-To: nacht@dxdmail.cc

The Samsung Galaxy Tab S9 Wi-Fi uses the fuel gauge of the Silicon
Mitus SM5714. This series adds a binding and a small driver for it,
which reports the state of charge, voltage, current and status.

The fuel gauge node for the tablet will be sent with its board series:
https://lore.kernel.org/r/20261022-gts9wifi-dts-v4-0-a361428fe59c@dxdmail.cc

I tested it on the tablet, with the USB cable in and out, and the
power-supply selftest passes.

Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
---
Nizat Mikayilli (2):
      dt-bindings: power: supply: Add Silicon Mitus SM5714 fuel gauge
      power: supply: Add Silicon Mitus SM5714 fuel gauge driver

 .../supply/siliconmitus,sm5714-fuel-gauge.yaml     |  47 +++++
 MAINTAINERS                                        |   7 +
 drivers/power/supply/Kconfig                       |  10 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/sm5714-battery.c              | 221 +++++++++++++++++++++
 5 files changed, 286 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261108-b4-sm5714-fuel-gauge-ccbe7c191c0c

Best regards,
-- 
Nizat Mikayilli <nacht@dxdmail.cc>


