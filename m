Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26702C08C8
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774768018; cv=none; b=WuCb48BL/Ax7tyCD0bl3H/NEcqITcpE9im0LmDVnFR15ipZgnuCbxLHYmQ51Azl+n48MHVgdR5Az6AmGEe6vwizPqYYh14QNfqENV9/c40rfYjl0/a2ONs9tKNBJay55loT/hczAVp4TLyOCn9/UInCG8F9034KJEL9XY6kBJzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774768018; c=relaxed/simple;
	bh=TIUrJlohH7zzcX5wL9kNLLx0H8njEDL4nmQhrrq1NaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcMP4GWNTlrtTwmDtzEG2uQWZUuuScDxy77UU9jwRQCFUmhFru9wfmTWo4SlqdMZ9ah7GIqfiA0O9TGek0GbtZQvx2MV2WnRXFX0Qvb2MUz9oRp12Gb4BjuaeKQTWilLmG3D4vn6Ti1tLTspnWeVhAnyD+euQ1yZVzUA1lFUN04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pto9I7//; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pto9I7//"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82748257f5fso2366342b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 00:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774768017; x=1775372817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/Kc/rqS3O8FcnFqoMXkBJLowbwjhPQjCnPmNyfgP7g=;
        b=pto9I7//0Fy0MFrQuTUG1Tq5FFy40rNEJsps0hcS6WkkbPs90mtmYJTUyklAg5XQ4h
         CR1h+P/3TKSCmhoNQ/dPnEdyLDvf2eTge4FnTrlll01MqgnB1AmREnQrg/RApb7T4PhG
         SYKIMKzRHX7DYEQzAE7BCDdg+dU+Sd/LGSA8mW9CkUi6JB7fXIVrHR7N5cgqrZabuTZC
         c2GJJK0SID8GOy2UN2lZ9W/bSI8Ihv+zCTvOpM/7UM9GLLD62Of9Mqljy2RmoI4Lm0Yd
         F4gYDgI+7qmkPFMZX4VsICPytF7oSugRHUDgVB9chBTM7vLPGW/ki5uY0qJpA0BWgcWx
         WhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774768017; x=1775372817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X/Kc/rqS3O8FcnFqoMXkBJLowbwjhPQjCnPmNyfgP7g=;
        b=D3l8dl01U2qbrx+Jwk9sFgsuHenzdea1ZPvDMQxC4B77Sn7MUJjM1OED8i7l/rA/H1
         zTwwYqbNvIzhyVDfwG4v5lTSEyZr9MLJ+OmauEb/OPwYZP/E41QoSMQ41cpxPWgVSPWE
         XwinkRS7h3Qh1hEO4x+Ro0O1/7HNNAzQk75UsvazkyJ7SsLRVRCYCkcZOw6tRh036vQ0
         BbG+stw1g3aGPacwQpjeTGkgsWIrOGCYW24ijEWF6gzfcp3NLJ6F2moK+rcyVo4dFgiZ
         j6CAmji92tCNrWU47YHuxFIOoyL2FP2jnXR0QQi730qV4xS75bfl/WinLfSCa323stIG
         Zs2g==
X-Forwarded-Encrypted: i=1; AJvYcCV2hVP3Rf+nkMhz8qC1KFowMtKPfikHsBNEFYa54yYcOuPPwpN6ryYUGq4DSI+nMa9ZZ0eN5uRa/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdAikb80Z2dA3Ot20t8R782kVCMOoiP4SdYBYEQjacMrQp8EVV
	YpTXAtIXWY2mCj1h107b8fYDW1Ncv78DwOZCUz2elN2ymMBmGW/WpHw6
X-Gm-Gg: ATEYQzydWFOuEA/HoTBwa6sp7fpzS98eYw9p/c5sk+8ngHFCj6hhSP7HEAqxlnykr14
	lTxObd2RTCXXXFCHb4U4tMGHj5GhBMtv/gs0+Gzj5EzVg9Xb0oRNISWCour0z7RrNASynwhIPwi
	Q7R8sPsgwu5X2eKELI/INGzLZdpPcEqqUo+9RokIuceCMMuXuAqKkbCWbk9I+MDJD6UtP64kpzS
	0J43q9pagj4wvSKC047kCgLqLhbdqMH43LMNGoTvlzYXbT8bn93Oe7qXM8SuIr4tU9HcVrWFkkg
	VyI8imZQL5IA/cHTvDvAJqyii5Xos1ZZLPZ4pSxYvnnRWAY0ENl7YwWlBKjgIIz1risBA2o4m9B
	E5rkVOBX3WGWoYh3ffi9jtBUPXtkbDqUB6MdwCXPZNwyo0Wfu4/oFXoEwQNrugDoaOZ5W1XC/rG
	59E3tLxojat1F4Stwa9sNXAiDFggkbXD+fRJSJRgR5hBs=
X-Received: by 2002:a05:6a00:22cc:b0:827:2d7b:5038 with SMTP id d2e1a72fcca58-82c86326de8mr9740481b3a.5.1774768016837;
        Sun, 29 Mar 2026 00:06:56 -0700 (PDT)
Received: from debian.killsync.com ([103.85.207.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8437441sm3911640b3a.3.2026.03.29.00.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 00:06:56 -0700 (PDT)
From: aravindanilraj0702@gmail.com
To: rafael@kernel.org
Cc: daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	srinivas.pandruvada@linux.intel.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aravind Anilraj <aravindanilraj0702@gmail.com>
Subject: [PATCH v2 1/2] thermal: intel: int340x: Fix potential shift overflow in ptc_mmio_write
Date: Sun, 29 Mar 2026 03:06:41 -0400
Message-ID: <20260329070642.10721-2-aravindanilraj0702@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329070642.10721-1-aravindanilraj0702@gmail.com>
References: <20260329070642.10721-1-aravindanilraj0702@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aravind Anilraj <aravindanilraj0702@gmail.com>

The value parameter is u32 but is shifted into a u64 register value
without casting first. If the shift amount pushes bits beyond 32, they
are lost. Cast value to u64 before shifting to ensure all bits are
preserved.

Signed-off-by: Aravind Anilraj <aravindanilraj0702@gmail.com>
---
 .../intel/int340x_thermal/platform_temperature_control.c        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
index 0ccc72c93499..18ac5014d8dc 100644
--- a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
+++ b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
@@ -138,7 +138,7 @@ static void ptc_mmio_write(struct pci_dev *pdev, u32 offset, int index, u32 valu
 
 	reg_val = readq((void __iomem *) (proc_priv->mmio_base + offset));
 	reg_val &= ~mask;
-	reg_val |= (value << ptc_mmio_regs[index].shift);
+	reg_val |= ((u64)value << ptc_mmio_regs[index].shift);
 	writeq(reg_val, (void __iomem *) (proc_priv->mmio_base + offset));
 }
 
-- 
2.47.3

