Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616459;
	b=W0qZfQdydhLdXLMLZbSNZOxy0nBJfzi9MryTHZ2HIu5sYrGdEgpCPAZOtiaaEf3LhLlh
	 g2RXYwV8czL1SFbauIZgB5tQLyc4xQGPkEfJ62pkeX8aD+qAuoldIkfRGwHA7zJm88tCz
	 JhctlrPQxio78HgExAdVQ95hTvTcw0y+dV43V9oTU5GxOrGyZBvEB0CcFxGfyyT/twGJ2
	 XwN9NtklAnZoSmqmJbQdpSGtweNUxzSnafZAzbHx2r8IX8ZTzgsRmPiIr1NkKu1Z5XiZm
	 6igRbbHmtElr1yz8q4X+jLrGVq2mEtOAqF6atoDFcgOSUiBjXiPay3qhe2x4kDy5cpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616459;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=T1xr5pi6h8Ns+FnI2LVdDxVM3EdKw4pPNmVRy23EAnc=;
	b=M85jyLkqQQMH+ou2qg1/Ua7QKA+gNCe0NgjhPGTQlgxL7MQbkeRSvd94zrbZxXPJUTml
	 S6t21zf6snr46aKbm/ah5VtFDgUI5wT22cCN2bXUukoNEG/bp3m7kC2HlJCBX90if61Pb
	 rTaWHQKYoij4jvu0lmHX1MTD4E1P6uDsj8eF9e6ZyyaLAoH32RIrvv4jxRPl6gRXmD0x8
	 QXllx4LW1hNzVcSCTq1p1rpByXvjnpmyb9ow/KBP/Qg5wKiJvpWeQxMr3UFg+1CdNlq/9
	 IbSrMtM2lmbIQQvNqMTJ1QWxmCyfJVkXVQjXC5pUzN3xYBed+8y6kME+0xQS0L1+yyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mCkAk/Gd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7227606A31E;
	Wed, 25 Nov 2026 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCkAk/Gd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91F11F000F2;
	Wed, 25 Nov 2026 14:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616458;
	bh=T1xr5pi6h8Ns+FnI2LVdDxVM3EdKw4pPNmVRy23EAnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mCkAk/GdNxPIZ7HgmankZAjGXPQHG3U0Lh3V+ungzZGHTB8/Eod+rcP8tdiajBYDw
	 H7Ffx3VYIxjdNZOMjor+dpWGpfbWLaMFf6M+CGw56uwOaUyRnoQ2vvetjwE8JzEJsg
	 DeaFA6IQWaaezZugJl7RSdlaCLhIBGRUZ0S6Eft7H15sM5BOPIIwXaP3wy7c0PYHKZ
	 japPd7fGDaGHkXQllgsL2yVKVjwdZKEMpQXfRxqMOofq60WZAMk4srHd42oKXRHJDF
	 4ouw+jaLXCCQsXfcrzdRSnFCBL6a0FlxSjWAWzjtQ6Se3KJzTx3VtHjG0UCaeLgZoE
	 UhthAtBk8NfHg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>
Subject:
 [PATCH v1 3/3] intel_idle: Allow ACPI _CST to be preferred to ACPI _LPI
Date: Wed, 25 Nov 2026 15:20:27 +0100
Message-ID: <2080993.usQuhbGJ8B@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <3986546.kQq0lBPeGt@rafael.j.wysocki>
References: <3986546.kQq0lBPeGt@rafael.j.wysocki>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Add a new module parameter called "prefer_cst" to intel_idle for making
it prefer _CST for building the idle state list when using ACPI, even
if _LPI (preferred by default) is available.

This may be useful for diagnostics during platform bringup and as a
fallback mechanism on platforms with broken ACPI _LPI and functional
ACPI _CST.

Update the documentation accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/intel_idle.rst | 15 ++++++++++-----
 drivers/idle/intel_idle.c                   | 15 +++++++++------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/pm/intel_idle.rst b/Documentation/admin-guide/pm/intel_idle.rst
