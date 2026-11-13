Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575876;
	b=YovKSnCE4kO1HNHxvJoS1W6fV/3dvLL3oj58A9D9/lj8Usav0tJssv8cErFUtM6gHt0V
	 EgAXg32ZzT1x82BhSuriO7fuQH6bILrUGyiOexjcVvUbkzFr7VXCuitvHzeDjIFWiraoa
	 zDJiNbTEfl8BCR3aI/wIlzE8OHVwtDr2Nhxqi7S4WSKTbr1Vy0j8upMgw8ggoV6G/cN8x
	 5zAWTUQZ3eoDjwNrygbE3CUkL7nwe+2L7MbtlsoVKqlFmHfrXO0/kNE9OOuer0YTRuPBI
	 LK7gL8mWRX7E0DpGH+/aLhJ6wPtQRi4LM2dHbDMw/g6nNboVKEXn4nXXdWrtSY2uO9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575876;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=Cfws8Hf9kGpQiOiS5R6isxFveVYiUdS4ZaLl56yKrkw=;
	b=gap04v3rh1umTqBPhTHJkPTvyiBWu8aKkBhM+sRQTjVr8uVzYxNMXhScV4R+wvB/I64i
	 p02hYlN5R7SPxJchalbmZb25B4w8IN+/6DgnnvGj/our2VKvaB1/lzq/kpGHHDk/dKu7s
	 mHgban3oseKFieSm2GajpwJJluEIWSrL7v5rCPYO0Pj+HT2RCT+mw7MA6DdYagvoUx4l4
	 zFRYqEmTo9svKopxtXUgUgAzd1/nbVWMmrQLt1t9G3x8//ZubhU8SIDzx6TTjq+FwVGt0
	 rO/d9Qz3GpYOf9TmGVbSjQl5W5VHYVy7Cac4Qz6N278e2SArn+k6WwHS/t29j5BNqBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVgfdjUy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED51606A323;
	Fri, 13 Nov 2026 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVgfdjUy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0091F000C4;
	Fri, 13 Nov 2026 13:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575875;
	bh=Cfws8Hf9kGpQiOiS5R6isxFveVYiUdS4ZaLl56yKrkw=;
	h=From:To:Cc:Subject:Date;
	b=MVgfdjUyBexllbXGrmV856rmqIRafRP5mWFjC1lLg/fOFBsYfwxAQcZNU9VBszz/J
	 kWj1dfZgrvkOhv30xlUyRgjg/Ji1lOLL6gmYRSNNFcf53FW5Hl9Xjl7d1MCsX70+uY
	 1meITbNAQoWqHhFbCv8dh9jE0FkjBJDwu57402lBj7quleAcmatxQZnLsrnS9DjgAv
	 IKR6mucYfFQHQ2LDWYhvKRMXNDrmr6GW+UJFZGwfADzzy1dd4QSTizDQDQ0nxqJ0yx
	 oMV1XS/5L2m/m1nDE1d4mPeTn0VWOYRLeOxIiCE1ddIS8lRMMquaJWQl2mQsNXLmaV
	 A+GQwg9nP9Apw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2] ACPI: CPPC: Drop compliance checks involving nominal performance
Date: Fri, 13 Nov 2026 14:17:51 +0100
Message-ID: <2869679.mvXUDI8C0e@rafael.j.wysocki>
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
is less than the guaranteed performance value, and it may be even less
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
+	    min_nonlinear < low ||
+	    (CPC_SUPPORTED(guaranteed_reg) && guaranteed < low)) {
 		ret = -EFAULT;
 		goto out_err;
 	}



