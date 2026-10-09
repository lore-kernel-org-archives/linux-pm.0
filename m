Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B95639DBD4;
	Fri,  9 Oct 2026 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548120; cv=none; b=uOtcDLimV4UxLfn2El+o4HouLxn8O09Pje2LDaYJvi0AkDCgcUBjABZtTAHZgnzes8jc0MWD15JKLh8pB6qCJDfuKyymJwvOLwppNLUYET16RLS1jsCgYj5eyc6/OOLLAKvxJvmGaVxXm8V1urW1fcG9JiOMua+ZC7itbg6gaHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548120; c=relaxed/simple;
	bh=LHPPv/t59nA8EN2qA1mpKu9sNUeZkB4PCIETi/K4wJ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aBiRtGjtUIPQXHU74qRidKwZzlFvJOP5PeMcLwAZYoJME2KxxyboQWZAOqsjlHFynP5WXPj5AErZFER3LBUOdo9lTiFyQpGW1Ju9UiopnsBShQFRJ7BRcN/91A+flp3Zp3cyUi178sI7H/tqa8UmGABNM4veGaLZFFwFh19JBNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtKdvOVu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtKdvOVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21EF1F00893;
	Fri,  9 Oct 2026 12:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791548108;
	bh=crVrt+azV6VzH/3rk8Jcr3ieOc5saBo85Edk21IHDvU=;
	h=From:Subject:Date:To:Cc;
	b=QtKdvOVuxyrLExAgcfojOGE+jucpqApSPmlC61pMOIDaSLHUJVvvMp9FHrREWYtlz
	 m3WkHEUQ5eCTUfu9xTeNmWpSQHony31ZnygnU4B1sl+n9eoAHgqudKukosMDamyAeZ
	 kHj1ghhX6WQsiSnOdReW4FMkmwmiVpJj71DV0w3aT2S05Ohnb7zGeqX/VZuKq4y8HU
	 AP81kXGm2i+p3LfJF1rbSruI2hijsxKMYFA2RSRsoudIbJht4DCS/CJ3PIgrWYnQuy
	 qJd91Kb47nBauXXVAjJS8zT6g8lqkSPQI9flmmPCYXeoks9mWfGEztfS3rYS3rrWGj
	 LmtDMB6a+nbqA==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH 0/3] pmdomain: Basic DT defines for ux500 power domains
Date: Fri, 09 Oct 2026 14:15:03 +0200
Message-Id: <20261009-ux500-power-domains-v7-3-rc1-redux-v1-0-5eb1b90bc35e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NQQqEMAxA0atI1gZSpSMzVxlclDZ1sphWUtSCe
 HeLy7f5/4TCKlzg052gvEuRnBpM34H/ubQwSmiGgYaXIXrjVi0RrvlgxZD/TlLBfcIR1RtUDlt
 F50OcrHWWo4cWWpWj1Gfyna/rBhOFN7d0AAAA
X-Change-ID: 20261009-ux500-power-domains-v7-3-rc1-redux-acdf755a5efc
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3

This is three preparatory patches for v7.4.

These three are an excerpt from the earlier sent series,
updated according to comments and collecting ACKs.

It also fixes an urgent dependency (my bad).

The main ux500 power domain rework is targeted for v7.5.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (3):
      dt-bindings: power: Convert Ux500 PM domains to schema
      dt-bindings: arm: ux500: Drop NR_DOMAINS
      dt-bindings: arm: Add the actual power domains on U8500

 .../devicetree/bindings/arm/ux500/power_domain.txt | 35 ------------------
 .../power/stericsson,ux500-pm-domains.yaml         | 41 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 drivers/pmdomain/st/ste-ux500-pm-domain.c          |  2 ++
 include/dt-bindings/arm/ux500_pm_domains.h         | 17 +++++++--
 5 files changed, 59 insertions(+), 37 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20261009-ux500-power-domains-v7-3-rc1-redux-acdf755a5efc

Best regards,
-- 
Linus Walleij <linusw@kernel.org>

