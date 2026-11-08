Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794134176;
	b=O2WP1aCrivQqXokeD4Pwr1KgkJcESJ8IzBkMnVJFaspt4a4MVyhZ3C5xS/0+88Jlv9kZ
	 lxRZek56KTCEs2jPFo9qC92h02sEB2NqEdiNQelQYM5ntmPyxNF7ZK2t88KyQAq20oeqB
	 724XwCouIEMV/zu3kGj7kioTHykGuORQQkRrmDmPERvFpVQImzaN6ChJoYu5w8L3iVaeQ
	 n1i6H3SuYzxurp2VPv0pocLrIbeyr6daIG7JNyipfxg2v3R9YK4j3iMjKQoNDJgH5TWCy
	 POsWbtfbCZ6er2IvRwrfa+nNVRWrc7NO2EKdTC2ivrVjEbnDDgGB3/YRYqf0fw2EOwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794134176;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kz+V4tNKgCgTqqukAPWOp8JL5D6hxHLTQSOOf6DneB0=;
	b=qgwqVRovinEYdDxWtGSN7LB6LmJVHqxKKD+PhR6vWo2TEqvCQTR6N3qEqrnoMTcrbiQp
	 cHG1NDgLzv7eCAgAqjLuE7ovBV6z0pnlNpVd9AMn5BAImbqqfgcrHV394CfGecLySWi5B
	 iVVknT4vn7c4Xz7wqRqGWs/uIjhUy14qHC7wWLVxHL0mHV64frQ2PdAcDicWD35NgN5Er
	 bZdXBqLBcNmYajAn5mIzYJ5+DzDqSq7P0XA0h774Kff8cA45O6zp7dxfxuhKgIh+G9YAB
	 em8W+Kb5Vmls41CctJGqgvSYpOwFSBI87y9sizf6cg/uf/+qgbSVo7wkwh9D2sv2nYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNc7EgjW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649D0606A31C;
	Sun,  8 Nov 2026 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNc7EgjW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974CF1F0089F;
	Sun,  8 Nov 2026 10:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794134175;
	bh=kz+V4tNKgCgTqqukAPWOp8JL5D6hxHLTQSOOf6DneB0=;
	h=From:Subject:Date:To:Cc;
	b=ZNc7EgjWwSNk60I/4Yb05rQ+nMHctWoleNJRYDq0AmhD4VNlHOzQFQ4fJlUb9oEz5
	 fHMdcbmN1HqeFkLHj4YW3MN1UpkA8bZ2zJxf+86OWCCCsY26rxqYfy8h7TC+XroNgb
	 YcxwBu0DRelo0He2r9AHNBU9KquD0+D3yUXASEInO+6mZwgQ+38NmLiK/ajnvBIs9L
	 9GcZweFT6Fe7ZJ/BcAjiT3G4PsIL1rTgBHcnOvVbl+v0Ge2k0VPB5+83Hu0HwmHcns
	 GLxtMK4NNSsIC2/uYzZcf88/K+T7bIhCHZE9sObkKx3r2rhlVs55/qXxX+0RmIGrHw
	 4o6/Yq+aqNftA==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH v3 0/2] PM: spacemit: Add power domain support
Date: Sun, 08 Nov 2026 10:36:00 +0000
Message-Id: <20261108-04-k3-pm-support-v3-0-b9dc0857039b@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQ6CMBBFr0K6dsxYkIIr72FYAJ1CRWgzBaIh3
 F3ApcuXvP/+IgKxpSBu0SKYZhusGzaIT5Go23JoCKzeWEiUKeaYAybQxeB7CJP3jkfAikyClCm
 jldhmnsnY95F8FD8OU/Wketw7u9HaMDr+HJ+z3L0jf0HM/vOzBITUKJWV11hrqe8d8UCvs+NGF
 Ou6fgHPXAQpwwAAAA==
X-Change-ID: 20260909-04-k3-pm-support-0bef40e87fd7
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Icenowy Zheng <uwu@icenowy.me>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2441; i=dlan@kernel.org;
 h=from:subject:message-id; bh=eYHQ9sRtIF3B/i/yNtGTuObHILC1/C1ifsAMq+TkTEk=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBq8FCSZppbebPKDI9SWsfL9gla8PQlWEXw26y+r
 V7jViOb4HeJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCavBQkhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0jRQ//UZP9/Zhkmhue1itkQrV/MjQ4baUoZQhpV/Xx4j2XaheBJtYUKuvPC
 XX75AGU8WnzFC0Htcm0feEjL6y6uELsCbOPQK9UeLpMpMMuJb5/NDGHX5ekpDK10vJyWKBL9IsN
 VDRR/OW0SoTPciEwyqjLZ6P7/9OVpvcoqgYWLhJjLRRzkPG3LGicoP9VKj1djcC6OzxK4KH+jy9
 1eTs0QVb9+lMxugzFb98QaPqe926AHtkTpnf6HJlQ+vAbU62sxL9cb/0q7zNdscyCOst64t8n3r
 ginGc8paW5IHvp427KX1LCGjmvApy9yjV90seDeDObaMa4Ty6vw4d2eo3ji8UooK5I2djBtplFU
 4DSvuT+h2GpLqHTltpC1IVVus0oEnMSwkRPlunMp+AlOmtRiDJoKuttMsN0iuXR2DfnMaIBbM2V
 kxkzDt5DT0QzfK2AtHyzoZWj563TEm5P8oURp/G8MiIUVXL9dp/AGk0v9wFY5Bd80ldpToFmMxE
 GB5ooJfq0JEfd2FUBh11WmrtUl90VDL4a6JFqFA9SuOE2xwvH4ucUEAjYnvKissMRBfeSXNaux6
 Yhr85hrVUknGAX/cWzyGlFBcRUF/8WLQITzQeM349VW3BCn5cQ9I2RYzXQ5rJ5MyVyyxPzf5Guw
 cFjD6cQbwnCSi4ehwKecE3AM4lqdtQ=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

In this series, we try to add a Power Domain driver support for SpacemiT
K1/K3 SoCs, the driver implement the power-switch functionaly which support
power on/off, and it's based on Linux Generic PM Domain framework and
similiar to vendor K1's implementation, but unlike the K3's vendor
version which is more complicated.

  The DT documentation for Power Domain already exist in below file,
and APMU already has #power-domain-cells property.
Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml

  The previous DTS patch is obsolete, so I dropped it. For devices required
PM feature, it need to add a "power-domains" property, and should send in
a separate patch.

  In order to test this series, a prerequisite CCU patches are needed,
which can be found here [1].

Link: https://lore.kernel.org/spacemit/20261008-04-k3-clk-pm-aux-v1-0-8372d7307694@kernel.org/ [1]
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Changes in v3:
- collect tags
- rename spacemit_pm_is_off_state()
- implement a remove() function
- use proper type in struct spacemit_pm_domain_param
- refactor struct spacemit_pmu
- Link to v2: https://patch.msgid.link/20261008-04-k3-pm-support-v2-0-6f778a53dd2d@kernel.org

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
 drivers/pmdomain/spacemit/spacemit-pm-domains.c | 431 ++++++++++++++++++++++++
 include/dt-bindings/power/spacemit,k1-power.h   |  14 +
 include/dt-bindings/power/spacemit,k3-power.h   |  12 +
 7 files changed, 481 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260909-04-k3-pm-support-0bef40e87fd7

Best regards,
--  
Yixun Lan <dlan@kernel.org>

