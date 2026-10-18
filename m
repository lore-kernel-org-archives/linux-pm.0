Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF1C361965
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 04:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792297827; cv=none; b=rNnrp8O85U+r/jRhvGgbfdmPRVY8ssWXo5myfDygdP5bQDMJ5OUZchVLgikyT26q6bvJkXCbz4v2OgqPtvyCTq/Ec2gTEbnNbnA3W8YVznx6s7J8xD2/C7vGIdHpQ0ncs+/v99W61p6etSLz8F1x8yRVoC4KOscxKF5e21ngoO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792297827; c=relaxed/simple;
	bh=f32Hhiuii8crj3wkcrN0uj33W/95RNcmO/iEDVyPKrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rDApVmVqlVgCo9M+5fo7Ws+JnbgTHIXZQK1Tmvf9hLdEIycjRYSQM4Vvyy2SCBO1HfApPgjIbLixQkbne8TmjcOf6+ARGdueyAUANn30i0QR1iOFVEao5rtnz6qO6E8tsbmKcPAfJYXgo7Jomy4wvBm7nCI3EUs6HtLm02XydFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHTkwiFD; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHTkwiFD"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3a706146559so893255a91.2
        for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 21:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792297821; x=1792902621; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zFr33fa9IIxS8M76ReU+A/YWrKsr2vhDOnZ4Db/Fk5U=;
        b=kHTkwiFDFamsYyDMxF4mKjPRz7QdzWGlIlEukNwl0WpwqG1zL4U2WYyVNJzKO7b8oH
         V1LnrMbJ3Sog4M6NgvXhlTH3nSvl/rV7QM9iRgxbKJMQcwY41Z/9NabIoK1WpaqnnpVz
         o4qvdEofzZZpXI1uoiAhOFVltBZmZ2rKNWj+QqJKDLjbTsmJdpnqHO3vM0Lg4IQHLZ6g
         7wCU6KmWfnH9Rf6EVbdG9iCvkE6WGFC+Djw5z6lRlRdPSF29sMtdgu5UgKW9tuhh7gST
         IdsmErWsuD18oUm6jfQJmtiBQuE8XizGqAvMdGn2OdVOhUaH5RQc7xn42z53HGZfJ87g
         xA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792297821; x=1792902621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zFr33fa9IIxS8M76ReU+A/YWrKsr2vhDOnZ4Db/Fk5U=;
        b=SURreeXZH9krWs25cSRDJxO7f0L7clqiPiuykmImGqq7BsyOholiW0S67MSemhTSNt
         CbsdiupG8spj/ZZfVQFRLniXHtDwNjb6o+nwt4vt3ilVy7SvGYrx4b3+ihYpcz+2UXjU
         RqrtryodoGO5Ra8TC6xViJelimtutmmrsHdKdzT6Ql/V+C6hFiFMbRmLo8Yp/Xko7HgC
         WhHN9879Rmoz001eOCIN0afTRF6/7gYWkNxYT3uNhZA2HeGbtS8VHJrBzW1SMdIfboRi
         bkhvaNjkyWgLQrolBbD1lj2NO8QsvDif4aiFvNSzEVofNfEFZk6mdCwXkpJFmLE2szmV
         ezxA==
X-Forwarded-Encrypted: i=1; AKwUvBwwcd6Wb3c9n21cr8ysBenDvsBdssLeE2xEWSTbXe0Tu8fJaocgke2cpIQlmCRWGEMeLsHBoMql8A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ55tUSQrQbsIIPFjjp9ptKYB6C4VLkqd5zPkv2pG43oi/BOZti
	kxX1Fv9muQ5sMRPt1Uu0kGjEVobp/w3wuQlpXQheqUjOI0NHLjL1gjQK
