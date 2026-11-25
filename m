Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607961;
	b=XOv//pPokA65tW6dRAS2Q1x3ArE7Nt7n3FaDbP4t4eGAhSy7RosZdRsPXI7YqJHm4J3g
	 IXxkGAbuPpDiPpaXdZxDmUOLvYT3v4nqcKSHaqeEDQmjEHJmMqMK6oFp7zCi9tjTBFIJJ
	 et1KesNE/fA7YGw2FoThuUz5yVr10IxZxk7dG1xpbWcgD57TUWuwJIQuqcm5XHypzQGhW
	 qZPZCcR3CvzqnvULZFGIzi1yjrKGdh4MuPEMnVsPJbWRqXWpA5ziM+ME4LvbW//cSO2Ae
	 xaI6NKGCZs1p/cafrh7AGpU1XYwkkWJ85+vEwj4P0d5ekMjDfCZwfAR4iMR1JsRcuQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607961;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=ktTGWXLaSiL+G5/vWQgvX0SB5ltKHHwYstClmRvBzOk=;
	b=R9YmkiBSZH3h24ztW9GZ3s0YL66NBm70/zTSyeGikswKMJUS23/RNgMomkd+G49YXHYv
	 9e56jooWKYbE5zW1rBqp0PW3XWK8UhF61tiRVfvtU/60zY2DyHIDzyrn4ifHy70+Fgyu2
	 15T3yH961BaHGLv53VcuD5405nLoQuSP0FICgblbSUh5Tuc6eUdrf6I0MHhkJJ2WBXTI9
	 1kflVcwSJrzpzcSkT1Fwemmf0y0mb2z/ISy4MMG4EewW2nrcRXdknI0zle6MbxfFmm0gb
	 KC3D9AYprj/vPLlXZbj4krPfXo6nbaivTPTPsvY2qcLauLhgvbTUrbJwhlNcYpho8Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wq9H0mdu;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=JaHRk023;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B047606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B047606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wq9H0mdu;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=JaHRk023
Date: Wed, 25 Nov 2026 11:59:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607959;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktTGWXLaSiL+G5/vWQgvX0SB5ltKHHwYstClmRvBzOk=;
	b=wq9H0mduBpOT4EVRHYLtKniMhDTgPVhYc0hbHhSGJU16OlC578Q1Dr5fJvAxsbXR1bwHqL
	Ccivkf6TpCYdlnvdTm58vHrscWHBCJ6ORjH+R7B/bPs6TkR1rM8QH1wjIjCGjKP9eolSal
	OfeGV4d3ILVn5jBbn0L9gSSrzDZK2MVeER1qSLXRgpWKay7Y0dYr++nT96F3xT//D/n+pS
	FNZStBQYJs6OIKsnYUcotn8+vrbXPg7XdQr+vueoBhQD9zG9DaD9tKrEpZ7G9ffLjwqwhQ
	cSKW366DjlWjebTC9yLLdPgrKHA5gkPgVenM9OX+KeALUW/DSWQO094YDFaOfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607959;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktTGWXLaSiL+G5/vWQgvX0SB5ltKHHwYstClmRvBzOk=;
	b=JaHRk0233pkvVWo43bmrFqoQuiHG05Xr2bXIVGptxP0aammwCv9KGZSYs7FVvXZGOSaZYm
	kPmSAvYwylBAlsCg==
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
Message-ID: <179560795722.92412.13343188526717425055.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     9de72d77310e931041886775222ba0fc9ef7134b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//9de72d77310e931041886775222ba0fc9ef7134b
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:25=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:53:14 +01:00

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
