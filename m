Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607949;
	b=XEsSGzbWl41OsO2XIhFo3QtsvzI2p3b/BOin8GyPGgw/QuCQflvtEcfaj19BgTB8720G
	 K7FiCYnms7s4Gjrn66C3lTACrCcfVpIpW+FBDzVpG/3WXbycrzyYvQFK1N8LHr7l7KEMC
	 IfsL+YPYJP3hkE3R2IM5+yDT9NXLGxx+hN7QRf+ThkG+werPZxW5iRl2cmKTUfyznH9Qk
	 7emNHYT32h+mny8tSdwuZwYF4P4uz+urm63FZoIcvSs6nvOkSWypQjoXMQ3kQcSVumT98
	 CBMVoAtHNBFlIHqIeQcqNw4bZuPluaj79GXImoQuPafLw9wuMKh74d6w6rPydXmze5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607949;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=dgmQiZ7+jzAIAvbJz2/WhrG+vV5nIrENTbJrwhcuzZA=;
	b=SLLa9l+P8gEgBhgmjYzAyYRUEnhimZbBoY27dZw6N7skU5ouApFgSdFLcQHz6CG1jkW8
	 ph7os6z9t4o093GI4vpS8IY74tYxH2x14MBK0QcDgJxC6ZerCU0Nmbdu92pbJU8ZiKwB+
	 ifAItbhiVORIPE69/C8SAd23Poz2jCYY5JLkmz1gnqndK8xcfSkTZ6dl2teY3rpzb7qnv
	 IN4seQLGtfsDGIFmCudpWb7yEm0El2hJH+z/WcTcgAkrl3DDZPQTcG82e+XqxsRIrbqDZ
	 AMdrLcPcVgzrUghVmT+UOtivqNPX1jFdtzRIBNKfgiCaPx751VBGQX/WkGa2Ke+gKFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=vFPannzu;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=7b4Kr3IB;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E33606A31E
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4E33606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=vFPannzu;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=7b4Kr3IB
Date: Wed, 25 Nov 2026 11:59:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgmQiZ7+jzAIAvbJz2/WhrG+vV5nIrENTbJrwhcuzZA=;
	b=vFPannzu4lAFw0uC+0/GLsb4v1mmKvDO2dI/i66nJxri7hR9YEvIjPF/frcfJD9rbpHotv
	ljvF1ggI3nTJ9F0DV/bc5uWxw6XxN0GVjndqBMCxNHqHqYQs8Ff9kMzeGghdkkHR0faJCA
	V8zp8BCCzJPbc9iFg5ZdC369AXuFauAbTSe7uNVLIYsB+i3HoROjULYMvi3rtzY6Jt04WF
	sIJx8zlvgeqFrH4UhX69p4Fzf0UpTwiM3O9uXIl4O8SIBlG2m8ma4ax/4ktZMgtuAop7sT
	lzJmgEeHRGWoEVjQjDPtFAguPlWKBOKbygg14qv181rZ5gHL86DFjTBWCoLGtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgmQiZ7+jzAIAvbJz2/WhrG+vV5nIrENTbJrwhcuzZA=;
	b=7b4Kr3IB+y23YuwAs4YT6+gHnIg18Dl9xtQtf+UCx6eLDLpSP1Yuu2Hc1BZzh2+w/yd50p
	Cy7CYq41JcpmalCw==
From: "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] dt-bindings: thermal: Use signed
 integers for coefficients
Cc: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20261103214357.2700244-1-daniel.lezcano@oss.qualcomm.com>
References: <20261103214357.2700244-1-daniel.lezcano@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179560794459.92412.14880317165745336872.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     f79e51c70ef3209103fbe0200a1a012eaad763d9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//f79e51c70ef3209103fbe0200a1a012eaad763d9
Author:        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
AuthorDate:    Tue, 03 Nov 2026 22:43:57 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:53:15 +01:00

dt-bindings: thermal: Use signed integers for coefficients

The coefficients property describes the coefficients of a linear
equation used to derive a thermal zone temperature. Both the slope
and the constant offset can be negative, and the thermal core stores
them as signed integers.

Existing Device Trees already rely on signed values. OMAP4460 uses
an offset of -9301, while OMAP5 uses offsets of -1791 and -2992.
Broadcom platforms also use negative slopes. Declaring the property
as uint32-array does not represent these values correctly.

Change the property type to int32-array so schema validation decodes
the cells as signed 32-bit integers, matching their intended meaning
and the thermal implementation. The cell width and binary encoding
remain unchanged, preserving compatibility with existing Device
Trees.

Fixes: 1202a442a31f ("dt-bindings: thermal: Add yaml bindings for thermal zon=
es")
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://patch.msgid.link/20261103214357.2700244-1-daniel.lezcano@oss.qu=
alcomm.com
---
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/D=
ocumentation/devicetree/bindings/thermal/thermal-zones.yaml
index 999ad40..72e4191 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -101,7 +101,7 @@ patternProperties:
           thermal zone.
=20
       coefficients:
-        $ref: /schemas/types.yaml#/definitions/uint32-array
+        $ref: /schemas/types.yaml#/definitions/int32-array
         description:
           An array of integers containing the coefficients of a linear equat=
ion
           that binds all the sensors listed in this thermal zone.
