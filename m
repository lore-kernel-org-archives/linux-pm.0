Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9095F3ACA45;
	Fri, 26 Jun 2026 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782461536; cv=none; b=iICCCqVlkhyIUukEH2Ra8e4cAzvwD5LdeuHW3pg1D3B0IsdVB9YVEdKG6ikjRxCBss4TEtGYPnK2JQjrcV+OihVE7SvF0dDrpKKvZnwWwGPrsgiCjCxIFUEej2DnREsvREFfIO8a06fKwiFLrOQd6YWV7VjfxJ25Boma2XA3llM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782461536; c=relaxed/simple;
	bh=dlA1MiAGzdoA9HwFhEa5DIIWYNj8BhxawgGxQzmpXz8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r9b4bqUG0JwxdUWQ4XbyZ9qVmnKzc3mBAboHbsu9p9Jro/Inh3Fukxp84vsLjMhHHmOOzZivHqJ6iYehdJwiz6G/B3TUgebkg25aw1WnS687NOYoAyHc/WJuSjGtClPmQ6T8fuNsY8MB9sSse+sEUH+emko9oXlyuYe7lHjQU34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=R517p//S; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=oDuIRq1K; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="R517p//S";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oDuIRq1K"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gmpLL6WH5z9vM2;
	Fri, 26 Jun 2026 10:12:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782461530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rGnXw71gOf/NHgaS6fndCKJ/qJ+w/itmp6SAHYCMOOk=;
	b=R517p//SmtenqfjN1zHhbcvciggca4pFsRHEYQBWlaRNdm7EplIL0Ro1rcGLMmptYiZ5xn
	HPDc2RoQz8wuUfKjRVeDvqLAaLcmvwy7FYjbYxRdGGNfbPbBDHG3gLSNzmHs+CeLjYbfxi
	5z+cE9mkl0UP2prLTn+PHjGi1hdh+YAdg4C9t6eFckj3bkEeenqF7gTQNCPTNS6wPvb1hT
	+jO5i4FVdd6B9C9eDumTBj3JTeQnoyn0mWnsNCX8iNEE2n4FdziGfgXwd0Jc/Uo8hrQU/O
	Ua7xOxYuwUc4m3MEZ299Ln2hgPNsJa5W8AXJlo/k9ry9j9XVTvgW2BbvkPfuqA==
From: Shuwei Wu <shuwei.wu@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782461528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rGnXw71gOf/NHgaS6fndCKJ/qJ+w/itmp6SAHYCMOOk=;
	b=oDuIRq1K8btmISlDln+QSv3IrjaHxuJxm6HDLGaWD350z0fFNWyx9tKdi8D3BfRKlXlnzQ
	bVa5o6lbWtAK3AsuE19vEpw7XvRND6Vqy4n3sHQihkyCfZt20GCaLfFZrWClpWECGbpfkv
	jEWFVU8Y6HNlO+MNUwwCrK1ALcBzCr8xXqx0GMQd6FvdLXP4Ul7qZw9LG+cHg/qpvydz+2
	g8nPnLnGIukA5AAhBVECBllOiF/6puJF6LLeE8GoAjyG3L831fWRNbHaV/FyN8T/UA23B8
	UabWwXDv3+iyWNu5KnwcftgOxJT3mzUE/R9PIgp+iPKrXqdsiEDbYIBEAwDkeA==
Subject: [PATCH v4 0/2] cpufreq: spacemit: Add cpufreq support for K1 SoC
Date: Fri, 26 Jun 2026 16:10:22 +0800
Message-Id: <20260626-shadow-deps-v4-0-bba9831f2f1d@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO4zPmoC/22Q2U7DMBBFfyXKM4O8je1ECPU/EA9exq3VJSEOA
 YT675gUqVTwOJbO8dH9bAtNmUrbN5/tREsueTjVQ901bdi505Ygx3q3ggnNJDNQdi4ObxBpLCD
 RCmescwZ1W4lxopTfV9vT8+We6OW1SufLYzu6Oeyqsm84Kh9VMoIFQqYxovWdtZFsEkYKZrxSa
 AR9e49UiltT+uZhLRFMQxldoGOeYeSwKGBgk+4wdtJyTpspl1BmN92H4fj4v0QyhD2HcNhDzYa
 FAwfng7MYNQmtN0eXD354vx+m7arwrhBUX/20b5BrRR1iTZcpIrMVdB1K5FLIhIbrmHwNar+X2
 OUyD9PHOvPC1yl+EuzNorWBQV3EYzCBGfK/G1bTIq604uyWFpVWxLW3gSXN6C8tr7Tm4paWlRZ
 Jemet5jylW/p8Pn8BD81wVy4CAAA=
X-Change-ID: 20260307-shadow-deps-3582a78aa756
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
 Yixun Lan <dlan@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 devicetree@vger.kernel.org, Shuwei Wu <shuwei.wu@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782461515; l=4573;
 i=shuwei.wu@mailbox.org; s=20251125; h=from:subject:message-id;
 bh=dlA1MiAGzdoA9HwFhEa5DIIWYNj8BhxawgGxQzmpXz8=;
 b=dWTgFqi7U2eQZs2u7TXeO4qbCDgE9l0+DUtN+zfSnyZyWk6zUVrl2fx9x+EfjzolKWh2mufXW
 YsnC+L2ta/HCNAwwrDNXtcGmLvTo0xpCtRdRY2wZI5BHE/vIxxNY/N3
