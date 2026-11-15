Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702728;
	b=UtyRWxkUC68Ndtl0FMbz403pbsdg1v1d0Gjwue/HgQkvcOJTjnzyWG0vz/kjqTklRN9b
	 5FZjI5dRf+bSMEAfjZCo1Q01AqYuqKDYTCYjKzxkeE7K/8viNyqJYQN3s6lzcPo8Mckt9
	 ZKTXAbcs0AhNJXxdSYWyzpa5hAp7fktZ5NLaXpW8qBMuRi6j/5PExNZhAgBHU51RmmsQk
	 nUt0LrPEhV9Fz6WTjCTXYG6CV4VbbmNL6p2CB7q1vAR1kxb6I9P7WmxTi4UHbPdVSz2Cr
	 82CnyVnNyNroxrVB2kKfwyP3A0J9clNWfyhv2zf/nWouJyTx9P43ogfYTjyGUeNwCVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GVBi/BtHwXrMR59M0e8R1++dDkkmRGqCyH13CxDS4UI=;
	b=hEAPtzf3E06l4CxJgyO0mhYehosmhi5Co99N2aBrvEf5UH+6d0zuf8FaRekgWfs8Woco
	 r5/6kPWlukWr/tVngwmOLp2WrAwUNc4HlztYKPm1T+C5hcSM3AeryvlQFYZuYwXpmmHsc
	 TEUNHNNkT0TKkNEJHq1knkObkTFVMAj+T1m6xpyPxslUDbj1Cdhzlb525lXwZye4tXQVG
	 Ff8PItsXzMiahgTfVRH6965n36qnlOjT8iVee6F+PDesIdjaWsi1jvIbViMak73fN9IoD
	 ZcjDlQFxX9eEvu4/q0s5iclXBL/HtsM9Ta7AP8TQoURVQO/l79bHkjQyIO9odfUQxcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F5NY6n4p;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAFB606A334
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 00:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DAFB606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F5NY6n4p
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c50a2efbe1dso370570766b.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 16:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794702726; x=1795307526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GVBi/BtHwXrMR59M0e8R1++dDkkmRGqCyH13CxDS4UI=;
        b=F5NY6n4pA3zJoPJKQRZ8qrnhPh4iiSBXipyS7ZZeZZk1Jhgi5od6w1ljHwxc4TFJP6
         N4RH5tiGrt0q8MU3f86r2HBDR9A6Xb9OViFPa5swY1F7qYvJquKfK1j+NbvGY5tQHQPZ
         Qj+is9aboixvTiNwW4IEIIq7cGKLrD1Xs3/n7mmKxauASaPGQFt3J5v6yzVGHvXvISEI
         n+KcHLw2WdJSS5FneYfKXWFzsDyGgY1I+yGZBgmkzshmKDFGEu/vmKNWG470+G6EE5Cu
         RIK8CCuHbKZLfU1KmA/VpeWOKvFvZAfEzS+jibYRyTkbRMqMKs9sIZ1s9KIcRGVogHH/
         5obQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794702726; x=1795307526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GVBi/BtHwXrMR59M0e8R1++dDkkmRGqCyH13CxDS4UI=;
        b=1EDfkDnrFyFuRDIdbtNUXAy1MTWlbgAZg3nZ/zyJCG+ZjcZdZWuL6hDoDmE2HDs331
         8A3wH+JsztKVeTrk5EHHyaFqdsCx2yCydy01x3C3wSCF/zifKNfYxVGYpsFgDxWBg4SM
         2qmUjbUMnP0k+VdH9qZwhi5xD+1MZiLvbB7/vbt6Znnm95DhPvxY5PIiio2weooe2fcx
         aXv/olgNaWLdx4ga2kQ4xoJo78hQOchtOZlLENA2JVXXe+KeG+GaGt/ee1Gc9H8+g7el
         hB4E9pTBr9cjRpiUfFA5XWvUCAQTWei2fiI+zigrRATOhtq0qoelWnlCHK5zmOLg5uJA
         kt8w==
