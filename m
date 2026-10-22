Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662095;
	b=Tje4zKKDxv5WDzfcNzTO153iMxjKihO4953IwcHyu/0O27a0I1gDResFceTMbe04aKyX
	 071d4XnSzHEIMxwTv7G7cl3aJcyOJjULBOtr/xuRqKzhRT4w4ra0KWWABuvWJ9Z5iSzS3
	 H/XFgC6DtKIMQwWMcW3akbt78ypck+xC+zCYl8LASHFH0dQk3wAxp03Z4lQxDrLSOXoLS
	 tniu1/vzpUlk6ku6C2IOsO/UaJ8A6z91eBqmofDwc9zI9c14+3x3XHx5sbcqEIi+qmyCT
	 fXookanLxBD7aXpgrlzavbwb/aubokwqduQDbjPULzWsHiBVNVFxIEQzTcwMn7SKT0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=ZO3QijMDlQGB6qI6turwFa39VuovzlWi+zzZq/Y2Sow=;
	b=x5RtrHLZoaTC6YTzH/q22wI12SbzQ8pYnRgOUheQh4fsw9uJqxFs4XakZWC1zdw2Xomm
	 wfgMmVyeXQWpV8PT3uWByH810ZQaybRSxH5Ceq2xIdPlXKieQkZygoZJKEBSycqOEN5zs
	 yJFSkOQSd0Z4/6lXLoLMOO1G3DvVYDHllupDigbn66n7fzI5HZAIq/cmA9HjfYvKKH1Vx
	 4yIcTl7N8oE3kfnWOE7kGGOJSaeZ1SU5tLkU/bxjhUrUXWbb3mADRT5uAYyWivuKDxMUy
	 wOsAO1C3mMk8DQ0VWvLfUH2OenDdHMgDCMw7XeM+n4OZsL9YCyugTktByrisSiwIvfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="qIjlwC/5";
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D02606A321
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 09:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77D02606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qIjlwC/5
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9995ce866so12787205ad.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 02:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792662095; x=1793266895; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZO3QijMDlQGB6qI6turwFa39VuovzlWi+zzZq/Y2Sow=;
        b=qIjlwC/53Ob/h9wveqCCxyG9bSf/7jYt0zFC+PfBzfr7JccVi1Ia9lUEeT0vP+48cg
         kyg3I3XtG9jdkw093xYuc6ENRd4wRprh8Iz91QwAqcLfS0rt0QchpQy5Vp1ry5C+W6fi
         daSJR1L0aJJpG5xYLIu43uvLNNkvR3ujJNEfW64BJRPTpaXxu/7aztMBkE8y9/cSZFRO
         M88B+RmUx+/hQ27zQjiPzLbT9pK9o9vSjVaJR9CI3CqiOQ2p47jmxl/ccMTbJwK3QrgS
         6Vi6xSMsL1qLBnuP+pAzXjQaWQV93OzyOziSJh9tBBt2t4faan4YnvXy8xZ9ZwmaPw0P
         MZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792662095; x=1793266895;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZO3QijMDlQGB6qI6turwFa39VuovzlWi+zzZq/Y2Sow=;
        b=t1Fjl7+WT7JTeJe9OYsVwxKE/1mqav+mC/No1l6teBcyk8ranMLYlZTZ/FkrbVt8AK
         Rwvoer16qL2F5FckeHE4MeX1k6sBzcqv23V98AJznvzG5kDauafQ5b26UwxVMI+St4dy
         JRJXoGcmvQ4KZvHV73vZtFks5xy/PsjkxeovkTJczni8X1CivFWRADXKacpPRN4ISYJD
         hFAaAP+xJqlxayZIfMN2/FgKtARmp9o1LwOxcC11fqTIrCoHl8nheZRFpH0GrZfqyLIz
         LUkqhjnlro+enCyYzuj2WOv9qmjDapzESnyt1eq+9ilWbgicRzwouRNs0zVf3OP/giEp
         8kPA==
X-Forwarded-Encrypted: i=1; AKwUvBzWa2/65oyP6iNAOIDtNp/wvY0y/lURTuaD5f8J1ZKNC/x7XGsZiL2bo+UsiUSM7N3qjCOnshM08A==@vger.kernel.org
X-Gm-Message-State: AFq9FYIo72jhkCQpH0wkvx1vdSEOeKZV8drs40FkU4oT3ylHWJxOoERr
	WOcVd6CEkVqhx5UdMFcChy06zPJr4qIvS4WA612pxs/tmvlqu0JtQGL7