X-Gm-Gg: AYBFou2KS/gq1ug9BsNY9g4tBq9Oe3XkG8y02eBA0/MkOETYm4uj2DXI3VErgGFnRb/
	p0b3B6zNtaQ3hkQ5GwBN7Gc6lKL2Jw5pi8BEkxVkv6ANNtZ89zTQRBqSwpSs6hM5XeMCGo2UbSB
	r7mHj/vHQWED+pypyvs/faApluMBNDiOsUQQFFO+QIejwznNvb/VOzQ8op927LYG7hUu+tZxCJJ
	+CqKXsDGbvvC5YWQH/fkdwvT7hSz2/VmHyEh54Q8R6Oqdrn/Vw/jG6mLATZmOtSd9JGR1FQqp0R
	SfJwrDLY2ok6wVnViOW00w9ceqaShFzJZT5b/n6TIRLJnO+9/smRAkpvPNtcXpiPorSmGtN1s7g
	a0xOD2hRyxs4qZB+kfd+LZ93tNirYL6JexaW+mDXOlRPSZ1kiSndeP+aFkC7OhNI2U4uQY62s8k
	fTWpmNyH5h0OfF0VyvRfx+KUhS7I2j3a3wLsh41YeqT7jKKOe1wfkKMmBI3sPFlMI=
X-Received: by 2002:a17:90b:2646:b0:3ac:9d14:fe9f with SMTP id 98e67ed59e1d1-3acef29e804mr3158765a91.31.1792297820655;
        Sat, 17 Oct 2026 21:30:20 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:7618:4e1c:8841:a092:12c2:47d7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc9e47588sm5885369a91.1.2026.10.17.21.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:30:18 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Sun, 18 Oct 2026 04:29:22 +0000
Subject: [PATCH v2 2/4] cpuidle: psci: Allow skipping the suspend mode
 switch
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-psci-fix-v2-2-35f65b59eb9a@gmail.com>
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
 linux-arm-msm@vger.kernel.org, Alejandro Tafalla <atafalla@dnyon.com>, 
 Reza Kurniawan <imkyufie@gmail.com>
X-Mailer: b4 0.15.2

From: Alejandro Tafalla <atafalla@dnyon.com>

On some SoCs (e.g. Qualcomm MSM8917 and MSM8937), PSCI reports that OSI
mode is supported but rejects any PSCI_SET_SUSPEND_MODE call with
NOT_SUPPORTED. psci_set_osi_mode() then fails with -EOPNOTSUPP and the
probe is aborted:

  psci-cpuidle-domain psci: probe with driver psci-cpuidle-domain failed
  with error -95

Add support for the "skip-suspend-mode-switch" property. When present,
do not call psci_set_osi_mode() and continue with the topology that was
already built.

Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
[Reza Kurniawan: split out the patch, added log message for skip case, renamed
 the property, added property check at PSCI initialization]
Co-developed-by: Reza Kurniawan <imkyufie@gmail.com>
Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 16 ++++++++++------
 drivers/firmware/psci/psci.c          |  6 ++++--
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index 5722365b94..cc9f14769b 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -159,13 +159,17 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 	if (ret)
 		goto remove_pd;
 
-	/* let's try to enable OSI. */
-	ret = psci_set_osi_mode(use_osi);
-	if (ret)
-		goto remove_pd;
+	if (of_property_read_bool(np, "skip-suspend-mode-switch")) {
+		pr_info("Initialized CPU PM domain topology, keeping firmware-set mode\n");
+	} else {
+		ret = psci_set_osi_mode(use_osi);
+		if (ret)
+			goto remove_pd;
+
+		pr_info("Initialized CPU PM domain topology using %s mode\n",
+			use_osi ? "OSI" : "PC");
+	}
 
-	pr_info("Initialized CPU PM domain topology using %s mode\n",
-		use_osi ? "OSI" : "PC");
 	return 0;
 
 remove_pd:
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index e73bae6cb2..3226af6d89 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -791,8 +791,10 @@ static int __init psci_1_0_init(const struct device_node *np)
 	if (psci_has_osi_support()) {
 		pr_info("OSI mode supported.\n");
 
-		/* Default to PC mode. */
-		psci_set_osi_mode(false);
+		if (!of_property_read_bool(np, "skip-suspend-mode-switch")) {
+			/* Default to PC mode. */
+			psci_set_osi_mode(false);
+		}
 	}
 
 	return 0;

-- 
2.55.0

