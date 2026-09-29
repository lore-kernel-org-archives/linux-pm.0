Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76244538D69
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700753; cv=none; b=hhjBfcexdRq3yXg0NO1OUsfQpSDGkyzeecwtmlF0cmMEj6j7KEwfQPa3tbrLATyNGmtgRUBcVxHnvkuBzvcvhdKKI+q+SVbiCHXTy5DAO9r+HI73mLmP3tgJMsBHzMDbucAOjioqnQigaiUCveKQ0Tmkjbgk0HrxrnM5YJysQ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700753; c=relaxed/simple;
	bh=Cnfv+3Oyg0thjSFdj6bj6qA4t9kGvvD9MItwbmBEmjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A1P4M7iFPoW7j6oexvFss2WVySUiK+GEzgr7H74Cs8ueafR105T99r9QiS5D7rQCq6BcFGTGjspOkxRYh1X7k7LWNACQH6nOV1wfAosaLslYgISz/AtRkMFQz+G6YkV4okHJdu/igGKeDJ+MwAQdYmLA+rCsev+7CnMS5qXg6Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pp4Gx75Z; arc=none smtp.client-ip=74.125.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pp4Gx75Z"
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a77141826cso768461fa.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790700749; x=1791305549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yjghGFxddp+hgpedfnq3QLkecvvYVf/Hl+33N5EPzS0=;
        b=pp4Gx75Z5t5rjXLgUzjcwFerW/CGlffQsbllhqqpG+24ILjwyPSYu+LjVcs0L2Ad2z
         NWIFy3kVjn8nJKIvJgS5rASHWCfeNs0Nerpw4sKDCpgonrwpbvR2UtIPensFsubeurUf
         WY5aWsKf3V5dpzydtoRGWRBtqEIN4YPos4aXV9muD3cEAReS2tew8V98TjidPBQ/3kTg
         9kgb8BD5Bn0lnW9mLgWO5ow6uL84AfDYw3/qrHOFv2p0ZkzpvERrq7oGLJJ/OZYG37yu
         jhEJOXMGJdym/G3QNTM97rTxNeAYCpUBq4fzh2Fsy5MP20v8oFiePchOAPsuEH+F/6eZ
         HbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790700749; x=1791305549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yjghGFxddp+hgpedfnq3QLkecvvYVf/Hl+33N5EPzS0=;
        b=MvtpJ/LB/Vqot0vdcopauQ262jtjfjRSolbE/7sNPdtWQSNrTM7op0/xmiH6oZEsMg
         8Wehg1glBPcpu99Ar16xbAGfRtZFNmDStsqLaowbWNvAmfsUaCacjlcZfeDa3Vrg2jAJ
         YzUmaUk9Jh+8rC6r0YuSZdBadXmFV7hUrJwAfZ3e9c4hx111nXwAta5yAZJqae6VpRlt
         iPniJCYRbJcHlxYrwU5jsNeboE9a9c63GjuuX0ms0AMUApqKVrX9Sd9XydF+DVnS2Uss
         m7GMiFIpBnJ5OIH5AdGI36k/vYb0OT2yySofD4bm6hLbOkJN0+e/BidCfDdfWxWJb4KX
         s3kw==
X-Forwarded-Encrypted: i=1; AKwUvBzaIVXDwn6aYqvLilK7QS4myzil+94QZwZSwF4gMItbTrp4l4q3xRoXMM3IQyUaKKowbQEFA8mwSw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIkmJ/OMMUmO1Zhf4Y7FhRMvYYozDglCJq8s6BZr7M+8hhiXCoU
	glAeY4L3mu3nh4TWdq3cy9h56XolQEmedXN+3QO9kP1OAqLtZMU+Hf8=
X-Gm-Gg: AYBFou2n32lIYMPcKYRnm+HpFe7lIckS+tBi1A0GpNQZug+zu/oDPuQWaTwqgB9pSme
	cjBtBPwsPo5CW3EeTphvBele8AaR68lmfu3jc7Nu12MtrUSW/z+74zI5ThBQEBYh/yJtUPgzCvR
	DizYG4B4PWMVz+1+0dv/ER2XOCL34bXDUf4BcS3opeSRrjh2uFbO0B21qq4UKMDUZGLAuNjc6ur
	p+POQtqlaB+lEo1IUwgnKtC2v7z1EaafpjiHop/tp2raCzrMBLyYWtcVPLfx0QLsmPCWBPFdi8a
	aRqEcYq+wO7IU7aD+fup9e6wJAJs63zorIcXdTnUqo5SqwebNi9w1Kza2cDYlWsYgxuvonT3Sfo
	IkXePJXQtfFI9GeJDDnJLIRcWIMe0icYyJLR0VaPxDfJE71o/Aei+RfSAIO974ugaOoakUk4sGR
	3TZtDrsoux9hjkA6RjHGXeVPF6qdyVl72vHbqsrZKkSUHr2bsXV0deju2D93ZT
X-Received: by 2002:a05:6512:6891:10b0:5ba:3b9c:ff70 with SMTP id 2adb3069b0e04-5ba3bee0c5emr25354e87.30.1790700749263;
        Tue, 29 Sep 2026 09:52:29 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a771947b14sm137751fa.32.2026.09.29.09.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 09:52:28 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH v3 0/4] thermal/drivers/airoha: Fix AN7583 mux mapping and expose all sensors
Date: Tue, 29 Sep 2026 19:52:05 +0300
Message-ID: <20260929165209.69669-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AN7583 support merged for 7.3-rc1 reads the wrong mux positions: the
mux field names are swapped, and v5 of the series swapped the call
arguments to match them. Patch 1 fixes the field definitions.

Patch 2 serialises mux selection and ADC sampling.

Patches 3 and 4 add one thermal sensor cell for AN7583 and a zone per
sensor.

Tested on a Nokia XG-040G-MF (AN7583) with this driver on a 6.18 kernel
in OpenWrt. Without the series the board powers off 2.6 s into boot.
With it the three zones match direct ADC reads, and concurrent readers
during CPU frequency changes gave no failed read and no shutdown. EN7581
was tested with equivalent changes on a Nokia XG-040G-MD. Build-tested
on arm64 with W=1; the binding passes dt_binding_check.

Changes in v3:
- Patch 2: say in the commit message that the race needs the zones
  added by patch 4
- Patch 3: add Reviewed-by
- Patch 4: shorten a comment
- Rebased on thermal/linux-next

v2: https://lore.kernel.org/all/20260915191131.25214-1-sochnev.v.74@gmail.com/
v1: https://lore.kernel.org/all/20260913145226.34643-1-sochnev.v.74@gmail.com/

Vitaliy Sochnev (4):
  thermal/drivers/airoha: Fix AN7583 ADC mux field mapping
  thermal/drivers/airoha: Serialise access to the shared ADC
  dt-bindings: arm: airoha: Use one thermal sensor cell for AN7583
  thermal/drivers/airoha: Register a thermal zone per AN7583 sensor

 .../bindings/arm/airoha,en7581-chip-scu.yaml  |   3 +-
 drivers/thermal/airoha_thermal.c              | 159 ++++++++++++++----
 2 files changed, 126 insertions(+), 36 deletions(-)


base-commit: e856ca3013b3074fd07cb81c90b1de332f69153c
-- 
2.55.0

