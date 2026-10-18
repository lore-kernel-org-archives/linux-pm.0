Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1E1419303
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 04:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792297837; cv=none; b=cjejf9NUPlRIgHhw8WIexDof74SNvGBmWQIISx05lK3+fRaiWljCxpk7/C5+XHQTwL4u+1Idb3Z9uFirdGzE9brtjwp1Z6l2ug2Eqs7gedVZDjiMs50Q8nJFFDhmt+IdLlZbb6yHZOvuLSWf+83rkcMf2mnifvu5YwdGJJKqF6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792297837; c=relaxed/simple;
	bh=BGOJLVXVccbwwnFWY84JCzL1yNcyYfyrD1jQgZCkXjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qDUdmh37jnr9GmJRpVYCKPXdQm0RyKAyqRYQEUYjhimU7aP83XcuasxAhC8AmCcgtvRaFac8fCZZvsu05mMXM3o2h3mmrvoXJS1AaW53mCsYvPlipEz2qef3DVc8MOuHbF+KQTb9EasUy8hqxeffiYsalCJnpNhB78s3EJENBYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCMbhNkG; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCMbhNkG"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso646478a91.2
        for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 21:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792297831; x=1792902631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nRLqlklMHo9ZCSuWpQYdrWIL15ypvdyDW0jPICD6Gas=;
        b=gCMbhNkGSsOdH9aYXpH/1IxtdqUaBox/YbQOaKqvTAHpI/tXkOTYO7fEBH31xyAxBJ
         RbjWs+ZovgL3sNqTm5dka6YGtCPRbBjPa19FurcZEk5jkDgmzypapmyu/jPrSk9XQH2X
         PeDR8/fgA/BWBOR5z9i9ZC/h8sqNIM3Q0iccFvHIuFPaSTqjfPt/jVb+7mWayaFN8sJQ
         7ggHKmlNR5cTnKJthFPMBx0kSkJ984JJ/11nlX+sp39KF3/ob9HKhYyNVIhx0iMx7g30
         2AkFUGrp/P1PlIKpxnsjUhZd3RF/nkuIAfqjaMh/7rKedTcD7RQF0kZeoz0or9UislhQ
         RE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792297831; x=1792902631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nRLqlklMHo9ZCSuWpQYdrWIL15ypvdyDW0jPICD6Gas=;
        b=sIRP4DkSZT8ZmsOMJmhiWG3FHKb7Wr8lE9iMwyQUMcjZcYypV6diCBYbuCZ9XW9J+6
         4JEcuLwyxhrJ2P87ZiF6H6VcqN3E3hFZQiG2BeqSfJ9WHvdUco4lv6AtDslYs9xrRzoi
         MaZTZOyakXpubsOTAxLlfPGTGxFwvtW9mCx9z4Y0n70CpW+DFtSty9SUu5NDRrvkEYgs
         vFhdgSxy4f5xdPhKQsDKm4x5iJzFi/ZWAnI014qVlkD+LuZWLjxXL0BaTwWER3Y0SG4X
         moDDV5NNwId+0R1ouNoqDrZjfjXdwEw7Vkg0guXTc19IJz+Nku+niYQYcw4hXLZ5v8vr
         Zqog==
X-Forwarded-Encrypted: i=1; AKwUvByqaz83PveRcvJL3lP4dZul2JyVsOMMsj5HI0zje0Ts8zKmggdAMVRx6CwxA44k6QwjJBMeoEwjDg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKByFaDi/yWr2qCddFAlweuiaA2g4nhLNKzesPncGGmpTYqlcK8
	l/NNKJpb18MLDrE0mNihvgIdClzjliqpbvBsZGgEhV4Ju1pl2OcAWpQp
X-Gm-Gg: AYBFou1TEQ5SCl+DtA2JgwmRCtUdbdKj1s+H8Yyt5i6URU+e6s2NlYdJMA2nQK/tnJZ
	4A69Aj05vm03AzhPPX84jAApVAUzy229BZq7FmkQ9k0tuH8HpSFIbQ3j3jzRPIYpxaCz0X/N1bB
	Gs/DKRIdtG+PIRroxULtPF1J2ENrpH7DzOLJJrSpWcuPxWkbiyCi5npCNys7tyUgLI/usTo4NYa
	EXQyQgQij8zQ6jK2957188TQ+dtnMBIoScUYeiyYVaWOSsAt0ko0/AX3ChGsC5SqCYnUP1I/QEH
	WCihx+6gsn0gqOplaMqz6mOHhtjg/ayOnnifxdo5rQXCoQmcOllsCt8Yd4MvGQkSukAomaphzex
	CRSU9RLPaelV/O8PTfCDpqLqvjY56rXb0r9TW/7RtnKnDHNTA3IQ9otRccCOqDTrEzoXn1jvOSG
	qc8gV3pISHWP4woRDeV2yp3uXsMnnv0bdvD3ryXqZDbhd3ui6RDPnMwHCRmP2lzhQ=
X-Received: by 2002:a17:90b:5870:b0:3a4:b0a1:c7ed with SMTP id 98e67ed59e1d1-3aceefc0547mr3380131a91.13.1792297830714;
        Sat, 17 Oct 2026 21:30:30 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:7618:4e1c:8841:a092:12c2:47d7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc9e47588sm5885369a91.1.2026.10.17.21.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:30:30 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Sun, 18 Oct 2026 04:29:23 +0000
Subject: [PATCH v2 3/4] arm64: dts: qcom: Skip suspend mode switch on
 MSM8917 and MSM8937
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-psci-fix-v2-3-35f65b59eb9a@gmail.com>
References: <20261018-psci-fix-v2-0-35f65b59eb9a@gmail.com>
In-Reply-To: <20261018-psci-fix-v2-0-35f65b59eb9a@gmail.com>
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

