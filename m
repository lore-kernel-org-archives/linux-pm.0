Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1E1492E26
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009207; cv=none; b=TXeI63/BeM1pmK2Rv9F9z8jUdbeuWiGZYajNosCLWvSPxJ4+77kpFvEoPvxY9aXfvxEnxRZa78kWy59xL3syAdR18JY2/yz2iQsbZNOz0jKLTXaBYY2uI9bxWk5O5cL323edXpWT9K5hWrD58WwlKUswltmttxZpj++EG7FKcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009207; c=relaxed/simple;
	bh=EwCYIzv2rRKMqDHOm3hrREhnT14HE529DIBUsMqlci0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c6KbJv7F54f+VEN0J81TRTB5an+ilzUW8ZHaEq+V/fsQiME0zUSHTjSgswYLWhYHYdk0V7uGLt7XjSUkz8MDlyKRXDgp3G0MtmnLQ4sbOd3W9cBmiVynMP5i5CqKanNUlWLPXOyIiHhiiaXQLFdeAP2s7pB+YtkV7nKGdCEDlFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lm2MgBzY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9RPFT7vu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lm2MgBzY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9RPFT7vu"
Date: Wed, 14 Oct 2026 20:20:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USJAK0AmsNUAxr2B681l4i2tmfEzssaVuOfjwfiDriI=;
	b=lm2MgBzYhVe+YIexAzf0odcGV1sDd+RWx/Ln2VGX2k9yo5ZUnAK4qqOa6UNtwWR6Ioaxxz
	1X4TfyfnfyxZYR204GpjebjAR5Ua0oHcGMJo6Q7lhIke6lNxMwrKdJywilIFtkGJKNq8/z
	Jqjah6DlleUvM5jNAmlwS0sxZv4xuTyiY46en/UdK6kV7I95ORYBfY8tiU98uox9/5V+3N
	VE3lF600ws3EqrJ2N40fuce0Q636AvJwGS5Ihzm6MK+G4+200DqKHDX/V4OA74eD+P+d8h
	tHBR9hSxPz+xh7k2JI1tSn1AljHU4n8uSQJ9S137KA6bT7upfdAlO9PGgdnGFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USJAK0AmsNUAxr2B681l4i2tmfEzssaVuOfjwfiDriI=;
	b=9RPFT7vu+Qa5RHD0ZWxfa1fPztGisImBUUgKfX/iYAMAZaDbN1B8uyW+JdYVWSj3+kG9mi
	qSf5lRJGXECA1vAw==
From: "thermal-bot for Priyansh Jain" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/qcom/tsens: Widen
 temperature limits to match hardware range
Cc: Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260508100700.772985-3-priyansh.jain@oss.qualcomm.com>
References: <20260508100700.772985-3-priyansh.jain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200920282.2666337.2284567663705396891.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     eca1247443d41f695c389e4109c2d7986f8fd95e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//eca1247443d41f695c389e4109c2d7986f8fd95e
Author:        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
AuthorDate:    Fri, 08 May 2026 15:37:00 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Sun, 27 Sep 2026 23:00:41 +02:00

thermal/drivers/qcom/tsens: Widen temperature limits to match hardware range

The TSENS v2 software driver currently clamps trip_min_temp and
trip_max_temp to -40=C2=B0C and 120=C2=B0C respectively. However, the
TSENS v2 hardware temperature threshold registers support a wider
programmable range from -204=C2=B0C to +204=C2=B0C.

On newer chipsets using TSENS v2, devices may legitimately operate
beyond the existing software limits (for example, up to 130=C2=B0C). When a
trip temperature is programmed outside the software clamped range, it is
constrained to 120=C2=B0C on the upper end or -40=C2=B0C on the lower end.
If the actual temperature continues to exceed this clamped limit, the
threshold is immediately violated again, which can result in a
continuous interrupt storm.

Expand the TSENS v2 software trip temperature limits to match the full
hardware supported range (-204=C2=B0C to +204=C2=B0C). This avoids repeated
threshold reprogramming and ensures correct trip handling on TSENS v2
based platforms.

Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://patch.msgid.link/20260508100700.772985-3-priyansh.jain@oss.qual=
comm.com
---
 drivers/thermal/qcom/tsens-v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 2ee117a..843dd29 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -54,8 +54,8 @@ static struct tsens_features tsens_v2_feat =3D {
 	.adc		=3D 0,
 	.srot_split	=3D 1,
 	.max_sensors	=3D 16,
-	.trip_min_temp	=3D -40000,
-	.trip_max_temp	=3D 120000,
+	.trip_min_temp	=3D -204000,
+	.trip_max_temp	=3D 204000,
 };
=20
 static struct tsens_features ipq8074_feat =3D {
