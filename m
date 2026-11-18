Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795043618;
	b=D3jzkFARj6EtYY7XJ2aXIczBE/setRoIrku3fqS2m3IagTmJHnJcIr2zQdfrjnw6zEIN
	 zf1qIJFoaBAKFMSwxaQrHxkDeIIQH+T1sbENAMIC2h9j5dHLaT/5xQ2ImuTvmLCegLyoa
	 z/b9pU3fApuFZ3KJq1Cc/n2bC98OLAvY/vsJCJKXXaTqpYk4lTbxjpvpGPdyAEQn5udWt
	 e/88quA6dxkujLnRebTj1rD3pSyv6CvFH43Usp18zxUS9hlKkUYqbwfooiqr/hTDwKaqQ
	 5GNQKr/qvioY84hrP5HDXi8/qHjiVQnml22c1R+ZMes9mGm2CSi2hlk0V10KPzCQpPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043618;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=uthXM6AxMh++BZoRfLANxhung5bsXeyFFnHLnIx3PQ8=;
	b=kowT4KYhHdq+OwoTqVmNQDBfrRypfDItt8zq7A8CgbgbhVBIKkECVwoq6nrLeqrtVCG/
	 2Ll7qZ1zoaId+oHZDdyS2JZ6WawAg/u4lB3UZrgUYMKOn66lY8H1ut85XbeT7UJhKIbjP
	 6aTtk7gU8YONjCQVsGkSRHiDK6OtHq6kylKxOfkJA4haCh6TdSJpFxBZ/2cmp/iFFcejm
	 BOD8XPY8TNs3KWQ7Vb7iBt0qKrXSk5RCe6SZ+c55KbJgWa0lwB1ulyUNNtS0A65LquX8y
	 RJO5nnul1827z49QqQrgyqw/7++Ia4r2eTLAklvH1mWmiH9+LuOgNzLXixL+gOUqvMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwzriDw7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22B1606A31C;
	Wed, 18 Nov 2026 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwzriDw7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836111F000C8;
	Wed, 18 Nov 2026 23:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795043618;
	bh=uthXM6AxMh++BZoRfLANxhung5bsXeyFFnHLnIx3PQ8=;
	h=From:Subject:Date:To:Cc;
	b=lwzriDw74S3uh8xf6HvVI61QO1ZnRSHG5266D3U4SHz2fo5h244CXqvX8w1CFky78
	 /xDQr0MAX1G8fVl0IiMLoqcnj/JOefW7P7ln9LOs+o5RxUEq9+noEHvIqsWAoc8303
	 6BDXeAcrByKocXYUWxnRShiT++I/e8NjQL3P+SjQ5hjCbnRmC8fpaMgmhoXbgWI02N
	 jzelGx/zG+/8/qCi9o9UBoaxZlDzz7HD0WGc5Axm0V3nlkBFKsCxwGJB2up2MYjiMx
	 faPzHE8yZiyqm0RHWRtS7H7vfCG/fNQ35zgdH4h3ZWndzt+b1/BQKlVz8OZOrJO/tC
	 p6FNGwvCcKj7g==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH v5 0/2] PM: spacemit: Add power domain support
Date: Wed, 18 Nov 2026 23:13:08 +0000
Message-Id: <20261118-04-k3-pm-support-v5-0-42394acdf3e3@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NTQ6CMBCG4auYrq2ZtpRSV97DuAA6QP2hpAWiI
 dzdggs1unyTb56ZSEBvMZD9ZiIeRxusa2PI7YaUTd7WSK2JTTjwFDRoCgm9CNrdaBi6zvmeQoF
 VApipyigSzzqPlb2v5PH06jAUZyz7xVkWjQ2984/158iX3cozgOyXHzkFmlZKZbkUxnBzuKBv8
 bpzviaLP4q3wP4KIgqFNiVkUoHQxY+QfAiM/xGSKBgUWrA8l0yKL2Ge5ycoKxcpRwEAAA==
