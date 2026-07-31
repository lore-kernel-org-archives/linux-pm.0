Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4DF3BC673;
	Fri, 31 Jul 2026 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490985; cv=none; b=JJsHncEnB5iaIZ61EWnoJTqomjF4ow3eMJqhiXt3Lmv8R27TWjcEM/VM3k+Zdu5gnwqGdGsWVfAQtiXrNJ6a5LFpCMNuMUy+4h3JLTYBZCWCiK4iXLU//VjGWD8qkk83ICpbf798cYvEVLYMcZYcTv1L5RVh6iL3Vkz9lfzdwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490985; c=relaxed/simple;
	bh=9PO/MiE851ATe1MubOIc99IKFY0BFwh9qQCCPBrXsuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UviTwstGG3iDjfwL5yqtDvDudt0LGYUF7shjjjcQ32crEQPyqXUEv7TpcsPN+Hmsuylpni7bY7uhJHFyIJo/WT6MfTwAQSxemZMbpoFXN3af2mr6F15R9rv/0/eld2rMEX8RPBddkqPJquqIvmkRCfVH++7hyj5AFtMfVxcrvPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.205])
	by gateway (Coremail) with SMTP id _____8BxvKEYbmxqgywJAA--.7638S3;
	Fri, 31 Jul 2026 17:42:48 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.205])
	by front1 (Coremail) with SMTP id qMiowJDxu8QPbmxqHvYeAA--.48910S2;
	Fri, 31 Jul 2026 17:42:40 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Lee Jones <lee@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 0/5] thermal: loongson2: Add support for Loongson-2K0300 SoC
Date: Fri, 31 Jul 2026 17:42:16 +0800
Message-ID: <cover.1785480242.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxu8QPbmxqHvYeAA--.48910S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEFCGpsKC8E-gAAs1
X-Coremail-Antispam: 1Uk129KBj93XoWxJrW5CFy7JFy5Kr48GF13Jrc_yoW8Kw17pa
	yY93sxCr1UGF4UAws3J3yxZr4Yvrn5ta9xZFs3Gw1ruwn8KFyay3y8ta15ZFyxCr45WFW2
	vryvkrWkCF1DuFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8svtJUUUUU==

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

=========
V3:
Patch (2/5):
 - New patch for moving thermal_ops to chip_data;
Patch (3/5):
 - Correct spelling errors;
Patch (4/5):
 - Add Acked-by from Conor, thanks;
Patch (5/5):
 - Keep loongson2_thermal_data->chip_data as const, and use
   data->flags as the private data.
 - Renmae LOONGSON2_THSENS_OUT_10B_MASK ->
   LOONGSON2_THSENS_OUT_11B_MASK;

Link to V2:
https://lore.kernel.org/all/cover.1784619512.git.zhoubinbin@loongson.cn/

V2:
Patch (1/4):
 - New patch form Sashiko;
Patch (2/4):
 - New patch for adding chipid syscon compatible;
Patch (3/4):
 - Use `loongson,chipid` phandle replace reg property;
Patch (3/4):
 - Refact `calib_offset` calculate routing;
 - Add LS2K0300_OLD_FUSE_FLAG flag.

Link to V1:
https://lore.kernel.org/all/cover.1783670011.git.zhoubinbin@loongson.cn/

Binbin Zhou (5):
  thermal/drivers/loongson2: Correct thermal sensor registration loop
  thermal/drivers/loongson2: Move thermal_ops to chip_data for SoC
    scalability
  dt-bindings: mfd: syscon: Allow syscon compatible for Loongson-2K0300
    chip id
  dt-bindings: thermal: loongson,ls2k-thermal: Add compatible for
    Loongson-2K0300
  thermal/drivers/loongson2: Add support for Loongson-2K0300

 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 .../thermal/loongson,ls2k-thermal.yaml        |  73 +++++++++---
 drivers/thermal/loongson2_thermal.c           | 110 ++++++++++++++++--
 3 files changed, 157 insertions(+), 28 deletions(-)


base-commit: 795f1b1a91ae13ebc012a364075e42f486a1cafe
-- 
2.52.0

