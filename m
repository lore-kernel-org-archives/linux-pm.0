Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FF337F8CC
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065845; cv=none; b=V81Yg3SYj3uTzlgZy9mRkgA00K87EYDRy2gNkYgEKZnR0FeVt6aCFCdRkhh1bZbQnnqDT4fOJLD6R7wIEVZ2DSohyqBwJE+ZDKTkm6F9CBhqJbAdk9SeSqyHldv6Zj6/SuDUU6E6qYkgYzJKmAPHyOfplNZTEaeEjVq2TIgDXtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065845; c=relaxed/simple;
	bh=XZ4hAV9fFse8n9VMFwqhdJ52136MQa8txkIr3VvJTkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OEjidEtTIMd1U5GrvzkGlNSEW1uaUukVF/do3iz7uOS4tAB6QRQsvJxTiI9h49pR/p3ibsSE/ct8h3X+QUUQPqMIIrLjAv21C3FbzggI0mj+JRbkQM4yf8eHAGjmjOaFHZgQhUCVVB5P+gvsmx0dm2q2S4yDMVauRKGSc83etpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/DGuEHe; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/DGuEHe"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1671ec8692so646010566b.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787065842; x=1787670642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=teOP2uP44OhR2SoM/Oy3bMAWk99Bs5sno8zRbiNQZ5Y=;
        b=D/DGuEHeO+ZGhi3uUHyS3stYHnY8PbRP4mDb0E4410URH5OUkNPY2cJXLOB/nkMtyh
         v4XM/9Ezio7l9MTHzX7etGgJMFY5FxwaarzcJJWykYPCO7HfmI8KRdnJjW8wqoLkbvbz
         WAHI0HJ12qSvf4Bi9iSHTunEs3ZvgNwCWedvZGLREmJQ+HUnP7V5vMRDfBgV1S3dAMeS
         Ttf3HE8/+bGSQE9zk/MYjNuCD8cSP8S8ufFQMbe7lZgwJLkbatiGncJyia6ht5JAzaVh
         tFb71yWSHh78h4sJffcVlXu5ufV4l2To0uRyh8CdZwdbPSihNoUXnvwSlcYGk21fEwSn
         hUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065842; x=1787670642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=teOP2uP44OhR2SoM/Oy3bMAWk99Bs5sno8zRbiNQZ5Y=;
        b=kkwthqeu7wUYlVO8nNTVipGwPR+osfSA1pSN0Qq5WYEhQfn1r26RdLikIXilnxHXIv
         gDYp+wG61Eo2H210J0BhMfcsJlVbVDEOgtP+/Utv/1exkelocJ97MY3Rsx2/ymtJb2+O
         xQ56u/h1oq+t9d+Jro7qCpWPS6/7Mtu8V2kPBtxAfBwo0xDIyd5baqXHL6YZ46kgA8N0
         4VowaDVwLWeYEHfO1h65WLP4FoPQS+tBLAN1isGXWOJes82w2/Z0q6U5UFX0SiXtuDKy
         lBT8WVlSj8uIFg++86Tmxnjbd1LEqzZLxOhWBsqlnvDRiWDXScGrsQCMBjy7QXCnewqC
         HOqw==
X-Forwarded-Encrypted: i=1; AHgh+RoaEWItbgaRInSdy+9uDc3EgOl65HdPLgLXbCTi6nRtDZ3d9fKsxnKSpH754/oaZYRO8Tdmsv4+kA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4epLZFVpIwDC8XGut8wN5xI+UQwTeG/Alu4oi5rsxJk6mX9oK
	Os1YsYaO/vqN4UHzZPOfDqIqj+Ewd8lVoJovdSxlV6mWnfvZO9XJsMnx
X-Gm-Gg: AR+sD13hdg+h0z6FMl4KT/xZeod9EAmXApFtpH8B3KbDGzCk5Nc8L/pVKo+KPQIj3SE
	qAxXb2Uqw2P5YZpYwS3fBcOthoFKHhYtpc9mt0YJcj+KyyF5FSlik0E/HyuAU4Ri5Ek4hkpvNO+
	L2gt4vbtepwt1zCjFIybwoF7xp1fRU2h3UXwKO+Z9VrBmEMjLVI4ABFVZ53NNIPZ2A2BWpz5BEh
	C5sbKMmU/7rz9uFuPw+SPa55H9M/0feOd7W5TDceoe+1llcdwvmH/ytaY83MCtA58sEDkbnP5Nv
	B++VV2y+7vbBS07M24izn9GpwOuFtifqr35uGHHpuocFVTqLWRmrCXyqC0GmhF2wXegdR2hanl6
	xqRUfHbixaEg0zHuxDOH5x9DjuBAKOKKXTBL5RhC/wb2dVAQT2aSijIruSQe4GxHqwPA0+OmYkt
	VqPVhSN18TkN+Ue4/8eIbaSDy7NSwx9FDfEIOOiHcvPHtUvc35aTKmhq9zU0cwER4IAOuMVg3pW
	VNZGm3xMZ6ciq9YWcuQcQ==
X-Received: by 2002:a17:907:928c:b0:bf0:b39:dcc8 with SMTP id a640c23a62f3a-c212a1da2bamr1864248066b.26.1787065841859;
        Tue, 18 Aug 2026 08:10:41 -0700 (PDT)
Received: from workstation (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c217fe69cf4sm205772266b.3.2026.08.18.08.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:10:41 -0700 (PDT)
From: "user.email" <zstaseg@gmail.com>
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
Subject: [RFC PATCH v2 0/3] Add Xiaomi 12 Lite 5G (taoyao) battery support
Date: Tue, 18 Aug 2026 17:10:36 +0200
Message-ID: <20260818151039.409767-1-zstaseg@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanislav Zaikin <zstaseg@gmail.com>

Xiaomi 12 Lite 5G (taoyao) has an additional property with ID 12 that
breaks the parsing in qcom_battmgr. Fix that by introducing separate
maps for lookups properties in both directions.

The other approach that I tried is manual shifting properties:

+	if (battmgr->variant == QCOM_BATTMGR_TAOYAO && prop > BATT_CHG_CTRL_LIM_MAX)
+		prop++;
...
+		if (battmgr->variant == QCOM_BATTMGR_TAOYAO && property > BATT_CHG_CTRL_LIM_MAX + 1)
+			property--;

But I found that more obscure.

Will be happy to switch if the maintainers prefer this one.

Changes in v2:
- Keep the qcom,sm7325-pmic-glink SoC fallback in the compatible chain
  of the taoyao pmic-glink node (review feedback, patch #1 and #3)

Stanislav Zaikin (3):
  dt-bindings: soc: qcom: add xiaomi,taoyao-pmic-glink compatible
  power: supply: qcom_battmgr: add Xiaomi taoyao support
  arm64: dts: qcom: sm7325-xiaomi-taoyao: switch to device-specific
    pmic-glink compatible

 .../bindings/soc/qcom/qcom,pmic-glink.yaml    |  5 ++
 .../boot/dts/qcom/sm7325-xiaomi-taoyao.dts    |  3 +-
 drivers/power/supply/qcom_battmgr.c           | 86 ++++++++++++++++++-
 3 files changed, 89 insertions(+), 5 deletions(-)

-- 
2.53.0
