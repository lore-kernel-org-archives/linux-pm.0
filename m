Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB52B3BE16E
	for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255372; cv=none; b=bXjl4m1Bf/Ocsbi6mvyNIqbXdBPsm4klDtT1M7m0HMYjilJe2apwz1GwT7Z9iZIV3Uo9kTa93Ly9Zd4qOSzTVmjOnM5seZqSfVaU67fQK+3pv0H1ON9K7f7YwficLRL2TXUCc0JR3Hw4r/lIJLa4wn1aXbRSDh19rYssUovrqsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255372; c=relaxed/simple;
	bh=rTrbWI5rSQm+EpHypyvlpEvi/M8L4lp40c78faRU1Nk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sM4JYYHToMGZXMl8w63Ys4YCme5P0cNxRFfLeg69TKKbLPKceW9gsJiF86fMJZqXRodbIhDxwf7VTLzI4eb9/sFozFjNDGQOlJrVuUBZVV0m93abU1Ilm+oigzv1p2PE+5PJLoZpxjZHwePwUD8hKj05iCh5Psv/hAHIDNRyQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdeQwKrN; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdeQwKrN"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so794464a91.1
        for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255370; x=1792860170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F4xibtJE0TG41iQco+r4uLl7fC1ynCkxCGcMxo66dpc=;
        b=fdeQwKrNa425zVk/tXc3j2vnw41qOSJdCJO+s9FhhOVdI4xhIl7wTK83GJHkHpQUJv
         3Lzdh1vudZxtkq+Exn+fhCOMSYV4IdPCijE/RIiYCaxYvB7VUt186uD1TEHDDNvoxvOj
         oAKjhmAbBMA78lHzT12gAmZGqFZTEXmqvSxnMBc+/wnAEELjXAIAy7fSf4wGtBsGdPPw
         /vazXjFtgPzSsMB0JxIEoYHkLhaOTtucIUd1a8387cVx08/bk0DpAY5o9KktypIIr/ZK
         rqxld+xBLzFE/FLujBTAxHoEU6tH6ruTU4QUNlWhAIao9tdec0d7HH+MKAsQd8mqxbX3
         Gdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255370; x=1792860170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F4xibtJE0TG41iQco+r4uLl7fC1ynCkxCGcMxo66dpc=;
        b=WGfCYTB+mRjIAV0SiwiwpBJ/iaJn9OOn3F1C+OSxW2tpEov7Wpb3y0UEJpL39+BWnB
         YQ/fowWUQ06AcF/M7Ck1y18xxDIwv8YdsqrSbhxADsqzXZCReHhz3yjkHxq8pvBDJf7J
         wKJ44NC1qwZ2XVs1axOT2QPHPTe4J6yVgErtF5dFConyW7GWpllqRWzx4kysrf2QyIC5
         +VUNS6xUceEZlZq+bggR/JisMTs6KFhB1H4jmUBX8s70HrkcfvVcfO1+SYIT9JhmUQOS
         Z1a5kNY7fxz9H7jE4f8FzpzlkQdvSknM1P/rc3i0cImVxpoP+Bd1FQ8eDJzgOkrvYHen
         LH5g==
X-Forwarded-Encrypted: i=1; AKwUvBxe3tHNChNrz5K/cuCjH4l2Xnzqu0ZNw+1VT8EMzQZ+uVoUGLZNY5Ng4Z95aWPY3hOb8v8ADnYxiQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKVS7VdGtOcqCAXC3W/ElDZwWtHObb/yiqNrd+fquYEGnsVPAjA
	jLpNFGH7x8/fCO4oMOXWnv0GZai+1BpgLngb7MSxtxgPkNDAFugN7jFb
X-Gm-Gg: AYBFou1I2kk41u+x9NQkGLeS/MY0I0n5qLZXPbsV7uxOFUAbatcHbEyJfkb4z/1ewV4
	6V30jgxw1mQqFy2xg7aIB+qhWREozgldsriAAtf/4H2tPoa86V6tkOBJpuCWbgNrgIsdQnR/tBB
	hOuZi2GhdK3XsSHyQqu68Ly3SP2dlF66nxTGiOUakJPR3qVOC1ft9WF3uTSWZBkLQ944YRLhr3n
	4slMhsP6YXw/BcWncrBCp/b///eQyh1d/mw6nMwStEdRJ/0RtseY5DoiG9GJUQe2azY0d25Fcqb
	UiqCvdmsTLYI2px/2N732pb0cg8ywyx1fdeolzRpQK1MzZiAum2yi/bnSzg+1Rkc9Uzww6Uv7If
	GY/dgo2j52ybLHNqu7yN7+/WNCf+sRseXY2W+XyJux61XDQHtMl+eVLBW+WmMibl11oYzcJ2kBV
	9KbKjWXmiZfGwP9g2mEKHeRFdwpNz1+if3FrVIP/+X34u0EHv909u1pI/cIaydHA==
X-Received: by 2002:a17:90b:582d:b0:3a8:5d1f:59ad with SMTP id 98e67ed59e1d1-3acef14c8femr2733506a91.43.1792255369994;
        Sat, 17 Oct 2026 09:42:49 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:7618:4e1c:2cb7:b2e6:ffb7:d23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94798212sm13816164a91.14.2026.10.17.09.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:42:49 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Sat, 17 Oct 2026 23:41:24 +0700
Subject: [PATCH 2/4] cpuidle: psci: Allow skipping the suspend mode switch
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-psci-fix-v1-2-dedae27e4a31@gmail.com>
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
 the property]
Co-developed-by: Reza Kurniawan <imkyufie@gmail.com>
Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

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

-- 
2.55.0

