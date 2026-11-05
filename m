Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893768;
	b=ieByceeHBw7jwIoDY8f8vl97eqCaAGYfwbP9h7BYxOgQz0h3u5RXpvvqOgui6bebuDDi
	 6Rjv2AgJ+nVBL4bYg6l54YteIgzkcHO/655yZKxhXdlJK5RYE4WHDG0HNG7a293XN9QRS
	 KfyBqtMuhMVRMoPQNsm3YQgpKSLn0l7aK1CzZ1tRRar0MGXZTi27SnwIXtn8m5X8JglV6
	 n9QWxmIdaIptchhqU3D8BbtG5zRQ2phL34Ihah6kIdDL/YBNRkdSsEXw8XRJ9IA9iHl0u
	 scLZWeKcFSCCxO2W69AmW4HSeyB5W3akDNhoi4GWlUrg71t3/uINNWlY13qynlEFc8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893768;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=njzHOYuep2BXgwrS+rSQ9C4nUFpAoZuxhNmhvRHO13c=;
	b=q5wBY6GhgczDHbuHOtRbewjL7u0ApqCi1C6QIwYwmr9q0Ls/49Q65taXaokDn+u1X+KJ
	 YydzEn0yv++gzDXCbXNadG0rz48dJJ/brUa2Zj0D8et5tsbO+V1KoSC3/cROzc5PFnEQs
	 oVOtHP4lfZ6hOMzj2DqtdY4fjWiCFB1ZDywRjHeRmwNdRqIrwnZ9YIbjlEs78ib3PUR9U
	 hUGT7CjveoBplr6DHPU3omeYUskir/ibSNA4qc+RvSfDL01UI2UVvxt9YSRYs1j2Boc1b
	 B3U3k4dduHZ181KVlA6mOIP7qIfvndwKI1KZnJpRfZqFcj2Xbdhbi0d9L5lug1KhlWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TkEd9uiC;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+JoH4T+l;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21C60A380E
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D21C60A380E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TkEd9uiC;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+JoH4T+l
Date: Thu, 05 Nov 2026 15:49:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893766;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njzHOYuep2BXgwrS+rSQ9C4nUFpAoZuxhNmhvRHO13c=;
	b=TkEd9uiCf0nL2Suv0jU4z/IN5GYrT6pkg8ZrYNUn/dH4ML0g3+ZtJ2m41T+IA/oodQEod+
	AyV76IGLVgrAOGlNeejIt/bbWffNGL8+UKvvrzoKRrDZ0V7wb+laK3Ipm455X8Y8SKm2Pv
	gQXRtEdb+69F4VnBvrRfpbreX2BuJu0pmTYk633rcw/09+4mUMLwkdhXT66zd949yZakGZ
	lTi0hv7moe/Kh5fYoVsYjUEC3ApUsKkxuZB68YbXJOoJeI62uksjSsfID22FMjh4rJs4d9
	5eJVbpr8ZSLyOYLISi4/irbggLrcIlEQF9BVX9yllHAql2U2eKtG2inRNfOpdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893766;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njzHOYuep2BXgwrS+rSQ9C4nUFpAoZuxhNmhvRHO13c=;
	b=+JoH4T+lFlejFQxZxE4yhuN4dn/fc4csrFZfakSG3eO41YmBbzp5XeI19eO7oLwvLrko4/
	+5ZQGnyPCjgetZBw==
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
Message-ID: <179389376508.1009794.816073962460957048.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     f04aff1cbba0080cd4af80134bbf4ac7452b2b8d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//f04aff1cbba0080cd4af80134bbf4ac7452b2b8d
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:24=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:51:50 +01:00

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
