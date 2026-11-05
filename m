Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893782;
	b=E/kbLUwKK3fvj8JUkMVfoTYMY4WX5nu37pZZR854M30Jipd4FFJLzB6Nt6JK3ADKhips
	 3IprCDi+mi1P10nE0Sh0k9NaK6eBDRpn46FX5PLikLWZ/pN4J9DDE0VQrI5U6sSWi0XMe
	 CW0tb+RcrnC3bRraTYLAy1AN5okDHF7fp12fqGhABspp+2o2AmLqre60IlNQuILmv9dSv
	 RSsQ7f2k9BKMD8CkHPnc1UrxtwznB6Vw+duXldpQG8OxXb+QIvYNios4g/I1VR4LkqNZ4
	 or+8d+joyezHhh33Si5AjU5yLDvywj6sltb983OwcijUxyK9S5bTjLCg/DMXSCQfZqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893782;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=6zjjuy7+bN6pAJiZ5713EyKDh4z0hmEZWXep3//7lJc=;
	b=h1Bl9LptrSG8BH11Akl0lzzI4wsehqVAD6J+XMPCVkE2AyAcpQ8xQRjDhJxwfII+xy2M
	 HEFBNrs6J4FPajn/CZA5GIoOWd8BgWaO920ujPD/KQnbBzFLjY6YuFCpOOi/6L+1O4Cdr
	 ExWQ5sq31hmkCQCUR9KNg6x6v33ijnm6oOXCbM8pTC91trk7dvRJK9E5ADGBFutHTk6O9
	 CVj0VCHWXAXTuSnZh+OzB2iS/ay5HDHz+s+kLVUBnEBlI/z9BeI8xEbk5MJQc+6YOmEFW
	 SgpApv5p36B7y5b045tYiA9xoydHVF4FQCV/NuhO7sUPQ4CDRVXPZvKZ3NgITB8LwxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="Zct/MdvK";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=MxDMvTKy;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB5C606D825
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BB5C606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Zct/MdvK;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=MxDMvTKy
Date: Thu, 05 Nov 2026 15:49:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893780;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6zjjuy7+bN6pAJiZ5713EyKDh4z0hmEZWXep3//7lJc=;
	b=Zct/MdvKXe5aGDZbH1Mg3ihiFbK9z0zlceOq6iJqkdtBk9eofrQ0B79spi8pB2m+SXfsaL
	QR1RRQ9DePBrXV/TU68qpTG4SESVsJepc+wBTbO2r9KaKJGefA2n5bdXqzIhRP2/Y5sOh2
	Oyesws6YrSEKhGJ+L/3zDYYtPs1cp9TwV7eJ/qbLlYOuSvar4OimZhMNsOiB1LBxTyGEJp
	MhDCncgTJfh305zvQHdD4yzLiPDk1uuxw1i8bI6nEa83PqYpGe111EfrK4ypQhE4Tmkc7l
	+Xm+fi0CDjRY9CZ2rS0vsvKgsMt+N9hxfMdZurDaDNoFBv88PX5YqAmOJTylgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893780;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6zjjuy7+bN6pAJiZ5713EyKDh4z0hmEZWXep3//7lJc=;
	b=MxDMvTKyaKa8ZniemrKkCebHgOUeNEaVKHHL1dY9k5yMkQ/HG5tacgiZgjs4cbjCp+ZdZM
	i6kSCXkzEnUgS9Aw==
From: "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/qcom/tsens: Validate
 the sensor count before initialization
Cc: Bjorn Andersson <andersson@kernel.org>,
 Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261021085749.3786101-2-daniel.lezcano@oss.qualcomm.com>
References: <20261021085749.3786101-2-daniel.lezcano@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179389377889.1009794.5972450185318390576.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     ce7e968a95c4d78717443ec1286ed2b207c74dfd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//ce7e968a95c4d78717443ec1286ed2b207c74dfd
Author:        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
AuthorDate:    Wed, 21 Oct 2026 10:57:47 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:48:08 +01:00

thermal/drivers/qcom/tsens: Validate the sensor count before initialization

The #qcom,sensors property can override the platform sensor count without
an upper-bound check. A count exceeding the IP's maximum causes the
driver to access uninitialized regmap fields when handling interrupts.
Platforms with an explicit hardware-ID table can also read beyond that
table, even when the count remains within the IP's hardware limit.

Reject zero counts and counts exceeding the hardware maximum or, when
present, the hardware-ID table length before allocating the private
structure and assigning sensor IDs. Preserve the existing fallback to
the platform default when the property cannot be read, and document
both the fallback and the sensor-count limits.

Fixes: 6d7c70d1cd65 ("thermal: qcom: tsens: Allow number of sensors to come f=
rom DT")
Closes: https://sashiko.dev/#/bug/linux-d0867095-c131-491e-a6aa-a81debfd0df5
Cc: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20261021085749.3786101-2-daniel.lezcano@oss.qu=
alcomm.com
---
 drivers/thermal/qcom/tsens.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 997a0db..4d4997b 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1402,10 +1402,20 @@ static int tsens_probe_common(struct platform_device =
*pdev)
=20
 	num_sensors =3D data->num_sensors;
=20
+	/*
+	 * DT may override the platform sensor count. A missing, empty or too
+	 * short property leaves num_sensors unchanged, retaining the default.
+	 */
 	if (np)
 		of_property_read_u32(np, "#qcom,sensors", &num_sensors);
=20
-	if (num_sensors <=3D 0) {
+	/*
+	 * Require at least one sensor and stay within the IP's hardware limit.
+	 * Platforms with an explicit hardware-ID table also limit the count to
+	 * its number of entries, which may be smaller than the hardware limit.
+	 */
+	if (!num_sensors || num_sensors > data->feat->max_sensors ||
+	    (data->hw_ids && num_sensors > data->num_sensors)) {
 		dev_err(dev, "%s: invalid number of sensors\n", __func__);
 		return -EINVAL;
 	}
