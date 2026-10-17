Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B50A3C09EF
	for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255378; cv=none; b=m7PWh56p2u0GkAhhO0Ix41H5x2XRK7OOF5IVN8xRXYctl9MQnFD4MgPe398iFPMteD7DXySL/gwhuC+OLXZZWZ9ByIO9wq1jbBOzjD3znEQXiiVgD7osX70qwnP39i57HMOmIRwsPsNqElujkJO8LmooH7R/705U/7zZ1jdezmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255378; c=relaxed/simple;
	bh=BGOJLVXVccbwwnFWY84JCzL1yNcyYfyrD1jQgZCkXjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H05mj3irUKPTfFf4hApQo7QgW1FyDCogNVdhdOfUsX4+AduriHiMBCIIR+pPUfdsM62Lce7eHTTnvN9KywAoGJFIPn/97zCi30zNRBdlGYAwfAwtXUxNr4sMsrwa0xkxrskgdBsbD8NWs4C6l91kDk7g5w1GKTEiDXTxzcI8zjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atob6bsV; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atob6bsV"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab98332238so666919a91.3
        for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255376; x=1792860176; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nRLqlklMHo9ZCSuWpQYdrWIL15ypvdyDW0jPICD6Gas=;
        b=atob6bsVJ1rIh2QWg23PqJPvd4vJ2U21qsAJQBBZd8RLkEGaW1YaWR9nP06unqEJ7P
         EDxqnAw+P5HBuQmEVCO3sMsMM2GSWAVRNgZe7GiIyIVaSFmoATFqPbWYq2N/euFDGWB+
         atUC/FLh5Pfx9VNvlvrxR3ti8Xbrl7vRvJKufAOF/S/b5xYlLgY87L6T1h5gjGhPAwFI
         Mg+OX5KYUHuTq+AB1vu6SszAWKeESxGwpi3KPgUSbqVTh/O2PAR4il2oLMf3jaK2ufQ8
         aJg2a3lYgrz/Uld/j03oV808sw9xzmn8oY7Mb1ZW+ALN2QZ4tflTKBrd408Jyhvq/kTn
         v8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255376; x=1792860176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nRLqlklMHo9ZCSuWpQYdrWIL15ypvdyDW0jPICD6Gas=;
        b=wmUNkNB9q8FwCNYjM+8Juv1uJlWspktrQjahospvQYBTJNgiCVUZsi4gtcYAUQn81Q
         QtwRSWmE6WP5Ebpa7+fAeyPcKHApnIo9xHLgsumYE8KULjgAjEOo4fGKmz6sidhJt5dz
         LuaaoU/gW/SK83f+H7SrceepzwYDIFrhprq5Q1DXfVmHDv3i36uuqbudON1hSX0ltgbd
         2cwQ6ExSdbRzGetM4JweyJu+0s1bj2ziM1AQPyrjTCcREjGDSvcNiIC3ry6DvsP1+w0p
         U1fXGV89MOidUxx66hAErPIKABxriPS1I0N5dExoTxAwydxq/3ddBdELDbf+pYNBJlWA
         CSPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRAODrF5+NnP5mZmBv5MFQvnj5Ue5wJTchoZRaDRJLPssuTFRVnzO1dxGvkpYpx43UVMBazzP75g==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9K0zi9Yhsmo27hu1HqfNi9h6OAV1NPHnfIf3u+anPS7YgRhPY
	jYT9En+XQDXfGWwxKvJ+jE3NFLSoFeHbNYh99id6sQR1LiMGO49ymd3G
X-Gm-Gg: AYBFou1xpDzNUwBEMGTcCVHlRb0jAFBAEkd1T2JIyK58qcvd6PoLDt4apNWM2SRr9xb
	RasbZrCH8iwgYWmwkUh1pvqvCzf1bMPHZjKkGPjefCwdWodfxAqWZ9WHxUwgKhtA1FVHPuTrMtO
	PS0lj6P+F8HpMG4t6R27714NucVpu7vtrwFS86tSyorotqYYX4rEj2yHCboiirbE5XDSvm0gn6g
	/GA+WTVVkvKOiZRVwjsZ42/zHe0RTvbfIwuK+6vTgbjyGS6XWnRXRHAlIKubHQCvRNq+Bfx8t02
	uBA0CK0dkKnSDRLg/GSe/D9v8Ha50Oe9uMeOZ8YdIJNaCV4adIkUleYB9pcwFSgwGEWpgQpb77S
	ZbLvJOFrVXkM6kLdqElMLEGKOdwKwJXCzVtDmtaNImIVPhhXP/Gx9kjKm/iZosutdzuC/Zs5Gej
	WEauhCBPsjFYuxh1Ov2h9BnGiM1uIbOL3FvdFn0eGAhJ/KinWObSWA7SZjEWh4ug==
X-Received: by 2002:a17:90a:fc48:b0:3aa:f875:3385 with SMTP id 98e67ed59e1d1-3acef14544bmr3161802a91.26.1792255376492;
        Sat, 17 Oct 2026 09:42:56 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:7618:4e1c:2cb7:b2e6:ffb7:d23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94798212sm13816164a91.14.2026.10.17.09.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:42:55 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Sat, 17 Oct 2026 23:41:25 +0700
Subject: [PATCH 3/4] arm64: dts: qcom: Skip suspend mode switch on MSM8917
 and MSM8937
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-psci-fix-v1-3-dedae27e4a31@gmail.com>
References: <20261017-psci-fix-v1-0-dedae27e4a31@gmail.com>
In-Reply-To: <20261017-psci-fix-v1-0-dedae27e4a31@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Christian Loehle <christian.loehle@arm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Reza Kurniawan <imkyufie@gmail.com>
X-Mailer: b4 0.15.2

The PSCI firmware on Qualcomm MSM8917 and MSM8937 reports to support
OS-initiated suspend mode but rejects call to PSCI_SET_SUSPEND_MODE with
NOT_SUPPORTED. psci_set_osi_mode() then fails with -EOPNOTSUPP and
probe of psci-cpuidle-domain is aborted:

  psci-cpuidle-domain psci: probe with driver psci-cpuidle-domain failed
  with error -95

Skip the mode switch on these platforms and continue with the topology
that was already built.

This is expected to be safe since it matches the downstream kernel
behavior, which manages the cluster power level in addition to the CPU
power level, just like Linux does when OSI is supported.

Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8917.dtsi | 1 +
 arch/arm64/boot/dts/qcom/msm8937.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8917.dtsi b/arch/arm64/boot/dts/qcom/msm8917.dtsi
index a2907f8a63..f0771187d0 100644
--- a/arch/arm64/boot/dts/qcom/msm8917.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8917.dtsi
@@ -182,6 +182,7 @@ pmu {
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+		skip-suspend-mode-switch;
 
 		cluster_pd: power-domain-cluster {
 			#power-domain-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/msm8937.dtsi b/arch/arm64/boot/dts/qcom/msm8937.dtsi
index 7de6447de4..a66a544f30 100644
--- a/arch/arm64/boot/dts/qcom/msm8937.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8937.dtsi
@@ -311,6 +311,7 @@ pmu {
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+		skip-suspend-mode-switch;
 	};
 
 	rpm: remoteproc {

-- 
2.55.0

