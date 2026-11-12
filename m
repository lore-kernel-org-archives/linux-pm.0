Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504964;
	b=rOwiaiZumYVayc3Zry9pPQjvsGDBl3ZP0xibgJb4unWUe7TWMERSCVyh1PVDLc7bUJgQ
	 OXLuQf5i2Ljs4c3iui+I4EAmn/WyY6zMFYNkHmxiZm/TgzYG6IfNfbbiSg4FI+RkYgUkW
	 H2E3/YpzmX0KHiSUvHVGqGmg5G0aC1n7htOBIct81pxR6s9IZ1NodfBbSI0kywjcLxoBx
	 JPOsUNqeucyOB3xawliyXSkDe4whDWsVMBV1fuDzX+7e+Z+wIlLzc40nqxX7QORwe/Bjc
	 oC2784nxU6UMu8g1lW7d1zkwGLDLb0eONbrj/OV1BB270auOcyb78Ew27aHSPA71EmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504964;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=XhxgWrP797phjOpTexJgWgQVJECHcKMfK1ahai2mOS0=;
	b=wMeqHCf586PwMSYCsuqnbaJcZ/Cw1a/kfQfmU+Lu0ffPYvw1Wu2dcp1OCb+mFb9hhnJu
	 riWEFdqSm1K3q2c9qZD7LdtlQt0oai1J2nXk3CawhieB2Bsb1cY0d8eZqcg+grPZ6jG/m
	 eT4f2xHXXW8K58YKnGslleiebeswCkO5DIe+2vg4+GLL8oA+9jH0/Il54hU0ecVmFA5xp
	 We2uMpnPforA/HIXmy02kQ3QzmyQg4Pt/wWMgSB2bt1YMaZrPnLEznKgQGw0s+SZLeGMP
	 XV8cOZcqv0q0z9vMCuNrj+4sd99WaOoe/cjmcCBhJ0iGMO9pHc53w+c/rFGk8OJ5fBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZylkNu7s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE29606A327;
	Thu, 12 Nov 2026 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZylkNu7s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9CF1F000C4;
	Thu, 12 Nov 2026 17:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504963;
	bh=XhxgWrP797phjOpTexJgWgQVJECHcKMfK1ahai2mOS0=;
	h=From:To:Cc:Subject:Date;
	b=ZylkNu7sVJGhfrNW/PL+gVqZuwKyxtR7GS45RP5h9XAspP/r5N78f5mwobf2h3jgl
	 5Fid2pcXj7l5Q12vJmWbJfhEofNGWf44d+xbIIphXUE3zvGLDhjV3fntDVS6Gbe6hZ
	 it6+6+n6OL67PGeIA1n7MwskHRov8oGwIXJd4GXu4KvmprlZjwMYCXcB4sDn87Wemi
	 +31Qfu1OVRdiFRMUz2vIhRzQCnF6bZn0tq99DSWqZ8FDaeaATdsRkdi7uPMnMvqgcx
	 ACPC2SWmL10U5qYzbUE8Ew56Zf6tJ0zukefqik7KnEngMVgiUsN/+VjAZOxmF72tfU
	 dOpLUPGPTSBvA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1] ACPI: CPPC: Drop two compliance checks involving nominal
 performance
Date: Thu, 12 Nov 2026 18:35:59 +0100
Message-ID: <13049690.O9o76ZdvQC@rafael.j.wysocki>
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
value in ACPI _CPC (which is an integer) is larger than the guaranteed
performance value and it may even be larger than the highest performance
value (that come from register reads).

The new specification compliance checks involving those values added
by commit 32299b29a887 ("ACPI: CPPC: Validate _CPC entry and control
semantics") cause the CPPC library to refuse to work for some CPUs
on the affected systems which in turn causes the intel_pstate driver
to overestimate the maximum performance levels for those CPUs.  One
of the affected systems is Dell Pro 5 14 P514260.

In this particular case, the fact that the specification is not
exactly followed has no implications and the checks enforcing
compliance are not useful, so drop them from the CPPC library.

If really necessary, they will need to be done elsewhere.

Fixes: 32299b29a887 ("ACPI: CPPC: Validate _CPC entry and control semantics")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/cppc_acpi.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -2940,9 +2940,8 @@ int cppc_get_perf_caps(int cpunum, struc
 	if (!high || !low || !nom || !ref || !min_nonlinear ||
 	    high > U32_MAX || low > U32_MAX || guaranteed > U32_MAX ||
 	    nom > U32_MAX || ref > U32_MAX || min_nonlinear > U32_MAX ||
-	    high < nom || nom < min_nonlinear || min_nonlinear < low ||
-	    (CPC_SUPPORTED(guaranteed_reg) &&
-	     (guaranteed < low || guaranteed > nom))) {
+	    nom < min_nonlinear || min_nonlinear < low ||
+	    (CPC_SUPPORTED(guaranteed_reg) && guaranteed < low)) {
 		ret = -EFAULT;
 		goto out_err;
 	}



