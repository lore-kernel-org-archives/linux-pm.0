Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.47.186.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516832;
	b=tQUewO3FyJpo88BYimENQ/KCSwQWr2yxzXjvKjO4YeB5psyaHgnp/zSkwXNYikJliHq8
	 YyDJMYVaRfD0CGiF3d1gdu7xfj4Yrr2oTlRsQh5+cPGQ8WXsJJfria3JEE4YEeZkHtj7d
	 P8iPSdzE9hA4/b5H5phG2CtpYAUHQmC/G5iwee5x0LV7Vn5MWbA0dnT1UmQ2gY8JwsqFX
	 kqxhudolHkVZ5N9bLT9VirRKY+tr8ISZLau5+e46PH5MwGlpDMKPnnrgEYPRiFS5ciffb
	 2mLduLJl+vQflcXitB48NXeY7vnDHS5646cdpVDFfw+Gdrc+XBt2D7l/ibi1SRzB0cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516832;
	h=DMARC-Filter:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=QOkoesu6L26Z4Z8FwsZEfnGdgaroIxpo3wyjYKYItfU=;
	b=3SEBTm19fplD116hsLHLDhWyI9OgjVVcjEUamvD/r0Jd8qNgtknbcyEm7BGZJ7s0kKAL
	 pnZs0K5ds0weAJL4csYgSPbNnLoF45qVvLQphEFvM/rWwd8wmOAP6PJY3cJZzoEAi5hmT
	 lXw+DrmNpuCvAic57P58Kbc0k5/QbTZztYXJKJYgjxLQlpJxRwzQ6O9gxHLkr+rkh16lJ
	 uyXDgAA5cuq6X6QvsDm54upCdd0Q0UYg1VwXWEWcrCAMggHegHnuRzQ3NpdL0bXP3ea08
	 upRHkWcOoa1/Y7Zq4HBfC6wiYZ46fyZyXkHx95KJjyZUjN4DHLcvpDQOZMUcRk9Uf4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=krgm.moe;
	spf=pass smtp.mailfrom=krgm.moe;
	arc=none smtp.remote-ip=103.47.186.116
Received: from krgm.moe (krgm.moe [103.47.186.116])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE35606A31E;
	Tue, 24 Nov 2026 10:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CE35606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=krgm.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krgm.moe
Received: from [10.42.0.96] (unknown [114.242.206.180])
	by krgm.moe (Postfix) with ESMTPSA id 8CB37859;
	Tue, 24 Nov 2026 16:10:27 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
Subject: [PATCH 0/2] Add Qualcomm Netrani interconnect support
Date: Tue, 24 Nov 2026 18:39:38 +0800
Message-Id: <20261124-netrani-interconnect-v1-v1-0-bb5efdb229cd@krgm.moe>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCQAyE4VcpORswUUR9FfHQ7k41HlLJrkUof
 XdXPX4w8y9UEIZC526hwGzFJm+QTUfp3vsNbLmZdKsHEd2zo0bvxuYVkSZ3pMqz8JBHzQLsjnq
 i9n4GRnv/ypfr3+U1PNr6m6N1/QDtBIuVewAAAA==
X-Change-ID: 20261124-netrani-interconnect-v1-bdf2d1ee3829
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=846; i=prcups@krgm.moe;
 h=from:subject:message-id; bh=2/hxVNVgouSPZ0MVAARCRc+4hY0rVlDTvBdrKLasTKQ=;
 b=owEBCQL2/ZANAwAIAV0dOJt2umJjAcsmYgBrBWl4GCvLg8GZh0NWNGbwmR5qnXEXCiAKD28Pz
 LICZQ+4HGiJAc8EAAEIADkWIQRSClJ2zjncUdNU0FFdHTibdrpiYwUCawVpeBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDIACgkQXR04m3a6YmMMNgv/e4GRj47R8YVlEipjmQ929InTBJUBuv4
 l/KPpkhI/Rrpy80egCh37bA/YK4wE7l79P51vingFpSTmXOkkl/jBdBHWRKWHDiw97XsuxEKr/5
 NApksqXsntMt+Q421hyd80pStRxA05nNsmJL8uubxjUeeie17pnIzJeGy8cey8ZjEKS9Ff2WPw7
 G0LRbLqWkcQbGigEma6NZL2F4AkEpjS2sQkFqGuNqUCEg2RaXxnjJkL35EwJk0aPdb63PtFcvmK
 3PABMtU7H6zbiJEJ6a0ZOdemjb0JITHKPhvnZiZsWXEVYIOUK6GC5+VnljfLWLUauj6pk8qavLi
 FLDe1kjEDQ7zxhls7lPr803BEatRGjIYEe2iPe2c0a/ja0S6imy+HUHT2+BObDyanxWdPDVjP7H
 4wnpH1V95NBWD2RTETBJr5pW8zqf6OXeULfAmz+jKSfet/ELku2K3JDrSw/7Hwh/3vBAcuFC6Ws
 d2Sau6GRT7ZVEDHyNFvNoGczigvDD72
X-Developer-Key: i=prcups@krgm.moe; a=openpgp;
 fpr=520A5276CE39DC51D354D0515D1D389B76BA6263

Add the RPMh interconnect binding, topology identifiers and
provider driver for Qualcomm Netrani (SM7435).

Signed-off-by: SignKirigami <prcups@krgm.moe>
---
SignKirigami (2):
      dt-bindings: interconnect: Add Qualcomm Netrani
      interconnect: qcom: Add Netrani RPMh interconnect support

 .../bindings/interconnect/qcom,netrani-rpmh.yaml   |  131 ++
 drivers/interconnect/qcom/Kconfig                  |   11 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/netrani.c                | 1723 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,netrani-rpmh.h   |  169 ++
 5 files changed, 2036 insertions(+)
---
base-commit: 3fd56a2833c22f62eb84297d0dbd47739632f1a0
change-id: 20261124-netrani-interconnect-v1-bdf2d1ee3829

Best regards,
--  
SignKirigami <prcups@krgm.moe>

