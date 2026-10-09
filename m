Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779011E1A3D;
	Fri,  9 Oct 2026 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514645; cv=none; b=bsLHM66r4kezI1zumiqp+iKPkJWprXqhXswW1elfKtp8hFNegl+VdUrSU7gKbKQdDnKh/n5QNFjnPdbVrmyphbAXCc9OolJvNtLPfsOpNZzzjNBNRaUCHJuomPLCYH/+6LV4JNUOsJB5WSvHFlbB7PJJgR0Y1MfCJH8s6pKVMqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514645; c=relaxed/simple;
	bh=0W+5BfsugaykrEkYYj3Ij3eiPQEQnrO2tdkT+wrnnpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=str7xDRrbkPnyvXpYtEjkB7UCXtBipoGB8TKh+whMLCdCDWf3ED/FFJJUce84S0gs4QYoH4Jfmviprc68809x/wMA5Jz5ZK4eRlqRPd5k88unv0qLvPxz3O9L9Pe8KXFQ6oeRT6k7lKgly1nrS4LYx9fDQ7A3dND8Oh5fgBiVE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.159])
	by gateway (Coremail) with SMTP id _____8Cxf9MRWMhqAPwTAA--.58391S3;
	Fri, 09 Oct 2026 10:57:21 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.159])
	by front1 (Coremail) with SMTP id qMiowJAx2c0KWMhqikwqAA--.24079S2;
	Fri, 09 Oct 2026 10:57:16 +0800 (CST)
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
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v7 0/8] thermal/drivers/loongson2: Fix trip programming and add Loongson-2K0300 support
Date: Fri,  9 Oct 2026 10:57:03 +0800
Message-ID: <cover.1791512067.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx2c0KWMhqikwqAA--.24079S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEPCGrHCfokSwAAs1
X-Coremail-Antispam: 1Uk129KBj93XoWxtF1kJw15WF4fJw4UXFW3twc_yoW7AF1kpa
	y3uwnFkr4DGr48AwsxJw4rAF4Yvwn5trZFqF4fK3s09an8Kryav3yxKa15Zry7Crs5XFy2
	qr1kKr4kCF4DCagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxU2MKZDUUUU

This series fixes trip-point handling in the Loongson-2 thermal driver,
refactors the driver around per-SoC chip data, and adds support for the
Loongson-2K0300 thermal sensor.

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
(-40 to 125),  the driver falls back to a simpler calculation and prints
a warning.

The first three patches are fixes:

- Patch 1 fixes signed division when converting negative milli-degree
  trip points to degrees Celsius.
- Patch 2 fixes the arguments to clamp() so trip points are limited to
  the supported sensor range.
- Patch 3 fixes Loongson-2K2000 trip-point programming by adding a
  per-SoC register callback and handling the split HI_GATE register.

Patches 4-6 are cleanups and preparation work:

- Patch 4 removes the unnecessary multi-sensor registration loop.
- Patch 5 replaces open-coded bit operations with bitfield helpers and
  splits the per-SoC thermal ops.
- Patch 6 moves the per-SoC ops and hardware initialization into chip
  data.

Patch 7 adds the Loongson-2K0300 DT binding, and patch 8 adds driver
support for the Loongson-2K0300 thermal sensor.

The patchset have been validated on the Loongson-2K series development
boards.

Thanks.
Binbin

=========
V7:
Patch (1/8):
 - New patch;
 - Fix negative temperature conversion in set_trips;
Patch (3/8):
 - Use writew()/writeb() in loongson2_2k2000_set_trips_regs;
Patch (4/8):
 - Rewite the thermal sensor registration loop to clearer;
Patch (5/8):
 - Fix `loognson2_thermal_set_trips` typo;
Patch (8/8):
 - Read CHIP_ID1 only when EXTERN_ID is set;
 - Simplify the Internal ID calculation;
 - Add necessary comments.

Link to V6:
https://lore.kernel.org/all/cover.1790561983.git.zhoubinbin@loongson.cn/

V6:
 - Rebase on linux-pm/thermal;
Patch (2/7):
 - New patch;
 - Fix incorrect clamp() argument order for thermal trip points;
Patch (3/7):
 - New patch;
 - Fix Loongson-2K2000 trip point programming by adding a per-SoC
   set_trips_regs callback and handling the split HI_GATE registers;
Patch (4/7):
 - New patch;
 - cleanup: use GENMASK/FIELD_* helpers, add named constants, and factor
   common trip point setup;
Patch (5/7):
 - New patch;
 - refactor: move thermal_zone_device_ops into chip_data and replace the
   Loongson-2K2000 flag special case with an optional init_extend_resource
   callback;
Patch (7/7):
 - Updated the 10-bit output to 11-bit in commit message;
 - Temporarily remove the implementation of `set_trips`;
 - Remove unnecessary header files;
 - Rewrite `get_temp`, separating `read_calib` and `detect_old_fuse` into
   new functions to be called during the probe;
 - Use macros to define the relevant numbers.

Link to V5:
https://lore.kernel.org/all/cover.1789546118.git.zhoubinbin@loongson.cn/#t

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

Binbin Zhou (8):
  thermal/drivers/loongson2: Fix negative temperature conversion in
    set_trips
  thermal/drivers/loongson2: Fix clamp() usage for thermal trip points
  thermal/drivers/loongson2: Fix Loongson-2K2000 trip point programming
  thermal/drivers/loongson2: Simplify thermal sensor registration
  thermal/drivers/loongson2: Use bitfields and per-SoC thermal ops
  thermal/drivers/loongson2: Move per-SoC ops into chip data
  dt-bindings: thermal: loongson,ls2k-thermal: Add compatible for
    Loongson-2K0300
  thermal/drivers/loongson2: Add Loongson-2K0300 support

 .../thermal/loongson,ls2k-thermal.yaml        |  73 +++-
 drivers/thermal/loongson2_thermal.c           | 359 ++++++++++++++----
 2 files changed, 332 insertions(+), 100 deletions(-)


base-commit: ec0d89150a9381d591344a9f6f5428655c227a7f
-- 
2.52.0

