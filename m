Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575063;
	b=bKcM4ZbCIVgT4oCR70h3WrUY/bPVDcOD5VjQbPNuAuekGF2IHHkN6g4skdl684lMuwwe
	 WFu7IoFCLqsGGzkBpQwhsGaI5WMt0NR9TaT5hTQqyOXxYeAHrtR3NsdspPnP7kseeVcbS
	 AStK4AOe/Ip9IDD/qXNiUVnN5g7UFIJVjkFqmxSqmQT6kdxLTa9wSSWONF7shbb9/lfl4
	 riI0bTg2Cz2Bs28HsH7Uqob4oe03a+RK3fifYMEz5u/AOhmVDPzNMuhHgVTpWvkXeeDMV
	 mPGl5Pu10OIn/nPN//MPNcExVJxcnopf5NpimL3pBstxvqgPO0Q7cviCcz3Waqs/vQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575063;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TvZuOBEGp6g5pnmw9dTTjksQCyQC5/R4HL7Fy6srO/E=;
	b=QeVmvyUrwEWssDHjq2MCH30Aqfwz5DQOalhWqsIGKXkVPvpAMNvo1isp7iDJsqF9R15a
	 m0RbXDDJwCjJLz6wdh5Tb2bj6af/tQRZzcEk5d4Ui/vRCA4XUUt2R8HljYwTFBdo+ik++
	 3POUFwBSmRdlorjegR4hrPWOXYqHUN/Tneci2ao9yCXquyCqGklx+x6Fs2cvqqtYUCVDg
	 wngMfCavVbLYMkHm2VCVPJvg6YxUEr3EXBEyhAbvOEU2weeYgov2j4f2sgMDQutFhzX7c
	 80M4Pv07PYrh4IaFoJUMgNQsdlpRl2c/qhpAshf7X5XIe99JfI1Zi8PK/WDSvxbnv8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="MUx87p/M";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71CA606A327;
	Fri, 13 Nov 2026 13:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B71CA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MUx87p/M
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D68D1476;
	Fri, 13 Nov 2026 05:04:19 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.0.130.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE27C3F85F;
	Fri, 13 Nov 2026 05:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794575062; bh=8uN2BgB6q2bBguiNfVfN7jbB1Uz2u4yP6PZ7F/eCnhc=;
	h=From:To:Cc:Subject:Date:From;
	b=MUx87p/MeDVSeQWQU/BxjhyWC1gp85Qj96PvnNqzTY7JgisswcUA0ZcKm3dxvzaWY
	 m8fGBKpQe+Dmo641JfcO9Zb4HPbFodU4AAsLZnNOg2qmbjL4ak1QmIRxaEetWbCO4a
	 +aTtgLC5Qp8oBb/JOCoT9TFxB40nJEid3uE22yxE=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sumitg@nvidia.com,
	luoxueqin@kylinos.cn,
	zhanjie9@hisilicon.com,
	superm1@kernel.org,
	zhangpengjie2@huawei.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] ACPI: CPPC: Reject EPP registers narrower than 8 bits
Date: Fri, 13 Nov 2026 13:04:11 +0000
Message-Id: <20261113130411.1433174-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
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

The EPP interfaces use an 8-bit preference, but ACPI permits narrower
fields. With a 4- or 6-bit SystemMemory field, writing 128 succeeds but
stores zero, requesting maximum performance instead.

Reject a present EPP register narrower than eight bits during _CPC probe.
Use the existing error path to release previously acquired resources and
leave the CPU's CPPC descriptor unpublished. Keep absent EPP entries and
registers at least eight bits wide on their existing paths.

Fail the whole probe instead of disabling only EPP. This also makes
amd-pstate's acpi_cpc_valid() check reject the platform before registering
its MSR or shared-memory driver. No affected hardware is known or
expected and the specification is expected to no longer permit these
in the future.

Fixes: 922607a2b462 ("cpufreq: CPPC: Add support for autonomous selection")
Link: https://github.com/tianocore/edk2/issues/10838
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 11a9f9eb6b4a..4c3d5778e428 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -2094,6 +2094,15 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 			cpc_apply_platform_quirks(gas_t, i - 2,
 						  platform_quirks);
 
+			/* EPP interfaces require the full 0-255 preference range. */
+			if (i - 2 == ENERGY_PERF && gas_t->bit_width < 8 &&
+			    !IS_NULL_REG(gas_t)) {
+				pr_debug("CPU%d: EPP register width %u is not supported\n",
+					 pr->id, gas_t->bit_width);
+				ret = -EOPNOTSUPP;
+				goto out_free;
+			}
+
 			/*
 			 * The PCC Subspace index is encoded inside
 			 * the CPC table entries. The same PCC index
-- 
2.34.1

