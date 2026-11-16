Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824191;
	b=yGwIUkSsxx/AQNCA3B7FRLDyvJNPD1AmNteVLiEveew838E1/dPAdBVT1NIUws9TEmwQ
	 GSgb0CSTyB52535dlieVQDHE8zUzgy83qrpliuiRTpL2ZHs/+sUEPFGnP4J9GXbpQ+wMh
	 rgblqvdC8ZHNtWzjejz4JvmrJXFcVy2q4tt+AxodcOBq/qFVpvxROn6vgLfhLYKT+cLa3
	 KTnumpOYu+SAmmTjfMN4WdeyM/UkwG/KIL4EnPtMQFRjmwdMS+u35DQoYEMkPk4SCupFH
	 q+dsATr6YxNQbB+E16D9fukNIGsRYviNDfYv+px5TQ5yVsDgNBGVL3KL5VDgzipQO7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824191;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=xhOm1k28TVwjypTguaVYnEw+SHxoaZ9nytF6bokwZmQ=;
	b=oiQ1x1AjhdWc7vuWR2RA5dneP/4tOtHpqvhd//SmBVFwIuMDVgYkDn9t6fYvdHZn+fEo
	 awU+vvLYr1KjT8gthZINzPKp909MoUKcBqSnxnmPBXt0KgorELUrr5YWn2ideHig7IeUq
	 l6r36JUHiXB+Kuh8PEz0kmRkBpijI8j9/7LbCna3c+YTFSEbNdL5MTPoE0fA9cJ7Sz00V
	 /lzz6CMXshxJCLYBY3fAyXjddDDeF5nJBX4csCVmtCe7u7CrfRnhrnxm9bO30S411micY
	 G5OZUTdesO7o2Ug4+Znizd2rMs1ySQU5R08+6rd6css16F0YyCrpN+Dn7PYekaohnGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sp4Clq07;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04810606A323;
	Mon, 16 Nov 2026 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sp4Clq07
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAF81F000C6;
	Mon, 16 Nov 2026 10:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794824190;
	bh=xhOm1k28TVwjypTguaVYnEw+SHxoaZ9nytF6bokwZmQ=;
	h=From:Date:Subject:To:Cc;
	b=Sp4Clq07qqcT6dBdu6p/fAbn56W7lg/E/r2BFLf6WhsjFmbH8I4RZUoDvaBOAtBpj
	 pOSevZxScwYl5maLReg10kmOQ/Zk3j4myV0xg5GZRTYVzEEb81QWQ/kN2xyofQOfbn
	 j9QK/lp2LyMjppG3wqkrrr6P1Fq/bCpVcTUctdRN/H33tElF5GPtXXpLdfIVVSU61I
	 OS55emC/3rClVpunTHG95dJ7Ls2Pb07CST+AWi7+hK4JtYbScyE/9f4/CLbdqhI54S
	 wVnNIhYb+PASaIUOZ8zMzT6giBPqzrtEp9VcTIU7sRi28fwbKa5mbJ8jcY4dz3SPZw
	 Pkg8NfCYxyKZw==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Nov 2026 11:16:26 +0100
Subject: [PATCH] dt-bindings: display: ste,mcde: Deprecate EPOD supply
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
Message-Id: <20261116-ux500-mcde-powerdomain-binding-v1-1-4f0f7ee280a0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3NUQqDMAwA0KuEfBtonfajVxn7aJvM5cNUWjYF8
 e4D3wXeiV2aSscIJzb5addqGMEPgOWTbBFSxgg4ujF47wN9j9k5WgsLbXWXxnVNapTVWG0hl9j
 nx1ymkAsOgFuTtx538Hxd1x8BHuFQcAAAAA==
X-Change-ID: 20261116-ux500-mcde-powerdomain-binding-0ad1b35c46bc
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>, 
 linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Make epod-supply optional and mark it deprecated.

The MCDE should use its power domain instead.

Require either epod-supply or power-domains, allowing both for
transitional device trees. Reject nodes describing neither.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Deprecate the legacy EPOD supply and allow MCDE to use its power domain
instead. Accept either property or both, rejecting nodes with neither.

This binding-only change can be applied independently. The companion
MCDE driver and Ux500 DTS changes are submitted separately.
---
 Documentation/devicetree/bindings/display/ste,mcde.yaml | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ste,mcde.yaml b/Documentation/devicetree/bindings/display/ste,mcde.yaml
index 05e7e4ebc882..e7978eca6f32 100644
--- a/Documentation/devicetree/bindings/display/ste,mcde.yaml
+++ b/Documentation/devicetree/bindings/display/ste,mcde.yaml
@@ -39,7 +39,8 @@ properties:
     maxItems: 1
 
   epod-supply:
-    description: a phandle to the EPOD regulator
+    description: a phandle to the legacy EPOD regulator
+    deprecated: true
 
   vana-supply:
     description: a phandle to the analog voltage regulator
@@ -103,9 +104,14 @@ required:
   - interrupts
   - clocks
   - clock-names
-  - epod-supply
   - vana-supply
 
+anyOf:
+  - required:
+      - epod-supply
+  - required:
+      - power-domains
+
 additionalProperties: false
 
 examples:
@@ -121,7 +127,6 @@ examples:
       reg = <0xa0350000 0x1000>;
       interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
       power-domains = <&pm_domains DOMAIN_B2R2_MCDE>;
-      epod-supply = <&db8500_b2r2_mcde_reg>;
       vana-supply = <&ab8500_ldo_ana_reg>;
       clocks = <&prcmu_clk PRCMU_MCDECLK>,
                <&prcmu_clk PRCMU_LCDCLK>,

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261116-ux500-mcde-powerdomain-binding-0ad1b35c46bc

Best regards,
--  
Linus Walleij <linusw@kernel.org>

