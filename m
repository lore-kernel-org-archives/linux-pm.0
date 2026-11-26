Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724561;
	b=0qCA92qvPTsTFRr83eCJvBydsBC4mEu0AGZTgbPS1aSWeKx0nOMjeHOxXeKtrIn0mkYn
	 /L7TS1B4WiNxeEYl1XfHYjVnARcEDKyQYRYrRi3JJ07dCIkbCh6v1VtXcCLyFgYsZpl6u
	 hSbt4CnFtPgQxTmrNe6oHr3ClyioiOcOgy+66VWbPqIeMT4OshQafZXfo+Cst/ZLC3VrY
	 zofQcJ0Lmi1mAcb3kCLDuDcRIYMh+UI2XZKbmJNLqGyCsqBS5EuC8hqFTfMSRSpPLlxvZ
	 dUL4UipfLeRRFfKOqgIghX172TWvqTyQ28McIwQfYksrvInt2+OQgKO6mp54msP1wOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eu/jciqpUTlRe4UepQQoT19Cl8pPa4jSIfjdhVO2wYA=;
	b=trMOqUbkOHDk5m2tZ1tclUwHCIokR+FZ5StJFShVzEYm/p4Sd3U1vIdrjPglNUwdL5Tc
	 YKFznisnmHgzZnPobW3/O2jbvA3uqpgAbekoG+d2HGPQZwhiIRrfWMvjcrb37vlBJPePS
	 NuQ0nmKKZmDNVpgtGG13H9+SBLD7xzilga4N8AN6NyWiME9Slf3a1Gtj/NBa+RUl3OHDa
	 CaF+2BHdy+C0kxrc/2/mv2Cg3XVnY1CXHJ2sBn7GOwQ3uBOuzrvAWibPcgYJ4FxHhVOkq
	 Q3/Ym5z8I594SZA+8ba6cQPOMKZ5mRlkFc+3Ao+mtKWCpDExUA2a+If74A4JaIMZ2MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R3KXAmT9;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69EE606A321
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 20:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C69EE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R3KXAmT9
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-38699cf08dfso9084124eec.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 12:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795724560; x=1796329360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eu/jciqpUTlRe4UepQQoT19Cl8pPa4jSIfjdhVO2wYA=;
        b=R3KXAmT9MsktSm5oNUEI4ygpv5v1XVS/vi9lc8iHNhY4ZI1ic5crzZvzIQfgCZMVjH
         SVH4oZoYzmUCLkiYFRpDtzHKUuYLa7KGYLlDsb81PguIWL2tXypudSIzDgdcREB6q75I
         ygHHGMS0ShlgT4gZglPyOfmTBGxx3wf5lqP5BZdIaPcMYeKTtOZmIbEknjZxKCXHIT98
         QvtnX8MPuZ4hM2LOI0m/V4D0IKphG6eYbZNxcp6a3HtizQTxzceuXktUkGcUuM6Qq0RE
         eTudZ7gq01uKpWKdMAskvMKT1CxDWBO0eTIyctI6cBjT1o0KJuHAD32g60ILy8UOhT3P
         TGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795724560; x=1796329360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eu/jciqpUTlRe4UepQQoT19Cl8pPa4jSIfjdhVO2wYA=;
        b=r7rq/eGan0LPFVkMWF403mysPQA5ILBQ6GU1fr26pLhQfd1Up1EOjKLv8EX11WEzLa
         zQVgxsPDGvWLII7Bk4w+net4FgF4JECxuy8/TC1omLSfC2lqdkbo48e0/vj1Th1LZWxi
         XLogIZlopW3QVjhKV0vu4um+niGD6YeMHajtbg9syM9NRw6DbNU0DTecJwXjMqJRXfzs
         zEVPZncmqnk/f1W4nRmXb0i3y/rQBjrpLwRb/lcuiS/rvaS2pjzhBr/yPAIv7ENJoNnz
         CGd9qr5padPKqVldCeGg9cSP2sP/Cb/JWzQKtE7CLKgfk9oSUWMdu8sNsMNbLRougrYf
         aToA==
X-Gm-Message-State: APuU4Z8TnnaAsOqOLACNf12xkTKNgQA2tb5Pq1xjLefUIHiBx0kvXp+X
	wO4ZevRhsgH0gy71vxDhkwbhoJY4XrZbLIwVEtyqto/ortNvVDc+tMf+
