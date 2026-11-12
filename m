Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503344;
	b=vF7swxMdKMCUDG9cjnO1XvUzDS5FvYvPofln7I/jmgFtoiFJP/rgf0I5zajiz1THyLbF
	 ULi0ryL5rBSHF1YuR+GKzXuTx631VtRopi8fPk+hA2UyZTiL06lIyUL3IimpNOem7Vu1J
	 kn1XU5I5/I6dzoqXLIn+OPSLYZhS9N0BGvYGFzS9/XAf+2rfb9t1n2yRPstWEqZif3Sni
	 TTghkdZfIpoHoSp8/TGds0i1Gm1ijruennJfk8YlkfSocIuEPq9y6g/m55CKuLJMYvunA
	 nN7X0JF4qdAgZXNE74XLVQfawkNO+DytoKobaxxvVt1IfhoEiWmvsJC9t9h9iJaVgfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503344;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oj2TNmHu0aGvGVnFAhxBXVtL1PvBAFJMiuWObtt4eU8=;
	b=s+M9p6gsCOm2uBiel2xL6dRbBLj2y0MM2jeYqUh3zcCvFVmzXLaFvnFkEqRT9WQaSJVy
	 7WZnJ1vfszEgeTpQBnM/VeqmK6c2RYYrfmtGDNE/F3kQYqwEoeySa4U0HVRpNQwD1bh2R
	 LmKHd54mfPq6/Wmg59W6S+jNw7lo1Egh4C0uOes9p6LQFZtk/Yh1PxPU7Vlq9yix52AXQ
	 KIt4zHTZSWDRHHU9ux5nyhk6TvYbP2ibPhMhxZFX+lpvsYzDpR/PBhn4xFCdWh1hFI0Hb
	 FOd1Fx67IIwP0Et1eVa9ZGCCPUu7mjOSC0A0Wvx6Ale4atME8Hi22wA0ggOa9FllEGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=KNTpMS5P;
	arc=none smtp.remote-ip=95.215.58.162
Received: from mta1.migadu.com (out-162.mta1.migadu.com [95.215.58.162])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C45606A334
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 17:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6C45606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=KNTpMS5P
X-Envelope-To: linux-pm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=W6VeXoYsDeuooRLOPur5oKNEUPcbNXvMYUsUnI6yMhQ=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794503340; v=1; x=1795108140;
 b=KNTpMS5PiD58A1ons/DpdJZmpZOCajmxxKBM5F/RE+ZjoQuNDaELQmTkqYAwdvagMjqJPCOH
 VyVorLwW83zHYFDRVk9P6fnbphJ1ZPIVuU/7JmkCTfDGeBw/ma+fwnFbeaP6RRKc9ypS1qR3P2h
 ipGeKR709smjl2/rMw2zt6CDTkzPrBN71Ds1fLAaz78BUPpwF+3E83msDbhgNXUZh4jt2ri2HIj
 Sak3LhdsE0QAL95+jlxE2NM8uPvNuHnRUNWNPQa5+3MHZsX0n2eNmAk1Nr1zRLXLyh7V9Be9bEH
 Et+M8i7ydeO2Z0C2nSxkkowNxTqr+0WISXwIcDxn9lV2Q==
X-Envelope-To: linux-pm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cc99491184bea011;
	Thu, 12 Nov 2026 17:09:00 +0000
X-Mizu-Trace-ID: cc99491184bea011
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: 
Cc: Val Packett <val@packett.cool>,
	Marc Lainez <marc.lainez@gmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Add driver for Qualcomm QGauge (qcom_qg) fuel gauge
Date: Thu, 12 Nov 2026 14:07:26 -0300
Message-ID: <20261112170841.2189322-1-val@packett.cool>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi o/

This series adds a driver for the "qgauge" battery fuel gauge
present in Qualcomm PMICs like PMI632, PM6150, PM7250B, PM2250.
The PMI632 is used in SDM632, SM6115/SM4250, SM6125 based phones.

This series was tested on sm6115-motorola-{cebu,guamp}, whose basic
dts has been submitted as [1].

There have been two attempts at making this driver, the first one
"WIP! power: supply: Add rude driver for QGauge" as found in
various development forks [2] was rather infamous for wild capacity%
swings due to load variation :D

The second one was submitted to msm8953-mainline at [3] by
Marc Lainez, and it behaved much better thanks to the use of
power_supply_batinfo_ocv2cap.

This is a continuation of that work, carrying his From/S-o-b on
modified patches with explicit permission. I have added the
SDAM read via NVMEM API, fixed the batt_info leak and did some
general cleanup.

With the SMB5 work also going on right now, we'll finally have
full battery support on these awkward pre-battmgr generations!

[1]: https://lore.kernel.org/all/20261109221453.658316-1-val@packett.cool/
[2]: https://github.com/sm7150-mainline/linux/commit/76879bf7a71f4f8f66b9bcd7175069ca7bbf4274
[3]: https://github.com/msm8953-mainline/linux/pull/242

Thanks,
~val

---

Marc Lainez (2):
  dt-bindings: power: supply: add Qualcomm QGauge fuel gauge
  power: supply: add Qualcomm QGauge (qcom_qg) fuel gauge driver

Val Packett (3):
  iio: adc: qcom-spmi-adc5: Add ADC5_BAT_THERM_100K_PU
  arm64: dts: qcom: pmi632: Add missing bat_therm ADC channel
  arm64: dts: qcom: pmi632: Add battery fuel gauge node

 .../bindings/power/supply/qcom,qg.yaml        | 105 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/qcom/pmi632.dtsi          |  41 +
 drivers/iio/adc/qcom-spmi-adc5.c              |   2 +
 drivers/power/supply/Kconfig                  |  13 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/qcom_qg.c                | 807 ++++++++++++++++++
 7 files changed, 976 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,qg.yaml
 create mode 100644 drivers/power/supply/qcom_qg.c

-- 
2.56.0