X-Developer-Key: i=shuwei.wu@mailbox.org; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-MBO-RS-ID: 8c5cd3c12b250b0ee23
X-MBO-RS-META: suke7fefyj4dz4nj3desdi5d7itrkxos

This series enables CPU DVFS for the SpacemiT K1 SoC using the generic
cpufreq-dt driver.

K1 has two CPU clock clusters. The two clusters have separate CPU clocks,
so they are represented as two cpufreq policies: policy0 for CPUs 0-3 and
policy4 for CPUs 4-7.

The CPU voltage rail is shared between the clusters. To model this with two
policies, the OPP entries describe voltage ranges instead of a single fixed
voltage, so the shared regulator can keep the rail within a range acceptable
for the active OPP constraints.

Tested on Banana Pi BPI-F3:

~ # cat /sys/devices/system/cpu/online
0-7

~ # ls /sys/devices/system/cpu/cpufreq/
policy0  policy4

~ # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver
cpufreq-dt
~ # cat /sys/devices/system/cpu/cpufreq/policy0/affected_cpus
0 1 2 3

~ # cat /sys/devices/system/cpu/cpufreq/policy4/scaling_driver
cpufreq-dt
~ # cat /sys/devices/system/cpu/cpufreq/policy4/affected_cpus
4 5 6 7

Both policies expose the same OPP frequencies:

~ # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
614400 819000 1000000 1228800 1600000

~ # cat /sys/devices/system/cpu/cpufreq/policy4/scaling_available_frequencies
614400 819000 1000000 1228800 1600000

For each policy, scaling_setspeed was set to each supported OPP and the
workload was pinned to one CPU covered by that policy with taskset.
CPU0 was used for policy0, and CPU4 was used for policy4. The clock rates below
are from /sys/kernel/debug/clk/clk_summary.

policy0 / CPU0:
----------------------------------------------------------
Frequency    |  cpu_c0_core_clk  |  Real (s)  |  User (s)
(kHz)        |  (Hz)             |            |
-------------+-------------------+------------+-----------
1,600,000    |  1,600,000,000    |    1.81    |    1.80
1,228,800    |  1,228,800,000    |    2.37    |    2.37
1,000,000    |  1,000,000,000    |    2.89    |    2.89
  819,000    |    819,200,000    |    3.56    |    3.55
  614,400    |    614,400,000    |    4.71    |    4.71
----------------------------------------------------------

policy4 / CPU4:
----------------------------------------------------------
Frequency    |  cpu_c1_core_clk  |  Real (s)  |  User (s)
(kHz)        |  (Hz)             |            |
-------------+-------------------+------------+-----------
1,600,000    |  1,600,000,000    |    1.81    |    1.80
1,228,800    |  1,228,800,000    |    2.36    |    2.36
1,000,000    |  1,000,000,000    |    2.89    |    2.89
  819,000    |    819,200,000    |    3.55    |    3.55
  614,400    |    614,400,000    |    4.71    |    4.70
----------------------------------------------------------

Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
---
Changes in v4:
- Represent K1 as two cpufreq-dt policies, one per CPU clock cluster
- Use OPP voltage ranges for the shared CPU supply
- Link to v3: https://lore.kernel.org/r/20260612-shadow-deps-v3-0-2f3ba88611ff@mailbox.org

Changes in v3:
- Add a K1-specific cpufreq driver for the shared-rail, dual-clock topology
- Use one shared CPU OPP table and one cpufreq policy for all CPUs
- Link to v2: https://lore.kernel.org/r/20260410-shadow-deps-v2-0-4e16b8c0f60e@mailbox.org

Changes in v2:
- Move OPP tables to dedicated k1-opp.dtsi
- Enable OPP only on BPI-F3 with cpu-supply present
- Link to v1: https://lore.kernel.org/r/20260308-shadow-deps-v1-0-0ceb5c7c07eb@mailbox.org

---
Shuwei Wu (2):
      cpufreq: dt-platdev: Add SpacemiT K1 SoC to the allowlist
      riscv: dts: spacemit: Add cpu scaling for K1 SoC

 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts |  35 +++++++-
 arch/riscv/boot/dts/spacemit/k1-opp.dtsi        | 105 ++++++++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi            |   8 ++
 drivers/cpufreq/cpufreq-dt-platdev.c            |   2 +
 4 files changed, 149 insertions(+), 1 deletion(-)
---
base-commit: 5164e95565d3fd508ca8a95351323f5716dfb695
change-id: 20260307-shadow-deps-3582a78aa756
prerequisite-patch-id: 154bd4f720ce5065d58b988de8f273207b44572e
prerequisite-message-id: <20260206-spacemit-p1-v4-0-8f695d93811e@riscstar.com>
prerequisite-patch-id: 5da3e75b18291a5540d4f66d7a0600fb8975ef62
prerequisite-patch-id: bcf41917414ecef8cf743095d130f6004c32f6a5
prerequisite-patch-id: cfe3800f8c791ec4c63e070af9628e88e0fc31b9
prerequisite-message-id: <20260305-k1-clk-fix-v1-1-abca85d6e266@mailbox.org>
prerequisite-patch-id: 7c7fb9f87dba019ece4c97c45750349a7cd28f3a

Best regards,
-- 
Shuwei Wu <shuwei.wu@mailbox.org>

