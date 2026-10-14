Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2D14A4F11
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009205; cv=none; b=c+FYXlWkDhcX0/Y0XR+BR7cJGFA6JcCjvSkRzPEeLhSBQsxJ9AMJT77vfb4gi8BWNHTe+oUsqsu6g6kZfy+n7/gGCiOj1OZeHgubSlFb41l0GH/bjbdNPsx2J6Ndq6UPqto/0bbBNr+kvRZse7B8un9cT0MKz+UEpiw+shqeV9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009205; c=relaxed/simple;
	bh=hJkA4ZsLvoPbbkHpxpk1olnU5COiaw/c4iZRYuQQXjU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kQp8FRZsUjt4Vs+03qu1zwJt1+I7dfcNsuNUBGnWoatYaDn4BH0VIxFObecVUAoZsFeEzXxdzWY/ltqv+gmetbu7yQ0bvh64DgnulmCP8Igh9eKG9Bk8z8PuWCwNwN4RxkjQu+p2khferSWCllpGf+BWW0TeAniyGK92DM0QG0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SF17RWdd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AZTkJy/Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SF17RWdd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AZTkJy/Z"
Date: Wed, 14 Oct 2026 20:20:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zNeVPDYfFQhfpcAGAkdHr0Zsb1XKDzyV1Yz2o3e2DA=;
	b=SF17RWddphVix0NeBCNclsPefLrr9iRdzd3CW495xyK4Qq+BahVtnXviL75VXuSZ+5Jf59
	C1+uqIzEfWAcycqu5Xen+MU4B7xGLYeheV35q3A8yn2uR6629Vw470dpBXPvQQ54OE0B5k
	JzKIFl2+gIJVxNeIkOHB41Pc0jEYtrWUCnv1dAty7hZtcntUIVV1sjUMVOlax1iIFkoDD+
	kytnys4xPJ7S/kt3BKZYwFGGT+nkJvI+VTqhdNKuFOvkhRh2zeojY95p98MQhb70lWJ4Du
	TLmjpKa5FjJ/BY/GStP8yarMxqNCzwGHBh3fWJAykAT6AqH5Kt7nsuqYx6qQ2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zNeVPDYfFQhfpcAGAkdHr0Zsb1XKDzyV1Yz2o3e2DA=;
	b=AZTkJy/ZmvFjYj2E7kSIYqcBVwiqH4LKz+uegmZKt6ZP61STUFVM5y1mWFrkxWFY/32ttn
	jz8zOoTjT/mtV5Bg==
From: "thermal-bot for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] dt-bindings: thermal: r9a08g045-tsu:
 Document RZ/G3L TSU
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 "Rob Herring (Arm)" <robh@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260925061617.127349-2-biju.das.jz@bp.renesas.com>
References: <20260925061617.127349-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200920121.2666337.14701746002831837638.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     6b7f5abb48cab4ab500ca9fdfcb28aeb0e4d4971
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//6b7f5abb48cab4ab500ca9fdfcb28aeb0e4d4971
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Fri, 25 Sep 2026 07:15:59 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Sun, 27 Sep 2026 23:00:50 +02:00

dt-bindings: thermal: r9a08g045-tsu: Document RZ/G3L TSU

Add the renesas,r9a08g046-tsu compatible string for the RZ/G3L Thermal
Sensor Unit (a.k.a TSU), which is similar to the RZ/G3S TSU but uses
different calibration constants. TSU is connected to a dedicated ADC IP
(a.k.a ADC1) on RZ/G3L.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20260925061617.127349-2-biju.das.jz@bp.renesas=
.com
---
 Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.=
yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
index 573e2b9..20fc1a8 100644
--- a/Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
+++ b/Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
@@ -17,7 +17,9 @@ $ref: thermal-sensor.yaml#
=20
 properties:
   compatible:
-    const: renesas,r9a08g045-tsu
+    enum:
+      - renesas,r9a08g045-tsu
+      - renesas,r9a08g046-tsu
=20
   reg:
     maxItems: 1
