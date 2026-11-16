Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864297;
	b=Pvnx2QfN9wLoBXyRfBrLFom/XZ/xyGDBsd9h6E+M1n86k/PQegvD3DtRHYOXialX3VD3
	 javRB/YNM4XSfJ2+lRj96N+q1/jau2QslC0Ny+YP57ZTP6qbDISRVxHLLrfd++B2/7KYv
	 C/VuGSjU4KvcKceL5eeCb3cuNCM2vdfjGlSZVcf6hnlPeDp5sVlBDSG396IFHbM+FRkdc
	 XNzLZUxj12eWzpcYViZaDn+5LKqI6HNB0Ch/wtCQ17MJcLkyPsgCuGggPrnXIfM91B+84
	 Qb+bTv8Dt97b7CWoAI1Aj7lcPX2Yoib6LhP990d7jBRxBg69JRHNnPX6e9IE+HBUwDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=zekaG0muTTzzy3RY0PTKHkYNAiqpI6W9p9ARJCHSRoI=;
	b=SlhAOsQLi/fRvbgsxR+ffRiehrFIqdvMox/Xg1j6OwIOzfBaneJXgefQxNqDWybOxdDb
	 cfhiP+BMgw+nO8C4BHrqij/zhBmuylBPGGpqGKMGPruT3p2XOQNzW2gEbEX9b0GQ5zSdN
	 ymWs8v3pIDrw4d5prOj/3MhTsEWJ7QbrUWhIgROz5xSKwaMOqHDra4/0soqdnUlrDxcer
	 k10XlO2uGfXvCXTWzis0BZvZyxMDtebKSzPI1c6JRXGHR5PQvEeNLEd+4zQjDKwUy3RuF
	 TILqUn5xLTvTMN3BZQTgi3gMh/SGmygADoI/oU1OvimpNgG6NILqiYA/ufDDMlMr2zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IeCqbRnx;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8890A606A329
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8890A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IeCqbRnx
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so14710785e9.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864296; x=1795469096; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zekaG0muTTzzy3RY0PTKHkYNAiqpI6W9p9ARJCHSRoI=;
        b=IeCqbRnxF94DUqJYYO/cNbEJZUkAo8BEg4L2CCqEm6Ly8QG4wYND+m8ruBuu8kOCC3
         IPlHZw3crOR0jTR7n4QV8y8/y9d0c+WalEktJnucuMj8hrz+7M+WSGsyhWXDUZ9jze6T
         wOysZYrejwWqIoXApXpznQFNuk1ut2ZtBcWN0N4FLUi4iTCjINcj8JWcz97tZhgYjHak
         re52LAY6dbrjxbSEwJ74Y8b/pPzk/w8lvO89ipHjlptTLfa9PfVCkCUnxLp3HIulQkqj
         KJPL6WSyStVqYYjaz66BVXcODoWNX1EQpCUw3QK2RvRtY+J/+O7Fi+d3BZtTi6Hu7Fm8
         VtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864296; x=1795469096;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zekaG0muTTzzy3RY0PTKHkYNAiqpI6W9p9ARJCHSRoI=;
        b=Ir3HY0QnEhEi1P7Xsb/sN6jby+e25y5dpGOp1fVkrAamks07ohKvJ8rxVytvUzpgb0
         8J4NI0iaaQIWuSUax98mRY9VX8bQAiJxpNcnEHwJzGkZMbVfOCJ+J35EIvHxD+2YgFJp
         3fsjP+gBZNjyHh65rMhlM+rvz7S+1m2walGeaoGND/00nC5GnRtQezmPGgNTYfqDANIQ
         VjXewauhXlrDmp8XPW0BzCzbCl1sIu3DaGJE4pkbwO/cbjhLsiSpAG20F9eY2V9iBz7/
         uFvLYkHJFzsyclk6dIOoXm0DWb1QjHXWMQ8B78zYXGYTAlbMg7Ip04Gm4CWq7OnWmKbe
         Z45w==
X-Forwarded-Encrypted: i=1; AL+hErHw1PAJIX660IrFWBT1YFeBT0VSG2WNcowUyDxewF1aSWlnpfKo3JghcaCWWw3IH/aYrUpO7FVXdQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9gwdOFLE6JCP3fD0tQu/S6utbx5EJChaMRVewVE+U50T33HfLi
	urtfY1hj3ahjPuAcqCweBT3ddhJcmML/DI0x8QtxoAhs/lkZaVo/1d2c
