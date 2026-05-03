Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5B30FC39
	for <linux-pm@vger.kernel.org>; Sun,  3 May 2026 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777827408; cv=none; b=gxsAt6gDAf/EJ10ZMRQqzHEWNVgAW0PNiuU+b8jXhXQH4NKSdLnNFN5hanaWGGQT/8wBFxd/azzTjwbLLql/xVP6GiW5JoHowCG83oJDr9Hxr/bv5usvl8WNErGxv4iwb2nBRZPnR9k1CzaefO+bKc05lgmE8CEY17NjtW21GgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777827408; c=relaxed/simple;
	bh=s+fCfZHLa6X9SMmDSFUNu1bAbwkL7DXvsPml84Dvs5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gJgbsVRoaKdYNQqdK3OEf7PVclyB8tNvplJ63fC5Ecyojzm9rKLh7aWdCC0hhhHrNDa8ojaQt2vuvy6F74pKb31v4vUaXZkhAZbCkXYHzQxno1ktbV6W4tpDaGbyWwpqv9OBjqfRqgaB5Zp9QiqFhZy03nGroj7FVhbgDzjuy2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVlbbXg1; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVlbbXg1"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-678e678970fso4650760a12.2
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777827406; x=1778432206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=okJJ4tttwzmNc8QujxJS2i7vSuTKHRYvo6XVfeNiU1o=;
        b=TVlbbXg1xtlVSi8v/YAj+LMS7s/2Bxr6XrjSfEythoPHOjm7jwV5GMQkJ0FBqKOhl8
         9Qdfk10C/gkQJvtYtSWQkOdxe09CzblWamk8uTl/XJ6VNjLTuW7hWMkrM+znDrcj7ql3
         u4d9pohAAxg78oE1X+Xr6PDY7R6Sx2kUVg9hWSC9Y6d30RITFfbql2MhIkXbJDuJkK57
         9n9xYvpeZpbVV3GUw/rkSt9MIlg3ENO84OmfLalm0ANddjzADthbt07U59TCWwROGTBd
         /W9zg2g9XZz9fouGNPkUZEDLWEIOytNKg0+M6+nzR7T4la48EtLhkwDqZrHuCphn9OBU
         HFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777827406; x=1778432206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okJJ4tttwzmNc8QujxJS2i7vSuTKHRYvo6XVfeNiU1o=;
        b=REvilAWKmOWCiom0Gfhf7dt6Vcv4qpiDYyqHGwFUHBtlU6eTq/J12R04KEXNxrMjm7
         bSbQa9RDZTHMfXC+Q1oAt8po5mj/hN/WMIb3H62ny987muvtApXU+hUvul7VRSXuszpQ
         twsQapWfPi3w94/yNxhYfeM7FYq9ALbFsQDu5XcZ3XyWOgW73vLUeSlQcKwODoELbPQt
         7oW2vDzas3b+W1YxB3ONE4osCO/ld9DRCCJqJj/V0RJ2GDjGwL+ojOhKeqJkAHErjE7J
         jpivezhpdtnE4m85DqmiyxLNMpDVq1WThdELJqmBWeIA+ahv7N0E9K1QbRSzPpRI8Tdj
         JnhA==
X-Forwarded-Encrypted: i=1; AFNElJ90433sQJgbclqVLc0dZz+hzrV5xOBqqqMzYmIOOpP11ii5H4YwXTPuqvPpRxtBDxLC9sJ+w52llA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRdx44TeSN7Ij7jAhUU8+fsJIx0y19albFhGZscqm6DnzTYiUh
	SkkwGcQLERv1wqLMh1aXQQVPjY0FqFaZp8w8uJDmbBn445VJIl2sXGf+
X-Gm-Gg: AeBDievhQJtsufC0NnBsoQn2N8yUJwmrMkq6zsD2TNu0ijD48eU7cNhTuaN3l+vCz5d
	OfXEXNRturuaelMbMwD3gfcTEZPkxUU4ID5StOM9l7uZMpACRE3U9I95uzKW+oDs4HA6/eF5dT+
	qcIiZIEFqVJ7LzajRCcqQqCNhqZk/1EfbvTqLvbRP6qpyqIJQ4J2SZaLWE1agtA1B/1QCKgqE1M
	P1Fid34jShuxI6CqjdNlbTN38kFCYj9+VY78RKFTU4UjmHQ7lMQKe65tnwlT+xbQAs/gM1+Wp4m
	RIuB0e6+UQXN+1x3BQtJpbaNl3lvXLtSFtlzYqgy4ZwcM0HRg6SJXLEqZB9EB57A8bAbPRQ9Cbx
	M7rWJ1t2wNalRSkG1/QvOC93rAibawEeO1QGTuU2wAJbTTzZyiRItm86/AEWBDwLnFP/n2Ffkgs
	536DAvexAAijQwKsUqp9ie86c=
X-Received: by 2002:aa7:db49:0:b0:670:8b30:a897 with SMTP id 4fb4d7f45d1cf-67c181252aemr2008173a12.1.1777827405545;
        Sun, 03 May 2026 09:56:45 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b8579891fsm2713649a12.0.2026.05.03.09.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:56:44 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 0/2] power: supply: Add support for Surface RT battery and charger
Date: Sun,  3 May 2026 19:56:32 +0300
Message-ID: <20260503165636.216257-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for Embedded Controller found in the Microsoft Surface RT and
used to monitor battery cell and charger input status and properties.
Controller works both for UEFI and APX booting.

---
Changes in v3:
- fixed i2c_smbus_read_i2c_block_data read size

Changes in v2:
- srt_bat_get_string > i2c_smbus_read_i2c_block_data
- added devm_kasprintf return check
---

Jonas Schwöbel (1):
  power: supply: Add support for Surface RT battery and charger

Svyatoslav Ryhel (1):
  dt-bindings: embedded-controller: Document Surface RT EC

 .../microsoft,surface-rt-ec.yaml              |  63 +++
 drivers/power/supply/Kconfig                  |  11 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/surface-rt-ec.c          | 389 ++++++++++++++++++
 4 files changed, 464 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/microsoft,surface-rt-ec.yaml
 create mode 100644 drivers/power/supply/surface-rt-ec.c

-- 
2.51.0

