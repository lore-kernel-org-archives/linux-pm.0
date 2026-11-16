Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822564;
	b=EkvbOFovcHVsR/t+rSSamsL+2oPaIayVfRWzxsBQD6YfWpWfjhWNwDQmajvy0JSgmYHP
	 kD+1L/Vm14Bvtidrqx2mN2mOKhZS3cNzA6Skxuc0j41/70ltAuS/bUX5O0knA/kC0phb6
	 xb96s1+v0a9+9u5kp6m9EG3u3+1PDiE8FYM2gnDqLCdKxs1AhxsZ8v/HEy2K0sN0LpFN3
	 lrJbUyaZEVtQpqSSyC/aLCKkuyU5OJqc1YSG9MossUaXDutC84PFKJEkb/AvfRwx+ygYd
	 AKA0sqcz35pJtWXKvMuqVr7A/45sAHTBkRruev0wI/P6P/QJOwy6wv/q1TIhz90w8NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822564;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=joacvyligxKtg/mdWS8HK6OXTbKPkel8ptTulrGnoN4=;
	b=5XpqvImKnccyfgmPG8MVcAWLG9iDqRFwrOLXY6Y+5VPEvwlB+UNkqmYgV+yIKeQvy9Kz
	 5MkCdOkHQ3w92MIpQqzm3eqKTOg3TmVXqnYACo6baFLa6zjU+vxeyoNltV+y6bI8zXMQw
	 Jr/ircqIfpG5Wxg+Uc6Uv8sTgoowPNjYsmpkGOtKoniIF5vDVkH409h+mTf2Fn9xGe/wd
	 gx3UD+YC/dNYqDaNq49HuhUOXP7DpTskyfSf1UdsdQ8Ylk7+tUAYjKHX4+vvJ7iknusbK
	 tQ8omaFlM05+1ID0sKJewqwRzwotb3QaDUcHHd7jFehrYBSoQ1QnJ4HhPKosvGDi9ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lNDFVng9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08172606A323;
	Mon, 16 Nov 2026 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lNDFVng9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFFB1F000C4;
	Mon, 16 Nov 2026 09:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822563;
	bh=joacvyligxKtg/mdWS8HK6OXTbKPkel8ptTulrGnoN4=;
	h=From:Date:Subject:To:Cc;
	b=lNDFVng9kauBDgivW9YXt+dcpKNYDEiGMPYgFfCBEfJhUHo9B8+Majt/Cy03+Rd2t
	 cKpV+D0J/ZYZkwsfgB75t6rKTF/VEWFbXs7ITkP/k/ve5mF0T1RwFaTwtMM7vnFFDB
	 axzgBmJ0Stz8G/9EHAQiyIeiF62t0Np5QYzZugsr7RgELgI+GcCpuYwG/sRgfnEvnJ
	 tWs6t+L76OwCwR7bmDQa3/ytnyJnLLt2xxNfYp9tdpxasngfr958dt0lmf/903xlju
	 t2RuKy0yghyR8N7DyhmC9YzP79do/sE1DCW4o7wT+GEBsG2fTJ+mcL7HQM9TgL38np
	 myejx9Z6swJAg==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Nov 2026 10:49:19 +0100
Subject: [PATCH] dt-bindings: clock: stericsson,u8500-clks: Allow power
 domains
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ux500-u8500-clocks-bindings-v1-1-0beed440c3f1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MwQrCMAwA0F8JOS+QVDddf0U8dF2cQemkYTIY+
 /ehl3d8G7pWU8cIG1b9mttcMII0gPmZyqRkI0bAwKETkY6WtWWm5fozv+f8chqsjFYmp9T2F+Z
 z6k8SsAH8VH3Y+t9v930/ABUWd1FtAAAA
X-Change-ID: 20261116-ux500-u8500-clocks-bindings-a597004a9312
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Allow the DB8500 clock controller node to reference its power domain.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Allow the DB8500 clock controller to reference its power domain.

This binding-only change can be applied independently. The companion
Ux500 power-domain consumer DTS changes will be submitted separately.
---
 Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml b/Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml
index 4ebfa5a8d524..75e5e1107ebb 100644
--- a/Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml
+++ b/Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml
@@ -34,6 +34,9 @@ properties:
       - description: PRCC 5 register area
       - description: PRCC 6 register area
 
+  power-domains:
+    maxItems: 1
+
   prcmu-clock:
     description: A subnode with one clock cell for PRCMU (power, reset, control
       management unit) clocks. The cell indicates which PRCMU clock in the

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261116-ux500-u8500-clocks-bindings-a597004a9312

Best regards,
--  
Linus Walleij <linusw@kernel.org>

