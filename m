Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792811456;
	b=bD6ruIGgeJzYJbhBo9PfcQoDWVlgm8ca0yy4jTZwiJ4m23b2u3XYhMSaT4jwaJUZAqyT
	 Q8CZ+t8LuZTPCRmpLjpBVf4o9TgsyYqE7nDr6KMADofqZGrqwsU0MPRR0fHy/psk8QmAK
	 WG0O86tAa7D7LDr113uk3zhK2iF6ZQT88bKi7ikVYGtMMTLENS3h3OZIQ150hHQxsbt/M
	 9ZJCUYgICh38DlEeH3hsBLnD3eJS1XASaezoVW3vvZPO03/BggsDELn8zOCfRKM8D3dCF
	 hi3o4tLJA2UpgSsCVC137c3dUBYMNAH557mECD/ZnQAbTZz9US5gLe9pQiye4E7PPDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792811456;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Tulg8eJHROeOyIwjJdqUZ1QqGrQ/CpnxAzffMuvvRdU=;
	b=gwgBZYafC7IAScahGkVNWM1/WniHsAp8978o5UBNc/usLGfH+KR9yRAn+ZMhx/7nngcQ
	 +f3I0/LFXgZTA4AWIpEg8HQ44ict8fkG6zYIFSxIVvmh5QQ0x8dvYhaM8yR4JbTzztDFK
	 FKptw0OAacRl7N9tRajioTu+fsvM+V83S00ukcG+COaV6JQHuqUBXZqUc3tiYaFJDEE07
	 uGSQ/0j8s6LmhjvusbEi7O0+wAC6KVRgQLjOqs9z9XrNjf96ZBGg/dmIOtQrTk8DaZdpA
	 mq06tjN7xFVN7RV78T0B1ZebhVlqH5thE5Y+PkYXZsBtgc++8HzC5PTztXqe5p1nSoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fjXhuqck;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B672606A31A;
	Sat, 24 Oct 2026 03:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fjXhuqck
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792811456;
	b=ZDyYy/W2p1XJVwWrneYEOpV7or6qc7vQMqFf1JP0a0ChFjFHYYoUEeCtFzGAYeMYCqF6
	 Nmapo5fc0cuJR0ltXsUg2TFmrG+zfjToJScbK01zJsGKOfJC6SCauQuKEW0k2PIjrN3+0
	 LT15XVOUe5NBW06qBfU/DkRP2CnDhXnucu9KY6vOI+07A14aaWfJTroB4C2VOkaCVHCVP
	 iGpF1pk07v1oClys4tvecTXfEYVaXxS8+JZPAtG+DQH9zGABz5sQszN5buK/Ht1VhugIR
	 9LVOciX8H6lKEb+t1rk9RJ60buO5r0ucZuom4qIVeSF/flvP8jFoeLy1HTQE9f4/aAQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792811456;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Tulg8eJHROeOyIwjJdqUZ1QqGrQ/CpnxAzffMuvvRdU=;
	b=CX7qtXoZDO4zOyYn0R7iCCI3eSTXNCsy2uoES6CrCGnXmU5RdSfReWgKc8jce5mLagbE
	 Zo7SNh93a5icfuyV5vHjEBjBl4xFyJfPk0wnWqRChPJ8Et8b9lMWfgcZzzFe+o5EuYJ+W
	 tVNESQzklcMP5VaniCHQvHQqTLe9IkOps/E7sNo8gVTz9d2PifLA20M6qSXVmJ1Ew5BnE
	 X/s5IP0enyXHIPu5rVlHAc2DGC4sgDU7pR+p9MVYTdetFbwcmwDqlruGse4k454fKkAJX
	 So8SOJFU6MOB3lZAcx4qfTlnl8bl1lbwWVVKI6djVBbW6aRC+pwPE5LFcRJbxHIih8Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A9C591F01825;
	Sat, 24 Oct 2026 03:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792811456;
	bh=Tulg8eJHROeOyIwjJdqUZ1QqGrQ/CpnxAzffMuvvRdU=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=fjXhuqckgdE7Fo1IWQxQwh0hn6wUeh1/lquvq1TEx3lIQdRPnpjFLy94/cio/W5kS
	 Uy54olvYZnyOnVPFBgz/XP4uD4WBvK5OMe+wPwbuCuY5ZjR4sV7fbdWAGDiUuQffeu
	 OPj6r2m3RXa6vTb7d8KGAETUFZ9oC/Q9Yn6403UZaCeoAcgC8rn29zBptuPoccHN2d
	 oVVh7EUToDAm3EYpXxvq40UeVIFksydaqWEpxXUEOPpN5C/iaHMo/625Mmm5wBSUjY
	 ApcZyL87BU4q5b+fvBMhgWO2QkneX8AdK2sBUv6KQtuUlRaKSIu6PnI4fWIUnWLmNE
	 Tmft4IY1WBvQw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3E8E1446F0;
	Sat, 24 Oct 2026 03:10:55 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Subject: [PATCH v2 0/2] interconnect: qcom: Add SM7250 interconnect
 provider
