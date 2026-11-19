Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093411;
	b=NHlaW0HWC/MfmYGrLNYgDnq1VxePte757QyE2+CmQFHdE6VJbfiDvrs6WggxoaI492+m
	 GHA33hxNDTOZ3boiYZYC+xANh2Wis8qnmTLcN7w4N6BsqR5FUng4qm3VbJMJSiSEOxPF5
	 fBLGQdSpw0uxn/GuAfRHewCNJFyXeeHfQYJ3ZACYy1X10q0WNlxwoNFoqe4WFiaJidood
	 FzcEIojuNlYmKAT0dQ4GA/19Z1htw7/E2zT/KiLqhJipNMYEqJECAXUbcBhCOKEGqIKV5
	 gngZzth9T4yNI5F4KpWPPU751IfALObPKO/WqosSo3AV+KJI57mcLDUN10KR8IH7gMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093411;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ci8p0AuX6stL6MXjMcRS6hMt62LWZGMpMiLOfGFW2gI=;
	b=SCHizfFRvyXdRTTvi7DqZRvfGO+JLKMIr8tTfxmgMX7infmq3BRWewZCysBYNmuzaxgm
	 RzPuflJZ908zNHjboGlQJfyP++1+Qp4qZxCJWf51G5N5boskk2s+tq/ejv678vNz0a7wD
	 V6N5kVTdK5Rgoz5o0PaRoFaPumUMhZ2Xv26jwS/ggL7wBPhri0hokGj+O1lXholiCm0bQ
	 yVQQ/QKy1MaX8g1dljeM2TD5e2AJ9IOdiX1o4GlM8ClRcazyfLv6K9DILpx4N+2AQYcPO
	 5Q6hN1PgzCsS9YziyViilx2wBGrAUNIH8qrBpsCFY5p4CAQ8oKeB7XdHh8EvGRTzDhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="UFLi/6eK";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4615A606A32F;
	Thu, 19 Nov 2026 13:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4615A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=UFLi/6eK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795093402;
	bh=NcbY1Kwj3zdv2Zy0vTw7QH7m4EmoNY/fT3JfB7rg+pY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UFLi/6eK4QpPXFew3S/yByKSPQZ+MYlEvNo82jSUO/hcIm/rP/eI9Lk1L5RqRZ1sr
	 CgOorXoWggbkk5OXYZpwdCKUv+lmfuC2KTPD3p5WnPJKO9rXkQHzfJq+TYgWIAJBFn
	 pXsfHHRcFWM/tm4cDiRDF4DSzGH1fQ4H+e3ktCd3I2XhspXuw87yEdH+kCPwF3crr+
	 tyZyvfI6rRRpUy+DeI/aETQOg2FCkPIhFHZIl4vWqSKZ9eUtYfDaVTOwBhqt71oZ9P
	 kZZL2BWAadgwWyLJJ+/KOdXMB6X/x4sT49jqv074etdrqnZDfb/oRizOrgdNm+XPD/
	 Q+kMfHHDOrgLg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D62B517E0BCD;
	Thu, 19 Nov 2026 14:03:22 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 911F1480030; Thu, 19 Nov 2026 14:03:22 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 19 Nov 2026 14:01:52 +0100
Subject: [PATCH v4 02/11] dt-bindings: devfreq: event: rockchip,dfi: add
 rk3576
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
Message-Id: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-2-517a68c008fe@collabora.com>
References: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
In-Reply-To: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=KprlhcFVeTBpVsP2HF+tCll/JPahCV7NR/zzegHDw2I=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr+85oA6DA/KhZxvFcKYJ5gL1mhn4HeSwvCx
 38LX/KkPvoaiokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/vOaAAoJENju1/PI
 O/qaDbwP/0lQqVCYl0oxQiFuNhuSiyYsld8IEQnHlAwcULM/44a9U2tzPaBOeMtjMNpuVYaTAe6
 y5ZagRXGRGJi39xPcEUHGjREy5gRbxVkdnymsSt/KPQH+jqowW7gS18KABDqxG4YCHhaVSyqsdD
 oeuHECraLYfWIeZr9971gE+Jq44flvUcTUuv8f0hVnDT1wCVhO/M63J0Dq4Tua2ELrd6TkMaNBK
 mSTDYL5LjAwvtU9L+fm8hUeO8ZL02CNfFxm9DoDCXt/NPs1Yzbee21P6WFqZCtaxaMedcpRLKeB
 f97/kbliJ+xoeV6K2YQ2T7F+nkC4PhJmzO0PEddezCSatCbav5VWwyxgyYDjwp1Qs/Y/ZxcPkhK
 K0F2eI0gv14pYns+n7518wPWt7wT+XpckUx6CphP/WlwZ9qwfXHpHNaUw1k4A4Ftm/4bHX8MYWS
 b0NI33Z9kMv95poWeLPSd+/FqKOoKiOnGhTfHiwWAL1Gst8/y4ZGbtdQs2dp3aKQFAEV7nF4QLi
 7fw86hk3zyXC+hJ1hba/GN7Ix+ZoHkcWJCTM6qcIBhprTOQHGe68jNWAp2mExn9OeSBmtcDLguz
 uBZHNtVGVN7/h1ERQzT53JCeb0tY5m/3SCgPA6w9Rdhn53ADGNdgW943mWjQDR4+DDAq3HirFyW
 uST5cS2l+aQk5elvwc/ggKw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

The RK3576 has DFI hardware for monitoring the DDR's bandwidth much
like other rockchip SoCs do. Unlike the RK3588 however, it only has two
memory channels, so only two per-channel pclks for DFI.

Add a compatible for this SoC's variant, and add it to the conditionals
at the bottom of the bindings file.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/devfreq/event/rockchip,dfi.yaml          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
index 3450e28b4020..dcf3bbde3e8d 100644
--- a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
+++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
@@ -14,6 +14,7 @@ properties:
     enum:
       - rockchip,rk3399-dfi
       - rockchip,rk3568-dfi
+      - rockchip,rk3576-dfi
       - rockchip,rk3588-dfi
 
   clocks:
@@ -64,6 +65,24 @@ allOf:
         - clocks
         - clock-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3576-dfi
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          minItems: 2
+          maxItems: 2
+      required:
+        - clocks
+        - clock-names
+
   - if:
       properties:
         compatible:

-- 
2.53.0

