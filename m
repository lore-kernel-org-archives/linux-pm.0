Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184200;
	b=rjcCJoy4Q2/1ndN98FKWygUis7y5Q33rJbR0Npo8QhK/ISRG7oq+94GmrTsyBkbxxmqc
	 Ko5j2WrmZilWgLuNB3I84VlT76OQMFejnqs1u0xGLW3KVRmp7IuTJWP9XNo4msDx1br1g
	 Jcx3UkMuPdvD7tQqXEmv5FQVCu4LBbBBekPXWNv/qYyUnqj0VWqrvYLcfCgiyZ8kFiBn2
	 ha3twNjUT1M8j/Mznr267WcrQA3jdx6M4BoWKn5rMS4IiqwNia1qpMH8Wgnbj9IEr6d3C
	 GoRKIrQKjo5wYlg3KUH8hGH9aGTjAec695zNfAFrFQVkJRu8I88uc+/H96l4LO7cNzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=3EKd0ikyZyrjPebrQ1IcrIhfAZXuC/dKRwkgcXP0o30=;
	b=rd2UYUvZ6S2Xv8UWTIHaRarE3d/ulUwmYIHrAR0PaEXgpSTOJms89QLJHiTSEDBIi3rN
	 GCl3Eby8lrG4tEz6ccQuAHLym21q/nL029Vuyec23HfPRThAqhf2pjs6ocLP92UZOceI9
	 X2+6HkOnQ0VH45Poo7SrhMHI27f3f3gRWptBTwU4rWewumx8nMGPWjvPjvzPy9D154W1V
	 gFGCYLAYU3w4xmzEFI0UoWKf/CFaODD+9SqAKuZUMECoPnRIxAfR7FCfMUL5Qb50aJ9X7
	 4+VZSoVGbv5mpVNIPmDqGVJQtuCbSy65XijFXOhaOUdt6qzTejTjInEyzbylCMKMfPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ify8EiE5;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6BE606D818
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 00:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E6BE606D818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ify8EiE5
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e4831c028so388783f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 16:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184198; x=1794788998; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3EKd0ikyZyrjPebrQ1IcrIhfAZXuC/dKRwkgcXP0o30=;
        b=ify8EiE5p+68P5QNKi+l3dMtkPP16GvbYO6rdEREedQp2Y9270NLejDTyHFsqU2gen
         7vTLOi3RvBgCiN8Mf9HuHJVOnuPBWHxNakhf/9Iu89b7iFMixvQ54a6T+s0nmCq9NoTB
         kRLzVRg1hSJ+jE+kmackVFXicz/DARG4u0+D2piKXAQ2ukbejN2x93kygJJQ8b8bKznV
         C4j5/4V51GG1dOawM1kfnCb3gADE8wbzZE1pn5BzgxeGtd8cbZhF2hsv4CoXz/f57CkJ
         K7tvV3a41LnN+CYcEDupNFekHD5GjCH17lZ+Jy5CrljHBxUOPn1CFS/eRagGFmkEAyIt
         MSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184198; x=1794788998;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3EKd0ikyZyrjPebrQ1IcrIhfAZXuC/dKRwkgcXP0o30=;
        b=QqZc9iJQCHmpTB/K3MecCLw4tXyKWo7+XpQkso2qWtMYm0yFgpNVOZDmqrXEo9VcJO
         cr6eI+qPIMAkVBH0DCLJhQd5jPUgEEJ+JbYbj+UAMe5iq0yebCivuIw2T7FwGM7u3OJG
         1mit4cB8Z54A2lNzZugS3nJ0jDG5ijrywfQL8jbYtd9M4tEPJftqHrOl+LYXyN2rR0/p
         P8lsQ6qJwV7bs4EIhAqAmNmDBIh9S8niN1qYNceVULEcBAZ06E6IBlrCX617O3dS+0pL
         Y6/FGKN4R6ZbdHa9Ly/zEeIyb0XD6degPt2LAA9M9WPbvIVHnKSxFwqyIGselnuiIzeB
         YNQg==
