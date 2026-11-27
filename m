Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795793319;
	b=oj9DNVEJh7UBcD5TDEKQJG0tnLCLecO/7tFKJJarhpfcyOx/RGAaHXOLUQmeYIxXXVCj
	 PNS7mBGp3rhb9mZzpZbFgpRLim6CvCTg4N0svjVgRgsmyvmAdvNBHtUWk3aJ+YxpTdnRY
	 hSGaRT+AdAVUDbYtS6fCK38yzFcUmfCYAeuVWvKOLhp2rPIgyVhPGFu+G6DGa4/w/KQPB
	 YDVq2vZ0LpTmSfjZZ8iSSHYYBm7jCoizU1gy0J5p9ZF7tLLnrVEd9h+jj9xllZBtSKHAs
	 3bs1SYiw4JJQjVuCOrVaPXGuh4FEw9iIN0MF5mBwajfHs7dD1N5gao2BPRuU9qVYROg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793319;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NgtfBGZW6JnOX8QXxkHMy03vg6zeloIYXjLXT43yxao=;
	b=GrqX5FJoL4TzLPy5mljSGlxodL5M5+nDHI3SO9BcnEOfwclhTppzM8jjiJAzfdzXzpV8
	 FHDNEGaLDmg7m3FrWsmVKzPVRWvGNzBu2BAseVptm7pf5O23kOb1YZdajlYpxEZccG5MP
	 6eX/ZcUA84kpDRrfsqmRsqsFaD3htgGY3OJbg59Au/YGMu2XGSIqYrtoIhjIhiM0Ebhm6
	 dQVWZhNiGruRFjr2qMfYyisjt0xP9x52yl029nXGJZT/iBE4puxf/lAFK8wt8CRn0iJuA
	 DaaAWUjh2vintq/utpYBQXcRqM7Sjdw/EBYRH7N5SOd1d72aWxSzMaLROAUjPtGprJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSXBaJiH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DD6606A31E;
	Fri, 27 Nov 2026 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSXBaJiH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795793319;
	b=uzcmpTkgpFLFHg3B4Eq9p7aJZRCbVi7+cjmCW1Gyx3ESEWiIB1S+eL8W5MJEHWy2Ube9
	 Ms2Z9ahQft243jk5HMkPpUSpr098px+YmMbHof/pB1r4qIr/HIf/WIu5aaAYhCpJ1QHQC
	 YpNIVw6ZhiQgis+Euv63S3Evafl6ZnUBLUmpZU/ra/UN0gh3IQcWi8PRrtRj5PuhiBgZZ
	 +Dl2I/cYurEuHa1PnrVb3/iVNQYoUDkMFwtFZXYzpVHFOqhOxwXbhEsh93PazA2VO62Hu
	 h6sbkjVFrHxx4eUfUOJIP2jCQVTKtWlFETYiYPT2tBwineSyB/iueNQ3B0qHWvGKf/A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795793319;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NgtfBGZW6JnOX8QXxkHMy03vg6zeloIYXjLXT43yxao=;
	b=uyIk8w4m9YhhJ+31bwnN7F4STuE7Cb4eN22JOhRRCU4WaalvchBQs/saKl5MVEtb/T2R
	 Go6690089mjouxnY8JwW05MXvQUTlzpbdKFqhOFbGSPYR0sG9rIHhityZmj0k9MMteTPU
	 Qd65HgnyGPwXqFlrm0RnY7k22m622nLENJqnfqHeDF5CUgx02EVvgeWTPNVaTzFC+XOCv
	 2tgzvKKi5G14BO7edUEX+hCajEt1lrlT2bI5DuruCB6R+wAO7iOzV0yuVoR1yKJFvF/AA
	 MVUmhtp291IWuOAzQwLeO+voOchVaw83SB46M2oOe6gLEsi1A/w+iY8oopYtQkqu4DA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 60A821F00899;
	Fri, 27 Nov 2026 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793319;
	bh=NgtfBGZW6JnOX8QXxkHMy03vg6zeloIYXjLXT43yxao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gSXBaJiHLLiZ+4DbLwfLbKXGfKxEqluk7htCpxtmIHraem3dzdLUUJUW5+W+pz8fC
	 Rl9bAc+drgTxZdpFHZjwiMd04NWhsRf9sHCOuxJy5ccLWTgWhTBmqPq1Zm/C2a85GS
	 lGuQLysvddprG++sngS33ela2k3PBIn79k8Z4mpMd/nkE5ZdbysNR1hee39eu74gNA
	 6f6aPOGfocoSMFLomDCVGVtoErHGz77xdZU+0in8c2Ma7PF+wvNohyKK7E1PfbzsEn
	 9EzeQvktoSnf65BkmYTZC5YvqtcWQqoOrIfzzn7Puuw80vVqhewbgt2fb89OIGDrQA
	 Z/4Q3Ku/EcPdg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DF4094DC71;
	Fri, 27 Nov 2026 15:28:28 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 27 Nov 2026 16:27:02 +0100
