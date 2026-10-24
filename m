Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792853259;
	b=PDcr4X79V5s8fgGPtWzuU8dOtpxbomCw+JGbo2343P0TsuOovlAYPjyAPlt/8JXks1AS
	 y236245hWE46f2uITnZY7Iilgiay1PSV3oENLVMtSTkh0lCTJNhDbLmVeD0rl69X9Oz3d
	 EREQYh8Y3VCbd+cvFvGybZdCLgLz+2lK8PHarHcIT37+nVYcQWSgf57BB8Osn2tgEGYFt
	 SZrqz1krbdX45cb84j3Zy9qMdpkwTjZO0ryshctR+fDbUzUlTYFNpOo8RTP6WN4qkzVTM
	 +/PK+AKz5SzqBWWbD/Ixkpz2OCnE4R3BUi7ozJYchzN9CHv1qPQhYzg5W4AcrwPH+pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792853259;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=oTFwYNPlYqH4fydSmyNWVQUc+Q4ImkmN8RwZXxCJdcY=;
	b=2Wl7Ahpx9GmpbiDtRYzGB8zb2NEtdeMptQVEbDiNq8V8Amng+MwiFtQsX8G6iloBC0uz
	 01MnWc1/kZ8bdp8fjueaxtRVbKnMvmIBA0SwSCoHrOddve0zSuwRUYfJw6HB+ZekF/SEO
	 OtVazmdafHArAEaCZxlftZYpofbCnbDJEFtsKXONkv6K0oaD/ufa8mDXDPrAqMoTK1Lk6
	 ry+jcwNM8rMY1onGDQ9CE2javeCzeC3r7iQ0Zjc9Kd0mCAblvRhti7Oc+f66tDsv81CW5
	 JPEQyOUJVLp79lk0Ax6Y2iJo8VM3ZY4KOIr7LFk0i2ZBac8tHRfQTgWkX5/EVS4cvgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phytium.com.cn;
	spf=pass smtp.mailfrom=phytium.com.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2FE606A31A;
	Sat, 24 Oct 2026 14:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F2FE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwC3v6cHxdxqtHFHBA--.53683S2;
	Sat, 24 Oct 2026 22:47:35 +0800 (CST)
Received: from WIN-B62RPRBL2BM.localdomain (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAf8DwanUExdxqpOjwAA--.14665S3;
	Sat, 24 Oct 2026 22:47:33 +0800 (CST)
From: Zhu Ling <zhuling2709@phytium.com.cn>
To: maz@kernel.org
Cc: Zhu Ling <zhuling2709@phytium.com.cn>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] irqchip/gic-v3: Preserve SPI state across hibernation
Date: Sat, 24 Oct 2026 22:47:12 +0800
Message-ID: <20261024144720.113165-1-zhuling2709@phytium.com.cn>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:AQAAf8DwanUExdxqpOjwAA--.14665S3
X-CM-SenderInfo: x2kxzxlqjsliuz6sx5pwlxzhxfrphubq/1tbiAQAPAWrXwUoEpgAosz
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=zhuling270
	9@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCF13Aw1xKr1rAr4xuryUKFg_yoW5AFyfpF
	WqqrWFvayDJw1xtayfAw47Zry5Zws3GrWUJ3Z3G3srZwn8CFyvyrnagr1UAa48CrZ3A3Zx
	Xr1YgryUu3Z8uaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

This v2 replaces my earlier genirq/PM proposal. Please do not apply
v1. The new revision restores distributor configuration in the GICv3
driver and leaves generic IRQ PM policy unchanged.

Previous review:
https://lists.openwall.net/linux-kernel/2026/09/08/2938

Test platform: Phytium E2000Q.
Base: 17bb0e2f6c8043f70a693a5f3797471cbed354c8.
Setup: GICv3 SPI 189, level-high, CPU0 only, SATA root/swap and serial
console; disk=shutdown, pm_test=none. Serial captures confirm poweroff,
a new boot and hibernation-image restoration.

An independent module installs either request_irq() or a chained
handler on the same idle SPI. It injects one real GIC pending event
before S4 and another after restoration. It has no PM callbacks or
automatic recovery. GPIOLIB is disabled; no vendor GPIO driver or
PAD configuration participates in the test.

After-S4 results, with separate fresh boots for each registration mode:

                         hits/injected  hw_masked  pending  rescued
  unpatched ordinary          2/2           0         0        0
  unpatched chained           1/2           1         1        0
  patched chained             2/2           0         0        0
  patched ordinary            2/2           0         0        0

In the failing run the descriptor remains started=1, disabled=0 and
sw_masked=0. A separate explicit unmask delivers the queued event
without another injection or handler reinstallation. Neither patched
run needs this rescue; the SPI is already unmasked before injection.
No unsolicited interrupts were observed.

The fix saves SPI/ESPI enable, trigger, priority and routing state in
the image and restores it during syscore resume. It does not rely on
the module being probed by the boot kernel. v2 changes only GICv3,
instead of forcing chained IRQs through generic resume as v1 did.

Validation: one real S4 cycle per patched mode; ARM64 Image/modules;
W=1 GICv3 builds for ARM32 with hibernation and ARM64 without
hibernation or PM; strict checkpatch and clean-base apply checks.
Mock-MMIO ASan/UBSan checks also pass; these are not hardware tests.
Sparse was skipped by Kbuild because the installed checker is too old.

The test kernels also contain the same 8-line USB host enablement,
not included in this patch. Taint is 0 before loading the external
test module and 4096 (O) afterwards. The fixed runs use the same
Image and byte-identical full configurations.

Scope: SPI distributor configuration, not complete GICv3/ITS S4
support. ESPI hardware, PPI/SGI/LPI, deep S3, dedicated disabled-IRQ,
rollback/fault-injection, non-default configurations and repeated S4
have not been validated. No introducing commit or Fixes tag is guessed.
The reproducer and original logs are retained and can be supplied.

v1 used zhuling0805@qq.com; v2 uses zhuling2709@phytium.com.cn.

Zhu Ling (1):
  irqchip/gic-v3: Preserve SPI configuration across hibernation

 drivers/irqchip/irq-gic-v3.c | 161 +++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)


base-commit: 17bb0e2f6c8043f70a693a5f3797471cbed354c8