X-Forwarded-Encrypted: i=1; AL+hErFjiUaomNE2TKLvDf9MPQ1RqCnFz0kWJErvYdovXlbmNMw1C0WMUof+T0bl9394UVyKOtfeuPXUjw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+lIi8UQJn+/qJncuxyadLR7s6AHwuW3ZBNVahEOr0cY3m8T1F+
	uPOaiQIJSWJQJFfQPzYQI2/QtRmXnsmghRLWxvcnwz6iVtqLGEQEcctnJoHkKklN3As=
X-Gm-Gg: AYBFou3UWf5TWjqDuAOafSNTpUG29G3UlznxJX1pftgf1q9WrCPAYyhwaW+PWNOL1Im
	x53g2xptJlt5D6IuNHc/QIGLAOCclf+DSVvXGT+15QrBQyG8OOH4GAyEQqsjLd9Z8wO4T/x3lR6
	XSXaxJJ7or/chRxJsv6a1C0kCQAAlMfMyUkYw+mzXUxW+JQsNw/Tk5MWj1xQcPze4z71ysvqN+0
	KGBp0Pz+tHTqiuKoMm453P2QogmFwyEslsVFgAA1/66Fk9cx9vquybSYZlbYZjRhtgevikcW3Kg
	a94t/klYuB7D24FskRoUDXIpbcBk9c3G5j87hbtNqaWY8n8vbuA2zrpAjDFpDlxtQNK3igW6yyK
	JvRFpK6tM39entIvGIE8qCmcUN62V7s09Sg3zDltLdwBIo1PoSIEcupbGQR9HTQx/har5pVYDfR
	FXWF4AprcZfhJC2uOrUYTEkU57M/YuD4W4ASFdKFAWWT6uNmPGs5zhuf6Ow6OUm7pC72hGtQAHK
	6OCJoVtP4bKfi/1UuTpq6H0ibuif/Koe2DcydF4T2IkT8wGFlYw5BxcXKp4DVUI7XfUx6XGhjZU
	qlCZbNwNYtdbk2qnEyT7/mQFR2hYHBRPx8mSeXTn
X-Received: by 2002:a05:6000:1a89:b0:48d:c186:dcc6 with SMTP id ffacd0b85a97d-49585f85ae7mr6393858f8f.57.1794184198082;
        Sun, 08 Nov 2026 16:29:58 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4967a70a35dsm3479742f8f.9.2026.11.08.16.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:29:57 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Subject: [PATCH 0/2] Add interconnect driver for Qualcomm Halliday
 (SXR2250P)
Date: Mon, 09 Nov 2026 00:29:52 +0000
Message-Id: <20261109-halliday-icc-v1-0-def7cf786f75@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAU8WoC/yXMQQ5AMBBA0avIrDXRppVyFbGodjAiSIsQcXfF8
 i3+vyCgJwxQJhd43CnQPEXwNAHbm6lDRi4aRCZyzjPNejOO5MzJyFqWK6OkFA1qVUBMFo8tHd+
 uqn+HrRnQru8D7vsBiUZdo3AAAAA=
X-Change-ID: 20261108-halliday-icc-65a5442be859
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184195; l=1171;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=IRLmg/T4Ucg8fvDrl6bT8sXAYm2xObD8gKEFdhhsCHE=;
 b=lGzTTrqn4CIpaQ3yuUtw71gJGLHu95Xl3xghzfcX63IbzmYYaFNRze7fyq7lB969c/V+njIFx
 U3IaqwXIkvaD/gi7THqtoaOagrl45KEfyz/rxyv/2ExdFssL1eFvW9j
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document and add the interconnect driver for the Qualcomm Halliday SoC.
The display BCM voter is left out for now.

Halliday (SXR2250P / Snapdragon XR2+ Gen 2) is the SoC in the Samsung
Galaxy XR headset. The DT changes follow in a separate series.

This work was made together with Claude, ChatGPT and Gemini.
Reviewed and tested on my Galaxy XR.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
Stanislav Aleksandrov (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Halliday SoC
      interconnect: qcom: Add Halliday interconnect provider driver

 .../bindings/interconnect/qcom,halliday-rpmh.yaml  |  131 ++
 drivers/interconnect/qcom/Kconfig                  |   13 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/halliday.c               | 1909 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,halliday-rpmh.h  |  158 ++
 5 files changed, 2213 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261108-halliday-icc-65a5442be859

Best regards,
--  
Stanislav Aleksandrov <lightofmysoul@gmail.com>

