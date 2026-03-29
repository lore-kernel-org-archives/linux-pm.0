Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70AD38758C
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774817551; cv=none; b=Xl6cJlE/n03+Qmp/lCvBnH1qv6tGCcWDV69cIsXrgd8QKQsnZrcFD9+VrsdvqnB5FZn3hIRbCG8Vw/MQKuuCv4rtV1HmrOBwIzyO6yje55JUrsIAKHJCfMj+Ugd2N3SH2Uq0zapelCvkWJeA5kX2/XUZzwFKTDCyMrykUK9/nG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774817551; c=relaxed/simple;
	bh=7cmGYQcvmEc1xWQ0Rcmt3muQAX4wWu1F7S2wsgbG2e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MM+hKuHO7/bETuy8v+TmBbF4lY5npXf1Yp3TMHvWA4IlkJ9X0ULIAalbM46x/A2vAQATFQP0sAmVIZIknAV987WFDejfCTLT5DIH1dE0NpWaCfbsK+iLDbo4F7QFFoq/94HlJYi/7DrmZ07lg7m2h0fHLXKvtskhwj25CXvAEEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALVEAWZU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALVEAWZU"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35c124d2613so2482195a91.2
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 13:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774817550; x=1775422350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRcoZ1iR+Zft8TDDmCol/NQjdrUX/469MdzYJEtnt0k=;
        b=ALVEAWZUvg0qWt3d5MEDWdXCwREiPg7e8wbpycvWkPxwCasTORSncd2nop35UDu/Nt
         rYbm8QXl15ssmaiBMHRBYLVLH1AFTuhvqdR9rvZroVBakICIEnvqtm/cM20s7zMF9fTm
         3SeAph1WeFj7dcrAzkrfElCDNdOnTmJBA6u3geyxM/7D3FYiBM4FmeDOKLAWK+FvuJ0f
         WSV5XkMSw6tDyxeXdVf8GQFc6ksZymTRR7zVvH6FDx34OjNMFexJC+wvJInIj4rlKYux
         jghToxK1qcDOvSR9yztFpk3MnwIBkHUnjfy6Nusw5OduMq2AukXqzcJCWBtx6Eg16Doe
         rzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774817550; x=1775422350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jRcoZ1iR+Zft8TDDmCol/NQjdrUX/469MdzYJEtnt0k=;
        b=CSSp8sD3Z7xuxUCMRcSGVKDXPiWk2q4bUXGP5FJtAR90t0o108LdgAAy/yrHC+biZ0
         P0VVCuLxbyvd8/v4+cgs4wPkU8LvSlS39HoOqQ+1cnQnx1nhfU+Oqce/Mh/PQQ369xJ7
         sKiag1lXqgjehzMl24nz7zOyUMHzThSwWrFdGMvD3nx7tofVEvNqGIYoofo5kxt2RhSI
         CFBdLx/p42FBE4QXCgc5nWMJ68LflvaVlBBtzN5DJWxLGt3MqVjc/5shtd4hSEGy1nyn
         C/CU/g77j63bq2JBbsuYSXlpC6Fpqo//t2y/kPHw3en/PxUyrsVAA+/O9GJRx/5WKN9J
         ni2w==
X-Forwarded-Encrypted: i=1; AJvYcCXLKHQV1zcpH/dd6x/3262mxHgGhvSv35nOqkVWZ/+9shj+yB+B7fWRR3KF1OlfkrcrkIrqfwSUtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaGVmtB3lyAwmVkFWW5ovwT5OMyjD77Ge0auHA8LmAeDa3A0jR
	OrgQCApRskx9iEJ7gKtDdZ2g/9YWBRGKZAsgJApEJBraK/lzXvO+KJX0
X-Gm-Gg: ATEYQzwqJrmWyZfp+dngDEZQaBdcVR9LW1rDiMl//uKeisf0dj4MONfIu8zA+O1Qqo/
	W8qi7Xy7R+cs++Ivm635iRH2gooV3DvQbhjdkOBq6qj3iJxSnB6tB5xzIjvZE1xrSz6vdGUSLVE
	fvcjYb1BF5zOcGDTAQ8GKq9nTsvFTxbsY9//buWABXBFpi7lHDCGCxupkGLJuc9MxszVt4cg5/L
	+9iVS4lSuDuzMOGi6CeoY33ggO6SG6GrR+2Npv17CLb49fmhWWiElfRJBbrpPGqzEhZZ52bpcby
	kXmhNPE83bC5LQgd/xkFipgHRcG09ih+JG1d1jukiQft886D9EDaNzGjZAxNDVpck4wiJczrjvg
	BTSVpZxGV+T54LjofLUsvTESuZIZ09r8V0cQLJ9LbPlRnIci5+UPJFcuD9hIqZConp3GUEVqGPb
	lLYY7kkQm/n3JNkBsIPXa0sF1TDsp1
X-Received: by 2002:a17:90a:158f:b0:35c:30a8:327 with SMTP id 98e67ed59e1d1-35c30a809demr6408184a91.0.1774817549987;
        Sun, 29 Mar 2026 13:52:29 -0700 (PDT)
Received: from snowman ([2401:4900:646d:9af6:7748:701:6c70:4173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22d8c500sm10423412a91.10.2026.03.29.13.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 13:52:29 -0700 (PDT)
From: Khushal Chitturi <khushalchitturi@gmail.com>
To: sre@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulli.kroll@googlemail.com,
	linusw@kernel.org
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Khushal Chitturi <khushalchitturi@gmail.com>
Subject: [PATCH v2 2/2] ARM: dts: gemini: Rename power controller node to gemini-poweroff
Date: Mon, 30 Mar 2026 02:21:51 +0530
Message-ID: <20260329205151.15161-3-khushalchitturi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329205151.15161-1-khushalchitturi@gmail.com>
References: <20260329205151.15161-1-khushalchitturi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the node name for the Cortina Gemini power controller from
power-controller to gemini-poweroff since node "power controller" is
reserved for power domain controller.

Signed-off-by: Khushal Chitturi <khushalchitturi@gmail.com>
---
 arch/arm/boot/dts/gemini/gemini.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini/gemini.dtsi b/arch/arm/boot/dts/gemini/gemini.dtsi
index befe322bd7de..c524adadcf81 100644
--- a/arch/arm/boot/dts/gemini/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini/gemini.dtsi
@@ -228,7 +228,7 @@ intcon: interrupt-controller@48000000 {
 			#interrupt-cells = <2>;
 		};
 
-		power-controller@4b000000 {
+		gemini-poweroff@4b000000 {
 			compatible = "cortina,gemini-power-controller";
 			reg = <0x4b000000 0x100>;
 			interrupts = <26 IRQ_TYPE_EDGE_RISING>;
-- 
2.53.0