Subject: [PATCH v5 01/12] dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl:
 Fix compatible matching in conditionals
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
Message-Id: <20261127-meson-drm-create-hdmitx-phy-v5-1-88c43eb95468@aliel.fr>
References: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
In-Reply-To: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3283;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=PVKFWIK5TVZ+BrIG2D/sPckomoO1CwEMBpgyzjwKon8=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbnwo4lXSy+ejIvDHe5M+3L5snh+DcrYbFnrZmTR/kSO
 R31J1wdpSwMYlwMsmKKLP1zLU+8u3z0zNc96ikwc1iZQIYwcHEKwEQ6tzMydN89U8+sm9O3Kl6s
 /TXbUd9LenuaNl+q58vjUGg6yC/2g+EPz77O44zd728/UEpj2eEYwpKyY8PJxlk603Mc9oYHxNk
 wAAA=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr
Content-Transfer-Encoding: 7bit

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

The conditional schemas select on "compatible" with a bare enum. On a
list such as:

  compatible = "amlogic,meson-gx-hhi-sysctrl", "syscon", "simple-mfd";

an enum applied to the whole array only matches single-entry lists, so
the if: blocks never match as intended and the per-variant constraints
are not applied reliably.

Wrap the enums in "contains" so that the conditions match on any entry
of the compatible list.

Doing so exposes the "phy" child node of "amlogic,meson-gx-hhi-sysctrl":
it was forbidden (phy: false), but some DT legitimately describe an
"amlogic,g12a-mipi-dphy-analog" PHY node under this system controller,
which resulted in dtbs_check warnings such as:

  system-controller@0 (amlogic,meson-gx-hhi-sysctrl): False schema does
  not allow {'compatible': ['amlogic,g12a-mipi-dphy-analog'],
  '#phy-cells': 0, ...}

Allow the phy child node for amlogic,meson-gx-hhi-sysctrl by referencing
the amlogic,g12a-mipi-dphy-analog binding instead of rejecting it.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  | 32 +++++++++++++---------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
index f3a85c67ce8a..285edac4c082 100644
--- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
@@ -40,8 +40,9 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - amlogic,meson-hhi-sysctrl
+          contains:
+            enum:
+              - amlogic,meson-hhi-sysctrl
     then:
       properties:
         clock-controller:
@@ -53,9 +54,10 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - amlogic,meson-gx-hhi-sysctrl
-            - amlogic,meson-axg-hhi-sysctrl
+          contains:
+            enum:
+              - amlogic,meson-gx-hhi-sysctrl
+              - amlogic,meson-axg-hhi-sysctrl
     then:
       properties:
         clock-controller:
@@ -67,9 +69,10 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - amlogic,meson-gx-ao-sysctrl
-            - amlogic,meson-axg-ao-sysctrl
+          contains:
+            enum:
+              - amlogic,meson-gx-ao-sysctrl
+              - amlogic,meson-axg-ao-sysctrl
     then:
       properties:
         clock-controller:
@@ -81,17 +84,20 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - amlogic,meson-gx-hhi-sysctrl
+          contains:
+            enum:
+              - amlogic,meson-gx-hhi-sysctrl
     then:
       properties:
-        phy: false
+        phy:
+          $ref: /schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml
 
   - if:
       properties:
         compatible:
-          enum:
-            - amlogic,meson-axg-hhi-sysctrl
+          contains:
+            enum:
+              - amlogic,meson-axg-hhi-sysctrl
     then:
       properties:
         phy:

-- 
2.56.1