X-Change-ID: 20260909-04-k3-pm-support-0bef40e87fd7
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Icenowy Zheng <uwu@icenowy.me>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3463; i=dlan@kernel.org;
 h=from:subject:message-id; bh=dIcn4UKroERxmS7Nu963yNp5RWL56ReaEAU4lVs9RqI=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBq/jEVPiq46KOXgLjax5SPnS3Plqx47MmZgpwVV
 MAPRHk7dZuJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCav4xFRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0Dhw//dGZeYB0SmyPcVLPgv5mSKL7/6pSsnmsLioEXbGrdiYa8ZrAJ1CcU7
 QlJvtryqTGJVXmpmadynV+MNKqbwreVUWcU+6nGleJ4cj6U6bxkD8Qh5OoekrcBgXXSShxSc511
 zltESptRs+5dkT5xniFsCarrRiMF00AFt0NmCglcG6CBrdK9/gWkOc0wJKmXgxUqyzLpcYi49Lg
 beFejV39AnaxJ8/DWDa0KxU4oY4ZKiifAq5fxFdDkLbDT/MxWAi4LTYaAOjG0BMlYB5UQ1X6vNr
 DMLzLj8DrwXy/xi71yr5Hn5Mb0qyGwmwWQgK0P1Ou4g9ocuTU6KEO3KladDBtqUI1HuzgBsWRkj
 /GXbQwmKEfjZAfSMbLmknQGSiBIv48/qi3xszquBqqXbjrNtk2X+cQIfzAVmi2tVcQttSOmkohU
 LaeL9bqdzb4sEYdu6Ep56DY5TfUgAPukoJt8kTKsNckcMDY2MFqYvY93TLVBGNBjdBWXcqBsL4W
 34VIp8NotgBrQrHCr8XpHcQRy0dNNWo/m4+67p873WCXZ4AmJ4/2b8Wj2b+niJ9ynLsPM/+j1CP
 +4Jkic171ygwA+sHtlY78bmsbrNA1h1wGqR1T0k1iBVL8yMdVq2gsfmM+LPvmU8jr7P2s3bQSG5
 HJPoN74Ngn+FLQFbEzwt9wTlLSQSp8=
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

Hi Ulf,
 Would you be ok to take this version? only minor change updated.
I think the sudden removal of pmdomain supplier is kind of an
independent common issue (exist in other platfroms too), I do not
want to addresse it in this series, see a possible solution in separate
patch here [2], or Icenowy's preference in comment[3], or whatever
way to take. Just let me know what you think..

Link: https://lore.kernel.org/spacemit/20261008-04-k3-clk-pm-aux-v1-0-8372d7307694@kernel.org/ [1]
Link: https://lore.kernel.org/spacemit/20261112-01-pm-device-link-v1-1-8932e0862378@kernel.org/ [2]
Link: https://lore.kernel.org/spacemit/b7d7ac2eee0e64aa7c267def5c2a8a022c7da425.camel@icenowy.me [3]
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Changes in v5:
- drop pm_index
- fix dev_err() to return error code
- Link to v4: https://patch.msgid.link/20261112-04-k3-pm-support-v4-0-de3931aa5153@kernel.org

Changes in v4:
- adjust Kconfig help message
- drop unused include header 
- propagate regmap_read_x() error code
- simplify spacemit_pm_is_off_state()
- Link to v3: https://patch.msgid.link/20261108-04-k3-pm-support-v3-0-b9dc0857039b@kernel.org

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
 drivers/pmdomain/spacemit/spacemit-pm-domains.c | 422 ++++++++++++++++++++++++
 include/dt-bindings/power/spacemit,k1-power.h   |  14 +
 include/dt-bindings/power/spacemit,k3-power.h   |  12 +
 7 files changed, 472 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260909-04-k3-pm-support-0bef40e87fd7

Best regards,
--  
Yixun Lan <dlan@kernel.org>

