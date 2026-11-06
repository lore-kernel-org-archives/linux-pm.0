Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793960378;
	b=g09/hlclGVQ3XCQ54oBI6gCT1reS0igEWOY8faLPqmFAadbtHZXVts9cOHqaD2vvliV2
	 PlGcW+J4qRv3Z4kDckjH1zvhyR6GLvkFxy/yMPXbgkYaF5QeWHD9yAUK8gKx63RRiysvU
	 rOsVOmA1uX8mLlaJMvHU9jWt2b9cq4d4UunLTOQKQfhlHe8vJAFwkQk8rgdqN7/GkBxiE
	 aASgl/+hAVXCPlMfu82ph8A/yC2a86hwAruQAP6qS3xoSWe7fvpWAb9jv+ZfqqAg4/0j0
	 bCcR4ET9VDzh4gWT7rCti7Z5qWtCwhcm7EwOiNt8QIuSWCT3iEA476GjXgHrHizzjig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960378;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=ARtDCbvM7wnTY2BVBSnKcT77iq7yVWGwS7A3lz5iolY=;
	b=Xf0/W2piZPpsMyN12tAApo1xbMmap6sTsRuyDuJLR/c7TtfwVp2LftpIMkRx5lfbiwrW
	 XZfk7XI/nB2X5EefBZS0ZTBZNrvR03/bUVMnBG9UA2dBGPeWZO/O7HjqTss7vE7/l7eaH
	 BGZBa+M4vWl9va1c07s/CT4MllZ0foFVjOpotU1oVAL4oC2iOv4kC9axqQT4DIwFm5gPG
	 H6ENoYuNX4iXbQH8W0OZ2BcIknFZXS+muuFQb9UX01lMvzgx2UQSX8MMnsvYXShndKqUZ
	 o2dv0eeb37E6IOCqDQT5ZbDBN70/r0qhRh11Vn7aZsLY91X+wMP60TeX9sc+g4gIM1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b="GsX/eEPc";
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132E606D818;
	Fri,  6 Nov 2026 10:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3132E606D818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=GsX/eEPc
Received: from surface-pro-5 (ydWLT-U1-95-184.uibk.ac.at [172.25.95.184])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 6A6AJFCU1863929
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 6 Nov 2026 11:19:17 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 6A6AJFCU1863929
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1793960358;
	bh=ARtDCbvM7wnTY2BVBSnKcT77iq7yVWGwS7A3lz5iolY=;
	h=From:To:Cc:Subject:Date;
	b=GsX/eEPc4iPvQvkA6eX4tszgiT9kL8+ZiB23z9UIGaQzhzuqhbP0O9C9smdwBnFdY
	 TdcW1lKTU0ebwdTo5IE4OiRIcGxsE2kXUQtS4PB0VUNPjjXzY1bqIj8zBEMWYrG6hX
	 jwXLwFR26SAWphze31FY+GvuEvtl8jALgJGZXV4A=
From: christian.koever-draxl@student.uibk.ac.at
To: glaroque@baylibre.com, rafael@kernel.org, daniel.lezcano@kernel.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH v2 0/3] thermal/drivers/amlogic: add S4 support
Date: Fri,  6 Nov 2026 11:19:10 +0100
Message-ID: <20261106101913.46664-1-christian.koever-draxl@student.uibk.ac.at>
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

The S4 temperature sensors are the G12A design with the calibration read
through the secure monitor, as on T7, so they reuse the T7 data on top of
Ronald Claveau's secure monitor calibration support. Without calibration
the CPU sensor reported about -144 degrees Celsius.

Patch 3 makes the expected first probe deferral (the secure monitor
probes later) quiet.

Changes in v2:
- Compatible renamed from amlogic,s4-cpu-thermal to amlogic,s4-thermal:
  as on T7 the sensor index is the secure monitor phandle argument, so
  one compatible covers the CPU and the DDR sensor.
- The binding takes the bus clock (ts_pll / ts_ddr) besides the
  functional clock, named, like T7; the driver reuses the T7 data.
- Patch 3: Reviewed-by from Neil.
- Link to v1: https://lore.kernel.org/r/20261025192244.209256-1-christian.koever-draxl@student.uibk.ac.at

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
  dt-bindings: thermal: amlogic: add S4
  thermal/drivers/amlogic: add S4 support
  thermal/drivers/amlogic: do not log the secure monitor deferral as an
    error

 .../devicetree/bindings/thermal/amlogic,thermal.yaml  |  5 ++++-
 drivers/thermal/amlogic_thermal.c                     | 11 +++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)


base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
-- 
2.56.0

