Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC96F48F83D;
	Thu, 17 Sep 2026 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643566; cv=none; b=mLAouInPMKg8V0bIj+Cj1Olg+Btji+4Xe7AC0EZKr2Ebp6PfJ5W7boSwXoW7QfBAdMGX3H2EwacMg1OartAJQ6fpGlwvmMYK70gdIqjaUyPnxA/0LDF8NamGLrFq0puEKjc6Byj5MZmq94zGWia7A2NoGzePBhEhwzQtl2hozrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643566; c=relaxed/simple;
	bh=J5Pw+Bc5CVu8xuGakr343GdkX+9FY1vcnwQmHd04Hnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FDOsrs3weAEmgdq4dKXNaeUt7UOeWcdi9+2rr26FQ30ou4l/XtQy6Sr/K9mYEe3mtXcGEP1GWH+yqV3xduv0YZ/sekQGAiC86EyoAVXumg9gnsCGW6BMboTXbn++18PoDtDhbkneDBRohTaxjF4W4MH7m9QSzbslScZuFLrFbok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.112])
	by gateway (Coremail) with SMTP id _____8BxLNIcy6tq+P4MAA--.37976S3;
	Thu, 17 Sep 2026 19:12:28 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.112])
	by front1 (Coremail) with SMTP id qMiowJDxg8wVy6tqD84hAA--.44877S2;
	Thu, 17 Sep 2026 19:12:23 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v5 0/4] thermal: loongson2: Add support for Loongson-2K0300 SoC
Date: Thu, 17 Sep 2026 19:11:46 +0800
Message-ID: <cover.1789546118.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxg8wVy6tqD84hAA--.44877S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQENCGqrSnMJYgAAsW
X-Coremail-Antispam: 1Uk129KBj93XoWxJF4fKw1fXr4ktF4kXr18JFc_yoW5Gw43pa
	y3uwnxCr1DKF48AwsxJ3yxZF4Yvwn5ta9rXFs2k345uwn8Ka4av3y8ta15Zr97Crs0gFy2
	vr1ktr4kCF1DuFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2
	AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jn
	SdgUUUUU=

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
V5:
 - Rebase on linux-pm/thermal;
 - Drop patch-3 for it was applied.

Link to V4:
https://lore.kernel.org/all/cover.1785829933.git.zhoubinbin@loongson.cn/

V4:
 - Rebase on linux-mfd/for-mfd-next;
Patch (3/5):
 - Remove the operation that adds `compatible` to the `select` node.

Link to V3:
https://lore.kernel.org/all/cover.1785480242.git.zhoubinbin@loongson.cn/

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

Binbin Zhou (4):
  thermal/drivers/loongson2: Correct thermal sensor registration loop
  thermal/drivers/loongson2: Move thermal_ops to chip_data for SoC
    scalability
  dt-bindings: thermal: loongson,ls2k-thermal: Add compatible for
    Loongson-2K0300
  thermal/drivers/loongson2: Add support for Loongson-2K0300

 .../thermal/loongson,ls2k-thermal.yaml        |  73 +++++++++---
 drivers/thermal/loongson2_thermal.c           | 110 ++++++++++++++++--
 2 files changed, 155 insertions(+), 28 deletions(-)


base-commit: 5ad0af4f4367202b1bc71813052fe39b5116cdb9
-- 
2.52.0

