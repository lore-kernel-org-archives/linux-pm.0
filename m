Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAFA47A881
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009183; cv=none; b=qlyIq7zqD2nvQrE4Opj4g3dGEZ753Tl7GWfn6j2t+4ayhpvl+lcwak52E8nTt/p/CShQaSYug1QHCUpVi3W+3D3g8di/CCFN+V6EspTPux8Cm/D905JZ8CSKXvg6K+MhX+IvY0O2wa4zzXDDYDe1PSB62t9ytxbUCCAClliqRlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009183; c=relaxed/simple;
	bh=KXEfeBiRtxb+crB8QiI0eFnAdLlT5SgzvB5PPXgbgs4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AkZKQVdYdfjUfqvu/Avnn1dIxniU/+6yQbdUr2DS4JJogRqZLeVmwOK0zWCvU0Y8Ku1I8eJfloUDomK+d0BOy4k2UCw5aulAsESXYnCvoCwPV/M/AJIBrJMNG1oYr3GjWDRvLRLx9zcVU0Q9iTyitbDX9U985iqHW4D0UMl/q34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oC22XnBC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iKif0b7w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oC22XnBC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iKif0b7w"
Date: Wed, 14 Oct 2026 20:19:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009180;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47kqGBrJfzRvRG1j6B+gA5+xOHhdgSgWFPopD+eN6xQ=;
	b=oC22XnBCpvoDsGEtVY1hOPhkXwfvB4SawUj7WldmQmU6ds31F4fQTcPacxsujd2lokyLvr
	oeEYnxv1yRWSWe3XpAzzyklw/sgykMtluRby8h0Zy7kHqWqWAwclNDCVT9s120dkWgfU6L
	kGZI0kGq2RxmLFXapbbTreJPRe7ttbFxyrVUTV27exRSi+cprH7mC7tcDOSmkCL51NPuJv
	LX59tcKb4fteEtYsUHNOAJjlL6JXEYdAjukVqyL1NHq9X6Dr3dZ4HPY00cEyfwU3we9Vak
	r1/pEL5JFEZqm47263ODoPtfyA/AK+IqyB4CnVXMZYmO3Z5OcZERZxKV6Vu3cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009180;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47kqGBrJfzRvRG1j6B+gA5+xOHhdgSgWFPopD+eN6xQ=;
	b=iKif0b7wOUFTBaqscRw4ImzrlUnBY5zmOhMGdCIY9BYXAqzku8OaZmzu+RGJojGBad+G4S
	zYTuMiThX013u0DA==
From: "thermal-bot for Vitaliy Sochnev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] dt-bindings: arm: airoha: Use one
 thermal sensor cell for AN7583
Cc: Vitaliy Sochnev <sochnev.v.74@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 "Rob Herring (Arm)" <robh@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260929165209.69669-4-sochnev.v.74@gmail.com>
References: <20260929165209.69669-4-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200917848.2666337.14749846623203298925.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     0cc14454eb4a1478ad23644668f8fb19075fd46f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//0cc14454eb4a1478ad23644668f8fb19075fd46f
Author:        Vitaliy Sochnev <sochnev.v.74@gmail.com>
AuthorDate:    Tue, 29 Sep 2026 19:52:08 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 14 Oct 2026 09:45:40 +02:00

dt-bindings: arm: airoha: Use one thermal sensor cell for AN7583

AN7583 has three temperature sensors behind the chip SCU: bandgap, GbE
and CPU. With no cells a thermal zone can only refer to the bandgap
sensor.

Use one cell to select the sensor. The AN7583 compatible is new in
7.3-rc1 and no device tree uses the property yet.

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20260929165209.69669-4-sochnev.v.74@gmail.com
---
 Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yam=
l b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
index cc564dc..4a10d02 100644
--- a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
+++ b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
@@ -26,7 +26,8 @@ properties:
     maxItems: 1
=20
   '#thermal-sensor-cells':
-    const: 0
+    description: Sensor index, 0 bandgap, 1 GbE, 2 CPU.
+    const: 1
=20
 required:
   - compatible
