Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607963;
	b=MMpUl9RnAUTt4mVXcSycX0FIFFMpMuUdoJTxX2SBycJl1llr5JFD6kXo6WYoIVXluZtN
	 2Ga4PNM9KvZrxxDG083dOhpf7d6AOupDAKUGVKHQc0Lhl5PxP7Yk/yVy0JjkxkFSWJTNm
	 +btZukzynMiFZ8Nzqd2KFAl8OzEsIdMFBRz0xvsQh2V65ZFBdaX3WDf1p0ufXRMe4f9io
	 A0vFynysONNdLdyrRzxh9ja6G+9kp24TbtnMVoeRinjbUF7SRfJLHdr6AS4GlFrufZp+b
	 +DDNr6qt00DiUB9O0PosI0Hm2ZVoDqjmMp+YA7arXgss1bk2s9V/9G8SBraqjHvh8sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607963;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=Y77gQb1tpTh/QSx6HXmkRyAix4qE3CJ90oiyhIuNJsY=;
	b=k0PGcG2MHVXLqJuqp7k8CGUtHjh1uYcW4XV5I9VuSrT23OWgPinv6K9WvJNoTtDf9HQP
	 7Isc7w4Ozl2yePwC/I9f8R3d/EETnhA7Ftfk2SZOrULJuK1A29fGHei5OR02Y7h+1rlEc
	 pvmbzKnq+ijQmwXw3G67y0DG4p6mo4aFTUeoo1eP5PsTa+DUmfEp/YY2HOpLRCyFVNglh
	 BllblDalgTTNErqAM5/u3EcXFuGBNS6h0HLznkqSVW/Rhyhiux2w8Duz6xcTr98egVbJv
	 GPAR9eliabc298cOab7MoXic/qP7lpK6FwZt+/uA3qFYh+LfvCYC+bawssE624TWebg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=qpRX7rEl;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=DFRH5JsI;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E68606A693
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0E68606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=qpRX7rEl;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=DFRH5JsI
Date: Wed, 25 Nov 2026 11:59:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607960;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y77gQb1tpTh/QSx6HXmkRyAix4qE3CJ90oiyhIuNJsY=;
	b=qpRX7rEl8krHbDRZgunYN7uCf78km+S/3woHzED9u5h9csLgz1k7QG6J6chAJ+8ekDwGvm
	YFlPKGyjGIIaHK/kj1HvSjNnGGFOVn2wK8i44Ei4LH1F0GpU18zyEvfCOR5Sx3NuXJOHzZ
	PMuRzQIGJLfWJvviN76gBLvDliNzLLEM3F0DqXiX7G0gzgB3uYOScxStenygJSImYYlsxz
	9OTOfAyQabuV+K5UG64SIBY4LVK+RM2CgyVVXnI2Yf+jYwqJp1mSV0gEi/dzkwqkbqc8HB
	G9NFDBnm94o5zB29OZub+P0Duot9+xbkG8irbRxNEUmDB1qGYxUBUVreOpg88g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607960;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y77gQb1tpTh/QSx6HXmkRyAix4qE3CJ90oiyhIuNJsY=;
	b=DFRH5JsIAUgmnacVd1PmWNPsQAHeDg4PReV8JIpo2p+QmcLDffeq37zTGEIJVcin1jfFaE
	CRC7aW1Ho5GmgODA==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/samsung: acpm-tmu:
 Return -ENODATA when sensor is disabled
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-7-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-7-0637431b7268@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179560795894.92412.1301859301910976639.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     5634b46b5d6c875fc81d1f3a696c5d430ce602c3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//5634b46b5d6c875fc81d1f3a696c5d430ce602c3
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:24=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:53:14 +01:00

thermal/drivers/samsung: acpm-tmu: Return -ENODATA when sensor is disabled

In the thermal core, returning -EAGAIN from .get_temp() instructs
__thermal_zone_device_update() -> thermal_zone_recheck() to schedule a
250 ms (4 Hz) retry loop with no backoff. If re-enabling a sensor fails
(for example on resume, or after an acpm_tmu_update_thresholds() failure
when polling is active), sensor->enabled remains false while tz->mode is
still THERMAL_DEVICE_ENABLED, causing an infinite 4 Hz retry loop
instead of backing off and disabling the broken zone via
thermal_zone_broken_disable(). In addition, hwmon's temp_input_show()
forwards -EAGAIN directly to userspace rather than -ENODATA.

Return -ENODATA instead of -EAGAIN when !sensor->enabled in
acpm_tmu_get_temp().

Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver GS1=
01")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20261026-acpm-tmu-fixes-v1-7-0637431b7268@lina=
ro.org
---
 drivers/thermal/samsung/acpm-tmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acp=
m-tmu.c
index 4257bec..1f56c69 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -200,7 +200,7 @@ static int acpm_tmu_get_temp(struct thermal_zone_device *=
tz, int *temp)
 	 * after PM resume.
 	 */
 	if (!sensor->enabled)
-		return -EAGAIN;
+		return -ENODATA;
=20
 	ret =3D pm_runtime_resume_and_get(dev);
 	if (ret < 0)
@@ -208,7 +208,7 @@ static int acpm_tmu_get_temp(struct thermal_zone_device *=
tz, int *temp)
=20
 	scoped_guard(mutex, &sensor->lock) {
 		if (!sensor->enabled) {
-			ret =3D -EAGAIN;
+			ret =3D -ENODATA;
 		} else {
 			ret =3D ops->read_temp(handle, priv->mbox_chan_id,
 					     sensor->group->id, &acpm_temp);
