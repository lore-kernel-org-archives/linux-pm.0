Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893767;
	b=ai1vqbtPEpNGERTzNAAWE4UlyB0uECulDqnRVI6SIi9sKrHv/WvgMlANgX/xV7X2a/bN
	 4SurBCV9cGc78FEHCOeudy8G10wyjFJxEMooSEUnFH6Bh5TZVIk17f7nf+o2sn2+3rrdQ
	 JS4xtHjRcTJZgeDyu8srqrk13CYm9JX1gXBDBw0oNoMkvou5BAJjftEFeeIpMNyitAvyj
	 9TPthlZGtUV1NTLzkOPCftykFWSQLf+YYkTGvlK4tDHJvBnIC4G0bHeSYujmuVClNIx4j
	 JUWLLulRR1t/AAJ0fm7mH2u450BHU7AXeVyAE6AhZ4HNo2vA0ENaNs60jbOqxGIDw/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893767;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=fbUHXct32v+OA8iZl21YZ5Jddk2BY3J3ehbC2c8AADE=;
	b=T3QXaHrgrCpbNa7ac2Ua4+27RZE1wDIK+ACfioE/pCI6TO96M3KJtilW/fx+drmDrPSy
	 lS048sbbrFQQbNRspak2ky9CrUnXtEJrgQa6zGak9cR7iNgskEcz3WPs2yP7W8fUZ33pz
	 VE339ixObbR3yq3z2CMeTei9C14lDr5qqYw7FWYemNcxfJZq+SWcovP4SN1CkDNWWbO6R
	 c9OoZk3vn79hvUTBCWj+Fr1eitH2nNHgC9jXhlEVkT8SnuAw2VFRDD+y/I1OhPpeOQpna
	 G6Qb+6XrbskLPDYCEXod9j3W9O6Eq/CBRgbSuFh+TbOsX0cdPVBvSWXRMF7v30CwnQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=POyR7vMa;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=6bdouINt;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CA660A2622
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76CA660A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=POyR7vMa;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=6bdouINt
Date: Thu, 05 Nov 2026 15:49:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893765;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbUHXct32v+OA8iZl21YZ5Jddk2BY3J3ehbC2c8AADE=;
	b=POyR7vMa3HRaF04miUBLx3CJA8Hp5a4KSOKXURBqnN8g/9DUreq8EaeYTfJNb2dqGJvO1J
	8ffy145w3ixFKCZ/GpsqyUNK8adeFjKNJ3evnLcHwJQ5i2WlOvE1cARkOxL2lfLMOOE/pD
	ZK4lZASO40OCYNFD5jSD360Kn/Eo5diJZ44WaABpPgxBM8q7rMlFss/rjtk8Q8naI946jD
	+kCUgYhj/n3PT6Z+2MsJAH+OXJ6tAUbmn42S1hazfRcPBYzvA+2h2Z6pFij8PbDOypbSx/
	h0h3ifLbCefisKxsEQ921OzIOsrQkfVRZWP2KL28qNwWdbniOVgR0zKJM4dChw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893765;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbUHXct32v+OA8iZl21YZ5Jddk2BY3J3ehbC2c8AADE=;
	b=6bdouINtsJ7I6I9d+KdRGiEsuMw+HfIdQb08KxwgdGcvZ9mhikHQm8tVkRn94lMRK4xfDl
	1QB/gB1kjSzmk7DA==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/samsung: acpm-tmu:
 Annotate lockless sensor->enabled access
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-8-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-8-0637431b7268@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179389376344.1009794.17597249664711249082.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     95580915961eca39d4f3159cb4a235f25ea301b5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//95580915961eca39d4f3159cb4a235f25ea301b5
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:25=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:51:50 +01:00

thermal/drivers/samsung: acpm-tmu: Annotate lockless sensor->enabled access

acpm_tmu_get_temp() reads sensor->enabled outside sensor->lock as a fast
path before resuming the device via runtime PM, while
acpm_tmu_op_tz_control() updates sensor->enabled under sensor->lock.
Because both accesses are plain C accesses, concurrent execution is a
data race.

Pair READ_ONCE() on the lockless fast-path read with WRITE_ONCE() in
acpm_tmu_op_tz_control() to prevent compiler misoptimizations and KCSAN
data-race warnings.

Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver GS1=
01")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20261026-acpm-tmu-fixes-v1-8-0637431b7268@lina=
ro.org
---
 drivers/thermal/samsung/acpm-tmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acp=
m-tmu.c
index 1f56c69..65be888 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -7,6 +7,7 @@
=20
 #include <linux/cleanup.h>
 #include <linux/clk.h>
+#include <linux/compiler.h>
 #include <linux/device/devres.h>
 #include <linux/err.h>
 #include <linux/firmware/samsung/exynos-acpm-protocol.h>
@@ -148,7 +149,7 @@ static int acpm_tmu_op_tz_control(struct acpm_tmu_sensor =
*sensor, bool on)
 	if (ret)
 		return ret;
=20
-	sensor->enabled =3D on;
+	WRITE_ONCE(sensor->enabled, on);
=20
 	return 0;
 }
@@ -199,7 +200,7 @@ static int acpm_tmu_get_temp(struct thermal_zone_device *=
tz, int *temp)
 	 * concurrent disabling is caught by the second check under the lock
 	 * after PM resume.
 	 */
-	if (!sensor->enabled)
+	if (!READ_ONCE(sensor->enabled))
 		return -ENODATA;
=20
 	ret =3D pm_runtime_resume_and_get(dev);