X-Forwarded-Encrypted: i=1; AL+hErHHUwJwpazpUzy/uiUhULMWe60wBCP3Zg7Y++kZ2Pfgh2WKXswGRUyMAKp+3uXIjDLQXGULGBgEvQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z85fBFIxwY2b3QmwaxxTKk6MkIJEi0xBz/cloAxAYMt6nP+oQyF
	uejIe8C4bCcnYYm7zXwcA9EBFW2MvgtOuMUO4picKfF26wkxpb+utuo=
X-Gm-Gg: AYBFou24uP3yu6Mysr/RPPAZ/JxAE7dfxH5bA1Xq//P5Sp64VFBMJIWvdFTrr5XeR6l
	OADjakKO3XrCs6JbKst+s7p9lAf7jhoOYwV7swDmoJBvyKbopZevKaFyOwPVzI+EB2LU63yl07D
	1cMePKfZFagEltDVqL5ppNeii5rFQ+n12EmfkNZWj4MgfyY+OqKNY3d8SV07RvAtyF+NqZRZ3Ae
	I979Wd+tUqPOyUWMu1PkF3xISIoiHAbAnAU6M2/tCjVdD1IBsR31K8SpvtsCMf4L4zuACvSYUSH
	pb1PVeykRj5rQVXSA1ZG3eBTpb4OU6fb3M0ZvTs7XLnQJYYhmLXjBGqtpalVIFO1UHVM9909Wnp
	wsUcmeHjuUyfa1gymcdQd1bNnmCyKWZFfNcx25FLtwahh+Vrv+2F82sgOpp2k7d/yMnlSBf8fLW
	xksJob5mVj98O4afh3aUptDcvOJQIRb4QtIM60LWJVcys/7jd/H/S28vd+dJoDFS8XLbxfb/ByZ
	6+F0HhdGKyM7Wf3/kTsHrJbFGiCoJErGMwGKf4MzifDmtTsDgC2y1HMNYFE5F5oFBYEAvbI5D9j
	hvce09DnIZi5AYe+zsuIALynXItpuRncVNTt+cvTgG6yADdaLqVXEm/6f/yfbko97y0bAxqUUzG
	07MYd9WJk5MXgzp6WptZaNz17I8nSXTWYkjs=
X-Received: by 2002:a17:907:843:b0:c2b:4142:2db1 with SMTP id a640c23a62f3a-c5096387a3dmr518400366b.40.1794702725988;
        Sat, 14 Nov 2026 16:32:05 -0800 (PST)
Received: from sohrab-omarchy.taila18b31.ts.net (2a02-a44e-4ae7-1-c0e-6d5a-8ae2-915.fixed6.kpn.net. [2a02:a44e:4ae7:1:c0e:6d5a:8ae2:915])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095a5c4b7sm260695166b.1.2026.11.14.16.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 16:32:04 -0800 (PST)
From: Majid Hajiheidari <majidhhdri@gmail.com>
To: andersson@kernel.org,
	konradybcio@kernel.org
Cc: rafael@kernel.org,
	viresh.kumar@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	abelvesa@kernel.org,
	mani@kernel.org,
	admin@mswin.me,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM6125 compatible
Date: Sun, 15 Nov 2026 01:31:56 +0100
Message-ID: <20261115003158.391171-2-majidhhdri@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115003158.391171-1-majidhhdri@gmail.com>
References: <20261115003158.391171-1-majidhhdri@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the cpufreq-hw (OSM) block on SM6125. Like SM6115 it has two
frequency domains with one register region each, so add it to both the
compatible list and the two-region constraint.

Signed-off-by: Majid Hajiheidari <majidhhdri@gmail.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 98eb36bff..8dfe77d08 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -28,6 +28,7 @@ properties:
               - qcom,sdm670-cpufreq-hw
               - qcom,sdm845-cpufreq-hw
               - qcom,sm6115-cpufreq-hw
+              - qcom,sm6125-cpufreq-hw
               - qcom,sm6350-cpufreq-hw
               - qcom,sm8150-cpufreq-hw
           - const: qcom,cpufreq-hw
@@ -146,6 +147,7 @@ allOf:
               - qcom,sdm845-cpufreq-hw
               - qcom,sm4450-cpufreq-epss
               - qcom,sm6115-cpufreq-hw
+              - qcom,sm6125-cpufreq-hw
               - qcom,sm6350-cpufreq-hw
               - qcom,sm6375-cpufreq-epss
     then:
-- 
2.56.1

