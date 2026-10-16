Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27F36A342;
	Fri, 16 Oct 2026 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131246; cv=none; b=gp47B5Qqf/DAq64LdHNcTW3ioEAUoQRULMcrBErkvqHWEEp4hsXNdwWP1P6FZryL7QYabtEDSlvlXghZoc+19SbG/FIw9ly5DWxQ96KDqe2cqMsD09LdsqvuerGDimvOlkyY0XIJfRUsSG8N68YIpgcM04A2fpIKQiEh7eVkp3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131246; c=relaxed/simple;
	bh=pJkuQ5sxueCNJq/4feYK9sFltk8n39f8M+LNL3IDvJA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kGo0fCj5CQwcr7aoZTe8pAwfVGSjseeYpTD4UA+aJ/8oX9BIa/dKTXjdFH3OhYfl9Ywr2oi6CauG4m5x008JigcJl2bvN8iqPv883wqNABdeVfizlvtdPYTxkkoCRe12xAN//QLt0pEZXhd8oxWuNhu7CtYJ43afthKU/dWMA7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3O6AotA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3O6AotA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20C4BC2BCF5;
	Fri, 16 Oct 2026 06:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792131246;
	bh=pJkuQ5sxueCNJq/4feYK9sFltk8n39f8M+LNL3IDvJA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=c3O6AotAahCx9k7Rd5qoNVMxUMLnQhL6LYwvK0RenpcuomFVbx3+bl4U6Za+CguN1
	 OiCH0ckcX4l0SvBrX/aM4ynBSd0oRjg11X79VHX1Rs5MjqWs95zbyGAR4y91r/HeaV
	 8guM/1KPQXN4SSpkXueaqDpb4osvAco2CfWzA6fGqhCpgFsphJcOW3bOPZIpv4j1Fv
	 OexDojBrFAKExOtILuM0h98k2UCO7+9ObwRB0wded0hzGA/bt3knDPFGEADFgn+S0U
	 rwWTVQxVmoIUCBzXx6a02zfivpr3OYyEWD78DOwYUwLiJ2Q1uP5G429i0Uz9IPyiRA
	 qjxNo9fdDm1Yg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA40CCA464;
	Fri, 16 Oct 2026 06:14:06 +0000 (UTC)
From: Demeter Barna via B4 Relay <devnull+me.fromdisposition.org@kernel.org>
Subject: [PATCH 0/2] arm64: dts: qcom: sm8350: Add CPU and LLCC BWMON
Date: Fri, 16 Oct 2026 06:13:50 +0000
Message-Id: <20261016-sm8350-bwmon-v1-0-562fe403bf6b@fromdisposition.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0Mz3eJcC2NTA92k8tz8PN1EYzNTM4vkJCMD42QloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAWQ86wHAAAAA=
X-Change-ID: 20261016-sm8350-bwmon-a36568cb203c
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Demeter Barna <me@fromdisposition.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792131248; l=984;
 i=me@fromdisposition.org; s=20261012; h=from:subject:message-id;
 bh=pJkuQ5sxueCNJq/4feYK9sFltk8n39f8M+LNL3IDvJA=;
 b=ft9eFqoU8zxNmRBZdxKjT3TpAebnRH67UODWaQz7J/Jw+cpMq+ZSduhCGjCDer/JjDD1lFQRI
 AeyGRuEuk55Coyd36hqgiZ/DYI4T655yYKw3E+4SCQJyGfJpfEcMCw5
X-Developer-Key: i=me@fromdisposition.org; a=ed25519;
 pk=S0QFlGq1BQEaAtPPdAH8YKEOXMeRuSkTgctXuvtU+1Y=
X-Endpoint-Received: by B4 Relay for me@fromdisposition.org/20261012 with
 auth_id=1163
X-Original-From: Demeter Barna <me@fromdisposition.org>
Reply-To: me@fromdisposition.org

Add the CPU (CPU to LLCC) and LLCC (LLCC to DDR) bandwidth monitors of
SM8350, as SM8250 and SM8550 have them.

Tested on a Razer Edge 5G, whose board support is not upstream yet:
both monitors probe and their votes follow the memory traffic, also
after a system suspend. On top of the CPU OPP votes of [1], they add
14-15 % copy bandwidth on the A55 and A78 cores.

[1] https://patch.msgid.link/20261016-sm8350-cpu-bw-v1-0-044ac6dc9565@fromdisposition.org

---
Demeter Barna (2):
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add SM8350 CPU and LLCC BWMON
      arm64: dts: qcom: sm8350: Add CPU and LLCC BWMON

 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |   2 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi               | 100 +++++++++++++++++++++
 2 files changed, 102 insertions(+)
---
base-commit: 4eb2586bd40db27d77cc5b724ca9386ed0c71d53
change-id: 20261016-sm8350-bwmon-a36568cb203c

Best regards,
--  
Demeter Barna <me@fromdisposition.org>


