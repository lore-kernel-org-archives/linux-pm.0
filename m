Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6484F3EF0D0;
	Fri, 10 Jul 2026 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671924; cv=none; b=HqagVzpDCs8838mkpck2pygQ7lw0rjGep/yQGraiDMCx7G4OLPCabJm6KxTh0g6pH6Hh6KwIG7D84k7Hr/XaAE1Ry98FOLT+BsuH8AIbftD5CkBkcPIYRuVosC0y5+qv0u13yBRBs8XdUqyevzuJxzL19WzHDVQlkwdv15CwaEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671924; c=relaxed/simple;
	bh=xd3KDzAqTgFAcVfNE91ziMvZZ4Kkugvet6hKeLO7NV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n3jbwDq2UpK6t1gUBYU+Hcg09zZOkUyiDG1+vSXA3xRljDQWlOsxzKBNkRkVJ+4JRxwVd/4db1Dfij1+URVI/z1+sruQZwK7gjxQdPVc23G1/PAZ5FT99KObo3ht7aLmudPJgOh4cTJyW53dpAXE0tK40lda5Ws79p41bhRX3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.155])
	by gateway (Coremail) with SMTP id _____8Bx1+pxrFBqETQCAA--.9220S3;
	Fri, 10 Jul 2026 16:25:21 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.155])
	by front1 (Coremail) with SMTP id qMiowJBxEuRtrFBqEx4IAA--.24690S2;
	Fri, 10 Jul 2026 16:25:19 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 0/2] thermal: loongson2: Add support for Loongson-2K0300 SoC
Date: Fri, 10 Jul 2026 16:24:58 +0800
Message-ID: <cover.1783670011.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxEuRtrFBqEx4IAA--.24690S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEECGpQcs0EugAAs3
X-Coremail-Antispam: 1Uk129KBj93XoWxJrW5CFy7JFy5Kr48GF13Jrc_yoW8JFWxpa
	yY9343Wr1DGFW7AwnxJr4UJrs0vr9avayDXF4fGw15uwn8GFy7trWUtF4Yyr97Gry0gFWj
	vr1DKr4DCF1kurXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3UUUUU==

Hi all:

This patch series adds thermal zone support for the Loongson-2K0300 SoC.

The Loongson-2K0300's thermal sensor is generally compatible with the
existing Loongson-2K series, but it features several key differences:
1. It has an independent CPU ID register for reading chip version
information.
2. The raw temperature output field has been extended from 8 bits to 11
bits.
3. The temperature calculation formula has been updated to incorporate a
correction factor based on the version information.

To ensure robustness on older hardware revisions, a fallback mechanism
is included: if the calculated temperature falls outside the valid range
(-55 TO 125),  the driver falls back to a simpler calculation and prints
a warning.

The patches have been validated on the Loongson-2K0300 development board.

Thanks.
Binbin

Binbin Zhou (2):
  dt-bindings: thermal: loongson,ls2k-thermal: Add compatible for
    Loongson-2K0300
  thermal/drivers/loongson2: Add thermal driver support for
    Loongson-2K0300

 .../thermal/loongson,ls2k-thermal.yaml        | 68 +++++++++++----
 drivers/thermal/loongson2_thermal.c           | 83 +++++++++++++++++--
 2 files changed, 127 insertions(+), 24 deletions(-)


base-commit: 795f1b1a91ae13ebc012a364075e42f486a1cafe
-- 
2.52.0

