Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D19E535FC5;
	Thu,  1 Oct 2026 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894365; cv=none; b=qGqXh6UYywIf1bHi7wPj5HeTiVPpWf/ohyuo4FcCLJRePFUFWn/dzd8KNrYi7Dg3GB6XCb5XkCGSvNOEiZxJ7RpYzx2ZsoFnIcAx19eX9cMpJVoabjgPFAip4EkJe/1QfmQ7fweNdc32TyTC1jEojynNv75/sDwuVECtGV0snDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894365; c=relaxed/simple;
	bh=Ec/ktmytxMU3f8El8FxP74pWK596JZJmVpnNurOP78g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GeZuYoAujsBofgcU3DhpJDiHKlWz9lALvGnNrVTClqw25VRFlzEMCRkSgc6nSNNRKgLu7JOGe5alQewMnGOSYUF3jtR1BdbOEJLQMH7vqUBAl8n07lJaT5DFnA/9ghUN37drLa7AFK87ruU7FiIOGjLSaIB2ieZYgy2vmV2ZWI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=k+QYwA0A; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=LnEBcJGN; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="k+QYwA0A";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="LnEBcJGN"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Date:Subject:From; t=1790894347; bh=PmgsvGcizyjhejJ/0taQANE
	LxYOdQ6satm+6fazHCRA=; b=k+QYwA0AKyXmQ1Gv0u7JbO5jUa3nXdVYnYIMGr3b1iw0qIllCK
	l6kvAJdqQpZshrmF05McwiWzKod3mwZA/n0cbDDw/ShV3+j2m37Zd6KpNc9kBwYT0VLRWRInuZ4
	Y0b5zN1AAV1Tpb3GCrKRGn14r4nlccgv+24qRahV9tJ0nsZN7s3M5gTF5M2U7a2hQlsu+oKhDaJ
	pGpk2hJDFd1cgVMSt3t+uGbnW739Kcrfy5CnK+q0VnIIjSKeuHhOSAjbRU08wTLRiC4Ts5FZWEh
	v0JdyVpmM9BQ4XVgNFozUxdpXZYam2X2KOuFwRBUcmtvPGKYImW6Mwmw6vCkKnbsIkg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Date:Subject:From; t=1790894347; bh=PmgsvGcizyjhejJ/0taQANE
	LxYOdQ6satm+6fazHCRA=; b=LnEBcJGNV8FlCouZZhHB8DuJoFVdnsgpJKM9N9p0zwX+ilfgGR
	nfLFntsn03oPKKVKhoJVV82ItmKAiO4NTLBQ==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH v3 0/7] MSM8953/SDM632 rpmpd/mss fixes
Date: Fri, 02 Oct 2026 00:38:28 +0200
Message-Id: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XOTQrCMBCG4avIrI3kx6aJK+8hLtpm2g7YtCQSl
 NK7mxZB1OX7wTzMDBEDYYTTboaAiSKNPofa76DpK98hI5cbJJeaK2FZdINWkoVpmBxrOCqsi6N
 pCwP5ZArY0mPjLtfcPcX7GJ6bnsS6viFZfkNJMM40t8Y11pZO6/NQkb+RJ98dxtDBqiX5Eaz8e
 SXJLNgSW2MKI7So/4RlWV5kLdIL7wAAAA==
X-Change-ID: 20260319-sdm632-rpmpd-c0e3eb548f58
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Stephan Gerhold <stephan@gerhold.net>, Ulf Hansson <ulfh@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790894346; l=2712;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=Ec/ktmytxMU3f8El8FxP74pWK596JZJmVpnNurOP78g=;
 b=VlSDxlwyAlLwPO5J5RC5bYzHmLL4L0tyagMefMnueOvgrjjZDInxUPLEAYmAcIOOsuIIJ9ZGm
 dVIYuHoJneGAUa7Dit5lnuWJ+a/nxPHEPRn4Aux3ZC9rD9bUew9IOSG
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

SDM632 pm domains are different from MSM8953 because MSM8953
is defining pm8953_s1 as regulator but SDM632 is defining it
as pm domain.

This patch series correcting the pm domains defined in rpmpd
driver and splitting the MSS resources for the both SoC to match
the reality.

These changes was discussed in a previous threads:
https://lore.kernel.org/all/2b057aa5-4416-4fd4-aeab-6bc23acbb53d@oss.qualcomm.com/

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
Changes in v3:
- Change RPMPD_VDDMD from 10 to 5.
- Add back MSM8953_VDDMD_AO and MSM8953_VDDMD.
- Split qcom,sdm632-rpmpd compatible documentation from VDDMD definition.
- Link to v2: https://patch.msgid.link/20260929-sdm632-rpmpd-v2-0-97ef8858161b@mainlining.org

Changes in v2:
- Define RPMPD_VDDMD
- Remove unused MSM8953_VDDMD and MSM8953_VDDMD_AO
- Squash MSM8953 mss related commits.
- Rebase on latest next.
- Link to v1: https://patch.msgid.link/20260327-sdm632-rpmpd-v1-0-6098dc997d66@mainlining.org

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Ulf Hansson <ulfh@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Abel Vesa <abelvesa@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-remoteproc@vger.kernel.org

---
Barnabás Czémán (7):
      dt-bindings: power: qcom-rpmpd: define RPMPD_VDDMD
      dt-bindings: power: qcom,rpmpd: Add SDM632
      pmdomain: qcom: rpmpd: Split SDM632 pm domains from MSM8953
      remoteproc: qcom_q6v5_mss: Use mss as regulator for MSM8953
      dt-bindings: remoteproc: qcom,msm8916-mss-pil: Add SDM632
      remoteproc: qcom_q6v5_mss: Add SDM632 MSS
      arm64: dts: qcom: sdm632: Correct power domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
 .../bindings/remoteproc/qcom,msm8916-mss-pil.yaml  |  9 ++--
 arch/arm64/boot/dts/qcom/msm8953.dtsi              |  5 +-
 arch/arm64/boot/dts/qcom/sdm632.dtsi               | 34 +++++++++++++
 drivers/pmdomain/qcom/rpmpd.c                      | 29 ++++++-----
 drivers/remoteproc/qcom_q6v5_mss.c                 | 56 ++++++++++++++++++++--
 include/dt-bindings/power/qcom-rpmpd.h             |  1 +
 7 files changed, 113 insertions(+), 22 deletions(-)
---
base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
change-id: 20260319-sdm632-rpmpd-c0e3eb548f58

Best regards,
--  
Barnabás Czémán <barnabas.czeman@mainlining.org>

