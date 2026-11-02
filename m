Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616776;
	b=3Nu271Tbu1JC4VUnTICdHdbfR8yzOkOHYqEYoK1dWqO0EbaU6q8ZQIp3dHhVZANZ6EGO
	 gOWQ8WMJ9lLeyO3BZh80aUTlflC6yV0gnrHfjV5TkIvZr9ttac7d7P+9AlnP76jwsYBrs
	 eKXiT//MMPnM1M337M87SzaSh10/fW+X+1ZEEveZe+a9o8g/jNbBwXAh6/fta8bUF+qad
	 XrOWW4z0KobKPDGz3S6ERAcibYvCYOlvsAO4xGXisIrb6pUIYzaBYU9DH/m89KLh9afZT
	 0z1DuzVWtQ/fXJ2+JaPDd6pJukdq332f7+DRu5d4leMarKdHX2M8ilHAPIyx85YDsow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616776;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=pF8iqEXRJ1ZbpjG6qsySNYKQRqDg6FhWZI45N4tANsc=;
	b=HLfIEYa8VMasgQ6ajYUfzrampI6cuJMA64xqaxX2LQ2GVE1SiBtwuyDGjkAcep2pSGWX
	 l+dTZ7hX7MwiS/L72E5f5Lie3XbTkEK4vq4smWJNcuQL6ECGt86RM6TnFE5VTLnL3izCd
	 YXMjmSYnWw+fAoW5YVhzLrerXsyxIpqrIEyfQAo6mhr1X+IcThmwSiozVIL3Q2cC4OKOO
	 No753EBliX1IhbeZRmlKKO5vCQHHk0T3n9ttFqq5uZPkU6YG+PHIDoIaCsYAWhHqBO2si
	 vTFs+gBUFMSo4Q/Tpe19/dmeZQZK70KwjNhsD0SXqUJLleSyHPuCShDjguursFFSE4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=A9ykuWHJ;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882FD606A335;
	Mon,  2 Nov 2026 10:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 882FD606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=A9ykuWHJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pF
	8iqEXRJ1ZbpjG6qsySNYKQRqDg6FhWZI45N4tANsc=; b=A9ykuWHJcDYzfZ++ty
	wdD7xBWf62Ud20WWETfKA+LGHj8xUDSqXJ66j7DZWN7On+q1KAzr5fKRnDpeWJcB
	HBWGynkN1o84ri+t+himifuImETfxCi1kxBdNT7kHCvbQ/ShWdDLtbEDA25k2N9y
	lS91HQfdZyJrtoE52kZHMuIq8=
Received: from QD202103290168A.neusoft.internal (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBHTpdWa+hqVQKEEA--.44730S2;
	Mon, 02 Nov 2026 18:52:09 +0800 (CST)
From: Jianing Li <m13940358460@163.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianing Li <m13940358460@163.com>
Subject: [PATCH v2 0/2] power: supply: max17040: fix error-path state handling
Date: Mon,  2 Nov 2026 18:52:04 +0800
Message-Id: <20261102105206.1587-1-m13940358460@163.com>
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
X-CM-TRANSID:_____wBHTpdWa+hqVQKEEA--.44730S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4UXry7ZF1kJw4UZFy5Arb_yoW8Wr4Upa
	9Ikan8trn5Ww1rX39rtr40kFy5uw4fCFW5GrWkt390gFsI9F4DXFZ3KFWUWFyUCw1ruay2
	grWYqwsxuFn0vFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUaiifUUUUU=
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbC3xnFAGroa1nCYAAA3R

This series fixes two independent error paths in the MAX17040 family
driver. The first keeps the cached alert threshold unchanged when the
register access fails. The second propagates an IRQ request failure so
MAX17048 and MAX17049 do not bind without either SOC alerts or polling.

The second issue is specific to configurations using an alert IRQ; it does
not affect a MAX17040 running without interrupts.

Both issues are present in Torvalds' master at
6628e7d4c6b25c8d18f1345e3a20d21829aae7e4 and in the power-supply for-next
file checked on 2026-11-02. This series is based on that master version.

Changes since v1:
- Rewrite the second commit message to describe the observed control flow
  and the fix directly.

Validation: a standalone C harness extracts the original driver setter,
probe, suspend/resume and work helpers and mocks register, IRQ and managed
resource operations. It reproduces the cache inconsistency on -EIO and the
uninitialized-work path on IRQ request errors. All 30 checks pass with the
patches, including no-IRQ polling, successful IRQ setup, invalid thresholds
and the double-SOC conversion. Both patches pass checkpatch.

This is software fault-injection testing; no full kernel build or hardware
runtime test was performed.

Jianing Li (2):
  power: supply: max17040: preserve alert threshold on write failure
  power: supply: max17040: fail probe when requesting the alert IRQ
    fails

 drivers/power/supply/max17040_battery.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--
2.23.0.windows.1