X-Gm-Gg: AYBFou15pNqu0V/GqOq716XIV2jYkYv8SXqXYdVXrIARqPj3e4+cfId8lIdAoDUouLN
	ola0bVft82l2xwTTX0zscf3oTh4hIvQcDdmWuINY6Z+ygNWbQ6PYTPJLo70j7XfJZ5oD5wbt1K/
	T2MIFuMZXKGqH2vKpAC4WNGa7OV2VEexIrx7b5069sJ2Opty7aYTjGEydSxoCPY12wYZWb26Jg8
	Hm6cYgqBuU8lYMtEfLZlwPt18jFsdrjSuLED5HwbuEHnAHBii3Y576qBJvbcBONPL91eQvwEyRg
	XO9qh0JDu04VX2tVT6AmIrMk7sgPVYZGdeJSTRIxrJaP0cP8EWSryyxxtaa8LoUdwraZwXxyi6y
	CkZtYwR4tthvPz0zNlTDBebiWoKVBugSAHwf/aG6NPVMMvLyulW91CmIB4o/CqK0Hc9jKTgWQn9
	oZ/6N6FIwFDlWQLClX5qmaUyZltKePCDl3YA7RCtPiQGMxyk8+T8UAak6pLNuw/VIvztQiq8f4F
	hHrd0x8GMCXFpfep5gjPmIekA4cOQCLsme+ww/wZI8rbq1TjC5lCXxzgD1tv36gXUOKw4vJEWDX
	L43B9W1UVqNofe8x8lrkuC1kWrouKY2kbatjO53t
X-Received: by 2002:a05:600c:1c0e:b0:4bb:6f45:2a79 with SMTP id 5b1f17b1804b1-4bb6f452d4fmr123535875e9.22.1794864296120;
        Mon, 16 Nov 2026 13:24:56 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb734b9f44sm61928305e9.1.2026.11.16.13.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:24:55 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Subject: [PATCH v2 0/3] Add interconnect driver for Qualcomm Halliday
 (SXR2250P)
Date: Mon, 16 Nov 2026 21:24:49 +0000
Message-Id: <20261116-halliday-icc-v2-0-6df8fc0e0620@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAKJ0+2oC/1WNyw6CMBBFf4XM2hraUB6u/A/DopQpjAFKWmwkp
 P8uYFy4PMm5527g0RF6uCUbOAzkyU47iEsCuldTh4zanUGkIuc8LVmvhoFatTLSmuVSySwTDZa
 ygn0yOzT0PnOP+sv+1TxRL0fjMHryi3Xr+Rf44f3S1X86cJayFk2hTVHmppD3blQ0XLUdoY4xf
 gAYm7z7ugAAAA==
X-Change-ID: 20261108-halliday-icc-65a5442be859
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Stanislav Aleksandrov <lightofmysoul@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864293; l=1761;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=N1nEq2VfMFE4oihSgkAn+u1wXc3t/ieMcwO9xQMMdlw=;
 b=tvgA8nzb0WtJsi3f0O4AfkPb6zoQycIfw9woR3cY50dSNNhHx1T5EJSoEqPwBX3jrOYkpQD4k
 K46KghG77mgDLVD+bDqpDb7C6OZCl6wwPEo897wMT+7cxIR9ugHd8Z/
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document and add the interconnect driver for the Qualcomm Halliday SoC,
and document its EPSS L3 interconnect. The display BCM voter is left
out for now.

Halliday (SXR2250P / Snapdragon XR2+ Gen 2) is the SoC in the Samsung
Galaxy XR headset. The DT changes follow in a separate series.

This work was made together with Claude, ChatGPT and Gemini.
Reviewed and tested on my Galaxy XR.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
Changes in v2:
- Add the OSM L3 binding from the DT series (14/17 there), so that the
  interconnect patches are in one series (Krzysztof):
  https://patch.msgid.link/20261109-halliday-dts-v1-14-289114ab8197@gmail.com
- Define the nodes after the nodes they link to and drop the forward
  declarations (Konrad)
- Link to v1: https://patch.msgid.link/20261109-halliday-icc-v1-0-def7cf786f75@gmail.com

---
Stanislav Aleksandrov (3):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Halliday SoC
      dt-bindings: interconnect: OSM L3: Add Halliday EPSS L3 compatible
      interconnect: qcom: Add Halliday interconnect provider driver

 .../bindings/interconnect/qcom,halliday-rpmh.yaml  |  131 ++
 .../bindings/interconnect/qcom,osm-l3.yaml         |    1 +
 drivers/interconnect/qcom/Kconfig                  |   13 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/halliday.c               | 1781 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,halliday-rpmh.h  |  158 ++
 6 files changed, 2086 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261108-halliday-icc-65a5442be859

Best regards,
--  
Stanislav Aleksandrov <lightofmysoul@gmail.com>

