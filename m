Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604757;
	b=r1Xm338R3rT3iO72rMlwXBivLd9zjseNB1XuBwydNA9d1bFcO2iM7Qd4B5kEgaL8oxPl
	 oJh+nU7HZYD5BjTRr6O1wpwGtolSJbkw3qG+fisxndZC14FQzXSAN06LnSCTvMT+H1D5a
	 W4Zpj0Nw+pwVCnO+8vrF4MGqZGw28gIjik7LcFnkoPGE/Ry7pQD6M/4LqtZ/gRtUgPfS+
	 WgBphZ8OQwLBYJQwZ6Pp4o9tghFN+q8bxpAUyXu+8N984rPSjrJKOvx8aZAMN0nBGLEZ0
	 ZZsGGxD/oLcte4qEYMIM07wUt24PNylrc1Cd4UXFtrpJLHpLI4+1g7WvnCrcxFYIMdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604757;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=EzV+fpso8g6Ongle/DtSwOOu2/jdqgj459k/1q0L/As=;
	b=xnE1nKbVn6GQ9vt9DkcAuNLXp27VjVjFBYfTtpvvnU7rOrt2cBZqsXf1g2my8RP9Vka2
	 gdhmr5NnkluL6UFVP6wfWuvlnufOxREEw0LAZ8OwxpuXCbLuALJotk1kEcL66hNGuUTCc
	 AMQmjWcIiBAVeB0nxoOYfn2TGs2EqqPq6wUdPZOHtIbeGJjBVLvqwSGMXgHuUnPw8DXOz
	 qv1/iru4Yh6LdYuL8NOLyvVEW7cgAIpz+J76FqKSKi+ef5dFnpQqijDh6EjLjOPQpXGlq
	 IAVBAev3HSIu6x+qprEp40mk4lRVZNOQscqMRvzJs7NkfPFNDoMxYOl7vHZMcwwp+zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Kox7d2yN;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F71606A329;
	Mon,  2 Nov 2026 07:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9F71606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Kox7d2yN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ez
	V+fpso8g6Ongle/DtSwOOu2/jdqgj459k/1q0L/As=; b=Kox7d2yN2U1JGlVpB1
	ZScC2BPrdYH+7blEUb3mYItHrzvmQ+7GRf1NqljnAoXpLqg9xclEwS0ZUOA+jPIV
	qZV4djJPQXcIYp+0n1FLRSLKViPLjEBfXeBuSyyG7mNxB5wsIV8GlLoO8d7YOXmV
	RwsKhpQFKbh6T9aILa20ho8pI=
Received: from QD202103290168A.neusoft.internal (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCXwCdkPOhqtdkvDg--.49083S2;
	Mon, 02 Nov 2026 15:31:52 +0800 (CST)
From: Jianing Li <m13940358460@163.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianing Li <m13940358460@163.com>
Subject: [PATCH 0/2] power: supply: max17040: fix error-path state handling
Date: Mon,  2 Nov 2026 15:31:46 +0800
Message-Id: <20261102073148.1233-1-m13940358460@163.com>
X-Mailer: git-send-email 2.23.0.windows.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCXwCdkPOhqtdkvDg--.49083S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4UXry7ZF1kJw4UZFy5Arb_yoW8XF13pa
	9xCan8tr1kWw1rX3yDtr409a4UC3yfCFZrGrZ5t395KrsF9F1qqFsakFWUWry7Cw1ruFW2
	grWYqw4DuFn0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU-6p9UUUUU=
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbC+wj9OGroPGiTPQAA3O

This series fixes two independent error paths in the MAX17040 family
driver. The first keeps the cached alert threshold unchanged when the
register access fails. The second propagates an IRQ request failure,
avoiding successful binding with neither SOC alerts nor initialized
polling work on MAX17048 and MAX17049.

The second issue is specific to configurations using an alert IRQ; it
does not affect a MAX17040 running without interrupts.

Both issues are present in Torvalds' master at
6628e7d4c6b25c8d18f1345e3a20d21829aae7e4 and in the power-supply for-next
file checked on 2026-11-02. This series is based on that master version.

Validation: a standalone C harness extracts the original driver setter,
probe, suspend/resume and work helpers and mocks register, IRQ and managed
resource operations. It reproduces the cache inconsistency on -EIO and
the uninitialized-work path on IRQ request errors. All 30 checks pass
with the patches, including no-IRQ polling, successful IRQ setup, invalid
thresholds and the double-SOC conversion. Both patches pass checkpatch.

This is software fault-injection testing; no full kernel build or
hardware runtime test was performed.

Jianing Li (2):
  power: supply: max17040: preserve alert threshold on write failure
  power: supply: max17040: fail probe when requesting the alert IRQ
    fails

 drivers/power/supply/max17040_battery.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.23.0.windows.1