index d1a6251790b8..8092807d446b 100644
--- a/Documentation/admin-guide/pm/intel_idle.rst
+++ b/Documentation/admin-guide/pm/intel_idle.rst
@@ -94,7 +94,9 @@ objects representing the CPUs in the system and ``_LPI`` processing produces a
 non-empty list of valid idle states, it will be used.  Otherwise, ``_CST`` will
 be used so long as it is present under at least one of the ACPI objects
 representing the CPUs in the system and it returns a non-empty list of valid
-idle states.  In either case, since the ``CPUIdle`` subsystem expects that the
+idle states.  [There is a module parameter that can be used to tell the driver
+to prefer ``_CST`` to ``_LPI`` and reverse the order in which they are tried.]
+In either case, since the ``CPUIdle`` subsystem expects that the
 list of idle states supplied by the driver will be suitable for all of the CPUs
 handled by it and ``intel_idle`` is registered as the ``CPUIdle`` driver for all
 of the CPUs in the system, ``intel_idle`` looks for the first CPU where the
@@ -223,10 +225,10 @@ even if they have been enumerated (see :ref:`cpu-pm-qos` in
 Documentation/admin-guide/pm/cpuidle.rst).
 Setting ``max_cstate`` to 0 causes the ``intel_idle`` initialization to fail.
 
-The ``no_acpi``, ``use_acpi`` and ``no_native`` module parameters are
-recognized by ``intel_idle`` if the kernel has been configured with ACPI
-support.  In the case that ACPI is not configured these flags have no impact
-on functionality.
+The ``no_acpi``, ``use_acpi``, ``no_native``, and ``prefer_cst`` module
+parameters are recognized by ``intel_idle`` if the kernel has been configured
+with ACPI support.  If ACPI is not configured, these flags have no impact on
+functionality.
 
 ``no_acpi`` - Do not use ACPI at all.  Only native mode is available, no
 ACPI mode.
@@ -237,6 +239,9 @@ C-states on/off status in native mode.
 ``no_native`` - Work only in ACPI mode, no native mode available (ignore
 all custom tables).
 
+``prefer_cst`` - When using ACPI, prefer idle states coming from ``_CST`` to
+idle states coming from ``_LPI`` (which is preferred by default).
+
 The value of the ``states_off`` module parameter (0 by default) represents a
 list of idle states to be disabled by default in the form of a bitmask.
 
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index fc0aea26db50..3c07469586f7 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1779,6 +1779,10 @@ static bool no_native __read_mostly; /* No effect if no_acpi is set. */
 module_param_named(no_native, no_native, bool, 0444);
 MODULE_PARM_DESC(no_native, "Ignore cpu specific (native) idle states in lieu of ACPI idle states");
 
+static bool prefer_cst __read_mostly; /* No effect if no_acpi is set. */
+module_param(prefer_cst, bool, 0444);
+MODULE_PARM_DESC(prefer_cst, "Prefer ACPI _CST idle states to ACPI _LPI idle states");
+
 static struct acpi_processor_power acpi_state_table __initdata;
 static bool acpi_lpi_available __initdata;
 
@@ -1855,13 +1859,12 @@ static bool __init intel_idle_acpi_extract_cst_cstates(void)
 
 static bool __init intel_idle_acpi_extract_cstates(void)
 {
-	if (intel_idle_acpi_extract_lpi_cstates())
-		return true;
+	if (prefer_cst)
+		return intel_idle_acpi_extract_cst_cstates() ||
+			intel_idle_acpi_extract_lpi_cstates();
 
-	if (intel_idle_acpi_extract_cst_cstates())
-		return true;
-
-	return false;
+	return intel_idle_acpi_extract_lpi_cstates() ||
+		intel_idle_acpi_extract_cst_cstates();
 }
 
 static bool __init intel_idle_acpi_probe(void)
-- 
2.51.0




