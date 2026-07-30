Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D1B3FE356
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404112; cv=none; b=oZSE451NzZ2vMP+KcV5RR751Bq7JbqA++lUzs9p96Uwm73ZgcMpxYyKZcTncoUX0ovEK7ghM+ejewl0lox9lolu6e1E7wwIFD0Rfo7BRmpHxK34mysVWxY81W2K7gs2S9/x1vBiutPECPvHMLnY9t046x36n3Um+Qq4hS17KbEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404112; c=relaxed/simple;
	bh=3ReRcSOymyULMja+V0YmUrgeSZE4hXMAgCGFeJtA1uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8U+MuOHYgUx+k45EytzXPmrzeeO5aFlSIGbnd/VZe3JZmSWORMNYF6CD9ZkJD5CwppGREYJHm2QIFJtQJF6+lRaFerkWMYJLS0SCaV8CzlWt3hdlhnJ4oesckzcuDrf9uUnNdPePg5jybZnrlN5XnuAdmkpqI+fs4z3sE7gfwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQkBZbmc; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQkBZbmc"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69c7ab350e9so3105006a12.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 02:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785404108; x=1786008908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wkDRMO/NHA8kCIXBimZ+z8/mCEPuG9r8mSJg/GLK9jA=;
        b=YQkBZbmcRi74GAKtgFKH4HVKrzOiT9W8a3T/5HryZI09u8jbQ4nQhmflf7hsmL1PkY
         2hIs+IV53gFhzcrTZtXU7RLIRsuc9GmPXjvbJI3tFpauw7b+RobAtDDHYNOr2eMoF0be
         DlSaM1/iw6ZeMy2aNV8TLNJvUTJni50Nim/uR/qYLTUOsiNwxDMml1/8RcWommBVN4n5
         Benp2ofuiXoqIs1wHzDdzroleDVAEd83PnSHDxmrU57GMB4DgjlOK4K7NCCfEat7GYBU
         JLfItZFmjoSBx+skQ1ZUhCvWEWorIYbi06Oltyv3J8I0Bs80nRmlw2IJsLxfhMP0n/WQ
         YrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404108; x=1786008908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wkDRMO/NHA8kCIXBimZ+z8/mCEPuG9r8mSJg/GLK9jA=;
        b=Hxx0WUO/VbgVIIzeefCEyl/zc2txh9deaScL9a1vUDG9uIqtG8aV1GV2d7KvZyIv7p
         AAgDykr1C3ukKzVq826Mv08kFm9johgLJGu3u3dW/0IjN8x/nsT8WSrTEkwNqOh+/qDK
         E3nEOowwJZhkmcpqWQTeGoyu/8ixxAOexgzm1xZxhIV4SzojO8fYyOD2bvlfbqdX/GBr
         p5niY5U9sdihk/Y4AJJ8/JAA/7EgurF6zAbRXypaBxQlVLd5sYHrlGHtNx4xfUGrMP5f
         GDGEDmbX7YeoFdU/3Om7Kt2mWWLOS4FSf8thJHex92ZIIhH2EUUrMjZoB5aB7HGLQrFI
         qGag==
X-Forwarded-Encrypted: i=1; AHgh+RoKs0sjE/uOUSmDxOa21V/oM7CZr2ujpBAZkacL5pK8wM67oEGT/Hj0OUvU+B281CFy3+PdxWBXzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+uGtkTP/w4FRB1nD2e1lX25gC20UNa8p7A6hAgNiW5+LaRQsS
	+nmNEezMygc0gIMVf9XL2mKz39FBJDQ7RNBvuA2gFMgzzgHbC05cuRQk
X-Gm-Gg: AR+sD109wUdtnGO8Y25kW8tRBkU/YeBAvV4yBNz/buXVDrpxHDITw8aKO9jcouVVxEC
	YqjrKzWhI5rkhTTCrHvpkHCkjBqxdLaZPndf5C6sBWyuaKKrra3flEqltFy8p1wHbXcKhnCI+Sx
	6k0XW8G+ll0WYlLq+uXSejgBoJm0uldimjsJ+wCfkc0Chw4IFrVqMBlEs0IJNy92Dd2Bax+VPUA
	bd1sMRlkxih3VUzzDIUva0qLEfm3ytDSpXVM5sZAqiPKGXzIB41sgkkrVrHtQVSEcHeaaE5ZZGX
	i4JflK1zE0wbBBbVOcuzmaaQ1PWkRgz8hZKVZ6AeVUPGvWJXgUlIm2oh9E2FlArgFCS6c4PNLoB
	N3AV69sMUqtsTnnZzkZYb39eYPsmeUneX96R8Qeirk4vjuPaIPyZsZ0g8JdC+NSuRdNNNritpfF
	LGSUuWneBqRqennUIW/EqciTQar+UcJdFgGlB9Y0P0j8kGdZP+m4GJMansmjprdxUC/efrubRFU
	PdRh9UuGHUhMrhwl4md0w==
X-Received: by 2002:a17:906:99cd:b0:c12:979c:5a5e with SMTP id a640c23a62f3a-c1fa50fa7b6mr110666266b.0.1785404108221;
        Thu, 30 Jul 2026 02:35:08 -0700 (PDT)
Received: from workstation (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8577e78sm46733066b.20.2026.07.30.02.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:35:07 -0700 (PDT)
From: Stanislav Zaikin <zstaseg@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Stanislav Zaikin <zstaseg@gmail.com>
Subject: [RFC PATCH 3/3] arm64: dts: qcom: sm7325-xiaomi-taoyao: switch to device-specific pmic-glink compatible
Date: Thu, 30 Jul 2026 11:35:02 +0200
Message-ID: <20260730093502.689505-4-zstaseg@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730093502.689505-1-zstaseg@gmail.com>
References: <20260730093502.689505-1-zstaseg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch taoyao to its own compatible so qcom_battmgr can select the
taoyao-specific property mapping added in the previous patch.

Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts b/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts
index 6f8bc65bb99b..bc4dfa49ef38 100644
--- a/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts
+++ b/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts
@@ -72,7 +72,7 @@ key-volume-up {
 	};
 
 	pmic-glink {
-		compatible = "qcom,sm7325-pmic-glink",
+		compatible = "xiaomi,taoyao-pmic-glink",
 			     "qcom,qcm6490-pmic-glink",
 			     "qcom,pmic-glink";
 
-- 
2.53.0

