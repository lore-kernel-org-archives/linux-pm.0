Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956186;
	b=FD9rAQ/kYcULVEPlS4Sglghtx3CGtesroc/igEvB+c7JzIy2OXjVkOlt+uPXaSIZ9r95
	 7ldJBpfZbKCHHhRgD6OjTRmATgJvVOmNuFg6jnF+uN3RP7NOTmi7gbHr6tXSVvEfe6B83
	 Ghr8dWBMr0Mxn9wVyM6UnC9TJ0on9GZs16EDMQbp7GjUj2E1ZJAIABh7RyYTgRMxbV/Wj
	 dM2uj//c6n3rKpg26wezH9a8X2khBZqZc3zyWl3Lvgnlsso1/ZF2pE62OqAAOLWHyN3I+
	 zR9QwWCPdW/s7J7Ja5nR/9Vwrvg+599D4lfetqX6MdTd5i+KNQRVS0PAFws1ZxcYYgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956186;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=/KrjoMZQWqp+zJ+I/5Z/0i9WZXMZ7iZpapqeU3pEo34=;
	b=Y3oELZuwtmYXJGANnwc+t679ib+TNDsiNYdccOFQDcoSu5SDiTZ+ad2m6Bzqd/uXoOxK
	 tWuVQGYftbtS2ZU7sdBFDYo04gSGPOmm4uBrBEAuFn6rjV+7rMYgPXMETv0AXIbSueGID
	 NQQHJ3qBqkaYCZGkbYnINdH+AYRkkFnF9WYzs3dneyO4wUxR/FD5JCHTkOvAmr+tTYA8B
	 CHuj3yCCiGeqlZdb1nlWFPKvP/zo1aCOdtYpIV/RwbzSTBZTIwJOoTvhADUrkjrQyrG/v
	 zgLNWIKtD5gRjiDEXRoDtP4mRlSS+KemvwR5jGkHQJKNU993HJdGjh9+lBMFjj9YUhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=CDTaCsvR;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D45606A32D;
	Sun, 25 Oct 2026 19:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37D45606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=CDTaCsvR
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJMjmd517433
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:22:48 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJMjmd517433
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956169;
	bh=/KrjoMZQWqp+zJ+I/5Z/0i9WZXMZ7iZpapqeU3pEo34=;
	h=From:To:Cc:Subject:Date;
	b=CDTaCsvRD0/5b8RX4QfpitsUqvyrqLWsotN9K90ScDW2a2L+M0xwdMHcEAWw3ZWa3
	 JKdiIIPMYGrxIrk7KwbH0u9L5vDSUXpii/oVeYJk1DI4JlOi8Sdl+oaAfNQ335p9mV
	 IxbyN/luo+UkOaPsDKP/Xmf0YU529nfzGj6tme/U=
From: christian.koever-draxl@student.uibk.ac.at
To: glaroque@baylibre.com, rafael@kernel.org, daniel.lezcano@kernel.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 0/3] thermal/drivers/amlogic: add S4 support
Date: Sun, 25 Oct 2026 20:22:41 +0100
Message-ID: <20261025192244.209256-1-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: () -13.0 ALL_TRUSTED,RCV_SMTP_AUTH,RCV_SMTP_UIBK,U_H_APTO_LONG,U_RCPTS_11_PLUS
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

The S4 CPU sensor is the G12A design with the calibration read through
the secure monitor, as on T7, so it reuses the T7 data on top of Ronald
Claveau's secure monitor calibration support. Without calibration the
sensor reported about -144 degrees Celsius.

Patch 3 makes the expected first probe deferral (the secure monitor
probes later) quiet.

Tool use (Documentation/process/generated-content.rst):
This work was done with the help of an AI coding assistant, Claude
(Anthropic), used through Claude Code over many sessions. It did a large
part of the hands-on work: it read the vendor kernel and the firmware
interfaces, probed registers on the board, drafted the code and the
changelogs, and ran the builds, checkpatch, dt_binding_check and the
tests on the hardware. I directed the work, reviewed every change and
the final patches, and take responsibility for them. There is no single
prompt to quote; the sessions were of the form "find out why X fails on
this board, fix it, test it on the box".

Tested on an Amediatech X98Q TV box (Amlogic S905W2, S4 family, 2 GiB),
vendor U-Boot and BL31/OP-TEE, Linux 7.3 plus this work.

Christian Stefan Kövér-Draxl (3):
  dt-bindings: thermal: amlogic: add the S4 CPU sensor
  thermal/drivers/amlogic: add S4 support
  thermal/drivers/amlogic: do not log the secure monitor deferral as an
    error

 .../devicetree/bindings/thermal/amlogic,thermal.yaml  |  1 +
 drivers/thermal/amlogic_thermal.c                     | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)


base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
-- 
2.56.0