X-Gm-Gg: AYBFou30wZcX7U97iqeM97nNpOgJCyEF5d1aICvbe7BaNUd+IAN0qkJN6j9hd5vRhg8
	rv1i9HLIA+1PseALkHAeHKL0mR9uNtnaMFFXhbjiDJ9xf0Brw62/ujuWSddpXtgKOKOY5SfP6gv
	7IihXdAViww1XdQnsixGoK/NfJOythD0MvGQbt05mhYWJNFseWyzObb1aWp+hSYCF+UV1oSZGf6
	vq/f0qxuXksTtmiP50DUNBX1BYpolwUg1U0yYelQjdojkHKvz2YVvSJWGocpgSd7935tPFPh4CY
	508lC7dZFBK9aG4qwbRlFO21HluN9knpK15we1pASeYnY9n0X61RgG/pympiEcTXw24VuaI/8db
	PluE5hN2x+9HWKoEA3VHbCjZMTmQjLpQms1JDl4BVmbQfvtASFAvojCWpQ3sIULrbfzxgDfg6FW
	NRmN9+t+faq/epdmUHVX0+vXni8QsqRSrseHYV0TzZkEmNuYZexXd6VT6rFRfye+lCB6Wr7+gRT
	ulBaGAHwxdHhUKlb8ylrU2rlOuEbSI+0ady89khtwZt/YJC/Q==
X-Received: by 2002:a17:902:ce10:b0:2e8:5202:aa8c with SMTP id d9443c01a7336-2ea43fbc008mr40821225ad.48.1792662094813;
        Thu, 22 Oct 2026 02:41:34 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:701f:d27a:ab05:82e0:7670:1951])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4356c1sm21483075ad.38.2026.10.22.02.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:41:34 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Subject: [PATCH v3 0/4] Fix PSCI on MSM8917 and MSM8937
Date: Thu, 22 Oct 2026 09:41:09 +0000
Message-Id: <20261022-psci-fix-v3-0-9ce2133c5659@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02Nyw6CMBBFf4V0bU0fUsCV/2FclHaAMfJIi42G8
 O+2GCPLOznnzEI8OARPztlCHAT0OA5xyENGTKeHFijauIlgQnHGJZ28Qdrgi5ZaGGaVUKrRJOK
 Tg3jeUtfbd/tnfQczJz8RHfp5dO/tV+CJ+2WLfzZwyqgFq0EUcNKSX9pe4+Noxp6kbBB7sdyJI
 ooyb1Re5xXUld6L67p+ADr8iXrrAAAA
X-Change-ID: 20261013-psci-fix-8a2c0d6266fa
To: Mark Rutland <mark.rutland@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Christian Loehle <christian.loehle@arm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Val Packett <val@packett.cool>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Alejandro Tafalla <atafalla@dnyon.com>, 
 Reza Kurniawan <imkyufie@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2

PSCI on Qualcomm MSM8917 and MSM8937 advertises support for OS-initiated
mode through PSCI_FEATURES, but rejects every PSCI_SET_SUSPEND_MODE call
with NOT_SUPPORTED. The cpuidle-psci-domain driver treats this as a
fatal error, so probe fails and the CPU PM domain topology is never
registered:

  psci-cpuidle-domain psci: probe with driver psci-cpuidle-domain failed
  with error -95

This series adds a "skip-suspend-mode-switch" property to the PSCI node.
When present, cpuidle-psci-domain does not call psci_set_osi_mode() and
continues with the topology it has already built.

Skipping the switch is expected to be safe on these platforms since it
matches the behavior of the downstream kernel, which manages the
cluster power level in addition to the CPU power level, just as Linux
does when OSI is supported.

Additionally, it also adds the property to the PSCI node for both
platforms. For MSM8917, additional change is added to fix the system
being unresponsive at idle.

---
Changes in v3:
- Swap ordering (patch #3 <-> patch #4)
- Link to v2: https://patch.msgid.link/20261018-psci-fix-v2-0-35f65b59eb9a@gmail.com

Changes in v2:
- Small phrase change in the property description
- Added property check in psci_1_0_init()
- Link to v1: https://patch.msgid.link/20261017-psci-fix-v1-0-dedae27e4a31@gmail.com

---
Alejandro Tafalla (2):
      dt-bindings: arm: psci: Add skip-suspend-mode-switch property
      cpuidle: psci: Allow skipping the suspend mode switch

Reza Kurniawan (2):
      arm64: dts: qcom: msm8917: Use a shallower cluster state to fix unresponsive idle
      arm64: dts: qcom: Skip suspend mode switch on MSM8917 and MSM8937

 Documentation/devicetree/bindings/arm/psci.yaml | 13 +++++++++++++
 arch/arm64/boot/dts/qcom/msm8917.dtsi           |  9 +++++----
 arch/arm64/boot/dts/qcom/msm8937.dtsi           |  1 +
 drivers/cpuidle/cpuidle-psci-domain.c           | 16 ++++++++++------
 drivers/firmware/psci/psci.c                    |  6 ++++--
 5 files changed, 33 insertions(+), 12 deletions(-)
---
base-commit: 9a482184d910775cf648863148944945b74e2815
change-id: 20261013-psci-fix-8a2c0d6266fa

Best regards,
--  
Reza Kurniawan <imkyufie@gmail.com>

