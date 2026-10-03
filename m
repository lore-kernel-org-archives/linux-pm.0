Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FC32D876F;
	Sat,  3 Oct 2026 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056723; cv=none; b=ostw/Erfk+LiVAgeJpn04DaxvEZn3fdx15fwkF4g1d0aiLvoBcMxY8uQOBDqOgRCJCCBTxSHNZ2A8re95KIBDCZxtnyvYrNF+cfzD79tyEThN9SZYfOGgJnbzQ8KO1JTFimo5c1gzw4g/1rgPutu+lBbm1AmE/dyzz5d/EirvV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056723; c=relaxed/simple;
	bh=69Be8OqRG4uKfxINxNYsSa/2mzLTbGi6UrvJIKEBERY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rT5Mb1Azc6vcL/h23eIPZpRnEPtpce5uTINJxV82AshsGdE9FsJEEB1blLqfYDXw70eWq8PBEHcTpLngD46ziITyM2B0mGD8Gbf+fRsWGcc+8ozby6yQXp0OSn9JEswVzyPqeMrIb8ggFXluEZCCJDSIvOpuww+LNlRhaA3fhFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiG2x9T+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiG2x9T+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F337C2BCB9;
	Sat,  3 Oct 2026 19:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791056722;
	bh=69Be8OqRG4uKfxINxNYsSa/2mzLTbGi6UrvJIKEBERY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=hiG2x9T+3HTW3UB/7FA2xEh6ZZ56qSwBRVHhqcgUM5VK5X1570ImdGMWQ9gJ7oqKq
	 5bO5sw7FBWi1SJnvrql3JcG69saT13TYCKW87jC7xUQouC0XmqpthULRXL3AK8894W
	 S22as6SdZZ948zIXFkXJuXKZMP9auCQHzRsY3JgROs4cF3/sMKospqcMkk7wEitOBU
	 SSS7vzXkhz8jGY1KSGDHf5qNAlHfCs7f+F4WHCExeUKpHswGiNnS82Cut2PrzLHLyK
	 NXOxdeoJxWrkzIyiyjE6SMlFsEdmpwxxOcQ0/d3VIumC3yNbyoJQ9HPPCWEaHOp7Fx
	 1DbnOld6Hhqqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C06CA5FDD;
	Sat,  3 Oct 2026 19:45:22 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Subject: [PATCH 0/4] power: supply: qcom_smbx: report charger state changes
Date: Sat, 03 Oct 2026 16:45:20 -0300
Message-Id: <20261003-qcom-smbx-chg-state-change-v1-0-fffaef446932@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y3MQQqDMBBA0avIrB2IphX1KtJFMh11CmqbSYsg3
 t20dfng8zdQDsIKbbZB4I+oLHNCkWdAo5sHRrknQ2nKqjDG4ouWCXXyK9I4oEYXGc/SXiw1vq7
 JXRnS4Bm4l/U3725/69s/mOL3CPt+AKYQKOZ+AAAA
X-Change-ID: 20261003-qcom-smbx-chg-state-change-343c9b88ca5e
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Robin Snyders <robin@snyders.xyz>, David Heidelberg <david@ixit.cz>, 
 phone-devel@vger.kernel.org, Richard Acayan <mailingradian@gmail.com>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Fabricio Akio <fabricioakio@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791056720; l=1384;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=69Be8OqRG4uKfxINxNYsSa/2mzLTbGi6UrvJIKEBERY=;
 b=j4P4kueOKJEBhvIsJc/2rxdyAGEI7E4Ka7+E9uKMI2OOnzqEgmhPotkz5rVxPbjcB40uVf+b4
 gxaUleMiQwsBqQTPFn2tRCu9M2WQkCb27yTqsiunx7X4HXDzle85/AD
X-Developer-Key: i=fabricioakio@gmail.com; a=ed25519;
 pk=TlMUT8bPI/ZQzp2q24BIQTb2qSx/jdUTBlGEXIRCm54=
X-Endpoint-Received: by B4 Relay for fabricioakio@gmail.com/20260928 with
 auth_id=1076
X-Original-From: Fabricio Akio <fabricioakio@gmail.com>
Reply-To: fabricioakio@gmail.com

qcom_smbx does not handle the charger's chg-state-change interrupt, so
a charge completing is not notified and consumers can keep a stale
status. Allow the interrupt in the binding, handle it in the driver,
and describe it for PM660 and PMI8998.

Tested on a Motorola Moto X4 (PM660) with the sdm660-mainline 7.2.3
tree: each charging-state change is notified and the battery status
follows. The PMI8998 patch is untested on hardware.

Robin Snyders' pending SMB5 series touches the same binding and
driver; whichever lands second needs a rebase.

---
Fabricio Akio (4):
      dt-bindings: power: supply: qcom,pmi8998-charger: add chg-state-change
      power: supply: qcom_smbx: report charger state changes
      arm64: dts: qcom: pm660: Add the charger state change interrupt
      arm64: dts: qcom: pmi8998: Add the charger state change interrupt

 .../power/supply/qcom,pmi8998-charger.yaml         |  5 ++++-
 arch/arm64/boot/dts/qcom/pm660.dtsi                |  9 ++++++--
 arch/arm64/boot/dts/qcom/pmi8998.dtsi              |  6 ++++--
 drivers/power/supply/qcom_smbx.c                   | 24 ++++++++++++++++++++++
 4 files changed, 39 insertions(+), 5 deletions(-)
---
base-commit: 9f24d789f03b22941b905ded43cb5ff8eea9ce62
change-id: 20261003-qcom-smbx-chg-state-change-343c9b88ca5e

Best regards,
--  
Fabricio Akio <fabricioakio@gmail.com>


