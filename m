Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893788;
	b=kI0JH/Rw9rV/uGH81QCtdTvT34QEBZiKz+jhIOHLsmG16X0QQlwTuzjNuYsH88roXczg
	 T0x/d4kNnnLQN/ZE+ZistQJPBO49AqX0E3eKC26WEn5FH+53ZKLOCDvAdVA6MhIFllT5b
	 jakAJaoxbjWoKj9PEsN3XzzS2qu0lykooBFCUNIp/YaOaQgv+DlshOJEzHRr1Zu0iI0FT
	 JiWLVRoKAxxcXBNYZ5t9xYeYhX1ky4mvqZMuPV+q0PqjeC7sFDWg0r4ZR7D0t4MU/XCzu
	 9DjqfogqcS5l2fEO3Aq3iajgcsrCgr2ETHi7Ukrnqu/RqfMWxoqlarKtDHDXvi+v0wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893788;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:MIME-Version:Message-ID:Robot-ID:Robot-Unsubscribe:
	 Precedence:Content-Type:Content-Transfer-Encoding;
	bh=aAop6QiREEeNCeRsV6218fK4ujntTVpVTGHMGXFWbFA=;
	b=GYNW8LA59qj+R61u9vng4x4QvMaE/vr1AZs1/hlQeMi3zPHHVKGBKQzob3igWSnNiaNl
	 Di66C0qpd0L8GRnrZIb9BlCyMDYahoUI0y0bOALKZLFLNT4pmt6BItiqWhOCs/dVCzhhc
	 qbM505vAihIjgRPkQSRGfurZvKLQ6DQiAdUGR3acgDr1qNhGNbE4nN2UlIwryNDW6OFZi
	 3z+RMpxNgsbQde5/qAzGQ9o1zIctTUdB9W2qUb1robO/D2xNRGlgPlnhx3WhHWPtH7Hvt
	 4PxLDcEUJeIs8pvtWoShcwkTwUvV3uNv/p2VuLohAXA4d2NtrErJR0buCsyp5oJ7BeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OrU7Y0hu;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=TaNmAEPl;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA416606D824
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA416606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OrU7Y0hu;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=TaNmAEPl
Date: Thu, 05 Nov 2026 15:49:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893786;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=aAop6QiREEeNCeRsV6218fK4ujntTVpVTGHMGXFWbFA=;
	b=OrU7Y0huPewC84mNdVcsM3QKinxzVzWJrbZm0y+Uxgbt5vE+3tn/12slP/leO5LmuzjC3H
	sMxuCBFlWqE1ThjF1PZhVoPss+k+MuXrcfJ3sFRGYlPlShFncQJTiOWqEo83umulZqYdBb
	UuA+qMSosmhPw7GM93KnRqtl+trWdi7uP6coCuS26lHnu+TP/g/JhwSjDIM0HtzNmocu/A
	BDRFUn/FCX85Qy/evVpKE21N/P1WGo0hyPinqr8cu6LocAfzflLCtLOSptTo1xZL5ZELk2
	mwqRHVww1NTeodwQL2uH6yybzRD31Z435fH+8Lh3RKF5fy38WAloYLG1uIs8Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893786;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=aAop6QiREEeNCeRsV6218fK4ujntTVpVTGHMGXFWbFA=;
	b=TaNmAEPlhIupMRPqgw3Fnsp0Bycf0+FTJ+rqpGBEa5knQ9ExvRTGN2PCwx/elSz+2Srtjc
	eNYSw30x+gjSczAg==
From: "thermal-bot for Artem Novak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] dt-bindings: timer: renesas,tmu: Add
 SH7305 support
Cc: Artem Novak <artem122novak@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Rob Herring (Arm)" <robh@kernel.org>, daniel.lezcano@kernel.org
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179389378407.1009794.4852254490791697159.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     115b4ff52cd3566181c59991d72b3cdd3eab7c03
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//115b4ff52cd3566181c59991d72b3cdd3eab7c03
Author:        Artem Novak <artem122novak@gmail.com>
AuthorDate:    Thu, 22 Oct 2026 20:09:32 -06:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:14:16 +01:00

dt-bindings: timer: renesas,tmu: Add SH7305 support

Add the SH7305 compatible string to the Renesas TMU Device Tree
binding.

Exclude SH7305 from the mandatory resets property, following
the convention used for older SuperH TMU implementations.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/timer/renesas,tmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,tmu.yaml
index b122959..263f60b 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -51,6 +51,7 @@ properties:
           - renesas,tmu-r8a779f0 # R-Car S4-8
           - renesas,tmu-r8a779g0 # R-Car V4H
           - renesas,tmu-r8a779h0 # R-Car V4M
+          - renesas,tmu-sh7305   # SH7305
       - const: renesas,tmu
=20
   reg:
@@ -110,6 +111,7 @@ if:
             - renesas,tmu-r8a7740
             - renesas,tmu-r8a7778
             - renesas,tmu-r8a7779
+            - renesas,tmu-sh7305
 then:
   required:
     - resets
