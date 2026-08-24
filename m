Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3292403E9C;
	Mon, 24 Aug 2026 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569822; cv=none; b=paOoy9eQ5wqemF2r6qEiOqDkHRuwRS0QcaALthupUq+jGOpa2NRtPwQQvItms9zYqzogCVaG6Tw/kk8tWz6lVD4Iid2YfFEVsFuESMe8J8DHoSUVAY6XYo0uDTnmUUHWe1CUlGrv+CkrEVr2Jvk3GCLZSf/krxyzD4F085yFAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569822; c=relaxed/simple;
	bh=ahDUcj8UgLsyiaiC/TtnLv9jJZ7tWQ9JqdAkbOdiBq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJN8B7VsmYakB9fCgkFDpNKyU1uJd8X314OacwojMIhLWPY2CHnUDnRV6UHq5XYEEFJHs3wTN5+or9a91Izu2k883+0ikwzZILT+aY2QGiYgiPCbgtwiBEjICgo+oLbzN01KeSc5CfX0dFQ3akTvBi2LHaNyqs667UNWItDLCqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=qkyK8Zzr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KDkI+c3y; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="qkyK8Zzr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KDkI+c3y"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id A0EDA1300135;
	Mon, 24 Aug 2026 07:10:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 24 Aug 2026 07:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787569819; x=
	1787573419; bh=h5Iydu55nn53/E790W1X0ige2y+XDRJOVkvd0LR/QSg=; b=q
	kyK8ZzrzLMU66L4//CmQ4FbO2ncqU9rEgQgkjhDhll7pqTjWb1Aec9+FYNvh+/dO
	aaFqX/6DpkKY1aK/0+Ucp1AXo6N142fOF491vSQunEYdxqESOCxoCjN8A0OgoeQ7
	ZUz7Y6w6UFRYBDUwQnElmro13Dmt0u5reRiRMSUGeFq+D4vdRciD05ZIct7y0UzT
	GLwYUe1w5U14br2tPFUchCJF9Fm5GlZ5Rss1oVdl4Fuo8+3YrZVF7f6LXZl6Q1qb
	8ma9zsDcY52JE62w0P9wB9NNBGpwuyWdZdBKBW/f6BHfoBFjxtmj9kNJMZc3hqOW
	nhXxs5KFZXcT75EaLJiQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787569819; x=1787573419; bh=h
	5Iydu55nn53/E790W1X0ige2y+XDRJOVkvd0LR/QSg=; b=KDkI+c3yAe54hrqPE
	A4F+dwW9Obo7ntOquRIOjthw8Uu3oCQ0jGfzLhuC/PpmpULgodz0UTjeyV7GPMc5
	a52babmw8TRqi+GaBkProDMSUtCGOoJtvSjX2T3P7LNEFCXZ0+G3aKMe1Zp/qo9l
	F/XC6R+zcm2WVDbLT2ufEtBnlYG2o3PN1yEwkEOqXLYVkrSAdbfnnhiy/LcmWrae
	n81vEtHCLiuTp9IlAc+FYSSFnjtKapuBQLdwEOf6y1nVH7Ft7RHLJb7+poSFCt/8
	uG5iFigW9Vkk4qHEecPVPUVrffvXcebP9zeEC9O9cw7so4iW6AsENMk3IkEL8KfS
	CBvUg==
X-ME-Sender: <xms:myaMapPX9NbXk0M79r1K_iB0NX5QjonivnamIuNRLy7HYVpqLEiD2Q>
    <xme:myaMar1aVNaj624QQKdusugZDbzHVtFhBZ3Y90Vo2gmJD8xEN9OIpDzSEaRotKkMy
    jQsqD3P86_bo9DLAmn7k62E4dCGLQYM3exQQilsthqoICa243BA9CQ>
