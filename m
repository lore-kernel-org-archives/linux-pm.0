Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211718;
	b=H74tcdfDNhVEw8+YuxNUSxb3J8Vc2vYGjkdh1wTDNGzvf2CM4L2R9AaQrFrk25O1RUBV
	 ZlqJ9ZZJ7L+bsvjzo6juZVutnVBHf6p++kRks/QMdl4ZZVQzpgZEFvYZRFI1N9Bg3g2Iw
	 gQ3lxuzh/1KtDmecndj8OxoLRlpqC5J6qJxJ1c/5C6SlcUaGuQGpUirA7VtqSWXE8UpKk
	 XC08x5lPT+BNJQltN7lCIDkAwGGlEzvT7u4lcM8IF/rPWv0Hc1f4Q1aNyKthZxKAJSmzT
	 y3qOxxaPNLIhagB9JQedxwkAe5dxg0IMgCDsXuLp24wtFOXsmsJOtuDbp6CjEPHU1QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211718;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=Ux/zH2eSKuK+chXZyJ1t8r33Q2S7GEJ5ITkj8yH25OI=;
	b=Tr8JPftxN5FVRw0DDsLrZ8scF7YbbcuPuL36WhvACaxK/cGsFlo5E6vGPVYbIvlhTKRg
	 75XKqwE/0XKRaRhWEOx2XOWs1dsr3w8ThfmtdOZgu4Y/8w3rlrcTh1g1Stn76ZFjf8LKj
	 GHyGvR0Vi1YJlvEQZt58LTd4jL4sct1Jdsyn4BI1aAVLZAKs15xtm0JS45EFnsbVv+TQv
	 QQ/nxNcpgD34W4DAdz92jSeYyKra+FGsv30NbwkLq5xSsnlUtXrPeH6Hwdsy0n+HKqPfc
	 jhMA4RAmsaa6Z8vRC2PZIi+34Q6sM8O7PZEccfwv3xSZJmOzWObbfit8CKnhcIdfdNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C707606A321;
	Mon,  9 Nov 2026 08:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C707606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8BxhvCCf_FqZb8dAA--.19964S3;
	Mon, 09 Nov 2026 16:08:34 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJAxmM15f_FqWiQzAA--.37920S2;
	Mon, 09 Nov 2026 16:08:26 +0800 (CST)
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
Subject: [PATCH v9 0/7] thermal/drivers/loongson2: Fix trip programming and add Loongson-2K0300 support
Date: Mon,  9 Nov 2026 16:08:15 +0800
Message-ID: <cover.1794211535.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
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
X-CM-TRANSID:qMiowJAxmM15f_FqWiQzAA--.37920S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEGCGrxKfoDLgABsq
X-Coremail-Antispam: 1Uk129KBj93XoWxtF48Zw4kJFyxZw4fGr1kCrX_yoW7Zryxpa
	y3uwn0kr4DWr48JwsxA3s5ZF4Ygw1rtrZFqF4Sk3s8uan8GrWav3yxtan8Zr9rCrs5XFy2
	qr4kKr4kCFWDCFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUc9a9UUUUU

Hi all:

This series fixes trip-point handling in the Loongson-2 thermal driver,
refactors the driver around per-SoC chip data, and adds support for the
Loongson-2K0300 thermal sensor.

The first three patches are fixes and are marked for stable:

- Patch 1 fixes signed division when converting negative milli-degree
  trip points to degrees Celsius.
- Patch 2 fixes the arguments to clamp() so trip points are limited to
  the supported sensor range.
- Patch 3 fixes Loongson-2K2000 trip-point programming by adding a
  per-SoC register callback and handling the split HI_GATE register.

Patches 4-5 are cleanups and preparation work:

- Patch 4 removes the unnecessary multi-sensor registration loop.
- Patch 5 moves the per-SoC ops and hardware initialization into chip
  data.

Patch 6 adds the Loongson-2K0300 DT binding, and patch 7 adds driver
support for the Loongson-2K0300 thermal sensor. 

The patchset have been validated on the Loongson-2K series development
boards.

Thanks.
Binbin

=========
V9:
- Add Reviewed-by from Huacai, thanks;
- Fix issues reported by Sashiko AI:
Patch (3/7):
  - extract gate_lo with FIELD_GET(GENMASK(7, 0), gate) before FIELD_PREP()
    to avoid the __BF_FIELD_CHECK_MASK() BUILD_BUG_ON();
  - disable INTEN while updating the 16-bit gate to prevent a torn
    {old_hi, new_lo} threshold from latching a spurious interrupt.
Patch (7/7):
  - add depends on MFD_SYSCON;
  - delay after writing LS2K0300_THSENS_CFG_REG to avoid misdetecting old
    fuse on a premature OUT_REG read.

Link to V8:
https://lore.kernel.org/all/cover.1793690276.git.zhoubinbin@loongson.cn/

V8:
Patch (1/7):
 - Use MILLIDEGREE_PER_DEGREE macro instead of explicitly casting MILLI;

- Split patch-4 into two parts: the bitfields section will be merged into
  patch-3, and the remaining changes will be merged into patch-6 as
  preparation for introducing the new SoC.

Link to V7:
https://lore.kernel.org/all/cover.1791512067.git.zhoubinbin@loongson.cn/

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
 - Add the necessary comments.

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

Binbin Zhou (7):
  thermal/drivers/loongson2: Fix negative trip conversion in set_trips
  thermal/drivers/loongson2: Fix clamp() usage for thermal trip points
  thermal/drivers/loongson2: Fix Loongson-2K2000 trip point programming
  thermal/drivers/loongson2: Simplify thermal sensor registration
  thermal/drivers/loongson2: Move per-SoC ops and init into chip data
  dt-bindings: thermal: loongson,ls2k-thermal: Add compatible for
    Loongson-2K0300
  thermal/drivers/loongson2: Add Loongson-2K0300 support

 .../thermal/loongson,ls2k-thermal.yaml        |  73 +++-
 drivers/thermal/Kconfig                       |   1 +
 drivers/thermal/loongson2_thermal.c           | 383 ++++++++++++++----
 3 files changed, 355 insertions(+), 102 deletions(-)


base-commit: 4358090906b01806ee483229e8d7163b806bd116
-- 
2.52.0

