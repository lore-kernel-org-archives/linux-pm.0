Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724550;
	b=URd5JD8iveiE40tT7VnrfXbTxSnGZVwtFnarAmoa6hwzanB6UrpSB+DbvLgrgGkAilYw
	 pupmiB0pqNCaCf4GH7tjrWcglbhQ9TnkZaMztUcLgyT7GRrfKxu5qFD5VDZGqWLKQe+64
	 kv6veYoNRS/5p8xu/RNk3oMIYSKnolboJ1kPR495ZESRcKLEnCR6S2+76tXgWni4L0NtF
	 D+QxSI5SgowqRS0qa3J1vRsNRik9BbSMA9zmFCEychxaxUs/ADJtJdVeRCIkfKet9uarT
	 1Si7urXCdnb0Z4quqbPnYKk+NKLnyI6tOU3BS5t9ollxpmaAJ/CxwXr/DQvwqr92lXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=K8vXOpYPJvLf306yumbguV5Cmb3JESdYMT0CcHfak1I=;
	b=crFF6kXa4wpEi292nBgoAtI0g3VLk93T42tOEELd7YhIAXAMrnRLkNDe/5QkVFH1oj1q
	 BAtYJsUd4mcEdlwKKImjB3f41KiC5Pnnh4kPpQHWpKAULoq+gb1PM8ifFmdrT7gWRjMXC
	 SalbrzIqF6K2e1w1H51IZf62rluVmoTFCWpd3Ar6iNXnj9JNYpcDnTLL2mhn+pxDXKi6h
	 qZOFFWU563xsU0N2TPxVQOwhj+pIg0rpFHENY8ooiGV72Mxjt04B3dYlk2o6hP44xh2D8
	 i5CAis6IPV0QJv1nl+n7BD304sC6cbjWfMpg2e6SfU6FGevHbIja1rmH6ozETjsPGuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hte0Q+Gb;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA83606A338
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 20:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEA83606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hte0Q+Gb
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-386bd881d39so7640764eec.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 12:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795724547; x=1796329347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K8vXOpYPJvLf306yumbguV5Cmb3JESdYMT0CcHfak1I=;
        b=Hte0Q+GbMa59QI6u4BQ/Q9hH8K18WTBYFPyIGfJrBmh72Khszw2FKp5dp5cglWFHt/
         BcrcN5zXWDgv2CD/zXXteq0xlqca4nTEGXqA9Xfu7wO9Qv3CJmwWvT1xC2CrdHqvuaZA
         7Nt7XCrqa5vNmy2MBP9zZgufn8/n5SMFVddaRzoAxb/S4Tlm4+v4K3zNTp05qE0tNe6r
         udFMoLNBPgGoI4yqVM8JMEdi/+Y9YqxJ7/4RpjOk2mpxHQ/19bC/hNVN+SoKRhVVYvxq
         0FMgQ15oAMmukcUTOtYt16+/xUImXhSLLTacV8NUl9LyCEB4sp/5kpaw+TF7uTkvlRCq
         cTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795724547; x=1796329347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K8vXOpYPJvLf306yumbguV5Cmb3JESdYMT0CcHfak1I=;
        b=1unb9hLU49Cy9wscXghRvgH8xdYYzZBxIZpNAk/RsDnThwi5pgoQl0b+WTiby3EU5g
         HS8xr7/DYL1c4Cp8tBeoVyrW29UAxDqbNbGR5pOEkquo6CVTfaNQXbsIbZhbvVbVAp9f
         i+r/6Lov4xkK95rli1b7yC9s8DU/NT5U5IX+Su324bOHFtC+ZUpJ06gCzxAJj+EGqe7q
         1ZwmYF0Cv440uvtmbF4N5MsBkQraSklnhnOj+/+6Dr7vsgh/rHg6f9n7tcdlnUdgd0a5
         uyiIfMSd0yhUqp0ooBhz8R+oabdHKRKiHrMueWO3kDfEhWHodO0RJEkzGLFb0SAzjUfU
         XIYg==