X-ME-Received: <xmr:myaMall3hO7yTKRcCLV_6cT4qXhRUBHdA5hQ2gz8lWPmOXNebNt58vtljHPrdfAdXuJpgr-Y_w>
X-ME-Proxy-Cause: dmFkZTEoTuOQ8CkDOr6PHsdHjyNpmMRTSMw6TbutShlZvv/e9dHlUX0LTuKilBgPj+FGDY
    wGZ5raHDDvYuzSJIRw5yITOS2MRAdjkLG7GVQ7K6zeyx429EPeZfhyBXw+vKI4ICZEDq0z
    hwhV+wJ7G4Unacn06iUnrP/rilDDCA3Jg71wUyGE6K4Hgea5BaRd/VYv0EMCnDQn+poQw8
    /mmD3ohYTmBSZCQ8I1Odf4JWSYcamidkMFFJ5Be1c1CYlggmA3M6dZKs9QEVfuJE8xKZgI
    VmIIf9AoXdZwwwCIMwT/ySGBUP1pqX0HVciToDi/WJNqD5jKBBcaH22+G3E0xnWn+jPnNn
    LfqCm0aOIf7YED5ZaXiWcNCUT8tH6sO7lPhuEzmaJBzmjMoSbdfrQIse64fJwF61cPA4wq
    16teEXR66H3UZDMFgZosgr74ra4P6FGEZoe9Jf4Oy2v4srGfX7oxgVisPXJDyimfFYCDNk
    WM/DiWndT81IRgeq06YuipBX0kusFLbzSHn9U5vpNl9GdNhlBVtFXzRl2Rw4TE1pokXYSZ
    6dfWhW2XLzML2XJQNJkw6JTiHlTLz7oBZHsRbbgArhO/Frij6OUqA7PdaiS01crOkZfu0u
    PIlxNxQ38jrBN0Hm3VuQshw9268Z4wt0oudxhIpRMY3mS/S7qc7xCJZkWCZg
X-ME-Proxy: <xmx:myaMah5-Xa1kNiFYiH8Od-g1kFEMdqMv4zFtXQiukQgyxgsMdcJq3w>
    <xmx:myaMaul7TU5vlGHSRMyNHZOKkcxNTUgJv6eM3E88uB4avqLiJcW7PQ>
    <xmx:myaMajRe94_ccH1IXgvHpFkrfdCj2--s8OMoy29ldrWmztzXXGP0mQ>
    <xmx:myaMasmPNpnLagNqnV8miZ4F2n__QD5lrSnnqfW2Jd3gTotZwd1z0Q>
    <xmx:myaManEvnRlaKfb7YIZMYUC-xVk3GqDe6IyugY7YWKtj0HGWQig4n-ET>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 07:10:12 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v9 06/13] dt-bindings: power: rockchip: allow resets in a power domain node
Date: Mon, 24 Aug 2026 23:08:55 +1200
Message-ID: <c34278613fdb483ee7d771077a9451f66973e89d.1787568944.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some domains do not come up in a usable state on their own and need
their resets cycled once power is on. The RK3576 NPU domains are one
case: without it the first access after power-on takes an async SError.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 .../bindings/power/rockchip,power-controller.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index b41db576f..83741f048 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -136,6 +136,13 @@ $defs:
           A number of phandles to clocks that need to be enabled
           while power domain switches state.
 
+      resets:
+        maxItems: 1
+        description:
+          A phandle to a reset that needs to be cycled once the power domain has
+          been switched on, for domains whose logic does not come up in a usable
+          state by itself.
+
       domain-supply:
         description: domain regulator supply.
 
@@ -216,6 +223,7 @@ examples:
                     reg = <RK3399_PD_IEP>;
                     clocks = <&cru ACLK_IEP>,
                              <&cru HCLK_IEP>;
+                    resets = <&cru SRST_A_IEP>;
                     pm_qos = <&qos_iep>;
                     #power-domain-cells = <0>;
                 };
-- 
2.43.0