Date: Sat, 24 Oct 2026 08:40:52 +0530
Message-Id: <20261024-icc-sm7250-v2-0-0e755894b188@brar.si>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0JmbU07QktceQ/DAuooYyKYDjYa0
 rvb4tblS95/fwWhwCRwrFYIFFl4njLgrgI/9tONFF8yA2q0RuNBsfdKHg4brYxta7JUm14j5ME
 z0JXfW+zc/Vhew538UgrFGFmWOXy2t2iK9zccjcp1qp03iLZt3GkIfdgLQ5dS+gIIAifTtAAAA
 A==
X-Change-ID: 20261023-icc-sm7250-1684e6e41a02
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ishu Brar <patches@brar.si>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792811453; l=2352;
 i=patches@brar.si; h=from:subject:message-id;
 bh=T3ZI7PbY0xl/jUaA5Jz6n72jWUKQk5kHlkMUrXXo5tk=;
 b=6dZp2nsH7vl7wEoTBdez3RQXd5/b+Wuf4NnW/z+D3qyI2nHrEPorEaAXmzXGuUVI/Cov9IVbf
 IEhfPy9K77kCfBj3uFLraXk7cfcxUzA2h9qTu2APTLXGz9FvNwr+01p
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Endpoint-Received: by B4 Relay for patches@brar.si/default with
 auth_id=1189
X-Original-From: Ishu Brar <patches@brar.si>
Reply-To: patches@brar.si

Add the binding and the driver for the Network-On-Chip interconnect
providers of the Qualcomm SM7250 SoC (Snapdragon 765/765G/768G). They are
controlled through RPMh Bus Clock Managers, like the other RPMh based
providers. The driver follows the layout of sm7150 and sm8250, and the
nodes and BCMs come from the downstream interconnect description of the
platform.

Tested on a OnePlus Nord (a 7.3-rc7 based tree): all providers probe,
and UFS, USB, display, I2C, serial and camera ISP devices get their
paths without errors. The Adreno 620 GPU also takes its memory bandwidth
levels from these providers (the Adreno 620 series sent earlier relies on
them). The SoC devicetree nodes are not part of this series.

Signed-off-by: Ishu Brar <patches@brar.si>
---
Changes in v2:
- Set .enable_mask = BIT(3) on the ACV BCM, like sm8150, sm8250 and sc7180, so
  that the voter sends the one-hot APPS RSC bit instead of the scaled bandwidth
  (reported by sashiko-bot)
- Drop the IPA virtual provider (qcom,sm7250-ipa-virt, its BCM and its node IDs):
  clk-rpmh already owns the IP0 BCM through RPMH_IPA_CLK, and the sibling SoCs
  have no such provider either; otherwise icc_sync_state() would zero its vote
  (reported by sashiko-bot)
- Link to v1: https://patch.msgid.link/20261023-icc-sm7250-v1-0-1e47c1226857@brar.si

To: Georgi Djakov <djakov@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Ishu Brar <patches@brar.si>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Ishu Brar (2):
      dt-bindings: interconnect: qcom: Add SM7250 RPMh NoC bindings
      interconnect: qcom: Add SM7250 interconnect provider driver

 .../bindings/interconnect/qcom,sm7250-rpmh.yaml    |   95 ++
 drivers/interconnect/qcom/Kconfig                  |   14 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sm7250.c                 | 1642 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sm7250-rpmh.h    |  148 ++
 5 files changed, 1901 insertions(+)
---
base-commit: 3fd56a2833c22f62eb84297d0dbd47739632f1a0
change-id: 20261023-icc-sm7250-1684e6e41a02

Best regards,
--  
Ishu Brar <patches@brar.si>