X-Gm-Message-State: APuU4Z91FD6InFQOQSbTDGjb2WhxkGX1W03ZIb/MGobi0lpBNl/6Dshw
	ymR/iX93URBOorqlLwtxr5obMUv8DaPa5vHBPVAekGhAeMGC+KSnjElI
X-Gm-Gg: AZFdTZe5cyCgDSa5JfUkabm+4JlY5LZMUYIqwUUvANOW7l8qQa+Hk8TDRxv4lnXZytc
	8bDG//c7opitCWMjvQy43et1Vvj5qzUnR1oGQD4HXAcMu0gCAGRNRhNRBHV3tQUtCLG2/QRbBYI
	gMxJzryf2hY5xNAWfEHVNpsB7lUm1TRVQxgAC//1zgPVT/JGDJ49kPlMbI6LqCBmOVgfvf1szjE
	BiajAMFgQTGDQPo/CPCNfzGMm4nDqKUpX0mDfFZyrsRG3s65yqE/P2YaVhLwH6QrQDAZksoZiMg
	t2psR50vqyeDbn86YoZEyBqUa7R5CIYbovJPfe5e6Af+A4f17olwp9ltgcCbaaHLawsvLY8ZBhf
	U+8Ox+L7bAfBdhGf0GQs5Z/ZRLayo+NjLRoUvk8zos6Mteo2fjbAiQAhxmC0IZFlvhFGipYxh17
	nffud+i+tTiHjfZql4b1m3Q0mJ9js/jLNWqiTd2KeLn+wX9liOB+0klaCpWLJVZuODc2RKcZtzI
	GpplscmmkOr3hv7ij11gY39uSe0NlHR2UxEX78aLySn5xfTNIp5uefUDm9InUgzgrEjKucPzXdD
	RzV4ynChP7mLAB4NYaabNxR2QvFN1aF9tgIrbDo5QeRsYswA
X-Received: by 2002:a05:7301:550e:b0:386:e952:3455 with SMTP id 5a478bee46e88-386e952358cmr895091eec.34.1795724546785;
        Thu, 26 Nov 2026 12:22:26 -0800 (PST)
Received: from mrprachoday.bbrouter ([2402:a00:402:9f97:e752:d178:849f:9d04])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm73987372eec.24.2026.11.26.12.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 12:22:26 -0800 (PST)
From: Prachoday Sutar <prachodaysutar7@gmail.com>
To: sre@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pali@kernel.org,
	afd@ti.com
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Prachoday Sutar <prachodaysutar7@gmail.com>
Subject: [PATCH v2 0/2] Add TI BQ27Z558 fuel gauge support
Date: Fri, 27 Nov 2026 01:49:57 +0530
Message-ID: <20261126201959.28743-1-prachodaysutar7@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The TI BQ27Z558 is a single-cell fuel gauge documented in the same
Technical Reference Manual as the BQ27Z561-R2 (SLUUC54) and is register
compatible with the BQ27Z561.

Patch 1 adds the compatible to the binding with "ti,bq27z561" as the
fallback. Patch 2 adds a matching I2C device ID so the driver probes
correctly when the client is named after the first compatible.

Tested on a Kneron KL630-based board with a BQ27Z558, using a vendor
Linux 4.9 kernel with the equivalent bq27xxx changes and the fallback
compatible in DT. Voltage, current, capacity, status and temperature
read correctly through /sys/class/power_supply.

Changes in v2:
- Add patch 2. Binding via the fallback compatible alone left
  i2c_client_get_device_id() returning NULL in probe, causing a NULL
  pointer dereference (reported by the Sashiko AI review).
- Patch 1: drop the claim from the commit message that no driver
  changes are needed.

Link to v1: https://lore.kernel.org/r/20261126191906.25708-1-prachodaysutar7@gmail.com

Prachoday Sutar (2):
  dt-bindings: power: supply: bq27xxx: Add BQ27Z558
  power: supply: bq27xxx: Add BQ27Z558 I2C device ID

 .../bindings/power/supply/bq27xxx.yaml        | 72 ++++++++++---------
 drivers/power/supply/bq27xxx_battery_i2c.c    |  1 +
 2 files changed, 39 insertions(+), 34 deletions(-)

-- 
2.53.0

