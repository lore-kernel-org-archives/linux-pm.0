Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616465;
	b=FVY/Oh9WgrK2S1StXaPFcT30dGNY/9ArCIEQ0zrpbRWqRyct+STw21dFHvg8g1+eUFnG
	 Ajl9lNl7owwIcV42qiqUQTHLEaXMMNS03SsVBvgLWDV1OGatXfjJh9NJZk0yAIbumP9hM
	 zMDI7ztrCJMHV6ARKZR36Yxs1e2Fz0VVYbD+VnfnDlPjwX2pFPgf5iNRnvejs6DNChpOq
	 FXeBdstYvQmIivZdz3GzoC30wSTRkXsGnMY5QuNNVTJRFF1WksaL+LuAQMTJ9N+5DpHUi
	 KeCzgHr8fkqNHvYFQgIdgfnozX2x1Rfvu4yF1vKuM0Ii2mUBvxVVT1cZh5YJpRzOGrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616465;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=0b3qNvi/RzKKL54w331KWsfAF8GxP4J1Qbu9HChJB2E=;
	b=jmGkadb8W525HkaUWWJgL23GbDxh27vwI9ctIYlRW3klKhTleyYT2cYoMGTFn4pRII1r
	 bhq7DdciV8IPaq7Vgdq7nt3EWW+s2tL/MJKOf49tn/b2ntR2VBaxBft320HgOlzNqQDXQ
	 tas6Rd9A0tMAP5cSlguYK1RYEet3sqvGQMLXNkOVys84HukhD+rs4fkbdfEv+0ApUGHDo
	 ZN9VEadPqMjlwxXfWvaU9se341loANpGVH48Gzs7fFEpBruTJzx6pPVqNULur76UwuU3+
	 MTCA+4YRRlURBaeKdyym2r+hFxDjqQl2MU0d3ap6HqzPePh2b7e0Re1E+wkCDqgAmHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FcLHShxP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA4C606A321;
	Wed, 25 Nov 2026 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FcLHShxP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336911F000C0;
	Wed, 25 Nov 2026 14:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616465;
	bh=0b3qNvi/RzKKL54w331KWsfAF8GxP4J1Qbu9HChJB2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FcLHShxP7E2VVR51+d5DbktFal4XoREIrzrLxmbFbg8xz/uAuTj1lrcNuSLtSXYWf
	 1k6QCugwALxvYQOn/ROyJkQO+s3VtVm4TsplSwSGh+hiGVHYj4toQveMZFmXDfFnic
	 T/Ut0MYeFwjAgy6VM7TkOpW3RFw81kQ1JoDbP3svsmbOlswiPVSwEZVMxgrGF2wjD4
	 CQIk10jgwOEe+DLlZhbUTVp7o5iATO06/0c6mHsVWWf+ryT688r/KWm9Sr+S9OXR95
	 DAG01h3fPj6PTJGVzio8pUN1vUmu2Oz/hiaTyJUbbrXHI9rKhohiESoK1mTTlm9CHU
	 0iMCHp+PGM1zQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>
Subject:
 [PATCH v1 1/3] intel_idle: Update no_acpi and use_acpi module parameter
 descriptions
Date: Wed, 25 Nov 2026 15:16:31 +0100
Message-ID: <9711169.CDJkKcVGEf@rafael.j.wysocki>
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

The descriptions of the no_acpi and use_acpi module parameters of
intel_idle only mention ACPI _CST which is inaccurate after adding
ACPI _LPI support to the driver.

Update them to mention ACPI in general to avoid confusion.

Fixes: abc5c103c66d ("intel_idle: Add ACPI _LPI support")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 9f5e1c47aba2..b8f58da277a4 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1769,11 +1769,11 @@ static bool __init intel_idle_state_needs_timer_stop(struct cpuidle_state *state
 
 static bool no_acpi __read_mostly;
 module_param(no_acpi, bool, 0444);
-MODULE_PARM_DESC(no_acpi, "Do not use ACPI _CST for building the idle states list");
+MODULE_PARM_DESC(no_acpi, "Do not use ACPI for building the idle state list");
 
 static bool force_use_acpi __read_mostly; /* No effect if no_acpi is set. */
 module_param_named(use_acpi, force_use_acpi, bool, 0444);
-MODULE_PARM_DESC(use_acpi, "Use ACPI _CST for building the idle states list");
+MODULE_PARM_DESC(use_acpi, "Force using ACPI for building the idle state list");
 
 static bool no_native __read_mostly; /* No effect if no_acpi is set. */
 module_param_named(no_native, no_native, bool, 0444);
-- 
2.51.0




