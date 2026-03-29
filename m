Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C00235B63B
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 20:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774817526; cv=none; b=mADLj1nbh6lkH36nlwTf+Au6M5ObUSnJtoiusmCNTFl5/cL3IoZAsbrw1jjePD4SEu6D7RGN9pS9+1cVaeEpG/hPDVIX3kwrM5WhfAtyP+BHZGWTkqcRXa/ZUCfeF088u7LpQSipZQ+8y0JoAy3Zr9ktva0Vfu1dTQlxdo2IoF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774817526; c=relaxed/simple;
	bh=I+QmOdm+icahqXt/SdP+sydmyyzhLJFqjcZ8AWjEoAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EzfAqT/oQ0p2ysDw8oO5i4gfXFdEv03dAQLQlpeiRTi00RmMdW3fy5SM369C683jrRUQYtyWVFQOv3eHpx6CY7vzX8odLllTiTqRk+yJrsxClqetSkMXcmeVV0f3wCc+GL7cGh84CkDbb5X1nt5Z+NPWkodfJC3Yx4OmOOpkgrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLJ/YDd5; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLJ/YDd5"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so2530268a91.0
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 13:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774817525; x=1775422325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=agUpQ7KTBePLs54BGx3erOStKc7P9lkIakmuRg1PvGo=;
        b=DLJ/YDd5jHKALGY2hOQM4481+YWsJJMnDz7Grh+b+7GLGpKTz0VLX/x1M46zjOrSC5
         x6CP/w4oLnqiJ11Vkom9eWM0hEjK/KHhrbQyTIgoUhNql2IFsEkjnhsIKXktxGIDpGHy
         iWXK22ma7tDGL8d3JYOqj12DzQCSpjTIfLOTlh62Nag9Lc9xm1RrcwcaBfJEw1iXM2L0
         j9hByVLmXJOUVHMVItkrpq4CTDWf3D1uXECiiwYMU7bXNxrR1jlgyQNGormX2VwWZK28
         aMsmi3z42GyaR694RdjLLcOu3dUucAcWK2eJRwr6klMontTIJg3ldlfh/4XJywYIxMXk
         CeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774817525; x=1775422325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agUpQ7KTBePLs54BGx3erOStKc7P9lkIakmuRg1PvGo=;
        b=Xws3oXhjx+dvRF4fngkNgrxOq0cl961M0Rt1A39HDnBCE0LVlieJ1x1bTdRqeH52EY
         5Abz9my1AJGiWnfpQiXsyT1fU6tZXZ8hdFtHilml9talUcP3yXzsm7x538x5zm20mA81
         Fr/ekwNNiArNY3LDjjYp9oU2Igk4+A5QQsm24Z3WIKY+L5njyYS+d5IPEWtIl2jdaH5B
         J4+A5hoB4evoVIgSImD1nZytxhgMYxDI+QaFL5mmcema7KzEezhjrLpyiYHiQDXq8JaQ
         td5qp+d7lFg0dhqJasKSWAZCx63WLDQ7CaABxdMiiLg5FLC4pQ4bh4P/mLt00gdu0Wv2
         Ts/A==
X-Forwarded-Encrypted: i=1; AJvYcCVeXqkId9M7smLWQlf2+YHW1e3hp13/82VKSoRoumVOdjQ14gc8IqCVUb4zPRhsPVyZH1PVPP6+rQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAiv0baSUerFO4izGd1yDS1pz8/tUuM2NymdO/jqDiml7VlSB3
	ZYf7PTNHfswEbJY6qX/cr0zgoFzMYIwOUPUKmmbZtnW9DyJHt75fF4M3
X-Gm-Gg: ATEYQzw8Duf7S7mG+oXH5PUt9YdYj+xz9k+AG42NO4lnZ78R6LYbyucW9ezE3w8KT22
	VktiihAOLjxhylLjf9AQaA4ExYhTzJwEWaQgjpk6g+2sbF077PgsRu8cnPpYS7QMGi6qSIS9GX2
	VhrnA7lRmlb2gLeCcd0xosk6rcs9oKtAtXCQFfrH9yROr861IW0zmDeojCT6QoqbjdFA+l142ek
	QpetSNDX87yr7Gl/0ku16Mrju31OFuwE7VGGDaKxtEfAStkTev5pNRYagrYrhsifDtfjmf7eOUK
	MlYMctkuHknDyaeSx0aaPJpfHNykdV0skxfAwAVcJkX3xyCseR0KpvdVK3kWRZdqnviqGM5LVaE
	hFvx0rrbu2G1K62IOxpUOackfa4N3+cntiOk0t2nBtqrmYAOI79tSDEtuuUINslLJ2CFT4SCZBu
	iokszjxCBORagYSw2Z4yQm26j5Lqq1
X-Received: by 2002:a17:90a:649:b0:35d:95eb:8797 with SMTP id 98e67ed59e1d1-35d95eb8a74mr3497270a91.12.1774817524667;
        Sun, 29 Mar 2026 13:52:04 -0700 (PDT)
Received: from snowman ([2401:4900:646d:9af6:7748:701:6c70:4173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22d8c500sm10423412a91.10.2026.03.29.13.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 13:52:04 -0700 (PDT)
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
Subject: [PATCH v2 0/2] dt-bindings: power: reset: cortina: Convert to DT schema and rename node
Date: Mon, 30 Mar 2026 02:21:49 +0530
Message-ID: <20260329205151.15161-1-khushalchitturi@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Cortina Systems Gemini Poweroff Controller bindings to
DT schema and update corresponding dtsi file with new node name

---
Khushal Chitturi (2):
  dt-bindings: power: reset: cortina,gemini-power-controller: convert to
    DT schema
  ARM: dts: gemini: Rename power controller node to gemini-poweroff

 .../cortina,gemini-power-controller.yaml      | 42 +++++++++++++++++++
 .../bindings/power/reset/gemini-poweroff.txt  | 17 --------
 arch/arm/boot/dts/gemini/gemini.dtsi          |  2 +-
 3 files changed, 43 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/cortina,gemini-power-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/reset/gemini-poweroff.txt

-- 
2.53.0