X-Gm-Gg: AZFdTZed5hKDygdRutr0fH1Cigv9REThsSoF+e0/ZbJXMgPean8yMoxmSNdK4/UFe3n
	r3lhIa0VdSHQB8LvijyZVFKJCgFTQBHT2mMEjyann6p1AfbYS4QMInL6orKxEkeU7YaBc9fG1hf
	lxIhaUEMXQbhxOYSP2faEUwrNihL35X8J+fmOsHEbymIxXgFPedC43YMyFtnHiL5swZB7wV40dK
	5voX6fHHSsIwP+tc4Ab9BFUb63f/9HKJB/W/VMbaCEKIt8jVz8QDRqBpELQDtK4NGWH5UJlLmDC
	mD2w5kfSFXDvHTBOPZwPH8nOLQYIVLGc9B/YDMKIYHgWg1DmkCxw2P1QdNbQKINv4LUKhZ30S4l
	YAZ7+aeCRdFS4F10C4u337IBVobd9PHppr/RDI9D4EnjTB/Bqw9lyzK0Tbdybz6I1eVVrBstx+V
	lfYB1D8ttoi1Tpk4V4WMVurP1vmaEo8TFVnxG0iwHsmbOWJ6iJ4qIEMCW3pyhpb3YyOagCiXWWx
	WEmHyjm77V0A6EsEshhgZeTCOLhhVhXoQ/34lIHIUFLrCbO58Pkaeyf/Aqsyxy/Ydjem21idKIc
	uexfXoCaGkYcSkmk9eLZeKv+LIV2kbusX0XiDdf1/yUwzCYGKOSjVokyByunIKY0i3tsbQ==
X-Received: by 2002:a05:693c:880e:20b0:386:b26b:d67a with SMTP id 5a478bee46e88-386b26be80fmr13019351eec.12.1795724559778;
        Thu, 26 Nov 2026 12:22:39 -0800 (PST)
Received: from mrprachoday.bbrouter ([2402:a00:402:9f97:e752:d178:849f:9d04])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm73987372eec.24.2026.11.26.12.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 12:22:39 -0800 (PST)
From: Prachoday Sutar <prachodaysutar7@gmail.com>
To: sre@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pali@kernel.org,
	afd@ti.com
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Prachoday Sutar <prachodaysutar7@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: power: supply: bq27xxx: Add BQ27Z558
Date: Fri, 27 Nov 2026 01:49:58 +0530
Message-ID: <20261126201959.28743-2-prachodaysutar7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126201959.28743-1-prachodaysutar7@gmail.com>
References: <20261126201959.28743-1-prachodaysutar7@gmail.com>
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

The TI BQ27Z558 is a single-cell fuel gauge documented in the same
Technical Reference Manual as the BQ27Z561-R2 (SLUUC54). It uses the
same standard command set and register layout as the BQ27Z561.

Add a compatible for the BQ27Z558 with "ti,bq27z561" as the fallback.

Signed-off-by: Prachoday Sutar <prachodaysutar7@gmail.com>
---
 .../bindings/power/supply/bq27xxx.yaml        | 72 ++++++++++---------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
index be0f1f729..28b04732e 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -18,40 +18,44 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - ti,bq27200
-      - ti,bq27210
-      - ti,bq27500 # deprecated, use revision specific property below
-      - ti,bq27510 # deprecated, use revision specific property below
-      - ti,bq27520 # deprecated, use revision specific property below
-      - ti,bq27500-1
-      - ti,bq27510g1
-      - ti,bq27510g2
-      - ti,bq27510g3
-      - ti,bq27520g1
-      - ti,bq27520g2
-      - ti,bq27520g3
-      - ti,bq27520g4
-      - ti,bq27521
-      - ti,bq27530
-      - ti,bq27531
-      - ti,bq27541
-      - ti,bq27542
-      - ti,bq27546
-      - ti,bq27742
-      - ti,bq27545
-      - ti,bq27411
-      - ti,bq27421
-      - ti,bq27425
-      - ti,bq27426
-      - ti,bq27441
-      - ti,bq27621
-      - ti,bq27z561
-      - ti,bq27z746
-      - ti,bq28z610
-      - ti,bq28z620
-      - ti,bq34z100
-      - ti,bq78z100
+    oneOf:
+      - enum:
+          - ti,bq27200
+          - ti,bq27210
+          - ti,bq27500 # deprecated, use revision specific property below
+          - ti,bq27510 # deprecated, use revision specific property below
+          - ti,bq27520 # deprecated, use revision specific property below
+          - ti,bq27500-1
+          - ti,bq27510g1
+          - ti,bq27510g2
+          - ti,bq27510g3
+          - ti,bq27520g1
+          - ti,bq27520g2
+          - ti,bq27520g3
+          - ti,bq27520g4
+          - ti,bq27521
+          - ti,bq27530
+          - ti,bq27531
+          - ti,bq27541
+          - ti,bq27542
+          - ti,bq27546
+          - ti,bq27742
+          - ti,bq27545
+          - ti,bq27411
+          - ti,bq27421
+          - ti,bq27425
+          - ti,bq27426
+          - ti,bq27441
+          - ti,bq27621
+          - ti,bq27z561
+          - ti,bq27z746
+          - ti,bq28z610
+          - ti,bq28z620
+          - ti,bq34z100
+          - ti,bq78z100
+      - items:
+          - const: ti,bq27z558
+          - const: ti,bq27z561
 
   reg:
     maxItems: 1
-- 
2.53.0

