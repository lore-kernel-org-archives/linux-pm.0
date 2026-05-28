Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0D82DAFA9;
	Thu, 28 May 2026 03:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779939572; cv=none; b=PV2k0CkBK/VYmEmg39n6AZ7ngaaOhQP8qXW4IP8WSwagQPuJZLTQWXkYBGpEZHdX4DcxIKk48NLpaMfkoPhHgc8Vu+FfMA/66TD8WDPLQVZNBH9JB/YJtF9uvr4d8KCMXtgPBOPESk/E1rtp78DLm7c+ZWzxeS3VYx7YyJpl/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779939572; c=relaxed/simple;
	bh=0HNKn9uJOrUj5fdAKjFadUhpFBPIo0H4vtoICGI+Ris=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PExukWjh3SfH622kRKMUZx091WwVMNiikctFPWN6xOaJwFa4WCe7r4k7qm8qEvWoOD4yC2papiCYPZ5W9tuphVqjsf4IEgy9ne2u2qAik6g+lTcnS6bcszp7ZrZbib9i8gFEpzBtpVhjewFxTJvUesmcIRV/iDUp+MFR6LG+Vk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRQrhWCB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRQrhWCB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AA0FC2BCB4;
	Thu, 28 May 2026 03:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779939570;
	bh=0HNKn9uJOrUj5fdAKjFadUhpFBPIo0H4vtoICGI+Ris=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SRQrhWCB5i0DZpAw1PMB1w3us7LsL87HiCzxtSmZjRpq8ZxNQQ03HcxjimwdUiQLW
	 pe9Vn8MNegALu7pN47E6vOyshKlCqvvIq27xq/OZnAvmWO8H5ckFAfkTMTOMSMcFVU
	 Ugc1HiEktmkkCBZ1q4UkQrg99O63eHeh7I0vl/BzQDKrXSAJ1HInmHkAdhw3gpy6L4
	 FOqeVioAydHOzhbukwatvtBYk0UBWtn7YYYT0HYDRhLt74PktiSZz6SLasCI9PBRaP
	 Sq13hbkUDhph6E9WqJSSUgy3aN7TRC9IvR0Y+Uf2+ikTYSsHtspGjFawgOK6w+ea4+
	 tT2vUoKvABmLg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C76CD6E43;
	Thu, 28 May 2026 03:39:30 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Wed, 27 May 2026 20:39:28 -0700
Subject: [PATCH v2 1/3] dt-bindings: opp: Allow optional -vN suffix in
 opp-microvolt property name
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-expressatt_cpufreq-v2-1-b9b7726ccb6d@gmail.com>
References: <20260527-expressatt_cpufreq-v2-0-b9b7726ccb6d@gmail.com>
In-Reply-To: <20260527-expressatt_cpufreq-v2-0-b9b7726ccb6d@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Ilia Lin <ilia.lin@kernel.org>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779939570; l=1182;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=z/WcStOsVzdMFWp8uRFOe40/ecbf/NOss5Qfrb51yd8=;
 b=jftSPMYmys0+D6DQdiGgQPXjZmjbpCJ43RowmEacOFhKVXHINvYiKqyXVmVPmpdys0oFWSFLG
 KZ/LWB0W1CoAA7kuvyh7URIahwHeLXLrxfS7i0m1crvJLgfYUv0pfF/
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: Rudraksha Gupta <guptarud@gmail.com>

The qcom-cpufreq-nvmem driver generates prop_name as
"speed%d-pvs%d-v%d" for Krait SoCs, resulting in property names like
opp-microvolt-speed0-pvs0-v0. The existing schema regex only allows
opp-microvolt-speed[0-9]+-pvs[0-9]+ without the trailing version
suffix.

Extend the regex to optionally match a -v[0-9]+ suffix so that
devicetrees using the full prop_name pass schema validation.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
index fd04d060c1de..846f49a99484 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
@@ -81,7 +81,7 @@ patternProperties:
       required-opps: true
 
     patternProperties:
-      '^opp-microvolt-speed[0-9]+-pvs[0-9]+$': true
+      '^opp-microvolt-speed[0-9]+-pvs[0-9]+(-v[0-9]+)?$': true
 
     required:
       - opp-hz

-- 
2.54.0


