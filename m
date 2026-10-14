Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7A14A840A
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009194; cv=none; b=NYyQcJCaXSrhUCjT/s3tCzhd2FrS3agxi6tTS/f1aMuAhtYoN3w2iiHRbnQEt6wNtJDnjV39VczOX5YNqJ9vUgCdCuWJaww60im9zlXxUEAKjL6ePJuqUf0kuumRSR+gFclIDab50+uHWjNNp68v6ngj1HSNc41fiKWkJnJP0/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009194; c=relaxed/simple;
	bh=WvDdsotbrtj6aTnwL2Sd3H9oCBkzuJTLEcIbL/i6WlA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NSxcBKZajZateeRvIqqbI5mg+dhkMZJGCBP5y1yH7CY1TynDzTv7daksceS3FM1dKTClse7HJN8jDnjSULqfk+rY4Tu9NtQs8wOMD8LyA+O80U/N4CTWlPZQLBdFQrkRQudB4a5XE62zL4WibnKrBkydraeWMCP2KnY+KYs6zcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V90ZvD2D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yuXa2Cs4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V90ZvD2D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yuXa2Cs4"
Date: Wed, 14 Oct 2026 20:19:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009191;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=meEgjKrX9y1a3Ko0CR1SygHL1tKHew3FhYHBDRJbQLw=;
	b=V90ZvD2DGqrV5Ix31Gh1ylja4GgPIfLgyli9g4NmESKlW4wBgwrG6HeFY9Pr5ZTVppJe7a
	lyDvgE754MufJXD2hvQOeNGvVwP2j8OD6axAU5sOeS6FeW7DvNIg8jmECmK8PvLAsFhrV9
	Dn8/Iy6f8H6BmEkeqrw+ZI1NnZIHMF/aDdw3mwgjU8KGW715fuWx7QuLZqWb1pMq/V9RyK
	+XMTI9/P5ZIX4EQClEU9f4Kd4sSTPfAx4tCxuElYPDMkzHHDlE13xp0uNcyO9TFOnx+5X/
	kxikMNMdSZ4yn+GCVVzq5UlEbbQk/wg2VEL9zo0xUoMoPxqgRxXzY+LRu3goRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009191;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=meEgjKrX9y1a3Ko0CR1SygHL1tKHew3FhYHBDRJbQLw=;
	b=yuXa2Cs4SF1AC6QwHnWNjwbA89/mScKZf0QErXOB9lHAFcJNJ5C3Rt6sh628replduS/d6
	BWSe+lRLk49yB5AA==
From: "thermal-bot for Liu Jing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] tools/thermal/tmon: Fix signed shift UB
 in binding display
Cc: Liu Jing <liujing@cmss.chinamobile.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260903082858.5273-1-liujing@cmss.chinamobile.com>
References: <20260903082858.5273-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200918982.2666337.4901637097677861498.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     f4428025c8b54d8a6e0fb15589e08b097b7b9a76
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//f4428025c8b54d8a6e0fb15589e08b097b7b9a76
Author:        Liu Jing <liujing@cmss.chinamobile.com>
AuthorDate:    Thu, 03 Sep 2026 16:28:58 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 13 Oct 2026 16:26:28 +02:00

tools/thermal/tmon: Fix signed shift UB in binding display

In the thermal zone binding display loop, the expression `(1 << j)`
performs a signed integer shift. When j reaches 31, this sets the
sign bit of a 32-bit signed integer, which is undefined behavior.

Fix it by using `(1U << j)` to perform an unsigned shift.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20260903082858.5273-1-liujing@cmss.chinamobile=
.com
---
 tools/thermal/tmon/tmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/tmon.c b/tools/thermal/tmon/tmon.c
index 7eb3216..ef67cd1 100644
--- a/tools/thermal/tmon/tmon.c
+++ b/tools/thermal/tmon/tmon.c
@@ -171,7 +171,7 @@ static void prepare_logging(void)
=20
 		memset(binding_str, 0, sizeof(binding_str));
 		for (j =3D 0; j < 32; j++)
-			binding_str[j] =3D (ptdata.tzi[i].cdev_binding & (1 << j)) ?
+			binding_str[j] =3D (ptdata.tzi[i].cdev_binding & (1U << j)) ?
 				'1' : '0';
=20
 		fprintf(tmon_log, "#thermal zone %s%02d cdevs binding: %32s\n",
