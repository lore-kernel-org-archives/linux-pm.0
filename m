Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580145;
	b=PWyiupPCM/aNEfxBUbytD0PicMm011Ka/AE0/lEhc7Zx6SGaKCfsNMGPFWuH96mAOIo4
	 YTuX7PoJZxqrnOlhfYsHNv5aX+u7BX+RPOy5nL57eyGz7D5r5ZOpmfkR3EZ6lVmBCRBa+
	 hg34xMqGAxq+RGO6iI0ffitiogWPK+9mSO0RBqP/5InZMKu/vypvCZWpb1qstZJO4Y7HK
	 0SbvKIO485id8QwKKxE9XFQxqIHNy1D1j2/8juOTrlO0zxd39xVd6ba/148UAmbSx4XDD
	 kCHILCXL2kzvL8ctvhCUPB8fjo9zOURrOy0yuznIgB4Rym0Fhxf095dZ6nNsqk9QUuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580145;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=ah38blLA4LkY3qwnaluR3CN6L09sZvQIHQwHdJmqgws=;
	b=BNUFQd1SF93JiNju48MKsff0juYa0hGvc2CalZCDXnfzcRQBscO3zf/Z0hS5jRs5gnxO
	 xdeF6++wBiG4VZPzboo0R1pc5cgku2q5I/igLyKSHN2E8RGkdECZqCPNB76oz/vkLyXpt
	 xXy7xpOrKXPvjfv/kqXpWzclxr106dN685qXJjW1GpEWFreA4+1K/AANvdpdwsOB2gRVC
	 MHthO/98bc1RpnhbKnMCH+LZo4xHvHoe10bBFfahiFhZPOd0Lr2v1/I/1U21BGiVklaIt
	 dLzTfNQGgE2beeC2/VNxLV955dg9xjTlb6quaEY03iKc/oE1WPK2GF8buJuOgWN/UGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lnPgRQuG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4B6606A882;
	Fri, 13 Nov 2026 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lnPgRQuG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACF71F000C6;
	Fri, 13 Nov 2026 14:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794580145;
	bh=ah38blLA4LkY3qwnaluR3CN6L09sZvQIHQwHdJmqgws=;
	h=From:To:Cc:Subject:Date;
	b=lnPgRQuGknLzVDJ0IED5TjbiFTYdEO89BrLncuSEWkGkHm5qs1O9vwa1zLt+C+38H
	 dgX4ydZbikGHSgQhFhhwIW+8qta8f2qFWQXcS3fthUoB5lWeudJOgFby36G6yqjhe1
	 zU9FpIz3OFruLIwot0nF9svXU5RaTki03FRax01pcNbmKcysNa0F3JLZoBHq/6l/XV
	 g1AmD/CcmXolzxAtma28ZKj1XnK8ksHVOMd7OKrjH7gquVFu/YHc9+1b/k4bm5B3FE
	 vdPECcatlgNpbpIXdPOMnAyetGuHoQkZpvSJPKLBQnTdEdrvUOF5xbsbxVtu0M0N5y
	 t/MbXMqn7IWhQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v3] ACPI: CPPC: Drop compliance checks involving nominal performance
Date: Fri, 13 Nov 2026 15:29:01 +0100
Message-ID: <6060382.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
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

On a number of Intel platforms in the field, the nominal performance
value in ACPI _CPC (which is an integer embedded in the _CPC package)
is less than the guaranteed performance value, and it may even be less
than the minimum nonlinear performance value or greater than the highest
performance value (that all come from register reads).

The new specification compliance checks involving those values added
by commit 32299b29a887 ("ACPI: CPPC: Validate _CPC entry and control
semantics") cause the CPPC library to refuse to work for some CPUs
on the affected systems which in turn causes the intel_pstate driver
to overestimate the maximum performance levels for those CPUs.  One
of the affected systems is Dell Pro 5 14 P514260.

In this particular case, the fact that the specification is not
exactly followed has no implications and the checks enforcing
compliance are not really useful, so drop the checks in question
from the CPPC library.

If really necessary, they will need to be done elsewhere.

Fixes: 32299b29a887 ("ACPI: CPPC: Validate _CPC entry and control semantics")
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Sorry for the quick turnaround, but Sashiko has made a good point that
the ordering between high, min_nonlinear and low, and high, guaranteed,
and low should still be checked:

https://sashiko.dev/#/patchset/2869679.mvXUDI8C0e%40rafael.j.wysocki

---
 drivers/acpi/cppc_acpi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -2940,9 +2940,9 @@ int cppc_get_perf_caps(int cpunum, struc
 	if (!high || !low || !nom || !ref || !min_nonlinear ||
 	    high > U32_MAX || low > U32_MAX || guaranteed > U32_MAX ||
 	    nom > U32_MAX || ref > U32_MAX || min_nonlinear > U32_MAX ||
-	    high < nom || nom < min_nonlinear || min_nonlinear < low ||
+	    high < min_nonlinear || min_nonlinear < low ||
 	    (CPC_SUPPORTED(guaranteed_reg) &&
-	     (guaranteed < low || guaranteed > nom))) {
+	     (guaranteed < low || guaranteed > high))) {
 		ret = -EFAULT;
 		goto out_err;
 	}



